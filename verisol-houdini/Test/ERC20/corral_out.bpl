type Ref;

type ContractName;

const unique null: Ref;

const unique tokenRecipient: ContractName;

const unique TokenERC20: ContractName;

const unique VeriSol: ContractName;

function ConstantToRef(x: int) : Ref;

function BoogieRefToInt(x: Ref) : int;

function {:bvbuiltin "mod"} modBpl(x: int, y: int) : int;

function keccak256(x: int) : int;

function abiEncodePacked1(x: int) : int;

function _SumMapping_VeriSol(x: [Ref]int) : int;

function abiEncodePacked2(x: int, y: int) : int;

function abiEncodePacked1R(x: Ref) : int;

function abiEncodePacked2R(x: Ref, y: int) : int;

var Balance: [Ref]int;

var DType: [Ref]ContractName;

var Alloc: [Ref]bool;

var balance_ADDR: [Ref]int;

var M_Ref_int: [Ref][Ref]int;

var M_Ref_Ref: [Ref][Ref]Ref;

var M_int_Ref: [Ref][int]Ref;

var Length: [Ref]int;

var now: int;

procedure FreshRefGenerator() returns (newRef: Ref);
  modifies Alloc;



implementation {:ForceInline} FreshRefGenerator() returns (newRef: Ref)
{

  anon0:
    havoc newRef;
    assume Alloc[newRef] <==> false;
    Alloc[newRef] := true;
    assume newRef != null;
    return;
}



procedure HavocAllocMany();
  modifies Alloc;



implementation {:ForceInline} HavocAllocMany()
{
  var oldAlloc: [Ref]bool;

  anon0:
    oldAlloc := Alloc;
    havoc Alloc;
    assume (forall __i__0_0: Ref :: oldAlloc[__i__0_0] ==> Alloc[__i__0_0]);
    return;
}



procedure boogie_si_record_sol2Bpl_int(x: int);



procedure boogie_si_record_sol2Bpl_ref(x: Ref);



procedure boogie_si_record_sol2Bpl_bool(x: bool);



axiom (forall __i__0_0: int, __i__0_1: int :: { ConstantToRef(__i__0_0), ConstantToRef(__i__0_1) } __i__0_0 == __i__0_1 || ConstantToRef(__i__0_0) != ConstantToRef(__i__0_1));

axiom (forall __i__0_0: int, __i__0_1: int :: { keccak256(__i__0_0), keccak256(__i__0_1) } __i__0_0 == __i__0_1 || keccak256(__i__0_0) != keccak256(__i__0_1));

axiom (forall __i__0_0: int, __i__0_1: int :: { abiEncodePacked1(__i__0_0), abiEncodePacked1(__i__0_1) } __i__0_0 == __i__0_1 || abiEncodePacked1(__i__0_0) != abiEncodePacked1(__i__0_1));

axiom (forall __i__0_0: [Ref]int :: (exists __i__0_1: Ref :: __i__0_0[__i__0_1] != 0) || _SumMapping_VeriSol(__i__0_0) == 0);

axiom (forall __i__0_0: [Ref]int, __i__0_1: Ref, __i__0_2: int :: _SumMapping_VeriSol(__i__0_0[__i__0_1 := __i__0_2]) == _SumMapping_VeriSol(__i__0_0) - __i__0_0[__i__0_1] + __i__0_2);

axiom (forall __i__0_0: int, __i__0_1: int, __i__1_0: int, __i__1_1: int :: { abiEncodePacked2(__i__0_0, __i__1_0), abiEncodePacked2(__i__0_1, __i__1_1) } (__i__0_0 == __i__0_1 && __i__1_0 == __i__1_1) || abiEncodePacked2(__i__0_0, __i__1_0) != abiEncodePacked2(__i__0_1, __i__1_1));

