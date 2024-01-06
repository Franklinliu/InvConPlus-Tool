from invconplus.invariant.unary.Unary import Unary
from invconplus.model.model import VarInfo
from typing import List, Set
import re 

array_pattern = re.compile("\[[0-9]*\]")
class IntUnary(Unary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        return (vars[0].type in  ["uint"+str(i*8) for i in range(1, 33)]) \
            or    (vars[0].type in  ["int"+str(i*8) for i in range(1, 33)]) \
            or (vars[0].type.startswith("enum") and array_pattern.search(vars[0].type) is None)
       
    def handleNone(self, val):
        val = val if val is not None else 0
        if isinstance(val, str):
            if val.startswith("0x"):
                val = int(val, base=16)
            else:
                val = int(val)
        return super().handleNone(val)
    
