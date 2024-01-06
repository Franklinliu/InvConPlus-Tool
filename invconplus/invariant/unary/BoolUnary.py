from invconplus.invariant.unary.Unary import Unary
from invconplus.model.model import VarInfo
from typing import List, Set
import re 

array_pattern = re.compile("\[[0-9]*\]")
class BoolUnary(Unary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        return (vars[0].type in  ["bool"]) and array_pattern.search(vars[0].type) is None
       
    def handleNone(self, val):
        val = val if val is not None else 0
        return super().handleNone(val)
    
