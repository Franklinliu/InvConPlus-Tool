from invconplus.invariant.unary.Unary import VarInfo, List, Set
from invconplus.invariant.unary.IntUnary import IntUnary 
from invconplus.const import INVARIANT_STYLE

class IntRange(IntUnary):
    values: Set  
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
        self.values = set()     
    
    def _check(self, val):
        self.values.add(val)
        return True 

    def __str__(self) -> str:
        if INVARIANT_STYLE == "VERISOL":
            return ""
        desc = "IntRange({0})".format(self.varInfos[0].name)
        return desc