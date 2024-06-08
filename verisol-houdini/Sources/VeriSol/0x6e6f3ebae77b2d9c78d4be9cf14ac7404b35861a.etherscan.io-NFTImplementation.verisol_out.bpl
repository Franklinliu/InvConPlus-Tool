type Ref;
type ContractName;
const unique null: Ref;
const unique Initializable: ContractName;
const unique SafeMath: ContractName;
const unique Counters: ContractName;
const unique Counters.Counter: ContractName;
const unique Context: ContractName;
const unique IERC165: ContractName;
const unique IERC721: ContractName;
const unique IERC721Receiver: ContractName;
const unique Address: ContractName;
const unique VeriSol: ContractName;
function ConstantToRef(x: int) returns (ret: Ref);
function BoogieRefToInt(x: Ref) returns (ret: int);
function {:bvbuiltin "mod"} modBpl(x: int, y: int) returns (ret: int);
function keccak256(x: int) returns (ret: int);
function abiEncodePacked1(x: int) returns (ret: int);
function _SumMapping_VeriSol(x: [Ref]int) returns (ret: int);
function _SumMappingIntInt_VeriSol(x: [int]int) returns (ret: int);
function abiEncodePacked2(x: int, y: int) returns (ret: int);
function abiEncodePacked1R(x: Ref) returns (ret: int);
function abiEncodePacked2R(x: Ref, y: int) returns (ret: int);
var Balance: [Ref]int;
var DType: [Ref]ContractName;
var Alloc: [Ref]bool;
var balance_ADDR: [Ref]int;
var M_Ref_int: [Ref][Ref]int;
var M_int_int: [Ref][int]int;
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
procedure {:inline 1} Counters.Counter_ctor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _value: int);
implementation Counters.Counter_ctor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _value: int)
{
_value_Counters.Counter[this] := _value;
}


axiom(forall  __i__0_0:int, __i__0_1:int :: {ConstantToRef(__i__0_0), ConstantToRef(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((ConstantToRef(__i__0_0)) != (ConstantToRef(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {keccak256(__i__0_0), keccak256(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((keccak256(__i__0_0)) != (keccak256(__i__0_1)))));

axiom(forall  __i__0_0:int, __i__0_1:int :: {abiEncodePacked1(__i__0_0), abiEncodePacked1(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1(__i__0_0)) != (abiEncodePacked1(__i__0_1)))));

axiom(forall  __i__0_0:[Ref]int ::  ((exists __i__0_1:Ref ::  ((__i__0_0[__i__0_1]) != (0))) || ((_SumMapping_VeriSol(__i__0_0)) == (0))));

axiom(forall  __i__0_0:[Ref]int, __i__0_1:Ref, __i__0_2:int ::  ((_SumMapping_VeriSol(__i__0_0[__i__0_1 := __i__0_2])) == (((_SumMapping_VeriSol(__i__0_0)) - (__i__0_0[__i__0_1])) + (__i__0_2))));

axiom(forall  __i__0_0:[int]int ::  ((exists __i__0_1:int ::  ((__i__0_0[__i__0_1]) != (0))) || ((_SumMappingIntInt_VeriSol(__i__0_0)) == (0))));

axiom(forall  __i__0_0:[int]int, __i__0_1:int, __i__0_2:int ::  ((_SumMappingIntInt_VeriSol(__i__0_0[__i__0_1 := __i__0_2])) == (((_SumMappingIntInt_VeriSol(__i__0_0)) - (__i__0_0[__i__0_1])) + (__i__0_2))));

axiom(forall  __i__0_0:int, __i__0_1:int, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2(__i__0_0, __i__1_0)) != (abiEncodePacked2(__i__0_1, __i__1_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref :: {abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1R(__i__0_0)) != (abiEncodePacked1R(__i__0_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2R(__i__0_0, __i__1_0)) != (abiEncodePacked2R(__i__0_1, __i__1_1)))));
procedure {:inline 1} Initializable_Initializable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Initializable_Initializable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
initialized_Initializable[this] := false;
initializing_Initializable[this] := false;
// end of initialization
}

procedure {:inline 1} Initializable_Initializable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Initializable_Initializable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 14} (true);
call Initializable_Initializable_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

var initialized_Initializable: [Ref]bool;
var initializing_Initializable: [Ref]bool;
procedure {:inline 1} isConstructor_Initializable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: bool);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 51} (true);
call SafeMath_SafeMath_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s94: int, b_s94: int) returns (__ret_0_: int);
implementation add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s94: int, b_s94: int) returns (__ret_0_: int)
{
var c_s93: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s94);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s94);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 57} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 58} (true);
assume ((c_s93) >= (0));
assume ((a_s94) >= (0));
assume ((b_s94) >= (0));
assume (((a_s94) + (b_s94)) >= (0));
c_s93 := (a_s94) + (b_s94);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s93);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 59} (true);
assume ((c_s93) >= (0));
assume ((a_s94) >= (0));
assume ((c_s93) >= (a_s94));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 60} (true);
assume ((c_s93) >= (0));
__ret_0_ := c_s93;
return;
}

