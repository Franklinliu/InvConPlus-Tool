pragma solidity ^0.5.0;

import "./IERC20.sol";
import "./SafeMath.sol";
import "./VeriSolContracts.sol";

contract Arzdigital {
    /// @return total amount of tokens
    function totalSupply() public view returns (uint256 supply) {}

    /// @param _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address _owner) public view returns (uint256 balance) {}

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {}

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {}

    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {}

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

contract StandardToken is Arzdigital {
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        //Default assumes totalSupply cant be over max (256  1).
        //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesnt wrap.
        //Replace the if with this one instead.
        //if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
        // VeriSol.Ensures(balances == VeriSol.Old(balances));
        // VeriSol.Ensures(allowed == VeriSol.Old(allowed));


        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply)); //Verified successful
        VeriSol.Requires(_totalSupply == VeriSol.SumMapping(balances)); //May not hold
        VeriSol.Ensures(_to == VeriSol.Old(_to)); //Verified Successful
		VeriSol.Ensures(_value == VeriSol.Old(_value)); //Verified 
		VeriSol.Ensures(msg.sender == VeriSol.Old(msg.sender)); //Verified
		// VeriSol.Ensures(msg.value == VeriSol.Old(msg.value)); //TypeError
		// VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(balances)); //May not hold
		VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances)); //Verified
		// VeriSol.Requires(_value <= balances[msg.sender]); //Corral found counter example
		// VeriSol.Ensures(_value < VeriSol.Old(_totalSupply)); //Corral found counter example
		// StandardToken::transfer (this = address!0, msg.sender = address!2, msg.value = 27, _to = address!17, _value = 820000000)
		// VeriSol.Requires(_value < _totalSupply); //Corral found counter example
		// Token::Constructor (this = address!0, msg.sender = address!17, msg.value = 24)
        VeriSol.Ensures(VeriSol.Old(balances[msg.sender] + balances[_to]) == balances[msg.sender] + balances[_to]); //Verified
        // VeriSol.Ensures(VeriSol.Old(balances[msg.sender] + _value) == balances[_to]); //Corral found counter example
        // StandardToken::transfer (this = address!0, msg.sender = address!2, msg.value = 27, _to = address!4, _value = 6892)
        // VeriSol.Ensures(balances[_to] - _value == VeriSol.Old(balances[_to])); //Corral found counter example
        // StandardToken::transfer  (this = address!0, msg.sender = address!3, msg.value = 27, _to = address!3, _value = 9911)
		
		
        
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        //same as above. Replace this line with the following if you want to protect against wrapping uints.
        //if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
        if (
            balances[_from] >= _value &&
            allowed[_from][msg.sender] >= _value &&
            _value > 0
        ) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    uint256 public _totalSupply;
}

//name this contract whatever youd like
contract Token is StandardToken {
    function() external {
        //if ether is sent to this address, send it back.
        revert();
    }

    /* Public variables of the token */
    /*
 NOTE:
 The following variables are OPTIONAL vanities. One does not have to include them.
 They allow one to customise the token contract & in no way influences the core functionality.
 Some wallets/interfaces might not even bother to look at this information.
 */
    string public name; //fancy name: eg Simon Bucks
    uint8 public decimals; //How many decimals to show. ie. There could 1000 base units with 3 decimals. Meaning 0.980 SBX = 980 base units. Its like comparing 1 wei to 1 ether.
    string public symbol; //An identifier: eg SBX
    string public version = "H1.0"; //human 0.1 standard. Just an arbitrary versioning scheme.

    //
    // ???? ???? ??? ???????? ??? ?? ????? ????
    //
    //make sure this function name matches the contract name above. So if youre token is called TutorialToken, make sure the //contract name above is also TutorialToken instead of ERC20Token
    constructor() public {
        balances[msg.sender] = 820000000; // ???? ??????? ????? ??? ?????? ???? -???? ???? ???? ???? 100000
        _totalSupply = 820000000; // ???? ????
        name = "AmainCoin"; // ??? ????
        decimals = 1; // ?????
        symbol = "AMN"; // ???? ????
    }

    /* Approves and then calls the receiving contract */
    function approveAndCall(
        address _spender,
        uint256 _value,
        bytes memory _extraData
    ) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesnt have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        // bytes memory data = abi.encodeWithSignature(
        //     "receiveApproval(address,uint256,address,bytes)",
        //     msg.sender,
        //     _value,
        //     address(this),
        //     _extraData
        // );
        // (bool success, bytes memory returnData) = _spender.call(data);
        // if (!success) {
        //     revert();
        // }

        return true;
    }
}
