type Ref;
type ContractName;
const unique null: Ref;
const unique Address: ContractName;
const unique ERC165: ContractName;
const unique ERC721: ContractName;
const unique IERC165: ContractName;
const unique IERC721: ContractName;
const unique IERC721Receiver: ContractName;
const unique SafeMath: ContractName;
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
var M_int_bool: [Ref][int]bool;
var M_int_Ref: [Ref][int]Ref;
var M_Ref_int: [Ref][Ref]int;
var M_Ref_bool: [Ref][Ref]bool;
var M_Ref_Ref: [Ref][Ref]Ref;
var M_int_int: [Ref][int]int;
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

axiom(forall  __i__0_0:[int]int ::  ((exists __i__0_1:int ::  ((__i__0_0[__i__0_1]) != (0))) || ((_SumMappingIntInt_VeriSol(__i__0_0)) == (0))));

axiom(forall  __i__0_0:[int]int, __i__0_1:int, __i__0_2:int ::  ((_SumMappingIntInt_VeriSol(__i__0_0[__i__0_1 := __i__0_2])) == (((_SumMappingIntInt_VeriSol(__i__0_0)) - (__i__0_0[__i__0_1])) + (__i__0_2))));

axiom(forall  __i__0_0:int, __i__0_1:int, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2(__i__0_0, __i__1_0)) != (abiEncodePacked2(__i__0_1, __i__1_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref :: {abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1)} (((__i__0_0) == (__i__0_1)) || ((abiEncodePacked1R(__i__0_0)) != (abiEncodePacked1R(__i__0_1)))));

axiom(forall  __i__0_0:Ref, __i__0_1:Ref, __i__1_0:int, __i__1_1:int :: {abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1)} ((((__i__0_0) == (__i__0_1)) && ((__i__1_0) == (__i__1_1))) || ((abiEncodePacked2R(__i__0_0, __i__1_0)) != (abiEncodePacked2R(__i__0_1, __i__1_1)))));
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/Address.sol"} {:sourceLine 5} (true);
call Address_Address_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} isContract_Address(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s785: Ref) returns (__ret_0_: bool);
var _INTERFACE_ID_ERC165_ERC165: [Ref]int;
var _supportedInterfaces_ERC165: [Ref]Ref;
procedure {:inline 1} ERC165_ERC165_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation ERC165_ERC165_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_1: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
_INTERFACE_ID_ERC165_ERC165[this] := 33540519;
// Make array/mapping vars distinct for _supportedInterfaces
call __var_1 := FreshRefGenerator();
_supportedInterfaces_ERC165[this] := __var_1;
// Initialize Boolean mapping _supportedInterfaces
assume (forall  __i__0_0:int ::  (!(M_int_bool[_supportedInterfaces_ERC165[this]][__i__0_0])));
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC165.sol"} {:sourceLine 15} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC165.sol"} {:sourceLine 16} (true);
if ((DType[this]) == (ERC721)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC165_ERC165[this]);
} else if ((DType[this]) == (ERC165)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC165_ERC165[this]);
} else {
assume (false);
}
}

procedure {:constructor} {:public} {:inline 1} ERC165_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation ERC165_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_1: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call ERC165_ERC165_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} supportsInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s819: int) returns (__ret_0_: bool);
implementation supportsInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s819: int) returns (__ret_0_: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "interfaceId"} boogie_si_record_sol2Bpl_int(interfaceId_s819);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC165.sol"} {:sourceLine 20} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC165.sol"} {:sourceLine 21} (true);
__ret_0_ := M_int_bool[_supportedInterfaces_ERC165[this]][interfaceId_s819];
return;
}

procedure {:inline 1} _registerInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s837: int);
implementation _registerInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s837: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "interfaceId"} boogie_si_record_sol2Bpl_int(interfaceId_s837);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC165.sol"} {:sourceLine 25} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC165.sol"} {:sourceLine 26} (true);
assume ((interfaceId_s837) != (-1));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC165.sol"} {:sourceLine 27} (true);
M_int_bool[_supportedInterfaces_ERC165[this]][interfaceId_s837] := true;
call  {:cexpr "_supportedInterfaces[interfaceId]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_supportedInterfaces_ERC165[this]][interfaceId_s837]);
}