procedure {:inline 1} sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s110: int, b_s110: int) returns (__ret_0_: int);
implementation sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s110: int, b_s110: int) returns (__ret_0_: int)
{
var __var_2: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s110);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s110);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 68} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 69} (true);
assume ((__var_2) >= (0));
assume ((a_s110) >= (0));
assume ((b_s110) >= (0));
call __var_2 := sub_SafeMath(this, msgsender_MSG, msgvalue_MSG, a_s110, b_s110, 806148266);
assume ((__var_2) >= (0));
__ret_0_ := __var_2;
return;
}

procedure {:inline 1} sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s137: int, b_s137: int, errorMessage_s137: int) returns (__ret_0_: int);
implementation sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s137: int, b_s137: int, errorMessage_s137: int) returns (__ret_0_: int)
{
var c_s136: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s137);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s137);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s137);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 78} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 79} (true);
assume ((b_s137) >= (0));
assume ((a_s137) >= (0));
assume ((b_s137) <= (a_s137));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 80} (true);
assume ((c_s136) >= (0));
assume ((a_s137) >= (0));
assume ((b_s137) >= (0));
assume (((a_s137) - (b_s137)) >= (0));
c_s136 := (a_s137) - (b_s137);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s136);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 81} (true);
assume ((c_s136) >= (0));
__ret_0_ := c_s136;
return;
}

procedure {:inline 1} mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s172: int, b_s172: int) returns (__ret_0_: int);
implementation mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s172: int, b_s172: int) returns (__ret_0_: int)
{
var c_s171: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s172);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s172);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 89} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 90} (true);
assume ((a_s172) >= (0));
if ((a_s172) == (0)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 90} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 91} (true);
__ret_0_ := 0;
return;
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 93} (true);
assume ((c_s171) >= (0));
assume ((a_s172) >= (0));
assume ((b_s172) >= (0));
assume (((a_s172) * (b_s172)) >= (0));
c_s171 := (a_s172) * (b_s172);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s171);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 94} (true);
assume ((c_s171) >= (0));
assume ((a_s172) >= (0));
assume ((((c_s171) div (a_s172))) >= (0));
assume ((b_s172) >= (0));
assume ((((c_s171) div (a_s172))) == (b_s172));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 95} (true);
assume ((c_s171) >= (0));
__ret_0_ := c_s171;
return;
}

procedure {:inline 1} div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s188: int, b_s188: int) returns (__ret_0_: int);
implementation div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s188: int, b_s188: int) returns (__ret_0_: int)
{
var __var_3: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s188);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s188);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 105} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 106} (true);
assume ((__var_3) >= (0));
assume ((a_s188) >= (0));
assume ((b_s188) >= (0));
call __var_3 := div_SafeMath(this, msgsender_MSG, msgvalue_MSG, a_s188, b_s188, 725242315);
assume ((__var_3) >= (0));
__ret_0_ := __var_3;
return;
}

procedure {:inline 1} div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s215: int, b_s215: int, errorMessage_s215: int) returns (__ret_0_: int);
implementation div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s215: int, b_s215: int, errorMessage_s215: int) returns (__ret_0_: int)
{
var c_s214: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s215);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s215);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s215);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 117} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 118} (true);
assume ((b_s215) >= (0));
assume ((b_s215) > (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 119} (true);
assume ((c_s214) >= (0));
assume ((a_s215) >= (0));
assume ((b_s215) >= (0));
assume (((a_s215) div (b_s215)) >= (0));
c_s214 := (a_s215) div (b_s215);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s214);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 120} (true);
assume ((c_s214) >= (0));
__ret_0_ := c_s214;
return;
}

procedure {:inline 1} mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s231: int, b_s231: int) returns (__ret_0_: int);
implementation mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s231: int, b_s231: int) returns (__ret_0_: int)
{
var __var_4: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s231);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s231);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 130} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 131} (true);
assume ((__var_4) >= (0));
assume ((a_s231) >= (0));
assume ((b_s231) >= (0));
call __var_4 := mod_SafeMath(this, msgsender_MSG, msgvalue_MSG, a_s231, b_s231, -824698145);
assume ((__var_4) >= (0));
__ret_0_ := __var_4;
return;
}

