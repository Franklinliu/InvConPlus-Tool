pragma solidity ^0.4.4;

contract Arzdigital {
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    /// @return total amount of tokens
    function totalSupply() public view returns (uint256 supply) {}

    /// @return The balance
    function balanceOf(address _owner) public view returns (uint256 balance) {}

    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) public returns (bool success) {}

    /// @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {}

    /// @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value) public returns (bool success) {}

    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {}
}

contract StandardToken is Arzdigital {
    mapping(address => uint256) internal balances;
    mapping(address => mapping(address => uint256)) internal allowed;
    uint256 public totalSupply;

    function transfer(address _to, uint256 _value) public returns (bool success) {
        if ((balances[msg.sender] >= _value) && (_value > 0)) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (((balances[_from] >= _value) && (allowed[_from][msg.sender] >= _value)) && (_value > 0)) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}

contract Token is StandardToken {
    string public name;
    uint8 public decimals;
    string public symbol;
    string public version = "H1.0";

    modifier verisol_Token() {
        _;
    }

    modifier verisol_approveAndCall(address _spender, uint256 _value, bytes _extraData) {
        _;
    }

    function () public verisol_() {
        throw;
    }

    function Token() public verisol_Token() {
        balances[msg.sender] = 820000000;
        totalSupply = 820000000;
        name = "AmainCoin";
        decimals = 1;
        symbol = "AMN";
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public verisol_approveAndCall(_spender,_value,_extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        if (!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) {
            throw;
        }
        return true;
    }
}