pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

/// @title ERC20 interface
/// @dev see https://github.com/ethereum/EIPs/issues/20
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

/// @title ERC20Detailed token
/// @dev The decimals are only for visualization purposes.
/// All the operations are done using the smallest and indivisible token unit,
/// just as on Ethereum all the operations are done in wei.
contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 public _decimals;

    constructor(string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }

    /// @return the name of the token.
    function name() public view returns (string memory) {
        return _name;
    }

    /// @return the symbol of the token.
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /// @return the number of decimals of the token.
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

/// @title SafeMath
/// @dev Unsigned math operations with safety checks that revert on error
library SafeMath {
    /// @dev Multiplies two unsigned integers, reverts on overflow.
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require((c / a) == b);
        return c;
    }

    /// @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        return c;
    }

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

    /// @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
    /// reverts when dividing by zero.
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

/// @title Standard ERC20 token
///  * @dev Implementation of the basic standard token.
/// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
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
    /// @return An uint256 representing the amount owned by the passed address.
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

    /// @dev Transfer token for a specified address
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
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        //End of invariants
        require(spender != address(0));
        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    /// @dev Transfer tokens from one address to another.
    /// Note that while this function emits an Approval event, this is not required as per the specification,
    /// and other compliant implementations may not emit the event.
    /// @param from address The address which you want to send tokens from
    /// @param to address The address which you want to transfer to
    /// @param value uint256 the amount of tokens to be transferred
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        _transfer(from, to, value);
        emit Approval(from, msg.sender, _allowed[from][msg.sender]);
        return true;
    }

    /// @dev Increase the amount of tokens that an owner allowed to a spender.
    /// approve should be called when allowed_[_spender] == 0. To increment
    /// allowed value is better to use this function to avoid 2 calls (and wait until
    /// the first transaction is mined)
    /// From MonolithDAO Token.sol
    /// Emits an Approval event.
    /// @param spender The address which will spend the funds.
    /// @param addedValue The amount of tokens to increase the allowance by.
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        //End of invariants
        require(spender != address(0));
        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
    }

    /// @dev Decrease the amount of tokens that an owner allowed to a spender.
    /// approve should be called when allowed_[_spender] == 0. To decrement
    /// allowed value is better to use this function to avoid 2 calls (and wait until
    /// the first transaction is mined)
    /// From MonolithDAO Token.sol
    /// Emits an Approval event.
    /// @param spender The address which will spend the funds.
    /// @param subtractedValue The amount of tokens to decrease the allowance by.
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        //End of invariants
        require(spender != address(0));
        _allowed[msg.sender][spender] = _allowed[msg.sender][spender].sub(subtractedValue);
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
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

    /// @dev Internal function that burns an amount of the token of a given
    /// account, deducting from the sender's allowance for said account. Uses the
    /// internal burn function.
    /// Emits an Approval event (reflecting the reduced allowance).
    /// @param account The account whose tokens will be burnt.
    /// @param value The amount that will be burnt.
    function _burnFrom(address account, uint256 value) internal {
        _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(value);
        _burn(account, value);
        emit Approval(account, msg.sender, _allowed[account][msg.sender]);
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

    /// @dev Allows the current owner to relinquish control of the contract.
    /// @notice Renouncing to ownership will leave the contract without an owner.
    /// It will not be possible to call the functions with the `onlyOwner`
    /// modifier anymore.
    function renounceOwnership() public onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_owner!=address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner!=address(0));
        //End of invariants
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /// @dev Allows the current owner to transfer control of the contract to a newOwner.
    /// @param newOwner The address to transfer ownership to.
    function transferOwnership(address newOwner) public onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_owner!=address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner!=address(0));
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