var _ERC721_RECEIVED_ERC721: [Ref]int;
var _tokenOwner_ERC721: [Ref]Ref;
var _tokenApprovals_ERC721: [Ref]Ref;
var _ownedTokensCount_ERC721: [Ref]Ref;
var _operatorApprovals_ERC721: [Ref]Ref;
var _INTERFACE_ID_ERC721_ERC721: [Ref]int;
procedure {:inline 1} ERC721_ERC721_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation ERC721_ERC721_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_2: Ref;
var __var_3: Ref;
var __var_4: Ref;
var __var_5: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
_ERC721_RECEIVED_ERC721[this] := 353073666;
// Make array/mapping vars distinct for _tokenOwner
call __var_2 := FreshRefGenerator();
_tokenOwner_ERC721[this] := __var_2;
// Initialize address/contract mapping _tokenOwner
assume (forall  __i__0_0:int ::  ((M_int_Ref[_tokenOwner_ERC721[this]][__i__0_0]) == (null)));
// Make array/mapping vars distinct for _tokenApprovals
call __var_3 := FreshRefGenerator();
_tokenApprovals_ERC721[this] := __var_3;
// Initialize address/contract mapping _tokenApprovals
assume (forall  __i__0_0:int ::  ((M_int_Ref[_tokenApprovals_ERC721[this]][__i__0_0]) == (null)));
// Make array/mapping vars distinct for _ownedTokensCount
call __var_4 := FreshRefGenerator();
_ownedTokensCount_ERC721[this] := __var_4;
// Initialize Integer mapping _ownedTokensCount
assume (forall  __i__0_0:Ref ::  ((M_Ref_int[_ownedTokensCount_ERC721[this]][__i__0_0]) == (0)));
// Make array/mapping vars distinct for _operatorApprovals
call __var_5 := FreshRefGenerator();
_operatorApprovals_ERC721[this] := __var_5;
// Initialize length of 1-level nested array in _operatorApprovals
assume (forall  __i__0_0:Ref ::  ((Length[M_Ref_Ref[_operatorApprovals_ERC721[this]][__i__0_0]]) == (0)));
assume (forall  __i__0_0:Ref ::  (!(Alloc[M_Ref_Ref[_operatorApprovals_ERC721[this]][__i__0_0]])));
call HavocAllocMany();
assume (forall  __i__0_0:Ref ::  (Alloc[M_Ref_Ref[_operatorApprovals_ERC721[this]][__i__0_0]]));
assume (forall  __i__0_0:Ref, __i__0_1:Ref :: {M_Ref_Ref[_operatorApprovals_ERC721[this]][__i__0_0], M_Ref_Ref[_operatorApprovals_ERC721[this]][__i__0_1]} (((__i__0_0) == (__i__0_1)) || ((M_Ref_Ref[_operatorApprovals_ERC721[this]][__i__0_0]) != (M_Ref_Ref[_operatorApprovals_ERC721[this]][__i__0_1]))));
_INTERFACE_ID_ERC721_ERC721[this] := -2136188723;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 23} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 24} (true);
if ((DType[this]) == (ERC721)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ERC721[this]);
} else {
assume (false);
}
}

procedure {:constructor} {:public} {:inline 1} ERC721_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation ERC721_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_2: Ref;
var __var_3: Ref;
var __var_4: Ref;
var __var_5: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call ERC165_ERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
call ERC721_ERC721_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} balanceOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s69: Ref) returns (__ret_0_: int);
implementation balanceOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s69: Ref) returns (__ret_0_: int)
{
var __var_6: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s69);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 30} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 31} (true);
__var_6 := null;
assume ((owner_s69) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 32} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s69]) >= (0));
__ret_0_ := M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s69];
return;
}

procedure {:public} {:inline 1} ownerOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s93: int) returns (__ret_0_: Ref);
implementation ownerOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s93: int) returns (__ret_0_: Ref)
{
var owner_s92: Ref;
var __var_7: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s93);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 38} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 39} (true);
assume ((tokenId_s93) >= (0));
owner_s92 := M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s93];
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s92);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 40} (true);
__var_7 := null;
assume ((owner_s92) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 41} (true);
__ret_0_ := owner_s92;
return;
}

