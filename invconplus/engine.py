import logging
import json  

from invconplus.model.model import TypeParser, DataModel, VarType, VariableModel, VarInfo, \
     StructVariableModel, ArrayVariableModel, MappingVariableModel, UINT, INT, generateVarInfosForAbiFunc, getVarType
from invconplus.model.Tx import Transaction
from invconplus.ppt import PptTopLevel, PptType, TxType
from typing import Dict, List, Any
from invconplus.derivation.Derivation import Derivation 
from invconplus.derivation.unary.Original import Original
from invconplus.derivation.unary.StructMember import StructMember 
from invconplus.derivation.binary.ArrayItem import ArrayItem 
from invconplus.derivation.binary.MappingItem import MappingItem
from invconplus.invariant import IntConstRange, IntSmallRange, IntSeqConstSum, IntSeqItemSmallRange, AddressImply, LinearyEq
from invconplus.abstractType.AbstractType import MyContract
from invconplus.const import RESULT_DIR, DISABLE_IMPLICATION_INV, ALLOW_FASIFY_INV, ENABLE_INV_REDUCTION

PptMap = List[PptTopLevel]
ABISpec = Dict  
Declaration = DataModel
Path = str 
PptInfo = Dict 
ContractName =  str 
class InvConPlus:
    address: str 
    contractName: ContractName
    all_ppts: PptMap
    inv_file: Path 
    stateLayoutDecl: Declaration
    abi: ABISpec
    contractDependency: Any 
    def __init__(self, address, contractName: ContractName, model_0: Declaration, abi: ABISpec) -> None:
        self.decl = model_0 
        self.abi = abi
        self.all_ppts = list() 
        self.inv_file  = None
        self.contractName =  contractName
        self.address = address
        self.contractDependency = None 

        self.all_sliced_ppts = list()
    
    @classmethod
    def isFunction(cls, event_func):
        return event_func["type"] == "function"
    
    def getFunction(self, funcName):
        for event_func in self.abi:    
            if self.isFunction(event_func=event_func) \
                and ("stateMutability" not in event_func or event_func["stateMutability"] != "view") \
                and ("view" not in event_func or event_func["view"] != True) \
                and ("constant" not in event_func or event_func["constant"]!=True):
                func = event_func
                input_list = [item["name"] for item in func["inputs"]]
                _funcName = "{0}({1})".format(func["name"], ",".join(input_list))
                if funcName == _funcName:
                    return func 
        return None

    def createInitialPpts(self):
        for event_func in self.abi:    
            if self.isFunction(event_func=event_func) \
                and ("stateMutability" not in event_func or event_func["stateMutability"] != "view") \
                and ("view" not in event_func or event_func["view"] != True) \
                and ("constant" not in event_func or event_func["constant"]!=True):
                func = event_func
                self.createInitialPptsForFunction(func=func, statedecl = self.decl)
        self.createInitialPptsForContract(self.decl)

    def createInitialPptsForContract(self, decl):
        # TODO: 
        logging.warn("createInitialPptsForContract...")
        stateVarInfos  = decl.getVarInfos()
        ppt = PptTopLevel(contract= self.contractName, func=None, type= PptType.CONTRACT, executionType=TxType.NORMAL, vars= stateVarInfos)
        self.all_ppts.extend([ppt]) 
    
    def createInitialPptsForFunction(self, func, statedecl):
        # TODO: 
        input_list = [item["name"] for item in func["inputs"]]
        # print(input_list)
        logging.warn("createInitialPptsForFunction for {0}({1})".format(func["name"], ",".join(input_list)))
        funcName = "{0}({1})".format(func["name"], ",".join(input_list))
        stateVarInfos  = statedecl.getVarInfos()
        funcVarInfos = generateVarInfosForAbiFunc(func)  
        ppt1 = PptTopLevel(contract= self.contractName, func=funcName, type= PptType.ENTER, executionType=TxType.NORMAL, vars= stateVarInfos + funcVarInfos)
        ppt2 = PptTopLevel(contract= self.contractName, func=funcName, type= PptType.EXIT, executionType=TxType.NORMAL, vars= stateVarInfos + funcVarInfos)
        ppt3 = PptTopLevel(contract= self.contractName, func=funcName, type= PptType.ENTER, executionType=TxType.REVERSION, vars= stateVarInfos + funcVarInfos)
        ppt4 = PptTopLevel(contract= self.contractName, func=funcName, type= PptType.EXIT, executionType=TxType.REVERSION, vars= stateVarInfos + funcVarInfos)
        # self.all_ppts.extend([ppt1, ppt2, ppt3, ppt4])
        self.all_ppts.extend([ppt2, ppt4])

    def initializePpts(self):
        mycontract = MyContract(address=self.address)
        # create initial ppts 
        self.createInitialPpts()
        for ppt in self.all_ppts:
            # logging.warn(ppt.func)
            ppt.register_engine(self)
            # ppt.create_derived_variables()
        
        self.contractDependency =  mycontract.analyze(self.all_ppts)

        for ppt in self.all_ppts:
            if ppt.func is not None:
                derivedVarInfos = self.contractDependency.createDerivedVarsForFunc(ppt.func)
                if len(derivedVarInfos)>0:
                    ppt.addCustomizedVarInfos(derivedVarInfos)
                    logging.debug(derivedVarInfos)
            ppt.create_derived_variables()
            ppt.createSlices()
            for myslice in ppt.all_slices:
                myslice.instantiate_invariants()
                logging.debug(myslice)

            if not DISABLE_IMPLICATION_INV:
                # create imply slices that contains only the implied invariants
                ppt.createImplySlice()

    def process_data(self, tx: Transaction):
        for ppt in self.all_ppts:
            ppt.load(tx)

    def generate_invariants(self, inv_file = None):
        import os 
        if inv_file is None:
            inv_file = os.path.join(RESULT_DIR, self.address+"-"+self.contractName+".inv")
        output_format = "json"
        if output_format == "json":
            json_results = list()
            for ppt in self.all_ppts:
                    results = list()
                    _results =  ppt.getAllInvariants()
                    if ENABLE_INV_REDUCTION:
                        if ppt.func:
                            for inv in _results:
                                if self.contractDependency.testFuncDep(ppt.func, inv.varInfos):
                                    results.append(inv) 
                        else:
                            for inv in _results:
                                if self.contractDependency.testDep(inv.varInfos):
                                    results.append(inv)
                    else: 
                        results = _results  
                    logging.warning("\n")
                    logging.warning(ppt.func)
                    logging.warning(ppt.type)
                    logging.warning(ppt.executionType)
                    logging.warning("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify and inv.__str__()!="" ])) 
                    posts = list() 
                    pres = list() 
                    # falsified invariants that hold for some txs
                    falsified_pres = list()
                    falsified_posts = list()
                    LIMIT = 3

                    for inv in results:
                        
                        if inv.verified:
                            if not inv.falsify:
                                if inv.isPostCondition():
                                    if inv.__str__() not in posts and inv.__str__() != "":
                                        posts.append(inv.__str__())
                                else:
                                    if inv.__str__() not in pres and inv.__str__() != "":
                                        pres.append(inv.__str__())
                            elif ALLOW_FASIFY_INV and inv.falsify and inv.sizeOfPassSamples() >= LIMIT:
                                # do not show falsified invariants that hold for less than LIMIT txs
                                if isinstance(inv, IntSmallRange) or isinstance(inv, IntSeqConstSum) or isinstance(inv, IntConstRange) or isinstance(inv, IntSeqItemSmallRange) or isinstance(inv, AddressImply):
                                    # do not show falsified invariants that are too general
                                    continue 
                                if inv.isPostCondition():
                                    if inv.__str__() not in falsified_posts and inv.__str__() != "":
                                        falsified_posts.append(inv.__str__())
                                else:
                                    if inv.__str__() not in falsified_pres and inv.__str__() != "":
                                        falsified_pres.append(inv.__str__())
                            else:
                                pass 
                        
                    json_results.append(dict(func=ppt.func, type=str(ppt.type), executionType=str(ppt.executionType), preconditions=pres, postconditions=posts, falsified_preconditions=falsified_pres, falsified_postconditions=falsified_posts))
            json.dump(json_results, open(inv_file+".json", "w"), indent=4)
        else:
            with open(inv_file+"--raw", "w") as writer:
                for ppt in self.all_ppts:
                    results =  ppt.getAllInvariants()
                    logging.warning("\n")
                    logging.warning(ppt.func)
                    logging.warning(ppt.type)
                    logging.warning(ppt.executionType)
                    logging.warning("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify and inv.__str__()!="" ])) 
                    
                    writer.write("\n")
                    if ppt.func is not None:
                        writer.write(ppt.func)
                        writer.write("\n")
                    writer.write(str(ppt.type))
                    writer.write("\n")
                    writer.write(str(ppt.executionType))
                    writer.write("\n")
                    writer.write("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify and inv.__str__()!="" ])) 
                    writer.write("\n")

            with open(inv_file, "w") as writer:
                for ppt in self.all_ppts:
                    results = list()
                    _results =  ppt.getAllInvariants()
                    if ppt.func:
                        for inv in _results:
                            if self.contractDependency.testFuncDep(ppt.func, inv.varInfos):
                                results.append(inv) 
                    else:
                        for inv in _results:
                            if self.contractDependency.testDep(inv.varInfos):
                                results.append(inv)   
                    logging.warning("\n")
                    logging.warning(ppt.func)
                    logging.warning(ppt.type)
                    logging.warning(ppt.executionType)
                    logging.warning("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify and inv.__str__()!="" ])) 
                    
                    writer.write("\n")
                    if ppt.func is not None:
                        writer.write(ppt.func)
                        writer.write("\n")
                    writer.write(str(ppt.type))
                    writer.write("\n")
                    writer.write(str(ppt.executionType))
                    writer.write("\n")
                    writer.write("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify and inv.__str__()!=""])) 
                    writer.write("\n")
            
            with open(inv_file+"--compressed", "w") as writer:
                for ppt in self.all_ppts:
                    results =  list()
                    _results =  ppt.compressInvaraints()
                    if ppt.func:
                        for inv in _results:
                            if self.contractDependency.testFuncDep(ppt.func, inv.varInfos):
                                results.append(inv) 
                    else:
                        for inv in _results:
                            if self.contractDependency.testDep(inv.varInfos):
                                results.append(inv)   
                    logging.warning("\n")
                    logging.warning(ppt.func)
                    logging.warning(ppt.type)
                    logging.warning(ppt.executionType)
                    logging.warning("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify ])) 
                    
                    writer.write("\n")
                    if ppt.func is not None:
                        writer.write(ppt.func)
                        writer.write("\n")
                    writer.write(str(ppt.type))
                    writer.write("\n")
                    writer.write(str(ppt.executionType))
                    writer.write("\n")
                    writer.write("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify ])) 
                    writer.write("\n")

    def getVarType(self, funcName, varInfo: VarInfo):
        if varInfo.isStateVar():
            if not varInfo.isDerived():
                return self.decl.getVarType(varInfo) 
            else:
                if isinstance(varInfo.derivation, Original):
                    return self.getVarType(funcName, varInfo.derivation.varInfos[0]) 
                elif isinstance(varInfo.derivation, StructMember):
                    struct: StructVariableModel =  self.getVarType(funcName, varInfo.derivation.varInfos[0]) 
                    for member in struct.members():
                        if varInfo.derivation.varInfos[0].name + "." + member.varName == varInfo.name:
                            return member
                elif isinstance(varInfo.derivation, ArrayItem):
                    arr: ArrayVariableModel =  self.getVarType(funcName, varInfo.derivation.varInfos[0]) 
                    return arr.item_var_type 
                elif isinstance(varInfo.derivation, MappingItem):
                    mp: MappingVariableModel =  self.getVarType(funcName, varInfo.derivation.varInfos[0]) 
                    return mp.val_var_type
                else:
                    assert False         
        elif varInfo.isTxVar():
            return getVarType(self.getFunction(funcName=funcName), varInfo=varInfo)
        else:
            assert False

    def checkTypeConsistent(self, funcName, varInfo1: VarInfo, varInfo2: VarInfo):
        vartype1 = self.getVarType(funcName, varInfo1)
        vartype2 = self.getVarType(funcName, varInfo2)
        if isinstance(vartype1, VariableModel) and isinstance(vartype2, VariableModel):
            return vartype1.varType == vartype2.varType
        elif isinstance(vartype1, VariableModel) and not isinstance(vartype2, VariableModel):
            return vartype1.varType == vartype2["type"]
        elif not isinstance(vartype1, VariableModel) and isinstance(vartype2, VariableModel):
            return vartype2.varType == vartype1["type"]
        else:
            if vartype1["type"] == vartype2["type"]:
                return True 
            else:
                if vartype1["type"].startswith("uint") == vartype2["type"].startswith("uint"):
                    return True 
                else:
                    return False
                
    # create sliced ppts 
    def dynamicCreateOrGetSlicePPT(self, funcName, key_parameters: List[Dict], slice_states: List[Dict]):
        func = self.getFunction(funcName)
        if func is None:
            return None 
        else:
            new_funcName =  funcName + "@" + "@".join([ param.name for param in  key_parameters] )
            if any(map(lambda ppt: ppt.func == new_funcName , self.all_sliced_ppts)):
                return list(filter(lambda ppt: ppt.func == new_funcName , self.all_sliced_ppts))[0]
            
            state_varInfos = [ VarInfo(name = item["name"], type= item["vartype"], vartype= VarType.STATEVAR, derivation=None) for item in slice_states ]
           
         
            funcVarInfos = generateVarInfosForAbiFunc(func) 
            ppt = PptTopLevel(contract= self.contractName, func= new_funcName, type= PptType.EXIT, executionType= TxType.NORMAL, vars= state_varInfos + funcVarInfos)
            self.all_sliced_ppts.append(ppt)
            
            original_varInfos =  []
            for varInfo in state_varInfos:
                original_varInfos.extend(Original(varInfos=[varInfo], ppt_slice=ppt).derive())
            ppt.vars += original_varInfos 

            ppt.createSlices()
            for myslice in ppt.all_slices:
                myslice.instantiate_invariants()
                logging.debug(myslice)
            return ppt 
    
    def generate_trace_slice_invariants(self, inv_file: str):
        output_format = "json"
        if output_format == "json":
            json_results = list()
            for ppt in self.all_sliced_ppts:
                    results = list()
                    _results =  ppt.getAllInvariants()
                    results = _results  
                    logging.warning("\n")
                    logging.warning(ppt.func)
                    logging.warning(ppt.type)
                    logging.warning(ppt.executionType)
                    logging.warning("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify ])) 
                    posts = list() 
                    pres = list() 
                    for inv in results:
                        if inv.verified and not inv.falsify:
                            if inv.isPostCondition():
                                posts.append(inv.__str__())
                            else:
                                pres.append(inv.__str__())

                    json_results.append(dict(func=ppt.func, type=str(ppt.type), executionType=str(ppt.executionType), preconditions=pres, postconditions=posts))
            json.dump(json_results, open(inv_file+".json", "w"), indent=4)
        else:
            with open(inv_file+"--raw", "w") as writer:
                for ppt in self.all_sliced_ppts:
                    results =  ppt.getAllInvariants()
                    logging.warning("\n")
                    logging.warning(ppt.func)
                    logging.warning(ppt.type)
                    logging.warning(ppt.executionType)
                    logging.warning("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify ])) 
                    
                    writer.write("\n")
                    if ppt.func is not None:
                        writer.write(ppt.func)
                        writer.write("\n")
                    writer.write(str(ppt.type))
                    writer.write("\n")
                    writer.write(str(ppt.executionType))
                    writer.write("\n")
                    writer.write("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify ])) 
                    writer.write("\n")

            with open(inv_file+"--compressed", "w") as writer:
                for ppt in self.all_sliced_ppts:
                    results =  list()
                    _results =  ppt.compressInvaraints()
                    if ppt.func:
                        for inv in _results:
                            if self.contractDependency.testFuncDep(ppt.func, inv.varInfos):
                                results.append(inv) 
                    else:
                        for inv in _results:
                            if self.contractDependency.testDep(inv.varInfos):
                                results.append(inv)   
                    logging.warning("\n")
                    logging.warning(ppt.func)
                    logging.warning(ppt.type)
                    logging.warning(ppt.executionType)
                    logging.warning("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify ])) 
                    
                    writer.write("\n")
                    if ppt.func is not None:
                        writer.write(ppt.func)
                        writer.write("\n")
                    writer.write(str(ppt.type))
                    writer.write("\n")
                    writer.write(str(ppt.executionType))
                    writer.write("\n")
                    writer.write("\n".join([ inv.__str__() for inv in results if inv.verified and not inv.falsify ])) 
                    writer.write("\n")

