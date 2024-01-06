import logging
import pprint
from slither import Slither
from slither.core.declarations.contract import Contract
from slither.core.declarations.function_contract import FunctionContract
from slither.core.declarations.enum_contract import EnumContract
from slither.core.cfg.node import Node, NodeType
import re 
import os 
from typing import List, Dict, Any 
from crytic_compile.crytic_compile import CryticCompile
from slither.core.expressions.expression import Expression
from slither.core.expressions.assignment_operation import AssignmentOperation
from slither.core.expressions.binary_operation import BinaryOperation, BinaryOperationType
from slither.core.expressions.index_access import IndexAccess 
from slither.core.expressions.identifier import Identifier 
from slither.core.expressions.super_identifier import SuperIdentifier
from slither.core.expressions.member_access import MemberAccess 
from slither.core.expressions.literal import Literal
from slither.core.expressions.unary_operation import UnaryOperation
from slither.core.expressions.conditional_expression import ConditionalExpression
from slither.core.expressions.call_expression import CallExpression
from slither.core.expressions.type_conversion import TypeConversion
from slither.core.solidity_types.mapping_type import MappingType
from slither.core.solidity_types.array_type import ArrayType
from invconplus.model.model import VarInfo, VarType
from invconplus.derivation.binary.ArrayItem import ArrayItem 
from invconplus.derivation.binary.MappingItem import MappingItem
from invconplus.derivation.unary.StructMember import StructMember
from invconplus.derivation.unary.SeqSize import SeqSize
from invconplus.derivation.unary.ArrayWildcard import ArrayWildcard


from invconplus.abstractType.DataDependency import FuncDataDependency, ContractDependency

# text =""" ParserError: ParserError: Source "@openzeppelin/contracts/proxy/Proxy.sol" not found: File not found. Searched the following locations: ""."""
p =  re.compile("Source \"(.+)\"\s+")

def rename(address_or_workdir, missing_files: List[str]):
    workdir = None 
    if address_or_workdir.startswith("0x"):
        main_workdir =  "./crytic-export/etherscan-contracts/"
        for subdir in os.listdir(main_workdir):
            if subdir.startswith(address_or_workdir):
                workdir =  main_workdir + subdir + "/contracts" 
                break 
    else:
        workdir =  address_or_workdir 

    for file in missing_files:
        assert file.startswith("@openzeppelin")
        wrong_subdir =  os.path.join(workdir, file.split("/")[-2])
        if os.path.exists(wrong_subdir):
            correct_dir = os.path.join(workdir, "/".join(file.split("/")[:-2]))
            if not os.path.exists(correct_dir):
                os.makedirs(correct_dir)
            mv_cmd = "mv {0} {1}".format(wrong_subdir, correct_dir)
            code = os.system(mv_cmd)
            print(code)

def compileContract(address):
    cc = CryticCompile(target="mainet:{0}".format(address), etherscan_api_key="SDI5QEC2UAY1CX4C1VPXC4WE9HIMH2SF1C")
    slither = Slither(cc)
    if len(slither._crytic_compile.filenames) == 1:
        mainContract = list(slither._crytic_compile.filenames)[0].relative.split(".etherscan.io-")[1].split(".sol")[0]
    else:
        mainContract = list(slither._crytic_compile.filenames)[0].relative.split(".etherscan.io-")[1].split(".sol")[0].split("/")[0]
    print("main contract: ", mainContract)
    for contract in slither.contracts:
        print(contract.name)
    return mainContract, slither 

