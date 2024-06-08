type Ref;
type ContractName;
const unique null: Ref;
const unique Address: ContractName;
const unique ERC165: ContractName;
const unique ERC721: ContractName;
const unique ERC721Enumerable: ContractName;
const unique ERC721Full: ContractName;
const unique ERC721Metadata: ContractName;
const unique EXODUS2: ContractName;
const unique IERC165: ContractName;
const unique IERC721: ContractName;
const unique IERC721Enumerable: ContractName;
const unique IERC721Metadata: ContractName;
const unique IERC721Receiver: ContractName;
const unique SafeMath: ContractName;
const unique VeriSol: ContractName;
const unique strings: ContractName;
const unique strings.slice: ContractName;
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
procedure {:inline 1} strings.slice_ctor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _len: int, _ptr: int);
implementation strings.slice_ctor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _len: int, _ptr: int)
{
_len_strings.slice[this] := _len;
_ptr_strings.slice[this] := _ptr;
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/Address.sol"} {:sourceLine 5} (true);
call Address_Address_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} isContract_Address(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s1673: Ref) returns (__ret_0_: bool);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC165.sol"} {:sourceLine 15} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC165.sol"} {:sourceLine 16} (true);
if ((DType[this]) == (EXODUS2)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC165_ERC165[this]);
} else if ((DType[this]) == (ERC721Full)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC165_ERC165[this]);
} else if ((DType[this]) == (ERC721Metadata)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC165_ERC165[this]);
} else if ((DType[this]) == (ERC721Enumerable)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC165_ERC165[this]);
} else if ((DType[this]) == (ERC721)) {
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

procedure {:public} {:inline 1} supportsInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s1707: int) returns (__ret_0_: bool);
implementation supportsInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s1707: int) returns (__ret_0_: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "interfaceId"} boogie_si_record_sol2Bpl_int(interfaceId_s1707);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC165.sol"} {:sourceLine 20} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC165.sol"} {:sourceLine 21} (true);
__ret_0_ := M_int_bool[_supportedInterfaces_ERC165[this]][interfaceId_s1707];
return;
}

procedure {:inline 1} _registerInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s1725: int);
implementation _registerInterface_ERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s1725: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "interfaceId"} boogie_si_record_sol2Bpl_int(interfaceId_s1725);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC165.sol"} {:sourceLine 25} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC165.sol"} {:sourceLine 26} (true);
assume ((interfaceId_s1725) != (-1));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC165.sol"} {:sourceLine 27} (true);
M_int_bool[_supportedInterfaces_ERC165[this]][interfaceId_s1725] := true;
call  {:cexpr "_supportedInterfaces[interfaceId]"} boogie_si_record_sol2Bpl_bool(M_int_bool[_supportedInterfaces_ERC165[this]][interfaceId_s1725]);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 23} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 24} (true);
if ((DType[this]) == (EXODUS2)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ERC721[this]);
} else if ((DType[this]) == (ERC721Full)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ERC721[this]);
} else if ((DType[this]) == (ERC721Metadata)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ERC721[this]);
} else if ((DType[this]) == (ERC721Enumerable)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ERC721[this]);
} else if ((DType[this]) == (ERC721)) {
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

procedure {:public} {:inline 1} balanceOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s475: Ref) returns (__ret_0_: int);
implementation balanceOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s475: Ref) returns (__ret_0_: int)
{
var __var_6: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s475);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 30} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 31} (true);
__var_6 := null;
assume ((owner_s475) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 32} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s475]) >= (0));
__ret_0_ := M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s475];
return;
}

procedure {:public} {:inline 1} ownerOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s499: int) returns (__ret_0_: Ref);
implementation ownerOf_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s499: int) returns (__ret_0_: Ref)
{
var owner_s498: Ref;
var __var_7: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s499);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 38} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 39} (true);
assume ((tokenId_s499) >= (0));
owner_s498 := M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s499];
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s498);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 40} (true);
__var_7 := null;
assume ((owner_s498) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 41} (true);
__ret_0_ := owner_s498;
return;
}

const {:existential true} HoudiniF1_approve_ERC721: bool;
const {:existential true} HoudiniF2_approve_ERC721: bool;
const {:existential true} HoudiniF3_approve_ERC721: bool;
const {:existential true} HoudiniF4_approve_ERC721: bool;
const {:existential true} HoudiniF5_approve_ERC721: bool;
const {:existential true} HoudiniF6_approve_ERC721: bool;
const {:existential true} HoudiniF7_approve_ERC721: bool;
const {:existential true} HoudiniF8_approve_ERC721: bool;
const {:existential true} HoudiniF9_approve_ERC721: bool;
const {:existential true} HoudiniF10_approve_ERC721: bool;
const {:existential true} HoudiniF11_approve_ERC721: bool;
procedure {:public} {:inline 1} approve_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s667: Ref, tokenId_s667: int);
requires HoudiniF1_approve_ERC721 ==> ((tokenId_s667) > (0));
requires HoudiniF2_approve_ERC721 ==> ((msgsender_MSG) != (null));
requires HoudiniF3_approve_ERC721 ==> ((to_s667) != (null));
requires HoudiniF4_approve_ERC721 ==> (((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667])) == (null));
requires HoudiniF5_approve_ERC721 ==> ((msgsender_MSG) != (to_s667));
requires HoudiniF6_approve_ERC721 ==> ((msgsender_MSG) != ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667])));
requires HoudiniF7_approve_ERC721 ==> ((to_s667) != ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667])));
ensures HoudiniF8_approve_ERC721 ==> ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667]) != (null));
ensures HoudiniF9_approve_ERC721 ==> ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667]) != (msgsender_MSG));
ensures HoudiniF10_approve_ERC721 ==> ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667]) == (to_s667));
ensures HoudiniF11_approve_ERC721 ==> ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667]) != (old(M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667])));
implementation approve_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s667: Ref, tokenId_s667: int)
{
var __var_8: Ref;
var __var_9: Ref;
var __var_10: Ref;
var __var_11: Ref;
var owner_s666: Ref;
var __var_12: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s667);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s667);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 50} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 54} (true);
assume ((tokenId_s667) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 55} (true);
__var_8 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 56} (true);
__var_9 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 57} (true);
assume ((tokenId_s667) >= (0));
__var_10 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 58} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 59} (true);
assume ((tokenId_s667) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 60} (true);
assume ((tokenId_s667) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 61} (true);
assume ((tokenId_s667) >= (0));
__var_11 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 62} (true);
assume ((tokenId_s667) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 63} (true);
assume ((tokenId_s667) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 64} (true);
assume ((tokenId_s667) >= (0));
assume ((tokenId_s667) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 66} (true);
assume ((tokenId_s667) >= (0));
if ((DType[this]) == (EXODUS2)) {
call owner_s666 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s667);
} else if ((DType[this]) == (ERC721Full)) {
call owner_s666 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s667);
} else if ((DType[this]) == (ERC721Metadata)) {
call owner_s666 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s667);
} else if ((DType[this]) == (ERC721Enumerable)) {
call owner_s666 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s667);
} else if ((DType[this]) == (ERC721)) {
call owner_s666 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s667);
} else {
assume (false);
}
owner_s666 := owner_s666;
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s666);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 67} (true);
assume ((to_s667) != (owner_s666));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 68} (true);
if ((DType[this]) == (EXODUS2)) {
call __var_12 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s666, msgsender_MSG);
} else if ((DType[this]) == (ERC721Full)) {
call __var_12 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s666, msgsender_MSG);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_12 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s666, msgsender_MSG);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_12 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s666, msgsender_MSG);
} else if ((DType[this]) == (ERC721)) {
call __var_12 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s666, msgsender_MSG);
} else {
assume (false);
}
assume ((((msgsender_MSG) == (owner_s666))) || (__var_12));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 69} (true);
assume ((tokenId_s667) >= (0));
M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667] := to_s667;
call  {:cexpr "_tokenApprovals[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s667]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 70} (true);
assert {:EventEmitted "Approval_ERC721"} (true);
}

procedure {:public} {:inline 1} getApproved_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s685: int) returns (__ret_0_: Ref);
implementation getApproved_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s685: int) returns (__ret_0_: Ref)
{
var __var_13: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s685);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 77} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 78} (true);
assume ((tokenId_s685) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_13 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((DType[this]) == (ERC721Full)) {
call __var_13 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_13 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_13 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((DType[this]) == (ERC721)) {
call __var_13 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else {
assume (false);
}
assume (__var_13);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 79} (true);
assume ((tokenId_s685) >= (0));
__ret_0_ := M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s685];
return;
}

const {:existential true} HoudiniF12_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF13_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF14_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF15_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF16_setApprovalForAll_ERC721: bool;
const {:existential true} HoudiniF17_setApprovalForAll_ERC721: bool;
procedure {:public} {:inline 1} setApprovalForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s781: Ref, approved_s781: bool);
requires HoudiniF12_setApprovalForAll_ERC721 ==> ((approved_s781) == (true));
requires HoudiniF13_setApprovalForAll_ERC721 ==> (((M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s781])) == (false));
requires HoudiniF14_setApprovalForAll_ERC721 ==> ((msgsender_MSG) != (null));
requires HoudiniF15_setApprovalForAll_ERC721 ==> ((to_s781) != (null));
requires HoudiniF16_setApprovalForAll_ERC721 ==> ((msgsender_MSG) != (to_s781));
ensures HoudiniF17_setApprovalForAll_ERC721 ==> ((M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s781]) == (true));
implementation setApprovalForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s781: Ref, approved_s781: bool)
{
var __var_14: Ref;
var __var_15: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s781);
call  {:cexpr "approved"} boogie_si_record_sol2Bpl_bool(approved_s781);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 86} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 90} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 91} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 92} (true);
__var_14 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 93} (true);
__var_15 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 94} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 95} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 97} (true);
assume ((to_s781) != (msgsender_MSG));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 98} (true);
M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s781] := approved_s781;
call  {:cexpr "_operatorApprovals[msg.sender][to]"} boogie_si_record_sol2Bpl_bool(M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][msgsender_MSG]][to_s781]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 99} (true);
assert {:EventEmitted "ApprovalForAll_ERC721"} (true);
}

procedure {:public} {:inline 1} isApprovedForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s797: Ref, operator_s797: Ref) returns (__ret_0_: bool);
implementation isApprovedForAll_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s797: Ref, operator_s797: Ref) returns (__ret_0_: bool)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s797);
call  {:cexpr "operator"} boogie_si_record_sol2Bpl_ref(operator_s797);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 106} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 107} (true);
__ret_0_ := M_Ref_bool[M_Ref_Ref[_operatorApprovals_ERC721[this]][owner_s797]][operator_s797];
return;
}