procedure {:inline 1} mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s254: int, b_s254: int, errorMessage_s254: int) returns (__ret_0_: int);
implementation mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s254: int, b_s254: int, errorMessage_s254: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s254);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s254);
call  {:cexpr "errorMessage"} boogie_si_record_sol2Bpl_int(errorMessage_s254);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 142} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 143} (true);
assume ((b_s254) >= (0));
assume ((b_s254) != (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 144} (true);
assume ((a_s254) >= (0));
assume ((b_s254) >= (0));
assume (((a_s254) mod (b_s254)) >= (0));
__ret_0_ := (a_s254) mod (b_s254);
return;
}

procedure {:inline 1} Counters_Counters_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Counters_Counters_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} Counters_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Counters_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 156} (true);
call Counters_Counters_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

var _value_Counters.Counter: [Ref]int;
procedure {:inline 1} current_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, counter_s272: Ref) returns (__ret_0_: int);
implementation current_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, counter_s272: Ref) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 163} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 164} (true);
assume ((_value_Counters.Counter[counter_s272]) >= (0));
__ret_0_ := _value_Counters.Counter[counter_s272];
return;
}

procedure {:inline 1} increment_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, counter_s284: Ref);
implementation increment_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, counter_s284: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 167} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 168} (true);
assume ((_value_Counters.Counter[counter_s284]) >= (0));
_value_Counters.Counter[counter_s284] := (_value_Counters.Counter[counter_s284]) + (1);
call  {:cexpr "counter._value"} boogie_si_record_sol2Bpl_int(_value_Counters.Counter[counter_s284]);
}

procedure {:inline 1} decrement_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, counter_s300: Ref);
implementation decrement_Counters(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, counter_s300: Ref)
{
var __var_5: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 171} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 172} (true);
assume ((_value_Counters.Counter[counter_s300]) >= (0));
assume ((_value_Counters.Counter[counter_s300]) >= (0));
call __var_5 := sub_SafeMath(this, this, 0, _value_Counters.Counter[counter_s300], 1);
_value_Counters.Counter[counter_s300] := __var_5;
assume ((__var_5) >= (0));
call  {:cexpr "counter._value"} boogie_si_record_sol2Bpl_int(_value_Counters.Counter[counter_s300]);
}

procedure {:inline 1} Context_Context_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Context_Context_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 177} (true);
}

procedure {:constructor} {:public} {:inline 1} Context_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Context_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call Initializable_Initializable(this, msgsender_MSG, msgvalue_MSG);
call Context_Context_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} _msgSender_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: Ref);
implementation _msgSender_Context(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 179} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 180} (true);
__ret_0_ := msgsender_MSG;
return;
}

procedure {:inline 1} IERC165_IERC165_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC165_IERC165_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} IERC165_IERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC165_IERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 194} (true);
call IERC165_IERC165_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} supportsInterface_IERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s324: int) returns (__ret_0_: bool);
procedure {:inline 1} IERC721_IERC721_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721_IERC721_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} IERC721_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 204} (true);
call Initializable_Initializable(this, msgsender_MSG, msgvalue_MSG);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} balanceOf_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s360: Ref) returns (balance_s360: int);
procedure {:public} {:inline 1} ownerOf_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s367: int) returns (owner_s367: Ref);
procedure {:public} {:inline 1} safeTransferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s376: Ref, to_s376: Ref, tokenId_s376: int);
procedure {:public} {:inline 1} transferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s385: Ref, to_s385: Ref, tokenId_s385: int);
procedure {:public} {:inline 1} approve_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s392: Ref, tokenId_s392: int);
procedure {:public} {:inline 1} getApproved_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s399: int) returns (operator_s399: Ref);
procedure {:public} {:inline 1} setApprovalForAll_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, operator_s406: Ref, _approved_s406: bool);
procedure {:public} {:inline 1} isApprovedForAll_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s415: Ref, operator_s415: Ref) returns (__ret_0_: bool);
procedure {:public} {:inline 1} __safeTransferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s426: Ref, to_s426: Ref, tokenId_s426: int, data_s426: int);
procedure {:inline 1} IERC721Receiver_IERC721Receiver_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721Receiver_IERC721Receiver_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} IERC721Receiver_IERC721Receiver(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721Receiver_IERC721Receiver(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 248} (true);
call IERC721Receiver_IERC721Receiver_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} onERC721Received_IERC721Receiver(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, operator_s440: Ref, from_s440: Ref, tokenId_s440: int, data_s440: int) returns (__ret_0_: int);
procedure {:inline 1} Address_Address_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Address_Address_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} Address_Address(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation Address_Address(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 265} (true);
call Address_Address_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} isContract_Address(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s458: Ref) returns (__ret_0_: bool);
procedure {:inline 1} toPayable_Address(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s472: Ref) returns (__ret_0_: Ref);
implementation toPayable_Address(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s472: Ref) returns (__ret_0_: Ref)
{
var __var_6: Ref;
var __var_7: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "account"} boogie_si_record_sol2Bpl_ref(account_s472);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 287} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 288} (true);
assume ((__var_7) >= (0));
__var_7 := BoogieRefToInt(account_s472);
assume ((BoogieRefToInt(account_s472)) >= (0));
__var_6 := ConstantToRef(BoogieRefToInt(account_s472));
__ret_0_ := ConstantToRef(BoogieRefToInt(account_s472));
return;
}

procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (IERC721Receiver)) {
assume ((amount) == (0));
} else if ((DType[to]) == (IERC721)) {
assume ((amount) == (0));
} else if ((DType[to]) == (IERC165)) {
assume ((amount) == (0));
} else if ((DType[to]) == (Context)) {
assume ((amount) == (0));
} else if ((DType[to]) == (Initializable)) {
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

const {:existential true} HoudiniB1_Initializable: bool;
const {:existential true} HoudiniB2_Initializable: bool;
const {:existential true} HoudiniB3_Initializable: bool;
const {:existential true} HoudiniB4_Initializable: bool;
procedure BoogieEntry_Initializable();
implementation BoogieEntry_Initializable()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((((DType[this]) == (Initializable)) || ((DType[this]) == (Context))) || ((DType[this]) == (IERC721)));
call Initializable_Initializable(this, msgsender_MSG, msgvalue_MSG);
while (true)
  invariant (HoudiniB1_Initializable) ==> ((initialized_Initializable[this]) == (true));
  invariant (HoudiniB2_Initializable) ==> ((initialized_Initializable[this]) == (false));
  invariant (HoudiniB3_Initializable) ==> ((initializing_Initializable[this]) == (true));
  invariant (HoudiniB4_Initializable) ==> ((initializing_Initializable[this]) == (false));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
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
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_Counters();
implementation BoogieEntry_Counters()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (Counters));
call Counters_Counters(this, msgsender_MSG, msgvalue_MSG);
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
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

const {:existential true} HoudiniB1_Context: bool;
const {:existential true} HoudiniB2_Context: bool;
const {:existential true} HoudiniB3_Context: bool;
const {:existential true} HoudiniB4_Context: bool;
procedure BoogieEntry_Context();
implementation BoogieEntry_Context()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (Context));
call Context_Context(this, msgsender_MSG, msgvalue_MSG);
while (true)
  invariant (HoudiniB1_Context) ==> ((initialized_Initializable[this]) == (true));
  invariant (HoudiniB2_Context) ==> ((initialized_Initializable[this]) == (false));
  invariant (HoudiniB3_Context) ==> ((initializing_Initializable[this]) == (true));
  invariant (HoudiniB4_Context) ==> ((initializing_Initializable[this]) == (false));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_IERC165();
implementation BoogieEntry_IERC165()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (IERC165)) || ((DType[this]) == (IERC721)));
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
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
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

const {:existential true} HoudiniB1_IERC721: bool;
const {:existential true} HoudiniB2_IERC721: bool;
const {:existential true} HoudiniB3_IERC721: bool;
const {:existential true} HoudiniB4_IERC721: bool;
procedure BoogieEntry_IERC721();
implementation BoogieEntry_IERC721()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s324: int;
var __ret_0_supportsInterface: bool;
var owner_s360: Ref;
var balance_s360: int;
var tokenId_s367: int;
var owner_s367: Ref;
var from_s376: Ref;
var to_s376: Ref;
var tokenId_s376: int;
var from_s385: Ref;
var to_s385: Ref;
var tokenId_s385: int;
var to_s392: Ref;
var tokenId_s392: int;
var tokenId_s399: int;
var operator_s399: Ref;
var operator_s406: Ref;
var _approved_s406: bool;
var owner_s415: Ref;
var operator_s415: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s426: Ref;
var to_s426: Ref;
var tokenId_s426: int;
var data_s426: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (IERC721));
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
while (true)
  invariant (HoudiniB1_IERC721) ==> ((initialized_Initializable[this]) == (true));
  invariant (HoudiniB2_IERC721) ==> ((initialized_Initializable[this]) == (false));
  invariant (HoudiniB3_IERC721) ==> ((initializing_Initializable[this]) == (true));
  invariant (HoudiniB4_IERC721) ==> ((initializing_Initializable[this]) == (false));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s324;