class MyContract:
    contract_name: str 
    slither: Slither 
    address: str 
    contract: Contract
    cdep: object 
    def __init__(self, address:str) -> None:
        assert address.startswith("0x") and len(address) == 42, "{0} is invalid address.".format(address)
        self.address = address 
        self.contract_name, self.slither =  compileContract(address=address)
        self.contract = self.getContract(contract_name=self.contract_name)
        self.cdep = None 

    def getContract(self, contract_name) -> Contract:
        for contract in self.slither.contracts:
            if contract.name == contract_name:
                return contract 
        return None 
    
    def extractConstants(self):
        constants = []
        for contract in self.slither.contracts:
            for var in contract.variables:
                if var.is_constant:
                    if isinstance(var.expression, Literal):
                        if var.expression.type.name in ["int"+str(8*i) for i in range(1,33)] + ["uint"+str(8*i) for i in range(1,33)]:
                            value = int(var.expression.value, 16) if var.expression.value.startswith("0x") else int(var.expression.value)
                            constants.append(dict(name=var.name, value=value, type=var.expression.type.name))
                        else:
                            constants.append(dict(name=var.name, value=var.expression.value, type=var.expression.type.name))
        return constants
    
    @property
    def list_funcs(self):
        # return set([ "{0}({1})".format(func.name, ",".join([param.name for param in func.parameters]))  for func in self.contract.functions_and_modifiers if func.is_implemented and not func.is_shadowed]) 
        return set([ "{0}({1})".format(func.name, ",".join([param.name for param in func.parameters]))  for func in self.contract.functions_and_modifiers if func.is_implemented]) 

    def getFunction(self, contract: Contract, func_name:str) -> FunctionContract:
        for func in contract.functions_and_modifiers_declared:
            if "{0}({1})".format(func.name, ",".join([param.name for param in func.parameters])) ==  func_name:
                if func.is_implemented and not func.is_shadowed:
                    return func
                # if hasattr(func, "functions_shadowed") and func.functions_shadowed is not None and len(func.functions_shadowed) > 0:
                #     return func.functions_shadowed[0]
                # return func 
        for func in contract.functions_and_modifiers_inherited:
            if "{0}({1})".format(func.name, ",".join([param.name for param in func.parameters])) ==  func_name:
                if func.is_implemented and not func.is_shadowed:
                    return func
                # if hasattr(func, "functions_shadowed") and func.functions_shadowed is not None and len(func.functions_shadowed) > 0:
                #     return func.functions_shadowed[0]
                # return func 
        return None 
    
    def createFunctionDataDependency(self, func: FunctionContract):
        def getEntry(myfunc: FunctionContract):
            entry = None
            if myfunc.entry_point is not None:
                entry = myfunc.entry_point
            elif len(myfunc.functions_shadowed) > 0:
                for shadowed_func in myfunc.functions_shadowed:
                    if shadowed_func.entry_point is not None:
                        entry = shadowed_func.entry_point 
            return entry
        entry = getEntry(func)
        assert entry is not None, "entry is None"
        funcDep = FuncDataDependency(func)
        def exploreEx(exp: Expression):
            if isinstance(exp, AssignmentOperation):
                left: Expression  = exp.expression_left
                right: Expression  = exp.expression_right
                leftVarInfo = exploreEx(left)
                rightVarInfo = exploreEx(right)
                if isinstance(leftVarInfo, VarInfo) and isinstance(rightVarInfo, VarInfo):
                    if leftVarInfo.isStateVar() and not rightVarInfo.isTxVar():
                        funcDep.addDependency(rightVarInfo, leftVarInfo)
                    else:
                        funcDep.addDependency(leftVarInfo, rightVarInfo)
                elif isinstance(leftVarInfo, VarInfo) and leftVarInfo.isStateVar():
                    funcDep.addDependency(leftVarInfo, None)
                return [leftVarInfo,exp.type.name,rightVarInfo]
            elif isinstance(exp, BinaryOperation):
                left : Expression = exp.expression_left
                right : Expression = exp.expression_right
                leftVarInfo = exploreEx(left)
                rightVarInfo = exploreEx(right)
                if exp.type in [BinaryOperationType.ANDAND, BinaryOperationType.OROR]:
                    return [[leftVarInfo],exp.type.name,[rightVarInfo]]
                else:
                    funcDep.addDependency(leftVarInfo, rightVarInfo)
                    return [leftVarInfo,exp.type.name,rightVarInfo]
            elif isinstance(exp, IndexAccess):
                left: Expression  = exp.expression_left
                right: Expression  = exp.expression_right
                # return exploreEx(left)+"["+exploreEx(right)+"]"
                baseVar = exploreEx(left)
                indexVar = exploreEx(right)
                if baseVar is not None and isinstance(baseVar.type, MappingType):
                    if isinstance(indexVar, str):
                        return None 
                        # return VarInfo(name=baseVar.name+"["+indexVar+"]", type = exp.type, vartype= baseVar.vartype, derivation=None)
                    else:
                        if isinstance(baseVar, dict) or isinstance(indexVar, dict):
                            logging.error("baseVar or indexVar is dict")
                            if "callee" in indexVar and indexVar["callee"] == "_msgSender":
                                if isinstance(baseVar, VarInfo):
                                    return VarInfo(name=baseVar.name+"[msg.sender]", type = exp.type, vartype= baseVar.vartype, derivation=MappingItem([baseVar, VarInfo(name = "msg.sender", type= "address", vartype= VarType.TXVAR, derivation=None )], ppt_slice=None))
                            else:
                                return None 
                        elif isinstance(baseVar, VarInfo) and isinstance(indexVar, VarInfo):
                            return VarInfo(name=baseVar.name+"["+indexVar.name+"]", type = exp.type, vartype= baseVar.vartype, derivation=MappingItem([baseVar, indexVar], ppt_slice=None))
                        else:
                            return None
                elif ArrayItem.valid_vars([baseVar, indexVar]):
                    if isinstance(indexVar, str):
                        return None 
                        # return VarInfo(name=baseVar.name+"["+indexVar+"]", type = exp.type, vartype= baseVar.vartype, derivation=None)
                    else:
                        if isinstance(baseVar, VarInfo) or isinstance(indexVar, VarInfo):
                            return VarInfo(name=baseVar.name+"["+indexVar.name+"]", type = exp.type, vartype= baseVar.vartype, derivation=ArrayItem([baseVar, indexVar], ppt_slice=None))
                        else:
                            return None 
                elif isinstance(indexVar, VarInfo) and isinstance(baseVar, VarInfo):
                    return VarInfo(name=baseVar.name+"["+indexVar.name+"]", type = exp.type, vartype= baseVar.vartype, derivation=MappingItem([baseVar, indexVar], ppt_slice=None))
                else:
                    return None 
                   
            elif isinstance(exp, MemberAccess):
                structexp: Expression = exp.expression
                member: str = exp.member_name
                # return exploreEx(structexp)+"."+member
                structVar = exploreEx(structexp)
                if structVar is None:
                    return None
                elif isinstance(structVar, EnumContract):
                    return VarInfo(name=structVar.name+"."+member, type = exp.type, vartype= VarType.ENUM, derivation=None)
                elif member != "length" and StructMember.valid_vars([structVar]):
                    return VarInfo(name=structVar.name+"."+member, type = exp.type, vartype= structVar.vartype, derivation=StructMember([structVar], ppt_slice=None))
                # elif member == "length":
                #     return VarInfo(name=structVar.name+"."+member, type = exp.type, vartype= structVar.vartype, derivation=SeqSize(ArrayWildcard([structVar], ppt_slice=None).derive()[0], ppt_slice=None))
                else:
                    return None  
        
            elif isinstance(exp, Identifier):
                val = exp.value
                # return val.name
                if isinstance(val, EnumContract):
                    return val 
                else:
                    return VarInfo(name=val.name, type=val.type, vartype= VarType.STATEVAR if val in self.contract.state_variables  else VarType.TXVAR if val in func.parameters or val.name in ["msg.sender", "msg.value"] else VarType.LOCALVAR, derivation=None)
            elif isinstance(exp, UnaryOperation):
                exp = exp.expression
                return exploreEx(exp)
            elif isinstance(exp, ConditionalExpression):
                return [exploreEx(exp.if_expression) , "|" , exploreEx(exp.else_expression)] 
            elif isinstance(exp, CallExpression):    
                if isinstance(exp.called, Identifier):
                    if isinstance(exp.called, SuperIdentifier):
                        superContracts = func.contract.inheritance
                        superFunc = None
                        for superContract in superContracts:
                            for myfunc in superContract.functions_and_modifiers_declared:
                                if myfunc.name == exp.called.value.name:
                                    superFunc = myfunc
                                    break
                        if superFunc is not None:
                            myentry  = getEntry(superFunc)
                            explore(myentry)
                            # funcdep = self.createFunctionDataDependency(superFunc)
                            # self.cdep.addFuncDataDependency(funcdep)
                        return dict(callee = "super."+exp.called.value.name, params = [ exploreEx(arg) for arg in exp.arguments ])
                    else:
                        funcDep.addCall(exp.called.value.name, [ exploreEx(arg) for arg in exp.arguments ]) 
                        return dict(callee = exp.called.value.name, params = [ exploreEx(arg) for arg in exp.arguments ])
               
            elif isinstance(exp, TypeConversion):
                return exploreEx(exp.expression)
            elif isinstance(exp, Literal):
                return exp.value
            else:
                return "" 
        
        visited = list()
        # do not consider cross function dependency
        def explore(node: Node):
            if node.type == NodeType.OTHER_ENTRYPOINT:
                pass 
            elif node.type == NodeType.EXPRESSION:
                data =  exploreEx(node.expression)
                # if data != "":
                #     print(data)
            elif node.type == NodeType.VARIABLE:
                data = exploreEx(node.expression)
                # if data != "":
                #     print(data)
            elif node.type == NodeType.IF:
                data = exploreEx(node.expression)
                # if data != "":
                #     print(data)
            elif node.type ==  NodeType.IFLOOP:
                pass
            else:
                pass 
            if node.contains_if():
                explore(node.son_true)
                explore(node.son_false)
            else:
                for son in node.sons:
                    if son not in visited:
                        visited.append(son)
                        explore(son)
        
        explore(entry)
        return funcDep 
        
    def analyze(self, ppts: Dict = dict()):
        cdep = ContractDependency()
        cdep.registerPPTs(ppts)
        self.cdep = cdep
        for func_name in self.list_funcs:
                func = self.getFunction(self.contract, func_name)
                # print("func_name:", func_name, func is not None, hasattr(func, "view") and func.view is True,  func.is_implemented if hasattr(func, "is_implemented") else None)
                # if func_name == "approve(to, tokenId)":
                #     pprint(func)
                # if not ((hasattr(func, "view") and func.view is True) or (hasattr(func, "is_implemented") and func.is_implemented is None)):
                if func is not None:
                    # print("func_name:", func_name)
                    funcdep = self.createFunctionDataDependency(func)
                    cdep.addFuncDataDependency(funcdep)
        cdep.analyze()
        return cdep 
                 


if __name__ == "__main__":
    mycontract = MyContract(address="0x60cd862c9C687A9dE49aecdC3A99b74A4fc54aB6")
    cdep = mycontract.analyze()
    print(cdep)