axiom (forall __i__0_0: Ref, __i__0_1: Ref :: { abiEncodePacked1R(__i__0_0), abiEncodePacked1R(__i__0_1) } __i__0_0 == __i__0_1 || abiEncodePacked1R(__i__0_0) != abiEncodePacked1R(__i__0_1));

axiom (forall __i__0_0: Ref, __i__0_1: Ref, __i__1_0: int, __i__1_1: int :: { abiEncodePacked2R(__i__0_0, __i__1_0), abiEncodePacked2R(__i__0_1, __i__1_1) } (__i__0_0 == __i__0_1 && __i__1_0 == __i__1_1) || abiEncodePacked2R(__i__0_0, __i__1_0) != abiEncodePacked2R(__i__0_1, __i__1_1));

procedure tokenRecipient_tokenRecipient_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure tokenRecipient_tokenRecipient(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure {:public} receiveApproval_tokenRecipient(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s13: Ref, _value_s13: int, _token_s13: Ref, _extraData_s13: int);



var name_TokenERC20: [Ref]int;

var symbol_TokenERC20: [Ref]int;

var decimals_TokenERC20: [Ref]int;

var totalSupply_TokenERC20: [Ref]int;

var balanceOf_TokenERC20: [Ref]Ref;

var allowance_TokenERC20: [Ref]Ref;

procedure TokenERC20_TokenERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int);
  modifies Balance, name_TokenERC20, symbol_TokenERC20, decimals_TokenERC20, totalSupply_TokenERC20, Alloc, balanceOf_TokenERC20, allowance_TokenERC20, M_Ref_int;



implementation {:ForceInline} TokenERC20_TokenERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int)
{
  var __var_1: int;
  var __var_2: Ref;
  var __var_3: Ref;

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    name_TokenERC20[this] := -412035031;
    symbol_TokenERC20[this] := -412035031;
    decimals_TokenERC20[this] := 18;
    totalSupply_TokenERC20[this] := 0;
    call {:si_unique_call 0} __var_2 := FreshRefGenerator();
    balanceOf_TokenERC20[this] := __var_2;
    assume (forall __i__0_0: Ref :: M_Ref_int[balanceOf_TokenERC20[this]][__i__0_0] == 0);
    call {:si_unique_call 1} __var_3 := FreshRefGenerator();
    allowance_TokenERC20[this] := __var_3;
    assume (forall __i__0_0: Ref :: Length[M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0]] == 0);
    assume (forall __i__0_0: Ref :: !Alloc[M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0]]);
    call {:si_unique_call 2} HavocAllocMany();
    assume (forall __i__0_0: Ref :: Alloc[M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0]]);
    assume (forall __i__0_0: Ref, __i__0_1: Ref :: { M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0], M_Ref_Ref[allowance_TokenERC20[this]][__i__0_1] } __i__0_0 == __i__0_1 || M_Ref_Ref[allowance_TokenERC20[this]][__i__0_0] != M_Ref_Ref[allowance_TokenERC20[this]][__i__0_1]);
    call {:si_unique_call 3} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 4} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 5} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 6} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 7} {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s83);
    call {:si_unique_call 8} {:cexpr "tokenName"} boogie_si_record_sol2Bpl_int(tokenName_s83);
    call {:si_unique_call 9} {:cexpr "tokenSymbol"} boogie_si_record_sol2Bpl_int(tokenSymbol_s83);
    call {:si_unique_call 10} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_1;

  corral_source_split_1:
    goto corral_source_split_2;

  corral_source_split_2:
    assume totalSupply_TokenERC20[this] >= 0;
    assume initialSupply_s83 >= 0;
    assume __var_1 >= 0;
    assume decimals_TokenERC20[this] >= 0;
    __var_1 := decimals_TokenERC20[this];
    assume decimals_TokenERC20[this] >= 0;
    assume decimals_TokenERC20[this] >= 0;
    assume initialSupply_s83 * decimals_TokenERC20[this] >= 0;
    totalSupply_TokenERC20[this] := initialSupply_s83 * decimals_TokenERC20[this];
    call {:si_unique_call 11} {:cexpr "totalSupply"} boogie_si_record_sol2Bpl_int(totalSupply_TokenERC20[this]);
    goto corral_source_split_3;

  corral_source_split_3:
    assume M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] := totalSupply_TokenERC20[this];
    call {:si_unique_call 12} {:cexpr "balanceOf[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]);
    goto corral_source_split_4;

  corral_source_split_4:
    name_TokenERC20[this] := tokenName_s83;
    call {:si_unique_call 13} {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_TokenERC20[this]);
    goto corral_source_split_5;

  corral_source_split_5:
    symbol_TokenERC20[this] := tokenSymbol_s83;
    call {:si_unique_call 14} {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_TokenERC20[this]);
    return;
}



