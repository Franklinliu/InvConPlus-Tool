from invconplus.model.model import VarInfo
from typing import List, Any

class DummyPptSliceType:
    def getVarType(self, varInfo):
        pass 

class Derivation:
    useless: bool
    varInfos: List[VarInfo]
    ppt_slice: DummyPptSliceType 
    def __init__(self, varInfos: List[VarInfo], ppt_slice: DummyPptSliceType) -> None:
        self.varInfos =  varInfos 
        self.ppt_slice = ppt_slice
        self.useless = False
    
    def setUseless(self):
        self.useless = True
    
    @classmethod
    def valid_vars(cls, vars: List[VarInfo]):
        return cls._valid_vars(vars) 
    
    @classmethod
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        return False 
    
    @classmethod
    def instantiate(cls, vars: List[VarInfo], ppt_slice: Any):
        assert cls.valid_vars(vars)
        return cls(vars, ppt_slice)

    def derive(self) -> List[VarInfo]:
        return None 

    def getValue(self, vals: List) -> Any:
        pass 

    def computeConfidence(self):
        return 1
    