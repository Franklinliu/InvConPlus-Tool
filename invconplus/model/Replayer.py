import copy
import logging
import json 
from dataclasses import asdict
from .Tx import Transaction, TxType
from .Reader import Reader, StorageModelReader
from . import model as model
from invconplus.vmtracesimulator.main import Simulator
from invconplus.const import ENABLE_READ_MODEL_FLATTENVALUE

File = str 
Tx = str
class TransactionReplayer:
    contract_address: str 
    contractName: str 
    myreader: Reader 
    modelReader: StorageModelReader
    def __init__(self, contract_address, maxCount) -> None:
        self.contract_address = contract_address.lower()
        self.myreader = Reader(contract_address=contract_address, maxCount=maxCount)
        self.modelReader = StorageModelReader(self.myreader.storageLayout)
        self.contractName =  self.myreader.contractName 
      
    def readPerTx(self):
        assert not self.done()

        isFirstTx, tx_hash, funcNames, envs, stateDiff, reverted = self.myreader.iterateTx()
        while tx_hash == "Invalid" and not self.done():
            isFirstTx, tx_hash, funcNames, envs, stateDiff, reverted = self.myreader.iterateTx()
        
        if tx_hash == "Invalid":
            return None, None

        self.envs = envs 

        preState = copy.deepcopy(self.modelReader.getModel())

        logging.debug("process transaction {0}".format(tx_hash))

        if reverted:
        # if stateDiff is None or self.contract_address.lower() not in stateDiff:
            if isFirstTx:
                return isFirstTx, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=preState, envs=envs, contract=self.contractName, func="constructor",  tx_type=TxType.REVERSION) 
            elif len(funcNames)>1:
                return True, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=preState, envs=envs, contract=self.contractName, func=list(funcNames)[0],  tx_type=TxType.REVERSION)
            elif len(funcNames)==1:
                return False, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=preState, envs=envs, contract=self.contractName, func=list(funcNames)[0],  tx_type=TxType.REVERSION)
            elif len(funcNames)==0:
                return True, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=preState, envs=envs, contract=self.contractName, func="",  tx_type=TxType.REVERSION)
            else:
                assert False

        else:
            model.GLOBAL_INNER_KEYS.clear()
            missed_data = list()
            def readEnvs():
                results =  set()
                for item in self.envs:
                    if item["value"] is not None:
                        if isinstance(item["value"], list):
                            results.update([ val.lower() if isinstance(val, str) and val.startswith("0x") else val for val in  item["value"] ])
                        else:
                            results.add(item["value"].lower() if isinstance(item["value"], str) and item["value"].startswith("0x") 
                                                        else item["value"])
                return results 
            myenvs = readEnvs() 
            
            if self.contract_address.lower() in stateDiff:
                stateenvs = self.modelReader.getModel().getFlatVarValues()
                # if ENABLE_READ_MODEL_FLATTENVALUE:
                #     if len(funcNames) > 0 and str(funcNames[0]).find("setInitialOwners") == -1:
                #             for flatval in self.modelReader.getModel().getFlatVarValues():
                #                 stateenvs.add(flatval)
                model.GLOBAL_INNER_KEYS = list(myenvs) + list(stateenvs)
                if "storage" not in stateDiff[self.contract_address.lower()]:
                    return None, None 
                for slot in stateDiff[self.contract_address.lower()]["storage"]:
                    slotchange = stateDiff[self.contract_address]["storage"][slot]
                    for mark in slotchange:
                        if mark == "+":
                            # initialize
                            oldVal = "0x"+"".join(["0"]*64)
                            newVal = slotchange[mark]
                            break 
                        elif mark == "*":
                            oldVal = slotchange[mark]["from"]
                            newVal = slotchange[mark]["to"]
                            break 
                        else:
                            assert False 

                    if not self.modelReader.read(slot, oldVal=oldVal, newVal=newVal):
                        missed_data.append((slot, oldVal, newVal)) 
                
                if len(missed_data) > 0:
                    logging.debug("missing state changes in transaction#{0}".format(tx_hash))
                    simulator = Simulator(tx_hash = tx_hash)
                    simulator.loadAndexec()

                    maxTimes = 3 # recheck all the miss data twice to compute the correct variable 
                                 # mapping and update the corresponding variable
                    count = 0
                    while count < maxTimes and len(missed_data) > 0:
                        count += 1
                        for missed_slot in copy.copy(missed_data):
                            slot, oldVal, newVal = missed_slot
                            constants = simulator.query(slot)
                            model.GLOBAL_INNER_KEYS = list(constants)
                            if self.modelReader.read(slot, oldVal=oldVal, newVal=newVal):
                                missed_data.remove(missed_slot)
                    
                    if len(missed_data) > 0:
                        logging.warning("missing {0} state changes: {1}".format(len(missed_data), missed_data))
                    else:
                        logging.warning("succeed in updating variables")
                
            # postState = copy.deepcopy(self.modelReader.getModel())
            postState = self.modelReader.getModel()

            if isFirstTx:
                return isFirstTx, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=postState, envs=envs, contract=self.contractName, func="constructor",  tx_type=TxType.NORMAL) 
            else:
                if len(funcNames) > 1:
                    return len(funcNames) > 1, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=postState, envs=envs, contract=self.contractName, func=list(funcNames)[0],  tx_type=TxType.NORMAL)
                elif len(funcNames) == 1:
                    return len(funcNames) > 1, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=postState, envs=envs, contract=self.contractName, func=list(funcNames)[0],  tx_type=TxType.NORMAL)
                else:
                    return len(funcNames) > 1, Transaction(tx_hash=tx_hash, pre_state=preState, post_state=postState, envs=envs, contract=self.contractName, func="", tx_type=TxType.NORMAL)
    
    def done(self):
        return self.myreader.done()
    
    def toStateJson(self, json_file):
        json.dump(asdict(self.modelReader.getModel()), open(json_file, "w"), indent=4)    
    
    def getABISpec(self):
        return self.myreader.abi
    
    def getDeclModel(self):
        return self.modelReader.getModel()


if __name__ == "__main__":
    TokenAddress = "0x1dac5649e2a0c943ffc4211d708f6ddde4742fd6"
    txreplayer = TransactionReplayer(contract_address=TokenAddress)
    while not txreplayer.done():
        firstOrMultiple, txObject = txreplayer.readPerTx()
        if not firstOrMultiple:
            print(txObject.tx_hash, txObject.func, txObject.tx_type)
    txreplayer.toStateJson(txreplayer.contractName+".json")

