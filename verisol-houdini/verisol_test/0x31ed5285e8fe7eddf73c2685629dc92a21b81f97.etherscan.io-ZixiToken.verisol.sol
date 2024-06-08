pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

/// @title SafeMath
/// @dev Unsigned math operations with safety checks that revert on error
library SafeMath {
    /// @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;
        return c;
    }

    /// @dev Adds two unsigned integers, reverts on overflow.
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }
}

/// @title Ownable
/// @dev The Ownable contract has an owner address, and provides basic authorization control
/// functions, this simplifies the implementation of "user permissions".
contract Ownable {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    address public _owner;

    /// @dev Throws if called by any account other than the owner.
    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    /// @dev The Ownable constructor sets the original `owner` of the contract to the sender
    /// account.
    constructor() internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /// @return the address of the owner.
    function owner() public view returns (address) {
        return _owner;
    }

    /// @return true if `msg.sender` is the owner of the contract.
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /// @dev Allows the current owner to transfer control of the contract to a newOwner.
    /// @param newOwner The address to transfer ownership to.
    function transferOwnership(address newOwner) public onlyOwner() {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner == msg.sender);
        //End of invariants
        _transferOwnership(newOwner);
    }

    /// @dev Transfers control of the contract to a newOwner.
    /// @param newOwner The address to transfer ownership to.
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

/// @title Pausable
/// @dev Base contract which allows children to implement an emergency stop mechanism.
contract Pausable is Ownable {
    event Paused(address account);

    event Unpaused(address account);

    bool public _paused;

    /// @dev Modifier to make a function callable only when the contract is not paused.
    modifier whenNotPaused() {
        require(!_paused);
        _;
    }

    /// @dev Modifier to make a function callable only when the contract is paused.
    modifier whenPaused() {
        require(_paused);
        _;
    }

    constructor() internal {
        _paused = false;
    }

    /// @return true if the contract is paused, false otherwise.
    function paused() public view returns (bool) {
        return _paused;
    }

    /// @dev called by the owner to pause, triggers stopped state
    function pause() public onlyOwner() whenNotPaused() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(_paused==false);
        //End of invariants
        _paused = true;
        emit Paused(msg.sender);
    }

    /// @dev called by the owner to unpause, returns to normal state
    function unpause() public onlyOwner() whenPaused() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(_paused==false);
        //End of invariants
        _paused = false;
        emit Unpaused(msg.sender);
    }
}

/// @title ERC20 interface
/// @dev see https://eips.ethereum.org/EIPS/eip-20
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);
}

