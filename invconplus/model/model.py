import copy
import json
import logging
import math
import traceback
import multiprocessing 
from itertools import repeat

from typing import List, Any, Dict, Union
from dataclasses import dataclass, asdict, field
from json import dumps
import re 
import invconplus.model.keycalculator as calculator
from enum import Enum 

GLOBAL_INNER_KEYS = list()

UINT =  0
INT = 1
BYTE = 2
BYTES = 3
STRING = 4
ADDRESS = 5
BOOL = 6
CONTRACT = 7
UNKNOWN = 8

types_desc =  dict()

from multiprocessing import Pool
def f(variable, slot, value, guess_key):
    try:
        return variable.tryImplyAndSet(slot, value, guess_key)
    except:
        return False 


class TypeParser:
    @classmethod
    def parse(cls, varType):
        varType = varType.replace("t_", "")
        try:
            if re.match("enum.*", varType):
                return UINT 
            elif re.match("uint[0-9]+", varType):
                return UINT 
            elif re.match("int[0-9]+", varType):
                return INT 
            elif re.match("byte[0-9]+", varType):
                return BYTE
            elif re.match("bytes[0-9]*", varType):
                return BYTES 
            elif re.match("string", varType):
                return STRING
            elif re.match("address", varType):
                return ADDRESS
            elif re.match("bool", varType):
                return BOOL
            elif re.match("contract", varType):
                return CONTRACT
            else:
                logging.debug("{0} is not currently supported".format(varType))
                return UNKNOWN
        except Exception as e:
            logging.warning(e)
            raise e 



DeepDynamicStorage = list()

@dataclass
class VariableModel:
    contractName: str 
    varName: str 
    varType: str 
    varBytes: int 
    varValue: Any
    varSlot: int 
    varOffset: int 
    def getValue(self):
        if self.varValue is not None:
            return self.varValue
        else:
            if TypeParser.parse(self.varType) == UINT:
                return 0
            elif TypeParser.parse(self.varType) == INT:
                return 0  
            elif TypeParser.parse(self.varType) in [BYTE, BYTES]:
                return ""
            elif TypeParser.parse(self.varType) == ADDRESS:
                return "0x"+ "".join(["00"]*20)
            elif TypeParser.parse(self.varType) == CONTRACT:
                return "0x"+ "".join(["00"]*20)
            elif TypeParser.parse(self.varType) == BOOL:
                return False
            else:
                return None
    def setValue(self, slot, value:Any):
    #   66-2*(self.offset+self.numOfBytes):66-2*self.offset
        if self.varOffset is None:
            self.varOffset = 0
        value =  "0x" + value[2:][64-2*(self.varOffset+self.varBytes):64-2*self.varOffset]

        if TypeParser.parse(self.varType) == UINT:
            assert self.varBytes is not None 
            self.varValue = calculator.toUInt(value)
        elif TypeParser.parse(self.varType) == INT:
            self.varValue =  calculator.toInt(value)  
        elif TypeParser.parse(self.varType) in [BYTE, BYTES]:
            self.varValue = value 
        elif TypeParser.parse(self.varType) == ADDRESS:
            self.varValue = "0x"+value[-40:]
        elif TypeParser.parse(self.varType) == CONTRACT:
            self.varValue =  "0x"+value[-40:]
        elif TypeParser.parse(self.varType) == BOOL:
            self.varValue = True if calculator.toUInt(value) == 1 else False
        else:
            assert False, "{0} is not currently supported elementary type".format(TypeParser.parse(self.varType)) 

    def _implyAndSet(self, slot:int, value: Any):
        return False 

    def implyAndSet(self, slot: int, value: Any):
        # logging.log(logging.WARN, "enter implyAndSet")
   
        if slot == self.varSlot:
            self.setValue(slot, value) 
            return True 
        else:
            return self._implyAndSet(slot, value)  
    
    def beginingSlot(self):
        return self.varSlot
    
    def occupySlots(self):
        return math.ceil(self.byteSize/32)
    


