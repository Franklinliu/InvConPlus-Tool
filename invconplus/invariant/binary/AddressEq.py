from invconplus.invariant.binary.AddressBinary import AddressBinary
from invconplus.const import INVARIANT_STYLE
class AddressEq(AddressBinary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    def _check(self, val_1, val_2):
        return val_1.strip().lower() == val_2.strip().lower()
    
    def __str__(self) -> str:
        if INVARIANT_STYLE == "VERISOL":
            if self.isPostCondition():
                desc = "VeriSol.Ensures({0} == {1})".format(self.varInfos[0].name, self.varInfos[1].name)
            else:
                desc = "VeriSol.Requires({0} == {1})".format(self.varInfos[0].name, self.varInfos[1].name)
            return desc
        elif INVARIANT_STYLE == "DAIKON":
            desc = "{0} == {1}".format(self.varInfos[0].name, self.varInfos[1].name)
            return desc
        else:
            desc = "AddressEq({0}, {1})".format(self.varInfos[0].name, self.varInfos[1].name)
            return desc