contract LockedPosition is ERC20, Ownable {
    mapping(address => uint256) public _partners;
    mapping(address => uint256) public _release;
    bool public publish = false;
    uint256 public released = 0;

    /// @dev update account to partner list
    /// @return 
    function partner(address from, address to, uint256 value) internal {
        require(from != address(0), "The from address is empty");
        require(to != address(0), "The to address is empty");
        if (publish) {
            _release[from] = _release[from].add(value);
        } else {
            if (owner() != from) {
                _partners[from] = _partners[from].sub(value);
            }
            if (owner() != to) {
                _partners[to] = _partners[to].add(value);
            }
        }
    }

    /// @dev check an account position
    /// @return bool
    function checkPosition(address account, uint256 value) internal view returns (bool) {
        require(account != address(0), "The account address is empty");
        if (isOwner()) {
            return true;
        }
        if (!publish) {
            return true;
        }
        if (released >= 100) {
            return true;
        }
        if (_partners[account] == 0) {
            return true;
        }
        return ((_partners[account] / 100) * released) >= (_release[account] + value);
    }

    /// @dev locked partners account
    /// @return 
    function locked() external onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_owner!=address(0));
        VeriSol.AssumesBeginningOfFunction(released==0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_partners)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) >= released);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply != VeriSol.SumMapping(_partners));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==200000000000000000000000000);
        VeriSol.Requires(VeriSol.SumMapping(_partners)>0);
        VeriSol.Requires(VeriSol.SumMapping(_partners)==98160200000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(publish==false);
        VeriSol.Requires(VeriSol.SumMapping(_balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(_balances)==200000000000000000000000000);
        VeriSol.Requires(released==0);
        VeriSol.Requires(VeriSol.SumMapping(_release)==0);
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(_partners)));
        VeriSol.Requires((_totalSupply) > (VeriSol.SumMapping(_partners)));
        VeriSol.Requires((_totalSupply) != (VeriSol.SumMapping(_partners)));
        VeriSol.Requires((_totalSupply) == (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((_totalSupply) <= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((_totalSupply) >= (released));
        VeriSol.Requires((_totalSupply) > (released));
        VeriSol.Requires((_totalSupply) != (released));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((_totalSupply) > (VeriSol.SumMapping(_release)));
        VeriSol.Requires((_totalSupply) != (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) <= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) < (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) != (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) >= (released));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) > (released));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) != (released));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) >= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) > (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) != (VeriSol.SumMapping(_release)));
        VeriSol.Requires(msg.sender == (_owner));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (released));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (released));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (released));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (VeriSol.SumMapping(_release)));
        VeriSol.Requires((released) == (VeriSol.SumMapping(_release)));
        VeriSol.Requires((released) >= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((released) <= (VeriSol.SumMapping(_release)));
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(VeriSol.SumMapping(_release)==0);
        VeriSol.Ensures(released==0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==200000000000000000000000000);
        VeriSol.Ensures(publish==true);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==200000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(_partners)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_partners)==98160200000000000000000000);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= released);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > released);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != released);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) >= VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) > VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) != VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) >= released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) > released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) != released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) == VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_owner == msg.sender);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(VeriSol.SumMapping(_release) == released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) == VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_release) == VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(released < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(released != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(released <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(released < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(released != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(released == VeriSol.Old(released));
        VeriSol.Ensures(released >= VeriSol.Old(released));
        VeriSol.Ensures(released <= VeriSol.Old(released));
        VeriSol.Ensures(released == VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(released >= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(released <= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(released <= _totalSupply);
        VeriSol.Ensures(released < _totalSupply);
        VeriSol.Ensures(released != _totalSupply);
        VeriSol.Ensures(released <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(released) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(released) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(released) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(released) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(released) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(released) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(released) == released);
        VeriSol.Ensures(VeriSol.Old(released) >= released);
        VeriSol.Ensures(VeriSol.Old(released) <= released);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(released==0);
        VeriSol.Ensures(VeriSol.SumMapping(_partners)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_partners));
        //End of invariants
        publish = true;
    }

    /// @dev release position
    /// @return 
    function release(uint256 percent) external onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_owner!=address(0));
        VeriSol.AssumesBeginningOfFunction(released==0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_partners)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) >= released);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply != VeriSol.SumMapping(_partners));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(VeriSol.Old(released) == released);
        VeriSol.Ensures(VeriSol.Old(released) >= released);
        VeriSol.Ensures(VeriSol.Old(released) <= released);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(released==0);
        VeriSol.Ensures(VeriSol.SumMapping(_partners)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_partners));
        //End of invariants
        require((percent <= 100) && (percent > 0), "The released must be between 0 and 100");
        released = percent;
    }

    /// @dev get account position
    /// @return bool
    function getPosition() external view returns (uint256) {
        return _partners[msg.sender];
    }

    /// @dev get account release
    /// @return bool
    function getRelease() external view returns (uint256) {
        return _release[msg.sender];
    }

    /// @dev get account position
    /// @return bool
    function positionOf(address account) external view onlyOwner() returns (uint256) {
        require(account != address(0), "The account address is empty");
        return _partners[account];
    }

    /// @dev get account release
    /// @return bool
    function releaseOf(address account) external view onlyOwner() returns (uint256) {
        require(account != address(0), "The account address is empty");
        return _release[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_owner!=address(0));
        VeriSol.AssumesBeginningOfFunction(released==0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_partners)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) >= released);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply != VeriSol.SumMapping(_partners));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==200000000000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(_owner!=address(0));
        VeriSol.Requires(to!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(_balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(_balances)==200000000000000000000000000);
        VeriSol.Requires(released==0);
        VeriSol.Requires(value>0);
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(_partners)));
        VeriSol.Requires((_totalSupply) > (VeriSol.SumMapping(_partners)));
        VeriSol.Requires((_totalSupply) != (VeriSol.SumMapping(_partners)));
        VeriSol.Requires((_totalSupply) == (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((_totalSupply) <= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((_totalSupply) >= (released));
        VeriSol.Requires((_totalSupply) > (released));
        VeriSol.Requires((_totalSupply) != (released));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((_totalSupply) > (VeriSol.SumMapping(_release)));
        VeriSol.Requires((_totalSupply) != (VeriSol.SumMapping(_release)));
        VeriSol.Requires((_totalSupply) >= value);
        VeriSol.Requires((_totalSupply) > value);
        VeriSol.Requires((_totalSupply) != value);
        VeriSol.Requires((VeriSol.SumMapping(_partners)) <= (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) < (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) != (VeriSol.SumMapping(_balances)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) >= (released));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) >= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_partners)) != value);
        VeriSol.Requires(msg.sender != to);
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (released));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (released));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (released));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != (VeriSol.SumMapping(_release)));
        VeriSol.Requires((VeriSol.SumMapping(_balances)) >= value);
        VeriSol.Requires((VeriSol.SumMapping(_balances)) > value);
        VeriSol.Requires((VeriSol.SumMapping(_balances)) != value);
        VeriSol.Requires((released) <= (VeriSol.SumMapping(_release)));
        VeriSol.Requires((released) <= value);
        VeriSol.Requires((released) < value);
        VeriSol.Requires((released) != value);
        VeriSol.Requires((VeriSol.SumMapping(_release)) != value);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(VeriSol.SumMapping(_partners)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances)==200000000000000000000000000);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==200000000000000000000000000);
        VeriSol.Ensures(released==0);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= released);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > released);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) >= VeriSol.SumMapping(_release));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_partners)) >= released);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_partners) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) >= VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) > VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) != VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) >= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) > VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) != VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_partners) >= value);
        VeriSol.Ensures(VeriSol.SumMapping(_partners) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_partners) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_partners) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_partners) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_partners) > released);
        VeriSol.Ensures(VeriSol.SumMapping(_partners) != released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != released);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(released));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(VeriSol.SumMapping(_release)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > released);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != released);
        VeriSol.Ensures(VeriSol.Old(released) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(released) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(released) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(released) == released);
        VeriSol.Ensures(VeriSol.Old(released) >= released);
        VeriSol.Ensures(VeriSol.Old(released) <= released);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_release)) >= released);
        VeriSol.Ensures(value <= _totalSupply);
        VeriSol.Ensures(value < _totalSupply);
        VeriSol.Ensures(value != _totalSupply);
        VeriSol.Ensures(value >= released);
        VeriSol.Ensures(value > released);
        VeriSol.Ensures(value != released);
        VeriSol.Ensures(_totalSupply >= released);
        VeriSol.Ensures(_totalSupply > released);
        VeriSol.Ensures(_totalSupply != released);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(released==0);
        VeriSol.Ensures(VeriSol.SumMapping(_partners)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_partners));
        //End of invariants
        require(checkPosition(msg.sender, value), "Insufficient positions");
        partner(msg.sender, to, value);
        return ERC20.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(_owner!=address(0));
        VeriSol.AssumesBeginningOfFunction(released==0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_partners)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) >= released);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released < VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(released != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.AssumesBeginningOfFunction(_totalSupply != VeriSol.SumMapping(_partners));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(VeriSol.Old(released) == released);
        VeriSol.Ensures(VeriSol.Old(released) >= released);
        VeriSol.Ensures(VeriSol.Old(released) <= released);
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(released==0);
        VeriSol.Ensures(VeriSol.SumMapping(_partners)>0);
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_partners));
        //End of invariants
        require(checkPosition(from, value), "Insufficient positions");
        partner(from, to, value);
        return ERC20.transferFrom(from, to, value);
    }
}

