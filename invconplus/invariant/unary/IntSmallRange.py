from invconplus.invariant.unary.IntRange import IntRange
from invconplus.const import INVARIANT_STYLE
class IntSmallRange(IntRange):
    def __init__(self, varInfos) -> None:
        IntRange.__init__(self, varInfos)
     
    def computeConfidence(self):
        return 1 < len(self.values) < 10
    
    def _check(self, val):
        if len(self.values) < 10:
            return super()._check(val)
        else:
            return False
    
    @property
    def constVals(self):
        return self.values
    
    def __str__(self) -> str:
        if INVARIANT_STYLE == "VERISOL":
            return ""
        elif INVARIANT_STYLE == "DAIKON":
            desc = "{0} one of [{1}]".format(self.varInfos[0].name, ",".join(map(str, self.values)))
            return desc
        else:
            desc = "IntSmallRange({0}, [{1}])".format(self.varInfos[0].name, ",".join(map(str, self.values)))
            return desc