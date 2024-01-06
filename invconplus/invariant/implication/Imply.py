from invconplus.invariant.Invariant import Invariant
from invconplus.model.model import VarInfo
from typing import List
from invconplus.derivation.unary.Original import Original 
from invconplus.invariant.binary.AddressEq import AddressEq

class Imply(Invariant):
    from_condition: Invariant
    to_condition: Invariant
    num_samples: List
    true_test: bool
    neg_test: bool
    def __init__(self, from_condition: Invariant, to_condition: Invariant) -> None:
        varInfos = from_condition.varInfos + to_condition.varInfos
        super().__init__(varInfos)
        self.num_samples = list()
        self.from_condition = from_condition
        self.to_condition = to_condition
        self.true_test = False
        self.neg_test = False
    
    @classmethod
    def valid_imply(cls, from_condition: Invariant, to_condition: Invariant):
        return False

    # do not need to check the length of vars 
    # we need to explicitly check the length of vars in the check function
    @classmethod 
    def valid_vars_length(cls, vars: List[VarInfo]):
        return False 
    
    @property 
    def verified(self):
        return (self.true_test and self.neg_test) and self.from_condition.verified and self.to_condition.verified

    def check(self, vals: List):
        assert len(vals) == len(self.varInfos), "vals length must be equal to varInfos length"
        vals  = self.handleNone(vals)
        self.num_samples.append(vals)
        return self._check(vals)

    def handleNone(self, vals):
        vals = self.from_condition.handleNone(vals[:len(self.from_condition.varInfos)]) + self.to_condition.handleNone(vals[len(self.from_condition.varInfos):])
        return vals 
    
    def computeConfidence(self):
        return 1 
    
    def _check(self, vals):
        if self.from_condition.check(vals[:len(self.from_condition.varInfos)]):
            self.true_test = True
            flag =  self.to_condition.check(vals[len(self.from_condition.varInfos):])
            return flag
        else:
            self.neg_test = True
            return True
    
    def isPreCondition(self):
        return self.from_condition.isPreCondition() and self.to_condition.isPreCondition()
    
    def isPostCondition(self):
        return not self.isPreCondition()