const {:existential true} HoudiniF18_transferFrom_ERC721: bool;
const {:existential true} HoudiniF19_transferFrom_ERC721: bool;
const {:existential true} HoudiniF20_transferFrom_ERC721: bool;
const {:existential true} HoudiniF21_transferFrom_ERC721: bool;
const {:existential true} HoudiniF22_transferFrom_ERC721: bool;
procedure {:public} {:inline 1} transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s868: Ref, to_s868: Ref, tokenId_s868: int);
requires HoudiniF18_transferFrom_ERC721 ==> ((tokenId_s868) > (0));
requires HoudiniF19_transferFrom_ERC721 ==> ((from_s868) != (null));
requires HoudiniF20_transferFrom_ERC721 ==> ((msgsender_MSG) != (null));
requires HoudiniF21_transferFrom_ERC721 ==> ((to_s868) != (null));
requires HoudiniF22_transferFrom_ERC721 ==> ((from_s868) != (to_s868));
implementation transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s868: Ref, to_s868: Ref, tokenId_s868: int)
{
var __var_16: Ref;
var __var_17: Ref;
var __var_18: Ref;
var __var_19: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s868);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s868);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s868);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 116} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 120} (true);
assume ((tokenId_s868) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 121} (true);
__var_16 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 122} (true);
__var_17 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 123} (true);
__var_18 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 124} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 126} (true);
assume ((tokenId_s868) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_19 := _isApprovedOrOwner_ERC721(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, tokenId_s868);
} else if ((DType[this]) == (ERC721Full)) {
call __var_19 := _isApprovedOrOwner_ERC721(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, tokenId_s868);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_19 := _isApprovedOrOwner_ERC721(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, tokenId_s868);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_19 := _isApprovedOrOwner_ERC721(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, tokenId_s868);
} else if ((DType[this]) == (ERC721)) {
call __var_19 := _isApprovedOrOwner_ERC721(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, tokenId_s868);
} else {
assume (false);
}
assume (__var_19);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 127} (true);
assume ((tokenId_s868) >= (0));
if ((DType[this]) == (EXODUS2)) {
call _transferFrom_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((DType[this]) == (ERC721Full)) {
call _transferFrom_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((DType[this]) == (ERC721Metadata)) {
call _transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((DType[this]) == (ERC721Enumerable)) {
call _transferFrom_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((DType[this]) == (ERC721)) {
call _transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else {
assume (false);
}
}

procedure {:public} {:inline 1} safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s887: Ref, to_s887: Ref, tokenId_s887: int);
implementation safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s887: Ref, to_s887: Ref, tokenId_s887: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s887);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s887);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s887);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 139} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 140} (true);
assume ((tokenId_s887) >= (0));
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s887, to_s887, tokenId_s887, -1038550195);
}

procedure {:public} {:inline 1} _safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s914: Ref, to_s914: Ref, tokenId_s914: int, _data_s914: int);
implementation _safeTransferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s914: Ref, to_s914: Ref, tokenId_s914: int, _data_s914: int)
{
var __var_20: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s914);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s914);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s914);
call  {:cexpr "_data"} boogie_si_record_sol2Bpl_int(_data_s914);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 153} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 154} (true);
assume ((tokenId_s914) >= (0));
if ((DType[this]) == (EXODUS2)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914);
} else if ((DType[this]) == (ERC721Full)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914);
} else if ((DType[this]) == (ERC721Metadata)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914);
} else if ((DType[this]) == (ERC721Enumerable)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914);
} else if ((DType[this]) == (ERC721)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914);
} else {
assume (false);
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 155} (true);
assume ((tokenId_s914) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_20 := _checkOnERC721Received_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((DType[this]) == (ERC721Full)) {
call __var_20 := _checkOnERC721Received_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_20 := _checkOnERC721Received_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_20 := _checkOnERC721Received_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((DType[this]) == (ERC721)) {
call __var_20 := _checkOnERC721Received_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else {
assume (false);
}
assume (__var_20);
}

procedure {:inline 1} _exists_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s934: int) returns (__ret_0_: bool);
implementation _exists_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s934: int) returns (__ret_0_: bool)
{
var owner_s933: Ref;
var __var_21: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s934);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 161} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 162} (true);
assume ((tokenId_s934) >= (0));
owner_s933 := M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s934];
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s933);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 163} (true);
__var_21 := null;
__ret_0_ := (owner_s933) != (null);
return;
}

procedure {:inline 1} _isApprovedOrOwner_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s969: Ref, tokenId_s969: int) returns (__ret_0_: bool);
implementation _isApprovedOrOwner_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s969: Ref, tokenId_s969: int) returns (__ret_0_: bool)
{
var owner_s968: Ref;
var __var_22: Ref;
var __var_23: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s969);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s969);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 171} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 172} (true);
assume ((tokenId_s969) >= (0));
if ((DType[this]) == (EXODUS2)) {
call owner_s968 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721Full)) {
call owner_s968 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721Metadata)) {
call owner_s968 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721Enumerable)) {
call owner_s968 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721)) {
call owner_s968 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else {
assume (false);
}
owner_s968 := owner_s968;
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s968);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 173} (true);
assume ((tokenId_s969) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_22 := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721Full)) {
call __var_22 := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_22 := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_22 := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else if ((DType[this]) == (ERC721)) {
call __var_22 := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s969);
} else {
assume (false);
}
if ((DType[this]) == (EXODUS2)) {
call __var_23 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s968, spender_s969);
} else if ((DType[this]) == (ERC721Full)) {
call __var_23 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s968, spender_s969);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_23 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s968, spender_s969);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_23 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s968, spender_s969);
} else if ((DType[this]) == (ERC721)) {
call __var_23 := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s968, spender_s969);
} else {
assume (false);
}
__ret_0_ := (((((spender_s969) == (owner_s968))) || (((__var_22) == (spender_s969))))) || (__var_23);
return;
}

procedure {:inline 1} _mint_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s1017: Ref, tokenId_s1017: int);
implementation _mint_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s1017: Ref, tokenId_s1017: int)
{
var __var_24: Ref;
var __var_25: bool;
var __var_26: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s1017);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1017);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 180} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 181} (true);
__var_24 := null;
assume ((to_s1017) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 182} (true);
assume ((tokenId_s1017) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_25 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1017);
} else if ((DType[this]) == (ERC721Full)) {
call __var_25 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1017);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_25 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1017);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_25 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1017);
} else if ((DType[this]) == (ERC721)) {
call __var_25 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1017);
} else {
assume (false);
}
assume (!(__var_25));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 183} (true);
assume ((tokenId_s1017) >= (0));
M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s1017] := to_s1017;
call  {:cexpr "_tokenOwner[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s1017]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 184} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1017]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1017]) >= (0));
call __var_26 := add_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1017], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1017] := __var_26;
assume ((__var_26) >= (0));
call  {:cexpr "_ownedTokensCount[to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1017]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 185} (true);
assert {:EventEmitted "Transfer_ERC721"} (true);
}

procedure {:inline 1} _burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1064: Ref, tokenId_s1064: int);
implementation _burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1064: Ref, tokenId_s1064: int)
{
var __var_27: Ref;
var __var_28: int;
var __var_29: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s1064);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1064);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 193} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 194} (true);
assume ((tokenId_s1064) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_27 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1064);
} else if ((DType[this]) == (ERC721Full)) {
call __var_27 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1064);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_27 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1064);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_27 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1064);
} else if ((DType[this]) == (ERC721)) {
call __var_27 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1064);
} else {
assume (false);
}
assume ((__var_27) == (owner_s1064));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 195} (true);
assume ((tokenId_s1064) >= (0));
call _clearApproval_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1064);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 196} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s1064]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s1064]) >= (0));
call __var_28 := sub_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s1064], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s1064] := __var_28;
assume ((__var_28) >= (0));
call  {:cexpr "_ownedTokensCount[owner]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][owner_s1064]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 197} (true);
assume ((tokenId_s1064) >= (0));
__var_29 := null;
M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s1064] := __var_29;
call  {:cexpr "_tokenOwner[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s1064]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 198} (true);
assert {:EventEmitted "Transfer_ERC721"} (true);
}

procedure {:inline 1} __burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1077: int);
implementation __burn_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1077: int)
{
var __var_30: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1077);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 204} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 205} (true);
assume ((tokenId_s1077) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_30 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1077);
} else if ((DType[this]) == (ERC721Full)) {
call __var_30 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1077);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_30 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1077);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_30 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1077);
} else if ((DType[this]) == (ERC721)) {
call __var_30 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1077);
} else {
assume (false);
}
assume ((tokenId_s1077) >= (0));
if ((DType[this]) == (EXODUS2)) {
call _burn_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, __var_30, tokenId_s1077);
} else if ((DType[this]) == (ERC721Full)) {
call _burn_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, __var_30, tokenId_s1077);
} else if ((DType[this]) == (ERC721Metadata)) {
call _burn_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, __var_30, tokenId_s1077);
} else if ((DType[this]) == (ERC721Enumerable)) {
call _burn_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, __var_30, tokenId_s1077);
} else if ((DType[this]) == (ERC721)) {
call _burn_ERC721(this, msgsender_MSG, msgvalue_MSG, __var_30, tokenId_s1077);
} else {
assume (false);
}
}

procedure {:inline 1} _transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1141: Ref, to_s1141: Ref, tokenId_s1141: int);
implementation _transferFrom_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1141: Ref, to_s1141: Ref, tokenId_s1141: int)
{
var __var_31: Ref;
var __var_32: Ref;
var __var_33: int;
var __var_34: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s1141);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s1141);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1141);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 213} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 214} (true);
assume ((tokenId_s1141) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_31 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1141);
} else if ((DType[this]) == (ERC721Full)) {
call __var_31 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1141);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_31 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1141);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_31 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1141);
} else if ((DType[this]) == (ERC721)) {
call __var_31 := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1141);
} else {
assume (false);
}
assume ((__var_31) == (from_s1141));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 215} (true);
__var_32 := null;
assume ((to_s1141) != (null));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 216} (true);
assume ((tokenId_s1141) >= (0));
call _clearApproval_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1141);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 217} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][from_s1141]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][from_s1141]) >= (0));
call __var_33 := sub_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][from_s1141], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][from_s1141] := __var_33;
assume ((__var_33) >= (0));
call  {:cexpr "_ownedTokensCount[from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][from_s1141]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 218} (true);
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1141]) >= (0));
assume ((M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1141]) >= (0));
call __var_34 := add_SafeMath(this, this, 0, M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1141], 1);
M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1141] := __var_34;
assume ((__var_34) >= (0));
call  {:cexpr "_ownedTokensCount[to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[_ownedTokensCount_ERC721[this]][to_s1141]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 219} (true);
assume ((tokenId_s1141) >= (0));
M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s1141] := to_s1141;
call  {:cexpr "_tokenOwner[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenOwner_ERC721[this]][tokenId_s1141]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 220} (true);
assert {:EventEmitted "Transfer_ERC721"} (true);
}

