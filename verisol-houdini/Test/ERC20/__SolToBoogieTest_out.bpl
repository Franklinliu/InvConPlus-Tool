type Ref;
type ContractName;
const unique null: Ref;
const unique tokenRecipient: ContractName;
const unique TokenERC20: ContractName;
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
procedure {:inline 1} tokenRecipient_tokenRecipient_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation tokenRecipient_tokenRecipient_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} tokenRecipient_tokenRecipient(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation tokenRecipient_tokenRecipient(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 5} (true);
call tokenRecipient_tokenRecipient_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} receiveApproval_tokenRecipient(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s13: Ref, _value_s13: int, _token_s13: Ref, _extraData_s13: int);
var name_TokenERC20: [Ref]int;
var symbol_TokenERC20: [Ref]int;
var decimals_TokenERC20: [Ref]int;
var totalSupply_TokenERC20: [Ref]int;
var balanceOf_TokenERC20: [Ref]Ref;
var allowance_TokenERC20: [Ref]Ref;
procedure {:inline 1} TokenERC20_TokenERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int);
implementation TokenERC20_TokenERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int)
{
var __var_1: int;
var __var_2: Ref;
var __var_3: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
name_TokenERC20[this] := 1213534088;
symbol_TokenERC20[this] := 1213534088;
decimals_TokenERC20[this] := 18;
totalSupply_TokenERC20[this] := 0;
// Make array/mapping vars distinct for balanceOf
call __var_2 := FreshRefGenerator();
balanceOf_TokenERC20[this] := __var_2;
// Initialize Integer mapping balanceOf
assume (forall  __i__0_0:Ref ::  ((M_Ref_int[balanceOf_TokenERC20[this]][__i__0_0]) == (0)));
// Make array/mapping vars distinct for allowance
call __var_3 := FreshRefGenerator();
allowance_TokenERC20[this] := __var_3;
// Initialize length of 1-level nested array in allowance
assume (forall  __i__0_0:Ref ::  ((Length[M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0]]) == (0)));
assume (forall  __i__0_0:Ref ::  (!(Alloc[M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0]])));
call HavocAllocMany();
assume (forall  __i__0_0:Ref ::  (Alloc[M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0]]));
assume (forall  __i__0_0:Ref, __i__0_1:Ref :: {M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0], M_Ref_Ref[allowance_TokenERC20[this]][__i__0_1]} (((__i__0_0) == (__i__0_1)) || ((M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0]) != (M_Ref_Ref[allowance_TokenERC20[this]][__i__0_1]))));
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s83);
call  {:cexpr "tokenName"} boogie_si_record_sol2Bpl_int(tokenName_s83);
call  {:cexpr "tokenSymbol"} boogie_si_record_sol2Bpl_int(tokenSymbol_s83);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 21} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 22} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((initialSupply_s83) >= (0));
assume ((__var_1) >= (0));
assume ((decimals_TokenERC20[this]) >= (0));
__var_1 := decimals_TokenERC20[this];
assume ((decimals_TokenERC20[this]) >= (0));
assume (((decimals_TokenERC20[this])) >= (0));
assume (((initialSupply_s83) * ((decimals_TokenERC20[this]))) >= (0));
totalSupply_TokenERC20[this] := (initialSupply_s83) * ((decimals_TokenERC20[this]));
call  {:cexpr "totalSupply"} boogie_si_record_sol2Bpl_int(totalSupply_TokenERC20[this]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 23} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] := totalSupply_TokenERC20[this];
call  {:cexpr "balanceOf[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 24} (true);
name_TokenERC20[this] := tokenName_s83;
call  {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_TokenERC20[this]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 25} (true);
symbol_TokenERC20[this] := tokenSymbol_s83;
call  {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_TokenERC20[this]);
}

procedure {:constructor} {:public} {:inline 1} TokenERC20_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int);
implementation TokenERC20_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int)
{
var __var_1: int;
var __var_2: Ref;
var __var_3: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s83);
call  {:cexpr "tokenName"} boogie_si_record_sol2Bpl_int(tokenName_s83);
call  {:cexpr "tokenSymbol"} boogie_si_record_sol2Bpl_int(tokenSymbol_s83);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call TokenERC20_TokenERC20_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, initialSupply_s83, tokenName_s83, tokenSymbol_s83);
}