@dataclass
class StringVariableModel(VariableModel):
    byteSize: int
    toReadSlot: int 
    def setValue(self, slot: int,  value:Any):
        value = value[2:]
        lowest_byte = value[-2:]
        # https://docs.soliditylang.org/en/v0.8.18/internals/layout_in_storage.html
        # bytes and string
        if int(lowest_byte[1], base=16)%2 == 0:
            # lowest bit not set
            self.byteSize = int(int(lowest_byte, 16)/2)
            varValue = bytes.fromhex(value[:-2])
            self.varValue = varValue.decode().strip("\u0000")
            self.toReadSlot = self.varSlot
        else:
            self.byteSize = int((int(value, 16)-1)/2)
            self.varValue =  ""
            self.toReadSlot = self.beginingSlot()
    
    def _implyAndSet(self, slot: int, value: Any):
        beginingSlot =  self.beginingSlot()
        if self.toReadSlot is None:
            self.toReadSlot = self.varSlot
            self.varValue =  ""
        if self.toReadSlot <= slot and slot < self.occupySlots()+beginingSlot:
            varValue = bytes.fromhex(value[2:-2])
            try:
                if self.varValue is not None:
                # utf-8 encoding
                    self.varValue = self.varValue + varValue.decode().strip("\u0000")
                else:
                    self.varValue = varValue.decode().strip("\u0000")
            except:
                # accii encoding
                if self.varValue is not None:
                    self.varValue = self.varValue + varValue.hex() 
                else:
                    self.varValue = varValue.hex()
            self.toReadSlot += 1
            # print(str(self))
            return True
        else:
            return False
        
    def beginingSlot(self):
        return calculator.getArrayBeginingSlot(self.varSlot) if self.byteSize>31 else self.varSlot

    def occupySlots(self):
        return math.ceil(self.byteSize/32)

    def __str__(self) -> str:
        return "Var: {0}, ByteSize: {1}, Value:{2}, VarSlot: {3}".format(self.varName, self.byteSize, self.varValue, self.varSlot)




TURN_ON_PARRALLEL = False