procedure {:constructor} {:public} TokenERC20_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int);
  modifies Balance, name_TokenERC20, symbol_TokenERC20, decimals_TokenERC20, totalSupply_TokenERC20, Alloc, balanceOf_TokenERC20, allowance_TokenERC20, M_Ref_int;



implementation {:ForceInline} TokenERC20_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, initialSupply_s83: int, tokenName_s83: int, tokenSymbol_s83: int)
{
  var __var_1: int;
  var __var_2: Ref;
  var __var_3: Ref;

  anon0:
    call {:si_unique_call 15} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 16} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 17} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 18} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 19} {:cexpr "initialSupply"} boogie_si_record_sol2Bpl_int(initialSupply_s83);
    call {:si_unique_call 20} {:cexpr "tokenName"} boogie_si_record_sol2Bpl_int(tokenName_s83);
    call {:si_unique_call 21} {:cexpr "tokenSymbol"} boogie_si_record_sol2Bpl_int(tokenSymbol_s83);
    call {:si_unique_call 22} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    call {:si_unique_call 23} TokenERC20_TokenERC20_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG, initialSupply_s83, tokenName_s83, tokenSymbol_s83);
    return;
}



procedure contractInvariant_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure _transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s178: Ref, _to_s178: Ref, _value_s178: int);
  modifies M_Ref_int;



implementation {:ForceInline} _transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s178: Ref, _to_s178: Ref, _value_s178: int)
{
  var __var_4: Ref;
  var previousBalances_s177: int;

  anon0:
    call {:si_unique_call 24} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 25} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 26} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 27} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 28} {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s178);
    call {:si_unique_call 29} {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s178);
    call {:si_unique_call 30} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s178);
    call {:si_unique_call 31} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_7;

  corral_source_split_7:
    goto corral_source_split_8;

  corral_source_split_8:
    __var_4 := null;
    assume _to_s178 != null;
    goto corral_source_split_9;

  corral_source_split_9:
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] >= 0;
    assume _value_s178 >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] >= _value_s178;
    goto corral_source_split_10;

  corral_source_split_10:
    assume M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] >= 0;
    assume _value_s178 >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] + _value_s178 >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] + _value_s178 > M_Ref_int[balanceOf_TokenERC20[this]][_to_s178];
    goto corral_source_split_11;

  corral_source_split_11:
    assume previousBalances_s177 >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] + M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] >= 0;
    previousBalances_s177 := M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] + M_Ref_int[balanceOf_TokenERC20[this]][_to_s178];
    call {:si_unique_call 32} {:cexpr "previousBalances"} boogie_si_record_sol2Bpl_int(previousBalances_s177);
    goto corral_source_split_12;

  corral_source_split_12:
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] >= 0;
    assume _value_s178 >= 0;
    M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] := M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] - _value_s178;
    call {:si_unique_call 33} {:cexpr "balanceOf[_from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][_from_s178]);
    goto corral_source_split_13;

  corral_source_split_13:
    assume M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] >= 0;
    assume _value_s178 >= 0;
    M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] := M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] + _value_s178;
    call {:si_unique_call 34} {:cexpr "balanceOf[_to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][_to_s178]);
    goto corral_source_split_14;

  corral_source_split_14:
    assert {:EventEmitted "Transfer_TokenERC20"} true;
    goto corral_source_split_15;

  corral_source_split_15:
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] + M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] >= 0;
    assume previousBalances_s177 >= 0;
    assert M_Ref_int[balanceOf_TokenERC20[this]][_from_s178] + M_Ref_int[balanceOf_TokenERC20[this]][_to_s178] == previousBalances_s177;
    return;
}



