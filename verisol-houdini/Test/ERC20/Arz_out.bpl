type Ref;
type ContractName;
const unique null: Ref;
const unique Arzdigital: ContractName;
const unique StandardToken: ContractName;
const unique IERC20: ContractName;
const unique SafeMath: ContractName;
const unique VeriSol: ContractName;
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 7} (true);
call Arzdigital_Arzdigital_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} transfer_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s30: Ref, _value_s30: int) returns (success_s30: bool);
implementation transfer_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s30: Ref, _value_s30: int) returns (success_s30: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s30);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s30);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 23} (true);
}

var name_StandardToken: [Ref]int;
var decimals_StandardToken: [Ref]int;
var symbol_StandardToken: [Ref]int;
var version_StandardToken: [Ref]int;
var test_StandardToken: [Ref]Ref;
var balances_StandardToken: [Ref]Ref;
var allowed_StandardToken: [Ref]Ref;
var _totalSupply_StandardToken: [Ref]int;
procedure {:inline 1} contractInvariant_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
const {:existential true} HoudiniF1_StandardToken_StandardToken_NoBaseCtor: bool;
const {:existential true} HoudiniF2_StandardToken_StandardToken_NoBaseCtor: bool;
const {:existential true} HoudiniF3_StandardToken_StandardToken_NoBaseCtor: bool;
const {:existential true} HoudiniF4_StandardToken_StandardToken_NoBaseCtor: bool;
procedure {:inline 1} StandardToken_StandardToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
requires HoudiniF1_StandardToken_StandardToken_NoBaseCtor ==> ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) == (0));
ensures HoudiniF2_StandardToken_StandardToken_NoBaseCtor ==> ((_totalSupply_StandardToken[this]) == (820000000));
ensures HoudiniF3_StandardToken_StandardToken_NoBaseCtor ==> ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) == (820000000));
ensures HoudiniF4_StandardToken_StandardToken_NoBaseCtor ==> ((_totalSupply_StandardToken[this]) == (_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])));
implementation StandardToken_StandardToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_1: Ref;
var __var_2: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
name_StandardToken[this] := 923778741;
decimals_StandardToken[this] := 0;
symbol_StandardToken[this] := 923778741;
version_StandardToken[this] := 584016479;
test_StandardToken[this] := null;
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
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 40} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 41} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 42} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 43} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 44} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 45} (true);
assume ((M_Ref_int[balances_StandardToken[this]][msgsender_MSG]) >= (0));
M_Ref_int[balances_StandardToken[this]][msgsender_MSG] := 820000000;
call  {:cexpr "balances[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][msgsender_MSG]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 46} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
_totalSupply_StandardToken[this] := 820000000;
call  {:cexpr "_totalSupply"} boogie_si_record_sol2Bpl_int(_totalSupply_StandardToken[this]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 47} (true);
name_StandardToken[this] := 372478603;
call  {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_StandardToken[this]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 48} (true);
assume ((decimals_StandardToken[this]) >= (0));
decimals_StandardToken[this] := 1;
call  {:cexpr "decimals"} boogie_si_record_sol2Bpl_int(decimals_StandardToken[this]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 49} (true);
symbol_StandardToken[this] := 163917082;
call  {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_StandardToken[this]);
}

procedure {:constructor} {:public} {:inline 1} StandardToken_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation StandardToken_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_1: Ref;
var __var_2: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
call StandardToken_StandardToken_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

