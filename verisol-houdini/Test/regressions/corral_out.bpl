type Ref;

type ContractName;

const unique null: Ref;

const unique Arzdigital: ContractName;

const unique StandardToken: ContractName;

const unique Token: ContractName;

const unique IERC20: ContractName;

const unique VeriSol: ContractName;

const unique SafeMath: ContractName;

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

procedure Arzdigital_Arzdigital_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance;



implementation {:ForceInline} Arzdigital_Arzdigital_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    return;
}



procedure Arzdigital_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance;



implementation {:ForceInline} Arzdigital_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    call {:si_unique_call 0} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 1} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 2} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 3} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 4} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_1;

  corral_source_split_1:
    call {:si_unique_call 5} Arzdigital_Arzdigital_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
    return;
}



procedure {:public} totalSupply_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (supply_s10: int);



implementation {:ForceInline} totalSupply_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (supply_s10: int)
{

  anon0:
    call {:si_unique_call 6} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 7} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 8} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 9} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 10} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_3;

  corral_source_split_3:
    return;
}



procedure {:public} balanceOf_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s18: Ref) returns (balance_s18: int);



procedure {:public} transfer_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s28: Ref, _value_s28: int) returns (success_s28: bool);



procedure {:public} transferFrom_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s40: Ref, _to_s40: Ref, _value_s40: int) returns (success_s40: bool);



procedure {:public} approve_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s50: Ref, _value_s50: int) returns (success_s50: bool);



procedure {:public} allowance_Arzdigital(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s60: Ref, _spender_s60: Ref) returns (remaining_s60: int);



procedure StandardToken_StandardToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance, Alloc, balances_StandardToken, allowed_StandardToken, _totalSupply_StandardToken;



implementation {:ForceInline} StandardToken_StandardToken_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{
  var __var_1: Ref;
  var __var_2: Ref;

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    call {:si_unique_call 11} __var_1 := FreshRefGenerator();
    balances_StandardToken[this] := __var_1;
    assume (forall __i__0_0: Ref :: M_Ref_int[balances_StandardToken[this]][__i__0_0] == 0);
    call {:si_unique_call 12} __var_2 := FreshRefGenerator();
    allowed_StandardToken[this] := __var_2;
    assume (forall __i__0_0: Ref :: Length[M_Ref_Ref[allowed_StandardToken[this]][__i__0_0]] == 0);
    assume (forall __i__0_0: Ref :: !Alloc[M_Ref_Ref[allowed_StandardToken[this]][__i__0_0]]);
    call {:si_unique_call 13} HavocAllocMany();
    assume (forall __i__0_0: Ref :: Alloc[M_Ref_Ref[allowed_StandardToken[this]][__i__0_0]]);
    assume (forall __i__0_0: Ref, __i__0_1: Ref :: { M_Ref_Ref[allowed_StandardToken[this]][__i__0_0], M_Ref_Ref[allowed_StandardToken[this]][__i__0_1] } __i__0_0 == __i__0_1 || M_Ref_Ref[allowed_StandardToken[this]][__i__0_0] != M_Ref_Ref[allowed_StandardToken[this]][__i__0_1]);
    _totalSupply_StandardToken[this] := 0;
    return;
}



procedure StandardToken_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance, Alloc, balances_StandardToken, allowed_StandardToken, _totalSupply_StandardToken;



implementation {:ForceInline} StandardToken_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    call {:si_unique_call 14} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 15} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 16} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 17} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 18} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_5;

  corral_source_split_5:
    call {:si_unique_call 19} Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
    call {:si_unique_call 20} StandardToken_StandardToken_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
    return;
}



procedure {:public} transfer_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s231: Ref, _value_s231: int) returns (success_s231: bool);
  modifies M_Ref_int;
  ensures _totalSupply_StandardToken[this] == old(_totalSupply_StandardToken[this]);
  ensures _to_s231 == old(_to_s231);
  ensures _value_s231 == old(_value_s231);
  ensures msgsender_MSG == old(msgsender_MSG);
  ensures old(_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) == _SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]]);
  ensures old(M_Ref_int[balances_StandardToken[this]][msgsender_MSG] + M_Ref_int[balances_StandardToken[this]][_to_s231]) == M_Ref_int[balances_StandardToken[this]][msgsender_MSG] + M_Ref_int[balances_StandardToken[this]][_to_s231];
  ensures M_Ref_int[balances_StandardToken[this]][_to_s231] - _value_s231 == old(M_Ref_int[balances_StandardToken[this]][_to_s231]);



