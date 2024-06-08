type Ref;
type ContractName;
const unique null: Ref;
const unique Arzdigital: ContractName;
const unique StandardToken: ContractName;
const unique Token: ContractName;
const unique IERC20: ContractName;
const unique VeriSol: ContractName;
const unique SafeMath: ContractName;
function ConstantToRef(x: int) returns (ret: Ref);
function BoogieRefToInt(x: Ref) returns (ret: int);
function {:bvbuiltin "mod"} modBpl(x: int, y: int) returns (ret: int);
function keccak256(x: int) returns (ret: int);
function abiEncodePacked1(x: int) returns (ret: int);
function _SumMapping_VeriSol(x: [Ref]int) returns (ret: int);
function abiEncodePacked2(x: int, y: int) returns (ret: int);
function abiEncodePacked1R(x: Ref) returns (ret: int);
function abiEncodePacked2R(x: Ref, y: int) returns (ret: int);
var Balance: [Ref]int;
var DType: [Ref]ContractName;
var Alloc: [Ref]bool;
var balance_ADDR: [Ref]int;
var M_Ref_int: [Ref][Ref]int;
var M_Ref_Ref: [Ref][Ref]Ref;
var M_int_Ref: [Ref][int]Ref;
var Length: [Ref]int;
var now: int;
procedure {:inline 1} FreshRefGenerator() returns (newRef: Ref);
implementation FreshRefGenerator() returns (newRef: Ref)
{
havoc newRef;
assume ((Alloc[newRef]) == (false));
Alloc[newRef] := true;
assume ((newRef) != (null));
}

procedure {:inline 1} HavocAllocMany();
implementation HavocAllocMany()
{
var oldAlloc: [Ref]bool;
oldAlloc := Alloc;
havoc Alloc;
assume (forall  __i__0_0:Ref ::  ((oldAlloc[__i__0_0]) ==> (Alloc[__i__0_0])));
}

procedure boogie_si_record_sol2Bpl_int(x: int);
procedure boogie_si_record_sol2Bpl_ref(x: Ref);
procedure boogie_si_record_sol2Bpl_bool(x: bool);

axiom(forall  __i__0_0:int, __i__0_1:int :: {ConstantToRef(__i__0_0), ConstantToRef(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((ConstantToRef(__i__0_0)) != (ConstantToRef(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {keccak256(__i__0_0), keccak256(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((keccak256(__i__0_0)) != (keccak256(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {abiEncodePacked1(__i__0_0), abiEncodePacked1(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1(__i__0_0)) != (abiEncodePacked1(__i__0_1)))));

axiom(forall  __i__0_0:[Ref]int ::  ((exists __i__0_1:Ref ::  ((__i__0_0[__i__0_1]) != (0))) || ((_SumMapping_VeriSol(__i__0_0)) == (0))));

axiom(forall  __i__0_0:[Ref]int, __i__0_1:Ref, __i__0_2:int ::  ((_SumMapping_VeriSol(__i__0_0[__i__0_1 := __i__0_2])) == (((_SumMapping_VeriSol(__i__0_0)) - (__i__0_0[__i__0_1])) + (__i__0_2))));

axiom(forall  __i__0_0:int, __i__0_1:int, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2(__i__0_0, __i__1_0)) != (abiEncodePacked2(__i__0_1, __i__1_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref :: {abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1R(__i__0_0)) != (abiEncodePacked1R(__i__0_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2R(__i__0_0, __i__1_0)) != (abiEncodePacked2R(__i__0_1, __i__1_1)))));
procedure {:inline 1} Arzdigital_Arzdigital_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Arzdigital_Arzdigital_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} Arzdigital_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Arzdigital_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 7} (true);
call Arzdigital_Arzdigital_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} totalSupply_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (supply_s10: int);
implementation totalSupply_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (supply_s10: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 9} (true);
}

procedure {:public} {:inline 1} balanceOf_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s18: Ref) returns (balance_s18: int);
implementation balanceOf_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s18: Ref) returns (balance_s18: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_owner"} boogie_si_record_sol2Bpl_ref(_owner_s18);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 13} (true);
}

procedure {:public} {:inline 1} transfer_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s28: Ref, _value_s28: int) returns (success_s28: bool);
implementation transfer_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s28: Ref, _value_s28: int) returns (success_s28: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s28);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s28);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 22} (true);
}