@dataclass
class MappingVariableModel(VariableModel):
    key_var_type: VariableModel
    val_var_type: VariableModel

    def calculateElementSlots(self, key:str):
        pass 

    def has(self, key:Any) -> bool:
        return key in self.varValue 
    
    def keyCompatible(self, key:Any):
        return (isinstance(self.key_var_type, StringVariableModel) and isinstance(key, str)) \
            or (TypeParser.parse(self.key_var_type.varType) in [UINT] and isinstance(key, int) and key>=0) \
            or (TypeParser.parse(self.key_var_type.varType) in [INT] and isinstance(key, int)) \
            or (TypeParser.parse(self.key_var_type.varType) in [UINT, INT] and isinstance(key, str) and key.startswith("0x")) \
            or (TypeParser.parse(self.key_var_type.varType) in [ADDRESS, BYTE, BYTES] and isinstance(key, str) and key.startswith("0x")) 

    def implyAndSet(self, slot: int, value: Any):
        for guess_key in GLOBAL_INNER_KEYS:
                if self.tryImplyAndSet(slot, value, guess_key):
                        return True 
        return False

    def tryImplyAndSet(self, slot: int, value: Any, guess_key: Any):
        logging.debug("try guess key {0}..".format(guess_key))
        if self.varValue is None:
            self.varValue =  dict() 
        if self.keyCompatible(guess_key):
            
            if TypeParser.parse(self.key_var_type.varType) in [UINT, INT] and isinstance(guess_key, str) and guess_key.startswith("0x"):
                guess_key = int(guess_key, 16)

            if TypeParser.parse(self.key_var_type.varType) in [BYTES] and isinstance(guess_key, str) and guess_key.startswith("0x"):
                m = re.match("bytes([0-9]+)", self.key_var_type.varType)
                if m:
                    guess_key = guess_key[:int(m.group(1))*2+2]
            
            if  TypeParser.parse(self.key_var_type.varType) in [ADDRESS] and isinstance(guess_key, str) and guess_key.startswith("0x"):
                guess_key = f"{int(guess_key, 16):#0{42}x}" 

            if guess_key in self.varValue:
                if self.varValue[guess_key].implyAndSet(slot, value):
                    logging.debug("guess correct key {0}".format(guess_key))    
                    return True
                else:
                    return False
            else:
                current_beginingslot = self.beginingSlot(guess_key)
                if slot < 200:
                    return False
                self.varValue[guess_key] = copy.deepcopy(self.val_var_type)
                self.varValue[guess_key].varSlot = current_beginingslot

             
                success = self.varValue[guess_key].implyAndSet(slot, value)
                if not success:
                    del self.varValue[guess_key]
                else:
                    logging.debug("guess correct key {0}".format(guess_key))    
                    if isinstance(self.varValue[guess_key], StringVariableModel):
                        DeepDynamicStorage.append(self.varValue[guess_key])
                    elif isinstance(self.varValue[guess_key], DynamicArrayVariableModel):
                        DeepDynamicStorage.append(self.varValue[guess_key])
                return success
        else:
            return False
            

    def beginingSlot(self, key: Any):
        matchedSlotHex =  calculator.getKeyisNonValueTypeSlotCalculation(key, self.varSlot)  \
            if isinstance(self.key_var_type, StringVariableModel) else \
            calculator.getKeyisValueTypeSlotCalculation(key, self.varSlot) 
        return int(matchedSlotHex, 16)
    
    
    def occupySlots(self):
        return math.ceil(self.byteSize/32)

    def __str__(self) -> str:
        return "Var: {0}, Size: {1}, Value:{2}, VarSlot: {3}".format(self.varName, len(self.varValue), self.varValue, self.varSlot)
    
     
@dataclass        
class ArrayVariableModel(VariableModel):
    item_var_type: VariableModel
    def size(self) -> int:
        if self.varValue is None:
            return 0
        else:
            return len(self.varValue)
    def items(self) -> List[VariableModel]:
        return self.varValue
    
    def setValue(self, slot, value:Any):
        index_start = (slot - self.beginingSlot())*math.floor(32/self.item_var_type.varBytes)
        index_end = index_start + math.floor(32/self.item_var_type.varBytes)
        for index in range(index_start, index_end):
            if index >= self.size():
                if self.varValue is None:
                    self.varValue = list()
                for _ in range(index-self.size()+1):
                    self.varValue.append(copy.deepcopy(self.item_var_type))
            self.varValue[index].varSlot = slot 
            self.varValue[index].varOffset = ((index - index_start) % math.floor(32/self.item_var_type.varBytes))*self.item_var_type.varBytes
            self.varValue[index].implyAndSet(slot, value)
        return True 

    def isBigEndian(self):
        return True

    def _implyAndSet(self, slot: int, value: Any):
        beginingSlot =  self.beginingSlot()
        if beginingSlot <= slot and slot <= self.occupySlots()+beginingSlot:
            self.setValue(slot, value)
            return True
        else:
            return False
    
    def occupySlots(self):
        if self.item_var_type.varBytes <= 32:
            return math.ceil(self.size() / math.floor(32/self.item_var_type.varBytes)) 
        else:
            return self.size() * math.ceil(self.item_var_type.varBytes/32) 

    def __str__(self) -> str:
        return "Var: {0}, Size: {1}, Value:{2} ".format(self.varName, self.size(), self.varValue)
     

@dataclass
class FixedArrayVariableModel(ArrayVariableModel):
    def initalize(self, size: int):
        if self.varValue is None:
            self.varValue = list()
        if size > len(self.varValue):
            for i in range(len(self.varValue), size):
                self.varValue.append(copy.deepcopy(self.item_var_type))
                self.varValue[i].varSlot = math.ceil(i / math.floor(32/self.item_var_type.varBytes))
                self.varValue[i].varOffset = (i % math.floor(32/self.item_var_type.varBytes))*self.item_var_type.varBytes


