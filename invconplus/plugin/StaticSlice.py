

from slither import Slither
from slither.core.declarations.contract import Contract
from slither.core.declarations.function_contract import FunctionContract
from slither.core.cfg.node import Node
from slither.core.expressions.expression import Expression
from slither.core.expressions.assignment_operation import AssignmentOperation
from slither.core.expressions.binary_operation import BinaryOperation, BinaryOperationType
from slither.core.expressions.index_access import IndexAccess 
from slither.core.expressions.identifier import Identifier 
from slither.core.expressions.member_access import MemberAccess 
from slither.core.expressions.literal import Literal
from slither.core.expressions.unary_operation import UnaryOperation
from slither.core.expressions.conditional_expression import ConditionalExpression
from slither.core.expressions.call_expression import CallExpression
from slither.core.expressions.type_conversion import TypeConversion
import re 
import json 
import copy 

slice_criteria = {}

class StaticSlice:
    slither: Slither 
    mainContractName: str 
    def __init__(self, slither, mainContractName) -> None:
        self.slither =  slither
        self.mainContractName = mainContractName 
        self.slice_criteria  = dict(statevariables=["gameIdGame"])
    
    def getContract(self):
        return self.slither.get_contract_from_name(self.mainContractName)[0]
    
    def getSliceCriteria(self):
        return slice_criteria
    
    def setSliceCriteria(self, slice_criteria):
        self.slice_criteria = slice_criteria
    
    def staticSliceFunction(self, function: FunctionContract):
        parameter_bindings = dict()
        def backwardSlice(node: Node, interests: set, staticSlice: list):
            if isinstance(node.expression, AssignmentOperation):
                    left: Expression  = node.expression.expression_left
                    right: Expression  = node.expression.expression_right
                    if any([left.__str__().find(item)!=-1 for item in interests]):
                        staticSlice.append(node)  
                        if isinstance(right, IndexAccess):
                            r_left: Expression =  right.expression_left
                            r_right: Expression =  right.expression_right
                            interests.add(r_right.__str__())
                    
            for father in node.fathers:
                backwardSlice(father, interests, staticSlice)

        def forwardAnalysis(index, staticSlice, interests, transitives: dict):
            if index >= len(staticSlice):
                return 
            node = staticSlice[index]
            if isinstance(node.expression, AssignmentOperation):
                left: Expression  = node.expression.expression_left
                right: Expression  = node.expression.expression_right
                for key in transitives:
                    if right.__str__().find(key)!=-1:
                        right = re.subn("(\W?)"+key+"(\W)", r'\1'+transitives[key]+r'\2', right.__str__())[0]
                transitives[left.__str__()] = right.__str__()
            forwardAnalysis(index+1, staticSlice, interests, transitives)         
                    
        def exploreEx(exp: Expression, slice_criteria: list):
            if isinstance(exp, AssignmentOperation):
                left: Expression  = exp.expression_left
                right: Expression  = exp.expression_right
                leftVarInfo = exploreEx(left, slice_criteria)
                rightVarInfo = exploreEx(right, slice_criteria)
                return exp 
            elif isinstance(exp, BinaryOperation):
                left : Expression = exp.expression_left
                right : Expression = exp.expression_right
                leftVarInfo = exploreEx(left, slice_criteria)
                rightVarInfo = exploreEx(right, slice_criteria)
                return exp 
            elif isinstance(exp, IndexAccess):
                left: Expression  = exp.expression_left
                right: Expression  = exp.expression_right
                baseVar = exploreEx(left, slice_criteria)
                indexVar = exploreEx(right, slice_criteria)
                slice_criteria.append([baseVar.__str__(), indexVar.__str__()])
                return exp 
            elif isinstance(exp, MemberAccess):
                structexp: Expression = exp.expression
                member: str = exp.member_name
                structVar = exploreEx(structexp, slice_criteria)
                return exp
            elif isinstance(exp, Identifier):
                val = exp.value
                return val 
            elif isinstance(exp, UnaryOperation):
                exp = exp.expression
                exploreEx(exp, slice_criteria)
                return exp
            elif isinstance(exp, ConditionalExpression):
                exploreEx(exp.if_expression, slice_criteria)
                exploreEx(exp.else_expression, slice_criteria)
                return exp
            elif isinstance(exp, CallExpression):
                [ exploreEx(arg, slice_criteria) for arg in exp.arguments ]
                return exp
            elif isinstance(exp, TypeConversion):
                exploreEx(exp.expression, slice_criteria)
                return exp
            elif isinstance(exp, Literal):
                return exp.value
            else:
                return "" 

        def detectSliceCriteria(node: Node, slice_criteria_full_info_list: list):
            slice_criteria =  list() 
            # print(node.__str__())
            exploreEx(node.expression, slice_criteria)
            if len(slice_criteria)>0:
                slice_criteria_full_info_list.append([node.__str__(), slice_criteria])
                staticSlice = list()
                staticSlice.append(node)
                backwardSlice(node, set([ item[1] for item in  slice_criteria ]), staticSlice=staticSlice)
                staticSlice.reverse()
                # print([item.__str__() for item in staticSlice ])
                transitives = dict()
                forwardAnalysis(0, staticSlice, set([ item[1] for item in  slice_criteria ]), transitives)
                # print(transitives)
                for statevariable in self.slice_criteria["statevariables"]:
                    for key in transitives:
                        if transitives[key].find(statevariable)!=-1:
                            print("Trace Slice Criteria: ", statevariable)
                            print("Parameter Bindings: ", transitives[key])
                            if statevariable not in parameter_bindings:
                                parameter_bindings[statevariable] =  list()
                            parameter_bindings[statevariable].append(transitives[key])
                           
            if node.contains_if():
                if node.son_true:
                    detectSliceCriteria(node.son_true, slice_criteria_full_info_list)
                if node.son_false:
                    detectSliceCriteria(node.son_false, slice_criteria_full_info_list)
            else:
                for son in node.sons:
                    detectSliceCriteria(son, slice_criteria_full_info_list)
                    
        node = function.entry_point
        slice_criteria_full_info_list = list()
        if node: 
            detectSliceCriteria(node, slice_criteria_full_info_list)
            if len(slice_criteria_full_info_list) > 0:
                func_params = set([param.name for param in function.parameters]) 
                func_params.add("msg.sender")
                state_var_names = set([var.name for var in function.contract.state_variables])
                for item in slice_criteria_full_info_list:
                    for subitem in item[1]:
                        print(function.full_name, item[0], "\n",  subitem[0], subitem[1])
        return parameter_bindings
                           
    def staticSlice(self):
        global_parameter_binds = dict()
        contract: Contract = self.getContract()
        
        for function in contract.functions:
            parameter_bindings =  self.staticSliceFunction(function)
            if len(parameter_bindings)>0:
                global_parameter_binds[function.full_name] = parameter_bindings
        new_global_parameter_binds = copy.deepcopy(global_parameter_binds)
        for function in contract.functions:
            for call_expression in function.calls_as_expressions:
                if isinstance(call_expression, CallExpression):
                    if isinstance(call_expression.called, Identifier):
                        callee =  call_expression.called.value.name
                        callee_function =  next(
                                (f for f in contract.functions if f.full_name.find(callee)!=-1 and len(f.parameters) == len(call_expression.arguments) and not f.is_shadowed),
                                None,
                            )
                        call_parameter_bindings =  list()
                        if callee_function:
                            for index in range(len(call_expression.arguments)):
                                arg = call_expression.arguments[index]
                                param = callee_function.parameters[index]
                                if isinstance(arg, Identifier):
                                    call_parameter_bindings.append(dict(param=param.__str__(), arg = arg.value.__str__()))
                            if len(call_parameter_bindings) !=  len(call_expression.arguments):
                                continue
                            else:
                                for key in global_parameter_binds:
                                    if key == callee_function.full_name:
                                        if function.full_name not in global_parameter_binds:
                                            new_global_parameter_binds[function.full_name] = global_parameter_binds[callee_function.full_name]
                                            for key, value in new_global_parameter_binds[function.full_name].items():
                                                for item in  call_parameter_bindings:
                                                    value = re.subn("(\W?)"+item["param"]+"(\W)", r'\1'+item["arg"]+r'\2', value.__str__())[0]
                                                new_global_parameter_binds[function.full_name][key] = value
                    

        print(json.dumps(new_global_parameter_binds, indent=4))
        return new_global_parameter_binds