procedure {:public} {:inline 1} transferFrom_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s40: Ref, _to_s40: Ref, _value_s40: int) returns (success_s40: bool);
implementation transferFrom_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s40: Ref, _to_s40: Ref, _value_s40: int) returns (success_s40: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s40);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s40);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s40);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 33} (true);
}

procedure {:public} {:inline 1} approve_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s50: Ref, _value_s50: int) returns (success_s50: bool);
implementation approve_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s50: Ref, _value_s50: int) returns (success_s50: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s50);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s50);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 42} (true);
}

procedure {:public} {:inline 1} allowance_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s60: Ref, _spender_s60: Ref) returns (remaining_s60: int);
implementation allowance_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s60: Ref, _spender_s60: Ref) returns (remaining_s60: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_owner"} boogie_si_record_sol2Bpl_ref(_owner_s60);
call  {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s60);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 51} (true);
}

procedure {:inline 1} StandardToken_StandardToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation StandardToken_StandardToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_1: Ref;
var __var_2: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// Make array/mapping vars distinct for balances
call __var_1 := FreshRefGenerator();
balances_StandardToken[this] := __var_1;
// Initialize Integer mapping balances
assume (forall  __i__0_0:Ref ::  ((M_Ref_int[balances_StandardToken[this]][__i__0_0]) == (0)));
// Make array/mapping vars distinct for allowed
call __var_2 := FreshRefGenerator();
allowed_StandardToken[this] := __var_2;
// Initialize length of 1-level nested array in allowed
assume (forall  __i__0_0:Ref ::  ((Length[M_Ref_Ref[allowed_StandardToken[this]][__i__0_0]]) == (0)));
assume (forall  __i__0_0:Ref ::  (!(Alloc[M_Ref_Ref[allowed_StandardToken[this]][__i__0_0]])));
call HavocAllocMany();
assume (forall  __i__0_0:Ref ::  (Alloc[M_Ref_Ref[allowed_StandardToken[this]][__i__0_0]]));
assume (forall  __i__0_0:Ref, __i__0_1:Ref :: {M_Ref_Ref[allowed_StandardToken[this]][__i__0_0], M_Ref_Ref[allowed_StandardToken[this]][__i__0_1]} (((__i__0_0) == (__i__0_1)) || ((M_Ref_Ref[allowed_StandardToken[this]][__i__0_0]) != (M_Ref_Ref[allowed_StandardToken[this]][__i__0_1]))));
_totalSupply_StandardToken[this] := 0;
// end of initialization
}

procedure {:inline 1} StandardToken_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation StandardToken_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 61} (true);
call Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
call StandardToken_StandardToken_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} transfer_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s225: Ref, _value_s225: int) returns (success_s225: bool);
requires((_totalSupply_StandardToken[this]) == (_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])));
ensures((_totalSupply_StandardToken[this]) == (old(_totalSupply_StandardToken[this])));
ensures((_to_s225) == (old(_to_s225)));
ensures((_value_s225) == (old(_value_s225)));
ensures((msgsender_MSG) == (old(msgsender_MSG)));
ensures((old(_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]]))) == (_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])));
ensures((old((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) + (M_Ref_int[balances_StandardToken[this]][_to_s225]))) == ((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) + (M_Ref_int[balances_StandardToken[this]][_to_s225])));
implementation transfer_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s225: Ref, _value_s225: int) returns (success_s225: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s225);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s225);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 65} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 74} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assume ((_totalSupply_StandardToken[this]) >= (0));
assume ((old(_totalSupply_StandardToken[this])) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 75} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 76} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 77} (true);
assume ((_value_s225) >= (0));
assume ((_value_s225) >= (0));
assume ((old(_value_s225)) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 78} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 81} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]]))) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 87} (true);
assume ((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) >= (0));
assume ((M_Ref_int[balances_StandardToken[this]][_to_s225]) >= (0));
assume (((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) + (M_Ref_int[balances_StandardToken[this]][_to_s225])) >= (0));
assume ((old((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) + (M_Ref_int[balances_StandardToken[this]][_to_s225]))) >= (0));
assume ((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) >= (0));
assume ((M_Ref_int[balances_StandardToken[this]][_to_s225]) >= (0));
assume (((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) + (M_Ref_int[balances_StandardToken[this]][_to_s225])) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 95} (true);
assume ((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) >= (0));
assume ((_value_s225) >= (0));
assume ((_value_s225) >= (0));
if (((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) >= (_value_s225)) && ((_value_s225) > (0))) {
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 95} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 96} (true);
assume ((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) >= (0));
assume ((_value_s225) >= (0));
M_Ref_int[balances_StandardToken[this]][msgsender_MSG] := (M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) - (_value_s225);
call  {:cexpr "balances[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 97} (true);
assume ((M_Ref_int[balances_StandardToken[this]][_to_s225]) >= (0));
assume ((_value_s225) >= (0));
M_Ref_int[balances_StandardToken[this]][_to_s225] := (M_Ref_int[balances_StandardToken[this]][_to_s225]) + (_value_s225);
call  {:cexpr "balances[_to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][_to_s225]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 98} (true);
assert {:EventEmitted "Transfer_StandardToken"} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 99} (true);
success_s225 := true;
return;
} else {
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 100} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 101} (true);
success_s225 := false;
return;
}
}

