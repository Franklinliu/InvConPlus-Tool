# apply SAT satisfiability query to remove reductant invariants 
import z3 
from invconplus.invariant import Invariant, Binary, Unary, Ternary, IntEq, IntGe, IntGt, IntLe, IntLt, IntNotEq, AddressEq, AddressIsZero, AddressNotZero, StringIsNull, IntIsZero, IntGtZero, AddressNotEq, IntConstRange, IntSmallRange, Imply 

from typing import List, Any, Dict
class Supressor:
    solver: z3.Solver
    varsymMap: Dict
    varInfos: List 
    def __init__(self, varInfos: List) -> None:
        self.solver = z3.Solver()
        self.varInfos = varInfos
        self.varsymMap = self.translateVarInfos()
        
    def imply(self, invs: List[Invariant], test_inv: Invariant):
        self.solver.reset()
        for inv in invs:
            predicate = self.translateInv(inv)
            self.solver.add(predicate)
        result: z3.CheckSatResult = self.solver.check()
        assert result == z3.sat

        predicate = self.translateInv(test_inv)
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
            
    def translateInv(self, inv: Invariant):
            if isinstance(inv, Binary):
                if isinstance(inv, AddressEq):
                    return self.varsymMap[inv.varInfos[0].name]==self.varsymMap[inv.varInfos[1].name]
                elif isinstance(inv, AddressNotEq):
                    return self.varsymMap[inv.varInfos[0].name]!=self.varsymMap[inv.varInfos[1].name]
                elif isinstance(inv, IntEq):
                    return self.varsymMap[inv.varInfos[0].name]==self.varsymMap[inv.varInfos[1].name]
                elif isinstance(inv, IntNotEq):
                    return self.varsymMap[inv.varInfos[0].name]!=self.varsymMap[inv.varInfos[1].name]
                elif isinstance(inv, IntGe):
                    return self.varsymMap[inv.varInfos[0].name]>=self.varsymMap[inv.varInfos[1].name]
                elif isinstance(inv, IntGt):
                    return self.varsymMap[inv.varInfos[0].name]>self.varsymMap[inv.varInfos[1].name]
                elif isinstance(inv, IntLe):
                    return self.varsymMap[inv.varInfos[0].name]<=self.varsymMap[inv.varInfos[1].name]
                elif isinstance(inv, IntLt):
                    return self.varsymMap[inv.varInfos[0].name]<self.varsymMap[inv.varInfos[1].name]
                else:
                    assert False
            elif isinstance(inv, Unary):
                if isinstance(inv, AddressIsZero):
                    return self.varsymMap[inv.varInfos[0].name]==0
                elif isinstance(inv, AddressNotZero):
                    return self.varsymMap[inv.varInfos[0].name]!=0
                elif isinstance(inv, IntConstRange):
                    return self.varsymMap[inv.varInfos[0].name]==inv.constVal
                elif isinstance(inv, IntSmallRange):
                    result = False 
                    for constVal in inv.constVals:
                        result = z3.Or(result, self.varsymMap[inv.varInfos[0].name]==constVal)
                    return result
                elif isinstance(inv, IntIsZero):
                    return self.varsymMap[inv.varInfos[0].name]==0
                elif isinstance(inv, IntGtZero):
                    return self.varsymMap[inv.varInfos[0].name]>0
                elif isinstance(inv, StringIsNull):
                    # return self.varsymMap[inv.varInfos[0].name]==0
                    return True 
                else:
                    return True 
            elif isinstance(inv, Ternary):
                return True
            elif isinstance(inv, Imply):
                return True 
            else:
                assert False

    def translateVarInfos(self):
        results = dict()
        for varInfo in self.varInfos:
            results[varInfo.name] = z3.Int(varInfo.name)
        return results


def testZ3():
    x = z3.Int("x")
    y = z3.Int("y")
    result = z3.solve(x>=y, x<y)
    print(type(result), result)
    solver = z3.Solver()
    solver.add(x>y)
    solver.add(x<y)
    result = solver.check()
    print(type(result), result)

if __name__ == "__main__":
    testZ3()