procedure {:public} transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s247: Ref, _value_s247: int) returns (__ret_0_: bool);
  modifies M_Ref_int;
  ensures _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) == old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]));
  ensures old(totalSupply_TokenERC20[this]) == totalSupply_TokenERC20[this];
  ensures old(totalSupply_TokenERC20[this]) >= totalSupply_TokenERC20[this];
  ensures old(totalSupply_TokenERC20[this]) <= totalSupply_TokenERC20[this];



implementation {:ForceInline} transfer_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s247: Ref, _value_s247: int) returns (__ret_0_: bool)
{

  anon0:
    call {:si_unique_call 35} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 36} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 37} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 38} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 39} {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s247);
    call {:si_unique_call 40} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s247);
    call {:si_unique_call 41} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_17;

  corral_source_split_17:
    goto corral_source_split_18;

  corral_source_split_18:
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= 0;
    goto corral_source_split_19;

  corral_source_split_19:
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    goto corral_source_split_20;

  corral_source_split_20:
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    goto corral_source_split_21;

  corral_source_split_21:
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    goto corral_source_split_22;

  corral_source_split_22:
    assume _value_s247 >= 0;
    call {:si_unique_call 42} _transfer_TokenERC20(this, msgsender_MSG, msgvalue_MSG, msgsender_MSG, _to_s247, _value_s247);
    goto corral_source_split_23;

  corral_source_split_23:
    __ret_0_ := true;
    return;
}



procedure {:public} transferFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s384: Ref, _to_s384: Ref, _value_s384: int) returns (success_s384: bool);
  requires M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG] >= _value_s384;
  modifies M_Ref_int;
  ensures _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) == old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]));
  ensures _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]));
  ensures _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) <= old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]));
  ensures old(totalSupply_TokenERC20[this]) == totalSupply_TokenERC20[this];
  ensures old(totalSupply_TokenERC20[this]) >= totalSupply_TokenERC20[this];
  ensures old(totalSupply_TokenERC20[this]) <= totalSupply_TokenERC20[this];



implementation {:ForceInline} transferFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s384: Ref, _to_s384: Ref, _value_s384: int) returns (success_s384: bool)
{

  anon0:
    call {:si_unique_call 43} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 44} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 45} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 46} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 47} {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s384);
    call {:si_unique_call 48} {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s384);
    call {:si_unique_call 49} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s384);
    call {:si_unique_call 50} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_25;

  corral_source_split_25:
    goto corral_source_split_26;

  corral_source_split_26:
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= 0;
    goto corral_source_split_27;

  corral_source_split_27:
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= 0;
    goto corral_source_split_28;

  corral_source_split_28:
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= 0;
    goto corral_source_split_29;

  corral_source_split_29:
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    goto corral_source_split_30;

  corral_source_split_30:
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    goto corral_source_split_31;

  corral_source_split_31:
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    goto corral_source_split_32;

  corral_source_split_32:
    assume M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG] >= 0;
    assume _value_s384 >= 0;
    goto corral_source_split_33;

  corral_source_split_33:
    assume _value_s384 >= 0;
    assume M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG] >= 0;
    assume _value_s384 <= M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG];
    goto corral_source_split_34;

  corral_source_split_34:
    assume M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG] >= 0;
    assume _value_s384 >= 0;
    M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG] := M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG] - _value_s384;
    call {:si_unique_call 51} {:cexpr "allowance[_from][msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s384]][msgsender_MSG]);
    goto corral_source_split_35;

  corral_source_split_35:
    assume _value_s384 >= 0;
    call {:si_unique_call 52} _transfer_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s384, _to_s384, _value_s384);
    goto corral_source_split_36;

  corral_source_split_36:
    success_s384 := true;
    return;
}