implementation {:ForceInline} transfer_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _to_s231: Ref, _value_s231: int) returns (success_s231: bool)
{

  anon0:
    call {:si_unique_call 21} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 22} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 23} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 24} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 25} {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s231);
    call {:si_unique_call 26} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s231);
    call {:si_unique_call 27} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_7;

  corral_source_split_7:
    goto corral_source_split_8;

  corral_source_split_8:
    assume _totalSupply_StandardToken[this] >= 0;
    assume _totalSupply_StandardToken[this] >= 0;
    assume old(_totalSupply_StandardToken[this]) >= 0;
    goto corral_source_split_9;

  corral_source_split_9:
    goto corral_source_split_10;

  corral_source_split_10:
    assume _value_s231 >= 0;
    assume _value_s231 >= 0;
    assume old(_value_s231) >= 0;
    goto corral_source_split_11;

  corral_source_split_11:
    goto corral_source_split_12;

  corral_source_split_12:
    assume _SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]]) >= 0;
    assume old(_SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]])) >= 0;
    assume _SumMapping_VeriSol(M_Ref_int[balances_StandardToken[this]]) >= 0;
    goto corral_source_split_13;

  corral_source_split_13:
    assume M_Ref_int[balances_StandardToken[this]][msgsender_MSG] >= 0;
    assume M_Ref_int[balances_StandardToken[this]][_to_s231] >= 0;
    assume M_Ref_int[balances_StandardToken[this]][msgsender_MSG] + M_Ref_int[balances_StandardToken[this]][_to_s231] >= 0;
    assume old(M_Ref_int[balances_StandardToken[this]][msgsender_MSG] + M_Ref_int[balances_StandardToken[this]][_to_s231]) >= 0;
    assume M_Ref_int[balances_StandardToken[this]][msgsender_MSG] >= 0;
    assume M_Ref_int[balances_StandardToken[this]][_to_s231] >= 0;
    assume M_Ref_int[balances_StandardToken[this]][msgsender_MSG] + M_Ref_int[balances_StandardToken[this]][_to_s231] >= 0;
    goto corral_source_split_14;

  corral_source_split_14:
    assume M_Ref_int[balances_StandardToken[this]][_to_s231] >= 0;
    assume _value_s231 >= 0;
    assume M_Ref_int[balances_StandardToken[this]][_to_s231] - _value_s231 >= 0;
    assume M_Ref_int[balances_StandardToken[this]][_to_s231] >= 0;
    assume old(M_Ref_int[balances_StandardToken[this]][_to_s231]) >= 0;
    goto corral_source_split_15;

  corral_source_split_15:
    assume M_Ref_int[balances_StandardToken[this]][msgsender_MSG] >= 0;
    assume _value_s231 >= 0;
    assume _value_s231 >= 0;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} M_Ref_int[balances_StandardToken[this]][msgsender_MSG] >= _value_s231 && _value_s231 > 0;
    goto corral_source_split_17;

  corral_source_split_17:
    goto corral_source_split_18;

  corral_source_split_18:
    assume M_Ref_int[balances_StandardToken[this]][msgsender_MSG] >= 0;
    assume _value_s231 >= 0;
    M_Ref_int[balances_StandardToken[this]][msgsender_MSG] := M_Ref_int[balances_StandardToken[this]][msgsender_MSG] - _value_s231;
    call {:si_unique_call 28} {:cexpr "balances[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][msgsender_MSG]);
    goto corral_source_split_19;

  corral_source_split_19:
    assume M_Ref_int[balances_StandardToken[this]][_to_s231] >= 0;
    assume _value_s231 >= 0;
    M_Ref_int[balances_StandardToken[this]][_to_s231] := M_Ref_int[balances_StandardToken[this]][_to_s231] + _value_s231;
    call {:si_unique_call 29} {:cexpr "balances[_to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][_to_s231]);
    goto corral_source_split_20;

  corral_source_split_20:
    assert {:EventEmitted "Transfer_StandardToken"} true;
    goto corral_source_split_21;

  corral_source_split_21:
    success_s231 := true;
    return;

  anon3_Else:
    assume {:partition} !(M_Ref_int[balances_StandardToken[this]][msgsender_MSG] >= _value_s231 && _value_s231 > 0);
    goto corral_source_split_23;

  corral_source_split_23:
    goto corral_source_split_24;

  corral_source_split_24:
    success_s231 := false;
    return;
}



procedure {:public} transferFrom_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s295: Ref, _to_s295: Ref, _value_s295: int) returns (success_s295: bool);
  modifies M_Ref_int;



