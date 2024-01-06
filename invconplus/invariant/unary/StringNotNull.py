from invconplus.derivation.unary.Original import Original
from invconplus.invariant.unary.Unary import Unary, VarInfo, List
from invconplus.const import INVARIANT_STYLE
import re 
bytes_pattern = re.compile("bytes[0-9]*")
class StringNotNull(Unary):
    def __init__(self, varInfos) -> None:
        Unary.__init__(self, varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        return bytes_pattern.match(vars[0].type) is not None

    def handleNone(self, val):
        val = val if val is not None else ""
        return super().handleNone(val)
    
    def _check(self, val):
        return val != ""
    
    def __str__(self) -> str:
        if INVARIANT_STYLE == "VERISOL":
            if self.isPostCondition():
                desc = "VeriSol.Ensures({0} != '')".format(self.varInfos[0].name)
            else:
                # if isinstance(self.varInfos[0].derivation, Original):
                #     desc = "VeriSol.Requires({0} != '')".format(self.varInfos[0].derivation.varInfos[0].name)
                # else:
                    desc = "VeriSol.Requires({0} != '')".format(self.varInfos[0].name)
            return desc
        elif INVARIANT_STYLE == "DAIKON":
            desc = "{0} != \"\"".format(self.varInfos[0].name)
            return desc
        else:
            desc = "StringNotNull({0})".format(self.varInfos[0].name)
            return desc