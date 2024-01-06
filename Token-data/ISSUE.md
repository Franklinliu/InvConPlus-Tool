Result is not correct

/home/liuye/Projects/InvConPlus/Token-data/out/0xf8ccad1b25a54ce12f1b1ee56ef0f2a930d3e969-Finder.txt-3
True invariant:
transfer(_to,_value): VeriSol.Ensures(balances[_to] >= _value)
transfer(_to,_value): VeriSol.Ensures(!(VeriSol.Old(owner) == _to) || (balances[_to] >= _value))
transfer(_to,_value): VeriSol.Ensures(!(VeriSol.Old(owner) != _to) || (balances[_to] >= _value))