procedure {:public} approve_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s502: Ref, _value_s502: int) returns (success_s502: bool);
  modifies M_Ref_int;
  ensures _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) == old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]));
  ensures _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]));
  ensures _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) <= old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]));
  ensures totalSupply_TokenERC20[this] == old(totalSupply_TokenERC20[this]);
  ensures totalSupply_TokenERC20[this] >= old(totalSupply_TokenERC20[this]);
  ensures totalSupply_TokenERC20[this] <= old(totalSupply_TokenERC20[this]);
  ensures M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502] == _value_s502;



implementation {:ForceInline} approve_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s502: Ref, _value_s502: int) returns (success_s502: bool)
{

  anon0:
    call {:si_unique_call 53} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 54} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 55} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 56} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 57} {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s502);
    call {:si_unique_call 58} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s502);
    call {:si_unique_call 59} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_38;

  corral_source_split_38:
    goto corral_source_split_39;

  corral_source_split_39:
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= 0;
    goto corral_source_split_40;

  corral_source_split_40:
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= 0;
    goto corral_source_split_41;

  corral_source_split_41:
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]])) >= 0;
    goto corral_source_split_42;

  corral_source_split_42:
    assume totalSupply_TokenERC20[this] >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    goto corral_source_split_43;

  corral_source_split_43:
    assume totalSupply_TokenERC20[this] >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    goto corral_source_split_44;

  corral_source_split_44:
    assume totalSupply_TokenERC20[this] >= 0;
    assume totalSupply_TokenERC20[this] >= 0;
    assume old(totalSupply_TokenERC20[this]) >= 0;
    goto corral_source_split_45;

  corral_source_split_45:
    assume M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502] >= 0;
    assume _value_s502 >= 0;
    goto corral_source_split_46;

  corral_source_split_46:
    assume M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502] >= 0;
    assume _value_s502 >= 0;
    M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502] := _value_s502;
    call {:si_unique_call 60} {:cexpr "allowance[msg.sender][_spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][msgsender_MSG]][_spender_s502]);
    goto corral_source_split_47;

  corral_source_split_47:
    success_s502 := true;
    return;
}



procedure {:public} approveAndCall_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s540: Ref, _value_s540: int, _extraData_s540: int) returns (success_s540: bool);
  modifies M_Ref_int;



implementation {:ForceInline} approveAndCall_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s540: Ref, _value_s540: int, _extraData_s540: int) returns (success_s540: bool)
{
  var spender_s539: Ref;
  var __var_5: bool;
  var __var_6: int;
  var __var_7: Ref;

  anon0:
    call {:si_unique_call 61} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 62} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 63} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 64} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 65} {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s540);
    call {:si_unique_call 66} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s540);
    call {:si_unique_call 67} {:cexpr "_extraData"} boogie_si_record_sol2Bpl_int(_extraData_s540);
    call {:si_unique_call 68} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_49;

  corral_source_split_49:
    goto corral_source_split_50;

  corral_source_split_50:
    assume DType[_spender_s540] == tokenRecipient;
    spender_s539 := _spender_s540;
    call {:si_unique_call 69} {:cexpr "spender"} boogie_si_record_sol2Bpl_ref(spender_s539);
    goto corral_source_split_51;

  corral_source_split_51:
    assume _value_s540 >= 0;
    call {:si_unique_call 70} __var_5 := approve_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s540, _value_s540);
    goto anon2_Then, anon2_Else;

  anon2_Then:
    assume {:partition} __var_5;
    goto corral_source_split_53;

  corral_source_split_53:
    goto corral_source_split_54;

  corral_source_split_54:
    assume _value_s540 >= 0;
    __var_7 := this;
    call {:si_unique_call 71} receiveApproval_tokenRecipient(spender_s539, this, __var_6, msgsender_MSG, _value_s540, this, _extraData_s540);
    goto corral_source_split_55;

  corral_source_split_55:
    success_s540 := true;
    return;

  anon2_Else:
    assume {:partition} !__var_5;
    return;
}



