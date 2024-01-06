from invconplus.model.model import VarInfo
from typing import List
from invconplus.const import  INVARIANT_STYLE
class Invariant:
    _verified: bool
    varInfos: List[VarInfo]
    useless: bool
    falsify: bool
    def __init__(self, varInfos: List[VarInfo]) -> None:
        self.varInfos = varInfos 
        self._verified = False
        self.useless = False
        self.falsify = False
    
    def setUseless(self):
        self.useless = True

    @property
    def verified(self):
        return self._verified

    @classmethod 
    def valid_vars(cls, vars: List[VarInfo]):
        return cls.valid_vars_length(vars) and cls.valid_vars_type(vars)
    
    @classmethod 
    def valid_vars_length(cls, vars: List[VarInfo]):
        return True
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        return False
    
    @classmethod 
    def instantiate(cls, vars):
        return cls(vars)
    
    def check(self, vals: List):
        return False 
    
    def computeConfidence(self):
        return 1 

    def finalize(self):
        if self.computeConfidence() <= 0.999:
            self.falsify = True
        else:
            self.falsify = False
        # self.falsify = False

    def __str__(self) -> str:
        return ""

    def isPreCondition(self) -> str:
        return False
    
    def isPostCondition(self) -> str:
        return False  
    
    def __eq__(self, inv):
        return type(self) == type(inv) and self.varInfos == inv.varInfos and self.verified == inv.verified and self.falsify == inv.falsify