procedure {:inline 1} contractInvariant_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
procedure {:inline 1} _transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s178: Ref, _to_s178: Ref, _value_s178: int);
implementation _transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s178: Ref, _to_s178: Ref, _value_s178: int)
{
var __var_4: Ref;
var previousBalances_s177: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s178);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s178);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s178);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 65} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 66} (true);
__var_4 := null;
assume ((_to_s178) != (null));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 67} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) >= (0));
assume ((_value_s178) >= (0));
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) >= (_value_s178));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 68} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) >= (0));
assume ((_value_s178) >= (0));
assume ((((M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) + (_value_s178))) >= (0));
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) >= (0));
assume ((((M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) + (_value_s178))) > (M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 69} (true);
assume ((previousBalances_s177) >= (0));
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) >= (0));
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) >= (0));
assume (((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) + (M_Ref_int[balanceOf_TokenERC20[this]][_to_s178])) >= (0));
previousBalances_s177 := (M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) + (M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]);
call  {:cexpr "previousBalances"} boogie_si_record_sol2Bpl_int(previousBalances_s177);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 70} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) >= (0));
assume ((_value_s178) >= (0));
M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] := (M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) - (_value_s178);
call  {:cexpr "balanceOf[_from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 71} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) >= (0));
assume ((_value_s178) >= (0));
M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] := (M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) + (_value_s178);
call  {:cexpr "balanceOf[_to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 72} (true);
assert {:EventEmitted "Transfer_TokenERC20"} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 73} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) >= (0));
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]) >= (0));
assume ((((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) + (M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]))) >= (0));
assume ((previousBalances_s177) >= (0));
assert ((((M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]) + (M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]))) == (previousBalances_s177));
}

procedure {:public} {:inline 1} transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s247: Ref, _value_s247: int) returns (__ret_0_: bool);
ensures((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) == (old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))));
ensures((old(totalSupply_TokenERC20[this])) == (totalSupply_TokenERC20[this]));
ensures((old(totalSupply_TokenERC20[this])) >= (totalSupply_TokenERC20[this]));
ensures((old(totalSupply_TokenERC20[this])) <= (totalSupply_TokenERC20[this]));
implementation transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s247: Ref, _value_s247: int) returns (__ret_0_: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s247);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s247);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 76} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 95} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 100} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 101} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 102} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 103} (true);
assume ((_value_s247) >= (0));
call _transfer_TokenERC20(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, _to_s247, _value_s247);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 104} (true);
__ret_0_ := true;
return;
}

procedure {:public} {:inline 1} transferFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s384: Ref, _to_s384: Ref, _value_s384: int) returns (success_s384: bool);
ensures((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) == (old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))));
ensures((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))));
ensures((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) <= (old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))));
ensures((old(totalSupply_TokenERC20[this])) == (totalSupply_TokenERC20[this]));
ensures((old(totalSupply_TokenERC20[this])) >= (totalSupply_TokenERC20[this]));
ensures((old(totalSupply_TokenERC20[this])) <= (totalSupply_TokenERC20[this]));
ensures((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]) >= (0));
implementation transferFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s384: Ref, _to_s384: Ref, _value_s384: int) returns (success_s384: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s384);
call  {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s384);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s384);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 107} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 125} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 126} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 127} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 128} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 129} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 130} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 131} (true);
assume ((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 132} (true);
assume ((_value_s384) >= (0));
assume ((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]) >= (0));
assume ((_value_s384) <= (M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 133} (true);
assume ((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]) >= (0));
assume ((_value_s384) >= (0));
M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG] := (M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]) - (_value_s384);
call  {:cexpr "allowance[_from][msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 134} (true);
assume ((_value_s384) >= (0));
call _transfer_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s384, _to_s384, _value_s384);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 135} (true);
success_s384 := true;
return;
}

procedure {:public} {:inline 1} approve_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s502: Ref, _value_s502: int) returns (success_s502: bool);
ensures((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) == (old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))));
ensures((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))));
ensures((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) <= (old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))));
ensures((totalSupply_TokenERC20[this]) == (old(totalSupply_TokenERC20[this])));
ensures((totalSupply_TokenERC20[this]) >= (old(totalSupply_TokenERC20[this])));
ensures((totalSupply_TokenERC20[this]) <= (old(totalSupply_TokenERC20[this])));
ensures((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502]) == (_value_s502));
implementation approve_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s502: Ref, _value_s502: int) returns (success_s502: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s502);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s502);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 138} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 148} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 149} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 150} (true);
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= (0));
assume ((old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]))) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 151} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 152} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 153} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((old(totalSupply_TokenERC20[this])) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 154} (true);
assume ((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502]) >= (0));
assume ((_value_s502) >= (0));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 158} (true);
assume ((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502]) >= (0));
assume ((_value_s502) >= (0));
M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502] := _value_s502;
call  {:cexpr "allowance[msg.sender][_spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 159} (true);
success_s502 := true;
return;
}

