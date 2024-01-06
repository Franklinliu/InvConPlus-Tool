pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

contract Token {
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    string public name = "Asia Tycoon";
    string public symbol = "ATC";
    uint256 public totalSupply;
    uint8 public decimals = 6;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) >= _value);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) >= balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) == decimals);
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(balanceOf[_to] >= VeriSol.Old(balanceOf[_to]));
        //End of invariants
        require(balanceOf[msg.sender] >= _value);
        assert(true);
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(decimals == 6);
        VeriSol.ContractInvariant(totalSupply == VeriSol.SumMapping(balanceOf));
    }
}