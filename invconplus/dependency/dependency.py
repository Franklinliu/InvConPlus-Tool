from typing import List
from slither.analyses.data_dependency.data_dependency import \
 Variable_types as SUPPORTED_TYPES, \
Context_types as Context_types_API,\
  Variable, SolidityVariable, \
  Set, Dict, \
  is_dependent, get_dependencies, get_all_dependencies, \
  compute_dependency, compute_dependency_contract, \
  is_tainted
from slither.core.declarations import Contract, Function, FunctionContract
from slither.core.variables.local_variable import LocalVariable
from slither.core.variables.state_variable import StateVariable
from slither.core.expressions.call_expression import CallExpression
from slither.core.solidity_types import ArrayType, MappingType, UserDefinedType
import re 

class Dependency:
    def __init__(self, contract: Contract) -> None:
        self.contract :Contract = contract
        
    
    def is_data_dependent(self, 
                     variable: SUPPORTED_TYPES, 
                     source: SUPPORTED_TYPES, 
                     context: Context_types_API) -> bool:
        # return is_dependent(variable, source, context, only_unprotected=False)
        return is_dependent(variable, source, self.contract, only_unprotected=False)
    
    
    def get_data_dependencies(self, 
                              variable: SUPPORTED_TYPES,
                              context: Context_types_API) -> Set[Variable]:
        return get_dependencies(variable, context, only_unprotected=False)
    
    def get_all_data_dependencies(self,
                                  context: Context_types_API) -> Dict[Variable, Set[Variable]]:
        return get_all_dependencies(context, only_unprotected=False)
    
    @staticmethod
    def _explore_func_cond_read(func: Function, include_loop: bool) -> List[LocalVariable]:
        ret = [n.local_variables_read for n in func.nodes if n.is_conditional(include_loop)]
        return [item for sublist in ret for item in sublist if item in func.parameters]

    def all_conditional_parameters_read(self, func: Function, include_loop=True) -> List["StateVariable"]:
        """
        Return the parameters used in a condition

        Over approximate and also return index access
        It won't work if the variable is assigned to a temp variable
        """
        self._all_conditional_parameters_read_with_loop = None
        self._all_conditional_parameters_read = None
        if include_loop:
           
            if self._all_conditional_parameters_read_with_loop is None:
                self._all_conditional_parameters_read_with_loop = func._explore_functions(
                    lambda x: self._explore_func_cond_read(x, include_loop)
                )
            self._all_conditional_parameters_read_with_loop = list(filter(lambda x: x in func.parameters, self._all_conditional_parameters_read_with_loop))
            return self._all_conditional_parameters_read_with_loop
        if self._all_conditional_parameters_read is None:
            self._all_conditional_parameters_read = func._explore_functions(
                lambda x: self._explore_func_cond_read(x, include_loop)
            )
        self._all_conditional_parameters_read = list(filter(lambda x: x in func.parameters, self._all_conditional_parameters_read))
        return self._all_conditional_parameters_read
  
    def propogate_control_solidity_dependencies(self, context: Function) -> List[SUPPORTED_TYPES]:
        con_solidity_vars: List[SUPPORTED_TYPES] = context.all_conditional_solidity_variables_read() 
        for internal_func in context.internal_calls:
            if isinstance(internal_func, Function):
              con_solidity_vars += self.propogate_control_solidity_dependencies(internal_func)
        return list(set(con_solidity_vars))
    
    def propogate_control_statevar_dependencies(self, context: Function) -> List[SUPPORTED_TYPES]:
        con_state_vars: List[SUPPORTED_TYPES] = context.all_conditional_solidity_variables_read() 
        for internal_func in context.internal_calls:
            if isinstance(internal_func, Function):
              con_state_vars += self.propogate_control_statevar_dependencies(internal_func)
        return list(set(con_state_vars))

    def propogate_control_parameter_dependencies(self, context: Function) -> List[SUPPORTED_TYPES]:
        con_param_vars: List[SUPPORTED_TYPES] = self.all_conditional_parameters_read(context) 
        con_param_vars = list(filter(lambda x: x in context.parameters or isinstance(x, SolidityVariable), con_param_vars))
        for internal_func in context.internal_calls:
            if isinstance(internal_func, Function):
              results = self.propogate_control_parameter_dependencies(internal_func)
              for item in results:
                  for param in context.parameters + context.all_solidity_variables_read():
                    if is_dependent(item, param, self.contract):
                        con_param_vars.append(param)
        return list(set(con_param_vars))

    def is_control_dependent(self, 
                             variable: SUPPORTED_TYPES, 
                             source: SUPPORTED_TYPES, 
                             context: Function) -> bool:
        con_solidity_vars: List[SUPPORTED_TYPES] = self.propogate_control_solidity_dependencies(context) 
        con_state_vars: List[SUPPORTED_TYPES] = self.propogate_control_statevar_dependencies(context)
        con_param_vars: List[SUPPORTED_TYPES] = self.propogate_control_parameter_dependencies(context)
        all_state_variables_written = context.all_state_variables_written()
        # print("con_solidity_vars", con_solidity_vars)
        # print("con_state_vars", con_state_vars)
        # print("con_param_vars", [str(item) for item in con_param_vars])
        return (source in con_solidity_vars or \
                source in con_state_vars or \
                source in con_param_vars ) and \
                variable in all_state_variables_written
    
    def is_dependent(self, 
                     variable: SUPPORTED_TYPES, 
                     source: SUPPORTED_TYPES, 
                     context: Context_types_API) -> bool:
        return self.is_data_dependent(variable, source, context) or \
                  self.is_control_dependent(variable, source, context)
    
   
    def is_feasible_implication(self, inv1: str, inv2: str, func: str) -> bool:
        """
        Check if inv1 => inv2 is feasible
        invariant 1 is the precondition and invariant 2 is the postcondition
        invariant 1 and invariant 2 are string representation of the invariant
        invariant format: "x > 0", "x[y] > 0", "old(x) > 0", "x > old(y)"
        """
        mapping_index_terminals = dict()
        def get_terminals_expr(expr: str) -> List[str]:
            expr = expr.strip()
            
            results = list()
            m = re.match(r"^VeriSol\.Old\((.*)\)$", expr)
            if m is not None:
                results.extend(get_terminals_expr(m.group(1)))
                return results
                 
            m = re.match(r"^VeriSol\.SumMapping\((.*)\)$", expr)
            if m is not None:
                results.extend(get_terminals_expr(m.group(1)))
                return results
            
            m = re.match(r"^\((.*)\)$", expr)
            if m is not None:
                results.extend(get_terminals_expr(m.group(1)))
                return results 
            m = re.match(r"^([_a-zA-Z][\w|\.]*)$", expr)
            if m is not None:
                results.append(m.group(1))
                return results 
            
            m = re.match(r"^([_a-zA-Z][\w|\.]*)\((.*)\)$", expr)
            if m is not None:
                results.extend(get_terminals_expr(m.group(2)))
                return results 
            
            m = re.match(r"^([_a-zA-Z][\w|\.]*)\.(.*)$", expr)
            if m is not None:
                results.append(m.group(1))
                m = re.match(r"^([_a-zA-Z][\w|\.]*)(\W.*)$", m.group(2))
                if m is not None:
                    results.extend(get_terminals_expr(m.group(2)))
                return results
            
            m = re.match(r"^([_a-zA-Z]\w*)\[(.*)\]\[(.*)\]$", expr)
            if m is not None:
                results.append(m.group(1))
                tmp1 = get_terminals_expr(m.group(2))
                tmp2 = get_terminals_expr(m.group(3))
                results.extend(tmp1)
                results.extend(tmp2)
                if m.group(1) not in mapping_index_terminals:
                    mapping_index_terminals[m.group(1)] = set()
                mapping_index_terminals[m.group(1)].update(tmp1)
                mapping_index_terminals[m.group(1)].update(tmp2)
                return results

            m = re.match(r"^([_a-zA-Z]\w*)\[(.*)\]$", expr)
            if m is not None:
                results.append(m.group(1))
                tmp1 = get_terminals_expr(m.group(2))
                results.extend(tmp1)
                if m.group(1) not in mapping_index_terminals:
                    mapping_index_terminals[m.group(1)] = set()
                mapping_index_terminals[m.group(1)].update(tmp1)
                return results
            
            return results
            
          
           
          

            



        def get_terminals(inv: str) -> List[str]:
            exprs = re.split(r'\+|-|\*|!=|==|>=|<=|>|<', inv)
            terminals = set()
            mapping_index_terminals.clear()
            for expr in exprs:
                expr = expr.strip()
                if expr == "":
                    continue
                terminals.update(get_terminals_expr(expr))
                continue
                m = re.match(r"^([_a-zA-Z][\w|\.]*)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    continue
                m = re.match(r"^VeriSol\.Old\(([_a-zA-Z][\w|\.]*)\)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    continue
                m = re.match(r"^VeriSol\.SumMapping([_a-zA-Z][\w|\.]*)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    continue
                m = re.match(r"^VeriSol\.Old\(VeriSol\.SumMapping([_a-zA-Z][\w|\.]*)\)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    continue
                m = re.match(r"^([_a-zA-Z][\w|\.]*)\.([_a-zA-Z][\w|\.]*)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    continue
                m = re.match(r"^VeriSol\.Old\(([_a-zA-Z][\w|\.]*)\.([_a-zA-Z][\w|\.]*)\)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    continue
                
                m = re.match(r"^([_a-zA-Z][\w|\.]*)\[([_a-zA-Z][\w|\.]*)\]\.([_a-zA-Z][\w|\.]*)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    terminals.add(m.group(2))
                    if m.group(1) not in mapping_index_terminals:
                        mapping_index_terminals[m.group(1)] = set()
                    mapping_index_terminals[m.group(1)].add(m.group(2))
                    continue
                m = re.match(r"^VeriSol\.Old\(([_a-zA-Z][\w|\.]*)\[([_a-zA-Z][\w|\.]*)\]\.([_a-zA-Z][\w|\.]*)\)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    terminals.add(m.group(2))
                    if m.group(1) not in mapping_index_terminals:
                        mapping_index_terminals[m.group(1)] = set()
                    mapping_index_terminals[m.group(1)].add(m.group(2))
                    continue

                m = re.match(r"^([_a-zA-Z][\w|\.]*)\[([_a-zA-Z][\w|\.]*)\]$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    terminals.add(m.group(2))
                    if m.group(1) not in mapping_index_terminals:
                        mapping_index_terminals[m.group(1)] = set()
                    mapping_index_terminals[m.group(1)].add(m.group(2))
                    continue
                m = re.match(r"^VeriSol\.Old\(([_a-zA-Z][\w|\.]*)\[([_a-zA-Z][\w|\.]*)\]\)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    terminals.add(m.group(2))
                    if m.group(1) not in mapping_index_terminals:
                        mapping_index_terminals[m.group(1)] = set()
                    mapping_index_terminals[m.group(1)].add(m.group(2))
                    continue
                m = re.match(r"^([_a-zA-Z][\w|\.]*)\[([_a-zA-Z][\w|\.]*)\]\[([_a-zA-Z][\w|\.]*)\]$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    terminals.add(m.group(2))
                    terminals.add(m.group(3))
                    if m.group(1) not in mapping_index_terminals:
                        mapping_index_terminals[m.group(1)] = set()
                    mapping_index_terminals[m.group(1)].add(m.group(2))
                    mapping_index_terminals[m.group(1)].add(m.group(3))
                    continue
                m = re.match(r"^VeriSol\.Old\(([_a-zA-Z][\w|\.]*)\[([_a-zA-Z][\w|\.]*)\]\[([_a-zA-Z][\w|\.]*)\]\)$", expr)
                if m is not None:
                    terminals.add(m.group(1))
                    terminals.add(m.group(2))
                    terminals.add(m.group(3))
                    if m.group(1) not in mapping_index_terminals:
                        mapping_index_terminals[m.group(1)] = set()
                    mapping_index_terminals[m.group(1)].add(m.group(2))
                    mapping_index_terminals[m.group(1)].add(m.group(3))
                    continue
            import copy 
            return terminals, copy.deepcopy(mapping_index_terminals)

        def findFunction(func_name):
            for function in self.contract.functions:
                if function.name == func_name and function.is_shadowed is False:
                    return function
            return None
        
        def findVariable(terminal):
            function = findFunction(func)
            assert function is not None
            for param in function.parameters + function.all_solidity_variables_read():
                    if str(param) == terminal:
                        return param
            for state_var in self.contract.state_variables_ordered:
                if str(state_var) == terminal:
                    return state_var
            assert False, "cannot find variable: " + terminal + " in function: " + func + " " + str(list(map(lambda x: x.name, function.parameters)))

        def all_hasTerminalsUse(func: FunctionContract,  terminals: [str])-> bool:
            for terminal in terminals:
                if terminal in ["true", "false"]:
                    continue 
                existLocal = any(map(lambda x: str(x) == terminal, func.parameters + func.all_solidity_variables_read()))
                existGlobal = any(map(lambda x: str(x) == terminal,func.all_state_variables_read()+func.all_state_variables_written()))
                if not existLocal and not existGlobal:
                    return False
            return True
    

        terminals_1, mapping_index_terminals_1 = get_terminals(inv1)
        terminals_2, mapping_index_terminals_2 = get_terminals(inv2)
        # print(inv1, terminals_1, mapping_index_terminals_1)
        # print(inv2, terminals_2, mapping_index_terminals_2)   
        
        myfunc = findFunction(func)
        
        if all_hasTerminalsUse(myfunc, terminals_1) is False or all_hasTerminalsUse(myfunc, terminals_2) is False:
            return False
        
        result = False
        for term1 in terminals_1:
            for term2 in terminals_2:
                if term1 != term2 and (term1 not in ["true", "false"] and term2 not in ["true", "false"]):
                    try:
                        ret = self.is_control_dependent(findVariable(term2), findVariable(term1), myfunc) \
                        or (self.is_data_dependent(findVariable(term2), findVariable(term1), myfunc) and term1 not in terminals_2) \
                            or (term2 in mapping_index_terminals_2 and term1 in mapping_index_terminals_2[term2])
                        # ret = self.is_control_dependent(findVariable(term2), findVariable(term1), myfunc) \
                        #  or (term2 in mapping_index_terminals_2 and term1 in mapping_index_terminals_2[term2])
                        if ret:
                            result = True
                    except:
                        pass 
        return result

def test():
    # TODO: add tests
    contract_file = "test_contracts/dependency_test.sol"
    contract_name  = "ZUCToken"
    from slither import Slither
    from subprocess import Popen, PIPE
    versions = Popen(["solc-select", "versions"], stdout=PIPE).communicate()[0]
    versions = versions.decode().split("\n")[:-2] 

    slither = Slither(contract_file, solc_solcs_select=",".join(versions))
    contract = slither.get_contract_from_name(contract_name)[0]
    print(contract.name)
    # compute_dependency_contract(contract, slither)
    dependency = Dependency(contract)
    for function in contract.functions:
        # if function.visibility != "external" and function.visibility != "public":
        #     continue
        if function.is_shadowed:
            continue
        results = dependency.get_all_data_dependencies(function)
        results =  [ (str(key), [str(item) for item in value]) for key, value in results.items()]
        print(function.full_name)
        print("all state variable read:", [str(item) for item in function.all_state_variables_read()])
        print("all solidity variable read:", [str(item) for item in function.all_solidity_variables_read()])
        print("all conditional state variable read:", [str(item) for item in dependency.propogate_control_statevar_dependencies(function)])
        print("all conditional solidity variable read:", [str(item) for item in dependency.propogate_control_solidity_dependencies(function)])
        print("all conditional parameters read:", [str(item) for item in dependency.propogate_control_parameter_dependencies(function)])
        
        print("all local variable read:", [str(item) for item in function.local_variables])
        print("all parameters:", [str(item) for item in function.parameters])
        print("all state variable written:", [str(item) for item in function.all_state_variables_written()])
        print("all non-primitive state variable written:", [str(item) for item in function.all_state_variables_written() if isinstance(item, StateVariable) and (isinstance(item.type,ArrayType) or isinstance(item.type, MappingType))])
        for _item in  [item for item in function.all_state_variables_written() if isinstance(item, StateVariable) and ( isinstance(item.type, MappingType))]:
            for param in function.parameters + function.all_solidity_variables_read():
                assert isinstance(_item.type,  MappingType)
                if _item.type.type_from == param.type:
                    print("index compatible: ", (str(_item), str(param)))
        print("all internal call expressions:", [str(item) for item in function.internal_calls])
        # print("detail of all internal call expressions:", [str(item) for item in function._expression_calls])
        # for item in function._expression_calls:
        #     assert isinstance(item, CallExpression)
        #     print("internal call:", str(item.called))
        #     print("arguments:", [str(arg) for arg in item.arguments])
        #     print("type call:", item.type_call)
        for item in function.all_state_variables_written():
            for param in function.parameters:
                print("is_dependent: ", (str(item), str(param)), dependency.is_dependent(item, param, function))
        print("**" * 20)
    
    
    results = dependency.get_all_data_dependencies(contract)
    results =  [ (function.name + "#" + str(key), [str(item) for item in value 
                                                #    if item in function.local_variables + function.all_state_variables_written()
                                                   ])\
                 for key, value in results.items()
                   for function in contract.functions \
                   if key in function.local_variables]
    print(results)

    # inv1 = "x > 0"
    # inv2 = "y > 0"
    inv1 = "msg.sender != recipient"
    # inv1 = "amount > 0"
    inv2 = "_balances[msg.sender] == old(_balances[msg.sender]) - amount"
    # inv1 = "spender != 9"
    # inv2 = "allowance[msg.sender][spender] == value"
    func = "transfer"
    print(dependency.is_feasible_implication(inv1, inv2, func))


def main():
    import argparse

    parser = argparse.ArgumentParser()
   
    subparsers = parser.add_subparsers(help="commands")
    single_parser = subparsers.add_parser("single", help="single implication feasibility query")
     
    single_parser.add_argument("--contract_file", help="contract file", type=str, required=True)
    single_parser.add_argument("--contract_name", help="contract name", type=str, required=True)
    
    single_parser.add_argument("--inv1", help="the first invariant text", type=str, required=True)
    single_parser.add_argument("--inv2", help="the second invariant text", type=str, required=True)
    single_parser.add_argument("--func", help="the function name", type=str, required=True)

    
    
    multi_parser = subparsers.add_parser("batch", help="multiple implication feasibility queries")
    multi_parser.add_argument("--contract_file", help="contract file", type=str, required=True)
    multi_parser.add_argument("--contract_name", help="contract name", type=str, required=True)
    
    multi_parser.add_argument("--query_arrays", help="the file containing the invariants", type=str, required=True)

    args = parser.parse_args()
    # return if the implication is feasible
    from slither import Slither
    from subprocess import Popen, PIPE
    versions = Popen(["solc-select", "versions"], stdout=PIPE).communicate()[0]
    versions = versions.decode().split("\n")[:-2]
    slither = Slither(args.contract_file, solc_solcs_select=",".join(versions))
    contract = slither.get_contract_from_name(args.contract_name)[0]
    dependency = Dependency(contract)
    if hasattr(args, "query_arrays") is False:
        if dependency.is_feasible_implication(args.inv1, args.inv2, args.func):
            print("Implication is feasible")
        else:
            print("Implication is not feasible")
        
        return 0 
    
    else:
        import json 
        ret = {}
        query_arrays = json.load(open(args.query_arrays))
        index = 0
        for query in query_arrays:
            inv1, inv2, func = query
            try:
                if dependency.is_feasible_implication(inv1, inv2, func):
                        # print("Implication is feasible")
                        ret[index] = "feasible" 
                # else:
                #         # print("Implication is not feasible")
                #         ret[index] = "not feasible"
            except:
                print(inv1, inv2, func)
                raise Exception("error")
            index += 1
        print(json.dumps(ret))
        return 0
   
if __name__ == "__main__":
    main()

# test command 
# python3 dependency.py single --contract_file test_contracts/dependency_test.sol --contract_name ZUCToken --inv1 "msg.sender != recipient" --inv2 "_balances[msg.sender] == old(_balances[msg.sender]) - amount" --func transfer