procedure {:public} {:inline 1} approveAndCall_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s540: Ref, _value_s540: int, _extraData_s540: int) returns (success_s540: bool);
implementation approveAndCall_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s540: Ref, _value_s540: int, _extraData_s540: int) returns (success_s540: bool)
{
var spender_s539: Ref;
var __var_5: bool;
var __var_6: int;
var __var_7: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s540);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s540);
call  {:cexpr "_extraData"} boogie_si_record_sol2Bpl_int(_extraData_s540);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 162} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 164} (true);
assume ((DType[_spender_s540]) == (tokenRecipient));
spender_s539 := _spender_s540;
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s539);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 165} (true);
assume ((_value_s540) >= (0));
call __var_5 := approve_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s540, _value_s540);
if (__var_5) {
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 165} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 166} (true);
assume ((_value_s540) >= (0));
__var_7 := this;
call receiveApproval_tokenRecipient(spender_s539, this, __var_6, msgsender_MSG, _value_s540, this, _extraData_s540);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 167} (true);
success_s540 := true;
return;
}
}

procedure {:public} {:inline 1} burn_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _value_s576: int) returns (success_s576: bool);
implementation burn_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _value_s576: int) returns (success_s576: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s576);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 171} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 173} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]) >= (0));
assume ((_value_s576) >= (0));
assume ((M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]) >= (_value_s576));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 174} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]) >= (0));
assume ((_value_s576) >= (0));
M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] := (M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]) - (_value_s576);
call  {:cexpr "balanceOf[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 175} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((_value_s576) >= (0));
totalSupply_TokenERC20[this] := (totalSupply_TokenERC20[this]) - (_value_s576);
call  {:cexpr "totalSupply"} boogie_si_record_sol2Bpl_int(totalSupply_TokenERC20[this]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 176} (true);
assert {:EventEmitted "Burn_TokenERC20"} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 177} (true);
success_s576 := true;
return;
}

procedure {:public} {:inline 1} burnFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s631: Ref, _value_s631: int) returns (success_s631: bool);
implementation burnFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s631: Ref, _value_s631: int) returns (success_s631: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s631);
call  {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s631);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 180} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 182} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s631]) >= (0));
assume ((_value_s631) >= (0));
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s631]) >= (_value_s631));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 183} (true);
assume ((_value_s631) >= (0));
assume ((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG]) >= (0));
assume ((_value_s631) <= (M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG]));
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 184} (true);
assume ((M_Ref_int[balanceOf_TokenERC20[this]][_from_s631]) >= (0));
assume ((_value_s631) >= (0));
M_Ref_int[balanceOf_TokenERC20[this]][_from_s631] := (M_Ref_int[balanceOf_TokenERC20[this]][_from_s631]) - (_value_s631);
call  {:cexpr "balanceOf[_from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][_from_s631]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 185} (true);
assume ((M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG]) >= (0));
assume ((_value_s631) >= (0));
M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG] := (M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG]) - (_value_s631);
call  {:cexpr "allowance[_from][msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 186} (true);
assume ((totalSupply_TokenERC20[this]) >= (0));
assume ((_value_s631) >= (0));
totalSupply_TokenERC20[this] := (totalSupply_TokenERC20[this]) - (_value_s631);
call  {:cexpr "totalSupply"} boogie_si_record_sol2Bpl_int(totalSupply_TokenERC20[this]);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 187} (true);
assert {:EventEmitted "Burn_TokenERC20"} (true);
assert {:first} {:sourceFile "D:\Invariant\verisol-master\Test\ERC20\0x0148650ef8e216e8d0999fe8d4b5c1871b71771a.etherscan.io-TokenERC20.sol"} {:sourceLine 188} (true);
success_s631 := true;
return;
}

procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (TokenERC20)) {
assume ((amount) == (0));
} else if ((DType[to]) == (tokenRecipient)) {
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

procedure BoogieEntry_tokenRecipient();
implementation BoogieEntry_tokenRecipient()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (tokenRecipient));
call tokenRecipient_tokenRecipient(this, msgsender_MSG, msgvalue_MSG);
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
assume ((DType[msgsender_MSG]) != (tokenRecipient));
assume ((DType[msgsender_MSG]) != (TokenERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_TokenERC20();
implementation BoogieEntry_TokenERC20()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var initialSupply_s83: int;
var tokenName_s83: int;
var tokenSymbol_s83: int;
var _to_s247: Ref;
var _value_s247: int;
var __ret_0_transfer: bool;
var _from_s384: Ref;
var _to_s384: Ref;
var _value_s384: int;
var success_s384: bool;
var _spender_s502: Ref;
var _value_s502: int;
var success_s502: bool;
var _spender_s540: Ref;
var _value_s540: int;
var _extraData_s540: int;
var success_s540: bool;
var _value_s576: int;
var success_s576: bool;
var _from_s631: Ref;
var _value_s631: int;
var success_s631: bool;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (TokenERC20));
call TokenERC20_TokenERC20(this, msgsender_MSG, msgvalue_MSG, initialSupply_s83, tokenName_s83, tokenSymbol_s83);
while (true)
  invariant (_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) == (totalSupply_TokenERC20[this]);
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc initialSupply_s83;
havoc tokenName_s83;
havoc tokenSymbol_s83;
havoc _to_s247;
havoc _value_s247;
havoc __ret_0_transfer;
havoc _from_s384;
havoc _to_s384;
havoc _value_s384;
havoc success_s384;
havoc _spender_s502;
havoc _value_s502;
havoc success_s502;
havoc _spender_s540;
havoc _value_s540;
havoc _extraData_s540;
havoc success_s540;
havoc _value_s576;
havoc success_s576;
havoc _from_s631;
havoc _value_s631;
havoc success_s631;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (tokenRecipient));
assume ((DType[msgsender_MSG]) != (TokenERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call __ret_0_transfer := transfer_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _to_s247, _value_s247);
} else if ((choice) == (5)) {
call success_s384 := transferFrom_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s384, _to_s384, _value_s384);
} else if ((choice) == (4)) {
call success_s502 := approve_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s502, _value_s502);
} else if ((choice) == (3)) {
call success_s540 := approveAndCall_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s540, _value_s540, _extraData_s540);
} else if ((choice) == (2)) {
call success_s576 := burn_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _value_s576);
} else if ((choice) == (1)) {
call success_s631 := burnFrom_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s631, _value_s631);
}
}
}

procedure CorralChoice_tokenRecipient(this: Ref);
implementation CorralChoice_tokenRecipient(this: Ref)
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
assume ((DType[msgsender_MSG]) != (tokenRecipient));
assume ((DType[msgsender_MSG]) != (TokenERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}

procedure CorralEntry_tokenRecipient();
implementation CorralEntry_tokenRecipient()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (tokenRecipient));
call tokenRecipient_tokenRecipient(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
call CorralChoice_tokenRecipient(this);
}
}

procedure CorralChoice_TokenERC20(this: Ref);
implementation CorralChoice_TokenERC20(this: Ref)
{
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var initialSupply_s83: int;
var tokenName_s83: int;
var tokenSymbol_s83: int;
var _to_s247: Ref;
var _value_s247: int;
var __ret_0_transfer: bool;
var _from_s384: Ref;
var _to_s384: Ref;
var _value_s384: int;
var success_s384: bool;
var _spender_s502: Ref;
var _value_s502: int;
var success_s502: bool;
var _spender_s540: Ref;
var _value_s540: int;
var _extraData_s540: int;
var success_s540: bool;
var _value_s576: int;
var success_s576: bool;
var _from_s631: Ref;
var _value_s631: int;
var success_s631: bool;
var tmpNow: int;
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc initialSupply_s83;
havoc tokenName_s83;
havoc tokenSymbol_s83;
havoc _to_s247;
havoc _value_s247;
havoc __ret_0_transfer;
havoc _from_s384;
havoc _to_s384;
havoc _value_s384;
havoc success_s384;
havoc _spender_s502;
havoc _value_s502;
havoc success_s502;
havoc _spender_s540;
havoc _value_s540;
havoc _extraData_s540;
havoc success_s540;
havoc _value_s576;
havoc success_s576;
havoc _from_s631;
havoc _value_s631;
havoc success_s631;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (tokenRecipient));
assume ((DType[msgsender_MSG]) != (TokenERC20));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (6)) {
call __ret_0_transfer := transfer_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _to_s247, _value_s247);
} else if ((choice) == (5)) {
call success_s384 := transferFrom_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s384, _to_s384, _value_s384);
} else if ((choice) == (4)) {
call success_s502 := approve_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s502, _value_s502);
} else if ((choice) == (3)) {
call success_s540 := approveAndCall_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s540, _value_s540, _extraData_s540);
} else if ((choice) == (2)) {
call success_s576 := burn_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _value_s576);
} else if ((choice) == (1)) {
call success_s631 := burnFrom_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s631, _value_s631);
}
}

procedure CorralEntry_TokenERC20();
implementation CorralEntry_TokenERC20()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var initialSupply_s83: int;
var tokenName_s83: int;
var tokenSymbol_s83: int;
call this := FreshRefGenerator();
assume ((now) >= (0));
assume ((DType[this]) == (TokenERC20));
call TokenERC20_TokenERC20(this, msgsender_MSG, msgvalue_MSG, initialSupply_s83, tokenName_s83, tokenSymbol_s83);
while (true)
  invariant (_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) == (totalSupply_TokenERC20[this]);
{
call CorralChoice_TokenERC20(this);
}
}


