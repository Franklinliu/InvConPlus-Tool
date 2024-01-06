from invconplus.invariant.binary.Binary import Binary
from invconplus.model.model import VarInfo
from typing import List

class AddressBinary(Binary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)
    
    @classmethod 
    def valid_vars_type(cls, vars: List[VarInfo]):
        for var_ in vars:
            var_.type = str(var_.type)
        return vars[0].type in  ["address", "address_payable"] and vars[1].type in  ["address", "address_payable"]
    
    def handleNone(self, vals: List):
        _vals = []
        for val in vals:
            _vals.append(val.lower() if val is not None else "0x"+"".join(["0"]*40))
        return super().handleNone(_vals) 