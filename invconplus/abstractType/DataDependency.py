import copy
import traceback
from typing import Dict, List, Tuple, Set, NewType, Any
from invconplus.model.model import VarInfo, VarType
from invconplus.derivation.unary.Original import Original
from invconplus.derivation.binary.ArrayItem import ArrayItem 
from invconplus.derivation.binary.MappingItem import MappingItem
from invconplus.derivation.unary.StructMember import StructMember
from invconplus.derivation.unary.IntSeqSum import IntSeqSum
from invconplus.derivation.unary.MappingWildcard import MappingWildcard
from invconplus.derivation.unary.ArrayWildcard import ArrayWildcard
from invconplus.derivation.unary.SeqSize import SeqSize
from slither.core.declarations.function_contract import FunctionContract
import logging

VarDepPair =  NewType("VarDepPair", List)
def makeVarDepPair(varInfo_from, varInfo_to):
    return VarDepPair([varInfo_from, [varInfo_to]])

class FuncDataDependency:
    func: FunctionContract
    func_name: str 
    dependency: List[VarDepPair]
    internalcalls: List 
    contractDependency: Any
    all_dependencies: Any
    record:  Dict
    ppt_slice: Any 
    varInfos: Set[VarInfo] 
    derivedRelation: Dict[str, List[VarInfo]]
    parentVarRelation: Dict[str, VarInfo]
    variableClusters: List[List[VarInfo]]
    def __init__(self, func: FunctionContract) -> None:
        self.func = func 
        self.func_name = "{0}({1})".format(func.name, ",".join([param.name for param in func.parameters]))
        self.parameternames = [param.name for param in func.parameters]
        self.parameternames.append("msg.sender")
        self.parameternames.append("block.timestamp")
        self.parameternames.append("block.number")
        self.parameternames.append("msg.value")
        self.parameternames.append("tx.origin")
        self.parameternames.append("msg.gas")
        self.dependency = list()
        self.internalcalls = list()
        self.all_dependencies = list()
        self.record =  dict()
        self.contractDependency=  None 
        self.ppt_slice = None
        self.varInfos = set()
        self.derivedRelation = dict()
        self.parentVarRelation = dict()
        self.variableClusters =  list()
        
    
    def registerContractDependency(self, contractdependency):
        self.contractDependency =  contractdependency
    
    def registerPPT(self, ppt_slice):
        self.ppt_slice = ppt_slice

    def addCall(self, func_name, params: List):
        self.internalcalls.append([func_name, params])
    
    def replaceVarInfo(self, varInfo: VarInfo, newVarInfo: VarInfo, all_dependencies: List[VarDepPair], varInfos: List[VarInfo]):
        visited = dict()
        def recursive_replace(curVarInfo, varInfo: VarInfo, newVarInfo: VarInfo):
            if curVarInfo is None:
                return None
            if curVarInfo == varInfo:
                return newVarInfo
            if isinstance(curVarInfo, str):
                return None 
            if isinstance(curVarInfo, dict):
                return None
            if not isinstance(curVarInfo, VarInfo):
                return None
            if curVarInfo.name in visited:
                return visited[curVarInfo.name]
            old_name =  curVarInfo.name
            visited[old_name] = curVarInfo
            if curVarInfo.derivation is not None:               
                derivation_infos = []
                for i in range(len(curVarInfo.derivation.varInfos)):
                    if curVarInfo.derivation.varInfos[i] == varInfo:
                        # new_curVarInfo.derivation.varInfos[i] = newVarInfo
                        derivation_infos.append(newVarInfo)
                    elif curVarInfo.derivation.varInfos[i].name == varInfo.name:
                        derivation_infos.append(newVarInfo)
                    else:
                        value = recursive_replace(curVarInfo.derivation.varInfos[i], varInfo, newVarInfo)
                        derivation_infos.append(value)
                if curVarInfo.name.find(varInfo.name)!=-1:
                    new_name  =  curVarInfo.name
                    if isinstance(newVarInfo, str):
                        new_name = new_name.replace(varInfo.name, newVarInfo)
                    else:
                        if isinstance(newVarInfo, VarInfo):
                            new_name = new_name.replace(varInfo.name, newVarInfo.name)
                        else:
                            pass 
                    curVarInfo = VarInfo(name = new_name, type = curVarInfo.type, vartype = curVarInfo.vartype, derivation = curVarInfo.derivation.__class__(varInfos = derivation_infos, ppt_slice = curVarInfo.derivation.ppt_slice))

            
            return curVarInfo
        
        for pair in all_dependencies:
            if isinstance(pair[0], list) or isinstance(pair[0], str) or isinstance(pair[0], int) or isinstance(pair[0], bool) or isinstance(pair[0], dict):
                pass 
            else:
                value = recursive_replace(pair[0], varInfo, newVarInfo)
                if value is None or not isinstance(value, VarInfo):
                    continue
                pair[0] = value
            for i in range(len(pair[1])):
                if isinstance(pair[1][i], list) or isinstance(pair[1][i], str) or isinstance(pair[1][i], int) or isinstance(pair[1][i], bool) or isinstance(pair[1][i], dict):
                    pass
                else:
                    value = recursive_replace(pair[1][i], varInfo, newVarInfo)
                    if value is None or not isinstance(value, VarInfo):
                        continue
                    pair[1][i] = value
        for i in range(len(varInfos)):
            if isinstance(varInfos[i], list) or isinstance(varInfos[i], str) or isinstance(varInfos[i], int) or isinstance(varInfos[i], bool) or isinstance(varInfos[i], dict):
                pass
            else:
                value = recursive_replace(varInfos[i], varInfo, newVarInfo)
                if value is None or not isinstance(value, VarInfo):
                    continue
                varInfos[i] = value

    def getAllDepdencies(self, visited = list()):
        if self.func_name in visited:
            return self.all_dependencies
        visited.append(self.func_name)
        if len(self.all_dependencies)>0:
            return self.all_dependencies
        all_dependencies = [] 
        for internal_call in self.internalcalls:
            for full_name in self.contractDependency.all_func_dependencies:
                if  internal_call[0] == full_name.split("(")[0]:
                    
                    otherfuncDep: FuncDataDependency  = self.contractDependency.all_func_dependencies[full_name]
                    try:
                        all_dependencies += copy.deepcopy(otherfuncDep.getAllDepdencies(visited=visited))
                        self.varInfos.update(copy.deepcopy(otherfuncDep.varInfos))
                    except:
                        all_dependencies += copy.copy(otherfuncDep.getAllDepdencies(visited=visited))
                        self.varInfos.update(copy.copy(otherfuncDep.varInfos))

                    lsVarInfos = list(self.varInfos)

                    # replace args with actual values
                    for i in range(len(otherfuncDep.func.parameters)):
                        if i >= len(internal_call[1]):
                            break
                        param = otherfuncDep.func.parameters[i]
                        paramVarInfo = VarInfo(name=param.name, type=param.type, vartype=VarType.TXVAR, derivation=None)
                        newVarInfo = self.findParentVarInfo(internal_call[1][i])
                        self.replaceVarInfo(paramVarInfo, newVarInfo, all_dependencies, lsVarInfos)

                    self.varInfos.update(lsVarInfos)
                       
        all_dependencies = self.dependency + all_dependencies 
        self.all_dependencies =  all_dependencies
        self.initializeClusters()
        return all_dependencies

    def initializeClusters(self):
        for pair in self.all_dependencies:
            varInfo_1  = pair[0]
            depVarInfos = pair[1]
            for dep in depVarInfos:
                self.addDependency2Clusters(varInfo_1, dep)

    def addDependency2Clusters(self, varInfo_1: VarInfo, varInfo_2: VarInfo):
        if len(self.variableClusters) == 0:
            self.variableClusters.append([varInfo_1, varInfo_2])
        else:
            match_1 = None 
            match_2 = None 
            for cluster in self.variableClusters:
                if varInfo_1 in cluster:
                    match_1 = cluster
                if varInfo_2 in cluster:
                    match_2 = cluster
            if match_1 == match_2:
                if match_1 is None:
                    self.variableClusters.append([varInfo_1, varInfo_2])
            elif match_1 is None and match_2 is not None:
                match_2.append(varInfo_1)
            elif match_2 is None and match_1 is not None:
                match_1.append(varInfo_2)
            else:
                merge = match_1 + match_2
                self.variableClusters.remove(match_1)
                self.variableClusters.remove(match_2)
                self.variableClusters.append(merge)  

    def testInSameCluster(self, varInfo_1: VarInfo,  varInfo_2: VarInfo):
        match_1 = None 
        match_2 = None 
        for cluster in self.variableClusters:
            for varInfo in cluster:
                if isinstance(varInfo, VarInfo):
                    if varInfo == varInfo_1 or \
                        (isinstance(varInfo.derivation, MappingItem) and isinstance(varInfo_1.derivation, IntSeqSum) and isinstance(varInfo_1.derivation.varInfos[0].derivation, MappingWildcard) and varInfo_1.derivation.varInfos[0].derivation.varInfos[0] == varInfo.derivation.varInfos[0]) \
                        or (isinstance(varInfo.derivation, ArrayItem) and isinstance(varInfo_1.derivation, IntSeqSum) and isinstance(varInfo_1.derivation.varInfos[0].derivation, ArrayWildcard) and varInfo_1.derivation.varInfos[0].derivation.varInfos[0] == varInfo.derivation.varInfos[0]):
                        match_1 =  cluster
                    if varInfo == varInfo_2 or \
                        (isinstance(varInfo.derivation, MappingItem) and isinstance(varInfo_2.derivation, IntSeqSum) and isinstance(varInfo_2.derivation.varInfos[0].derivation, MappingWildcard) and varInfo_2.derivation.varInfos[0].derivation.varInfos[0] == varInfo.derivation.varInfos[0]) \
                        or (isinstance(varInfo.derivation, ArrayItem) and isinstance(varInfo_2.derivation, IntSeqSum) and isinstance(varInfo_2.derivation.varInfos[0].derivation, ArrayWildcard) and varInfo_2.derivation.varInfos[0].derivation.varInfos[0] == varInfo.derivation.varInfos[0]):
                        match_2 =  cluster

        return match_1 is not None and match_1 == match_2

    def addDependency(self, _from: VarInfo, _to: VarInfo):
        if isinstance(_from, VarInfo):
            self.varInfos.add(_from)
        if isinstance(_to, VarInfo):
            self.varInfos.add(_to)
        updated = False 
        for vardep_pair in self.dependency:
            if self.equal(vardep_pair[0], _from):
                vardep_pair[1].append(_to)
                updated = True
                break 
        
        if not updated:
            vardep_pair = makeVarDepPair(_from, _to)
            self.dependency.append(vardep_pair)
    
    def searchVarInfoDeps(self, varInfo: VarInfo):
        for vardep_pair in self.dependency:
            if self.equal(vardep_pair[0], varInfo):
                return vardep_pair[1]
        return list()
    
    def findOriginalVarInfo(self, varInfo: VarInfo):
        assert isinstance(varInfo, VarInfo)
        if varInfo.isDerived(): 
            if isinstance(varInfo.derivation, MappingItem):
                base = self.findOriginalVarInfo(varInfo.derivation.varInfos[0])
                index =  self.findOriginalVarInfo(varInfo.derivation.varInfos[1])
                return VarInfo(name=base.name+"["+index.name+"]", type = varInfo.type, vartype= base.vartype, derivation=MappingItem([base, index], ppt_slice=varInfo.derivation.ppt_slice))
            elif isinstance(varInfo.derivation, ArrayItem):
                base = self.findOriginalVarInfo(varInfo.derivation.varInfos[0])
                index =  self.findOriginalVarInfo(varInfo.derivation.varInfos[1])
                return VarInfo(name=base.name+"["+index.name+"]", type = varInfo.type, vartype= base.vartype, derivation=MappingItem([base, index], ppt_slice=varInfo.derivation.ppt_slice))
            elif isinstance(varInfo.derivation, StructMember):
                struct = self.findOriginalVarInfo(varInfo.derivation.varInfos[0])
                return VarInfo(name=struct.name+"."+varInfo.name.split(".")[-1], type = varInfo.type, vartype= struct.vartype, derivation=StructMember([struct], ppt_slice=varInfo.derivation.ppt_slice))      
            elif isinstance(varInfo.derivation, MappingWildcard):
                mapping = self.findOriginalVarInfo(varInfo.derivation.varInfos[0])
                if varInfo.name.find("[...].")!=-1:
                    return VarInfo(name=mapping.name+"[...]."+varInfo.name.split(".")[-1], type = varInfo.type, vartype= mapping.vartype, derivation=MappingWildcard([mapping], ppt_slice=varInfo.derivation.ppt_slice)) 
                else:
                    return VarInfo(name=mapping.name+"[...]", type = varInfo.type, vartype= mapping.vartype, derivation=MappingWildcard([mapping], ppt_slice=varInfo.derivation.ppt_slice))
            elif isinstance(varInfo.derivation, ArrayWildcard):
                arr = self.findOriginalVarInfo(varInfo.derivation.varInfos[0])
                if varInfo.name.find("[...].")!=-1:
                    return VarInfo(name=arr.name+"[...]."+varInfo.name.split(".")[-1], type = varInfo.type, vartype= arr.vartype, derivation=ArrayWildcard([arr], ppt_slice=varInfo.derivation.ppt_slice)) 
                else:
                    return VarInfo(name=mapping.name+"[...]", type = varInfo.type, vartype= mapping.vartype, derivation=ArrayWildcard([arr], ppt_slice=varInfo.derivation.ppt_slice))
            elif isinstance(varInfo.derivation, IntSeqSum):
                seq = self.findOriginalVarInfo(varInfo.derivation.varInfos[0])
                return VarInfo(name="Sum("+seq.name+")", type = varInfo.type, vartype= seq.vartype, derivation=IntSeqSum([seq], ppt_slice=varInfo.derivation.ppt_slice)) 
            elif isinstance(varInfo.derivation, Original):
                return self.findOriginalVarInfo(varInfo.derivation.varInfos[0])
            else:
                assert False 
        else:
            return varInfo 

    def testDep(self, varInfo_1: VarInfo,  varInfo_2: VarInfo):
        _varInfo_1 =  self.findOriginalVarInfo(varInfo_1)
        _varInfo_2 =  self.findOriginalVarInfo(varInfo_2)
        ret1  = self._testDep(_varInfo_1, _varInfo_2)
        return ret1
    
    # Note: there may exist cycle 
    # TODO: how to avoid such scenario
    def _testDep(self, varInfo_from: VarInfo,  varInfo_to: VarInfo):
        if varInfo_from == varInfo_to:
            return True 
        if isinstance(varInfo_from, VarInfo) and isinstance(varInfo_to, VarInfo):
            # through deps (temporal relations)
            if varInfo_from.name in self.parentVarRelation:
                varInfo_from = self.parentVarRelation[varInfo_from.name] 
         
            if varInfo_to.name in self.parentVarRelation:
                varInfo_to = self.parentVarRelation[varInfo_to.name]

            return self.testInSameCluster(varInfo_from, varInfo_to)
        else:
            return False     
    
    def findParentVarInfo(self, varInfo: VarInfo, visited: List = []):
        if varInfo in visited:
            if isinstance(varInfo, VarInfo) and varInfo.name in self.parentVarRelation:
                return self.parentVarRelation[varInfo.name]
            else:
                return varInfo
        visited.append(varInfo)
        result = varInfo
        if isinstance(varInfo, VarInfo) and varInfo.isDerived():
            if isinstance(varInfo.derivation, MappingItem):
                base =  self.findParentVarInfo(varInfo.derivation.varInfos[0], visited=visited)
                index =  self.findParentVarInfo(varInfo.derivation.varInfos[1], visited=visited)
                if isinstance(base, VarInfo) and isinstance(index, VarInfo):
                    result.name = base.name + "["+ index.name + "]"
                    result.vartype = base.vartype
                    result.derivation = MappingItem([base, index],ppt_slice= varInfo.derivation.ppt_slice)
            elif isinstance(varInfo.derivation, ArrayItem):
                base =  self.findParentVarInfo(varInfo.derivation.varInfos[0], visited=visited)
                index =  self.findParentVarInfo(varInfo.derivation.varInfos[1])
                result.name = base.name + "["+ index.name + "]"
                result.vartype = base.vartype
                result.derivation = ArrayItem([base, index], ppt_slice=varInfo.derivation.ppt_slice)
            elif isinstance(varInfo.derivation, StructMember):
                struct =  self.findParentVarInfo(varInfo.derivation.varInfos[0], visited=visited)
                result.name = struct.name + "."+ result.name.split(".")[-1]
                result.vartype =  struct.vartype
                result.derivation = StructMember([struct], ppt_slice=varInfo.derivation.ppt_slice)
            self.parentVarRelation[result.name] = varInfo
            if isinstance(result, VarInfo):
                self.varInfos.add(result)
            return result
        else:
            _result = result
            for vardep_pair in self.all_dependencies:
                if self.equal(vardep_pair[0], varInfo):
                    for varInfo_to in vardep_pair[1]:
                        if isinstance(varInfo_to, VarInfo):
                            if varInfo_to.isDerived():
                                _result = varInfo_to
                                if isinstance(varInfo_to.derivation, MappingItem):
                                    base =  self.findParentVarInfo(varInfo_to.derivation.varInfos[0], visited=visited)
                                    index =  self.findParentVarInfo(varInfo_to.derivation.varInfos[1], visited=visited)
                                    if isinstance(base, VarInfo) and isinstance(index, VarInfo):
                                        _result.name = base.name + "["+ index.name + "]"
                                        _result.vartype = base.vartype
                                        _result.derivation.varInfos = [base, index]
                                elif isinstance(varInfo_to.derivation, ArrayItem):
                                    base =  self.findParentVarInfo(varInfo_to.derivation.varInfos[0], visited=visited)
                                    index =  self.findParentVarInfo(varInfo_to.derivation.varInfos[1], visited=visited)
                                    _result.name = base.name + "["+ index.name + "]"
                                    _result.vartype =  base.vartype
                                    _result.derivation.varInfos = [base, index]
                                elif isinstance(varInfo_to.derivation, StructMember):
                                    struct =  self.findParentVarInfo(varInfo_to.derivation.varInfos[0], visited=visited)
                                    _result.name = struct.name + "."+ _result.name.split(".")[-1]
                                    _result.vartype =  struct.vartype
                                    _result.derivation.varInfos = [struct]
                            else:
                                if varInfo_to.name in self.record:
                                    _result = self.record[varInfo_to.name]
                                else:    
                                    _result = varInfo_to

            if isinstance(varInfo, VarInfo) and isinstance(_result, VarInfo) and _result.isDerived():
                self.record[varInfo.name] = _result
                result = _result 

            if isinstance(result, VarInfo) and result!=varInfo:
                self.varInfos.add(result)
                self.parentVarRelation[result.name] = varInfo
            return result

    def getAllVarParentDeps(self):
        deps = list()
        for varDepPair in self.getAllDepdencies():
                varInfo_from = varDepPair[0] 
                if isinstance(varInfo_from, VarInfo):
                    name = varInfo_from.name
                    dep: VarInfo = self.findParentVarInfo(varInfo_from)
                    # if dep.name!=name and dep.isDerived():
                    if dep.isDerived():
                        # print(name,  dep)
                        deps.append(dep)
        
        for varInfo in self.varInfos:
            if varInfo.isDerived():
                deps.append(varInfo)

        return deps

    def createDerivedVarInfos(self):
        results = []
        def validVarInfo(varInfo: VarInfo):
            if isinstance(varInfo.derivation, MappingItem):
                if not validVarInfo(varInfo.derivation.varInfos[0]):
                    return False
                if varInfo.derivation.varInfos[1] is None or isinstance(varInfo.derivation.varInfos[1], str):
                    return False
                if isinstance(varInfo.derivation.varInfos[1], dict):
                    return False
                
                if varInfo.derivation.varInfos[1].isLocalVar() and varInfo.derivation.varInfos[1].name in self.parameternames:
                    varInfo.derivation.varInfos[1].vartype = VarType.TXVAR
                
                if varInfo.derivation.varInfos[1].isDerived():
                    if not validVarInfo(varInfo.derivation.varInfos[1]):
                        return False
                else:
                    if varInfo.derivation.varInfos[1].isLocalVar() and varInfo.derivation.varInfos[1].name not in self.parameternames:
                        return False
                    if varInfo.derivation.varInfos[1].isTxVar() and varInfo.derivation.varInfos[1].name not in self.parameternames:
                        return False
            elif isinstance(varInfo.derivation, ArrayItem):
                if not validVarInfo(varInfo.derivation.varInfos[0]):
                    return False
                if varInfo.derivation.varInfos[1].isDerived():
                    if not validVarInfo(varInfo.derivation.varInfos[1]):
                        return False
                else:
                    if varInfo.derivation.varInfos[1].isLocalVar() and varInfo.derivation.varInfos[1].name not in self.parameternames:
                        return False
                    if varInfo.derivation.varInfos[1].isTxVar() and varInfo.derivation.varInfos[1].name not in self.parameternames:
                        return False
            elif isinstance(varInfo.derivation, StructMember):
                if not validVarInfo(varInfo.derivation.varInfos[0]):
                    return False
    
            return True

        all_varInfo = set(self.getAllVarParentDeps())
        for varInfo in copy.copy(all_varInfo):
            if isinstance(varInfo, VarInfo) and varInfo.vartype == VarType.STATEVAR:
                if not validVarInfo(varInfo):
                    all_varInfo.remove(varInfo)
            else:
                all_varInfo.remove(varInfo)

        # add unfounded struct member
        for varInfo in copy.copy(all_varInfo):
            if varInfo.isDerived():
                if isinstance(varInfo.derivation, StructMember):
                    all_varInfo.remove(varInfo)
                    if varInfo in self.varInfos: 
                        self.varInfos.remove(varInfo)
                    try:
                        for item in StructMember([varInfo.derivation.varInfos[0]], ppt_slice=self.ppt_slice).derive():
                            all_varInfo.add(item)
                            self.varInfos.add(item)
                    except:
                        print(varInfo)
                        # print("error: ", varInfo, " not found in all_varInfo")
                        traceback.print_exc()
                        raise Exception("error: ", varInfo, " not found in all_varInfo")
        for varInfo in all_varInfo:
                deriveds = Original.createDerivedVarInfos(varInfo=varInfo, ppt_slice=self.ppt_slice)
                for derived_var in deriveds:
                    if StructMember.valid_vars([derived_var]):
                        for item in StructMember([derived_var], ppt_slice=self.ppt_slice).derive():
                            self.varInfos.add(item)
                            new_varInfo = VarInfo(
                                name=varInfo.name+"."+item.name.split(".")[-1],
                                type = item.type, 
                                vartype= item.vartype, 
                                derivation=StructMember([varInfo], ppt_slice = None)
                                )
                            derived_vars = Original.createDerivedVarInfos(varInfo=item, ppt_slice=self.ppt_slice)
                            results.extend(derived_vars)
                            if new_varInfo.name not in self.derivedRelation:
                                self.derivedRelation[new_varInfo.name] = list()
                            self.derivedRelation[new_varInfo.name].extend(derived_vars)
                    else:
                        if varInfo.name not in self.derivedRelation:
                            self.derivedRelation[varInfo.name] = list()
                        results.append(derived_var)
                        self.derivedRelation[varInfo.name].append(derived_var)
        return results                     

    @classmethod
    def equal(cls, varInfo_1: VarInfo, varInfo_2: VarInfo):
        return varInfo_1 ==  varInfo_2 or ( varInfo_1.name ==  varInfo_2.name and varInfo_1.type == varInfo_2.type \
            if isinstance(varInfo_1, VarInfo) and isinstance(varInfo_2, VarInfo) else False )

    def __str__(self) -> str:
        text = "function: "+self.func_name + "\n"
        for vardep_pair in self.dependency:
            text +=  str(vardep_pair) + "\n"

        text += "internal calls:\n"
        for call in self.internalcalls:
            text +=  call[0] + str(call[1]) + "\n"
        return text 


