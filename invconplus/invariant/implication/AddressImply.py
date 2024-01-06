from invconplus.invariant.Invariant import Invariant
from invconplus.model.model import VarInfo
from typing import List
from invconplus.invariant.binary.AddressBinary import AddressBinary
from invconplus.invariant.implication.Imply import Imply
from invconplus.const import INVARIANT_STYLE

class AddressImply(Imply):
    def __init__(self, from_condition: Invariant, to_condition: Invariant) -> None:
        assert isinstance(from_condition, AddressBinary), "from_condition must be AddressBinary"
        super().__init__(from_condition, to_condition)
    
    
    @classmethod
    def valid_imply(cls, from_condition: Invariant, to_condition: Invariant):
        return isinstance(from_condition, AddressBinary) and \
            from_condition.isPreCondition() and to_condition.isPostCondition() 

    def __str__(self) -> str:
        
        if INVARIANT_STYLE == "VERISOL":
            assert self.isPostCondition(), "AddressImply must be post condition"
            from_condition_str = self.from_condition.__str__().replace("VeriSol.Requires", "")
            to_condition_str = self.to_condition.__str__().replace("VeriSol.Ensures", "")
            if from_condition_str == "" or to_condition_str == "":
                return ""
            # p ==> q <==>  !p || q
            desc = "VeriSol.Ensures(!{0} || {1})".format(from_condition_str, to_condition_str)
            # desc = "VeriSol.Ensures({0} ==> {1})".format(from_condition_str, to_condition_str)
            return desc
        elif INVARIANT_STYLE == "DAIKON":
            from_condition_str = self.from_condition.__str__()
            to_condition_str = self.to_condition.__str__()
            desc = "{0} ==> {1}".format(from_condition_str, to_condition_str)
            return desc
        else:
            from_condition_str = self.from_condition.__str__()
            to_condition_str = self.to_condition.__str__()
            desc = "AddressImply({0}, {1})".format(from_condition_str, to_condition_str)
            return desc
    
        
    def __eq__(self, inv):
        return type(self) == type(inv) and type(self.from_condition) == type(inv.from_condition) and type(self.to_condition) == type(inv.to_condition) and self.varInfos == inv.varInfos and self.verified == inv.verified and self.falsify == inv.falsify