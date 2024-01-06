from invconplus.invariant.unary.Unary import VarInfo, List, Set
from invconplus.invariant.unary.IntSeqUnary import IntSeqUnary 
from invconplus.const import INVARIANT_STYLE

class IntSeqConstSum(IntSeqUnary):
    sums: Set
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
        self.sums = set()
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        return not vars[0].type.startswith("enum") and super().valid_vars_type(vars) and vars[0].name.endswith("[...]")

    def _check(self, val: List):
        self.sums.add(sum(val))
        return True 
    
    def computeConfidence(self):
        return len(self.sums) == 1 
    
    def __str__(self) -> str:
        if INVARIANT_STYLE == "VERISOL":
            return ""
        elif INVARIANT_STYLE == "DAIKON":
            desc = "elem of {0} is one of [{1}]".format(self.varInfos[0].name, list(self.sums)[0])
            return desc
        else:
            desc = "IntSeqSumEqConst({0}, {1})".format(self.varInfos[0].name, list(self.sums)[0])
            return desc