from invconplus.invariant.ternary.IntTernary import IntTernary
from invconplus.const import INVARIANT_STYLE
class LinearyEq(IntTernary):
    def __init__(self, varInfos) -> None:
        super().__init__(varInfos)    
        self.core: LinearyCore = None 
    
    def _check(self, val_1, val_2, val_3):
        if self.core is None:
            self._verified = False
            self.core = LinearyCore(val_1, val_2, val_3, self.varInfos[0].name, self.varInfos[1].name, self.varInfos[2].name)
            return True
        elif self.core.x_1 == val_1 and self.core.y_1 == val_2 and self.core.z_1 == val_3:
            self._verified = False
            return True
        elif (self.core.y_1 * val_1 - val_2 * self.core.x_1) == 0:
            self._verified = False
            return True
        else:
            self._verified = True
            success = self.core.addNewPoint(val_1, val_2, val_3)
            return success
    
    def __str__(self) -> str:
        expr = self.core.__str__()
        if expr == "":
            return ""
        if INVARIANT_STYLE == "VERISOL":
            if self.isPostCondition():
                desc = "VeriSol.Ensures({0})".format(self.core.__str__())
            else:
                desc = "VeriSol.Requires({0})".format(self.core.__str__())
            return desc
        elif INVARIANT_STYLE == "DAIKON":
            desc = "{0}".format(self.core.__str__())
            return desc
        else:
            desc = "LinearyEq({0})".format(self.core.__str__())
            return desc

class LinearyCore:
    x_1, y_1, z_1 = None, None, None
    a, b, c = None, None, None
    x_name, y_name, z_name = None, None, None
    
    def __init__(self, x, y, z, x_name, y_name, z_name):
        self.x_1, self.y_1, self.z_1 = x, y, z
        self.a, self.b, self.c = None, None, None
        self.x_name, self.y_name, self.z_name = x_name, y_name, z_name
      
    # equation: ax + by + z = 0 let c = 1
    def addNewPoint(self, x_2, y_2, z_2):
        # a* x * x_2 + b* y * x_2 + z * x_2 = 0
        # a* x_2 * x + b* y_2 * x + z_2 * x = 0
        a, b, c = self.a, self.b, self.c
        if (self.y_1 * x_2 - y_2 * self.x_1) == 0:
            return False
        
        if self.a is not None and self.b is not None:
            if self.a == 0 or self.b == 0:
                return False
            if abs(self.a) != 1 or abs(self.b) != 1:
                return False
            if self.a * x_2 + self.b * y_2 + z_2 != 0:
                return False
            else:
                return True

        # check if it's a line or not
        if (self.y_1 * x_2 - y_2 * self.x_1) != 0:
            self.c = 1
            self.b = int(-(self.z_1 * x_2 - z_2 * self.x_1) / (self.y_1 * x_2 - y_2 * self.x_1))
            if self.x_1 != 0:
                self.a = int((-self.z_1 - self.b * self.y_1) / self.x_1)
            else:
                # x_1 == 0 and x_2 == 0 can not hold at the same time
                self.a = int((-z_2 - self.b * y_2) / x_2)
        else:
            return False

            
        # if self.a == 0:
        #     return False
        
        # if self.b == 0:
        #     return False

        # there is no guarantee that a and b are 1 or -1
        # assert a == 1 or a == -1
        # assert b == 1 or b == -1
        if self.a == 0 or self.b == 0:
            self.a = a 
            self.b = b 
            self.c = c 
            return False
        if abs(self.a) != 1 or abs(self.b) != 1:
            self.a = a 
            self.b = b 
            self.c = c 
            return False

        return True
    
    def __str__(self) -> str:
        if self.c == 1:
            assert self.c == 1, "c should be 1"
            if self.a == -1:
                return "{0} {1} {2} == {3}".format(self.z_name, "+" if self.b == 1 else "-", self.y_name, self.x_name)
            elif self.b == -1:
                return "{0} {1} {2} == {3}".format(self.z_name, "+" if self.a == 1 else "-", self.x_name, self.y_name)
            else:
                # assert False, "a or b should be -1"
                return ""
        else:
            return ""
       