/// @title Standard ERC20 token
///  * @dev Implementation of the basic standard token.
/// https://eips.ethereum.org/EIPS/eip-20
/// Originally based on code by FirstBlood:
/// https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
///  * This implementation emits additional Approval events, allowing applications to reconstruct the allowance status for
/// all accounts just by listening to said events. Note that this isn't required by the specification, and other
/// compliant implementations may not do it.
contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping(address => uint256) public _balances;
    mapping(address => mapping(address => uint256)) private _allowed;
    uint256 public _totalSupply;

    /// @dev Total number of tokens in existence
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /// @dev Gets the balance of the specified address.
    /// @param owner The address to query the balance of.
    /// @return A uint256 representing the amount owned by the passed address.
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    /// @dev Function to check the amount of tokens that an owner allowed to a spender.
    /// @param owner address The address which owns the funds.
    /// @param spender address The address which will spend the funds.
    /// @return A uint256 specifying the amount of tokens still available for the spender.
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }

    /// @dev Transfer token to a specified address
    /// @param to The address to transfer to.
    /// @param value The amount to be transferred.
    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    /// @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
    /// Beware that changing an allowance with this method brings the risk that someone may use both the old
    /// and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
    /// race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
    /// https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    /// @param spender The address which will spend the funds.
    /// @param value The amount of tokens to be spent.
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    /// @dev Transfer tokens from one address to another.
    /// Note that while this function emits an Approval event, this is not required as per the specification,
    /// and other compliant implementations may not emit the event.
    /// @param from address The address which you want to send tokens from
    /// @param to address The address which you want to transfer to
    /// @param value uint256 the amount of tokens to be transferred
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        _transfer(from, to, value);
        _approve(from, msg.sender, _allowed[from][msg.sender].sub(value));
        return true;
    }

    /// @dev Increase the amount of tokens that an owner allowed to a spender.
    /// approve should be called when _allowed[msg.sender][spender] == 0. To increment
    /// allowed value is better to use this function to avoid 2 calls (and wait until
    /// the first transaction is mined)
    /// From MonolithDAO Token.sol
    /// Emits an Approval event.
    /// @param spender The address which will spend the funds.
    /// @param addedValue The amount of tokens to increase the allowance by.
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        //End of invariants
        _approve(msg.sender, spender, _allowed[msg.sender][spender].add(addedValue));
        return true;
    }

    /// @dev Decrease the amount of tokens that an owner allowed to a spender.
    /// approve should be called when _allowed[msg.sender][spender] == 0. To decrement
    /// allowed value is better to use this function to avoid 2 calls (and wait until
    /// the first transaction is mined)
    /// From MonolithDAO Token.sol
    /// Emits an Approval event.
    /// @param spender The address which will spend the funds.
    /// @param subtractedValue The amount of tokens to decrease the allowance by.
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        //End of invariants
        _approve(msg.sender, spender, _allowed[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    /// @dev Transfer token for a specified addresses
    /// @param from The address to transfer from.
    /// @param to The address to transfer to.
    /// @param value The amount to be transferred.
    function _transfer(address from, address to, uint256 value) internal {
        require(to != address(0));
        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(from, to, value);
    }

    /// @dev Internal function that mints an amount of the token and assigns it to
    /// an account. This encapsulates the modification of balances such that the
    /// proper events are emitted.
    /// @param account The account that will receive the created tokens.
    /// @param value The amount that will be created.
    function _mint(address account, uint256 value) internal {
        require(account != address(0));
        _totalSupply = _totalSupply.add(value);
        _balances[account] = _balances[account].add(value);
        emit Transfer(address(0), account, value);
    }

    /// @dev Internal function that burns an amount of the token of a given
    /// account.
    /// @param account The account whose tokens will be burnt.
    /// @param value The amount that will be burnt.
    function _burn(address account, uint256 value) internal {
        require(account != address(0));
        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(0), value);
    }

    /// @dev Approve an address to spend another addresses' tokens.
    /// @param owner The address that owns the tokens.
    /// @param spender The address that will spend the tokens.
    /// @param value The number of tokens that can be spent.
    function _approve(address owner, address spender, uint256 value) internal {
        require(spender != address(0));
        require(owner != address(0));
        _allowed[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /// @dev Internal function that burns an amount of the token of a given
    /// account, deducting from the sender's allowance for said account. Uses the
    /// internal burn function.
    /// Emits an Approval event (reflecting the reduced allowance).
    /// @param account The account whose tokens will be burnt.
    /// @param value The amount that will be burnt.
    function _burnFrom(address account, uint256 value) internal {
        _burn(account, value);
        _approve(account, msg.sender, _allowed[account][msg.sender].sub(value));
    }
}

contract UpgradedStandardToken is ERC20 {
    uint public _totalSupply;

    function transferByLegacy(address from, address to, uint value) public returns (bool);

    function transferFromByLegacy(address sender, address from, address spender, uint value) public returns (bool);

    function approveByLegacy(address from, address spender, uint value) public returns (bool);

    function increaseApprovalByLegacy(address from, address spender, uint addedValue) public returns (bool);

    function decreaseApprovalByLegacy(address from, address spender, uint subtractedValue) public returns (bool);
}

contract ZixiToken is Pausable, ERC20 {
    event Issue(uint amount);

    event Redeem(uint amount);

    event Deprecate(address newAddress);

    address public upgradedAddress;
    bool public deprecated;
    string public name;
    string public symbol;
    uint8 public decimals;

    constructor(uint _initialSupply, string memory _name, string memory _symbol, uint8 _decimals) public {
        //Begin of assumptions
        VeriSol.AssumesEndingOfFunction(decimals>0);
        VeriSol.AssumesEndingOfFunction(decimals==6);
        VeriSol.AssumesEndingOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesEndingOfFunction(deprecated==false);
        VeriSol.AssumesEndingOfFunction(_paused==false);
        VeriSol.AssumesEndingOfFunction(_totalSupply>0);
        VeriSol.AssumesEndingOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesEndingOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesEndingOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesEndingOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesEndingOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesEndingOfFunction(decimals < _totalSupply);
        VeriSol.AssumesEndingOfFunction(decimals != _totalSupply);
        VeriSol.AssumesEndingOfFunction(_owner != upgradedAddress);
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(_owner != upgradedAddress);
        //End of invariants
        _mint(owner(), _initialSupply);
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        deprecated = false;
        emit Issue(_initialSupply);
    }

    function transfer(address _to, uint _value) public whenNotPaused() returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_paused==false);
        VeriSol.Requires(_value>0);
        VeriSol.Requires(VeriSol.SumMapping(_balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==6);
        VeriSol.Requires(upgradedAddress==address(0));
        VeriSol.Requires(deprecated==false);
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(_to!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==500000000000);
        VeriSol.Requires(_value <= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value < (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value != (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value >= (uint256(decimals)));
        VeriSol.Requires(_value > (uint256(decimals)));
        VeriSol.Requires(_value != (uint256(decimals)));
        VeriSol.Requires(_value <= (_totalSupply));
        VeriSol.Requires(_value < (_totalSupply));
        VeriSol.Requires(_value != (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) < (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (_totalSupply));
        VeriSol.Requires((upgradedAddress) != (_owner));
        VeriSol.Requires((upgradedAddress) != _to);
        VeriSol.Requires((upgradedAddress) != msg.sender);
        VeriSol.Requires((_owner) != _to);
        VeriSol.Requires(_to != msg.sender);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _value);
        VeriSol.Ensures(decimals < _value);
        VeriSol.Ensures(decimals != _value);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(_owner != VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner != _to);
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(upgradedAddress != VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress != _to);
        VeriSol.Ensures(upgradedAddress != msg.sender);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_value <= _totalSupply);
        VeriSol.Ensures(_value < _totalSupply);
        VeriSol.Ensures(_value != _totalSupply);
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
        } else {
            return ERC20.transfer(_to, _value);
        }
    }

    function transferFrom(address _from, address _to, uint _value) public whenNotPaused() returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_value>0);
        VeriSol.Requires(_paused==false);
        VeriSol.Requires(VeriSol.SumMapping(_balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==6);
        VeriSol.Requires(upgradedAddress==address(0));
        VeriSol.Requires(deprecated==false);
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(_to!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(_from!=address(0));
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==500000000000);
        VeriSol.Requires(_value <= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value < (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value != (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value >= (uint256(decimals)));
        VeriSol.Requires(_value > (uint256(decimals)));
        VeriSol.Requires(_value != (uint256(decimals)));
        VeriSol.Requires(_value <= (_totalSupply));
        VeriSol.Requires(_value < (_totalSupply));
        VeriSol.Requires(_value != (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) < (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (_totalSupply));
        VeriSol.Requires((upgradedAddress) != (_owner));
        VeriSol.Requires((upgradedAddress) != _to);
        VeriSol.Requires((upgradedAddress) != msg.sender);
        VeriSol.Requires((upgradedAddress) != _from);
        VeriSol.Requires((_owner) != _to);
        VeriSol.Requires((_owner) != msg.sender);
        VeriSol.Requires((_owner) != _from);
        VeriSol.Requires(_to != msg.sender);
        VeriSol.Requires(_to != _from);
        VeriSol.Requires(msg.sender != _from);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _value);
        VeriSol.Ensures(decimals < _value);
        VeriSol.Ensures(decimals != _value);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(_owner != VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner != _to);
        VeriSol.Ensures(_owner != msg.sender);
        VeriSol.Ensures(_owner != _from);
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(upgradedAddress != VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress != _to);
        VeriSol.Ensures(upgradedAddress != msg.sender);
        VeriSol.Ensures(upgradedAddress != _from);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_value <= _totalSupply);
        VeriSol.Ensures(_value < _totalSupply);
        VeriSol.Ensures(_value != _totalSupply);
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferFromByLegacy(msg.sender, _from, _to, _value);
        } else {
            return ERC20.transferFrom(_from, _to, _value);
        }
    }

    function balanceOf(address who) public view returns (uint) {
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).balanceOf(who);
        } else {
            return ERC20.balanceOf(who);
        }
    }

    function oldBalanceOf(address who) public view returns (uint) {
        if (deprecated) {
            return ERC20.balanceOf(who);
        }
    }

    function approve(address _spender, uint _value) public whenNotPaused() returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_paused==false);
        VeriSol.Requires(_value>0);
        VeriSol.Requires(_value==10000000000000000);
        VeriSol.Requires(VeriSol.SumMapping(_balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==6);
        VeriSol.Requires(upgradedAddress==address(0));
        VeriSol.Requires(deprecated==false);
        VeriSol.Requires(_spender!=address(0));
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==500000000000);
        VeriSol.Requires(_value >= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value > (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value != (VeriSol.SumMapping(_balances)));
        VeriSol.Requires(_value >= (uint256(decimals)));
        VeriSol.Requires(_value > (uint256(decimals)));
        VeriSol.Requires(_value != (uint256(decimals)));
        VeriSol.Requires(_value >= (_totalSupply));
        VeriSol.Requires(_value > (_totalSupply));
        VeriSol.Requires(_value != (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) < (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (_totalSupply));
        VeriSol.Requires((upgradedAddress) != _spender);
        VeriSol.Requires((upgradedAddress) != (_owner));
        VeriSol.Requires((upgradedAddress) != msg.sender);
        VeriSol.Requires(_spender != (_owner));
        VeriSol.Requires(_spender != msg.sender);
        VeriSol.Requires((_owner) != msg.sender);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _value);
        VeriSol.Ensures(decimals < _value);
        VeriSol.Ensures(decimals != _value);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(_owner != VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(_owner != _spender);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner != msg.sender);
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(upgradedAddress != _spender);
        VeriSol.Ensures(upgradedAddress != VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress != msg.sender);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) < _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != _value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_value >= _totalSupply);
        VeriSol.Ensures(_value > _totalSupply);
        VeriSol.Ensures(_value != _totalSupply);
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).approveByLegacy(msg.sender, _spender, _value);
        } else {
            return ERC20.approve(_spender, _value);
        }
    }

    function increaseApproval(address _spender, uint _addedValue) public whenNotPaused() returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).increaseApprovalByLegacy(msg.sender, _spender, _addedValue);
        } else {
            return ERC20.increaseAllowance(_spender, _addedValue);
        }
    }

    function decreaseApproval(address _spender, uint _subtractedValue) public whenNotPaused() returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).decreaseApprovalByLegacy(msg.sender, _spender, _subtractedValue);
        } else {
            return ERC20.decreaseAllowance(_spender, _subtractedValue);
        }
    }

    function allowance(address _owner, address _spender) public view returns (uint remaining) {
        if (deprecated) {
            return IERC20(upgradedAddress).allowance(_owner, _spender);
        } else {
            return ERC20.allowance(_owner, _spender);
        }
    }

    function deprecate(address _upgradedAddress) public onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        require(_upgradedAddress != address(0));
        deprecated = true;
        upgradedAddress = _upgradedAddress;
        emit Deprecate(_upgradedAddress);
    }

    function totalSupply() public view returns (uint) {
        if (deprecated) {
            return IERC20(upgradedAddress).totalSupply();
        } else {
            return ERC20.totalSupply();
        }
    }

    function issue(uint amount) public onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_paused==false);
        VeriSol.Requires(VeriSol.SumMapping(_balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(_balances)==500000);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==6);
        VeriSol.Requires(upgradedAddress==address(0));
        VeriSol.Requires(deprecated==false);
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(amount>0);
        VeriSol.Requires(amount==499999500000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==500000);
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= amount);
        VeriSol.Requires((VeriSol.SumMapping(_balances)) < amount);
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != amount);
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) <= amount);
        VeriSol.Requires((uint256(decimals)) < amount);
        VeriSol.Requires((uint256(decimals)) != amount);
        VeriSol.Requires((uint256(decimals)) <= (_totalSupply));
        VeriSol.Requires((uint256(decimals)) < (_totalSupply));
        VeriSol.Requires((uint256(decimals)) != (_totalSupply));
        VeriSol.Requires((upgradedAddress) != (_owner));
        VeriSol.Requires((upgradedAddress) != msg.sender);
        VeriSol.Requires((_owner) == msg.sender);
        VeriSol.Requires(amount >= (_totalSupply));
        VeriSol.Requires(amount > (_totalSupply));
        VeriSol.Requires(amount != (_totalSupply));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= amount);
        VeriSol.Ensures(decimals < amount);
        VeriSol.Ensures(decimals != amount);
        VeriSol.Ensures(decimals <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(_owner != VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(upgradedAddress != VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress != msg.sender);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= amount);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > amount);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != amount);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply >= amount);
        VeriSol.Ensures(_totalSupply > amount);
        VeriSol.Ensures(_totalSupply != amount);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        require(!deprecated);
        _mint(owner(), amount);
        emit Issue(amount);
    }

    function redeem(uint amount) public onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(upgradedAddress==address(0));
        VeriSol.AssumesBeginningOfFunction(deprecated==false);
        VeriSol.AssumesBeginningOfFunction(_owner != upgradedAddress);
        VeriSol.AssumesBeginningOfFunction(decimals>0);
        VeriSol.AssumesBeginningOfFunction(decimals==6);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.AssumesBeginningOfFunction(_paused==false);
        VeriSol.AssumesBeginningOfFunction(_totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(_totalSupply==500000000000);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(decimals <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(decimals != _totalSupply);
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) == (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (_totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) <= (_totalSupply));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(upgradedAddress == VeriSol.Old(upgradedAddress));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(upgradedAddress==address(0));
        VeriSol.Ensures(deprecated==false);
        VeriSol.Ensures(_owner != upgradedAddress);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==6);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.Ensures(_paused==false);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==500000000000);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        //End of invariants
        require(!deprecated);
        _burn(owner(), amount);
        emit Redeem(amount);
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(decimals>0);
        VeriSol.ContractInvariant(decimals==6);
        VeriSol.ContractInvariant(_owner!=address(0));
        VeriSol.ContractInvariant(upgradedAddress==address(0));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances)==500000000000);
        VeriSol.ContractInvariant(deprecated==false);
        VeriSol.ContractInvariant(_paused==false);
        VeriSol.ContractInvariant(_totalSupply>0);
        VeriSol.ContractInvariant(_totalSupply==500000000000);
        VeriSol.ContractInvariant(decimals <= VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(decimals < VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(decimals != VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(decimals <= _totalSupply);
        VeriSol.ContractInvariant(decimals < _totalSupply);
        VeriSol.ContractInvariant(decimals != _totalSupply);
        VeriSol.ContractInvariant(_owner != upgradedAddress);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) <= _totalSupply);
    }
}