procedure {:public} {:inline 1} approve_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s139: Ref, tokenId_s139: int);
implementation approve_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s139: Ref, tokenId_s139: int)
{
var owner_s138: Ref;
var __var_8: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s139);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s139);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 50} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 51} (true);
assume ((tokenId_s139) >= (0));
if ((DType[this]) == (ERC721)) {
call owner_s138 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s139);
} else {
assume (false);
}
owner_s138 := owner_s138;
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s138);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 52} (true);
assume ((to_s139) != (owner_s138));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 53} (true);
if ((DType[this]) == (ERC721)) {
call __var_8 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s138, msgsender_MSG);
} else {
assume (false);
}
assume ((((msgsender_MSG) == (owner_s138))) || (__var_8));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 54} (true);
assume ((tokenId_s139) >= (0));
M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s139] := to_s139;
call  {:cexpr "_tokenApprovals[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s139]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 55} (true);
assert {:EventEmitted "Approval_ERC721"} (true);
}

procedure {:public} {:inline 1} getApproved_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s157: int) returns (__ret_0_: Ref);
implementation getApproved_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s157: int) returns (__ret_0_: Ref)
{
var __var_9: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s157);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 62} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 63} (true);
assume ((tokenId_s157) >= (0));
call __var_9 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s157);
assume (__var_9);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 64} (true);
assume ((tokenId_s157) >= (0));
__ret_0_ := M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s157];
return;
}

const {:existential true} HoudiniF1_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF2_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF3_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF4_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF5_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF6_setApprovalForAll_ERC721: bool;
procedure {:public} {:inline 1} setApprovalForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s349: Ref, approved_s349: bool);
ensures HoudiniF1_setApprovalForAll_ERC721 ==> ((msgsender_MSG) != (null));
ensures HoudiniF2_setApprovalForAll_ERC721 ==> ((msgsender_MSG) != (to_s349));
ensures HoudiniF3_setApprovalForAll_ERC721 ==> ((!((((((old(M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349])) == (false)) && ((to_s349) != (null))) && ((to_s349) != (null))) && ((old(M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349])) == (false))))) || (((M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349]) == (true))));
ensures HoudiniF4_setApprovalForAll_ERC721 ==> ((M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349]) == (true));
ensures HoudiniF5_setApprovalForAll_ERC721 ==> ((!((((((to_s349) != (null)) && ((old(M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349])) == (false))) && ((old(M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349])) == (false))) && ((to_s349) != (null))))) || (((M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349]) == (true))));
ensures HoudiniF6_setApprovalForAll_ERC721 ==> ((M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349]) == (true));
implementation setApprovalForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s349: Ref, approved_s349: bool)
{
var __var_10: Ref;
var __var_11: Ref;
var __var_12: Ref;
var __var_13: Ref;
var __var_14: Ref;
var __var_15: Ref;
assume ((msgsender_MSG) != (null));
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s349);
call  {:cexpr "approved"} boogie_si_record_sol2Bpl_bool(approved_s349);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 71} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 73} (true);
__var_10 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 76} (true);
__var_11 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 77} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 78} (true);
__var_12 := null;
__var_13 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 79} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 80} (true);
__var_14 := null;
__var_15 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 81} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 83} (true);
assume ((to_s349) != (msgsender_MSG));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 84} (true);
M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349] := approved_s349;
call  {:cexpr "_operatorApprovals[msg.sender][to]"} boogie_si_record_sol2Bpl_bool(M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s349]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 85} (true);
assert {:EventEmitted "ApprovalForAll_ERC721"} (true);
}

procedure {:public} {:inline 1} isApprovedForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s365: Ref, operator_s365: Ref) returns (__ret_0_: bool);
implementation isApprovedForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s365: Ref, operator_s365: Ref) returns (__ret_0_: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s365);
call  {:cexpr "operator"} boogie_si_record_sol2Bpl_ref(operator_s365);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 92} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 93} (true);
__ret_0_ := M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][owner_s365]][operator_s365];
return;
}