class ContractDependency:
    all_ppts: List
    all_func_dependencies: Dict[str,  FuncDataDependency]
    def __init__(self) -> None:
        self.all_func_dependencies = dict()
    
    def registerPPTs(self, ppts):
        self.all_ppts = ppts

    def addFuncDataDependency(self, funcDataDependency: FuncDataDependency):
        for ppt in self.all_ppts:
            if ppt.func == funcDataDependency.func_name:
                funcDataDependency.registerPPT(ppt)
        funcDataDependency.registerContractDependency(self)
        self.all_func_dependencies[funcDataDependency.func_name] = funcDataDependency
    
    def searchStateVarInfoDeps(self, varInfo: VarInfo):
        results = list()
        for _func_name in self.all_func_dependencies:
            for dep_var in self.all_func_dependencies[_func_name].searchVarInfoDeps(varInfo):
                if dep_var.isStateVar():
                    results.append(dep_var)
        return results

    def analyze(self):
        record =  dict()
        for func_name in self.all_func_dependencies:
            funcDep =  self.all_func_dependencies[func_name]
            print("".join(["*"]*10)+"\n")
            print(func_name)
            deps = funcDep.varInfos
            print(deps)
            print(funcDep.all_dependencies)
    
    def createDerivedVarsForFunc(self, func_name):
        try:
            assert func_name in self.all_func_dependencies
            return set(self.all_func_dependencies[func_name].createDerivedVarInfos())
        except:
            print("error: ", func_name, " not found in all_func_dependencies")
            print(self.all_func_dependencies.keys())
        #     return set()
            traceback.print_exc()
            return set()

    def testDep(self, varInfos: List[VarInfo]):
        return any([ self.testFuncDep(func, varInfos) for func in self.all_func_dependencies])

    def testFuncDep(self, func, varInfos: List[VarInfo]):
        if len(varInfos) <= 1:
            return True 
        elif len(varInfos) == 2:
            return self.all_func_dependencies[func].testDep(varInfos[0], varInfos[1])
        elif len(varInfos) == 3:
            return self.all_func_dependencies[func].testDep(varInfos[0], varInfos[1]) and self.all_func_dependencies[func].testDep(varInfos[1], varInfos[2]) 
        else:
            # TODO: how to handle this case
            return False
            

    
    
