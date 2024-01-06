from invconplus.derivation.unary.Original import Original
from invconplus.invariant.unary.Unary import VarInfo, List, Set
from invconplus.invariant.unary.BoolUnary import BoolUnary
from invconplus.const import INVARIANT_STYLE

class BoolTrue(BoolUnary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    
    def _check(self, val):
        if val is None:
            val = False
        return val == True
    
    def __str__(self) -> str:
        if INVARIANT_STYLE == "VERISOL":
            if self.isPostCondition():
                desc = "VeriSol.Ensures({0} == true)".format(self.varInfos[0].name)
            else:
                # if isinstance(self.varInfos[0].derivation, Original):
                #     desc = "VeriSol.Requires({0} == true)".format(self.varInfos[0].derivation.varInfos[0].name)
                # else:
                    desc = "VeriSol.Requires({0} == true)".format(self.varInfos[0].name)
            return desc    
        elif INVARIANT_STYLE == "DAIKON":
            desc = "{0} == true".format(self.varInfos[0].name)
            return desc
        else:
            desc = "BoolTrue({0})".format(self.varInfos[0].name)
            return desc
    
