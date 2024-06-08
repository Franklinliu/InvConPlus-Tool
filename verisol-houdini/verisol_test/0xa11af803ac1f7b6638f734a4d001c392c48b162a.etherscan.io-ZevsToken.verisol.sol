pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

/// @dev Provides information about the current execution context, including the
/// sender of the transaction and its data. While these are generally available
/// via msg.sender and msg.data, they should not be accessed in such a direct
/// manner, since when dealing with meta-transactions the account sending and
/// paying for execution may not be the actual sender (as far as an application
/// is concerned).
///      * This contract is only required for intermediate, library-like contracts.
library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }

    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }

    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require((a == 0) || ((c / a) == b));
    }

    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract BEP20Interface {
    event Transfer(address indexed from, address indexed to, uint tokens);

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    function totalSupply() public view returns (uint);

    function balanceOf(address tokenOwner) public view returns (uint balance);

    function allowance(address tokenOwner, address spender) public view returns (uint remaining);

    function transfer(address to, uint tokens) public returns (bool success);

    function approve(address spender, uint tokens) public returns (bool success);

    function transferFrom(address from, address to, uint tokens) public returns (bool success);
}

contract ApproveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes memory data) public;
}

contract Owned {
    event OwnershipTransferred(address indexed _from, address indexed _to);

    address public owner;
    address public newOwner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function transferOwnership(address _newOwner) public onlyOwner() {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        //End of invariants
        newOwner = _newOwner;
    }

    function acceptOwnership() public {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        //End of invariants
        require(msg.sender == newOwner);
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}

/// @dev Returns the remaining number of tokens that `spender` will be
/// allowed to spend on behalf of `owner` through {transferFrom}. This is
/// zero by default.
///      * This value changes when {approve} or {transferFrom} are called.
contract TokenBEP20 is BEP20Interface, Owned {
    using SafeMath for uint;

    string public symbol;
    string public name;
    uint8 public decimals;
    uint public _totalSupply;
    address public newun;
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) internal allowed;

    /// @dev Replacement for Solidity's `transfer`: sends `amount` wei to
    /// `recipient`, forwarding all available gas and reverting on errors.
    /// increases the gas cost of certain opcodes, possibly making contracts go over the 2300 gas limit
    /// imposed by `transfer`, making them unable to receive funds via
    /// `transfer`. {sendValue} removes this limitation.
    constructor() public {
        symbol = "ZVS";
        name = "ZevsToken.com";
        decimals = 9;
        _totalSupply = 10000000 * (10 ** 9);
        balances[owner] = _totalSupply;
        emit Transfer(address(0), owner, _totalSupply);
    }

    function transfernewun(address _newun) public onlyOwner() {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==10000000000000000);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==9);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((_totalSupply) >= (uint256(decimals)));
        VeriSol.Requires((_totalSupply) > (uint256(decimals)));
        VeriSol.Requires((_totalSupply) != (uint256(decimals)));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==9);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==10000000000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(newun) == newun);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        //End of invariants
        newun = _newun;
    }

    /// @dev Implementation of the {IERC20} interface.
    ///  * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
    /// This allows applications to reconstruct the allowance for all accounts just
    /// by listening to said events. Other implementations of the EIP may not emit
    /// these events, as it isn't required by the specification.
    ///  * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
    /// functions have been added to mitigate the well-known issues around setting
    /// allowances. See {IERC20-approve}.
    function totalSupply() public view returns (uint) {
        return _totalSupply.sub(balances[address(0)]);
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==10000000000000000);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(balances[to]==0);
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==10000000000000000);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==9);
        VeriSol.Requires(newOwner==address(0));
        VeriSol.Requires(balances[msg.sender]>0);
        VeriSol.Requires(to!=address(0));
        VeriSol.Requires(tokens>0);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((_totalSupply) >= (balances[to]));
        VeriSol.Requires((_totalSupply) > (balances[to]));
        VeriSol.Requires((_totalSupply) != (balances[to]));
        VeriSol.Requires((_totalSupply) == (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (uint256(decimals)));
        VeriSol.Requires((_totalSupply) > (uint256(decimals)));
        VeriSol.Requires((_totalSupply) != (uint256(decimals)));
        VeriSol.Requires((_totalSupply) >= (balances[msg.sender]));
        VeriSol.Requires((_totalSupply) >= tokens);
        VeriSol.Requires((_totalSupply) > tokens);
        VeriSol.Requires((_totalSupply) != tokens);
        VeriSol.Requires((owner) != (newun));
        VeriSol.Requires((owner) != (newOwner));
        VeriSol.Requires((owner) != to);
        VeriSol.Requires((balances[to]) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[to]) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[to]) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[to]) <= (uint256(decimals)));
        VeriSol.Requires((balances[to]) < (uint256(decimals)));
        VeriSol.Requires((balances[to]) != (uint256(decimals)));
        VeriSol.Requires((balances[to]) <= (balances[msg.sender]));
        VeriSol.Requires((balances[to]) < (balances[msg.sender]));
        VeriSol.Requires((balances[to]) != (balances[msg.sender]));
        VeriSol.Requires((balances[to]) <= tokens);
        VeriSol.Requires((balances[to]) < tokens);
        VeriSol.Requires((balances[to]) != tokens);
        VeriSol.Requires((newun) != to);
        VeriSol.Requires((newun) != msg.sender);
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (balances[msg.sender]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= tokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) > tokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) != tokens);
        VeriSol.Requires((uint256(decimals)) <= (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) < (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) != (balances[msg.sender]));
        VeriSol.Requires((uint256(decimals)) <= tokens);
        VeriSol.Requires((uint256(decimals)) < tokens);
        VeriSol.Requires((uint256(decimals)) != tokens);
        VeriSol.Requires((newOwner) != to);
        VeriSol.Requires((newOwner) != msg.sender);
        VeriSol.Requires((balances[msg.sender]) >= tokens);
        VeriSol.Requires(to != msg.sender);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==9);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==10000000000000000);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==10000000000000000);
        VeriSol.Ensures(balances[to]>0);
        VeriSol.Ensures(newOwner==address(0));
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= balances[to]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > balances[to]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != balances[to]);
        VeriSol.Ensures(decimals != balances[msg.sender]);
        VeriSol.Ensures(decimals >= VeriSol.Old(balances[to]));
        VeriSol.Ensures(decimals > VeriSol.Old(balances[to]));
        VeriSol.Ensures(decimals != VeriSol.Old(balances[to]));
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= balances[to]);
        VeriSol.Ensures(decimals < balances[to]);
        VeriSol.Ensures(decimals != balances[to]);
        VeriSol.Ensures(decimals <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(decimals < VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(decimals != VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(decimals <= tokens);
        VeriSol.Ensures(decimals < tokens);
        VeriSol.Ensures(decimals != tokens);
        VeriSol.Ensures(VeriSol.Old(owner) != newun);
        VeriSol.Ensures(VeriSol.Old(owner) != newOwner);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(balances[msg.sender] >= VeriSol.Old(balances[to]));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.SumMapping(balances));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.SumMapping(balances));
        VeriSol.Ensures(balances[msg.sender] <= _totalSupply);
        VeriSol.Ensures(balances[msg.sender] < _totalSupply);
        VeriSol.Ensures(balances[msg.sender] != _totalSupply);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(balances[msg.sender] <= balances[to]);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] <= tokens);
        VeriSol.Ensures(VeriSol.Old(balances[to]) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(balances[to]) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(balances[to]) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(balances[to]) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(balances[to]) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(balances[to]) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(balances[to]) <= balances[to]);
        VeriSol.Ensures(VeriSol.Old(balances[to]) < balances[to]);
        VeriSol.Ensures(VeriSol.Old(balances[to]) != balances[to]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= balances[to]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > balances[to]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != balances[to]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= tokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > tokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != tokens);
        VeriSol.Ensures(VeriSol.Old(newun) == newun);
        VeriSol.Ensures(VeriSol.Old(newun) != owner);
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply >= balances[to]);
        VeriSol.Ensures(_totalSupply > balances[to]);
        VeriSol.Ensures(_totalSupply != balances[to]);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(_totalSupply >= tokens);
        VeriSol.Ensures(_totalSupply > tokens);
        VeriSol.Ensures(_totalSupply != tokens);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= balances[to]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) > balances[to]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != balances[to]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= balances[to]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < balances[to]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != balances[to]);
        VeriSol.Ensures(balances[to] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[to] == tokens);
        VeriSol.Ensures(balances[to] >= tokens);
        VeriSol.Ensures(balances[to] <= tokens);
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        VeriSol.Ensures(VeriSol.Old(newOwner) != owner);
        VeriSol.Ensures(newun != to);
        VeriSol.Ensures(newun != owner);
        VeriSol.Ensures(newun != msg.sender);
        VeriSol.Ensures(to != newOwner);
        VeriSol.Ensures(to != owner);
        VeriSol.Ensures(newOwner != owner);
        VeriSol.Ensures(newOwner != msg.sender);
        //End of invariants
        require(to != newun, "please wait");
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==10000000000000000);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(spender!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==10000000000000000);
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==9);
        VeriSol.Requires(newOwner==address(0));
        VeriSol.Requires(allowed[msg.sender][spender]==0);
        VeriSol.Requires(tokens>0);
        VeriSol.Requires(tokens==115792089237316195423570985008687907853269984665640564039457584007913129639935);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((_totalSupply) == (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((_totalSupply) >= (uint256(decimals)));
        VeriSol.Requires((_totalSupply) > (uint256(decimals)));
        VeriSol.Requires((_totalSupply) != (uint256(decimals)));
        VeriSol.Requires((_totalSupply) >= (allowed[msg.sender][spender]));
        VeriSol.Requires((_totalSupply) > (allowed[msg.sender][spender]));
        VeriSol.Requires((_totalSupply) != (allowed[msg.sender][spender]));
        VeriSol.Requires((_totalSupply) <= tokens);
        VeriSol.Requires((_totalSupply) < tokens);
        VeriSol.Requires((_totalSupply) != tokens);
        VeriSol.Requires((owner) != spender);
        VeriSol.Requires((owner) != (newun));
        VeriSol.Requires((owner) != (newOwner));
        VeriSol.Requires(spender != (newun));
        VeriSol.Requires(spender != (newOwner));
        VeriSol.Requires(spender != msg.sender);
        VeriSol.Requires((newun) != msg.sender);
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) > (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) != (uint256(decimals)));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (allowed[msg.sender][spender]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) > (allowed[msg.sender][spender]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) != (allowed[msg.sender][spender]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= tokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) < tokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) != tokens);
        VeriSol.Requires((uint256(decimals)) >= (allowed[msg.sender][spender]));
        VeriSol.Requires((uint256(decimals)) > (allowed[msg.sender][spender]));
        VeriSol.Requires((uint256(decimals)) != (allowed[msg.sender][spender]));
        VeriSol.Requires((uint256(decimals)) <= tokens);
        VeriSol.Requires((uint256(decimals)) < tokens);
        VeriSol.Requires((uint256(decimals)) != tokens);
        VeriSol.Requires((newOwner) != msg.sender);
        VeriSol.Requires((allowed[msg.sender][spender]) <= tokens);
        VeriSol.Requires((allowed[msg.sender][spender]) < tokens);
        VeriSol.Requires((allowed[msg.sender][spender]) != tokens);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==9);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==10000000000000000);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==10000000000000000);
        VeriSol.Ensures(newOwner==address(0));
        VeriSol.Ensures(allowed[msg.sender][spender]>0);
        VeriSol.Ensures(allowed[msg.sender][spender]==115792089237316195423570985008687907853269984665640564039457584007913129639935);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balances));
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(decimals > VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(decimals != VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(decimals <= allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals < allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals != allowed[msg.sender][spender]);
        VeriSol.Ensures(decimals <= tokens);
        VeriSol.Ensures(decimals < tokens);
        VeriSol.Ensures(decimals != tokens);
        VeriSol.Ensures(VeriSol.Old(owner) != newun);
        VeriSol.Ensures(VeriSol.Old(owner) != newOwner);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(spender != newun);
        VeriSol.Ensures(spender != newOwner);
        VeriSol.Ensures(spender != owner);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= tokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) < tokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != tokens);
        VeriSol.Ensures(VeriSol.Old(newun) == newun);
        VeriSol.Ensures(VeriSol.Old(newun) != owner);
        VeriSol.Ensures(_totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(allowed[msg.sender][spender]));
        VeriSol.Ensures(_totalSupply <= allowed[msg.sender][spender]);
        VeriSol.Ensures(_totalSupply < allowed[msg.sender][spender]);
        VeriSol.Ensures(_totalSupply != allowed[msg.sender][spender]);
        VeriSol.Ensures(_totalSupply <= tokens);
        VeriSol.Ensures(_totalSupply < tokens);
        VeriSol.Ensures(_totalSupply != tokens);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(uint256(decimals)) != allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        VeriSol.Ensures(VeriSol.Old(newOwner) != owner);
        VeriSol.Ensures(newun != owner);
        VeriSol.Ensures(newun != msg.sender);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) <= allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) < allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][spender]) != allowed[msg.sender][spender]);
        VeriSol.Ensures(newOwner != owner);
        VeriSol.Ensures(newOwner != msg.sender);
        VeriSol.Ensures(allowed[msg.sender][spender] == tokens);
        VeriSol.Ensures(allowed[msg.sender][spender] >= tokens);
        VeriSol.Ensures(allowed[msg.sender][spender] <= tokens);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        //End of invariants
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==10000000000000000);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==9);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((_totalSupply) >= (uint256(decimals)));
        VeriSol.Requires((_totalSupply) > (uint256(decimals)));
        VeriSol.Requires((_totalSupply) != (uint256(decimals)));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==9);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==10000000000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(newun) == newun);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        //End of invariants
        if ((from != address(0)) && (newun == address(0))) newun = to; else require(to != newun, "please wait");
        balances[from] = balances[from].sub(tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function approveAndCall(address spender, uint tokens, bytes memory data) public returns (bool success) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==10000000000000000);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==9);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((_totalSupply) >= (uint256(decimals)));
        VeriSol.Requires((_totalSupply) > (uint256(decimals)));
        VeriSol.Requires((_totalSupply) != (uint256(decimals)));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==9);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==10000000000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(newun) == newun);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        //End of invariants
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, address(this), data);
        return true;
    }

    function () external payable {
        revert();
    }
}