implementation {:ForceInline} transferFrom_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _from_s295: Ref, _to_s295: Ref, _value_s295: int) returns (success_s295: bool)
{

  anon0:
    call {:si_unique_call 30} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 31} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 32} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 33} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 34} {:cexpr "_from"} boogie_si_record_sol2Bpl_ref(_from_s295);
    call {:si_unique_call 35} {:cexpr "_to"} boogie_si_record_sol2Bpl_ref(_to_s295);
    call {:si_unique_call 36} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s295);
    call {:si_unique_call 37} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_26;

  corral_source_split_26:
    goto corral_source_split_27;

  corral_source_split_27:
    assume M_Ref_int[balances_StandardToken[this]][_from_s295] >= 0;
    assume _value_s295 >= 0;
    assume M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s295]][msgsender_MSG] >= 0;
    assume _value_s295 >= 0;
    assume _value_s295 >= 0;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} M_Ref_int[balances_StandardToken[this]][_from_s295] >= _value_s295 && M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s295]][msgsender_MSG] >= _value_s295 && _value_s295 > 0;
    goto corral_source_split_29;

  corral_source_split_29:
    goto corral_source_split_30;

  corral_source_split_30:
    assume M_Ref_int[balances_StandardToken[this]][_to_s295] >= 0;
    assume _value_s295 >= 0;
    M_Ref_int[balances_StandardToken[this]][_to_s295] := M_Ref_int[balances_StandardToken[this]][_to_s295] + _value_s295;
    call {:si_unique_call 38} {:cexpr "balances[_to]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][_to_s295]);
    goto corral_source_split_31;

  corral_source_split_31:
    assume M_Ref_int[balances_StandardToken[this]][_from_s295] >= 0;
    assume _value_s295 >= 0;
    M_Ref_int[balances_StandardToken[this]][_from_s295] := M_Ref_int[balances_StandardToken[this]][_from_s295] - _value_s295;
    call {:si_unique_call 39} {:cexpr "balances[_from]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][_from_s295]);
    goto corral_source_split_32;

  corral_source_split_32:
    assume M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s295]][msgsender_MSG] >= 0;
    assume _value_s295 >= 0;
    M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s295]][msgsender_MSG] := M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s295]][msgsender_MSG] - _value_s295;
    call {:si_unique_call 40} {:cexpr "allowed[_from][msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s295]][msgsender_MSG]);
    goto corral_source_split_33;

  corral_source_split_33:
    assert {:EventEmitted "Transfer_StandardToken"} true;
    goto corral_source_split_34;

  corral_source_split_34:
    success_s295 := true;
    return;

  anon3_Else:
    assume {:partition} !(M_Ref_int[balances_StandardToken[this]][_from_s295] >= _value_s295 && M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_from_s295]][msgsender_MSG] >= _value_s295 && _value_s295 > 0);
    goto corral_source_split_36;

  corral_source_split_36:
    goto corral_source_split_37;

  corral_source_split_37:
    success_s295 := false;
    return;
}



procedure {:public} balanceOf_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s307: Ref) returns (balance_s307: int);



implementation {:ForceInline} balanceOf_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s307: Ref) returns (balance_s307: int)
{

  anon0:
    call {:si_unique_call 41} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 42} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 43} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 44} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 45} {:cexpr "_owner"} boogie_si_record_sol2Bpl_ref(_owner_s307);
    call {:si_unique_call 46} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_39;

  corral_source_split_39:
    goto corral_source_split_40;

  corral_source_split_40:
    assume M_Ref_int[balances_StandardToken[this]][_owner_s307] >= 0;
    balance_s307 := M_Ref_int[balances_StandardToken[this]][_owner_s307];
    return;
}



procedure {:public} approve_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s335: Ref, _value_s335: int) returns (success_s335: bool);
  modifies M_Ref_int;



