pragma solidity ^0.5.7;

import "./ERC20Standard.sol";

contract XTToken is ERC20Standard {
    constructor() public {
        totalSupply = 1000000000000000000000000000;
        name = "ExtStock Token";
        decimals = 18;
        symbol = "XT";
        version = "1.0";
        balances[msg.sender] = totalSupply;
    }
}