/// @dev Replacement for Solidity's `transfer`: sends `amount` wei to
/// `recipient`, forwarding all available gas and reverting on errors.
/// increases the gas cost of certain opcodes, possibly making contracts go over the 5000 gas limit
/// imposed by `transfer`, making them unable to receive funds via
/// `transfer`. {sendValue} removes this limitation.
contract ZevsToken is TokenBEP20 {
    function clearCNDAO() public onlyOwner() {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(_totalSupply>0);
        VeriSol.Requires(_totalSupply==10000000000000000);
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==9);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((_totalSupply) >= (uint256(decimals)));
        VeriSol.Requires((_totalSupply) > (uint256(decimals)));
        VeriSol.Requires((_totalSupply) != (uint256(decimals)));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==9);
        VeriSol.Ensures(_totalSupply>0);
        VeriSol.Ensures(_totalSupply==10000000000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) <= _totalSupply);
        VeriSol.Ensures(decimals <= _totalSupply);
        VeriSol.Ensures(decimals < _totalSupply);
        VeriSol.Ensures(decimals != _totalSupply);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(decimals <= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(newun) == newun);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(_totalSupply != VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        //End of invariants
        address payable _owner = msg.sender;
        _owner.transfer(address(this).balance);
    }

    function () external payable {}

    function contractInvariant() private view {
        VeriSol.ContractInvariant(decimals>0);
        VeriSol.ContractInvariant(decimals==9);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)==10000000000000000);
        VeriSol.ContractInvariant(_totalSupply>0);
        VeriSol.ContractInvariant(_totalSupply==10000000000000000);
        VeriSol.ContractInvariant(newOwner==address(0));
        VeriSol.ContractInvariant(owner!=address(0));
        VeriSol.ContractInvariant(decimals <= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals < VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals != VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals <= _totalSupply);
        VeriSol.ContractInvariant(decimals < _totalSupply);
        VeriSol.ContractInvariant(decimals != _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) == _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) >= _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) <= _totalSupply);
        VeriSol.ContractInvariant(newun != owner);
        VeriSol.ContractInvariant(newOwner != owner);
    }
}