implementation {:ForceInline} approve_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s335: Ref, _value_s335: int) returns (success_s335: bool)
{

  anon0:
    call {:si_unique_call 47} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 48} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 49} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 50} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 51} {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s335);
    call {:si_unique_call 52} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s335);
    call {:si_unique_call 53} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_42;

  corral_source_split_42:
    goto corral_source_split_43;

  corral_source_split_43:
    assume M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s335] >= 0;
    assume _value_s335 >= 0;
    M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s335] := _value_s335;
    call {:si_unique_call 54} {:cexpr "allowed[msg.sender][_spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s335]);
    goto corral_source_split_44;

  corral_source_split_44:
    assert {:EventEmitted "Approval_StandardToken"} true;
    goto corral_source_split_45;

  corral_source_split_45:
    success_s335 := true;
    return;
}



procedure {:public} allowance_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s351: Ref, _spender_s351: Ref) returns (remaining_s351: int);



implementation {:ForceInline} allowance_StandardToken(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _owner_s351: Ref, _spender_s351: Ref) returns (remaining_s351: int)
{

  anon0:
    call {:si_unique_call 55} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 56} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 57} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 58} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 59} {:cexpr "_owner"} boogie_si_record_sol2Bpl_ref(_owner_s351);
    call {:si_unique_call 60} {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s351);
    call {:si_unique_call 61} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_47;

  corral_source_split_47:
    goto corral_source_split_48;

  corral_source_split_48:
    assume M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_owner_s351]][_spender_s351] >= 0;
    remaining_s351 := M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][_owner_s351]][_spender_s351];
    return;
}



var balances_StandardToken: [Ref]Ref;

var allowed_StandardToken: [Ref]Ref;

var _totalSupply_StandardToken: [Ref]int;

procedure FallbackMethod_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



var name_Token: [Ref]int;

var decimals_Token: [Ref]int;

var symbol_Token: [Ref]int;

var version_Token: [Ref]int;

procedure Token_Token_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance, name_Token, decimals_Token, symbol_Token, version_Token, M_Ref_int, _totalSupply_StandardToken;



implementation {:ForceInline} Token_Token_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    assume msgsender_MSG != null;
    Balance[this] := 0;
    name_Token[this] := 1756992956;
    decimals_Token[this] := 0;
    symbol_Token[this] := 1756992956;
    version_Token[this] := 1444123205;
    call {:si_unique_call 62} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 63} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 64} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 65} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 66} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_50;

  corral_source_split_50:
    goto corral_source_split_51;

  corral_source_split_51:
    assume M_Ref_int[balances_StandardToken[this]][msgsender_MSG] >= 0;
    M_Ref_int[balances_StandardToken[this]][msgsender_MSG] := 820000000;
    call {:si_unique_call 67} {:cexpr "balances[msg.sender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[balances_StandardToken[this]][msgsender_MSG]);
    goto corral_source_split_52;

  corral_source_split_52:
    assume _totalSupply_StandardToken[this] >= 0;
    _totalSupply_StandardToken[this] := 820000000;
    call {:si_unique_call 68} {:cexpr "_totalSupply"} boogie_si_record_sol2Bpl_int(_totalSupply_StandardToken[this]);
    goto corral_source_split_53;

  corral_source_split_53:
    name_Token[this] := -1438745343;
    call {:si_unique_call 69} {:cexpr "name"} boogie_si_record_sol2Bpl_int(name_Token[this]);
    goto corral_source_split_54;

  corral_source_split_54:
    assume decimals_Token[this] >= 0;
    decimals_Token[this] := 1;
    call {:si_unique_call 70} {:cexpr "decimals"} boogie_si_record_sol2Bpl_int(decimals_Token[this]);
    goto corral_source_split_55;

  corral_source_split_55:
    symbol_Token[this] := -1837221890;
    call {:si_unique_call 71} {:cexpr "symbol"} boogie_si_record_sol2Bpl_int(symbol_Token[this]);
    return;
}



procedure {:constructor} {:public} Token_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);
  modifies Balance, Alloc, balances_StandardToken, allowed_StandardToken, _totalSupply_StandardToken, name_Token, decimals_Token, symbol_Token, version_Token, M_Ref_int;



implementation {:ForceInline} Token_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int)
{

  anon0:
    call {:si_unique_call 72} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 73} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 74} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 75} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 76} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    call {:si_unique_call 77} Arzdigital_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
    call {:si_unique_call 78} StandardToken_StandardToken(this, msgsender_MSG, msgvalue_MSG);
    call {:si_unique_call 79} Token_Token_NoBaseCtor(this, msgsender_MSG, msgvalue_MSG);
    return;
}



procedure {:public} approveAndCall_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s439: Ref, _value_s439: int, _extraData_s439: int) returns (success_s439: bool);
  modifies M_Ref_int;



