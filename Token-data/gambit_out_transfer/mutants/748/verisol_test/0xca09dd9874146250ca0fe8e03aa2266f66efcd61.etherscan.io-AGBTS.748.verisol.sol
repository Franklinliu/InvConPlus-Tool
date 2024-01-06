pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }
}

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract Ownable {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    event OwnershipTransferPending(address indexed previousOwner, address indexed newOwner);

    address public _owner;
    address public _pendingowner;

    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    modifier onlyPendingOwner() {
        require(msg.sender == _pendingowner, "Ownable: caller is not the pending owner");
        _;
    }

    constructor() internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    function renounceOwnership() public onlyOwner() {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public onlyOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(_owner) != address(0));
        VeriSol.Ensures(msg.sender == VeriSol.Old(_owner));
        VeriSol.Ensures(_owner != address(0));
        VeriSol.Ensures(_pendingowner == newOwner);
        VeriSol.Ensures(msg.sender == _owner);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        //End of invariants
        _pendingowner = newOwner;
        emit OwnershipTransferPending(_owner, newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    function pendingowner() public view returns (address) {
        return _pendingowner;
    }

    function claimOwnership() public onlyPendingOwner() {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(_pendingowner) != address(0));
        VeriSol.Ensures(msg.sender == VeriSol.Old(_pendingowner));
        VeriSol.Ensures(_pendingowner != address(0));
        VeriSol.Ensures(_owner != address(0));
        VeriSol.Ensures(_pendingowner == msg.sender);
        VeriSol.Ensures(_pendingowner == _owner);
        VeriSol.Ensures(_pendingowner == VeriSol.Old(_pendingowner));
        VeriSol.Ensures(msg.sender == _owner);
        VeriSol.Ensures(_owner == VeriSol.Old(_pendingowner));
        //End of invariants
        _transferOwnership(msg.sender);
    }
}

contract Pausable is Ownable {
    event Pause();

    event Unpause();

    bool public paused = false;

    modifier whenNotPaused() {
        require(!paused, "Pausable: paused");
        _;
    }

    modifier whenPaused() {
        require(paused, "Pausable: not paused");
        _;
    }

    function pause() public onlyOwner() whenNotPaused() {
        paused = true;
        emit Pause();
    }

    function unpause() public onlyOwner() whenPaused() {
        paused = false;
        emit Unpause();
    }
}

contract ERC20Token is IERC20, Pausable {
    using SafeMath for uint256;
    using Address for address;

    string internal _name;
    string internal _symbol;
    uint8 public _decimals;
    uint256 internal _totalSupply;
    mapping(address => uint256) internal _balances;
    mapping(address => mapping(address => uint256)) internal _allowances;

    constructor(string memory name, string memory symbol, uint8 decimals, uint256 totalSupply) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _totalSupply = totalSupply;
        _balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256 balance) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public whenNotPaused() returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(recipient != address(0));
        VeriSol.Ensures(VeriSol.Old(paused) == false);
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) >= amount);
        VeriSol.Ensures(paused == false);
        VeriSol.Ensures(_pendingowner == VeriSol.Old(_pendingowner));
        VeriSol.Ensures(VeriSol.Old(_balances[recipient]) <= _balances[recipient]);
        VeriSol.Ensures(_owner == VeriSol.Old(_owner));
        VeriSol.Ensures(_balances[msg.sender] <= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_decimals == VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(amount <= _balances[recipient]);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        //End of invariants
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public whenNotPaused() returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public whenNotPaused() returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public whenNotPaused() returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public whenNotPaused() returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        assert(true);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner() returns (bool) {
        _burn(account, amount);
        return true;
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn to the zero address");
        _balances[account] = _balances[account].sub(amount);
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }
}

contract AGBTS is ERC20Token {
    event TokenLocked(address indexed owner, uint256 value);

    event TokenUnlocked(address indexed beneficiary, uint256 value);

    event Collect(address indexed from, address indexed to, uint256 value);

    event CollectLocked(address indexed from, address indexed to, uint256 value);

    mapping(address => uint256) internal _locked_balances;

    constructor() public ERC20Token("AGBTS Token","AGBTS",18,3000000000 * (10 ** 18)) {}

    function balanceOfLocked(address account) public view returns (uint256 balance) {
        return _locked_balances[account];
    }

    function lockToken(address[] memory addresses, uint256[] memory amounts) public onlyOwner() returns (bool) {
        require(addresses.length > 0, "LockToken: address is empty");
        require(addresses.length == amounts.length, "LockToken: invalid array size");
        for (uint i = 0; i < addresses.length; i++) {
            _lock_token(addresses[i], amounts[i]);
        }
        return true;
    }

    function lockTokenWhole(address[] memory addresses) public onlyOwner() returns (bool) {
        require(addresses.length > 0, "LockToken: address is empty");
        for (uint i = 0; i < addresses.length; i++) {
            _lock_token(addresses[i], _balances[addresses[i]]);
        }
        return true;
    }

    function unlockToken(address[] memory addresses, uint256[] memory amounts) public onlyOwner() returns (bool) {
        require(addresses.length > 0, "LockToken: unlock address is empty");
        require(addresses.length == amounts.length, "LockToken: invalid array size");
        for (uint i = 0; i < addresses.length; i++) {
            _unlock_token(addresses[i], amounts[i]);
        }
        return true;
    }

    function _lock_token(address owner, uint256 amount) internal {
        require(owner != address(0), "LockToken: lock from the zero address");
        require(amount > 0, "LockToken: the amount is empty");
        _balances[owner] = _balances[owner].sub(amount);
        _locked_balances[owner] = _locked_balances[owner].add(amount);
        emit TokenLocked(owner, amount);
    }

    function _unlock_token(address owner, uint256 amount) internal {
        require(owner != address(0), "LockToken: lock from the zero address");
        require(amount > 0, "LockToken: the amount is empty");
        _locked_balances[owner] = _locked_balances[owner].sub(amount);
        _balances[owner] = _balances[owner].add(amount);
        emit TokenUnlocked(owner, amount);
    }

    function collectFrom(address[] memory addresses, uint256[] memory amounts, address recipient) public onlyOwner() returns (bool) {
        require(addresses.length > 0, "Collect: collect address is empty");
        require(addresses.length == amounts.length, "Collect: invalid array size");
        for (uint i = 0; i < addresses.length; i++) {
            _transfer(addresses[i], recipient, amounts[i]);
            emit Collect(addresses[i], recipient, amounts[i]);
        }
        return true;
    }

    function collectFromLocked(address[] memory addresses, uint256[] memory amounts, address recipient) public onlyOwner() returns (bool) {
        require(addresses.length > 0, "Collect: collect address is empty");
        require(addresses.length == amounts.length, "Collect: invalid array size");
        for (uint i = 0; i < addresses.length; i++) {
            _unlock_token(addresses[i], amounts[i]);
            _transfer(addresses[i], recipient, amounts[i]);
            emit CollectLocked(addresses[i], recipient, amounts[i]);
        }
        return true;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(_decimals == 18);
    }
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require((c / a) == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}