procedure {:public} {:inline 1} transferFrom_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s289: Ref, _to_s289: Ref, _value_s289: int) returns (success_s289: bool);
implementation transferFrom_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s289: Ref, _to_s289: Ref, _value_s289: int) returns (success_s289: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s289);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s289);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s289);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 109} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 112} (true);
assume ((M_Ref_int[balances_StandardToken[this]][_from_s289]) >= (0));
assume ((_value_s289) >= (0));
assume ((M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s289]][msgsender_MSG]) >= (0));
assume ((_value_s289) >= (0));
assume ((_value_s289) >= (0));
if ((((M_Ref_int[balances_StandardToken[this]][_from_s289]) >= (_value_s289)) && ((M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s289]][msgsender_MSG]) >= (_value_s289))) && ((_value_s289) > (0))) {
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 116} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 117} (true);
assume ((M_Ref_int[balances_StandardToken[this]][_to_s289]) >= (0));
assume ((_value_s289) >= (0));
M_Ref_int[balances_StandardToken[this]][_to_s289] := (M_Ref_int[balances_StandardToken[this]][_to_s289]) + (_value_s289);
call  {:cexpr "balances[_to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][_to_s289]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 118} (true);
assume ((M_Ref_int[balances_StandardToken[this]][_from_s289]) >= (0));
assume ((_value_s289) >= (0));
M_Ref_int[balances_StandardToken[this]][_from_s289] := (M_Ref_int[balances_StandardToken[this]][_from_s289]) - (_value_s289);
call  {:cexpr "balances[_from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][_from_s289]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 119} (true);
assume ((M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s289]][msgsender_MSG]) >= (0));
assume ((_value_s289) >= (0));
M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s289]][msgsender_MSG] := (M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s289]][msgsender_MSG]) - (_value_s289);
call  {:cexpr "allowed[_from][msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s289]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 120} (true);
assert {:EventEmitted "Transfer_StandardToken"} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 121} (true);
success_s289 := true;
return;
} else {
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 122} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 123} (true);
success_s289 := false;
return;
}
}

procedure {:public} {:inline 1} balanceOf_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s301: Ref) returns (balance_s301: int);
implementation balanceOf_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s301: Ref) returns (balance_s301: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_owner"} boogie_si_record_sol2Bpl_ref(_owner_s301);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 127} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 128} (true);
assume ((M_Ref_int[balances_StandardToken[this]][_owner_s301]) >= (0));
balance_s301 := M_Ref_int[balances_StandardToken[this]][_owner_s301];
return;
}

procedure {:public} {:inline 1} approve_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s329: Ref, _value_s329: int) returns (success_s329: bool);
implementation approve_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s329: Ref, _value_s329: int) returns (success_s329: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s329);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s329);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 134} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 135} (true);
assume ((M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s329]) >= (0));
assume ((_value_s329) >= (0));
M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s329] := _value_s329;
call  {:cexpr "allowed[msg.sender][_spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s329]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 136} (true);
assert {:EventEmitted "Approval_StandardToken"} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 137} (true);
success_s329 := true;
return;
}

