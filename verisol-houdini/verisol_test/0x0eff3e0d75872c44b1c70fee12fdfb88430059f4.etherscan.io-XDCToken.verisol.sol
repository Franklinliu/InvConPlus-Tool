pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

contract SafeMath {
    /// @dev returns the sum of _x and _y, asserts if the calculation overflows
    /// @param _x   value 1
    /// @param _y   value 2
    /// @return sum
    function safeAdd(uint256 _x, uint256 _y) internal pure returns (uint256) {
        uint256 z = _x + _y;
        require(z >= _x);
        return z;
    }

    /// @dev returns the difference of _x minus _y, asserts if the subtraction results in a negative number
    /// @param _x   minuend
    /// @param _y   subtrahend
    /// @return difference
    function safeSub(uint256 _x, uint256 _y) internal pure returns (uint256) {
        require(_x >= _y);
        return _x - _y;
    }

    /// @dev returns the product of multiplying _x by _y, asserts if the calculation overflows
    /// @param _x   factor 1
    /// @param _y   factor 2
    /// @return product
    function safeMul(uint256 _x, uint256 _y) internal pure returns (uint256) {
        uint256 z = _x * _y;
        require((_x == 0) || ((z / _x) == _y));
        return z;
    }

    function safeDiv(uint256 _x, uint256 _y) internal pure returns (uint256) {
        return _x / _y;
    }

    function ceilDiv(uint256 _x, uint256 _y) internal pure returns (uint256) {
        return ((_x + _y) - 1) / _y;
    }
}

