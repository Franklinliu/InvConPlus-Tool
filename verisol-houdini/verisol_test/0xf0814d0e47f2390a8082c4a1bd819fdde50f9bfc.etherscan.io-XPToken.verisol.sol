pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

/// ubmitted for verification at Etherscan.io on 2020-05-01
library SafeMath {
    /// @dev Multiplies two numbers, throws on overflow.
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require((c / a) == b);
        return c;
    }

    /// @dev Integer division of two numbers, truncating the quotient.
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

    /// @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        return a - b;
    }

    /// @dev Adds two numbers, throws on overflow.
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }
}

contract Ownable {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    address public owner;
    bool public stopped = false;

    /// @dev Throws if called by any account other than the owner.
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /// Validate if ICO/Contract running
    modifier isRunning() {
        require(!stopped);
        _;
    }

    /// @dev The Ownable constructor sets the original `owner` of the contract to the sender
    /// account.
    constructor() public {
        owner = msg.sender;
    }

    /// @dev Allows the current owner to transfer control of the contract to a newOwner.
    /// @param newOwner The address to transfer ownership to.
    function transferOwnership(address newOwner) public onlyOwner() {
        //Begin of invariants
        VeriSol.Requires(stopped==false);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(newOwner!=address(0));
        VeriSol.Requires((owner) == msg.sender);
        VeriSol.Requires((owner) != newOwner);
        VeriSol.Requires(msg.sender != newOwner);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(VeriSol.Old(owner) != owner);
        VeriSol.Ensures(owner != msg.sender);
        VeriSol.Ensures(owner == newOwner);
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        //End of invariants
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    /// Stop ICO/Contract
    function stop() public onlyOwner() {
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        //End of invariants
        stopped = true;
    }

    /// Start ICO/Contract
    function start() public onlyOwner() {
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        //End of invariants
        stopped = false;
    }

    /// Remove contract code/data from blockchain
    function close() public onlyOwner() {
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        //End of invariants
    }
}

contract ERC20Basic {
    event Transfer(address indexed from, address indexed to, uint256 value);

    function totalSupply() public view returns (uint256);

    function balanceOf(address who) public view returns (uint256);

    function transfer(address to, uint256 value) public returns (bool);
}

contract BasicToken is ERC20Basic {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;
    uint256 public totalSupply_;

    /// @dev total number of tokens in existence
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    /// @dev transfer token for a specified address
    /// @param _to The address to transfer to.
    /// @param _value The amount to be transferred.
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /// @dev Gets the balance of the specified address.
    /// @param _owner The address to query the the balance of.
    /// @return An uint256 representing the amount owned by the passed address.
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    /// @dev Internal function that mints an amount of the token and assigns it to
    /// an account. This encapsulates the modification of balances such that the
    /// proper events are emitted.
    /// @param account The account that will receive the created tokens.
    /// @param value The amount that will be created.
    function _mint(address account, uint256 value) internal {
        require(account != address(0));
        totalSupply_ = totalSupply_.add(value);
        balances[account] = balances[account].add(value);
        emit Transfer(address(0), account, value);
    }
}

contract BurnableToken is BasicToken, Ownable {
    event Burn(address indexed burner, uint256 value);

    /// @dev Burns a specific amount of tokens.
    /// @param _value The amount of token to be burned.
    function burn(uint256 _value) public onlyOwner() {
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        require(_value <= balances[msg.sender]);
        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
        emit Burn(burner, _value);
    }
}

contract ERC20 is ERC20Basic {
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function allowance(address owner, address spender) public view returns (uint256);

    function transferFrom(address from, address to, uint256 value) public returns (bool);

    function approve(address spender, uint256 value) public returns (bool);
}

library SafeERC20 {
    function safeTransfer(ERC20Basic token, address to, uint256 value) internal {
        require(token.transfer(to, value));
    }

    function safeTransferFrom(ERC20 token, address from, address to, uint256 value) internal {
        require(token.transferFrom(from, to, value));
    }

    function safeApprove(ERC20 token, address spender, uint256 value) internal {
        require(token.approve(spender, value));
    }
}

contract StandardToken is ERC20, BasicToken {
    mapping(address => mapping(address => uint256)) internal allowed;

    /// @dev Transfer tokens from one address to another
    /// @param _from address The address which you want to send tokens from
    /// @param _to address The address which you want to transfer to
    /// @param _value uint256 the amount of tokens to be transferred
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    /// @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
    ///      * Beware that changing an allowance with this method brings the risk that someone may use both the old
    /// and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
    /// race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
    /// https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    /// @param _spender The address which will spend the funds.
    /// @param _value The amount of tokens to be spent.
    function approve(address _spender, uint256 _value) public returns (bool) {
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /// @dev Function to check the amount of tokens that an owner allowed to a spender.
    /// @param _owner address The address which owns the funds.
    /// @param _spender address The address which will spend the funds.
    /// @return A uint256 specifying the amount of tokens still available for the spender.
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

    /// @dev Increase the amount of tokens that an owner allowed to a spender.
    ///      * approve should be called when allowed[_spender] == 0. To increment
    /// allowed value is better to use this function to avoid 2 calls (and wait until
    /// the first transaction is mined)
    /// From MonolithDAO Token.sol
    /// @param _spender The address which will spend the funds.
    /// @param _addedValue The amount of tokens to increase the allowance by.
    function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    /// @dev Decrease the amount of tokens that an owner allowed to a spender.
    ///      * approve should be called when allowed[_spender] == 0. To decrement
    /// allowed value is better to use this function to avoid 2 calls (and wait until
    /// the first transaction is mined)
    /// From MonolithDAO Token.sol
    /// @param _spender The address which will spend the funds.
    /// @param _subtractedValue The amount of tokens to decrease the allowance by.
    function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        uint oldValue = allowed[msg.sender][_spender];
        if (_subtractedValue > oldValue) {
            allowed[msg.sender][_spender] = 0;
        } else {
            allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
        }
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }
}

/// @title ERC20 Mintable
/// @dev ERC20 minting logic
contract ERC20Mintable is BasicToken, Ownable {
    /// @dev Function to mint tokens
    /// @param to The address that will receive the minted tokens.
    /// @param value The amount of tokens to mint.
    /// @return A boolean that indicates if the operation was successful.
    function mint(address to, uint256 value) public onlyOwner() returns (bool) {
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        _mint(to, value);
        return true;
    }
}

contract XPToken is StandardToken, BurnableToken, ERC20Mintable {
    using SafeMath for uint;

    string public constant symbol = "XPT";
    string public constant name = "XPToken.io";
    uint8 public constant decimals = 8;
    uint256 public constant decimalFactor = 10 ** uint256(decimals);
    uint256 public constant INITIAL_SUPPLY = 200000000 * decimalFactor;

    constructor() public {
        totalSupply_ = INITIAL_SUPPLY;
        preSale(msg.sender, totalSupply_);
    }

    function preSale(address _address, uint _amount) internal returns (bool) {
        balances[_address] = _amount;
        emit Transfer(address(0x0), _address, _amount);
    }

    function transfer(address _to, uint256 _value) public isRunning() returns (bool) {
        //Begin of invariants
        VeriSol.Requires(stopped==false);
        VeriSol.Requires(totalSupply_>0);
        VeriSol.Requires(totalSupply_==20000000000000000);
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==20000000000000000);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(_value>0);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(_to!=address(0));
        VeriSol.Requires((totalSupply_) == (VeriSol.SumMapping(balances)));
        VeriSol.Requires((totalSupply_) >= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((totalSupply_) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((totalSupply_) >= _value);
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= _value);
        VeriSol.Requires((owner) != _to);
        VeriSol.Requires(msg.sender != _to);
        VeriSol.Ensures(totalSupply_>0);
        VeriSol.Ensures(totalSupply_==20000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==20000000000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply_ == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply_ >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply_ <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply_ >= _value);
        VeriSol.Ensures(VeriSol.Old(totalSupply_) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(totalSupply_) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(totalSupply_) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= _value);
        VeriSol.Ensures(owner != _to);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Ensures(owner!=address(0));
        //End of invariants
        BasicToken.transfer(_to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public isRunning() returns (bool) {
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(stopped==false);
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ >= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(totalSupply_ <= VeriSol.Old(totalSupply_));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(totalSupply_ == VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        StandardToken.transferFrom(_from, _to, _value);
        return true;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(totalSupply_>0);
        VeriSol.ContractInvariant(totalSupply_==20000000000000000);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)==20000000000000000);
        VeriSol.ContractInvariant(owner!=address(0));
        VeriSol.ContractInvariant(stopped==false);
        VeriSol.ContractInvariant(totalSupply_ == VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(totalSupply_ >= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(totalSupply_ <= VeriSol.SumMapping(balances));
    }
}