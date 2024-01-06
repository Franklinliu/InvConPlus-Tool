# reduce reduductant invariants
# e.g (1) A -> B (2) A -> B \/ C
# (2) is reductant and should be removed.
# do not support invariant format in " a + b * c == d"
# only support invariant format in "a * b + c == d"
from enum import Enum
from dataclasses import dataclass
import re 
import z3 
from typing import List,  Dict, Any
import pprint
import os 
from functools import lru_cache

class TOKENKIND(Enum):
    NORMAL = 0
    ADD = 1
    SUB = 2
    MUL = 3
    GT = 4
    GE = 5
    LT = 6
    LE = 7
    EQ = 8 
    NEQ = 9
    AND = 10
    OR = 11
    NOT = 12
    IMPLY = 13
    BRACKET_LEFT = 14
    BRACKET_RIGHT = 15
    SPACE = 16
    ERROR = 17

def tokenName(token: TOKENKIND):
    if token == TOKENKIND.ADD:
        return " + "
    elif token == TOKENKIND.SUB:
        return " - "
    elif token == TOKENKIND.MUL:
        return " * "
    elif token == TOKENKIND.GT:
        return " > "
    elif token == TOKENKIND.GE:
        return " >= "
    elif token == TOKENKIND.LT:
        return " < "
    elif token == TOKENKIND.LE:
        return " <= "
    elif token == TOKENKIND.EQ:
        return " == "
    elif token == TOKENKIND.NEQ:
        return " != "
    elif token == TOKENKIND.AND:
        return " && "
    elif token == TOKENKIND.OR:
        return " || "
    elif token == TOKENKIND.NOT:
        return " || "
    elif token == TOKENKIND.IMPLY:
        return " => "
    else:
        assert False, token
    
def prority(token: TOKENKIND):
    if token == TOKENKIND.ADD:
        return 1
    elif token == TOKENKIND.SUB:
        return 1
    elif token == TOKENKIND.MUL:
        return 2
    elif token == TOKENKIND.GT:
        return 0
    elif token == TOKENKIND.GE:
        return 0
    elif token == TOKENKIND.LT:
        return 0
    elif token == TOKENKIND.LE:
        return 0
    elif token == TOKENKIND.EQ:
        return 0
    elif token == TOKENKIND.NEQ:
        return 0
    elif token == TOKENKIND.AND:
        return -1
    elif token == TOKENKIND.OR:
        return -1
    elif token == TOKENKIND.NOT:
        return -1
    elif token == TOKENKIND.IMPLY:
        return -2
    elif token == TOKENKIND.BRACKET_LEFT:
        return -3
    elif token == TOKENKIND.BRACKET_RIGHT:
        return -3
    else:
        assert False, token


@dataclass   
class LogicUnaryExpr:
    op: TOKENKIND
    expr: Any
    # def __str__(self) -> str:
    #     return tokenName(self.op) + str(self.expr)

@dataclass   
class LogicBinaryExpr:
    left: Any 
    op: TOKENKIND
    right: Any
    # def __str__(self) -> str:
    #     return str(self.left) + tokenName(self.op) + str(self.right)

@dataclass   
class BinaryExpr:
    left: Any 
    op: TOKENKIND
    right: Any
    # def __str__(self) -> str:
    #     return str(self.left) + tokenName(self.op) + str(self.right)


# evaluate expression logic
def eval(inv_expr):
    pass 

def token(char, nextchar, pointer):
    if char == " ":
        return TOKENKIND.SPACE, pointer
    elif char == ">":
        if nextchar is not None:
            if nextchar == "=":
                pointer += 1
                return TOKENKIND.GE, pointer
            else:
                return TOKENKIND.GT, pointer
        else:
            return TOKENKIND.GT, pointer
    elif char == "<":
        if nextchar is not None:
            if nextchar == "=":
                pointer += 1
                return TOKENKIND.LE, pointer
            else:
                return TOKENKIND.LT, pointer
        else:
            return TOKENKIND.LT, pointer
    elif char == "!":
        if nextchar is not None:
            if nextchar == "=":
                pointer += 1
                return TOKENKIND.NEQ, pointer
            else:
                return TOKENKIND.NOT, pointer
        else:
            return TOKENKIND.NOT, pointer
    elif char == "=":
        if nextchar is not None:
            if nextchar == "=":
                pointer += 1
                return TOKENKIND.EQ, pointer
            elif nextchar == ">":
                pointer += 1
                return TOKENKIND.IMPLY, pointer
            else:
                return TOKENKIND.ERROR, pointer
        else:
            return TOKENKIND.ERROR, pointer
    elif char == "+":
        return TOKENKIND.ADD, pointer
    elif char == "-":
        return TOKENKIND.SUB, pointer
    elif char == "*":
        return TOKENKIND.MUL, pointer
    elif char == "|":
        if nextchar is not None:
            if nextchar == "|":
                pointer += 1
                return TOKENKIND.OR, pointer
            else:
                return TOKENKIND.ERROR, pointer
        else:
            return TOKENKIND.ERROR, pointer
    elif char == "&":
        if nextchar is not None:
            if nextchar == "&":
                pointer += 1
                return TOKENKIND.AND, pointer
            else:
                return TOKENKIND.ERROR, pointer
        else:
            return TOKENKIND.ERROR, pointer
    elif char == "(":
        return TOKENKIND.BRACKET_LEFT, pointer
    elif char == ")":
        return TOKENKIND.BRACKET_RIGHT, pointer
    else:
        return TOKENKIND.NORMAL, pointer