implementation {:ForceInline} approveAndCall_Token(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, _spender_s439: Ref, _value_s439: int, _extraData_s439: int) returns (success_s439: bool)
{

  anon0:
    call {:si_unique_call 80} {:cexpr "_verisolFirstArg"} boogie_si_record_sol2Bpl_bool(false);
    call {:si_unique_call 81} {:cexpr "this"} boogie_si_record_sol2Bpl_ref(this);
    call {:si_unique_call 82} {:cexpr "msg.sender"} boogie_si_record_sol2Bpl_ref(msgsender_MSG);
    call {:si_unique_call 83} {:cexpr "msg.value"} boogie_si_record_sol2Bpl_int(msgvalue_MSG);
    call {:si_unique_call 84} {:cexpr "_spender"} boogie_si_record_sol2Bpl_ref(_spender_s439);
    call {:si_unique_call 85} {:cexpr "_value"} boogie_si_record_sol2Bpl_int(_value_s439);
    call {:si_unique_call 86} {:cexpr "_extraData"} boogie_si_record_sol2Bpl_int(_extraData_s439);
    call {:si_unique_call 87} {:cexpr "_verisolLastArg"} boogie_si_record_sol2Bpl_bool(true);
    goto corral_source_split_57;

  corral_source_split_57:
    goto corral_source_split_58;

  corral_source_split_58:
    assume M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s439] >= 0;
    assume _value_s439 >= 0;
    M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s439] := _value_s439;
    call {:si_unique_call 88} {:cexpr "allowed[msg.sender][_spender]"} boogie_si_record_sol2Bpl_int(M_Ref_int[M_Ref_Ref[allowed_StandardToken[this]][msgsender_MSG]][_spender_s439]);
    goto corral_source_split_59;

  corral_source_split_59:
    assert {:EventEmitted "Approval_Token"} true;
    goto corral_source_split_60;

  corral_source_split_60:
    success_s439 := true;
    return;
}



procedure IERC20_IERC20_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure IERC20_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure {:public} totalSupply_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int) returns (__ret_0_: int);



procedure {:public} balanceOf_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, account_s454: Ref) returns (__ret_0_: int);



procedure {:public} transfer_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, recipient_s463: Ref, amount_s463: int) returns (__ret_0_: bool);



procedure {:public} allowance_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, owner_s472: Ref, spender_s472: Ref) returns (__ret_0_: int);



procedure {:public} approve_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, spender_s481: Ref, amount_s481: int) returns (__ret_0_: bool);



procedure {:public} transferFrom_IERC20(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, sender_s492: Ref, recipient_s492: Ref, amount_s492: int) returns (__ret_0_: bool);



procedure SafeMath_SafeMath_NoBaseCtor(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure SafeMath_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int);



procedure add_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s708: int, b_s708: int) returns (__ret_0_: int);



procedure sub_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s733: int, b_s733: int) returns (__ret_0_: int);



procedure mul_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s767: int, b_s767: int) returns (__ret_0_: int);



procedure div_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s792: int, b_s792: int) returns (__ret_0_: int);



procedure mod_SafeMath(this: Ref, msgsender_MSG: Ref, msgvalue_MSG: int, a_s813: int, b_s813: int) returns (__ret_0_: int);



procedure FallbackDispatch(from: Ref, to: Ref, amount: int);



procedure Fallback_UnknownType(from: Ref, to: Ref, amount: int);



procedure send(from: Ref, to: Ref, amount: int) returns (success: bool);



procedure BoogieEntry_Arzdigital();



procedure BoogieEntry_StandardToken();



procedure BoogieEntry_Token();



procedure BoogieEntry_IERC20();



procedure BoogieEntry_SafeMath();



procedure CorralChoice_Arzdigital(this: Ref);



procedure CorralEntry_Arzdigital();



procedure CorralChoice_StandardToken(this: Ref);



procedure CorralEntry_StandardToken();



procedure CorralChoice_Token(this: Ref);
  modifies now, Alloc, M_Ref_int;