procedure {:public} burn_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _value_s576: int) returns (success_s576: bool);
  modifies M_Ref_int, totalSupply_TokenERC20;



implementation {:ForceInline} burn_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _value_s576: int) returns (success_s576: bool)
{

  anon0:
    call {:si_unique_call 72} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 73} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 74} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 75} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 76} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s576);
    call {:si_unique_call 77} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_57;

  corral_source_split_57:
    goto corral_source_split_58;

  corral_source_split_58:
    assume M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] >= 0;
    assume _value_s576 >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] >= _value_s576;
    goto corral_source_split_59;

  corral_source_split_59:
    assume M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] >= 0;
    assume _value_s576 >= 0;
    M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] := M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG] - _value_s576;
    call {:si_unique_call 78} {:cexpr "balanceOf[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][msgsender_MSG]);
    goto corral_source_split_60;

  corral_source_split_60:
    assume totalSupply_TokenERC20[this] >= 0;
    assume _value_s576 >= 0;
    totalSupply_TokenERC20[this] := totalSupply_TokenERC20[this] - _value_s576;
    call {:si_unique_call 79} {:cexpr "totalSupply"} boogie_si_record_sol2Bpl_int(totalSupply_TokenERC20[this]);
    goto corral_source_split_61;

  corral_source_split_61:
    assert {:EventEmitted "Burn_TokenERC20"} true;
    goto corral_source_split_62;

  corral_source_split_62:
    success_s576 := true;
    return;
}



procedure {:public} burnFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s631: Ref, _value_s631: int) returns (success_s631: bool);
  modifies M_Ref_int, totalSupply_TokenERC20;



implementation {:ForceInline} burnFrom_TokenERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s631: Ref, _value_s631: int) returns (success_s631: bool)
{

  anon0:
    call {:si_unique_call 80} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 81} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 82} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 83} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 84} {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s631);
    call {:si_unique_call 85} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s631);
    call {:si_unique_call 86} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_64;

  corral_source_split_64:
    goto corral_source_split_65;

  corral_source_split_65:
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s631] >= 0;
    assume _value_s631 >= 0;
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s631] >= _value_s631;
    goto corral_source_split_66;

  corral_source_split_66:
    assume _value_s631 >= 0;
    assume M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG] >= 0;
    assume _value_s631 <= M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG];
    goto corral_source_split_67;

  corral_source_split_67:
    assume M_Ref_int[balanceOf_TokenERC20[this]][_from_s631] >= 0;
    assume _value_s631 >= 0;
    M_Ref_int[balanceOf_TokenERC20[this]][_from_s631] := M_Ref_int[balanceOf_TokenERC20[this]][_from_s631] - _value_s631;
    call {:si_unique_call 87} {:cexpr "balanceOf[_from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balanceOf_TokenERC20[this]][_from_s631]);
    goto corral_source_split_68;

  corral_source_split_68:
    assume M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG] >= 0;
    assume _value_s631 >= 0;
    M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG] := M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG] - _value_s631;
    call {:si_unique_call 88} {:cexpr "allowance[_from][msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowance_TokenERC20[this]][_from_s631]][msgsender_MSG]);
    goto corral_source_split_69;

  corral_source_split_69:
    assume totalSupply_TokenERC20[this] >= 0;
    assume _value_s631 >= 0;
    totalSupply_TokenERC20[this] := totalSupply_TokenERC20[this] - _value_s631;
    call {:si_unique_call 89} {:cexpr "totalSupply"} boogie_si_record_sol2Bpl_int(totalSupply_TokenERC20[this]);
    goto corral_source_split_70;

  corral_source_split_70:
    assert {:EventEmitted "Burn_TokenERC20"} true;
    goto corral_source_split_71;

  corral_source_split_71:
    success_s631 := true;
    return;
}



