import logging
from invconplus.model.model import dataclass, StateData, EnvData, ContractName, TxType, FuncName, VarInfo
from invconplus.derivation.Derivation import Derivation 
from invconplus.derivation.unary.Original import Original
from invconplus.derivation.unary.StructMember import StructMember 
from invconplus.derivation.binary.ArrayItem import ArrayItem 
from invconplus.derivation.binary.MappingItem import MappingItem
from invconplus.derivation.unary.MappingWildcard import MappingWildcard
from invconplus.derivation.unary.ArrayWildcard import ArrayWildcard
from invconplus.derivation.unary.IntSeqSum import IntSeqSum

from typing import Union

@dataclass
class Transaction:
    tx_hash: str 
    pre_state: StateData
    post_state: StateData
    envs: EnvData
    contract: ContractName
    func: FuncName
    tx_type: TxType
    def hasRevert(self):
        return self.tx_type == TxType.REVERSION
    
    def getValue(self, varInfo: VarInfo, is_ori=False):
        varName = varInfo.name
        if varInfo.isStateVar():
            if not varInfo.isDerived():
                if is_ori:
                    return self.pre_state.getVarValue(varInfo)
                else:
                    return self.post_state.getVarValue(varInfo)
            else:
                if isinstance(varInfo.derivation, Original):
                    return self.getValue(varInfo.derivation.varInfos[0], is_ori=True)
                elif isinstance(varInfo.derivation, StructMember):
                    structValue =  varInfo.derivation.getValue([self.getValue(varInfo.derivation.varInfos[0], is_ori)])  
                    if structValue is None:
                        return None 
                    for member in structValue:
                        if varInfo.derivation.varInfos[0].name + "." + member.varName == varInfo.name:
                            return member.varValue
                    assert False, "Cannot find member " + varInfo.name + " in struct " + str(structValue) 
                elif isinstance(varInfo.derivation, MappingWildcard):
                    wildcardValues =  varInfo.derivation.getValue([self.getValue(varInfo.derivation.varInfos[0], is_ori)])  
                    # TODO @assumption: varInfo.name cannot be "[...].xxx[...].aaa"
                    if varInfo.name.find("[...].")!=-1:
                        # member wildcards 
                        results =  []
                        for structValue in wildcardValues:
                            for member in structValue:
                                if varInfo.derivation.varInfos[0].name + "[...]." + member.varName == varInfo.name:
                                    if member.varValue is None:
                                        if member.varType in ["int"+str(i*8) for i in range(1, 33)] + ["uint"+str(i*8) for i in range(1, 33)] or member.varType.startswith("enum"):
                                            results.append(0)
                                        elif member.varType in ["address", "address_payable"]:
                                            results.append("0x"+"".join(["0"]*40))
                                        elif member.varType in ["bytes", "string"] or member.varType in ["bytes"+str(i*8) for i in range(1, 33)]:
                                            results.append("")
                                        elif member.varType in ["bool"]:
                                            results.append(False)
                                        else:
                                            logging.error("Unknown type %s", member.varType)
                                            assert False
                                    else:
                                        results.append(member.varValue)
                        return results 
                    else:
                        results = wildcardValues
                        return results
                elif isinstance(varInfo.derivation,  ArrayWildcard):
                    wildcardValues =  varInfo.derivation.getValue([self.getValue(varInfo.derivation.varInfos[0], is_ori)])  
                    # TODO @assumption: varInfo.name cannot be "[...].xxx[...].aaa"
                    if varInfo.name.find("[...].")!=-1:
                        # member wildcards 
                        results =  []
                        for structValue in wildcardValues:
                            for member in structValue:
                                if varInfo.derivation.varInfos[0].name + "[...]." + member.varName == varInfo.name:
                                    results.append(member.getValue())
                                    # if member.varValue is None:
                                    #     if member.varType in ["int"+str(i*8) for i in range(1, 33)] + ["uint"+str(i*8) for i in range(1, 33)] or member.varType.startswith("enum"):
                                    #         results.append(0)
                                    #     elif member.varType in ["address", "address_payable"]:
                                    #         results.append("0x"+"".join(["0"]*40))
                                    #     elif member.varType in ["bytes", "string"] or member.varType in ["bytes"+str(i*8) for i in range(1, 33)]:
                                    #         results.append("")
                                    #     else:
                                    #         assert False
                                    # else:
                                    #     results.append(member.varValue)
                        return results 
                    else:
                        results = wildcardValues
                        return results
                elif isinstance(varInfo.derivation, IntSeqSum):
                    return varInfo.derivation.getValue([self.getValue(varInfo.derivation.varInfos[0], is_ori=is_ori)])  
                elif isinstance(varInfo.derivation, ArrayItem):
                    return varInfo.derivation.getValue([self.getValue(varInfo.derivation.varInfos[0], is_ori=is_ori), self.getValue(varInfo.derivation.varInfos[1])])  
                elif isinstance(varInfo.derivation, MappingItem):
                    return varInfo.derivation.getValue([self.getValue(varInfo.derivation.varInfos[0], is_ori=is_ori), self.getValue(varInfo.derivation.varInfos[1])])  
                else:
                    assert False         
        else:
            for item in self.envs:
                if item["name"] ==  varName:
                    return item["value"].lower() if isinstance(item["value"], str) and item["value"].startswith("0x") else item["value"]
        logging.warning("Cannot find value for varInfo: " + str(varInfo))
        assert False
        