procedure {:public} {:inline 1} allowance_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s345: Ref, _spender_s345: Ref) returns (remaining_s345: int);
implementation allowance_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s345: Ref, _spender_s345: Ref) returns (remaining_s345: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_owner"} boogie_si_record_sol2Bpl_ref(_owner_s345);
call  {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s345);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 144} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 145} (true);
assume ((M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_owner_s345]][_spender_s345]) >= (0));
remaining_s345 := M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_owner_s345]][_spender_s345];
return;
}

var balances_StandardToken: [Ref]Ref;
var allowed_StandardToken: [Ref]Ref;
var _totalSupply_StandardToken: [Ref]int;
procedure {:inline 1} FallbackMethod_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation FallbackMethod_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 155} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 157} (true);
assume (false);
}

var name_Token: [Ref]int;
var decimals_Token: [Ref]int;
var symbol_Token: [Ref]int;
var version_Token: [Ref]int;
procedure {:inline 1} Token_Token_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Token_Token_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
name_Token[this] := -194436563;
decimals_Token[this] := 0;
symbol_Token[this] := -194436563;
version_Token[this] := 786364985;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 176} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 177} (true);
assume ((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) >= (0));
M_Ref_int[balances_StandardToken[this]][msgsender_MSG] := 820000000;
call  {:cexpr "balances[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 178} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
_totalSupply_StandardToken[this] := 820000000;
call  {:cexpr "_totalSupply"} boogie_si_record_sol2Bpl_int(_totalSupply_StandardToken[this]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 179} (true);
name_Token[this] := -1467848269;
call  {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_Token[this]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 180} (true);
assume ((decimals_Token[this]) >= (0));
decimals_Token[this] := 1;
call  {:cexpr "decimals"} boogie_si_record_sol2Bpl_int(decimals_Token[this]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 181} (true);
symbol_Token[this] := -847071745;
call  {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_Token[this]);
}

procedure {:constructor} {:public} {:inline 1} Token_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Token_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
call StandardToken_StandardToken(this, msgsender_MSG, msgvalue_MSG);
call Token_Token_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} approveAndCall_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s433: Ref, _value_s433: int, _extraData_s433: int) returns (success_s433: bool);
implementation approveAndCall_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s433: Ref, _value_s433: int, _extraData_s433: int) returns (success_s433: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s433);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s433);
call  {:cexpr "_extraData"} boogie_si_record_sol2Bpl_int(_extraData_s433);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 189} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 190} (true);
assume ((M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s433]) >= (0));
assume ((_value_s433) >= (0));
M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s433] := _value_s433;
call  {:cexpr "allowed[msg.sender][_spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s433]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 191} (true);
assert {:EventEmitted "Approval_Token"} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\Arz.sol"} {:sourceLine 207} (true);
success_s433 := true;
return;
}

procedure {:inline 1} IERC20_IERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC20_IERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} IERC20_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC20_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\IERC20.sol"} {:sourceLine 7} (true);
call IERC20_IERC20_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} totalSupply_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
procedure {:public} {:inline 1} balanceOf_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s448: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} transfer_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s457: Ref, amount_s457: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} allowance_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s466: Ref, spender_s466: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} approve_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s475: Ref, amount_s475: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} transferFrom_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s486: Ref, recipient_s486: Ref, amount_s486: int) returns (__ret_0_: bool);
procedure {:inline 1} SafeMath_SafeMath_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation SafeMath_SafeMath_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} SafeMath_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation SafeMath_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 16} (true);
call SafeMath_SafeMath_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s702: int, b_s702: int) returns (__ret_0_: int);
implementation add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s702: int, b_s702: int) returns (__ret_0_: int)
{
var c_s701: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s702);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s702);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 26} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 27} (true);
assume ((c_s701) >= (0));
assume ((a_s702) >= (0));
assume ((b_s702) >= (0));
assume (((a_s702) + (b_s702)) >= (0));
c_s701 := (a_s702) + (b_s702);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s701);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 28} (true);
assume ((c_s701) >= (0));
assume ((a_s702) >= (0));
assume ((c_s701) >= (a_s702));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 30} (true);
assume ((c_s701) >= (0));
__ret_0_ := c_s701;
return;
}

