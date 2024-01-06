from typing import Dict, List, Union
import logging 
from invconplus.model.model import *
from ..plugin.BlockchainDataProvider import BlockchainDataProvider 
from .web3util import decodeFunctionInput
class Reader:
    contract_address: str 
    contractName: str 
    storageLayout: Dict 
    abi: List 
    transactions: List
    txCursor: int 
    def __init__(self, contract_address, maxCount) -> None:
        self.contract_address = contract_address 
        bdProvider = BlockchainDataProvider(params = dict(contract_address=contract_address), maxCount=maxCount)
        self.contractName, self.storageLayout, self.abi, self.constants, self.transactions = bdProvider.read()
        self.txCursor = 0 

    # @output, the environments of the parameter values, including block and transaction parameters
    def iterateTx(self):
        funcNames = list()
        envs = list()
        reverted = "error" in self.transactions[self.txCursor][0] and self.transactions[self.txCursor][0]["error"]!="" and self.transactions[self.txCursor][0]["error"]!="0"
        stateDiff =  self.transactions[self.txCursor][0]["stateDiff"]
        tx_hash = self.transactions[self.txCursor][0]["transactionHash"]
        # there could be multiple traces per transaction
        # the interesting trace(s) are the ones that the field `to` of `action` equals to the contract address
        # and the contract type is either `create` (maybe `create2`) or `call`
        foundAction = False
        for trace in self.transactions[self.txCursor]:
                # this is a transaction that contains contract creation call 
                if trace["action"]["from"].lower()!="0x0" \
                    and (trace["action"]["to"].lower() == self.contract_address.lower() \
                          or trace["action"]["to"].lower() == "0x0") \
                    and trace["type"] in ["create", "create2", "call"]:
                    envs.append(dict(name ="block.number", value = trace["blockNumber"]))
                    envs.append(dict(name ="tx.hash", value = trace["transactionHash"]))
                    envs.append(dict(name ="block.timestamp", value = trace["timestamp"]))
                    envs.append(dict(name ="msg.sender", value = trace["action"]["from"]))
                    envs.append(dict(name ="msg.gas", value = trace["action"]["gas"] if "gas" in trace["action"] else 0))
                    envs.append(dict(name ="msg.value", value = trace["action"]["value"]))
                    foundAction = True
                    # if "articulatedTrace" in trace:
                    #     fullName = self._findFullFuncName(trace["articulatedTrace"]["name"], trace["articulatedTrace"]["inputs"].keys())
                    #     funcNames.append(fullName)
                    #     for variable in trace["articulatedTrace"]["inputs"]:
                    #         envs.append(dict(name =variable, value = trace["articulatedTrace"]["inputs"][variable]))
                    try:
                        if "input" in trace["action"] and  trace["action"]["input"]!="" and trace["action"]["input"]!="0x":
                            result = decodeFunctionInput(address=trace["action"]["to"], abi = self.abi, tx_input=trace["action"]["input"])
                            funcName =  result["name"]
                            inputs = result["inputs"]
                            fullName = self._findFullFuncName(funcName, inputs.keys())
                            funcNames.append(fullName)
                            for variable in inputs:
                                if isinstance(inputs[variable], bytes):
                                    inputs[variable] = "0x"+inputs[variable].hex()
                                elif isinstance(inputs[variable], list):
                                    inputs[variable] = ["0x"+item.hex() if isinstance(item, bytes) else item for item in inputs[variable] ]
                                envs.append(dict(name =variable, value = inputs[variable]))
                        else:
                            pass 
                    except:
                        pass 
        if len(self.constants) > 0:
            envs.extend(self.constants)      

        if not foundAction:  
            self.txCursor += 1
            return None, "Invalid", None, None, None, None
        else:           
            self.txCursor += 1
            isFirstTx = self.txCursor == 1
            return isFirstTx, tx_hash, funcNames, envs, stateDiff, reverted 
    
    def done(self):
        return self.txCursor>=len(self.transactions)
    
    def _findFullFuncName(self, shortFuncName, variables):
        matched_func = None
        for func in self.abi:
            if "name" in func and func["name"] ==  shortFuncName:
                if len(variables)!=len(func["inputs"]):
                    continue 
                matched = True 
                for input in func["inputs"]:
                    if input["name"] not in variables:
                        matched = False 
                if matched:
                    matched_func = func 
                    break 
        if matched_func is None:
            return None 
        fullfuncName = matched_func["name"]+ "("+",".join([ item["name"] if item["name"]!="" else item["type"] for item in matched_func["inputs"]]) + ")"
        return fullfuncName
                
        

class StorageModelReader:
    def __init__(self, storageLayout) -> None:
        self.model = createDataModel(storageLayout)

    def getModel(self):
        return self.model 
    
    def read(self, slot: Union[str, int], oldVal, newVal):
        if isinstance(slot, str) and slot.startswith("0x"):
            slot = int(slot[2:], base=16)
        if not self.model.setValue(slot, newVal):
            logging.log(logging.DEBUG, "missing (slot: {0}, value: {1})".format(hex(slot), newVal))
            return False 
        return True