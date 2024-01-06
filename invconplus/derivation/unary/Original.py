from invconplus.derivation.Derivation import Derivation, List, VarInfo, DummyPptSliceType
from invconplus.model.model import VarType, StructVariableModel, MappingVariableModel, ArrayVariableModel
from invconplus.derivation.unary.StructMember import StructMember
from invconplus.derivation.binary.ArrayItem import ArrayItem
from invconplus.derivation.binary.MappingItem import MappingItem 
from invconplus.const import INVARIANT_STYLE
import re 
class Original(Derivation):
    def __init__(self, varInfos: List[VarInfo],  ppt_slice: DummyPptSliceType) -> None:
        super().__init__(varInfos, ppt_slice)
    
    @classmethod 
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        for var_ in vars:
            if not isinstance(var_.type, str):
                var_.type =  str(var_.type)
        return len(vars) == 1 and vars[0].isStateVar() and not (vars[0].isDerived() and isinstance(vars[0].derivation, Original)) \
    and  ((vars[0].type in ["int"+str(i*8) for i in range(1, 33)] + ["uint"+str(i*8) for i in range(1, 33)] + ["address", "address_payable"] + ["bool", "bytes", "string"] + ["bytes"+str(i) for i in range(1, 33)]) or vars[0].type.startswith("enum"))

    def derive(self) -> List:
        results: List[VarInfo] = list()
        if INVARIANT_STYLE == "VERISOL":
            if self.varInfos[0].type in ["uint"+str(i*8) for i in range(1, 32)]:
                results.append(VarInfo(name="VeriSol.Old(uint256("+self.varInfos[0].name+"))", type=self.varInfos[0].type, vartype= VarType.STATEVAR, derivation=self))
            elif self.varInfos[0].type in ["int"+str(i*8) for i in range(1, 32)]:
                results.append(VarInfo(name="VeriSol.Old(int256("+self.varInfos[0].name+"))", type=self.varInfos[0].type, vartype= VarType.STATEVAR, derivation=self))
            else:
                if self.varInfos[0].type in ["address", "address_payable"]:
                    results.append(VarInfo(name="VeriSol.Old(address("+self.varInfos[0].name+"))", type=self.varInfos[0].type, vartype= VarType.STATEVAR, derivation=self))
                else:
                    results.append(VarInfo(name="VeriSol.Old("+self.varInfos[0].name+")", type=self.varInfos[0].type, vartype= VarType.STATEVAR, derivation=self))
        else:
            results.append(VarInfo(name="ori("+self.varInfos[0].name+")", type=self.varInfos[0].type, vartype= VarType.STATEVAR, derivation=self))
        return results
    
    def getValue(self, vals: List):
        assert len(vals) == 1
        return vals[0]
    
    @classmethod
    def createDerivedVarInfos(cls, varInfo: VarInfo, ppt_slice: DummyPptSliceType):
        results = []
        assert isinstance(varInfo, VarInfo)
        if not varInfo.isDerived():
            if Original.valid_vars([varInfo]):
                return [varInfo] + Original(varInfos=[varInfo], ppt_slice=ppt_slice).derive()
            else:
                if varInfo.isTxVar() or varInfo.isStateVar():
                    return [varInfo]
                else:
                    return []
        else:
            _results = []
            if isinstance(varInfo.derivation, MappingItem):
                base =  varInfo.derivation.varInfos[0]
                index = varInfo.derivation.varInfos[1]
                if index.isStateVar() or index.isTxVar():
                    index_vars = Original.createDerivedVarInfos(index, ppt_slice=ppt_slice)
                    for index_var in index_vars:
                        assert MappingItem.valid_vars([base, index_var])
                        _results.extend(MappingItem([base, index_var], ppt_slice=ppt_slice).derive()) 
                else:
                    return []
            elif isinstance(varInfo.derivation, ArrayItem):
                base =  varInfo.derivation.varInfos[0]
                index = varInfo.derivation.varInfos[1]
                if index.isStateVar() or index.isTxVar():
                    index_vars = Original.createDerivedVarInfos(index, ppt_slice=ppt_slice)
                    for index_var in index_vars:
                        assert ArrayItem.valid_vars([base, index_var]), "base: " + str(base) + " index_var: " + str(index_var)
                        _results.extend(ArrayItem([base, index_var], ppt_slice=ppt_slice).derive())
                else:
                    return []
            elif isinstance(varInfo.derivation, StructMember):
                if varInfo.isStateVar() or varInfo.isTxVar():
                    structs = Original.createDerivedVarInfos(varInfo.derivation.varInfos[0], ppt_slice = ppt_slice)
                    for struct in structs:
                        _results.append(VarInfo(name=struct.name + "." + varInfo.name.split(".")[-1], type=varInfo.type, vartype=varInfo.vartype, derivation=StructMember([struct], ppt_slice=ppt_slice))) 
                else:
                    return []
            elif isinstance(varInfo.derivation, Original):
                if varInfo.isStateVar() or varInfo.isTxVar():
                    return [varInfo]
                else:
                    return []
            else:
                assert False, "Unsupported derivation type" + varInfo

            for var_info in _results:
                results.append(var_info)
                if Original.valid_vars([var_info]):
                    results.extend(Original([var_info], ppt_slice=ppt_slice).derive())
        return results



        