@lru_cache(maxsize = None)
def parser(string: str):
    size = len(string)
    start = 0
    terminals = list()
    terminal = ""
    left_bracket_no = 0 
    right_bracket_no = 0
    stack = list()
    middle_exprs = list()
    operator_stack = list()
    while start < size:
        mytoken, next =  token(string[start], string[start+1] if start+1 < size else None, start + 1)
        if mytoken == TOKENKIND.ERROR:
            assert False, "{0} contain error at index {}".format(string, next-1)
        elif mytoken == TOKENKIND.NORMAL:
            terminal += string[start:next]
            start = next 
           
        elif mytoken == TOKENKIND.SPACE:
            start = next
           
            continue     
        else:
            if terminal != "":
                if mytoken == TOKENKIND.BRACKET_LEFT:
                    terminal += string[start:next]
                    left_bracket_no += 1
                elif mytoken == TOKENKIND.BRACKET_RIGHT and terminal.count(")") < left_bracket_no:
                    terminal += string[start:next]
                    right_bracket_no += 1
                else:
                    middle_exprs.append(terminal)
                    terminals.append(terminal)  
                    terminal = ""
                    left_bracket_no =  0
                    right_bracket_no =  0 
                    if len(operator_stack)>0:
                        if  mytoken in [TOKENKIND.ADD, TOKENKIND.SUB, TOKENKIND.MUL, TOKENKIND.GE, TOKENKIND.LT, TOKENKIND.LE, TOKENKIND.GT, TOKENKIND.EQ, TOKENKIND.NEQ, TOKENKIND.AND, TOKENKIND.OR, TOKENKIND.NOT, TOKENKIND.IMPLY]:
                            while len(operator_stack)>0 and prority(operator_stack[-1]) >= prority(mytoken):
                                last = operator_stack.pop()
                                middle_exprs.append(last)
                            operator_stack.append(mytoken)
                        elif mytoken == TOKENKIND.BRACKET_RIGHT:
                            while operator_stack[-1] != TOKENKIND.BRACKET_LEFT:
                                last = operator_stack.pop()
                                middle_exprs.append(last)
                            operator_stack.pop()
                        elif mytoken == TOKENKIND.BRACKET_LEFT:
                            operator_stack.append(mytoken)
                    else:
                        operator_stack.append(mytoken)
                        
            else:
                operator_stack.append(mytoken)
            
            start = next 
    
    if terminal != "":
            middle_exprs.append(terminal) 
            terminals.append(terminal)   
    
    while len(operator_stack)>0:
            last = operator_stack.pop()
            middle_exprs.append(last)

    # print(middle_exprs, terminals)
    while len(middle_exprs) != 1:
        i = 0        
        try:
            while i < len(middle_exprs) and middle_exprs[i] not in [TOKENKIND.ADD, TOKENKIND.SUB, TOKENKIND.MUL, TOKENKIND.GE, TOKENKIND.LT, TOKENKIND.LE, TOKENKIND.GT, TOKENKIND.EQ, TOKENKIND.NEQ, TOKENKIND.AND, TOKENKIND.OR, TOKENKIND.NOT, TOKENKIND.IMPLY]:
                i += 1
            
            if middle_exprs[i] == TOKENKIND.NOT:
                res = LogicUnaryExpr(middle_exprs[i], middle_exprs[i-1])
                middle_exprs = middle_exprs[:i-1]+[res] + middle_exprs[i+1:]
            else:
                if middle_exprs[i] in [TOKENKIND.ADD, TOKENKIND.SUB, TOKENKIND.MUL ]:
                    res = BinaryExpr(middle_exprs[i-2], middle_exprs[i], middle_exprs[i-1])
                    middle_exprs = middle_exprs[:i-2]+[res] + middle_exprs[i+1:]
                else:
                    res = LogicBinaryExpr(middle_exprs[i-2], middle_exprs[i], middle_exprs[i-1])
                    middle_exprs = middle_exprs[:i-2]+[res] + middle_exprs[i+1:]
        except:
            print(i, middle_exprs, string)
            assert False


    return middle_exprs, terminals



