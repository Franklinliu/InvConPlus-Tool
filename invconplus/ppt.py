import logging
import copy 
from invconplus.model.model import VariableModel, TxType, FuncName, ContractName, VarInfo
from invconplus.model.Tx import Transaction
from enum import Enum
from typing import Any, Dict, List, NewType 
from itertools import combinations, permutations, chain


from invconplus.derivation.Derivation import Derivation 
from invconplus.derivation.unary.Original import Original 
from invconplus.derivation.unary.StructMember import StructMember 
from invconplus.derivation.binary.ArrayItem import ArrayItem 
from invconplus.derivation.binary.MappingItem import MappingItem
from invconplus.derivation.unary.MappingWildcard import MappingWildcard
from invconplus.derivation.unary.ArrayWildcard import ArrayWildcard
from invconplus.derivation.unary.IntSeqSum import IntSeqSum

from invconplus.invariant import Invariant, IntInc, IntDec, IntEq, IntGe, IntGt, IntLe, IntLt, IntNotEq, AddressEq, AddressNotEq, AddressIsZero, AddressNotZero, BoolEq, BoolNotEq, BoolTrue, BoolFalse,  StringNotNull, StringIsNull, IntIsZero, IntGtZero,  IntConstRange, IntSmallRange, IntSeqConstSum, IntSeqItemSmallRange, LinearyEq, AddressImply

from invconplus.suppressor import Supressor
from invconplus.const import ALLOW_FASIFY_INV

CompleteDerivations: List[Derivation] = [
   Original, IntSeqSum,  MappingWildcard, StructMember, ArrayItem, MappingItem
]

CompleteInvaraints: List[Invariant] = [
 IntInc, IntDec, IntEq, IntGe, IntGt, IntLe, IntLt, IntNotEq, 
 AddressEq, AddressNotEq, AddressIsZero, AddressNotZero, 
 BoolEq, BoolNotEq, BoolTrue, BoolFalse,
 StringNotNull, StringIsNull, IntIsZero, IntGtZero, 
 IntConstRange, IntSmallRange, 
 IntSeqConstSum,
 IntSeqItemSmallRange,
 LinearyEq
]
Variable = NewType("variable", VarInfo)

class PptType(Enum):
    CONTRACT = 0 # for contract-level invariants
    OBJECT =  1 # for object-level invaraints, e.g., invaraints about structure, mapping, and etc.
    ENTER = 2 # for function-elvel preconditions, the point entering function; only one enter point per function
    EXIT = 3 # for function-elvel post-conditions, the point leaving function; could be many exit points per function

class Ppt:
    vars: List[Variable]
    engine: Any
    def __init__(self, vars: List[Variable]) -> None:
        self.vars = vars 
    
    def register_engine(self, engine: Any):
        self.engine = engine
    
    def __str__(self) -> str:
        vars_desc = ", ".join([item.name for item in self.vars])
        return "[vars: {0}]".format(vars_desc)
    
