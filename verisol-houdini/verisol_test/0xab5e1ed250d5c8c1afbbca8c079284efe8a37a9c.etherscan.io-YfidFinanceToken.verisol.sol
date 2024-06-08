pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

contract ERC20Interface {
    event Transfer(address indexed from, address indexed to, uint tokens);

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    function totalSupply() public view returns (uint);

    function balanceOf(address tokenOwner) public view returns (uint balance);

    function allowance(address tokenOwner, address spender) public view returns (uint remaining);

    function transfer(address to, uint tokens) public returns (bool success);

    function approve(address spender, uint tokens) public returns (bool success);

    function transferFrom(address from, address to, uint tokens) public returns (bool success);
}

contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }

    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }

    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require((a == 0) || ((c / a) == b));
    }

    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract YfidFinanceToken is ERC20Interface, SafeMath {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public _totalSupply;
    mapping(address => uint) internal balances;
    mapping(address => mapping(address => uint)) internal allowed;

    /// Constrctor function
    ///      * Initializes contract with initial supply tokens to the creator of the contract
    constructor() public {
        name = "YfidFinance";
        symbol = "YFID";
        decimals = 18;
        _totalSupply = 25000000000000000000000;
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply - balances[address(0)];
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(tokens>0);
        VeriSol.Requires(tokens==115792089237316195423570985008687907853269984665640564039457584007913129639935);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(allowed[msg.sender][spender]==0);
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==25000000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.Requires(tokens >= (uint256(decimals)));
        VeriSol.Requires(tokens > (uint256(decimals)));
        VeriSol.Requires(tokens != (uint256(decimals)));
        VeriSol.Requires(tokens >= (allowed[msg.sender][spender]));
        VeriSol.Requires(tokens > (allowed[msg.sender][spender]));
        VeriSol.Requires(tokens != (allowed[msg.sender][spender]));
        VeriSol.Requires(tokens >= (_totalSupply));
        VeriSol.Requires(tokens > (_totalSupply));
        VeriSol.Requires(tokens != (_totalSupply));
        VeriSol.Requires(tokens >= (VeriSol.SumMapping(balances)));
        VeriSol.Requires(tokens > (VeriSol.SumMapping(balances)));
        VeriSol.Requires(tokens != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) >= (allowed[msg.sender][spender]));
        VeriSol.Requires((uint256(decimals)) > (allowed[msg.sender][spender]));
        VeriSol.Requires((uint256(decimals)) != (allowed[msg.sender][spender]));
        VeriSol.Requires((uint256(decimals)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) < (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (_totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((allowed[msg.sender][spender]) <= (_totalSupply));
        VeriSol.Requires((allowed[msg.sender][spender]) < (_totalSupply));
        VeriSol.Requires((allowed[msg.sender][spender]) != (_totalSupply));
        VeriSol.Requires((allowed[msg.sender][spender]) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((allowed[msg.sender][spender]) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((allowed[msg.sender][spender]) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) == (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires(msg.sender != spender);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==25000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.Ensures(allowed[msg.sender][spender]>0);
        VeriSol.Ensures(allowed[msg.sender][spender]==115792089237316195423570985008687907853269984665640564039457584007913129639935);
        VeriSol.Ensures(tokens >= decimals);
        VeriSol.Ensures(tokens > decimals);
        VeriSol.Ensures(tokens != decimals);
        VeriSol.Ensures(tokens >= _totalSupply);
        VeriSol.Ensures(tokens > _totalSupply);
        VeriSol.Ensures(tokens != _totalSupply);
        VeriSol.Ensures(tokens >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(tokens > VeriSol.SumMapping(balances));
        VeriSol.Ensures(tokens != VeriSol.SumMapping(balances));
        VeriSol.Ensures(tokens == allowed[msg.sender][spender]);
        VeriSol.Ensures(tokens >= allowed[msg.sender][spender]);
        VeriSol.Ensures(tokens <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) == decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) <= decimals);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) < decimals);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) != decimals);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) != allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals <= allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals < allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals != allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply <= allowed[msg.sender][spender]);
        VeriSol.Ensures(_totalSupply < allowed[msg.sender][spender]);
        VeriSol.Ensures(_totalSupply != allowed[msg.sender][spender]);
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(allowed[msg.sender][spender] >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(allowed[msg.sender][spender] > VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(allowed[msg.sender][spender] != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        //End of invariants
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(tokens>0);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==25000000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.Requires(balances[msg.sender]>0);
        VeriSol.Requires(tokens >= (uint256(decimals)));
        VeriSol.Requires(tokens > (uint256(decimals)));
        VeriSol.Requires(tokens != (uint256(decimals)));
        VeriSol.Requires(tokens <= (_totalSupply));
        VeriSol.Requires(tokens <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires(tokens <= (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) < (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (balances[to]));
        VeriSol.Requires((uint256(decimals)) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) <= (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) < (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) != (balances[msg.sender]));
        VeriSol.Requires((_totalSupply) >= (balances[to]));
        VeriSol.Requires((_totalSupply) > (balances[to]));
        VeriSol.Requires((_totalSupply) != (balances[to]));
        VeriSol.Requires((_totalSupply) == (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (balances[msg.sender]));
        VeriSol.Requires(msg.sender != to);
        VeriSol.Requires((balances[to]) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[to]) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[to]) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[to]) <= (balances[msg.sender]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (balances[msg.sender]));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==25000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.Ensures(balances[to]>0);
        VeriSol.Ensures(tokens >= decimals);
        VeriSol.Ensures(tokens > decimals);
        VeriSol.Ensures(tokens != decimals);
        VeriSol.Ensures(tokens <= _totalSupply);
        VeriSol.Ensures(tokens <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(tokens != balances[msg.sender]);
        VeriSol.Ensures(tokens <= balances[to]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) == decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= balances[to]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < balances[to]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != balances[to]);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals != balances[msg.sender]);
        VeriSol.Ensures(decimals != VeriSol.Old(balances[to]));
        VeriSol.Ensures(decimals <= balances[to]);
        VeriSol.Ensures(decimals < balances[to]);
        VeriSol.Ensures(decimals != balances[to]);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(decimals < VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(decimals != VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply >= balances[msg.sender]);
        VeriSol.Ensures(_totalSupply > balances[msg.sender]);
        VeriSol.Ensures(_totalSupply != balances[msg.sender]);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(balances[to]));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(balances[to]));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(balances[to]));
        VeriSol.Ensures(_totalSupply >= balances[to]);
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= balances[to]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(balances[to]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(balances[to]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(balances[to]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= balances[to]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] != balances[to]);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(balances[to]) <= balances[to]);
        VeriSol.Ensures(VeriSol.Old(balances[to]) < balances[to]);
        VeriSol.Ensures(VeriSol.Old(balances[to]) != balances[to]);
        VeriSol.Ensures(balances[to] <= VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==25000000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.Requires((uint256(decimals)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) < (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (_totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((uint256(decimals)) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) == (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) <= (VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==25000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) == decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != _totalSupply);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        //End of invariants
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(_totalSupply>0);
        VeriSol.ContractInvariant(_totalSupply==25000000000000000000000);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)==25000000000000000000000);
        VeriSol.ContractInvariant(decimals>0);
        VeriSol.ContractInvariant(decimals==18);
        VeriSol.ContractInvariant(_totalSupply == VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(_totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(_totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(_totalSupply >= decimals);
        VeriSol.ContractInvariant(_totalSupply > decimals);
        VeriSol.ContractInvariant(_totalSupply != decimals);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) >= decimals);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) > decimals);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) != decimals);
    }
}