contract XinTimeToken is ERC20Detailed, LockedPosition {
    uint256 private constant INITIAL_SUPPLY = (2 * (10 ** 8)) * (10 ** 18);

    constructor() public ERC20Detailed("Xin Time Token","XTT",18) {
        //Begin of assumptions
        VeriSol.AssumesEndingOfFunction(_owner!=address(0));
        VeriSol.AssumesEndingOfFunction(released==0);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_partners)>0);
        VeriSol.AssumesEndingOfFunction(_decimals != VeriSol.SumMapping(_release));
        VeriSol.AssumesEndingOfFunction(_decimals >= released);
        VeriSol.AssumesEndingOfFunction(_decimals > released);
        VeriSol.AssumesEndingOfFunction(_decimals != released);
        VeriSol.AssumesEndingOfFunction(_decimals <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(_decimals < VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(_decimals != VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) >= released);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(released <= VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(released < VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(released != VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.AssumesEndingOfFunction(_totalSupply != VeriSol.SumMapping(_partners));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(_owner!=address(0));
        VeriSol.Ensures(released==0);
        VeriSol.Ensures(VeriSol.SumMapping(_partners)>0);
        VeriSol.Ensures(_decimals != VeriSol.SumMapping(_release));
        VeriSol.Ensures(_decimals >= released);
        VeriSol.Ensures(_decimals > released);
        VeriSol.Ensures(_decimals != released);
        VeriSol.Ensures(_decimals <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_decimals < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_decimals != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) >= released);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released <= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released < VeriSol.SumMapping(_partners));
        VeriSol.Ensures(released != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.Ensures(_totalSupply != VeriSol.SumMapping(_partners));
        //End of invariants
        _mint(msg.sender, INITIAL_SUPPLY);
        emit Transfer(address(0), msg.sender, totalSupply());
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(_owner!=address(0));
        VeriSol.ContractInvariant(_decimals>0);
        VeriSol.ContractInvariant(_decimals==18);
        VeriSol.ContractInvariant(released==0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances)==200000000000000000000000000);
        VeriSol.ContractInvariant(_totalSupply>0);
        VeriSol.ContractInvariant(_totalSupply==200000000000000000000000000);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_partners)>0);
        VeriSol.ContractInvariant(_decimals != VeriSol.SumMapping(_release));
        VeriSol.ContractInvariant(_decimals >= released);
        VeriSol.ContractInvariant(_decimals > released);
        VeriSol.ContractInvariant(_decimals != released);
        VeriSol.ContractInvariant(_decimals <= VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(_decimals < VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(_decimals != VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(_decimals <= _totalSupply);
        VeriSol.ContractInvariant(_decimals < _totalSupply);
        VeriSol.ContractInvariant(_decimals != _totalSupply);
        VeriSol.ContractInvariant(_decimals <= VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(_decimals < VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(_decimals != VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) >= released);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) <= _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) < _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) != _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) <= VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) < VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_release) != VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(released <= VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(released < VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(released != VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(released <= _totalSupply);
        VeriSol.ContractInvariant(released < _totalSupply);
        VeriSol.ContractInvariant(released != _totalSupply);
        VeriSol.ContractInvariant(released <= VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(released < VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(released != VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) >= _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) <= _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) >= VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) > VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) != VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(_totalSupply >= VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(_totalSupply > VeriSol.SumMapping(_partners));
        VeriSol.ContractInvariant(_totalSupply != VeriSol.SumMapping(_partners));
    }
}