const {:existential true} HoudiniF7_transferFrom_ERC721: bool;
const {:existential true} HoudiniF8_transferFrom_ERC721: bool;
const {:existential true} HoudiniF9_transferFrom_ERC721: bool;
procedure {:public} {:inline 1} transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s431: Ref, to_s431: Ref, tokenId_s431: int);
ensures HoudiniF7_transferFrom_ERC721 ==> ((from_s431) != (null));
ensures HoudiniF8_transferFrom_ERC721 ==> ((msgsender_MSG) != (null));
ensures HoudiniF9_transferFrom_ERC721 ==> ((to_s431) != (null));
implementation transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s431: Ref, to_s431: Ref, tokenId_s431: int)
{
var __var_16: Ref;
var __var_17: Ref;
var __var_18: Ref;
var __var_19: Ref;
var __var_20: bool;
assume ((msgsender_MSG) != (null));
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s431);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s431);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s431);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 102} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 104} (true);
__var_16 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 107} (true);
__var_17 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 108} (true);
__var_18 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 109} (true);
__var_19 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 111} (true);
assume ((tokenId_s431) >= (0));
call __var_20 := _isApprovedOrOwner_ERC721(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, tokenId_s431);
assume (__var_20);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 112} (true);
assume ((tokenId_s431) >= (0));
call _transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s431, to_s431, tokenId_s431);
}

procedure {:public} {:inline 1} safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s448: Ref, to_s448: Ref, tokenId_s448: int);
implementation safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s448: Ref, to_s448: Ref, tokenId_s448: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s448);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s448);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s448);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 124} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 125} (true);
assume ((tokenId_s448) >= (0));
if ((DType[this]) == (ERC721)) {
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s448, to_s448, tokenId_s448, 414333189);
} else {
assume (false);
}
}

procedure {:public} {:inline 1} _safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s475: Ref, to_s475: Ref, tokenId_s475: int, _data_s475: int);
implementation _safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s475: Ref, to_s475: Ref, tokenId_s475: int, _data_s475: int)
{
var __var_21: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s475);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s475);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s475);
call  {:cexpr "_data"} boogie_si_record_sol2Bpl_int(_data_s475);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 138} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 139} (true);
assume ((tokenId_s475) >= (0));
if ((DType[this]) == (ERC721)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s475, to_s475, tokenId_s475);
} else {
assume (false);
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 140} (true);
assume ((tokenId_s475) >= (0));
call __var_21 := _checkOnERC721Received_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s475, to_s475, tokenId_s475, _data_s475);
assume (__var_21);
}

procedure {:inline 1} _exists_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s495: int) returns (__ret_0_: bool);
implementation _exists_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s495: int) returns (__ret_0_: bool)
{
var owner_s494: Ref;
var __var_22: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s495);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 146} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 147} (true);
assume ((tokenId_s495) >= (0));
owner_s494 := M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s495];
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s494);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 148} (true);
__var_22 := null;
__ret_0_ := (owner_s494) != (null);
return;
}

procedure {:inline 1} _isApprovedOrOwner_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s530: Ref, tokenId_s530: int) returns (__ret_0_: bool);
implementation _isApprovedOrOwner_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s530: Ref, tokenId_s530: int) returns (__ret_0_: bool)
{
var owner_s529: Ref;
var __var_23: Ref;
var __var_24: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s530);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s530);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 156} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 157} (true);
assume ((tokenId_s530) >= (0));
if ((DType[this]) == (ERC721)) {
call owner_s529 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s530);
} else {
assume (false);
}
owner_s529 := owner_s529;
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s529);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 158} (true);
assume ((tokenId_s530) >= (0));
if ((DType[this]) == (ERC721)) {
call __var_23 := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s530);
} else {
assume (false);
}
if ((DType[this]) == (ERC721)) {
call __var_24 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s529, spender_s530);
} else {
assume (false);
}
__ret_0_ := (((((spender_s530) == (owner_s529))) || (((__var_23) == (spender_s530))))) || (__var_24);
return;
}