@dataclass
class DynamicArrayVariableModel(ArrayVariableModel):
   
    def setValue(self, slot, value:Any):
        if slot == self.varSlot:
            if self.varValue is None:
                self.varValue = list()
            
            size = calculator.toInt(value)
            if size > len(self.varValue):
                    for i in range(len(self.varValue), size):
                        self.varValue.append(copy.deepcopy(self.item_var_type))
                        self.varValue[-1].varSlot = math.ceil(i / math.floor(32/self.item_var_type.varBytes))
                        self.varValue[-1].varOffset = (i % math.floor(32/self.item_var_type.varBytes))*self.item_var_type.varBytes
                        if isinstance(self.varValue[-1], StringVariableModel):
                            DeepDynamicStorage.append(self.varValue[-1])
            return True 
        else:
            # return super(ArrayVariableModel, self).implyAndSet(slot, value)
            # change to fix recursive call
            return super().setValue(slot, value)
    
    def beginingSlot(self):
        return calculator.getArrayBeginingSlot(self.varSlot)
    
    def _implyAndSet(self, slot: int, value: Any):
        beginingSlot =  self.beginingSlot()
        if beginingSlot <= slot and slot <= self.occupySlots()+beginingSlot + 1:
            self.setValue(slot, value)
            return True
        elif slot == self.varSlot:
            self.setValue(slot, value)
            return True
        else:
            return False

@dataclass
class StructVariableModel(VariableModel):
    def members(self) -> List[VariableModel]:
        return self.varValue 
    
    def setValue(self, slot, value: Any):
        if self.members()[0].varSlot!=self.beginingSlot():
            for mem in self.members():
                mem.varSlot += self.beginingSlot()
                # print(mem.varSlot-self.beginingSlot(), mem.varSlot, self.beginingSlot())
        success = False
        for mem in self.members():
            if mem.implyAndSet(slot, value):
                success = True 
        return success
    
    def _implyAndSet(self, slot: int, value: Any):
        return self.setValue(slot, value)

Slot2VariableMap = dict()

