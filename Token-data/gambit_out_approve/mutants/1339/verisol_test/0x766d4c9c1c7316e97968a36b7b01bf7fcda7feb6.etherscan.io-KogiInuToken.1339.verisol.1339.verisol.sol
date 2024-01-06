pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";
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

contract KogiInuToken is ERC20Interface, SafeMath {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public _totalSupply;
    mapping(address => uint) internal balances;
    mapping(address => mapping(address => uint)) internal allowed;

    /// Constrctor function
    ///       * Initializes contract with initial supply tokens to the creator of the contract
    constructor() public {
        name = "Kogi Inu Token";
        symbol = "KOGI";
        assert(true);
        _totalSupply = 10000000000000000000000000000000000;
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
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(allowed[msg.sender][spender] == tokens);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        //End of invariants
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(allowed[msg.sender][spender] == tokens);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures((!(VeriSol.Old(allowed[msg.sender][spender]) == 0)) || (allowed[msg.sender][spender] >= VeriSol.Old(allowed[msg.sender][spender])));
        VeriSol.Ensures((!(VeriSol.Old(allowed[msg.sender][spender]) == tokens)) || (allowed[msg.sender][spender] == VeriSol.Old(allowed[msg.sender][spender])));
        VeriSol.Ensures((!(VeriSol.Old(allowed[msg.sender][spender]) < tokens)) || (allowed[msg.sender][spender] > 0));
        VeriSol.Ensures((!(VeriSol.Old(allowed[msg.sender][spender]) > 0)) || ((allowed[msg.sender][spender] != VeriSol.Old(allowed[msg.sender][spender])) || (allowed[msg.sender][spender] > 0)));
        VeriSol.Ensures((!(VeriSol.Old(allowed[msg.sender][spender]) == 0)) || ((allowed[msg.sender][spender] > 0) || (allowed[msg.sender][spender] == VeriSol.Old(allowed[msg.sender][spender]))));
        VeriSol.Ensures((!(VeriSol.Old(allowed[msg.sender][spender]) <= tokens)) || ((allowed[msg.sender][spender] > 0) || (allowed[msg.sender][spender] == VeriSol.Old(allowed[msg.sender][spender]))));
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) >= tokens);
        VeriSol.Ensures(balances[to] >= VeriSol.Old(balances[to]));
        VeriSol.Ensures(balances[to] >= tokens);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        //End of invariants
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) >= tokens);
        VeriSol.Ensures(balances[to] >= VeriSol.Old(balances[to]));
        VeriSol.Ensures(balances[to] >= tokens);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures((!(tokens > 0)) || (balances[to] > 0));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) != VeriSol.Old(balances[msg.sender]))) || ((tokens + balances[msg.sender]) == VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == VeriSol.Old(VeriSol.SumMapping(balances)))) || (VeriSol.Old(balances[to]) == VeriSol.SumMapping(balances)));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) != tokens)) || (balances[to] > 0));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) < tokens)) || (balances[to] > VeriSol.Old(balances[to])));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) < tokens)) || (balances[msg.sender] < VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) < tokens)) || ((tokens + balances[msg.sender]) == VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) < VeriSol.Old(VeriSol.SumMapping(balances)))) || (balances[msg.sender] < VeriSol.Old(VeriSol.SumMapping(balances))));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) < VeriSol.Old(VeriSol.SumMapping(balances)))) || (balances[msg.sender] < VeriSol.SumMapping(balances)));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) == VeriSol.Old(VeriSol.SumMapping(balances)))) || (VeriSol.Old(balances[msg.sender]) == VeriSol.SumMapping(balances)));
        VeriSol.Ensures((!(to != msg.sender)) || ((tokens + balances[msg.sender]) == VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(VeriSol.SumMapping(balances)) == tokens)) || (tokens == VeriSol.SumMapping(balances)));
        VeriSol.Ensures((!(VeriSol.Old(VeriSol.SumMapping(balances)) > tokens)) || (VeriSol.SumMapping(balances) > 0));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) != 0)) || (balances[to] > 0));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) <= tokens)) || (balances[to] >= balances[msg.sender]));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == VeriSol.Old(balances[msg.sender]))) || (balances[to] >= balances[msg.sender]));
        VeriSol.Ensures((!(to == msg.sender)) || (balances[to] == balances[msg.sender]));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == 0)) || (VeriSol.Old(balances[to]) <= VeriSol.SumMapping(balances)));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) <= tokens)) || (balances[msg.sender] <= tokens));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == 0)) || (balances[to] <= VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == 0)) || (balances[to] == tokens));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == 0)) || (VeriSol.Old(balances[to]) <= balances[msg.sender]));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) <= tokens)) || (balances[to] >= VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) <= tokens)) || (VeriSol.Old(balances[to]) >= balances[msg.sender]));
        VeriSol.Ensures((!(to == msg.sender)) || (balances[to] == VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == VeriSol.Old(balances[msg.sender]))) || (balances[to] >= VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(to == msg.sender)) || (VeriSol.Old(balances[to]) == balances[msg.sender]));
        VeriSol.Ensures((!(VeriSol.Old(balances[to]) == VeriSol.Old(balances[msg.sender]))) || (VeriSol.Old(balances[to]) >= balances[msg.sender]));
        VeriSol.Ensures((!(to == msg.sender)) || (balances[to] == VeriSol.Old(balances[to])));
        VeriSol.Ensures((!(to == msg.sender)) || (balances[msg.sender] == VeriSol.Old(balances[msg.sender])));
        VeriSol.Ensures((!(VeriSol.Old(balances[msg.sender]) != tokens)) || (balances[msg.sender] != 0));
        VeriSol.Ensures((!((VeriSol.Old(balances[to]) <= tokens) && (VeriSol.Old(balances[msg.sender]) != tokens))) || ((tokens + balances[msg.sender]) == VeriSol.Old(balances[msg.sender])));
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(decimals == 18);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) == 10000000000000000000000000000000000);
        VeriSol.ContractInvariant(_totalSupply == 10000000000000000000000000000000000);
        VeriSol.ContractInvariant(decimals < VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals < _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) == _totalSupply);
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(decimals == 18);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) == 10000000000000000000000000000000000);
        VeriSol.ContractInvariant(_totalSupply == 10000000000000000000000000000000000);
        VeriSol.ContractInvariant(decimals < VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals < _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) == _totalSupply);
    }
}