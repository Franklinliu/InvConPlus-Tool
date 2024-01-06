from invconplus.invariant.binary.Binary import Binary
from invconplus.model.model import VarInfo
from typing import List
class BoolBinary(Binary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        for var_ in vars:
            var_.type = str(var_.type)
        return (vars[0].type in  ["bool"] \
            and vars[1].type in  ["bool"])
          
    def handleNone(self, vals: List):
        _vals = []
        for val in vals:
            val = val if val is not None else 0
            if isinstance(val, str):
                if val.startswith("0x"):
                    val = int(val, base=16)
                    if val == 0:
                        val = False
                    else:
                        val = True
                else:
                    val = int(val)
                    if val == 0:
                        val = False
                    else:
                        val = True
            _vals.append(val)
        return super().handleNone(_vals) 
    