@dataclass
class DataModel:
    variables: List[VariableModel]
    def setValue(self, slot:int, value:str):
        global Slot2VariableMap
        # with Pool(6) as p:
        #     results = p.starmap(f, [(variable, slot, value) for variable in self.variables])
        #     return True in results
        try:
            hit = False 

            if slot in Slot2VariableMap:
                for variable in Slot2VariableMap[slot]:
                    variable.implyAndSet(slot, value)
                hit = True 
            else:
                Slot2VariableMap[slot] = []
                for variable in self.variables:
                    if variable.implyAndSet(slot, value):
                        Slot2VariableMap[slot].append(variable)
                        hit = True
                        if variable.varBytes>=32:
                            break 
                if not hit:
                    for item in DeepDynamicStorage:
                        if item.implyAndSet(slot, value):
                            Slot2VariableMap[slot].append(item)
                            hit = True
                            if item.varBytes>=32:
                                    break 
            return hit
        except Exception as e:
            print(e)
            traceback.print_exc()
            return False
    def getFlatVarValues(self):
        flatvalues = set()
        # for i in range(0, 20):
        #     flatvalues.add(i)
        for variable in self.variables:
            # if isinstance(variable, MappingVariableModel) or isinstance(variable, StructVariableModel) \
            #     or isinstance(variable, ArrayVariableModel):
            #     if isinstance(variable, MappingVariableModel):
            #         if variable.varName == "catOwners" or variable.varName == "punkIndexToAddress":
            #             if TypeParser.parse(variable.val_var_type.varType) == ADDRESS:
            #                 value = variable.getValue()
            #                 if value is not None:
            #                     for key in value:
            #                         flatvalues.add(value[key].getValue())
            #         if variable.varName == "punkBids":
            #             value = variable.getValue()
            #             if value is not None:
            #                 for punkIndex in value:
            #                     bidmembers = value[punkIndex].getValue()
            #                     # bid is a struct
            #                     if bidmembers is not None:
            #                         for mem in bidmembers:
            #                             if mem.varName == "bidder":
            #                                 flatvalues.add(mem.getValue())

            #     continue 
            # if variable.varName == "rescueIndex":
            #     value = variable.getValue()
            #     if value is not None:
            #         flatvalues.add(value)
            #         assert isinstance(value, int)
            #         if value > 0:
            #             flatvalues.add(value-1)
            #         flatvalues.update([value + i for i in range(16)])
            #         flatvalues.update(range(16))
            #         flatvalues.add("0x"+"".join(["00"]*20))  
            #     for _variable in self.variables:
            #         if _variable.varName == "rescueOrder":
            #             _value = _variable.getValue()
            #             if _value is not None:
            #                 for item in _value:
            #                     flatvalues.add(item.getValue())

            # elif variable.varName == "totalTokens": 
            #     value = variable.getValue()
            #     if value is not None:
            #         flatvalues.add(value)
            #         if isinstance(value, int):
            #             for i in range(0, 16):
            #                 flatvalues.add(value+i)
            #                 flatvalues.add(i)
            
            # elif variable.varName == "tokenCounter": 
            #     value = variable.getValue()
            #     if value is not None:
            #         flatvalues.add(value)
            #         if isinstance(value, int):
            #             for i in range(0, 100):
            #                 flatvalues.add(value+i)
            #                 # flatvalues.add(i)

            # elif variable.varName == "_tokenOwners":
            #     value = variable.getValue()
            #     if value is None:
            #         length = 0
            #     else:
            #         if isinstance(value, list):
            #             length = len(value)
            #         else:
            #             length = 0 
            #     for i in range(0, 30):
            #         flatvalues.add(i+length) 
            # else:
                value = variable.getValue()
                if value is not None and (isinstance(value, str) or isinstance(value, int)):
                    flatvalues.add(value)
                    if isinstance(value, int):
                        flatvalues.add(value+1)
        return flatvalues
    
    def getVarInfos(self):
        results = list()
        for variable in self.variables:
            varInfo = VarInfo(name = variable.varName, type = variable.varType, vartype= VarType.STATEVAR, derivation=None)
            results.append(varInfo)
        return results
    
    def getVarType(self, varInfo: Any):
        for variable in self.variables: 
                if varInfo.name == variable.varName:
                    return variable
        assert False, f"{varInfo} not found" 
       
    
    def getVarValue(self, varInfo: Any):
        return self.getVarType(varInfo).getValue()


INPLACE = "inplace"
MAPPING = "mapping"
STRING = "bytes"
DYNAMICDARRAY = "dynamic_array"

def createVariableModelFromUnnamedType(varType:str, types_desc:dict):
    varBytes = int(types_desc.get(varType).get("numberOfBytes"))
    encoding = types_desc.get(varType).get("encoding")
    if encoding == INPLACE:
        if types_desc.get(varType).get("members"):
            members = list()
            for member_var in types_desc.get(varType).get("members"):
                mvar =  createVariableModel(member_var, types_desc)
                members.append(mvar)
            return StructVariableModel(contractName=None, varName=None, varType=varType.replace("t_", ""), varValue=members, varBytes=varBytes, varSlot=None, varOffset=None) 
        elif types_desc.get(varType).get("base"):
            # currently only support one-dimensional array
            item_type = types_desc.get(varType).get("base")
            item_var_type = createVariableModelFromUnnamedType(item_type, types_desc)
            fixedArray = FixedArrayVariableModel(contractName=None, varName=None, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=None, varOffset=None, item_var_type=item_var_type)
            number =  int(re.search("\[([0-9]+)\]$", item_type).groups()[0])
            fixedArray.initalize(number)  
            return fixedArray
        else:
            varType = types_desc.get(varType).get("label")
            return VariableModel(contractName=None, varName=None, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=None, varOffset=None)
    elif encoding == MAPPING:
        key_type  = types_desc.get(varType).get("key") 
        val_type  = types_desc.get(varType).get("value") 
        key_type_var = createVariableModelFromUnnamedType(key_type, types_desc)
        val_type_var = createVariableModelFromUnnamedType(val_type, types_desc)
        return MappingVariableModel(contractName=None, varName=None, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=None, varOffset=None, key_var_type=key_type_var, val_var_type=val_type_var)
    elif encoding == STRING:
        return StringVariableModel(contractName=None, varName=None, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=None, varOffset=None, byteSize=0, toReadSlot=None) 
    elif encoding == DYNAMICDARRAY:
        item_type = types_desc.get(varType).get("base")
        item_var_type = createVariableModelFromUnnamedType(item_type, types_desc)
        return DynamicArrayVariableModel(contractName=None, varName=None, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=None, varOffset=None, item_var_type=item_var_type)  