class Suppressor:
    solver: z3.Solver
    varsymMap: Dict
    def __init__(self, terminals: List) -> None:
        self.solver = z3.Solver()
        self.varsymMap = self.translateVarInfos(terminals)

    def imply(self, logicExprs: [LogicBinaryExpr], testLogicExpr: LogicBinaryExpr ):
        self.solver.reset()
        for inv in logicExprs:
            try:
                predicate = self.translate(inv)
                self.solver.add(predicate)
            except:
                assert False, inv
        result: z3.CheckSatResult = self.solver.check()
        assert result == z3.sat

        predicate = self.translate(testLogicExpr)
        # Invariant is defined to be preserved when predicate is True 
        if predicate ==  True:
            return False 
            
        self.solver.add(z3.Not(predicate))

        result: z3.CheckSatResult = self.solver.check()
        if result == z3.sat:
            return False
        elif result == z3.unsat:
            return True 
        elif result == z3.unknown:
            return False
        else:
            assert False
    
    def alwaysTrue(self, testLogicExpr: LogicBinaryExpr):
        self.solver.reset()
        predicate = self.translate(testLogicExpr)
        if predicate ==  True:
            return False 
        
        self.solver.add(z3.Not(predicate))
        result: z3.CheckSatResult = self.solver.check()
        if result == z3.sat:

            return False
        elif result == z3.unsat:
            return True 
        elif result == z3.unknown:
            return False
        else:
            assert False
    
    def translate(self, logicExpr: LogicBinaryExpr):
        if isinstance(logicExpr, str):
            return self.varsymMap[logicExpr]
        elif isinstance(logicExpr, LogicBinaryExpr):
            if logicExpr.op == TOKENKIND.AND:
                return z3.And(self.translate(logicExpr.left), self.translate(logicExpr.right))
            elif logicExpr.op == TOKENKIND.OR:
                return z3.Or(self.translate(logicExpr.left), self.translate(logicExpr.right))
            elif logicExpr.op == TOKENKIND.IMPLY:
                return z3.Implies(self.translate(logicExpr.left), self.translate(logicExpr.right))
            elif logicExpr.op == TOKENKIND.EQ:
                return self.translate(logicExpr.left) == self.translate(logicExpr.right)
            elif logicExpr.op == TOKENKIND.NEQ:
                return self.translate(logicExpr.left) != self.translate(logicExpr.right)
            elif logicExpr.op == TOKENKIND.GT:
                return self.translate(logicExpr.left) > self.translate(logicExpr.right)
            elif logicExpr.op == TOKENKIND.GE:
                return self.translate(logicExpr.left) >= self.translate(logicExpr.right)
            elif logicExpr.op == TOKENKIND.LT:
                return self.translate(logicExpr.left) < self.translate(logicExpr.right)
            elif logicExpr.op == TOKENKIND.LE:
                return self.translate(logicExpr.left) <= self.translate(logicExpr.right)
            else:
                assert False, logicExpr
        elif isinstance(logicExpr, LogicUnaryExpr):
            if logicExpr.op == TOKENKIND.NOT:
                return z3.Not(self.translate(logicExpr.exp))
            else:
                assert False
        elif isinstance(logicExpr, BinaryExpr):
            if logicExpr.op == TOKENKIND.ADD:
                return self.translate(logicExpr.left) + self.translate(logicExpr.right)
            elif logicExpr.op == TOKENKIND.SUB:
                return self.translate(logicExpr.left) - self.translate(logicExpr.right)
            elif  logicExpr.op == TOKENKIND.MUL:
                return self.translate(logicExpr.left) * self.translate(logicExpr.right)
            else:
                assert False
        else:
            assert False
            

    def translateVarInfos(self, terminals: List):
        results = dict()
        for terminal in terminals:
            results[terminal] = z3.Int(terminal)
        return results