procedure {:inline 1} _checkOnERC721Received_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1181: Ref, to_s1181: Ref, tokenId_s1181: int, _data_s1181: int) returns (__ret_0_: bool);
implementation _checkOnERC721Received_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1181: Ref, to_s1181: Ref, tokenId_s1181: int, _data_s1181: int) returns (__ret_0_: bool)
{
var __var_35: bool;
var retval_s1180: int;
var __var_36: Ref;
var __var_37: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s1181);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s1181);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1181);
call  {:cexpr "_data"} boogie_si_record_sol2Bpl_int(_data_s1181);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 230} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 231} (true);
call __var_35 := isContract_Address(this, this, 0, to_s1181);
if (!(__var_35)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 231} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 232} (true);
__ret_0_ := true;
return;
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 234} (true);
assume ((DType[to_s1181]) == (IERC721Receiver));
__var_36 := to_s1181;
assume ((tokenId_s1181) >= (0));
call retval_s1180 := onERC721Received_IERC721Receiver(__var_36, this, __var_37, msgsender_MSG, from_s1181, tokenId_s1181, _data_s1181);
retval_s1180 := retval_s1180;
call  {:cexpr "retval"} boogie_si_record_sol2Bpl_int(retval_s1180);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 235} (true);
__ret_0_ := (retval_s1180) == (_ERC721_RECEIVED_ERC721[this]);
return;
}

procedure {:inline 1} _clearApproval_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1204: int);
implementation _clearApproval_ERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1204: int)
{
var __var_38: Ref;
var __var_39: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1204);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 240} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 241} (true);
assume ((tokenId_s1204) >= (0));
__var_38 := null;
if ((M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s1204]) != (null)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 241} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721.sol"} {:sourceLine 242} (true);
assume ((tokenId_s1204) >= (0));
__var_39 := null;
M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s1204] := __var_39;
call  {:cexpr "_tokenApprovals[tokenId]"} boogie_si_record_sol2Bpl_ref(M_int_Ref[_tokenApprovals_ERC721[this]][tokenId_s1204]);
}
}

var _ownedTokens_ERC721Enumerable: [Ref]Ref;
var _ownedTokensIndex_ERC721Enumerable: [Ref]Ref;
var _allTokens_ERC721Enumerable: [Ref]Ref;
var _allTokensIndex_ERC721Enumerable: [Ref]Ref;
var _INTERFACE_ID_ERC721_ENUMERABLE_ERC721Enumerable: [Ref]int;
procedure {:inline 1} ERC721Enumerable_ERC721Enumerable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation ERC721Enumerable_ERC721Enumerable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_40: Ref;
var __var_41: Ref;
var __var_42: Ref;
var __var_43: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// Make array/mapping vars distinct for _ownedTokens
call __var_40 := FreshRefGenerator();
_ownedTokens_ERC721Enumerable[this] := __var_40;
// Initialize length of 1-level nested array in _ownedTokens
assume (forall  __i__0_0:Ref ::  ((Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][__i__0_0]]) == (0)));
assume (forall  __i__0_0:Ref ::  (!(Alloc[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][__i__0_0]])));
call HavocAllocMany();
assume (forall  __i__0_0:Ref ::  (Alloc[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][__i__0_0]]));
assume (forall  __i__0_0:Ref, __i__0_1:Ref :: {M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][__i__0_0], M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][__i__0_1]} (((__i__0_0) == (__i__0_1)) || ((M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][__i__0_0]) != (M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][__i__0_1]))));
// Make array/mapping vars distinct for _ownedTokensIndex
call __var_41 := FreshRefGenerator();
_ownedTokensIndex_ERC721Enumerable[this] := __var_41;
// Initialize Integer mapping _ownedTokensIndex
assume (forall  __i__0_0:int ::  ((M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][__i__0_0]) == (0)));
// Make array/mapping vars distinct for _allTokens
call __var_42 := FreshRefGenerator();
_allTokens_ERC721Enumerable[this] := __var_42;
assume ((Length[_allTokens_ERC721Enumerable[this]]) == (0));
// Make array/mapping vars distinct for _allTokensIndex
call __var_43 := FreshRefGenerator();
_allTokensIndex_ERC721Enumerable[this] := __var_43;
// Initialize Integer mapping _allTokensIndex
assume (forall  __i__0_0:int ::  ((M_int_int[_allTokensIndex_ERC721Enumerable[this]][__i__0_0]) == (0)));
_INTERFACE_ID_ERC721_ENUMERABLE_ERC721Enumerable[this] := 2014223715;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 18} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 19} (true);
if ((DType[this]) == (EXODUS2)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ENUMERABLE_ERC721Enumerable[this]);
} else if ((DType[this]) == (ERC721Full)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ENUMERABLE_ERC721Enumerable[this]);
} else if ((DType[this]) == (ERC721Enumerable)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_ENUMERABLE_ERC721Enumerable[this]);
} else {
assume (false);
}
}

procedure {:constructor} {:public} {:inline 1} ERC721Enumerable_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation ERC721Enumerable_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var __var_40: Ref;
var __var_41: Ref;
var __var_42: Ref;
var __var_43: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call ERC165_ERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
call ERC721_ERC721(this, msgsender_MSG, msgvalue_MSG);
call IERC721Enumerable_IERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
call ERC721Enumerable_ERC721Enumerable_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} tokenOfOwnerByIndex_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1268: Ref, index_s1268: int) returns (__ret_0_: int);
implementation tokenOfOwnerByIndex_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1268: Ref, index_s1268: int) returns (__ret_0_: int)
{
var __var_44: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s1268);
call  {:cexpr "index"} boogie_si_record_sol2Bpl_int(index_s1268);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 26} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 27} (true);
assume ((index_s1268) >= (0));
assume ((__var_44) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_44 := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1268);
} else if ((DType[this]) == (ERC721Full)) {
call __var_44 := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1268);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_44 := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1268);
} else {
assume (false);
}
assume ((__var_44) >= (0));
assume ((index_s1268) < (__var_44));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 28} (true);
assume ((index_s1268) >= (0));
assume ((M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][owner_s1268]][index_s1268]) >= (0));
__ret_0_ := M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][owner_s1268]][index_s1268];
return;
}

procedure {:public} {:inline 1} totalSupply_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
implementation totalSupply_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 33} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 34} (true);
assume ((Length[_allTokens_ERC721Enumerable[this]]) >= (0));
__ret_0_ := Length[_allTokens_ERC721Enumerable[this]];
return;
}

procedure {:public} {:inline 1} tokenByIndex_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, index_s1296: int) returns (__ret_0_: int);
implementation tokenByIndex_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, index_s1296: int) returns (__ret_0_: int)
{
var __var_45: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "index"} boogie_si_record_sol2Bpl_int(index_s1296);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 41} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 42} (true);
assume ((index_s1296) >= (0));
assume ((__var_45) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_45 := totalSupply_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
} else if ((DType[this]) == (ERC721Full)) {
call __var_45 := totalSupply_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
} else if ((DType[this]) == (ERC721Enumerable)) {
call __var_45 := totalSupply_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
} else {
assume (false);
}
assume ((__var_45) >= (0));
assume ((index_s1296) < (__var_45));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 43} (true);
assume ((index_s1296) >= (0));
assume ((M_int_int[_allTokens_ERC721Enumerable[this]][index_s1296]) >= (0));
__ret_0_ := M_int_int[_allTokens_ERC721Enumerable[this]][index_s1296];
return;
}

procedure {:inline 1} _transferFrom_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1324: Ref, to_s1324: Ref, tokenId_s1324: int);
implementation _transferFrom_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1324: Ref, to_s1324: Ref, tokenId_s1324: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s1324);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s1324);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1324);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 51} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 52} (true);
assume ((tokenId_s1324) >= (0));
call _transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s1324, to_s1324, tokenId_s1324);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 53} (true);
assume ((tokenId_s1324) >= (0));
call _removeTokenFromOwnerEnumeration_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, from_s1324, tokenId_s1324);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 54} (true);
assume ((tokenId_s1324) >= (0));
call _addTokenToOwnerEnumeration_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, to_s1324, tokenId_s1324);
}

procedure {:inline 1} _mint_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s1348: Ref, tokenId_s1348: int);
implementation _mint_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s1348: Ref, tokenId_s1348: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s1348);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1348);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 61} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 62} (true);
assume ((tokenId_s1348) >= (0));
call _mint_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s1348, tokenId_s1348);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 63} (true);
assume ((tokenId_s1348) >= (0));
call _addTokenToOwnerEnumeration_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, to_s1348, tokenId_s1348);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 64} (true);
assume ((tokenId_s1348) >= (0));
call _addTokenToAllTokensEnumeration_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, tokenId_s1348);
}

procedure {:inline 1} _burn_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1378: Ref, tokenId_s1378: int);
implementation _burn_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1378: Ref, tokenId_s1378: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s1378);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1378);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 72} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 73} (true);
assume ((tokenId_s1378) >= (0));
call _burn_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1378, tokenId_s1378);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 74} (true);
assume ((tokenId_s1378) >= (0));
call _removeTokenFromOwnerEnumeration_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, owner_s1378, tokenId_s1378);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 75} (true);
assume ((tokenId_s1378) >= (0));
assume ((M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1378]) >= (0));
M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1378] := 0;
call  {:cexpr "_ownedTokensIndex[tokenId]"} boogie_si_record_sol2Bpl_int(M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1378]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 76} (true);
assume ((tokenId_s1378) >= (0));
call _removeTokenFromAllTokensEnumeration_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, tokenId_s1378);
}

procedure {:inline 1} _tokensOfOwner_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1391: Ref) returns (__ret_0_: Ref);
implementation _tokensOfOwner_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1391: Ref) returns (__ret_0_: Ref)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s1391);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 82} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 83} (true);
__ret_0_ := M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][owner_s1391];
return;
}

procedure {:inline 1} _addTokenToOwnerEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s1415: Ref, tokenId_s1415: int);
implementation _addTokenToOwnerEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s1415: Ref, tokenId_s1415: int)
{
var __var_46: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "to"} boogie_si_record_sol2Bpl_ref(to_s1415);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1415);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 89} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 90} (true);
assume ((tokenId_s1415) >= (0));
assume ((M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1415]) >= (0));
assume ((Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][to_s1415]]) >= (0));
M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1415] := Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][to_s1415]];
call  {:cexpr "_ownedTokensIndex[tokenId]"} boogie_si_record_sol2Bpl_int(M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1415]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 91} (true);
assume ((tokenId_s1415) >= (0));
__var_46 := Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][to_s1415]];
M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][to_s1415]][__var_46] := tokenId_s1415;
Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][to_s1415]] := (__var_46) + (1);
}

procedure {:inline 1} _addTokenToAllTokensEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1434: int);
implementation _addTokenToAllTokensEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1434: int)
{
var __var_47: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1434);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 96} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 97} (true);
assume ((tokenId_s1434) >= (0));
assume ((M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1434]) >= (0));
assume ((Length[_allTokens_ERC721Enumerable[this]]) >= (0));
M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1434] := Length[_allTokens_ERC721Enumerable[this]];
call  {:cexpr "_allTokensIndex[tokenId]"} boogie_si_record_sol2Bpl_int(M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1434]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 98} (true);
assume ((tokenId_s1434) >= (0));
__var_47 := Length[_allTokens_ERC721Enumerable[this]];
M_int_int[_allTokens_ERC721Enumerable[this]][__var_47] := tokenId_s1434;
Length[_allTokens_ERC721Enumerable[this]] := (__var_47) + (1);
}

