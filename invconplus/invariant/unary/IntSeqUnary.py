from invconplus.invariant.unary.Unary import Unary
from invconplus.model.model import VarInfo
from typing import List
import re 

# need to capture enum xxx.[]
array_pattern1 = re.compile("^(\w+)\[[0-9]*\]$")
array_pattern2 = re.compile("^enum(.*)\[[0-9]*\]$")
class IntSeqUnary(Unary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        return vars[0].name.endswith("[...]") and (( array_pattern1.search(vars[0].type) is not None \
                 and 
                 any(map(lambda intty: vars[0].type.find(intty)!=-1, 
                 ["uint"+str(i*8) for i in range(1, 33)]+["int"+str(i*8) for i in range(1, 33)]))
                ) \
                or ( \
                    array_pattern2.search(vars[0].type) is not None 
                    and 
                    vars[0].type.startswith("enum")
                ))
       
    def handleNone(self, val):
        val = val if val is not None else []
        return super().handleNone(val)