def preprocess(inv_file, output_file):
    with open(inv_file) as f:
        lines = f.readlines()
        true_count = int(lines[0].split("Invariants with True value:")[-1].strip())
        false_count = int(lines[1].split("Invariants with False value:")[-1].strip())
        if true_count == 0:
            return 
        func_invs = dict()
        for line in lines[4:4+true_count]:
            line = line.strip()
            func_sig = line.split(":")[0].strip()
            isContractInvariant = func_sig.find("(")==-1
            ensuresOrRequires =  "Ensures" if line.find("Ensures")!=-1 else "Requires"
            inv_expr = line.split(ensuresOrRequires)[-1].strip()
            if isContractInvariant:
                inv_expr = re.sub('VeriSol\.ContractInvariant\((.*)\)', r'\1', inv_expr)
            stack, terminals = parser(inv_expr)
            # print(stack, terminals)
            assert len(stack) == 1, "stack should have only one item when parsing expression " + inv_expr + " in stack " +  str(stack)
            inv_expr = stack[-1]
            if func_sig not in func_invs:
                func_invs[func_sig] = dict()
            if ",".join(terminals)+"-"+ensuresOrRequires not in func_invs[func_sig]:
                func_invs[func_sig][",".join(terminals)+"-"+ensuresOrRequires] = list()
            func_invs[func_sig][",".join(terminals)+"-"+ensuresOrRequires].append(inv_expr)
        
        new_func_invs = dict()
        for func_sig in func_invs:
            new_func_invs[func_sig] = dict()
            for key in func_invs[func_sig]:
                items: List = func_invs[func_sig][key]
                supp = Suppressor(key.split("-")[0].split(","))
                while len(items) != 1:
                    start_item = items[-1]
                    strongest = True 
                    for i in range(0, len(items)-1):
                        if supp.imply([items[i]], start_item):
                            strongest = False 
                    
                    if strongest is False:
                        items.pop()
                    else:
                        items = items[-1:]
                new_func_invs[func_sig][key] = items[0]
        
        with open(output_file, "w") as fo:
            # print(new_func_invs)
            # size = sum([ len(new_func_invs[key]) for key in new_func_invs.keys()])
            final_func_invs = dict()
            for func_sig in new_func_invs:
                invariant_list = list()
                invalid_invs = list()
                for key in new_func_invs[func_sig]:
                    inv = new_func_invs[func_sig][key]
                    if isinstance(inv, LogicBinaryExpr) and inv.op in [ TOKENKIND.OR ]:
                        invalid_invs.append(str(inv))
                    else:
                        if isinstance(inv, LogicBinaryExpr) and inv.op in [ TOKENKIND.IMPLY ]:
                            supp = Suppressor(key.split("-")[0].split(","))
                            if not supp.alwaysTrue(inv.right):  
                                invariant_list.append(inv)
                        else:
                            invariant_list.append(inv)
                for inv in invariant_list:
                    if isinstance(inv, LogicBinaryExpr) and inv.op in [TOKENKIND.IMPLY]:
                        if str(inv.right) in invalid_invs:
                            invariant_list.remove(inv)
                       
                final_func_invs[func_sig] = invariant_list

            size = sum([ len(final_func_invs[key]) for key in final_func_invs.keys()])
            fo.write("original result: {0} invariants, smt-simplified result: {1} invariants\n".format(true_count, size))
           
            for func_sig in new_func_invs:
                fo.write(func_sig + ":\n")  

                for key in new_func_invs[func_sig]:
                    if new_func_invs[func_sig][key] not in final_func_invs[func_sig]:
                        continue
                    # print(key.split("-")[1].strip(), key.split("-")[0].split(","), new_func_invs[func_sig][key])
                    fo.write(key.split("-")[1].strip() + "\t\t" + str(new_func_invs[func_sig][key]) + "\n")


def test():
    # string = "a > b"
    # string = "spender != address(0) => VeriSol.SumMapping(_balances) > VeriSol.Old(_allowances[msg.sender][spender])"
    # stack, terminals = parser(string)
    # print(stack, terminals)
    result_dir = "../out-2-Sept"
    smt_simply_result_dir = "../out-2-Sept-smt-simply"
    if not os.path.exists(smt_simply_result_dir):
        os.mkdir(smt_simply_result_dir)
    for item in os.listdir(result_dir):
        inv_file = os.path.join(result_dir, item)
        ofile = os.path.join(smt_simply_result_dir, item)
        preprocess(inv_file=inv_file, output_file = ofile)
    # inv_file = "../out-31-Aug/0xfb36cd4519f246bdabefaa940df399a2ac636289-CodeWithJoe.txt-2"
    # output_file = "../out-31-Aug-smt-simply/0xfb36cd4519f246bdabefaa940df399a2ac636289-CodeWithJoe.txt-2"
    # preprocess(inv_file=inv_file, output_file = output_file)

    # string = "balances[to] > balances[msg.sender] || balances[to] <= balances[msg.sender]"
    # supp = Suppressor(["balances[to]", "balances[msg.sender]"])
    # string = "a > b || a <= b"
    # supp = Suppressor(["a", "b"])
    # stack, terminals = parser(string)
    # print(stack, list(set(terminals)))
    # print(supp.alwaysTrue(stack[0]))

if __name__ == "__main__":
    test()