procedure {:inline 1} _removeTokenFromOwnerEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1491: Ref, tokenId_s1491: int);
implementation _removeTokenFromOwnerEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1491: Ref, tokenId_s1491: int)
{
var lastTokenIndex_s1490: int;
var tokenIndex_s1490: int;
var lastTokenId_s1482: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "from"} boogie_si_record_sol2Bpl_ref(from_s1491);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1491);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 107} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 108} (true);
assume ((lastTokenIndex_s1490) >= (0));
assume ((Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]]) >= (0));
call lastTokenIndex_s1490 := sub_SafeMath(this, this, 0, Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]], 1);
lastTokenIndex_s1490 := lastTokenIndex_s1490;
call  {:cexpr "lastTokenIndex"} boogie_si_record_sol2Bpl_int(lastTokenIndex_s1490);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 109} (true);
assume ((tokenIndex_s1490) >= (0));
assume ((tokenId_s1491) >= (0));
assume ((M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1491]) >= (0));
tokenIndex_s1490 := M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][tokenId_s1491];
call  {:cexpr "tokenIndex"} boogie_si_record_sol2Bpl_int(tokenIndex_s1490);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 110} (true);
assume ((tokenIndex_s1490) >= (0));
assume ((lastTokenIndex_s1490) >= (0));
if ((tokenIndex_s1490) != (lastTokenIndex_s1490)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 110} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 111} (true);
assume ((lastTokenId_s1482) >= (0));
assume ((lastTokenIndex_s1490) >= (0));
assume ((M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]][lastTokenIndex_s1490]) >= (0));
lastTokenId_s1482 := M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]][lastTokenIndex_s1490];
call  {:cexpr "lastTokenId"} boogie_si_record_sol2Bpl_int(lastTokenId_s1482);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 112} (true);
assume ((tokenIndex_s1490) >= (0));
assume ((M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]][tokenIndex_s1490]) >= (0));
assume ((lastTokenId_s1482) >= (0));
M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]][tokenIndex_s1490] := lastTokenId_s1482;
call  {:cexpr "_ownedTokens[from][tokenIndex]"} boogie_si_record_sol2Bpl_int(M_int_int[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]][tokenIndex_s1490]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 113} (true);
assume ((lastTokenId_s1482) >= (0));
assume ((M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][lastTokenId_s1482]) >= (0));
assume ((tokenIndex_s1490) >= (0));
M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][lastTokenId_s1482] := tokenIndex_s1490;
call  {:cexpr "_ownedTokensIndex[lastTokenId]"} boogie_si_record_sol2Bpl_int(M_int_int[_ownedTokensIndex_ERC721Enumerable[this]][lastTokenId_s1482]);
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 115} (true);
assume ((Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]]) >= (0));
Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]] := (Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]]) - (1);
call  {:cexpr "_ownedTokens[from].length"} boogie_si_record_sol2Bpl_int(Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]]);
assume ((Length[M_Ref_Ref[_ownedTokens_ERC721Enumerable[this]][from_s1491]]) >= (0));
}

procedure {:inline 1} _removeTokenFromAllTokensEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1540: int);
implementation _removeTokenFromAllTokensEnumeration_ERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1540: int)
{
var lastTokenIndex_s1539: int;
var tokenIndex_s1539: int;
var lastTokenId_s1539: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1540);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 121} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 122} (true);
assume ((lastTokenIndex_s1539) >= (0));
assume ((Length[_allTokens_ERC721Enumerable[this]]) >= (0));
call lastTokenIndex_s1539 := sub_SafeMath(this, this, 0, Length[_allTokens_ERC721Enumerable[this]], 1);
lastTokenIndex_s1539 := lastTokenIndex_s1539;
call  {:cexpr "lastTokenIndex"} boogie_si_record_sol2Bpl_int(lastTokenIndex_s1539);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 123} (true);
assume ((tokenIndex_s1539) >= (0));
assume ((tokenId_s1540) >= (0));
assume ((M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1540]) >= (0));
tokenIndex_s1539 := M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1540];
call  {:cexpr "tokenIndex"} boogie_si_record_sol2Bpl_int(tokenIndex_s1539);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 124} (true);
assume ((lastTokenId_s1539) >= (0));
assume ((lastTokenIndex_s1539) >= (0));
assume ((M_int_int[_allTokens_ERC721Enumerable[this]][lastTokenIndex_s1539]) >= (0));
lastTokenId_s1539 := M_int_int[_allTokens_ERC721Enumerable[this]][lastTokenIndex_s1539];
call  {:cexpr "lastTokenId"} boogie_si_record_sol2Bpl_int(lastTokenId_s1539);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 125} (true);
assume ((tokenIndex_s1539) >= (0));
assume ((M_int_int[_allTokens_ERC721Enumerable[this]][tokenIndex_s1539]) >= (0));
assume ((lastTokenId_s1539) >= (0));
M_int_int[_allTokens_ERC721Enumerable[this]][tokenIndex_s1539] := lastTokenId_s1539;
call  {:cexpr "_allTokens[tokenIndex]"} boogie_si_record_sol2Bpl_int(M_int_int[_allTokens_ERC721Enumerable[this]][tokenIndex_s1539]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 126} (true);
assume ((lastTokenId_s1539) >= (0));
assume ((M_int_int[_allTokensIndex_ERC721Enumerable[this]][lastTokenId_s1539]) >= (0));
assume ((tokenIndex_s1539) >= (0));
M_int_int[_allTokensIndex_ERC721Enumerable[this]][lastTokenId_s1539] := tokenIndex_s1539;
call  {:cexpr "_allTokensIndex[lastTokenId]"} boogie_si_record_sol2Bpl_int(M_int_int[_allTokensIndex_ERC721Enumerable[this]][lastTokenId_s1539]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 127} (true);
assume ((Length[_allTokens_ERC721Enumerable[this]]) >= (0));
Length[_allTokens_ERC721Enumerable[this]] := (Length[_allTokens_ERC721Enumerable[this]]) - (1);
call  {:cexpr "_allTokens.length"} boogie_si_record_sol2Bpl_int(Length[_allTokens_ERC721Enumerable[this]]);
assume ((Length[_allTokens_ERC721Enumerable[this]]) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Enumerable.sol"} {:sourceLine 128} (true);
assume ((tokenId_s1540) >= (0));
assume ((M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1540]) >= (0));
M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1540] := 0;
call  {:cexpr "_allTokensIndex[tokenId]"} boogie_si_record_sol2Bpl_int(M_int_int[_allTokensIndex_ERC721Enumerable[this]][tokenId_s1540]);
}

procedure {:inline 1} ERC721Full_ERC721Full_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s93: int, symbol_s93: int);
implementation ERC721Full_ERC721Full_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s93: int, symbol_s93: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_s93);
call  {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_s93);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Full.sol"} {:sourceLine 13} (true);
}

procedure {:constructor} {:public} {:inline 1} ERC721Full_ERC721Full(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s93: int, symbol_s93: int);
implementation ERC721Full_ERC721Full(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s93: int, symbol_s93: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_s93);
call  {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_s93);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call ERC165_ERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
call ERC721_ERC721(this, msgsender_MSG, msgvalue_MSG);
call IERC721Enumerable_IERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
call ERC721Enumerable_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
call IERC721Metadata_IERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
call ERC721Metadata_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, name_s93, symbol_s93);
call ERC721Full_ERC721Full_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, name_s93, symbol_s93);
}

var _name_ERC721Metadata: [Ref]int;
var _symbol_ERC721Metadata: [Ref]int;
var _tokenURIs_ERC721Metadata: [Ref]Ref;
var _INTERFACE_ID_ERC721_METADATA_ERC721Metadata: [Ref]int;
procedure {:inline 1} ERC721Metadata_ERC721Metadata_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s1584: int, symbol_s1584: int);
implementation ERC721Metadata_ERC721Metadata_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s1584: int, symbol_s1584: int)
{
var __var_48: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
_name_ERC721Metadata[this] := -1038550195;
_symbol_ERC721Metadata[this] := -1038550195;
// Make array/mapping vars distinct for _tokenURIs
call __var_48 := FreshRefGenerator();
_tokenURIs_ERC721Metadata[this] := __var_48;
_INTERFACE_ID_ERC721_METADATA_ERC721Metadata[this] := 1532892063;
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_s1584);
call  {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_s1584);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 15} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 16} (true);
_name_ERC721Metadata[this] := name_s1584;
call  {:cexpr "_name"} boogie_si_record_sol2Bpl_int(_name_ERC721Metadata[this]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 17} (true);
_symbol_ERC721Metadata[this] := symbol_s1584;
call  {:cexpr "_symbol"} boogie_si_record_sol2Bpl_int(_symbol_ERC721Metadata[this]);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 18} (true);
if ((DType[this]) == (EXODUS2)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_METADATA_ERC721Metadata[this]);
} else if ((DType[this]) == (ERC721Full)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_METADATA_ERC721Metadata[this]);
} else if ((DType[this]) == (ERC721Metadata)) {
call _registerInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, _INTERFACE_ID_ERC721_METADATA_ERC721Metadata[this]);
} else {
assume (false);
}
}

procedure {:constructor} {:public} {:inline 1} ERC721Metadata_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s1584: int, symbol_s1584: int);
implementation ERC721Metadata_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, name_s1584: int, symbol_s1584: int)
{
var __var_48: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_s1584);
call  {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_s1584);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call ERC165_ERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
call ERC721_ERC721(this, msgsender_MSG, msgvalue_MSG);
call IERC721Metadata_IERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
call ERC721Metadata_ERC721Metadata_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, name_s1584, symbol_s1584);
}

procedure {:public} {:inline 1} name_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
implementation name_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 23} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 24} (true);
__ret_0_ := _name_ERC721Metadata[this];
return;
}

procedure {:public} {:inline 1} symbol_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
implementation symbol_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 29} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 30} (true);
__ret_0_ := _symbol_ERC721Metadata[this];
return;
}

procedure {:public} {:inline 1} tokenURI_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1618: int) returns (__ret_0_: int);
implementation tokenURI_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1618: int) returns (__ret_0_: int)
{
var __var_49: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1618);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 36} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 37} (true);
assume ((tokenId_s1618) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_49 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1618);
} else if ((DType[this]) == (ERC721Full)) {
call __var_49 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1618);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_49 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1618);
} else {
assume (false);
}
assume (__var_49);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 38} (true);
assume ((tokenId_s1618) >= (0));
__ret_0_ := M_int_int[_tokenURIs_ERC721Metadata[this]][tokenId_s1618];
return;
}

