from invconplus.derivation.Derivation import Derivation, List, VarInfo, DummyPptSliceType
from invconplus.model.model import StructVariableModel, VarType

class StructMember(Derivation):
    def __init__(self, varInfos: List[VarInfo],  ppt_slice: DummyPptSliceType) -> None:
        super().__init__(varInfos, ppt_slice)
    
    @classmethod 
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        for var_ in vars:
            if not isinstance(var_.type, str):
                var_.type =  str(var_.type)
        return len(vars) == 1 and vars[0].isStateVar() and vars[0].isStruct()

    def derive(self) -> List:
        results: List[VarInfo] = list()
        struct: StructVariableModel = self.ppt_slice.getVarType(self.varInfos[0])
        for mem in struct.members():
            results.append(VarInfo(name=self.varInfos[0].name + "." + mem.varName, type=mem.varType, vartype= VarType.STATEVAR, derivation=self))
        return results
    
    def getValue(self, vals: List):
        assert len(vals) == 1
        return vals[0]
    
    def computeConfidence(self):
        if self.varInfos[0].isDerived():
            return self.varInfos[0].derivation.computeConfidence()
        else:
            return 1
    
        