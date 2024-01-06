from invconplus.derivation.Derivation import Derivation, List, VarInfo, DummyPptSliceType 
from invconplus.model.model import VariableModel, StructVariableModel, ArrayVariableModel, VarType
from invconplus.derivation.unary.StructMember import StructMember 
import re 
from typing import Set,Union 
import math 

array_pattern = re.compile("^(\w+)\[[0-9]*\]$")
class ArrayWildcard(Derivation):
    def __init__(self, varInfos: List[VarInfo],ppt_slice: DummyPptSliceType) -> None:
        super().__init__(varInfos, ppt_slice)
    
    @classmethod 
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        for var_ in vars:
            if not isinstance(var_.type, str):
                var_.type =  str(var_.type)
        return len(vars) == 1 and vars[0].isStateVar() \
            and array_pattern.search(vars[0].type) is not None \
            and vars[0].type in ["uint"+str(i*8) for i in range(1, 33)]+["int"+str(i*8) for i in range(1, 33)] + ["bool", "address", "address payable" ] 
        
        
    def derive(self) -> List:
        results: List[VarInfo] = list()
        arr: ArrayVariableModel = self.ppt_slice.getVarType(self.varInfos[0])
        if StructMember.valid_vars([VarInfo(name = "", type = arr.item_var_type.varType ,vartype= VarType.STATEVAR, derivation=None)]):
            for mem in arr.item_var_type.varValue:
                results.append(VarInfo(name=self.varInfos[0].name +"[...]."+mem.varName, type = mem.varType+"[]", vartype=VarType.STATEVAR, derivation=self))
        else:
            results.append(VarInfo(name=self.varInfos[0].name +"[...]", type = arr.item_var_type.varType+"[]", vartype=VarType.STATEVAR, derivation=self))
        return results
    
    def getValue(self, vals: List):
        assert len(vals) == 1
        if vals[0] is None:
            return [] 
        assert isinstance(vals[0], list)
       
        # parse first [....] -> [{}, {}, ...,{}, {}]
        # [{}, {}, ...,{}, {}]

        if len(vals[0])>0 and isinstance(vals[0][0], list):
            # [...].a[...]
            #  vals=[[[], [], ..., []]]
            return self._getValue(vals=vals[0])
        else:
            # [...]
            # vals = [[]]
            return self._getValue(vals=[vals[0]])
    
    def _getValue(self, vals: List):
        # ensure one-dimensional array
        results = []
        for val in vals:
            for item in val:
                results.append(item.varValue)
        return results
        
    def computeConfidence(self):
        return 1 
    

        