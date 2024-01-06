from invconplus.invariant.unary.Unary import VarInfo, List, Set
from invconplus.invariant.unary.IntSeqUnary import IntSeqUnary 
from invconplus.const import INVARIANT_STYLE

class IntSeqItemRange(IntSeqUnary):
    values: Set  
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
        self.values = set()     
    
    def _check(self, val):
        self.values.update(val)
        return True 

    def __str__(self) -> str:
        # FIXME: 
        if INVARIANT_STYLE == "VERISOL":
            return ""
        desc = "IntSeqItemRange({0})".format(self.varInfos[0].name)
        return desc