class PptTopLevel(Ppt):
    contract: ContractName
    func: FuncName
    type: PptType
    executionType: TxType
    all_slices: List
    suppressor: Supressor
    def __init__(self, contract: ContractName, func: FuncName,  type: PptType, executionType: TxType, vars: List[Variable]) -> None:
        super().__init__(vars)
        self.contract = contract
        self.func =  func  
        self.type = type 
        self.executionType = executionType
        self.all_slices :List[PptSlice] =  list()

    def getVarType(self, varInfo: VarInfo):
        return self.engine.getVarType(self.func, varInfo)
    
    def checkTypeConsistent(self, varInfo1, varInfo2):
        return self.engine.checkTypeConsistent(self.func, varInfo1, varInfo2)

    def load(self, tx: Transaction):
        if not self.is_valid(tx):
            return 
        else:
            myvars = [
               myslice.vars for myslice in self.all_slices
            ]
            all_vars = list(set(chain(*myvars)))
            all_values =  list()
            for _var in all_vars:
                all_values.append(tx.getValue(_var))
            for slice in self.all_slices:
                # vals = [ tx.getValue(_var) for _var in slice.vars]  
                vals = [ all_values[all_vars.index(_var)] for _var in slice.vars]  
                slice.addValues(vals=vals)
    
    def loadSliceEvent(self, tx: Transaction, slice_states: List[Dict]):
        if not self.is_valid(tx):
            return 
        else:
            for myslice in self.all_slices:
                vals =  []
                for _var in myslice.vars:
                    if _var.name in [ item["name"] for item in slice_states]:
                        slice_state = list(filter(lambda item: item["name"] == _var.name, slice_states))[0]["value"]
                        vals.append(slice_state)
                    else:
                        vals.append(tx.getValue(_var)) 
                myslice.addValues(vals=vals)

    def is_valid(self, tx:Transaction):
        assert tx.contract ==  self.contract
        if self.type in [PptType.ENTER, PptType.EXIT]:
            # if tx.func == self.func:
            if self.func.find(tx.func)!=-1:
                if tx.tx_type == self.executionType:
                    return True 
            return False 
        else:
            return True 
        
    def addCustomizedVarInfos(self, varInfos: List[VarInfo]):
        self.vars.extend(varInfos)

    def create_derived_variables(self):
        logging.debug("create_derived_variables...")
        perm_1 = permutations(range(len(self.vars)), 1) 
        for item in perm_1:
            for derivation in [ArrayWildcard, MappingWildcard]:
                if derivation.valid_vars(vars=[self.vars[i] for i in item]):
                    instance = derivation.instantiate(vars=[self.vars[i] for i in item], ppt_slice=self)
                    derived_vars = instance.derive()
                    self.vars.extend(derived_vars)
        perm_1 = permutations(range(len(self.vars)), 1) 
        for item in perm_1:
            for derivation in [IntSeqSum]:
                if derivation.valid_vars(vars=[self.vars[i] for i in item]):
                    instance = derivation.instantiate(vars=[self.vars[i] for i in item], ppt_slice=self)
                    derived_vars = instance.derive()
                    self.vars.extend(derived_vars)
        perm_1 = permutations(range(len(self.vars)), 1)
        for item in perm_1:
            for derivation in [Original]:
                if derivation.valid_vars(vars=[self.vars[i] for i in item]):
                    instance = derivation.instantiate(vars=[self.vars[i] for i in item], ppt_slice=self)
                    derived_vars = instance.derive()
                    self.vars.extend(derived_vars)
        pass 
        # perm_2 = permutations(range(len(self.vars)), 2) 
        # for item in perm_2:
        #     for derivation in CompleteDerivations:
        #         if derivation.valid_vars(vars=[self.vars[i] for i in item]):
        #             instance = derivation.instantiate(vars=[self.vars[i] for i in item], ppt_slice=self)
        #             derived_vars = instance.derive()
        #             self.vars.extend(derived_vars)
        
        # perm_1 = permutations(range(len(self.vars)), 1) 
        # for item in perm_1:
        #     for derivation in CompleteDerivations:
        #         if derivation.valid_vars(vars=[self.vars[i] for i in item]):
        #             instance = derivation.instantiate(vars=[self.vars[i] for i in item], ppt_slice=self)
        #             derived_vars = instance.derive()
        #             self.vars.extend(derived_vars)
        
        # perm_1 = permutations(range(len(self.vars)), 1) 
        # for item in perm_1:
        #     for derivation in [Original]:
        #         if derivation.valid_vars(vars=[self.vars[i] for i in item]):
        #             instance = derivation.instantiate(vars=[self.vars[i] for i in item], ppt_slice=self)
        #             derived_vars = instance.derive()
        #             self.vars.extend(derived_vars)

    def createSlices(self):
        self.vars = list(set(self.vars))
        com_1 =  combinations(range(len(self.vars)), 1)
        for item in com_1:
            self.all_slices.append(self.get_or_instantiate_slice(vars=[self.vars[i] for i in item]))
        
        com_2 =  combinations(range(len(self.vars)), 2)
        for item in com_2:
            # if self.checkTypeConsistent(self.vars[item[0]], self.vars[item[1]]):
            self.all_slices.append(self.get_or_instantiate_slice(vars=[self.vars[i] for i in item]))
        
        com_3 =  combinations(range(len(self.vars)), 3)
        # print("com_3", len(com_3))
        # print(self.vars)
        for item in com_3:
            # check only case such as Old(A) + A + C = 0
            has_mappingItem = any([self.vars[i].derivation is not None and isinstance(self.vars[i].derivation, MappingItem) and self.vars[i].isStateVar() for i in item])
            has_old = any([self.vars[i].derivation is not None and isinstance(self.vars[i].derivation, Original) and self.vars[i].isStateVar() for i in item])
            has_param = any([self.vars[i].isTxVar() for i in item])
            types = set([str(self.vars[i].type) for i in item])
            # has_inttype = all([ _type.find("int")!=-1 for _type in types])
            _vars = [self.vars[i] for i in item]
            if len(types) == 1 and "uint256" in types and has_mappingItem and has_old and has_param :
                # _vars = [self.vars[i] for i in item]
                # _vars_names = [ _var.name for _var in _vars]
                self.all_slices.append(self.get_or_instantiate_slice(vars=_vars))
        
        # com_3 =  combinations(range(len(self.vars)), 3)
        # for item in com_3:
        #     if self.checkTypeConsistent(self.vars[item[0]], self.vars[item[1]]) \
        #         and self.checkTypeConsistent(self.vars[item[1]], self.vars[item[2]]):
        #         self.all_slices.append(self.get_or_instantiate_slice(vars=[self.vars[i] for i in item])) 

    def get_or_instantiate_slice(self, vars: List[Variable]):
        if 1==len(vars):
            return self.get_or_instantiate_slice1(vars)
        elif 2 == len(vars):
            return self.get_or_instantiate_slice2(vars)
        elif 3 ==  len(vars):
            return self.get_or_instantiate_slice3(vars)
        else:
            assert False, "The length {0} is not supported.".format(len(vars))

    def get_or_instantiate_slice1(self,vars):
        return PptSlice1(self, vars) 

    def get_or_instantiate_slice2(self, vars):
        return PptSlice2(self, vars)

    def get_or_instantiate_slice3(self, vars):
        return PptSlice3(self, vars)
    
    def createImplySlice(self):
        factory = PptImplySliceFactory()

        all_invs = list()
        for myslice in self.all_slices:
            all_invs += myslice.invs

        coms = list(combinations(range(len(all_invs)), 2))
        if self.func is not None:
            print(self.func, "coms", len(coms))
            count = 0 
            for item in coms:
                inv1 = all_invs[item[0]]
                inv2 = all_invs[item[1]]
                if AddressImply.valid_imply(inv1, inv2):
                    assert isinstance(inv1, Invariant) and isinstance(inv2, Invariant)
                    # inv1_clone = inv1.__class__(inv1.varInfos)
                    # inv2_clone = inv2.__class__(inv2.varInfos)
                    inv1_clone = copy.copy(inv1) 
                    inv2_clone = copy.copy(inv2)
                    implyInv = AddressImply(inv1_clone, inv2_clone)
                    factory.create(self, implyInv)
                    count += 1
                elif AddressImply.valid_imply(inv2, inv1):
                    assert isinstance(inv1, Invariant) and isinstance(inv2, Invariant)
                    # inv1_clone = inv1.__class__(inv1.varInfos)
                    # inv2_clone = inv2.__class__(inv2.varInfos)
                    inv1_clone = copy.copy(inv1) 
                    inv2_clone = copy.copy(inv2)
                    implyInv = AddressImply(inv2_clone, inv1_clone)
                    factory.create(self, implyInv)
                    count += 1
            print(self.func, "count", count)
            self.all_slices.extend(factory.all_imlySlices)
            print(self.func, "all_imlySlices", len(factory.all_imlySlices))
            print(self.func, "all_slices", len(self.all_slices))
    
    def getAllInvariants(self):
        results: List[Invariant] = list()
        myImplySlices: List[PptImplySlice] = list() 
        for myslice in self.all_slices:
            if not ALLOW_FASIFY_INV:
                myslice.finalize()
            if isinstance(myslice, PptImplySlice):
                myImplySlices.append(myslice)
            else:
                results.extend(myslice.invs)
        meaningFulImplySlices = list()
        for myslice in myImplySlices:
            for inv in myslice.invs:
                assert isinstance(inv, AddressImply)
                from_inv = inv.from_condition
                to_inv = inv.to_condition
                if from_inv not in results and to_inv not in results:
                    meaningFulImplySlices.append(myslice)
        for myslice in meaningFulImplySlices:
            results.extend(myslice.invs)
        return results 

    def compressInvaraints(self):
        results: List[Invariant] = list()
        for slice in self.all_slices:
            slice.finalize()
            slice.compressInvariants()
            results.extend(slice.invs)
        compressedResults: List[Invariant] = list()
        self.suppressor = Supressor(self.vars)
        for inv in results:
            if not self.suppressor.imply(compressedResults, inv):
                compressedResults.append(inv)
        return compressedResults

