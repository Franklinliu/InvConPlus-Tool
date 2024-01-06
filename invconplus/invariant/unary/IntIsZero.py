from invconplus.derivation.unary.Original import Original
from invconplus.invariant.unary.Unary import VarInfo, List, Set
from invconplus.invariant.unary.IntUnary import IntUnary
from invconplus.const import INVARIANT_STYLE

class IntIsZero(IntUnary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        return (vars[0].type in  ["uint"+str(i*8) for i in range(1, 33)]) \
            or    (vars[0].type in  ["int"+str(i*8) for i in range(1, 33)])
            
    
    def _check(self, val):
        if val is None:
            val = 0
        return val == 0
    
    def __str__(self) -> str:
        if INVARIANT_STYLE == "VERISOL":
            if self.isPostCondition():
                desc = "VeriSol.Ensures({0} == 0)".format(self.varInfos[0].name)
            else:
                # if isinstance(self.varInfos[0].derivation, Original):
                #     desc = "VeriSol.Requires({0} == 0)".format(self.varInfos[0].derivation.varInfos[0].name)
                # else:
                    desc = "VeriSol.Requires({0} == 0)".format(self.varInfos[0].name)
            return desc    
        elif INVARIANT_STYLE == "DAIKON":
            desc = "{0} == 0".format(self.varInfos[0].name)
            return desc
        else:
            desc = "IntIsZero({0})".format(self.varInfos[0].name)
            return desc
    