procedure {:inline 1} _mint_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s578: Ref, tokenId_s578: int);
implementation _mint_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s578: Ref, tokenId_s578: int)
{
var __var_25: Ref;
var __var_26: bool;
var __var_27: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s578);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s578);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 165} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 166} (true);
__var_25 := null;
assume ((to_s578) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 167} (true);
assume ((tokenId_s578) >= (0));
call __var_26 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s578);
assume (!(__var_26));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 168} (true);
assume ((tokenId_s578) >= (0));
M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s578] := to_s578;
call  {:cexpr "_tokenOwner[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s578]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 169} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s578]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s578]) >= (0));
call __var_27 := add_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][to_s578], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][to_s578] := __var_27;
assume ((__var_27) >= (0));
call  {:cexpr "_ownedTokensCount[to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][to_s578]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 170} (true);
assert {:EventEmitted "Transfer_ERC721"} (true);
}

procedure {:inline 1} _burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s625: Ref, tokenId_s625: int);
implementation _burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s625: Ref, tokenId_s625: int)
{
var __var_28: Ref;
var __var_29: int;
var __var_30: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s625);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s625);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 178} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 179} (true);
assume ((tokenId_s625) >= (0));
if ((DType[this]) == (ERC721)) {
call __var_28 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s625);
} else {
assume (false);
}
assume ((__var_28) == (owner_s625));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 180} (true);
assume ((tokenId_s625) >= (0));
call _clearApproval_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s625);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 181} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s625]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s625]) >= (0));
call __var_29 := sub_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s625], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s625] := __var_29;
assume ((__var_29) >= (0));
call  {:cexpr "_ownedTokensCount[owner]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s625]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 182} (true);
assume ((tokenId_s625) >= (0));
__var_30 := null;
M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s625] := __var_30;
call  {:cexpr "_tokenOwner[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s625]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 183} (true);
assert {:EventEmitted "Transfer_ERC721"} (true);
}

procedure {:inline 1} __burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s638: int);
implementation __burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s638: int)
{
var __var_31: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s638);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 189} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 190} (true);
assume ((tokenId_s638) >= (0));
if ((DType[this]) == (ERC721)) {
call __var_31 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s638);
} else {
assume (false);
}
assume ((tokenId_s638) >= (0));
call _burn_ERC721(this, msgsender_MSG, msgvalue_MSG, __var_31, tokenId_s638);
}

procedure {:inline 1} _transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s702: Ref, to_s702: Ref, tokenId_s702: int);
implementation _transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s702: Ref, to_s702: Ref, tokenId_s702: int)
{
var __var_32: Ref;
var __var_33: Ref;
var __var_34: int;
var __var_35: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s702);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s702);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s702);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 198} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 199} (true);
assume ((tokenId_s702) >= (0));
if ((DType[this]) == (ERC721)) {
call __var_32 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s702);
} else {
assume (false);
}
assume ((__var_32) == (from_s702));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 200} (true);
__var_33 := null;
assume ((to_s702) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 201} (true);
assume ((tokenId_s702) >= (0));
call _clearApproval_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s702);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 202} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][from_s702]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][from_s702]) >= (0));
call __var_34 := sub_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][from_s702], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][from_s702] := __var_34;
assume ((__var_34) >= (0));
call  {:cexpr "_ownedTokensCount[from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][from_s702]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 203} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s702]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s702]) >= (0));
call __var_35 := add_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][to_s702], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][to_s702] := __var_35;
assume ((__var_35) >= (0));
call  {:cexpr "_ownedTokensCount[to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][to_s702]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 204} (true);
assume ((tokenId_s702) >= (0));
M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s702] := to_s702;
call  {:cexpr "_tokenOwner[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s702]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 205} (true);
assert {:EventEmitted "Transfer_ERC721"} (true);
}

