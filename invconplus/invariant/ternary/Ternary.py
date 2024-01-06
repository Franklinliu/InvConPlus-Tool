from invconplus.invariant.Invariant import Invariant
from invconplus.model.model import VarInfo
from typing import List, Set
import math 
from invconplus.derivation.unary.Original import Original 

class Ternary(Invariant):
    num_samples: List
    pass_samples: List
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
        self.num_samples = list()
        self.pass_samples = list()
    
    @classmethod 
    def valid_vars_length(cls, vars: List[VarInfo]):
        return len(vars) == 3
    
    def check(self, vals: List):
        assert len(vals) == 3
        self._verified = True
        vals  = self.handleNone(vals)
        self.num_samples.append(vals)
        if self._check(vals[0], vals[1], vals[2]):
            self.pass_samples.append(vals)
            return True
        else:
            return False

    def handleNone(self, val):
        return val 
    
    def computeConfidence(self):
        return 1 
    
    def _check(self, val_1, val_2, val_3):
        return False 
    
    def isPreCondition(self):
        return (isinstance(self.varInfos[0].derivation, Original) or self.varInfos[0].isTxVar()) and (isinstance(self.varInfos[1].derivation, Original)  or self.varInfos[1].isTxVar()) and (isinstance(self.varInfos[2].derivation, Original)  or self.varInfos[2].isTxVar()) 
    
    def isPostCondition(self):
        return not self.isPreCondition()
    
    def sizeOfPassSamples(self):
        return len(self.pass_samples)
