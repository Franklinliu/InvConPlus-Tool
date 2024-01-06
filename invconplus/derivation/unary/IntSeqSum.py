from invconplus.derivation.Derivation import Derivation, List, VarInfo, DummyPptSliceType
from invconplus.model.model import VariableModel, StructVariableModel, MappingVariableModel, VarType
from typing import List
import re 
from invconplus.const import INVARIANT_STYLE

array_pattern = re.compile("^(\w+)\[[0-9]*\]$")
class IntSeqSum(Derivation):
    def __init__(self, varInfos: List[VarInfo],ppt_slice: DummyPptSliceType) -> None:
        super().__init__(varInfos, ppt_slice)
    
    @classmethod 
    def _valid_vars(cls, vars: List[VarInfo]) -> bool:
        if len(vars) != 1:
            return False 
        if not vars[0].isStateVar():
            return False 
        for var_ in vars:
            if not isinstance(var_.type, str):
                var_.type =  str(var_.type)
        m_1 = array_pattern.findall(vars[0].type)
        if len(m_1) == 0:
            return False 
        else:
            ele_ty = m_1[0]
            return ele_ty in ["uint"+str(i*8) for i in range(1, 33)]+["int"+str(i*8) for i in range(1, 33)] and vars[0].name.endswith("[...]")

    def derive(self) -> List:
        results: List[VarInfo] = list()
        m_1 = array_pattern.findall(self.varInfos[0].type)
        ele_ty = m_1[0]
        if INVARIANT_STYLE == "VERISOL":
            # TODO: some cases may not be sum over mapping variable
            results.append(VarInfo(name="VeriSol.SumMapping("+self.varInfos[0].name.replace("[...]", "") +")", type = ele_ty, vartype=VarType.STATEVAR, derivation=self))
        else:
            results.append(VarInfo(name="Sum("+self.varInfos[0].name +")", type = ele_ty, vartype=VarType.STATEVAR, derivation=self))
        return results
    
    def getValue(self, vals: List):  
        assert len(vals) == 1
        if len(vals[0]) == 0:
            return 0
        else:
            return sum(vals[0]) 
        
    def computeConfidence(self):
        return 1 
    

        