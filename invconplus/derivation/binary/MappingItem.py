from invconplus.derivation.Derivation import Derivation, List, VarInfo, DummyPptSliceType 
from invconplus.model.model import MappingVariableModel, VarType
import re 
from typing import Set 
import math 

mapping_pattern_1 = re.compile("^mapping\(\s*(\w*)\s*=>\s*(.*)\)$")
mapping_pattern_2 = re.compile("^mapping\(\s*(\w*)\s*,\s*(.*)\)$")
class MappingItem(Derivation):
    key_values: Set
    def __init__(self, varInfos: List[VarInfo],ppt_slice: DummyPptSliceType) -> None:
        super().__init__(varInfos, ppt_slice)
        self.key_values = set()
    
    @classmethod 
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        if not (len(vars) == 2):
            return False

        if not vars[0].isStateVar():
            return False
        
        for var_ in vars:
            if not isinstance(var_.type, str):
                var_.type =  str(var_.type)

        m_1 = mapping_pattern_1.findall(vars[0].type)
        m_2 = mapping_pattern_2.findall(vars[0].type)
        if len(m_1) == 0 and len(m_2) == 0:
            return False 
        
        keytype =  None 
        if len(m_1)>0:
            keytype = m_1[0][0]
        else:
            keytype =  m_2[0][0]
        if vars[1].type in  (["uint"+str(i*8) for i in range(1, 33)]) and keytype in  (["uint"+str(i*8) for i in range(1, 33)]):
            size1 = int(vars[1].type.split("uint")[-1].strip())
            size2 = int(keytype.split("uint")[-1].strip())
            return size1 <= size2 

        return str(vars[1].type) == keytype
        
    def derive(self) -> List:
        results: List[VarInfo] = list()
        mp: MappingVariableModel = self.ppt_slice.getVarType(self.varInfos[0])
        results.append(VarInfo(name=self.varInfos[0].name +"["+self.varInfos[1].name+"]", type = mp.val_var_type.varType, vartype=VarType.STATEVAR, derivation=self))
        return results
    
    def getValue(self, vals: List):
        assert len(vals) == 2
        if vals[0] is None:
            return None 
        if vals[1] in vals[0]:
            self.key_values.add(vals[1])
            return vals[0][vals[1]].varValue
        else:
            return None
        
    def computeConfidence(self):
        # return 1 - math.pow(0.25, len(self.key_values))
        return 1 
    

        