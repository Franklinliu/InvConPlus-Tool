from invconplus.derivation.Derivation import Derivation, List, VarInfo, DummyPptSliceType
from invconplus.model.model import ArrayVariableModel, VarType
import re 
from typing import Set 
import math 

array_pattern = re.compile("^(\w+)\[[0-9]*\]$")
class ArrayItem(Derivation):
    index_values: List
    def __init__(self, varInfos: List[VarInfo], ppt_slice: DummyPptSliceType) -> None:
        super().__init__(varInfos, ppt_slice)
        self.index_values = list()
    
    @classmethod 
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        for var_ in vars:
            if not isinstance(var_, VarInfo):
                return False
            if not isinstance(var_.type, str):
                var_.type =  str(var_.type)
        return len(vars) == 2 and vars[0].isStateVar() \
            and array_pattern.search(vars[0].type) is not None \
            and vars[1].type in ["int" + str(i) for i in range(8, 257, 8)] + ["uint" + str(i) for i in range(8, 257, 8)] 
        
    def derive(self) -> List:
        results: List[VarInfo] = list()
        arr: ArrayVariableModel = self.ppt_slice.getVarType(self.varInfos[0])
        results.append(VarInfo(name=self.varInfos[0].name +"["+self.varInfos[1].name+"]", type = arr.item_var_type.varType, vartype=VarType.STATEVAR, derivation=self))
        return results
    
    def getValue(self, vals: List):
        assert len(vals) == 2
        if vals[0] is None:
            return None 
        if vals[1] < len(vals[0]):
            if vals[1] not in self.index_values:
                self.index_values.append(vals[1])
            return vals[0][vals[1]].varValue
        else:
            return None
    
    def computeConfidence(self):
        return 1 
        # return 1 - math.pow(0.25, len(self.index_values))
    