procedure {:inline 1} _setTokenURI_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1638: int, uri_s1638: int);
implementation _setTokenURI_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1638: int, uri_s1638: int)
{
var __var_50: bool;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1638);
call  {:cexpr "uri"} boogie_si_record_sol2Bpl_int(uri_s1638);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 45} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 46} (true);
assume ((tokenId_s1638) >= (0));
if ((DType[this]) == (EXODUS2)) {
call __var_50 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1638);
} else if ((DType[this]) == (ERC721Full)) {
call __var_50 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1638);
} else if ((DType[this]) == (ERC721Metadata)) {
call __var_50 := _exists_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1638);
} else {
assume (false);
}
assume (__var_50);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 47} (true);
assume ((tokenId_s1638) >= (0));
M_int_int[_tokenURIs_ERC721Metadata[this]][tokenId_s1638] := uri_s1638;
call  {:cexpr "_tokenURIs[tokenId]"} boogie_si_record_sol2Bpl_int(M_int_int[_tokenURIs_ERC721Metadata[this]][tokenId_s1638]);
}

procedure {:inline 1} _burn_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1653: Ref, tokenId_s1653: int);
implementation _burn_ERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1653: Ref, tokenId_s1653: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "owner"} boogie_si_record_sol2Bpl_ref(owner_s1653);
call  {:cexpr "tokenId"} boogie_si_record_sol2Bpl_int(tokenId_s1653);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 55} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/ERC721Metadata.sol"} {:sourceLine 56} (true);
assume ((tokenId_s1653) >= (0));
call _burn_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1653, tokenId_s1653);
}

var stanzas_EXODUS2: [Ref]Ref;
procedure {:inline 1} EXODUS2_EXODUS2_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation EXODUS2_EXODUS2_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var i_s31: int;
var __var_51: Ref;
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// Make array/mapping vars distinct for stanzas
call __var_51 := FreshRefGenerator();
stanzas_EXODUS2[this] := __var_51;
assume ((Length[stanzas_EXODUS2[this]]) == (0));
// end of initialization
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 13} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 14} (true);
assume ((i_s31) >= (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 14} (true);
assume ((i_s31) >= (0));
i_s31 := 1;
call  {:cexpr "i"} boogie_si_record_sol2Bpl_int(i_s31);
while ((i_s31) < (20))
{
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 14} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 15} (true);
assume ((i_s31) >= (0));
if ((DType[this]) == (EXODUS2)) {
call _mint_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, i_s31);
} else {
assume (false);
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 14} (true);
assume ((i_s31) >= (0));
i_s31 := (i_s31) + (1);
call  {:cexpr "i"} boogie_si_record_sol2Bpl_int(i_s31);
assume ((i_s31) >= (0));
}
}

procedure {:constructor} {:public} {:inline 1} EXODUS2_EXODUS2(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation EXODUS2_EXODUS2(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
var i_s31: int;
var __var_51: Ref;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call ERC165_ERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
call ERC721_ERC721(this, msgsender_MSG, msgvalue_MSG);
call IERC721Enumerable_IERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
call ERC721Enumerable_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
call IERC721Metadata_IERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
call ERC721Full_ERC721Full(this, msgsender_MSG, msgvalue_MSG, 1436477499, 156169725);
call EXODUS2_EXODUS2_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

const {:existential true} HoudiniF23_deploy_EXODUS2: bool;
procedure {:public} {:inline 1} deploy_EXODUS2(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, pangram_s64: int);
requires HoudiniF23_deploy_EXODUS2 ==> ((msgsender_MSG) != (null));
implementation deploy_EXODUS2(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, pangram_s64: int)
{
var __var_52: Ref;
var __var_53: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "pangram"} boogie_si_record_sol2Bpl_int(pangram_s64);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 19} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 25} (true);
__var_52 := null;
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 27} (true);
assume ((Length[stanzas_EXODUS2[this]]) >= (0));
assume ((Length[stanzas_EXODUS2[this]]) < (19));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 28} (true);
__var_53 := Length[stanzas_EXODUS2[this]];
M_int_int[stanzas_EXODUS2[this]][__var_53] := pangram_s64;
Length[stanzas_EXODUS2[this]] := (__var_53) + (1);
}

procedure {:inline 1} contractInvariant_EXODUS2(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation contractInvariant_EXODUS2(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/EXODUS2.sol"} {:sourceLine 61} (true);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/IERC165.sol"} {:sourceLine 6} (true);
call IERC165_IERC165_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} supportsInterface_IERC165(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, interfaceId_s2039: int) returns (__ret_0_: bool);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/IERC721.sol"} {:sourceLine 8} (true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} balanceOf_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1763: Ref) returns (balance_s1763: int);
procedure {:public} {:inline 1} ownerOf_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1770: int) returns (owner_s1770: Ref);
procedure {:public} {:inline 1} approve_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, to_s1777: Ref, tokenId_s1777: int);
procedure {:public} {:inline 1} getApproved_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s1784: int) returns (operator_s1784: Ref);
procedure {:public} {:inline 1} setApprovalForAll_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, operator_s1791: Ref, _approved_s1791: bool);
procedure {:public} {:inline 1} isApprovedForAll_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1800: Ref, operator_s1800: Ref) returns (__ret_0_: bool);
procedure {:public} {:inline 1} transferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1809: Ref, to_s1809: Ref, tokenId_s1809: int);
procedure {:public} {:inline 1} safeTransferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1818: Ref, to_s1818: Ref, tokenId_s1818: int);
procedure {:public} {:inline 1} _safeTransferFrom_IERC721(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, from_s1829: Ref, to_s1829: Ref, tokenId_s1829: int, data_s1829: int);
procedure {:inline 1} IERC721Enumerable_IERC721Enumerable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721Enumerable_IERC721Enumerable_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} IERC721Enumerable_IERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721Enumerable_IERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/IERC721Enumerable.sol"} {:sourceLine 8} (true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
call IERC721Enumerable_IERC721Enumerable_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} totalSupply_IERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
procedure {:public} {:inline 1} tokenOfOwnerByIndex_IERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s1997: Ref, index_s1997: int) returns (tokenId_s1997: int);
procedure {:public} {:inline 1} tokenByIndex_IERC721Enumerable(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, index_s2004: int) returns (__ret_0_: int);
procedure {:inline 1} IERC721Metadata_IERC721Metadata_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721Metadata_IERC721Metadata_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} IERC721Metadata_IERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation IERC721Metadata_IERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/IERC721Metadata.sol"} {:sourceLine 8} (true);
call IERC165_IERC165(this, msgsender_MSG, msgvalue_MSG);
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
call IERC721Metadata_IERC721Metadata_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} name_IERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
procedure {:public} {:inline 1} symbol_IERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);
procedure {:public} {:inline 1} tokenURI_IERC721Metadata(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, tokenId_s2028: int) returns (__ret_0_: int);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/IERC721Receiver.sol"} {:sourceLine 7} (true);
call IERC721Receiver_IERC721Receiver_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:public} {:inline 1} onERC721Received_IERC721Receiver(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, operator_s1846: Ref, from_s1846: Ref, tokenId_s1846: int, data_s1846: int) returns (__ret_0_: int);
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
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 6} (true);
call SafeMath_SafeMath_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

procedure {:inline 1} mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1884: int, b_s1884: int) returns (__ret_0_: int);
implementation mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1884: int, b_s1884: int) returns (__ret_0_: int)
{
var c_s1883: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1884);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1884);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 8} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 9} (true);
assume ((a_s1884) >= (0));
if ((a_s1884) == (0)) {
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 9} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 10} (true);
__ret_0_ := 0;
return;
}
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 12} (true);
assume ((c_s1883) >= (0));
assume ((a_s1884) >= (0));
assume ((b_s1884) >= (0));
assume (((a_s1884) * (b_s1884)) >= (0));
c_s1883 := (a_s1884) * (b_s1884);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1883);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 13} (true);
assume ((c_s1883) >= (0));
assume ((a_s1884) >= (0));
assume ((((c_s1883) div (a_s1884))) >= (0));
assume ((b_s1884) >= (0));
assume ((((c_s1883) div (a_s1884))) == (b_s1884));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 14} (true);
assume ((c_s1883) >= (0));
__ret_0_ := c_s1883;
return;
}

procedure {:inline 1} div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1908: int, b_s1908: int) returns (__ret_0_: int);
implementation div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1908: int, b_s1908: int) returns (__ret_0_: int)
{
var c_s1907: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1908);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1908);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 18} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 19} (true);
assume ((b_s1908) >= (0));
assume ((b_s1908) > (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 20} (true);
assume ((c_s1907) >= (0));
assume ((a_s1908) >= (0));
assume ((b_s1908) >= (0));
assume (((a_s1908) div (b_s1908)) >= (0));
c_s1907 := (a_s1908) div (b_s1908);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1907);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 21} (true);
assume ((c_s1907) >= (0));
__ret_0_ := c_s1907;
return;
}

procedure {:inline 1} sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1932: int, b_s1932: int) returns (__ret_0_: int);
implementation sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1932: int, b_s1932: int) returns (__ret_0_: int)
{
var c_s1931: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1932);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1932);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 25} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 26} (true);
assume ((b_s1932) >= (0));
assume ((a_s1932) >= (0));
assume ((b_s1932) <= (a_s1932));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 27} (true);
assume ((c_s1931) >= (0));
assume ((a_s1932) >= (0));
assume ((b_s1932) >= (0));
assume (((a_s1932) - (b_s1932)) >= (0));
c_s1931 := (a_s1932) - (b_s1932);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1931);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 28} (true);
assume ((c_s1931) >= (0));
__ret_0_ := c_s1931;
return;
}

procedure {:inline 1} add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1956: int, b_s1956: int) returns (__ret_0_: int);
implementation add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1956: int, b_s1956: int) returns (__ret_0_: int)
{
var c_s1955: int;
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1956);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1956);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 32} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 33} (true);
assume ((c_s1955) >= (0));
assume ((a_s1956) >= (0));
assume ((b_s1956) >= (0));
assume (((a_s1956) + (b_s1956)) >= (0));
c_s1955 := (a_s1956) + (b_s1956);
call  {:cexpr "c"} boogie_si_record_sol2Bpl_int(c_s1955);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 34} (true);
assume ((c_s1955) >= (0));
assume ((a_s1956) >= (0));
assume ((c_s1955) >= (a_s1956));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 35} (true);
assume ((c_s1955) >= (0));
__ret_0_ := c_s1955;
return;
}

procedure {:inline 1} mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1976: int, b_s1976: int) returns (__ret_0_: int);
implementation mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s1976: int, b_s1976: int) returns (__ret_0_: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "a"} boogie_si_record_sol2Bpl_int(a_s1976);
call  {:cexpr "b"} boogie_si_record_sol2Bpl_int(b_s1976);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 40} (true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 41} (true);
assume ((b_s1976) >= (0));
assume ((b_s1976) != (0));
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/SafeMath.sol"} {:sourceLine 42} (true);
assume ((a_s1976) >= (0));
assume ((b_s1976) >= (0));
assume (((a_s1976) mod (b_s1976)) >= (0));
__ret_0_ := (a_s1976) mod (b_s1976);
return;
}