procedure {:inline 1} _checkOnERC721Received_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s742: Ref, to_s742: Ref, tokenId_s742: int, _data_s742: int) returns (__ret_0_: bool);
implementation _checkOnERC721Received_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s742: Ref, to_s742: Ref, tokenId_s742: int, _data_s742: int) returns (__ret_0_: bool)
{
var __var_36: bool;
var retval_s741: int;
var __var_37: Ref;
var __var_38: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s742);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s742);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s742);
call  {:cexpr "_data"} boogie_si_record_sol2Bpl_int(_data_s742);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 215} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 216} (true);
call __var_36 := isContract_Address(this, this, 0, to_s742);
if (!(__var_36)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 216} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 217} (true);
__ret_0_ := true;
return;
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 219} (true);
assume ((DType[to_s742]) == (IERC721Receiver));
__var_37 := to_s742;
assume ((tokenId_s742) >= (0));
call retval_s741 := onERC721Received_IERC721Receiver(__var_37, this, __var_38, msgsender_MSG, from_s742, tokenId_s742, _data_s742);
retval_s741 := retval_s741;
call  {:cexpr "retval"} boogie_si_record_sol2Bpl_int(retval_s741);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 220} (true);
__ret_0_ := (retval_s741) == (_ERC721_RECEIVED_ERC721[this]);
return;
}

procedure {:inline 1} _clearApproval_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s765: int);
implementation _clearApproval_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s765: int)
{
var __var_39: Ref;
var __var_40: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s765);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 225} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 226} (true);
assume ((tokenId_s765) >= (0));
__var_39 := null;
if ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s765]) != (null)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 226} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/ERC721.sol"} {:sourceLine 227} (true);
assume ((tokenId_s765) >= (0));
__var_40 := null;
M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s765] := __var_40;
call  {:cexpr "_tokenApprovals[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s765]);
}
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/IERC165.sol"} {:sourceLine 6} (true);
call IERC165_IERC165_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} supportsInterface_IERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s1324: int) returns (__ret_0_: bool);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/IERC721.sol"} {:sourceLine 8} (true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} balanceOf_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s875: Ref) returns (balance_s875: int);
procedure {:public} {:inline 1} ownerOf_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s882: int) returns (owner_s882: Ref);
procedure {:public} {:inline 1} approve_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s889: Ref, tokenId_s889: int);
procedure {:public} {:inline 1} getApproved_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s896: int) returns (operator_s896: Ref);
procedure {:public} {:inline 1} setApprovalForAll_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, operator_s903: Ref, _approved_s903: bool);
procedure {:public} {:inline 1} isApprovedForAll_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s912: Ref, operator_s912: Ref) returns (__ret_0_: bool);
procedure {:public} {:inline 1} transferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s921: Ref, to_s921: Ref, tokenId_s921: int);
procedure {:public} {:inline 1} safeTransferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s930: Ref, to_s930: Ref, tokenId_s930: int);
procedure {:public} {:inline 1} _safeTransferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s941: Ref, to_s941: Ref, tokenId_s941: int, data_s941: int);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/IERC721Receiver.sol"} {:sourceLine 7} (true);
call IERC721Receiver_IERC721Receiver_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} onERC721Received_IERC721Receiver(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, operator_s958: Ref, from_s958: Ref, tokenId_s958: int, data_s958: int) returns (__ret_0_: int);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 6} (true);
call SafeMath_SafeMath_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s996: int, b_s996: int) returns (__ret_0_: int);
implementation mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s996: int, b_s996: int) returns (__ret_0_: int)
{
var c_s995: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s996);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s996);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 8} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 9} (true);
assume ((a_s996) >= (0));
if ((a_s996) == (0)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 9} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 10} (true);
__ret_0_ := 0;
return;
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 12} (true);
assume ((c_s995) >= (0));
assume ((a_s996) >= (0));
assume ((b_s996) >= (0));
assume (((a_s996) * (b_s996)) >= (0));
c_s995 := (a_s996) * (b_s996);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s995);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 13} (true);
assume ((c_s995) >= (0));
assume ((a_s996) >= (0));
assume ((((c_s995) div (a_s996))) >= (0));
assume ((b_s996) >= (0));
assume ((((c_s995) div (a_s996))) == (b_s996));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 14} (true);
assume ((c_s995) >= (0));
__ret_0_ := c_s995;
return;
}

procedure {:inline 1} div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1020: int, b_s1020: int) returns (__ret_0_: int);
implementation div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1020: int, b_s1020: int) returns (__ret_0_: int)
{
var c_s1019: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1020);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1020);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 18} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 19} (true);
assume ((b_s1020) >= (0));
assume ((b_s1020) > (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 20} (true);
assume ((c_s1019) >= (0));
assume ((a_s1020) >= (0));
assume ((b_s1020) >= (0));
assume (((a_s1020) div (b_s1020)) >= (0));
c_s1019 := (a_s1020) div (b_s1020);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1019);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 21} (true);
assume ((c_s1019) >= (0));
__ret_0_ := c_s1019;
return;
}