class PptSlice(Ppt):
    arity: int 
    parent: PptTopLevel
    invs: List[Invariant] 
    suppressor: Supressor
    def __init__(self, parent: PptTopLevel, vars: List[Variable]) -> None:
        super().__init__(vars)
        self.parent = parent
        self.invs = list()
        self.suppressor = Supressor(self.vars)
    
    def instantiate_invariants(self):
        self._instantiate_given_invaraints(CompleteInvaraints)

    def _instantiate_given_invaraints(self, invariants: List[Invariant]):
        for proto_inv in invariants:
            if proto_inv.valid_vars(self.vars):
                self.invs.append(proto_inv.instantiate(self.vars))
    
    def addValues(self, vals: List):
        false_invs = list()
        size = len(self.invs)
        
        for inv in self.invs:
            if not inv.check(vals):
                false_invs.append(inv)
                inv.falsify = True

        if not ALLOW_FASIFY_INV:
            for inv in false_invs:
                self.invs.remove(inv)
            assert size == len(self.invs) + len(false_invs)
        
    def finalize(self):
        results =  []
        for inv in self.invs:
            inv.finalize()
            if not inv.falsify and inv.verified:
                results.append(inv)
        self.invs =  results

    def compressInvariants(self):
        if len(self.invs) == 0:
            return
        # IntGt -> IntGe 
        # IntGt -> IntNotEq
        # IntEq -> IntGe
        # IntEq -> IntLe 
        # IntLt -> IntLe
        # IntLt -> IntNotEq
        single_result = self.invs[0]
        for inv in self.invs[1:]:
            if not self.suppressor.imply([single_result], inv):
                single_result = inv  

        self.invs =  [single_result]

        # ImplyRules = dict()
        # ImplyRules["IntGt"] =  {"IntGe", "IntNotEq"}
        # ImplyRules["IntEq"] =  {"IntGe", "IntLe"}
        # ImplyRules["IntLt"] =  {"IntLe", "IntNotEq"}
        # for inv_rule in ImplyRules:
        #     for inv in self.invs:
        #         if self.getInvariantName(inv) == inv_rule:
        #             for _inv in self.invs:
        #                 if self.getInvariantName(_inv) in ImplyRules[inv_rule]:
        #                     _inv.setUseless()
        
        # useless_invs = list()
        # for inv in self.invs:
        #     if inv.useless:
        #         useless_invs.append(inv)
        
        # for inv in useless_invs:
        #     self.invs.remove(inv)
        
    
    @classmethod
    def getInvariantName(cls, inv: Invariant):
        if isinstance(inv, IntGt):
            return "IntGt"
        elif isinstance(inv, IntGe):
            return "IntGe"
        elif isinstance(inv, IntEq):
            return "IntEq"
        elif isinstance(inv, IntNotEq):
            return "IntNotEq"
        elif isinstance(inv, IntLe):
            return "IntLe"
        elif isinstance(inv, IntLt):
            return "IntLt"
        elif isinstance(inv, AddressImply):
            return "AddressImply"
        else:
            return "others"
        
    