procedure {:inline 1} strings_strings_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation strings_strings_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
// start of initialization
assume ((msgsender_MSG) != (null));
Balance[this] := 0;
// end of initialization
}

procedure {:inline 1} strings_strings(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
implementation strings_strings(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
call  {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
call  {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
call  {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
call  {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
call  {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
assert {:first} {:sourceFile "/home/liuye/Projects/verisol-houdini/verisol_test/0x76e422de0ce8842ebe837bc7ab6984b4fff88055.etherscan.io-EXODUS2/verisol/strings.sol"} {:sourceLine 4} (true);
call strings_strings_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
}

var _len_strings.slice: [Ref]int;
var _ptr_strings.slice: [Ref]int;
procedure {:inline 1} memcpy_strings(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, dest_s338: int, src_s338: int, len_s338: int);
procedure {:inline 1} toSlice_strings(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, self_s358: int) returns (__ret_0_: Ref);
procedure {:inline 1} concat_strings(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, self_s404: Ref, other_s404: Ref) returns (__ret_0_: int);
procedure {:inline 1} FallbackDispatch(from: Ref, to: Ref, amount: int);
implementation FallbackDispatch(from: Ref, to: Ref, amount: int)
{
if ((DType[to]) == (IERC721Receiver)) {
assume ((amount) == (0));
} else if ((DType[to]) == (IERC721Metadata)) {
assume ((amount) == (0));
} else if ((DType[to]) == (IERC721Enumerable)) {
assume ((amount) == (0));
} else if ((DType[to]) == (IERC721)) {
assume ((amount) == (0));
} else if ((DType[to]) == (IERC165)) {
assume ((amount) == (0));
} else if ((DType[to]) == (EXODUS2)) {
assume ((amount) == (0));
} else if ((DType[to]) == (ERC721Metadata)) {
assume ((amount) == (0));
} else if ((DType[to]) == (ERC721Full)) {
assume ((amount) == (0));
} else if ((DType[to]) == (ERC721Enumerable)) {
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
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
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
var interfaceId_s1707: int;
var __ret_0_supportsInterface: bool;
var tmpNow: int;
assume ((now) >= (0));
assume (((((((DType[this]) == (ERC165)) || ((DType[this]) == (ERC721))) || ((DType[this]) == (ERC721Enumerable))) || ((DType[this]) == (ERC721Full))) || ((DType[this]) == (ERC721Metadata))) || ((DType[this]) == (EXODUS2)));
call ERC165_ERC165(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s1707;
havoc __ret_0_supportsInterface;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s1707);
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
var interfaceId_s1707: int;
var __ret_0_supportsInterface: bool;
var owner_s475: Ref;
var __ret_0_balanceOf: int;
var tokenId_s499: int;
var __ret_0_ownerOf: Ref;
var to_s667: Ref;
var tokenId_s667: int;
var tokenId_s685: int;
var __ret_0_getApproved: Ref;
var to_s781: Ref;
var approved_s781: bool;
var owner_s797: Ref;
var operator_s797: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s868: Ref;
var to_s868: Ref;
var tokenId_s868: int;
var from_s887: Ref;
var to_s887: Ref;
var tokenId_s887: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var from_s914: Ref;
var to_s914: Ref;
var tokenId_s914: int;
var _data_s914: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((((((DType[this]) == (ERC721)) || ((DType[this]) == (ERC721Enumerable))) || ((DType[this]) == (ERC721Full))) || ((DType[this]) == (ERC721Metadata))) || ((DType[this]) == (EXODUS2)));
call ERC721_ERC721(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s1707;
havoc __ret_0_supportsInterface;
havoc owner_s475;
havoc __ret_0_balanceOf;
havoc tokenId_s499;
havoc __ret_0_ownerOf;
havoc to_s667;
havoc tokenId_s667;
havoc tokenId_s685;
havoc __ret_0_getApproved;
havoc to_s781;
havoc approved_s781;
havoc owner_s797;
havoc operator_s797;
havoc __ret_0_isApprovedForAll;
havoc from_s868;
havoc to_s868;
havoc tokenId_s868;
havoc from_s887;
havoc to_s887;
havoc tokenId_s887;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc from_s914;
havoc to_s914;
havoc tokenId_s914;
havoc _data_s914;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (11)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s1707);
} else if ((choice) == (10)) {
call __ret_0_balanceOf := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s475);
} else if ((choice) == (9)) {
call __ret_0_ownerOf := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s499);
} else if ((choice) == (8)) {
call approve_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s667, tokenId_s667);
} else if ((choice) == (7)) {
call __ret_0_getApproved := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((choice) == (6)) {
call setApprovalForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s781, approved_s781);
} else if ((choice) == (5)) {
call __ret_0_isApprovedForAll := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s797, operator_s797);
} else if ((choice) == (4)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((choice) == (3)) {
call safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s887, to_s887, tokenId_s887);
} else if ((choice) == (2)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
} else if ((choice) == (1)) {
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
}
}
}

procedure BoogieEntry_ERC721Enumerable();
implementation BoogieEntry_ERC721Enumerable()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s1707: int;
var __ret_0_supportsInterface: bool;
var owner_s475: Ref;
var __ret_0_balanceOf: int;
var tokenId_s499: int;
var __ret_0_ownerOf: Ref;
var to_s667: Ref;
var tokenId_s667: int;
var tokenId_s685: int;
var __ret_0_getApproved: Ref;
var to_s781: Ref;
var approved_s781: bool;
var owner_s797: Ref;
var operator_s797: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s868: Ref;
var to_s868: Ref;
var tokenId_s868: int;
var from_s887: Ref;
var to_s887: Ref;
var tokenId_s887: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var from_s914: Ref;
var to_s914: Ref;
var tokenId_s914: int;
var _data_s914: int;
var __ret_0_totalSupply: int;
var owner_s1268: Ref;
var index_s1268: int;
var __ret_0_tokenOfOwnerByIndex: int;
var index_s1296: int;
var __ret_0_tokenByIndex: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((((DType[this]) == (ERC721Enumerable)) || ((DType[this]) == (ERC721Full))) || ((DType[this]) == (EXODUS2)));
call ERC721Enumerable_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s1707;
havoc __ret_0_supportsInterface;
havoc owner_s475;
havoc __ret_0_balanceOf;
havoc tokenId_s499;
havoc __ret_0_ownerOf;
havoc to_s667;
havoc tokenId_s667;
havoc tokenId_s685;
havoc __ret_0_getApproved;
havoc to_s781;
havoc approved_s781;
havoc owner_s797;
havoc operator_s797;
havoc __ret_0_isApprovedForAll;
havoc from_s868;
havoc to_s868;
havoc tokenId_s868;
havoc from_s887;
havoc to_s887;
havoc tokenId_s887;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc from_s914;
havoc to_s914;
havoc tokenId_s914;
havoc _data_s914;
havoc __ret_0_totalSupply;
havoc owner_s1268;
havoc index_s1268;
havoc __ret_0_tokenOfOwnerByIndex;
havoc index_s1296;
havoc __ret_0_tokenByIndex;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (14)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s1707);
} else if ((choice) == (13)) {
call __ret_0_balanceOf := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s475);
} else if ((choice) == (12)) {
call __ret_0_ownerOf := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s499);
} else if ((choice) == (11)) {
call approve_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s667, tokenId_s667);
} else if ((choice) == (10)) {
call __ret_0_getApproved := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((choice) == (9)) {
call setApprovalForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s781, approved_s781);
} else if ((choice) == (8)) {
call __ret_0_isApprovedForAll := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s797, operator_s797);
} else if ((choice) == (7)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((choice) == (6)) {
call safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s887, to_s887, tokenId_s887);
} else if ((choice) == (5)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
} else if ((choice) == (4)) {
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((choice) == (3)) {
call __ret_0_totalSupply := totalSupply_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (2)) {
call __ret_0_tokenOfOwnerByIndex := tokenOfOwnerByIndex_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, owner_s1268, index_s1268);
} else if ((choice) == (1)) {
call __ret_0_tokenByIndex := tokenByIndex_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, index_s1296);
}
}
}

procedure BoogieEntry_ERC721Full();
implementation BoogieEntry_ERC721Full()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s1707: int;
var __ret_0_supportsInterface: bool;
var owner_s475: Ref;
var __ret_0_balanceOf: int;
var tokenId_s499: int;
var __ret_0_ownerOf: Ref;
var to_s667: Ref;
var tokenId_s667: int;
var tokenId_s685: int;
var __ret_0_getApproved: Ref;
var to_s781: Ref;
var approved_s781: bool;
var owner_s797: Ref;
var operator_s797: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s868: Ref;
var to_s868: Ref;
var tokenId_s868: int;
var from_s887: Ref;
var to_s887: Ref;
var tokenId_s887: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var from_s914: Ref;
var to_s914: Ref;
var tokenId_s914: int;
var _data_s914: int;
var __ret_0_totalSupply: int;
var owner_s1268: Ref;
var index_s1268: int;
var __ret_0_tokenOfOwnerByIndex: int;
var index_s1296: int;
var __ret_0_tokenByIndex: int;
var __ret_0_name: int;
var __ret_0_symbol: int;
var tokenId_s1618: int;
var __ret_0_tokenURI: int;
var name_s1584: int;
var symbol_s1584: int;
var name_s93: int;
var symbol_s93: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((DType[this]) == (ERC721Full)) || ((DType[this]) == (EXODUS2)));
call ERC721Full_ERC721Full(this, msgsender_MSG, msgvalue_MSG, name_s93, symbol_s93);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s1707;
havoc __ret_0_supportsInterface;
havoc owner_s475;
havoc __ret_0_balanceOf;
havoc tokenId_s499;
havoc __ret_0_ownerOf;
havoc to_s667;
havoc tokenId_s667;
havoc tokenId_s685;
havoc __ret_0_getApproved;
havoc to_s781;
havoc approved_s781;
havoc owner_s797;
havoc operator_s797;
havoc __ret_0_isApprovedForAll;
havoc from_s868;
havoc to_s868;
havoc tokenId_s868;
havoc from_s887;
havoc to_s887;
havoc tokenId_s887;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc from_s914;
havoc to_s914;
havoc tokenId_s914;
havoc _data_s914;
havoc __ret_0_totalSupply;
havoc owner_s1268;
havoc index_s1268;
havoc __ret_0_tokenOfOwnerByIndex;
havoc index_s1296;
havoc __ret_0_tokenByIndex;
havoc __ret_0_name;
havoc __ret_0_symbol;
havoc tokenId_s1618;
havoc __ret_0_tokenURI;
havoc name_s1584;
havoc symbol_s1584;
havoc name_s93;
havoc symbol_s93;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (17)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s1707);
} else if ((choice) == (16)) {
call __ret_0_balanceOf := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s475);
} else if ((choice) == (15)) {
call __ret_0_ownerOf := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s499);
} else if ((choice) == (14)) {
call approve_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s667, tokenId_s667);
} else if ((choice) == (13)) {
call __ret_0_getApproved := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((choice) == (12)) {
call setApprovalForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s781, approved_s781);
} else if ((choice) == (11)) {
call __ret_0_isApprovedForAll := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s797, operator_s797);
} else if ((choice) == (10)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((choice) == (9)) {
call safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s887, to_s887, tokenId_s887);
} else if ((choice) == (8)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
} else if ((choice) == (7)) {
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((choice) == (6)) {
call __ret_0_totalSupply := totalSupply_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (5)) {
call __ret_0_tokenOfOwnerByIndex := tokenOfOwnerByIndex_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, owner_s1268, index_s1268);
} else if ((choice) == (4)) {
call __ret_0_tokenByIndex := tokenByIndex_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, index_s1296);
} else if ((choice) == (3)) {
call __ret_0_name := name_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (2)) {
call __ret_0_symbol := symbol_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (1)) {
call __ret_0_tokenURI := tokenURI_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, tokenId_s1618);
}
}
}