procedure {:inline 1} sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1044: int, b_s1044: int) returns (__ret_0_: int);
implementation sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1044: int, b_s1044: int) returns (__ret_0_: int)
{
var c_s1043: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1044);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1044);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 25} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 26} (true);
assume ((b_s1044) >= (0));
assume ((a_s1044) >= (0));
assume ((b_s1044) <= (a_s1044));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 27} (true);
assume ((c_s1043) >= (0));
assume ((a_s1044) >= (0));
assume ((b_s1044) >= (0));
assume (((a_s1044) - (b_s1044)) >= (0));
c_s1043 := (a_s1044) - (b_s1044);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1043);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 28} (true);
assume ((c_s1043) >= (0));
__ret_0_ := c_s1043;
return;
}

procedure {:inline 1} add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1068: int, b_s1068: int) returns (__ret_0_: int);
implementation add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1068: int, b_s1068: int) returns (__ret_0_: int)
{
var c_s1067: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1068);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1068);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 32} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 33} (true);
assume ((c_s1067) >= (0));
assume ((a_s1068) >= (0));
assume ((b_s1068) >= (0));
assume (((a_s1068) + (b_s1068)) >= (0));
c_s1067 := (a_s1068) + (b_s1068);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1067);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 34} (true);
assume ((c_s1067) >= (0));
assume ((a_s1068) >= (0));
assume ((c_s1067) >= (a_s1068));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 35} (true);
assume ((c_s1067) >= (0));
__ret_0_ := c_s1067;
return;
}

procedure {:inline 1} mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1088: int, b_s1088: int) returns (__ret_0_: int);
implementation mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1088: int, b_s1088: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1088);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1088);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 40} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 41} (true);
assume ((b_s1088) >= (0));
assume ((b_s1088) != (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0xc50161e1f4015a4f4b91cf98b996b7001ceaccf0.etherscan.io-Decomposer/verisol/SafeMath.sol"} {:sourceLine 42} (true);
assume ((a_s1088) >= (0));
assume ((b_s1088) >= (0));
assume (((a_s1088) mod (b_s1088)) >= (0));
__ret_0_ := (a_s1088) mod (b_s1088);
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
} else if ((DType[to]) == (ERC721)) {
assume ((amount) == (0));
} else if ((DType[to]) == (ERC165)) {
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
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_ERC165();
implementation BoogieEntry_ERC165()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s819: int;
var __ret_0_supportsInterface: bool;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (ERC165)) || ((DType[this]) == (ERC721)));
call ERC165_ERC165(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s819;
havoc __ret_0_supportsInterface;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s819);
}
}
}