const {:existential true} HoudiniF5_transfer_StandardToken: bool;
const {:existential true} HoudiniF6_transfer_StandardToken: bool;
const {:existential true} HoudiniF7_transfer_StandardToken: bool;
const {:existential true} HoudiniF8_transfer_StandardToken: bool;
procedure {:public} {:inline 1} transfer_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s189: Ref, _value_s189: int) returns (success_s189: bool);
requires HoudiniF5_transfer_StandardToken ==> ((_totalSupply_StandardToken[this]) == (820000000));
requires HoudiniF6_transfer_StandardToken ==> ((_totalSupply_StandardToken[this]) == (_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])));
ensures HoudiniF7_transfer_StandardToken ==> ((_totalSupply_StandardToken[this]) == (820000000));
ensures HoudiniF8_transfer_StandardToken ==> ((_totalSupply_StandardToken[this]) == (_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])));
implementation transfer_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s189: Ref, _value_s189: int) returns (success_s189: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s189);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s189);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 55} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 56} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 57} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 58} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 59} (true);
assume ((_totalSupply_StandardToken[this]) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/Arz.sol"} {:sourceLine 60} (true);
success_s189 := true;
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/IERC20.sol"} {:sourceLine 7} (true);
call IERC20_IERC20_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} totalSupply_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
procedure {:public} {:inline 1} balanceOf_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s204: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} transfer_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s213: Ref, amount_s213: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} allowance_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s222: Ref, spender_s222: Ref) returns (__ret_0_: int);
procedure {:public} {:inline 1} approve_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s231: Ref, amount_s231: int) returns (__ret_0_: bool);
procedure {:public} {:inline 1} transferFrom_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s242: Ref, recipient_s242: Ref, amount_s242: int) returns (__ret_0_: bool);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 16} (true);
call SafeMath_SafeMath_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s286: int, b_s286: int) returns (__ret_0_: int);
implementation add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s286: int, b_s286: int) returns (__ret_0_: int)
{
var c_s285: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s286);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s286);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 26} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 27} (true);
assume ((c_s285) >= (0));
assume ((a_s286) >= (0));
assume ((b_s286) >= (0));
assume (((a_s286) + (b_s286)) >= (0));
c_s285 := (a_s286) + (b_s286);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s285);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 28} (true);
assume ((c_s285) >= (0));
assume ((a_s286) >= (0));
assume ((c_s285) >= (a_s286));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 30} (true);
assume ((c_s285) >= (0));
__ret_0_ := c_s285;
return;
}

procedure {:inline 1} sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s311: int, b_s311: int) returns (__ret_0_: int);
implementation sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s311: int, b_s311: int) returns (__ret_0_: int)
{
var c_s310: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s311);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s311);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 42} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 43} (true);
assume ((b_s311) >= (0));
assume ((a_s311) >= (0));
assume ((b_s311) <= (a_s311));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 44} (true);
assume ((c_s310) >= (0));
assume ((a_s311) >= (0));
assume ((b_s311) >= (0));
assume (((a_s311) - (b_s311)) >= (0));
c_s310 := (a_s311) - (b_s311);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s310);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 46} (true);
assume ((c_s310) >= (0));
__ret_0_ := c_s310;
return;
}

procedure {:inline 1} mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s345: int, b_s345: int) returns (__ret_0_: int);
implementation mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s345: int, b_s345: int) returns (__ret_0_: int)
{
var c_s344: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s345);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s345);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 58} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 62} (true);
assume ((a_s345) >= (0));
if ((a_s345) == (0)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 62} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 63} (true);
__ret_0_ := 0;
return;
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 66} (true);
assume ((c_s344) >= (0));
assume ((a_s345) >= (0));
assume ((b_s345) >= (0));
assume (((a_s345) * (b_s345)) >= (0));
c_s344 := (a_s345) * (b_s345);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s344);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 67} (true);
assume ((c_s344) >= (0));
assume ((a_s345) >= (0));
assume (((c_s344) div (a_s345)) >= (0));
assume ((b_s345) >= (0));
assume (((c_s344) div (a_s345)) == (b_s345));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 69} (true);
assume ((c_s344) >= (0));
__ret_0_ := c_s344;
return;
}

procedure {:inline 1} div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s370: int, b_s370: int) returns (__ret_0_: int);
implementation div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s370: int, b_s370: int) returns (__ret_0_: int)
{
var c_s369: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s370);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s370);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 83} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 85} (true);
assume ((b_s370) >= (0));
assume ((b_s370) > (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 86} (true);
assume ((c_s369) >= (0));
assume ((a_s370) >= (0));
assume ((b_s370) >= (0));
assume (((a_s370) div (b_s370)) >= (0));
c_s369 := (a_s370) div (b_s370);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s369);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 89} (true);
assume ((c_s369) >= (0));
__ret_0_ := c_s369;
return;
}

procedure {:inline 1} mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s391: int, b_s391: int) returns (__ret_0_: int);
implementation mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s391: int, b_s391: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s391);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s391);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 103} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 104} (true);
assume ((b_s391) >= (0));
assume ((b_s391) != (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/Test/ERC20/SafeMath.sol"} {:sourceLine 105} (true);
assume ((a_s391) >= (0));
assume ((b_s391) >= (0));
assume (((a_s391) mod (b_s391)) >= (0));
__ret_0_ := (a_s391) mod (b_s391);
return;
}

procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (IERC20)) {
assume ((amount) == (0));
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
var _to_s30: Ref;
var _value_s30: int;
var success_s30: bool;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (Arzdigital)) || ((DType[this]) == (StandardToken)));
call Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _to_s30;
havoc _value_s30;
havoc success_s30;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call success_s30 := transfer_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _to_s30, _value_s30);
}
}
}