def createVariableModel(var_desc: dict, types_desc:dict):
    contractName = var_desc.get("contract")
    varName = var_desc.get("label")
    if varName.find("_own_")!=-1:
        varName =  varName.split("_own_")[-1]
    varType = var_desc.get("type")
    varOffset = int(var_desc.get("offset"))
    varSlot = int(var_desc.get("slot"))
    varBytes = int(types_desc.get(varType).get("numberOfBytes"))
    encoding = types_desc.get(varType).get("encoding")
    if encoding == INPLACE:
        if types_desc.get(varType).get("members"):
            members = list()
            for member_var in types_desc.get(varType).get("members"):
                members.append(createVariableModel(member_var, types_desc))
            return StructVariableModel(contractName=contractName, varName=varName, varType=varType.replace("t_", ""), varValue=members, varBytes=varBytes, varSlot=varSlot, varOffset=varOffset) 
        elif types_desc.get(varType).get("base"):
            # currently only support one-dimensional array
            item_type = types_desc.get(varType).get("base")
            item_var_type = createVariableModelFromUnnamedType(item_type, types_desc)
            fixedArray = FixedArrayVariableModel(contractName=contractName, varName=varName, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=varSlot, varOffset=varOffset, item_var_type=item_var_type)
            number =  int(re.findall(item_type+"\[([0-9]+)\]$", varType)[0])
            fixedArray.initalize(number)  
            return fixedArray
        else:
            varType = types_desc.get(varType).get("label")
            return VariableModel(contractName=contractName, varName=varName, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=varSlot, varOffset=varOffset)
    elif encoding == MAPPING:
        key_type: str  = types_desc.get(varType).get("key") 
        val_type  = types_desc.get(varType).get("value") 
        key_type_var = createVariableModelFromUnnamedType(key_type, types_desc)
        val_type_var = createVariableModelFromUnnamedType(val_type, types_desc)
        return MappingVariableModel(contractName=contractName, varName=varName, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=varSlot, varOffset=varOffset, key_var_type=key_type_var, val_var_type=val_type_var)
    elif encoding == STRING:
        return StringVariableModel(contractName=contractName, varName=varName, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=varSlot, varOffset=varOffset, byteSize=0, toReadSlot=varSlot) 
    elif encoding ==  DYNAMICDARRAY:
        item_type = types_desc.get(varType).get("base")
        item_var_type = createVariableModelFromUnnamedType(item_type, types_desc)
        return DynamicArrayVariableModel(contractName=contractName, varName=varName, varType=varType.replace("t_", ""), varValue=None, varBytes=varBytes, varSlot=varSlot, varOffset=varOffset, item_var_type=item_var_type)  
    else:
        assert False, "encoding {0} is currently not support".format(encoding)