const {:existential true} HoudiniB1_ERC721Metadata: bool;
const {:existential true} HoudiniB2_ERC721Metadata: bool;
const {:existential true} HoudiniB3_ERC721Metadata: bool;
const {:existential true} HoudiniB4_ERC721Metadata: bool;
procedure BoogieEntry_ERC721Metadata();
implementation BoogieEntry_ERC721Metadata()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s1707: int;
var __ret_0_supportsInterface: bool;
var owner_s475: Ref;
var __ret_0_balanceOf: int;
var tokenId_s499: int;
var __ret_0_ownerOf: Ref;
var to_s667: Ref;
var tokenId_s667: int;
var tokenId_s685: int;
var __ret_0_getApproved: Ref;
var to_s781: Ref;
var approved_s781: bool;
var owner_s797: Ref;
var operator_s797: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s868: Ref;
var to_s868: Ref;
var tokenId_s868: int;
var from_s887: Ref;
var to_s887: Ref;
var tokenId_s887: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var from_s914: Ref;
var to_s914: Ref;
var tokenId_s914: int;
var _data_s914: int;
var __ret_0_name: int;
var __ret_0_symbol: int;
var tokenId_s1618: int;
var __ret_0_tokenURI: int;
var name_s1584: int;
var symbol_s1584: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((((DType[this]) == (ERC721Full)) || ((DType[this]) == (ERC721Metadata))) || ((DType[this]) == (EXODUS2)));
call ERC721Metadata_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, name_s1584, symbol_s1584);
while (true)
  invariant (HoudiniB1_ERC721Metadata) ==> ((_name_ERC721Metadata[this]) == (0));
  invariant (HoudiniB2_ERC721Metadata) ==> ((_name_ERC721Metadata[this]) != (0));
  invariant (HoudiniB3_ERC721Metadata) ==> ((_symbol_ERC721Metadata[this]) == (0));
  invariant (HoudiniB4_ERC721Metadata) ==> ((_symbol_ERC721Metadata[this]) != (0));
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s1707;
havoc __ret_0_supportsInterface;
havoc owner_s475;
havoc __ret_0_balanceOf;
havoc tokenId_s499;
havoc __ret_0_ownerOf;
havoc to_s667;
havoc tokenId_s667;
havoc tokenId_s685;
havoc __ret_0_getApproved;
havoc to_s781;
havoc approved_s781;
havoc owner_s797;
havoc operator_s797;
havoc __ret_0_isApprovedForAll;
havoc from_s868;
havoc to_s868;
havoc tokenId_s868;
havoc from_s887;
havoc to_s887;
havoc tokenId_s887;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc from_s914;
havoc to_s914;
havoc tokenId_s914;
havoc _data_s914;
havoc __ret_0_name;
havoc __ret_0_symbol;
havoc tokenId_s1618;
havoc __ret_0_tokenURI;
havoc name_s1584;
havoc symbol_s1584;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (14)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s1707);
} else if ((choice) == (13)) {
call __ret_0_balanceOf := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s475);
} else if ((choice) == (12)) {
call __ret_0_ownerOf := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s499);
} else if ((choice) == (11)) {
call approve_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s667, tokenId_s667);
} else if ((choice) == (10)) {
call __ret_0_getApproved := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((choice) == (9)) {
call setApprovalForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s781, approved_s781);
} else if ((choice) == (8)) {
call __ret_0_isApprovedForAll := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s797, operator_s797);
} else if ((choice) == (7)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((choice) == (6)) {
call safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s887, to_s887, tokenId_s887);
} else if ((choice) == (5)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
} else if ((choice) == (4)) {
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((choice) == (3)) {
call __ret_0_name := name_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (2)) {
call __ret_0_symbol := symbol_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (1)) {
call __ret_0_tokenURI := tokenURI_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, tokenId_s1618);
}
}
}

procedure BoogieEntry_EXODUS2();
implementation BoogieEntry_EXODUS2()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s1707: int;
var __ret_0_supportsInterface: bool;
var owner_s475: Ref;
var __ret_0_balanceOf: int;
var tokenId_s499: int;
var __ret_0_ownerOf: Ref;
var to_s667: Ref;
var tokenId_s667: int;
var tokenId_s685: int;
var __ret_0_getApproved: Ref;
var to_s781: Ref;
var approved_s781: bool;
var owner_s797: Ref;
var operator_s797: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s868: Ref;
var to_s868: Ref;
var tokenId_s868: int;
var from_s887: Ref;
var to_s887: Ref;
var tokenId_s887: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var from_s914: Ref;
var to_s914: Ref;
var tokenId_s914: int;
var _data_s914: int;
var __ret_0_totalSupply: int;
var owner_s1268: Ref;
var index_s1268: int;
var __ret_0_tokenOfOwnerByIndex: int;
var index_s1296: int;
var __ret_0_tokenByIndex: int;
var __ret_0_name: int;
var __ret_0_symbol: int;
var tokenId_s1618: int;
var __ret_0_tokenURI: int;
var name_s1584: int;
var symbol_s1584: int;
var name_s93: int;
var symbol_s93: int;
var pangram_s64: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (EXODUS2));
call EXODUS2_EXODUS2(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s1707;
havoc __ret_0_supportsInterface;
havoc owner_s475;
havoc __ret_0_balanceOf;
havoc tokenId_s499;
havoc __ret_0_ownerOf;
havoc to_s667;
havoc tokenId_s667;
havoc tokenId_s685;
havoc __ret_0_getApproved;
havoc to_s781;
havoc approved_s781;
havoc owner_s797;
havoc operator_s797;
havoc __ret_0_isApprovedForAll;
havoc from_s868;
havoc to_s868;
havoc tokenId_s868;
havoc from_s887;
havoc to_s887;
havoc tokenId_s887;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc from_s914;
havoc to_s914;
havoc tokenId_s914;
havoc _data_s914;
havoc __ret_0_totalSupply;
havoc owner_s1268;
havoc index_s1268;
havoc __ret_0_tokenOfOwnerByIndex;
havoc index_s1296;
havoc __ret_0_tokenByIndex;
havoc __ret_0_name;
havoc __ret_0_symbol;
havoc tokenId_s1618;
havoc __ret_0_tokenURI;
havoc name_s1584;
havoc symbol_s1584;
havoc name_s93;
havoc symbol_s93;
havoc pangram_s64;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (18)) {
call __ret_0_supportsInterface := supportsInterface_ERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s1707);
} else if ((choice) == (17)) {
call __ret_0_balanceOf := balanceOf_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s475);
} else if ((choice) == (16)) {
call __ret_0_ownerOf := ownerOf_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s499);
} else if ((choice) == (15)) {
call approve_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s667, tokenId_s667);
} else if ((choice) == (14)) {
call __ret_0_getApproved := getApproved_ERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s685);
} else if ((choice) == (13)) {
call setApprovalForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, to_s781, approved_s781);
} else if ((choice) == (12)) {
call __ret_0_isApprovedForAll := isApprovedForAll_ERC721(this, msgsender_MSG, msgvalue_MSG, owner_s797, operator_s797);
} else if ((choice) == (11)) {
call transferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s868, to_s868, tokenId_s868);
} else if ((choice) == (10)) {
call safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s887, to_s887, tokenId_s887);
} else if ((choice) == (9)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
} else if ((choice) == (8)) {
call _safeTransferFrom_ERC721(this, msgsender_MSG, msgvalue_MSG, from_s914, to_s914, tokenId_s914, _data_s914);
} else if ((choice) == (7)) {
call __ret_0_totalSupply := totalSupply_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (6)) {
call __ret_0_tokenOfOwnerByIndex := tokenOfOwnerByIndex_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, owner_s1268, index_s1268);
} else if ((choice) == (5)) {
call __ret_0_tokenByIndex := tokenByIndex_ERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, index_s1296);
} else if ((choice) == (4)) {
call __ret_0_name := name_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (3)) {
call __ret_0_symbol := symbol_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (2)) {
call __ret_0_tokenURI := tokenURI_ERC721Metadata(this, msgsender_MSG, msgvalue_MSG, tokenId_s1618);
} else if ((choice) == (1)) {
call deploy_EXODUS2(this, msgsender_MSG, msgvalue_MSG, pangram_s64);
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
assume (((((((((((DType[this]) == (ERC165)) || ((DType[this]) == (ERC721))) || ((DType[this]) == (ERC721Enumerable))) || ((DType[this]) == (ERC721Full))) || ((DType[this]) == (ERC721Metadata))) || ((DType[this]) == (EXODUS2))) || ((DType[this]) == (IERC165))) || ((DType[this]) == (IERC721))) || ((DType[this]) == (IERC721Enumerable))) || ((DType[this]) == (IERC721Metadata)));
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
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
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
var interfaceId_s2039: int;
var __ret_0_supportsInterface: bool;
var owner_s1763: Ref;
var balance_s1763: int;
var tokenId_s1770: int;
var owner_s1770: Ref;
var to_s1777: Ref;
var tokenId_s1777: int;
var tokenId_s1784: int;
var operator_s1784: Ref;
var operator_s1791: Ref;
var _approved_s1791: bool;
var owner_s1800: Ref;
var operator_s1800: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s1809: Ref;
var to_s1809: Ref;
var tokenId_s1809: int;
var from_s1818: Ref;
var to_s1818: Ref;
var tokenId_s1818: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((((((((DType[this]) == (ERC721)) || ((DType[this]) == (ERC721Enumerable))) || ((DType[this]) == (ERC721Full))) || ((DType[this]) == (ERC721Metadata))) || ((DType[this]) == (EXODUS2))) || ((DType[this]) == (IERC721))) || ((DType[this]) == (IERC721Enumerable))) || ((DType[this]) == (IERC721Metadata)));
call IERC721_IERC721(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s2039;
havoc __ret_0_supportsInterface;
havoc owner_s1763;
havoc balance_s1763;
havoc tokenId_s1770;
havoc owner_s1770;
havoc to_s1777;
havoc tokenId_s1777;
havoc tokenId_s1784;
havoc operator_s1784;
havoc operator_s1791;
havoc _approved_s1791;
havoc owner_s1800;
havoc operator_s1800;
havoc __ret_0_isApprovedForAll;
havoc from_s1809;
havoc to_s1809;
havoc tokenId_s1809;
havoc from_s1818;
havoc to_s1818;
havoc tokenId_s1818;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (10)) {
call __ret_0_supportsInterface := supportsInterface_IERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s2039);
} else if ((choice) == (9)) {
call balance_s1763 := balanceOf_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1763);
} else if ((choice) == (8)) {
call owner_s1770 := ownerOf_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1770);
} else if ((choice) == (7)) {
call approve_IERC721(this, msgsender_MSG, msgvalue_MSG, to_s1777, tokenId_s1777);
} else if ((choice) == (6)) {
call operator_s1784 := getApproved_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1784);
} else if ((choice) == (5)) {
call setApprovalForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, operator_s1791, _approved_s1791);
} else if ((choice) == (4)) {
call __ret_0_isApprovedForAll := isApprovedForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1800, operator_s1800);
} else if ((choice) == (3)) {
call transferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1809, to_s1809, tokenId_s1809);
} else if ((choice) == (2)) {
call safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1818, to_s1818, tokenId_s1818);
} else if ((choice) == (1)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
}
}
}