havoc __ret_0_supportsInterface;
havoc owner_s360;
havoc balance_s360;
havoc tokenId_s367;
havoc owner_s367;
havoc from_s376;
havoc to_s376;
havoc tokenId_s376;
havoc from_s385;
havoc to_s385;
havoc tokenId_s385;
havoc to_s392;
havoc tokenId_s392;
havoc tokenId_s399;
havoc operator_s399;
havoc operator_s406;
havoc _approved_s406;
havoc owner_s415;
havoc operator_s415;
havoc __ret_0_isApprovedForAll;
havoc from_s426;
havoc to_s426;
havoc tokenId_s426;
havoc data_s426;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_supportsInterface := supportsInterface_IERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s324);
} else if ((choice) == (9)) {
call balance_s360 := balanceOf_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s360);
} else if ((choice) == (8)) {
call owner_s367 := ownerOf_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s367);
} else if ((choice) == (7)) {
call safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s376, to_s376, tokenId_s376);
} else if ((choice) == (6)) {
call transferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s385, to_s385, tokenId_s385);
} else if ((choice) == (5)) {
call approve_IERC721(this, msgsender_MSG, msgvalue_MSG, to_s392, tokenId_s392);
} else if ((choice) == (4)) {
call operator_s399 := getApproved_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s399);
} else if ((choice) == (3)) {
call setApprovalForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, operator_s406, _approved_s406);
} else if ((choice) == (2)) {
call __ret_0_isApprovedForAll := isApprovedForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s415, operator_s415);
} else if ((choice) == (1)) {
call __safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s426, to_s426, tokenId_s426, data_s426);
}
}
}

procedure BoogieEntry_IERC721Receiver();
implementation BoogieEntry_IERC721Receiver()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var operator_s440: Ref;
var from_s440: Ref;
var tokenId_s440: int;
var data_s440: int;
var __ret_0_onERC721Received: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (IERC721Receiver));
call IERC721Receiver_IERC721Receiver(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc operator_s440;
havoc from_s440;
havoc tokenId_s440;
havoc data_s440;
havoc __ret_0_onERC721Received;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call __ret_0_onERC721Received := onERC721Received_IERC721Receiver(this, msgsender_MSG, msgvalue_MSG, operator_s440, from_s440, tokenId_s440, data_s440);
}
}
}

procedure BoogieEntry_Address();
implementation BoogieEntry_Address()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (Address));
call Address_Address(this, msgsender_MSG, msgvalue_MSG);
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
assume ((DType[msgsender_MSG]) != (Initializable));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (Counters));
assume ((DType[msgsender_MSG]) != (Context));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

procedure {:inline 1} initializer_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__out_mod_isTopLevelCall_s47: bool);
implementation initializer_pre(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__out_mod_isTopLevelCall_s47: bool)
{
var __var_1: bool;
var isTopLevelCall_s47: bool;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 21} (true);
call __var_1 := isConstructor_Initializable(this, msgsender_MSG, msgvalue_MSG);
assume ((((initializing_Initializable[this]) || (__var_1))) || ((!(initialized_Initializable[this]))));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 22} (true);
isTopLevelCall_s47 := !(initializing_Initializable[this]);
call  {:cexpr "isTopLevelCall"} boogie_si_record_sol2Bpl_bool(isTopLevelCall_s47);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 23} (true);
if (isTopLevelCall_s47) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 23} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 24} (true);
initializing_Initializable[this] := true;
call  {:cexpr "initializing"} boogie_si_record_sol2Bpl_bool(initializing_Initializable[this]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 25} (true);
initialized_Initializable[this] := true;
call  {:cexpr "initialized"} boogie_si_record_sol2Bpl_bool(initialized_Initializable[this]);
}
__out_mod_isTopLevelCall_s47 := isTopLevelCall_s47;
}

procedure {:inline 1} initializer_post(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, isTopLevelCall_s47: bool);
implementation initializer_post(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, isTopLevelCall_s47: bool)
{
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 28} (true);
if (isTopLevelCall_s47) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 28} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x6e6f3ebae77b2d9c78d4be9cf14ac7404b35861a.etherscan.io-NFTImplementation.verisol.sol"} {:sourceLine 29} (true);
initializing_Initializable[this] := false;
call  {:cexpr "initializing"} boogie_si_record_sol2Bpl_bool(initializing_Initializable[this]);
}
}