procedure BoogieEntry_ERC721();
implementation BoogieEntry_ERC721()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s819: int;
var __ret_0_supportsInterface: bool;
var owner_s69: Ref;
var __ret_0_balanceOf: int;
var tokenId_s93: int;
var __ret_0_ownerOf: Ref;
var to_s139: Ref;
var tokenId_s139: int;
var tokenId_s157: int;
var __ret_0_getApproved: Ref;
var to_s349: Ref;
var approved_s349: bool;
var owner_s365: Ref;
var operator_s365: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s431: Ref;
var to_s431: Ref;
var tokenId_s431: int;
var from_s448: Ref;
var to_s448: Ref;
var tokenId_s448: int;
var from_s475: Ref;
var to_s475: Ref;
var tokenId_s475: int;
var _data_s475: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (ERC721));
call ERC721_ERC721(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s819;
havoc __ret_0_supportsInterface;
havoc owner_s69;
havoc __ret_0_balanceOf;
havoc tokenId_s93;
havoc __ret_0_ownerOf;
havoc to_s139;
havoc tokenId_s139;
havoc tokenId_s157;
havoc __ret_0_getApproved;
havoc to_s349;
havoc approved_s349;
havoc owner_s365;
havoc operator_s365;
havoc __ret_0_isApprovedForAll;
havoc from_s431;
havoc to_s431;
havoc tokenId_s431;
havoc from_s448;
havoc to_s448;
havoc tokenId_s448;
havoc from_s475;
havoc to_s475;
havoc tokenId_s475;
havoc _data_s475;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s819);
} else if ((choice) == (9)) {
call __ret_0_balanceOf := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s69);
} else if ((choice) == (8)) {
call __ret_0_ownerOf := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s93);
} else if ((choice) == (7)) {
call approve_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s139, tokenId_s139);
} else if ((choice) == (6)) {
call __ret_0_getApproved := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s157);
} else if ((choice) == (5)) {
call setApprovalForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s349, approved_s349);
} else if ((choice) == (4)) {
call __ret_0_isApprovedForAll := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s365, operator_s365);
} else if ((choice) == (3)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s431, to_s431, tokenId_s431);
} else if ((choice) == (2)) {
call safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s448, to_s448, tokenId_s448);
} else if ((choice) == (1)) {
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s475, to_s475, tokenId_s475, _data_s475);
}
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
assume (((((DType[this]) == (ERC165)) || ((DType[this]) == (ERC721))) || ((DType[this]) == (IERC165))) || ((DType[this]) == (IERC721)));
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
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_IERC721();
implementation BoogieEntry_IERC721()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s1324: int;
var __ret_0_supportsInterface: bool;
var owner_s875: Ref;
var balance_s875: int;
var tokenId_s882: int;
var owner_s882: Ref;
var to_s889: Ref;
var tokenId_s889: int;
var tokenId_s896: int;
var operator_s896: Ref;
var operator_s903: Ref;
var _approved_s903: bool;
var owner_s912: Ref;
var operator_s912: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s921: Ref;
var to_s921: Ref;
var tokenId_s921: int;
var from_s930: Ref;
var to_s930: Ref;
var tokenId_s930: int;
var from_s941: Ref;
var to_s941: Ref;
var tokenId_s941: int;
var data_s941: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (ERC721)) || ((DType[this]) == (IERC721)));
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s1324;
havoc __ret_0_supportsInterface;
havoc owner_s875;
havoc balance_s875;
havoc tokenId_s882;
havoc owner_s882;
havoc to_s889;
havoc tokenId_s889;
havoc tokenId_s896;
havoc operator_s896;
havoc operator_s903;
havoc _approved_s903;
havoc owner_s912;
havoc operator_s912;
havoc __ret_0_isApprovedForAll;
havoc from_s921;
havoc to_s921;
havoc tokenId_s921;
havoc from_s930;
havoc to_s930;
havoc tokenId_s930;
havoc from_s941;
havoc to_s941;
havoc tokenId_s941;
havoc data_s941;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_supportsInterface := supportsInterface_IERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s1324);
} else if ((choice) == (9)) {
call balance_s875 := balanceOf_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s875);
} else if ((choice) == (8)) {
call owner_s882 := ownerOf_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s882);
} else if ((choice) == (7)) {
call approve_IERC721(this, msgsender_MSG, msgvalue_MSG, to_s889, tokenId_s889);
} else if ((choice) == (6)) {
call operator_s896 := getApproved_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s896);
} else if ((choice) == (5)) {
call setApprovalForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, operator_s903, _approved_s903);
} else if ((choice) == (4)) {
call __ret_0_isApprovedForAll := isApprovedForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s912, operator_s912);
} else if ((choice) == (3)) {
call transferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s921, to_s921, tokenId_s921);
} else if ((choice) == (2)) {
call safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s930, to_s930, tokenId_s930);
} else if ((choice) == (1)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s941, to_s941, tokenId_s941, data_s941);
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
var operator_s958: Ref;
var from_s958: Ref;
var tokenId_s958: int;
var data_s958: int;
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
havoc operator_s958;
havoc from_s958;
havoc tokenId_s958;
havoc data_s958;
havoc __ret_0_onERC721Received;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call __ret_0_onERC721Received := onERC721Received_IERC721Receiver(this, msgsender_MSG, msgvalue_MSG, operator_s958, from_s958, tokenId_s958, data_s958);
}
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
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
Alloc[msgsender_MSG] := true;
}
}


