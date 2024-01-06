from invconplus.invariant.Invariant import Invariant
from invconplus.model.model import VarInfo
from typing import List, Set
import math 
from invconplus.derivation.unary.Original import Original 

class Unary(Invariant):
    num_samples: List
    pass_samples: List
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
        self.num_samples = list()
        self.pass_samples = list()
    
    @classmethod 
    def valid_vars_length(cls, vars: List[VarInfo]):
        return len(vars) == 1
    
    def check(self, vals: List):
        assert len(vals) == 1
        self._verified = True
        val  = self.handleNone(vals[0])
        self.num_samples.append(val)
        if self._check(val):
            self.pass_samples.append(val)
            return True
        else:
            return False

    def handleNone(self, val):
        return val 
    
    def computeConfidence(self):
        # if self.varInfos[0].isDerived():
        #     return (1 - math.pow(0.5, len(self.num_samples))) * self.varInfos[0].derivation.computeConfidence()
        # else:
        #     return 1 - math.pow(0.5, len(self.num_samples))
        return 1 
    
    def _check(self, val):
        return False 
    
    def isPreCondition(self):
        return self.varInfos[0].isTxVar() or isinstance(self.varInfos[0].derivation, Original)
    
    def isPostCondition(self):
        return not self.isPreCondition()
    
    def sizeOfPassSamples(self):
        return len(self.pass_samples)