procedure {:inline 1} sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s727: int, b_s727: int) returns (__ret_0_: int);
implementation sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s727: int, b_s727: int) returns (__ret_0_: int)
{
var c_s726: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s727);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s727);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 42} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 43} (true);
assume ((b_s727) >= (0));
assume ((a_s727) >= (0));
assume ((b_s727) <= (a_s727));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 44} (true);
assume ((c_s726) >= (0));
assume ((a_s727) >= (0));
assume ((b_s727) >= (0));
assume (((a_s727) - (b_s727)) >= (0));
c_s726 := (a_s727) - (b_s727);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s726);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 46} (true);
assume ((c_s726) >= (0));
__ret_0_ := c_s726;
return;
}

procedure {:inline 1} mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s761: int, b_s761: int) returns (__ret_0_: int);
implementation mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s761: int, b_s761: int) returns (__ret_0_: int)
{
var c_s760: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s761);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s761);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 58} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 62} (true);
assume ((a_s761) >= (0));
if ((a_s761) == (0)) {
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 62} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 63} (true);
__ret_0_ := 0;
return;
}
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 66} (true);
assume ((c_s760) >= (0));
assume ((a_s761) >= (0));
assume ((b_s761) >= (0));
assume (((a_s761) * (b_s761)) >= (0));
c_s760 := (a_s761) * (b_s761);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s760);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 67} (true);
assume ((c_s760) >= (0));
assume ((a_s761) >= (0));
assume (((c_s760) div (a_s761)) >= (0));
assume ((b_s761) >= (0));
assume (((c_s760) div (a_s761)) == (b_s761));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 69} (true);
assume ((c_s760) >= (0));
__ret_0_ := c_s760;
return;
}

procedure {:inline 1} div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s786: int, b_s786: int) returns (__ret_0_: int);
implementation div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s786: int, b_s786: int) returns (__ret_0_: int)
{
var c_s785: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s786);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s786);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 83} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 85} (true);
assume ((b_s786) >= (0));
assume ((b_s786) > (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 86} (true);
assume ((c_s785) >= (0));
assume ((a_s786) >= (0));
assume ((b_s786) >= (0));
assume (((a_s786) div (b_s786)) >= (0));
c_s785 := (a_s786) div (b_s786);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s785);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 89} (true);
assume ((c_s785) >= (0));
__ret_0_ := c_s785;
return;
}

procedure {:inline 1} mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s807: int, b_s807: int) returns (__ret_0_: int);
implementation mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s807: int, b_s807: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s807);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s807);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 103} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 104} (true);
assume ((b_s807) >= (0));
assume ((b_s807) != (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\regressions\SafeMath.sol"} {:sourceLine 105} (true);
assume ((a_s807) >= (0));
assume ((b_s807) >= (0));
assume (((a_s807) mod (b_s807)) >= (0));
__ret_0_ := (a_s807) mod (b_s807);
return;
}

procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (IERC20)) {
assume ((amount) == (0));
} else if ((DType[to]) == (Token)) {
call FallbackMethod_Token(to, from, amount);
} else if ((DType[to]) == (StandardToken)) {
assume ((amount) == (0));
} else if ((DType[to]) == (Arzdigital)) {
assume ((amount) == (0));
} else {
call Fallback_UnknownType(from, to, amount);
}
}

procedure {:inline 1} Fallback_UnknownType(from: Ref, to: Ref, amount: int);
implementation Fallback_UnknownType(from: Ref, to: Ref, amount: int)
{
// ---- Logic for payable function START 
assume ((Balance[from]) >= (amount));
Balance[from] := (Balance[from]) - (amount);
Balance[to] := (Balance[to]) + (amount);
// ---- Logic for payable function END 
}

procedure {:inline 1} send(from: Ref, to: Ref, amount: int) returns (success: bool);
implementation send(from: Ref, to: Ref, amount: int) returns (success: bool)
{
if ((Balance[from]) >= (amount)) {
call FallbackDispatch(from, to, amount);
success := true;
} else {
success := false;
}
}