procedure FallbackDispatch(from: Ref, to: Ref, amount: int);



procedure Fallback_UnknownType(from: Ref, to: Ref, amount: int);



procedure send(from: Ref, to: Ref, amount: int) returns (success: bool);



procedure BoogieEntry_tokenRecipient();



procedure BoogieEntry_TokenERC20();



procedure CorralChoice_tokenRecipient(this: Ref);



procedure CorralEntry_tokenRecipient();



procedure CorralChoice_TokenERC20(this: Ref);
  modifies now, Alloc, M_Ref_int, totalSupply_TokenERC20;



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

  anon0:
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
    assume now > tmpNow;
    assume msgsender_MSG != null;
    assume DType[msgsender_MSG] != tokenRecipient;
    assume DType[msgsender_MSG] != TokenERC20;
    assume DType[msgsender_MSG] != VeriSol;
    Alloc[msgsender_MSG] := true;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} choice == 6;
    call {:si_unique_call 90} __ret_0_transfer := transfer_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _to_s247, _value_s247);
    return;

  anon7_Else:
    assume {:partition} choice != 6;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} choice == 5;
    call {:si_unique_call 91} success_s384 := transferFrom_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s384, _to_s384, _value_s384);
    return;

  anon8_Else:
    assume {:partition} choice != 5;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} choice == 4;
    call {:si_unique_call 92} success_s502 := approve_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s502, _value_s502);
    return;

  anon9_Else:
    assume {:partition} choice != 4;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} choice == 3;
    call {:si_unique_call 93} success_s540 := approveAndCall_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _spender_s540, _value_s540, _extraData_s540);
    return;

  anon10_Else:
    assume {:partition} choice != 3;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} choice == 2;
    call {:si_unique_call 94} success_s576 := burn_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _value_s576);
    return;

  anon11_Else:
    assume {:partition} choice != 2;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} choice == 1;
    call {:si_unique_call 95} success_s631 := burnFrom_TokenERC20(this, msgsender_MSG, msgvalue_MSG, _from_s631, _value_s631);
    return;

  anon12_Else:
    assume {:partition} choice != 1;
    return;
}



procedure CorralEntry_TokenERC20();
  modifies Alloc, Balance, name_TokenERC20, symbol_TokenERC20, decimals_TokenERC20, totalSupply_TokenERC20, balanceOf_TokenERC20, allowance_TokenERC20, M_Ref_int, now;



implementation CorralEntry_TokenERC20()
{
  var this: Ref;
  var msgsender_MSG: Ref;
  var msgvalue_MSG: int;
  var initialSupply_s83: int;
  var tokenName_s83: int;
  var tokenSymbol_s83: int;

  anon0:
    call {:si_unique_call 96} this := FreshRefGenerator();
    assume now >= 0;
    assume DType[this] == TokenERC20;
    call {:si_unique_call 97} TokenERC20_TokenERC20(this, msgsender_MSG, msgvalue_MSG, initialSupply_s83, tokenName_s83, tokenSymbol_s83);
    goto anon2_LoopHead;

  anon2_LoopHead:
    assert _SumMapping_VeriSol(M_Ref_int[balanceOf_TokenERC20[this]]) == totalSupply_TokenERC20[this];
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    assume {:partition} true;
    call {:si_unique_call 98} CorralChoice_TokenERC20(this);
    goto anon2_LoopHead;

  anon2_LoopDone:
    assume {:partition} !true;
    return;
}