implementation CorralChoice_Token(this: Ref)
{
  var msgsender_MSG: Ref;
  var msgvalue_MSG: int;
  var choice: int;
  var supply_s10: int;
  var _owner_s307: Ref;
  var balance_s307: int;
  var _to_s231: Ref;
  var _value_s231: int;
  var success_s231: bool;
  var _from_s295: Ref;
  var _to_s295: Ref;
  var _value_s295: int;
  var success_s295: bool;
  var _spender_s335: Ref;
  var _value_s335: int;
  var success_s335: bool;
  var _owner_s351: Ref;
  var _spender_s351: Ref;
  var remaining_s351: int;
  var _spender_s439: Ref;
  var _value_s439: int;
  var _extraData_s439: int;
  var success_s439: bool;
  var tmpNow: int;

  anon0:
    havoc msgsender_MSG;
    havoc msgvalue_MSG;
    havoc choice;
    havoc supply_s10;
    havoc _owner_s307;
    havoc balance_s307;
    havoc _to_s231;
    havoc _value_s231;
    havoc success_s231;
    havoc _from_s295;
    havoc _to_s295;
    havoc _value_s295;
    havoc success_s295;
    havoc _spender_s335;
    havoc _value_s335;
    havoc success_s335;
    havoc _owner_s351;
    havoc _spender_s351;
    havoc remaining_s351;
    havoc _spender_s439;
    havoc _value_s439;
    havoc _extraData_s439;
    havoc success_s439;
    havoc tmpNow;
    tmpNow := now;
    havoc now;
    assume now > tmpNow;
    assume msgsender_MSG != null;
    assume DType[msgsender_MSG] != Arzdigital;
    assume DType[msgsender_MSG] != StandardToken;
    assume DType[msgsender_MSG] != Token;
    assume DType[msgsender_MSG] != IERC20;
    assume DType[msgsender_MSG] != VeriSol;
    assume DType[msgsender_MSG] != SafeMath;
    Alloc[msgsender_MSG] := true;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} choice == 7;
    call {:si_unique_call 89} supply_s10 := totalSupply_Arzdigital(this, msgsender_MSG, msgvalue_MSG);
    return;

  anon8_Else:
    assume {:partition} choice != 7;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} choice == 6;
    call {:si_unique_call 90} balance_s307 := balanceOf_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s307);
    return;

  anon9_Else:
    assume {:partition} choice != 6;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} choice == 5;
    call {:si_unique_call 91} success_s231 := transfer_StandardToken(this, msgsender_MSG, msgvalue_MSG, _to_s231, _value_s231);
    return;

  anon10_Else:
    assume {:partition} choice != 5;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} choice == 4;
    call {:si_unique_call 92} success_s295 := transferFrom_StandardToken(this, msgsender_MSG, msgvalue_MSG, _from_s295, _to_s295, _value_s295);
    return;

  anon11_Else:
    assume {:partition} choice != 4;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} choice == 3;
    call {:si_unique_call 93} success_s335 := approve_StandardToken(this, msgsender_MSG, msgvalue_MSG, _spender_s335, _value_s335);
    return;

  anon12_Else:
    assume {:partition} choice != 3;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} choice == 2;
    call {:si_unique_call 94} remaining_s351 := allowance_StandardToken(this, msgsender_MSG, msgvalue_MSG, _owner_s351, _spender_s351);
    return;

  anon13_Else:
    assume {:partition} choice != 2;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} choice == 1;
    call {:si_unique_call 95} success_s439 := approveAndCall_Token(this, msgsender_MSG, msgvalue_MSG, _spender_s439, _value_s439, _extraData_s439);
    return;

  anon14_Else:
    assume {:partition} choice != 1;
    return;
}



procedure CorralEntry_Token();
  modifies Alloc, Balance, balances_StandardToken, allowed_StandardToken, _totalSupply_StandardToken, name_Token, decimals_Token, symbol_Token, version_Token, M_Ref_int, now;



implementation CorralEntry_Token()
{
  var this: Ref;
  var msgsender_MSG: Ref;
  var msgvalue_MSG: int;

  anon0:
    call {:si_unique_call 96} this := FreshRefGenerator();
    assume now >= 0;
    assume DType[this] == Token;
    call {:si_unique_call 97} Token_Token(this, msgsender_MSG, msgvalue_MSG);
    goto anon2_LoopHead;

  anon2_LoopHead:
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    assume {:partition} true;
    call {:si_unique_call 98} CorralChoice_Token(this);
    goto anon2_LoopHead;

  anon2_LoopDone:
    assume {:partition} !true;
    return;
}



procedure CorralChoice_IERC20(this: Ref);



procedure CorralEntry_IERC20();



procedure CorralChoice_SafeMath(this: Ref);



procedure CorralEntry_SafeMath();