class PptSlice1(PptSlice):
    def __init__(self, parent: PptTopLevel, vars: List[Variable]) -> None:
        PptSlice.__init__(self, parent, vars)
        assert 1 == len(self.vars)
        self.arity = 1
    
    
class PptSlice2(PptSlice):
    def __init__(self, parent: PptTopLevel, vars: List[Variable]) -> None:
        PptSlice.__init__(self, parent, vars)
        assert 2 == len(self.vars)
        self.arity = 2

class PptSlice3(PptSlice):
    def __init__(self, parent: PptTopLevel, vars: List[Variable]) -> None:
        PptSlice.__init__(self, parent, vars)
        assert 3 == len(self.vars)
        self.arity = 3


class PptImplySlice(PptSlice):
    def __init__(self, parent: PptTopLevel, invariant_from: AddressImply) -> None:
        varInfos = invariant_from.varInfos
        PptSlice.__init__(self, parent, varInfos)
        self.invs.append(invariant_from)
      
class PptImplySliceFactory(object):
    all_imlySlices: List[PptImplySlice]
    # def __new__(cls):
    #     if not hasattr(cls, 'instance'):
    #         cls.instance = super(PptImplySliceFactory, cls).__new__(cls)
    #     return cls.instance
    def __init__(self) -> None:
        self.all_imlySlices = list()

    def create(self, parent: PptTopLevel, invariant: AddressImply) -> PptImplySlice:
        varInfos = invariant.varInfos
        for mySlice in self.all_imlySlices:
            if mySlice.vars == varInfos:
                if invariant not in mySlice.invs:
                    mySlice.invs.append(invariant)
                return mySlice        
        newSlice = PptImplySlice(parent, invariant)
        self.all_imlySlices.append(newSlice)
        return newSlice