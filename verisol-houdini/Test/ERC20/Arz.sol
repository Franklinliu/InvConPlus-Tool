pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./SafeMath.sol";
import "./VeriSolContracts.sol";

contract Arzdigital {
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    /// @notice send `_value` token to `_to` from `msg.sender`
    ///  @param _to The address of the recipient
    ///  @param _value The amount of token to be transferred
    ///  @return Whether the transfer was successful or not
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {}
}

contract StandardToken is Arzdigital {
    string public name;
    uint8 public decimals;
    string public symbol;
    string public version = "H1.0";
    address test;
    mapping(address => uint256) internal balances;
    mapping(address => mapping(address => uint256)) internal allowed;
    uint256 public _totalSupply;

    function contractInvariant() private view {
        VeriSol.ContractInvariant(_totalSupply == VeriSol.SumMapping(balances));
    }

    constructor() public {
        VeriSol.AssumesBeginningOfFunction(_totalSupply == 0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply == VeriSol.SumMapping(balances));

        VeriSol.Requires(VeriSol.SumMapping(balances) == 0);
        VeriSol.Ensures(_totalSupply == 820000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == 820000000);
        VeriSol.Ensures(_totalSupply == VeriSol.SumMapping(balances));

        

        balances[msg.sender] = 820000000;
        _totalSupply = 820000000;
        name = "AmainCoin";
        decimals = 1;
        symbol = "AMN";

        VeriSol.AssumesEndingOfFunction(_totalSupply == 820000000);
        VeriSol.AssumesEndingOfFunction(_totalSupply == VeriSol.SumMapping(balances));

    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        VeriSol.Requires(_totalSupply == 820000000);
        VeriSol.Requires(_totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(_totalSupply == 820000000);
        VeriSol.Ensures(_totalSupply == VeriSol.SumMapping(balances));
        return true;
    }
}