def createDataModel(storagemodel: dict) -> DataModel:
    global types_desc
    vars = storagemodel.get("storage")
    types_desc = storagemodel.get("types")
    variableModels = list()
    for variable in vars:
        variableModel = createVariableModel(variable, types_desc)
        variableModels.append(variableModel)
   
    return DataModel(variables=variableModels)

def loadDataModel(trace: dict) -> DataModel:
    variableModels = list()
    def loadVariable(item):
        if "item_var_type" in item:
            # array
            item["item_var_type"] = loadVariable(item["item_var_type"])
            if item["varValue"] is not None:
                vals = []
                for _val in item["varValue"]:
                    val_var = loadVariable(_val)
                    vals.append(val_var)
                item["varValue"] = vals 
            return ArrayVariableModel(**item)
        elif "key_var_type" in item:
            # mapping
            assert "val_var_type" in item
            item["key_var_type"] = loadVariable(item["key_var_type"])
            item["val_var_type"] = loadVariable(item["val_var_type"])
            if item["varValue"] is not None:
                for key in item["varValue"]:
                    val_var = loadVariable(item["varValue"][key])
                    item["varValue"][key] = val_var
            return MappingVariableModel(**item)
        elif "byteSize" in item:
            return StringVariableModel(**item)
        else:
            if isinstance(item["varValue"], list):
                member_vars = []
                for member in item["varValue"]:
                    member_var = loadVariable(member) 
                    member_vars.append(member_var)
                item["varValue"] = member_vars
                return StructVariableModel(**item)
            else:
                # other primitive
                result = VariableModel(**item)
                return result
                 
    for item in trace["variables"]:
        elem = loadVariable(item)
        variableModels.append(elem)
    return DataModel(variables=variableModels)
    

VarName =  str 
StateData = DataModel 
EnvData =  List[Dict]
FuncName = str 
ContractName = str 

class TxType(Enum):
    NORMAL = 0
    REVERSION = 1

class VarType(Enum):
    STATEVAR = 0
    TXVAR = 1
    LOCALVAR = 2
    ENUM = 3

class DummyVarInfo:
    def computeConfidence(self):
        pass 
class DummyDerivation:
    def computeConfidence(self):
        pass 
  
@dataclass
class VarInfo:
    name: VarName
    type: str 
    vartype: VarType
    derivation: DummyDerivation 
    
    def getDerivedInfo(self):
        pass

    def isDerived(self):
        return self.derivation is not None   

    def isStateVar(self):
        return self.vartype == VarType.STATEVAR

    def isTxVar(self):
        return self.vartype == VarType.TXVAR
    
    def isLocalVar(self):
        return self.vartype == VarType.LOCALVAR
    
    def computeConfidence(self):
        if not self.isDerived():
            return 1
        return self.derivation.computeConfidence()
    
    def isStruct(self):
        if self.type in types_desc:
            if "members" in types_desc.get(self.type):
                return True 
        return False 

    def __eq__(self, other: object) -> bool:
        return self.name == other.name if isinstance(other, VarInfo) else False
    
    def __hash__(self) -> int:
        return hash(self.name)
    

def generateVarInfosForAbiFunc(func):
    results =  list()
    for item in func["inputs"]:
        varInfo = VarInfo(name=item["name"], type=item["type"], vartype= VarType.TXVAR, derivation= None)
        results.append(varInfo)
    
    results.append(VarInfo(name="msg.sender", type="address", vartype=VarType.TXVAR, derivation=None))
    results.append(VarInfo(name="msg.value", type="uint256", vartype=VarType.TXVAR, derivation=None))
    return results

# Notice
# Parameter var differs from state var in the representation of varType
# TODO: should we unify it?
def getVarType(func, varInfo: VarInfo):
    for item in func["inputs"]:
        if varInfo.name == item["name"]:
            return item 
    if varInfo.name == "msg.sender":
        return dict(name="msg.sender", type="address")
    elif varInfo.name == "msg.value":
        return dict(name="msg.value", type="uint256")
    else:
        assert False, "{0} is not supported.".format(varInfo.name)

