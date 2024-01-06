from invconplus.derivation.Derivation import Derivation, List, VarInfo, DummyPptSliceType 
from invconplus.model.model import VariableModel, StructVariableModel, MappingVariableModel, VarType
from invconplus.derivation.unary.StructMember import StructMember 
import re 
from typing import Set,Union 
import math 

mapping_pattern_1 = re.compile("^mapping\(\s*(\w*)\s*=>\s*(.*)\)$")
mapping_pattern_2 = re.compile("^mapping\(\s*(\w*)\s*,\s*(.*)\)$")
class MappingWildcard(Derivation):
    def __init__(self, varInfos: List[VarInfo],ppt_slice: DummyPptSliceType) -> None:
        super().__init__(varInfos, ppt_slice)
    
    @classmethod 
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        if not (len(vars) == 1):
            return False
        if not vars[0].isStateVar():
            return False
        for var_ in vars:
            if not isinstance(var_.type, str):
                var_.type =  str(var_.type)

        m_1 = mapping_pattern_1.findall(vars[0].type)
        m_2 = mapping_pattern_2.findall(vars[0].type)
        if len(m_1) ==0 and len(m_2) == 0:
            return False 
        else:
            return True
        
    def derive(self) -> List:
        results: List[VarInfo] = list()
        mp: MappingVariableModel = self.ppt_slice.getVarType(self.varInfos[0])
        if StructMember.valid_vars([VarInfo(name = "", type = mp.val_var_type.varType,vartype= VarType.STATEVAR, derivation=None)]):
            for mem in mp.val_var_type.varValue:
                results.append(VarInfo(name=self.varInfos[0].name +"[...]."+mem.varName, type = mem.varType+"[]", vartype=VarType.STATEVAR, derivation=self))
        else:
            results.append(VarInfo(name=self.varInfos[0].name +"[...]", type = mp.val_var_type.varType+"[]", vartype=VarType.STATEVAR, derivation=self))
        return results
    
    def getValue(self, vals: List):
        assert len(vals) == 1
        if vals[0] is None:
            return [] 
        if isinstance(vals[0], list):
            return self._getValue(vals=vals[0])
        else:
            return self._getValue(vals=[vals[0]])
    
    def _getValue(self, vals: List):
        # ensure one-dimensional array
        results = []
        for val in vals:
            for key_item in val:
                results.append(val[key_item].varValue)
        return results
        
    def computeConfidence(self):
        return 1 
    

        