procedure BoogieEntry_IERC721Enumerable();
implementation BoogieEntry_IERC721Enumerable()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s2039: int;
var __ret_0_supportsInterface: bool;
var owner_s1763: Ref;
var balance_s1763: int;
var tokenId_s1770: int;
var owner_s1770: Ref;
var to_s1777: Ref;
var tokenId_s1777: int;
var tokenId_s1784: int;
var operator_s1784: Ref;
var operator_s1791: Ref;
var _approved_s1791: bool;
var owner_s1800: Ref;
var operator_s1800: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s1809: Ref;
var to_s1809: Ref;
var tokenId_s1809: int;
var from_s1818: Ref;
var to_s1818: Ref;
var tokenId_s1818: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var __ret_0_totalSupply: int;
var owner_s1997: Ref;
var index_s1997: int;
var tokenId_s1997: int;
var index_s2004: int;
var __ret_0_tokenByIndex: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((((DType[this]) == (ERC721Enumerable)) || ((DType[this]) == (ERC721Full))) || ((DType[this]) == (EXODUS2))) || ((DType[this]) == (IERC721Enumerable)));
call IERC721Enumerable_IERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s2039;
havoc __ret_0_supportsInterface;
havoc owner_s1763;
havoc balance_s1763;
havoc tokenId_s1770;
havoc owner_s1770;
havoc to_s1777;
havoc tokenId_s1777;
havoc tokenId_s1784;
havoc operator_s1784;
havoc operator_s1791;
havoc _approved_s1791;
havoc owner_s1800;
havoc operator_s1800;
havoc __ret_0_isApprovedForAll;
havoc from_s1809;
havoc to_s1809;
havoc tokenId_s1809;
havoc from_s1818;
havoc to_s1818;
havoc tokenId_s1818;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc __ret_0_totalSupply;
havoc owner_s1997;
havoc index_s1997;
havoc tokenId_s1997;
havoc index_s2004;
havoc __ret_0_tokenByIndex;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (13)) {
call __ret_0_supportsInterface := supportsInterface_IERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s2039);
} else if ((choice) == (12)) {
call balance_s1763 := balanceOf_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1763);
} else if ((choice) == (11)) {
call owner_s1770 := ownerOf_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1770);
} else if ((choice) == (10)) {
call approve_IERC721(this, msgsender_MSG, msgvalue_MSG, to_s1777, tokenId_s1777);
} else if ((choice) == (9)) {
call operator_s1784 := getApproved_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1784);
} else if ((choice) == (8)) {
call setApprovalForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, operator_s1791, _approved_s1791);
} else if ((choice) == (7)) {
call __ret_0_isApprovedForAll := isApprovedForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1800, operator_s1800);
} else if ((choice) == (6)) {
call transferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1809, to_s1809, tokenId_s1809);
} else if ((choice) == (5)) {
call safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1818, to_s1818, tokenId_s1818);
} else if ((choice) == (4)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
} else if ((choice) == (3)) {
call __ret_0_totalSupply := totalSupply_IERC721Enumerable(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (2)) {
call tokenId_s1997 := tokenOfOwnerByIndex_IERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, owner_s1997, index_s1997);
} else if ((choice) == (1)) {
call __ret_0_tokenByIndex := tokenByIndex_IERC721Enumerable(this, msgsender_MSG, msgvalue_MSG, index_s2004);
}
}
}

procedure BoogieEntry_IERC721Metadata();
implementation BoogieEntry_IERC721Metadata()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var interfaceId_s2039: int;
var __ret_0_supportsInterface: bool;
var owner_s1763: Ref;
var balance_s1763: int;
var tokenId_s1770: int;
var owner_s1770: Ref;
var to_s1777: Ref;
var tokenId_s1777: int;
var tokenId_s1784: int;
var operator_s1784: Ref;
var operator_s1791: Ref;
var _approved_s1791: bool;
var owner_s1800: Ref;
var operator_s1800: Ref;
var __ret_0_isApprovedForAll: bool;
var from_s1809: Ref;
var to_s1809: Ref;
var tokenId_s1809: int;
var from_s1818: Ref;
var to_s1818: Ref;
var tokenId_s1818: int;
var from_s1829: Ref;
var to_s1829: Ref;
var tokenId_s1829: int;
var data_s1829: int;
var __ret_0_name: int;
var __ret_0_symbol: int;
var tokenId_s2028: int;
var __ret_0_tokenURI: int;
var tmpNow: int;
assume ((now) >= (0));
assume (((((DType[this]) == (ERC721Full)) || ((DType[this]) == (ERC721Metadata))) || ((DType[this]) == (EXODUS2))) || ((DType[this]) == (IERC721Metadata)));
call IERC721Metadata_IERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
while (true)
{
havoc msgsender_MSG;
havoc msgvalue_MSG;
havoc choice;
havoc interfaceId_s2039;
havoc __ret_0_supportsInterface;
havoc owner_s1763;
havoc balance_s1763;
havoc tokenId_s1770;
havoc owner_s1770;
havoc to_s1777;
havoc tokenId_s1777;
havoc tokenId_s1784;
havoc operator_s1784;
havoc operator_s1791;
havoc _approved_s1791;
havoc owner_s1800;
havoc operator_s1800;
havoc __ret_0_isApprovedForAll;
havoc from_s1809;
havoc to_s1809;
havoc tokenId_s1809;
havoc from_s1818;
havoc to_s1818;
havoc tokenId_s1818;
havoc from_s1829;
havoc to_s1829;
havoc tokenId_s1829;
havoc data_s1829;
havoc __ret_0_name;
havoc __ret_0_symbol;
havoc tokenId_s2028;
havoc __ret_0_tokenURI;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (13)) {
call __ret_0_supportsInterface := supportsInterface_IERC165(this, msgsender_MSG, msgvalue_MSG, interfaceId_s2039);
} else if ((choice) == (12)) {
call balance_s1763 := balanceOf_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1763);
} else if ((choice) == (11)) {
call owner_s1770 := ownerOf_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1770);
} else if ((choice) == (10)) {
call approve_IERC721(this, msgsender_MSG, msgvalue_MSG, to_s1777, tokenId_s1777);
} else if ((choice) == (9)) {
call operator_s1784 := getApproved_IERC721(this, msgsender_MSG, msgvalue_MSG, tokenId_s1784);
} else if ((choice) == (8)) {
call setApprovalForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, operator_s1791, _approved_s1791);
} else if ((choice) == (7)) {
call __ret_0_isApprovedForAll := isApprovedForAll_IERC721(this, msgsender_MSG, msgvalue_MSG, owner_s1800, operator_s1800);
} else if ((choice) == (6)) {
call transferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1809, to_s1809, tokenId_s1809);
} else if ((choice) == (5)) {
call safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1818, to_s1818, tokenId_s1818);
} else if ((choice) == (4)) {
call _safeTransferFrom_IERC721(this, msgsender_MSG, msgvalue_MSG, from_s1829, to_s1829, tokenId_s1829, data_s1829);
} else if ((choice) == (3)) {
call __ret_0_name := name_IERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (2)) {
call __ret_0_symbol := symbol_IERC721Metadata(this, msgsender_MSG, msgvalue_MSG);
} else if ((choice) == (1)) {
call __ret_0_tokenURI := tokenURI_IERC721Metadata(this, msgsender_MSG, msgvalue_MSG, tokenId_s2028);
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
var operator_s1846: Ref;
var from_s1846: Ref;
var tokenId_s1846: int;
var data_s1846: int;
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
havoc operator_s1846;
havoc from_s1846;
havoc tokenId_s1846;
havoc data_s1846;
havoc __ret_0_onERC721Received;
havoc tmpNow;
tmpNow := now;
havoc now;
assume ((now) > (tmpNow));
assume ((msgsender_MSG) != (null));
assume ((DType[msgsender_MSG]) != (Address));
assume ((DType[msgsender_MSG]) != (ERC165));
assume ((DType[msgsender_MSG]) != (ERC721));
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
if ((choice) == (1)) {
call __ret_0_onERC721Received := onERC721Received_IERC721Receiver(this, msgsender_MSG, msgvalue_MSG, operator_s1846, from_s1846, tokenId_s1846, data_s1846);
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
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
}
}

procedure BoogieEntry_strings();
implementation BoogieEntry_strings()
{
var this: Ref;
var msgsender_MSG: Ref;
var msgvalue_MSG: int;
var choice: int;
var tmpNow: int;
assume ((now) >= (0));
assume ((DType[this]) == (strings));
call strings_strings(this, msgsender_MSG, msgvalue_MSG);
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
assume ((DType[msgsender_MSG]) != (ERC721Enumerable));
assume ((DType[msgsender_MSG]) != (ERC721Full));
assume ((DType[msgsender_MSG]) != (ERC721Metadata));
assume ((DType[msgsender_MSG]) != (EXODUS2));
assume ((DType[msgsender_MSG]) != (IERC165));
assume ((DType[msgsender_MSG]) != (IERC721));
assume ((DType[msgsender_MSG]) != (IERC721Enumerable));
assume ((DType[msgsender_MSG]) != (IERC721Metadata));
assume ((DType[msgsender_MSG]) != (IERC721Receiver));
assume ((DType[msgsender_MSG]) != (SafeMath));
assume ((DType[msgsender_MSG]) != (VeriSol));
assume ((DType[msgsender_MSG]) != (strings));
Alloc[msgsender_MSG] := true;
}
}