const {:existential true} HoudiniB1_StandardToken: bool;
const {:existential true} HoudiniB2_StandardToken: bool;
const {:existential true} HoudiniB3_StandardToken: bool;
const {:existential true} HoudiniB4_StandardToken: bool;
const {:existential true} HoudiniB5_StandardToken: bool;
const {:existential true} HoudiniB6_StandardToken: bool;
const {:existential true} HoudiniB7_StandardToken: bool;
const {:existential true} HoudiniB8_StandardToken: bool;
const {:existential true} HoudiniB9_StandardToken: bool;
const {:existential true} HoudiniB10_StandardToken: bool;
const {:existential true} HoudiniB11_StandardToken: bool;
const {:existential true} HoudiniB12_StandardToken: bool;
const {:existential true} HoudiniC13_StandardToken: bool;
procedure BoogieEntry_StandardToken();
implementation BoogieEntry_StandardToken()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var _to_s189: Ref;
var _value_s189: int;
var success_s189: bool;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (StandardToken));
call StandardToken_StandardToken(this, msgsender_MSG, msgvalue_MSG);
while (true)
  invariant (HoudiniB1_StandardToken) ==> ((test_StandardToken[this]) == (null));
  invariant (HoudiniB2_StandardToken) ==> ((test_StandardToken[this]) != (null));
  invariant (HoudiniB3_StandardToken) ==> ((name_StandardToken[this]) == (0));
  invariant (HoudiniB4_StandardToken) ==> ((name_StandardToken[this]) != (0));
  invariant (HoudiniB5_StandardToken) ==> ((symbol_StandardToken[this]) == (0));
  invariant (HoudiniB6_StandardToken) ==> ((symbol_StandardToken[this]) != (0));
  invariant (HoudiniB7_StandardToken) ==> ((version_StandardToken[this]) == (0));
  invariant (HoudiniB8_StandardToken) ==> ((version_StandardToken[this]) != (0));
  invariant (HoudiniB9_StandardToken) ==> ((_totalSupply_StandardToken[this]) == (0));
  invariant (HoudiniB10_StandardToken) ==> ((_totalSupply_StandardToken[this]) != (0));
  invariant (HoudiniB11_StandardToken) ==> ((_totalSupply_StandardToken[this]) >= (0));
  invariant (HoudiniB12_StandardToken) ==> ((_totalSupply_StandardToken[this]) <= (0));
  invariant (HoudiniC13_StandardToken) ==> ((_totalSupply_StandardToken[this]) == (_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _to_s189;
havoc _value_s189;
havoc success_s189;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call success_s189 := transfer_StandardToken(this, msgsender_MSG, msgvalue_MSG, _to_s189, _value_s189);
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
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
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
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

procedure CorralChoice_Arzdigital(this: Ref);
implementation CorralChoice_Arzdigital(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var _to_s30: Ref;
var _value_s30: int;
var success_s30: bool;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _to_s30;
havoc _value_s30;
havoc success_s30;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call success_s30 := transfer_Arzdigital(this, msgsender_MSG, msgvalue_MSG, _to_s30, _value_s30);
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
assume (((DType[this]) == (Arzdigital)) || ((DType[this]) == (StandardToken)));
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
var _to_s189: Ref;
var _value_s189: int;
var success_s189: bool;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc _to_s189;
havoc _value_s189;
havoc success_s189;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Arzdigital));
assume ((DType[msgsender_MSG]) != (StandardToken));
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call success_s189 := transfer_StandardToken(this, msgsender_MSG, msgvalue_MSG, _to_s189, _value_s189);
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
assume ((DType[this]) == (StandardToken));
call StandardToken_StandardToken(this, msgsender_MSG, msgvalue_MSG);
while (true)
  invariant (_totalSupply_StandardToken[this]) == (_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]]));
{
call CorralChoice_StandardToken(this);
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
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
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
assume ((DType[msgsender_MSG]) != (IERC20));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
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