procedure BoogieEntry_Arzdigital();
implementation BoogieEntry_Arzdigital()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var supply_s10: int;
var _owner_s18: Ref;
var balance_s18: int;
var _to_s28: Ref;
var _value_s28: int;
var success_s28: bool;
var _from_s40: Ref;
var _to_s40: Ref;
var _value_s40: int;
var success_s40: bool;
var _spender_s50: Ref;
var _value_s50: int;
var success_s50: bool;
var _owner_s60: Ref;
var _spender_s60: Ref;
var remaining_s60: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((((DType[this]) == (Arzdigital)) || ((DType[this]) == (StandardToken))) || ((DType[this]) == (Token)));
call Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc supply_s10;
havoc _owner_s18;
havoc balance_s18;
havoc _to_s28;
havoc _value_s28;
havoc success_s28;
havoc _from_s40;
havoc _to_s40;
havoc _value_s40;
havoc success_s40;
havoc _spender_s50;
havoc _value_s50;
havoc success_s50;
havoc _owner_s60;
havoc _spender_s60;
havoc remaining_s60;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call supply_s10 := totalSupply_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (5)) {
call balance_s18 := balanceOf_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _owner_s18);
} else if ((choice) == (4)) {
call success_s28 := transfer_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _to_s28, _value_s28);
} else if ((choice) == (3)) {
call success_s40 := transferFrom_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _from_s40, _to_s40, _value_s40);
} else if ((choice) == (2)) {
call success_s50 := approve_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _spender_s50, _value_s50);
} else if ((choice) == (1)) {
call remaining_s60 := allowance_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _owner_s60, _spender_s60);
}
}
}

procedure BoogieEntry_StandardToken();
implementation BoogieEntry_StandardToken()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var supply_s10: int;
var _owner_s301: Ref;
var balance_s301: int;
var _to_s225: Ref;
var _value_s225: int;
var success_s225: bool;
var _from_s289: Ref;
var _to_s289: Ref;
var _value_s289: int;
var success_s289: bool;
var _spender_s329: Ref;
var _value_s329: int;
var success_s329: bool;
var _owner_s345: Ref;
var _spender_s345: Ref;
var remaining_s345: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (StandardToken)) || ((DType[this]) == (Token)));
call StandardToken_StandardToken(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc supply_s10;
havoc _owner_s301;
havoc balance_s301;
havoc _to_s225;
havoc _value_s225;
havoc success_s225;
havoc _from_s289;
havoc _to_s289;
havoc _value_s289;
havoc success_s289;
havoc _spender_s329;
havoc _value_s329;
havoc success_s329;
havoc _owner_s345;
havoc _spender_s345;
havoc remaining_s345;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call supply_s10 := totalSupply_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (5)) {
call balance_s301 := balanceOf_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s301);
} else if ((choice) == (4)) {
call success_s225 := transfer_StandardToken(this, msgsender_MSG, msgvalue_MSG, _to_s225, _value_s225);
} else if ((choice) == (3)) {
call success_s289 := transferFrom_StandardToken(this, msgsender_MSG, msgvalue_MSG, _from_s289, _to_s289, _value_s289);
} else if ((choice) == (2)) {
call success_s329 := approve_StandardToken(this, msgsender_MSG, msgvalue_MSG, _spender_s329, _value_s329);
} else if ((choice) == (1)) {
call remaining_s345 := allowance_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s345, _spender_s345);
}
}
}