contract XDCToken is SafeMath {
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    mapping(address => uint256) internal balances;
    address public owner;
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    uint256 public tmp;
    mapping(address => mapping(address => uint256)) internal allowed;

    constructor() public {
        //Begin of assumptions
        VeriSol.AssumesEndingOfFunction(totalSupply==100000000000000000000000000);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(totalSupply==100000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of invariants
        uint256 initialSupply = 100000000;
        owner = msg.sender;
        tmp = uint256(decimals);
        totalSupply = initialSupply * (10 ** tmp);
        balances[owner] = totalSupply;
        name = "XueDaoCoin";
        symbol = "XDC";
    }

    /// @param _owner The address from which the balance will be retrieved
    ///  @return The balance
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    /// @notice send `_value` token to `_to` from `msg.sender`
    ///  @param _to The address of the recipient
    ///  @param _value The amount of token to be transferred
    ///  @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) public returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(totalSupply==100000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(_value>0);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==100000000000000000000000000);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(_to!=address(0));
        VeriSol.Requires(balances[msg.sender]>0);
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires(totalSupply==100000000000000000000000000);
        VeriSol.Requires((owner) != _to);
        VeriSol.Requires(_value <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires(_value >= (uint256(decimals)));
        VeriSol.Requires(_value > (uint256(decimals)));
        VeriSol.Requires(_value != (uint256(decimals)));
        VeriSol.Requires(_value <= (balances[msg.sender]));
        VeriSol.Requires(_value <= (totalSupply));
        VeriSol.Requires(msg.sender != _to);
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (balances[_to]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) > (balances[_to]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) != (balances[_to]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (balances[msg.sender]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= (totalSupply));
        VeriSol.Requires((balances[_to]) != (uint256(decimals)));
        VeriSol.Requires((balances[_to]) != (balances[msg.sender]));
        VeriSol.Requires((balances[_to]) <= (totalSupply));
        VeriSol.Requires((balances[_to]) < (totalSupply));
        VeriSol.Requires((balances[_to]) != (totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) < (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) != (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) <= (totalSupply));
        VeriSol.Requires((uint256(decimals)) < (totalSupply));
        VeriSol.Requires((uint256(decimals)) != (totalSupply));
        VeriSol.Requires((balances[msg.sender]) <= (totalSupply));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==100000000000000000000000000);
        VeriSol.Ensures(balances[_to]>0);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==100000000000000000000000000);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(totalSupply >= _value);
        VeriSol.Ensures(totalSupply >= balances[_to]);
        VeriSol.Ensures(totalSupply >= balances[msg.sender]);
        VeriSol.Ensures(totalSupply > balances[msg.sender]);
        VeriSol.Ensures(totalSupply != balances[msg.sender]);
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(balances[_to]));
        VeriSol.Ensures(totalSupply > VeriSol.Old(balances[_to]));
        VeriSol.Ensures(totalSupply != VeriSol.Old(balances[_to]));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(_value <= balances[_to]);
        VeriSol.Ensures(_value != balances[msg.sender]);
        VeriSol.Ensures(_value <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(_value >= decimals);
        VeriSol.Ensures(_value > decimals);
        VeriSol.Ensures(_value != decimals);
        VeriSol.Ensures(balances[_to] != balances[msg.sender]);
        VeriSol.Ensures(balances[_to] <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[_to] >= VeriSol.Old(balances[_to]));
        VeriSol.Ensures(balances[_to] > VeriSol.Old(balances[_to]));
        VeriSol.Ensures(balances[_to] != VeriSol.Old(balances[_to]));
        VeriSol.Ensures(balances[_to] <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(balances[_to] >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(balances[_to] > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(balances[_to] != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(balances[_to] <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(balances[_to] >= decimals);
        VeriSol.Ensures(balances[_to] > decimals);
        VeriSol.Ensures(balances[_to] != decimals);
        VeriSol.Ensures(owner != _to);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.SumMapping(balances));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.SumMapping(balances));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(totalSupply));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(totalSupply));
        VeriSol.Ensures(balances[msg.sender] != decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) > decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != decimals);
        VeriSol.Ensures(VeriSol.Old(balances[_to]) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(balances[_to]) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(balances[_to]) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(balances[_to]) != decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) == decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= decimals);
        VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) >= decimals);
        VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) > decimals);
        VeriSol.Ensures(VeriSol.Old(balances[msg.sender]) != decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) != decimals);
        VeriSol.Ensures(totalSupply==100000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of invariants
        require(_value > 0);
        require(balances[msg.sender] >= _value);
        require((balances[_to] + _value) > balances[_to]);
        balances[msg.sender] = safeSub(balances[msg.sender], _value);
        balances[_to] = safeAdd(balances[_to], _value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    ///  @param _from The address of the sender
    ///  @param _to The address of the recipient
    ///  @param _value The amount of token to be transferred
    ///  @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(totalSupply==100000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= (totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (totalSupply));
        VeriSol.Requires((uint256(decimals)) < (totalSupply));
        VeriSol.Requires((uint256(decimals)) != (totalSupply));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) > decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) == decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) != decimals);
        VeriSol.Ensures(totalSupply==100000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of invariants
        require(balances[_from] >= _value);
        require((balances[_to] + _value) >= balances[_to]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = safeSub(balances[_from], _value);
        balances[_to] = safeAdd(balances[_to], _value);
        allowed[_from][msg.sender] = safeSub(allowed[_from][msg.sender], _value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    /// @notice `msg.sender` approves `_spender` to spend `_value` tokens
    ///  @param _spender The address of the account able to transfer the tokens
    ///  @param _value The amount of tokens to be approved for transfer
    ///  @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value) public returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(totalSupply==100000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= (totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (totalSupply));
        VeriSol.Requires((uint256(decimals)) < (totalSupply));
        VeriSol.Requires((uint256(decimals)) != (totalSupply));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) > decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) == decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) >= decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(totalSupply) != decimals);
        VeriSol.Ensures(totalSupply==100000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==100000000000000000000000000);
        //End of invariants
        require(balances[msg.sender] >= _value);
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /// @param _owner The address of the account owning tokens
    ///  @param _spender The address of the account able to transfer the tokens
    ///  @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function () external {
        revert();
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(totalSupply>0);
        VeriSol.ContractInvariant(totalSupply==100000000000000000000000000);
        VeriSol.ContractInvariant(owner!=address(0));
        VeriSol.ContractInvariant(decimals>0);
        VeriSol.ContractInvariant(decimals==18);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)==100000000000000000000000000);
        VeriSol.ContractInvariant(totalSupply >= decimals);
        VeriSol.ContractInvariant(totalSupply > decimals);
        VeriSol.ContractInvariant(totalSupply != decimals);
        VeriSol.ContractInvariant(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals <= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals < VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals != VeriSol.SumMapping(balances));
    }
}