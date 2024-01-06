from invconplus.invariant.binary.Binary import Binary
from invconplus.model.model import VarInfo
from typing import List
class IntBinary(Binary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        for var_ in vars:
            var_.type = str(var_.type)
        return (vars[0].type in  ["uint"+str(i*8) for i in range(1, 33)] \
            and vars[1].type in  ["uint"+str(i*8) for i in range(1, 33)])\
            or    (vars[0].type in  ["int"+str(i*8) for i in range(1, 33)] \
            and vars[1].type in  ["int"+str(i*8) for i in range(1, 33)])

    def handleNone(self, vals: List):
        _vals = []
        for val in vals:
            val = val if val is not None else 0
            if isinstance(val, str):
                if val.startswith("0x"):
                    val = int(val, base=16)
                else:
                    val = int(val)
            _vals.append(val)
        return super().handleNone(_vals) 
    