procedure BoogieEntry_Token();
implementation BoogieEntry_Token()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var supply_s10: int;
var _owner_s301: Ref;
var balance_s301: int;
var _to_s225: Ref;
var _value_s225: int;
var success_s225: bool;
var _from_s289: Ref;
var _to_s289: Ref;
var _value_s289: int;
var success_s289: bool;
var _spender_s329: Ref;
var _value_s329: int;
var success_s329: bool;
var _owner_s345: Ref;
var _spender_s345: Ref;
var remaining_s345: int;
var _spender_s433: Ref;
var _value_s433: int;
var _extraData_s433: int;
var success_s433: bool;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (Token));
call Token_Token(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc supply_s10;
havoc _owner_s301;
havoc balance_s301;
havoc _to_s225;
havoc _value_s225;
havoc success_s225;
havoc _from_s289;
havoc _to_s289;
havoc _value_s289;
havoc success_s289;
havoc _spender_s329;
havoc _value_s329;
havoc success_s329;
havoc _owner_s345;
havoc _spender_s345;
havoc remaining_s345;
havoc _spender_s433;
havoc _value_s433;
havoc _extraData_s433;
havoc success_s433;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
if ((choice) == (7)) {
call supply_s10 := totalSupply_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (6)) {
call balance_s301 := balanceOf_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s301);
} else if ((choice) == (5)) {
call success_s225 := transfer_StandardToken(this, msgsender_MSG, msgvalue_MSG, _to_s225, _value_s225);
} else if ((choice) == (4)) {
call success_s289 := transferFrom_StandardToken(this, msgsender_MSG, msgvalue_MSG, _from_s289, _to_s289, _value_s289);
} else if ((choice) == (3)) {
call success_s329 := approve_StandardToken(this, msgsender_MSG, msgvalue_MSG, _spender_s329, _value_s329);
} else if ((choice) == (2)) {
call remaining_s345 := allowance_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s345, _spender_s345);
} else if ((choice) == (1)) {
call success_s433 := approveAndCall_Token(this, msgsender_MSG, msgvalue_MSG, _spender_s433, _value_s433, _extraData_s433);
}
}
}

procedure BoogieEntry_IERC20();
implementation BoogieEntry_IERC20()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (IERC20));
call IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_SafeMath();
implementation BoogieEntry_SafeMath()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (SafeMath));
call SafeMath_SafeMath(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
}
}

procedure CorralChoice_Arzdigital(this: Ref);
implementation CorralChoice_Arzdigital(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var supply_s10: int;
var _owner_s18: Ref;
var balance_s18: int;
var _to_s28: Ref;
var _value_s28: int;
var success_s28: bool;
var _from_s40: Ref;
var _to_s40: Ref;
var _value_s40: int;
var success_s40: bool;
var _spender_s50: Ref;
var _value_s50: int;
var success_s50: bool;
var _owner_s60: Ref;
var _spender_s60: Ref;
var remaining_s60: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc supply_s10;
havoc _owner_s18;
havoc balance_s18;
havoc _to_s28;
havoc _value_s28;
havoc success_s28;
havoc _from_s40;
havoc _to_s40;
havoc _value_s40;
havoc success_s40;
havoc _spender_s50;
havoc _value_s50;
havoc success_s50;
havoc _owner_s60;
havoc _spender_s60;
havoc remaining_s60;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call supply_s10 := totalSupply_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (5)) {
call balance_s18 := balanceOf_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _owner_s18);
} else if ((choice) == (4)) {
call success_s28 := transfer_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _to_s28, _value_s28);
} else if ((choice) == (3)) {
call success_s40 := transferFrom_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _from_s40, _to_s40, _value_s40);
} else if ((choice) == (2)) {
call success_s50 := approve_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _spender_s50, _value_s50);
} else if ((choice) == (1)) {
call remaining_s60 := allowance_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _owner_s60, _spender_s60);
}
}

procedure CorralEntry_Arzdigital();
implementation CorralEntry_Arzdigital()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((((DType[this]) == (Arzdigital)) || ((DType[this]) == (StandardToken))) || ((DType[this]) == (Token)));
call Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_Arzdigital(this);
}
}

procedure CorralChoice_StandardToken(this: Ref);
implementation CorralChoice_StandardToken(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var supply_s10: int;
var _owner_s301: Ref;
var balance_s301: int;
var _to_s225: Ref;
var _value_s225: int;
var success_s225: bool;
var _from_s289: Ref;
var _to_s289: Ref;
var _value_s289: int;
var success_s289: bool;
var _spender_s329: Ref;
var _value_s329: int;
var success_s329: bool;
var _owner_s345: Ref;
var _spender_s345: Ref;
var remaining_s345: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc supply_s10;
havoc _owner_s301;
havoc balance_s301;
havoc _to_s225;
havoc _value_s225;
havoc success_s225;
havoc _from_s289;
havoc _to_s289;
havoc _value_s289;
havoc success_s289;
havoc _spender_s329;
havoc _value_s329;
havoc success_s329;
havoc _owner_s345;
havoc _spender_s345;
havoc remaining_s345;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call supply_s10 := totalSupply_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (5)) {
call balance_s301 := balanceOf_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s301);
} else if ((choice) == (4)) {
call success_s225 := transfer_StandardToken(this, msgsender_MSG, msgvalue_MSG, _to_s225, _value_s225);
} else if ((choice) == (3)) {
call success_s289 := transferFrom_StandardToken(this, msgsender_MSG, msgvalue_MSG, _from_s289, _to_s289, _value_s289);
} else if ((choice) == (2)) {
call success_s329 := approve_StandardToken(this, msgsender_MSG, msgvalue_MSG, _spender_s329, _value_s329);
} else if ((choice) == (1)) {
call remaining_s345 := allowance_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s345, _spender_s345);
}
}

procedure CorralEntry_StandardToken();
implementation CorralEntry_StandardToken()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume (((DType[this]) == (StandardToken)) || ((DType[this]) == (Token)));
call StandardToken_StandardToken(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_StandardToken(this);
}
}

procedure CorralChoice_Token(this: Ref);
implementation CorralChoice_Token(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var supply_s10: int;
var _owner_s301: Ref;
var balance_s301: int;
var _to_s225: Ref;
var _value_s225: int;
var success_s225: bool;
var _from_s289: Ref;
var _to_s289: Ref;
var _value_s289: int;
var success_s289: bool;
var _spender_s329: Ref;
var _value_s329: int;
var success_s329: bool;
var _owner_s345: Ref;
var _spender_s345: Ref;
var remaining_s345: int;
var _spender_s433: Ref;
var _value_s433: int;
var _extraData_s433: int;
var success_s433: bool;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc supply_s10;
havoc _owner_s301;
havoc balance_s301;
havoc _to_s225;
havoc _value_s225;
havoc success_s225;
havoc _from_s289;
havoc _to_s289;
havoc _value_s289;
havoc success_s289;
havoc _spender_s329;
havoc _value_s329;
havoc success_s329;
havoc _owner_s345;
havoc _spender_s345;
havoc remaining_s345;
havoc _spender_s433;
havoc _value_s433;
havoc _extraData_s433;
havoc success_s433;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
if ((choice) == (7)) {
call supply_s10 := totalSupply_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (6)) {
call balance_s301 := balanceOf_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s301);
} else if ((choice) == (5)) {
call success_s225 := transfer_StandardToken(this, msgsender_MSG, msgvalue_MSG, _to_s225, _value_s225);
} else if ((choice) == (4)) {
call success_s289 := transferFrom_StandardToken(this, msgsender_MSG, msgvalue_MSG, _from_s289, _to_s289, _value_s289);
} else if ((choice) == (3)) {
call success_s329 := approve_StandardToken(this, msgsender_MSG, msgvalue_MSG, _spender_s329, _value_s329);
} else if ((choice) == (2)) {
call remaining_s345 := allowance_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s345, _spender_s345);
} else if ((choice) == (1)) {
call success_s433 := approveAndCall_Token(this, msgsender_MSG, msgvalue_MSG, _spender_s433, _value_s433, _extraData_s433);
}
}

procedure CorralEntry_Token();
implementation CorralEntry_Token()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (Token));
call Token_Token(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_Token(this);
}
}

procedure CorralChoice_IERC20(this: Ref);
implementation CorralChoice_IERC20(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
}

procedure CorralEntry_IERC20();
implementation CorralEntry_IERC20()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (IERC20));
call IERC20_IERC20(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_IERC20(this);
}
}

procedure CorralChoice_SafeMath(this: Ref);
implementation CorralChoice_SafeMath(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (Token));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (SafeMath));
Alloc[msgsender_MSG] := true;
}

procedure CorralEntry_SafeMath();
implementation CorralEntry_SafeMath()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (SafeMath));
call SafeMath_SafeMath(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_SafeMath(this);
}
}


