pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert((c / a) == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    function ceil(uint256 a, uint256 m) internal pure returns (uint256) {
        uint256 c = add(a, m);
        uint256 d = sub(c, 1);
        return mul(div(d, m), m);
    }
}

contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 public _decimals;

    constructor(string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
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
}

contract Zeus is ERC20Detailed {
    using SafeMath for uint256;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowed;
    string internal constant tokenName = "ZeusDoge";
    string internal constant tokenSymbol = "Zoge";
    uint8 internal constant tokenDecimals = 18;
    uint256 internal _totalSupply = 1000000000 * (10 ** 18);
    uint256 public basePercent = 100;
    uint256 public _burnStopAmount;
    uint256 public _lastTokenSupply;
    uint256 public maxTxAmount = 1000000000 * (10 ** 18);
    address internal currentOwner;
    mapping(address => bool) private _isBlackListed;

    constructor() public payable ERC20Detailed(tokenName,tokenSymbol,tokenDecimals) {
        _mint(msg.sender, _totalSupply);
        _burnStopAmount = 0;
        _lastTokenSupply = 200000 * (10 ** 18);
        currentOwner = msg.sender;
    }

    function token_owner() public view returns (address) {
        return currentOwner;
    }

    function setMaxTxAmount(uint256 theAmount) external {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > 0);
        VeriSol.Ensures(VeriSol.Old(basePercent) == 100);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) == 0);
        VeriSol.Ensures(VeriSol.Old(currentOwner) != address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > 0);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == 200000000000000000000000);
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > 0);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(basePercent));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= theAmount);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(currentOwner) == msg.sender);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount == 0);
        VeriSol.Ensures(_lastTokenSupply == 200000000000000000000000);
        VeriSol.Ensures(_totalSupply > 0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > 0);
        VeriSol.Ensures(currentOwner != address(0));
        VeriSol.Ensures(basePercent == 100);
        VeriSol.Ensures(_decimals > 0);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(basePercent));
        VeriSol.Ensures(_burnStopAmount == VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(_burnStopAmount < _lastTokenSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_burnStopAmount <= VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_burnStopAmount < _totalSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_burnStopAmount < basePercent);
        VeriSol.Ensures(_burnStopAmount < _decimals);
        VeriSol.Ensures(_burnStopAmount <= theAmount);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount <= maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < basePercent);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == _decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) != maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(basePercent) == basePercent);
        VeriSol.Ensures(VeriSol.Old(basePercent) > _decimals);
        VeriSol.Ensures(VeriSol.Old(basePercent) != maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < basePercent);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _decimals);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= maxTxAmount);
        VeriSol.Ensures(_lastTokenSupply < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_lastTokenSupply == VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_lastTokenSupply < _totalSupply);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_lastTokenSupply > basePercent);
        VeriSol.Ensures(_lastTokenSupply > _decimals);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(currentOwner) == currentOwner);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) != basePercent);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) != _decimals);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) != maxTxAmount);
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_totalSupply > basePercent);
        VeriSol.Ensures(_totalSupply > _decimals);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > basePercent);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _decimals);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(currentOwner == msg.sender);
        VeriSol.Ensures(basePercent > _decimals);
        VeriSol.Ensures(basePercent < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(basePercent != maxTxAmount);
        VeriSol.Ensures(_decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_decimals != maxTxAmount);
        VeriSol.Ensures(theAmount <= maxTxAmount);
        //End of invariants
        require(msg.sender == currentOwner, "only token current owner can do this");
        maxTxAmount = theAmount * (10 ** 18);
    }

    function removeFromBlackList(address account) external {
        require(msg.sender == currentOwner, "only token current owner can do this");
        _isBlackListed[account] = false;
    }

    function addToBlackList(address account) external {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > 0);
        VeriSol.Ensures(VeriSol.Old(basePercent) == 100);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) == 0);
        VeriSol.Ensures(VeriSol.Old(currentOwner) != address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > 0);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == 200000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) > 0);
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > 0);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(basePercent));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(currentOwner) == msg.sender);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount == 0);
        VeriSol.Ensures(_isBlackListed[account] == true);
        VeriSol.Ensures(_lastTokenSupply == 200000000000000000000000);
        VeriSol.Ensures(_totalSupply > 0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > 0);
        VeriSol.Ensures(currentOwner != address(0));
        VeriSol.Ensures(basePercent == 100);
        VeriSol.Ensures(_decimals > 0);
        VeriSol.Ensures(maxTxAmount > 0);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(basePercent));
        VeriSol.Ensures(_burnStopAmount == VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(_burnStopAmount < _lastTokenSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_burnStopAmount < _totalSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_burnStopAmount < basePercent);
        VeriSol.Ensures(_burnStopAmount < _decimals);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < basePercent);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == _decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(basePercent) == basePercent);
        VeriSol.Ensures(VeriSol.Old(basePercent) > _decimals);
        VeriSol.Ensures(VeriSol.Old(basePercent) != maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < basePercent);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _decimals);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < maxTxAmount);
        VeriSol.Ensures(_lastTokenSupply < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_lastTokenSupply == VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_lastTokenSupply < _totalSupply);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_lastTokenSupply > basePercent);
        VeriSol.Ensures(_lastTokenSupply > _decimals);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_lastTokenSupply < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(currentOwner) == currentOwner);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= maxTxAmount);
        VeriSol.Ensures(account != currentOwner);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) > basePercent);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) > _decimals);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) == maxTxAmount);
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_totalSupply > basePercent);
        VeriSol.Ensures(_totalSupply > _decimals);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply >= maxTxAmount);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > basePercent);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _decimals);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= maxTxAmount);
        VeriSol.Ensures(currentOwner == msg.sender);
        VeriSol.Ensures(basePercent > _decimals);
        VeriSol.Ensures(basePercent < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(basePercent < maxTxAmount);
        VeriSol.Ensures(_decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_decimals < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= maxTxAmount);
        //End of invariants
        require(msg.sender == currentOwner, "only token current owner can do this");
        _isBlackListed[account] = true;
    }

    function isBlackListed(address account) public view returns (bool) {
        return _isBlackListed[account];
    }

    function transferOwnership(address newOwner) external {
        require(msg.sender == currentOwner, "only token current owner can do this");
        emit OwnershipTransferred(currentOwner, newOwner);
        currentOwner = newOwner;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }

    function findOnePercent(uint256 value) public view returns (uint256) {
        uint256 roundValue = value.ceil(basePercent);
        uint256 onePercent = roundValue.mul(basePercent).div(10000);
        return onePercent;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > 0);
        VeriSol.Ensures(VeriSol.Old(basePercent) == 100);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) == 0);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > 0);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == 200000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) > 0);
        VeriSol.Ensures(to != address(0));
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(basePercent));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(basePercent) != value);
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(value >= VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(value < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(value != VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(value <= VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(value <= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= VeriSol.Old(_balances[to]));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(to != msg.sender);
        VeriSol.Ensures(_burnStopAmount == 0);
        VeriSol.Ensures(_lastTokenSupply == 200000000000000000000000);
        VeriSol.Ensures(_totalSupply > 0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > 0);
        VeriSol.Ensures(basePercent == 100);
        VeriSol.Ensures(_decimals > 0);
        VeriSol.Ensures(maxTxAmount > 0);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(basePercent));
        VeriSol.Ensures(_burnStopAmount <= value);
        VeriSol.Ensures(_burnStopAmount == VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(_burnStopAmount <= _balances[to]);
        VeriSol.Ensures(_burnStopAmount < _lastTokenSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_burnStopAmount <= _balances[msg.sender]);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_burnStopAmount <= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(_burnStopAmount < _totalSupply);
        VeriSol.Ensures(_burnStopAmount <= VeriSol.Old(_balances[to]));
        VeriSol.Ensures(_burnStopAmount < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_burnStopAmount < basePercent);
        VeriSol.Ensures(_burnStopAmount < _decimals);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < basePercent);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == _decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) == basePercent);
        VeriSol.Ensures(VeriSol.Old(basePercent) > _decimals);
        VeriSol.Ensures(VeriSol.Old(basePercent) != maxTxAmount);
        VeriSol.Ensures(value != _lastTokenSupply);
        VeriSol.Ensures(value < _totalSupply);
        VeriSol.Ensures(value != basePercent);
        VeriSol.Ensures(value <= maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= _balances[to]);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= _balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < basePercent);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _decimals);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < maxTxAmount);
        VeriSol.Ensures(_balances[to] >= VeriSol.Old(_balances[to]));
        VeriSol.Ensures(_lastTokenSupply < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_lastTokenSupply == VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_lastTokenSupply <= _totalSupply);
        VeriSol.Ensures(_lastTokenSupply > basePercent);
        VeriSol.Ensures(_lastTokenSupply > _decimals);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_lastTokenSupply != maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(currentOwner) == currentOwner);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > _decimals);
        VeriSol.Ensures(_balances[msg.sender] <= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) <= _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) != _totalSupply);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) != basePercent);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) > _decimals);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) == maxTxAmount);
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_totalSupply > basePercent);
        VeriSol.Ensures(_totalSupply > _decimals);
        VeriSol.Ensures(_totalSupply != maxTxAmount);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= _decimals);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(basePercent > _decimals);
        VeriSol.Ensures(basePercent != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(basePercent != maxTxAmount);
        VeriSol.Ensures(_decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_decimals < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) - _balances[msg.sender] == value);
        //End of invariants
        require(value <= _balances[msg.sender]);
        assert(true);
        address caller = msg.sender;
        require(to != caller, "you can't send to yourself");
        require(value <= maxTxAmount, "Transfer amount exceeds the maxTxAmount.");
        require(!_isBlackListed[to], "this address is blacklisted");
        uint256 tokensToBurn = findOnePercent(value);
        uint256 tokensToTransfer = value.sub(tokensToBurn);
        _balances[msg.sender] = _balances[msg.sender].sub(value);
        _balances[to] = _balances[to].add(tokensToTransfer);
        _totalSupply = _totalSupply.sub(tokensToBurn);
        emit Transfer(msg.sender, to, tokensToTransfer);
        emit Transfer(msg.sender, address(0), tokensToBurn);
        return true;
    }

    function multiTransfer(address[] memory receivers, uint256[] memory amounts) public {
        for (uint256 i = 0; i < receivers.length; i++) {
            transfer(receivers[i], amounts[i]);
        }
    }

    function approve(address spender, uint256 value) public returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > 0);
        VeriSol.Ensures(VeriSol.Old(basePercent) == 100);
        VeriSol.Ensures(spender != address(0));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) == 0);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > 0);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == 200000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) > 0);
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > 0);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(basePercent));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(value >= VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount == 0);
        VeriSol.Ensures(_lastTokenSupply == 200000000000000000000000);
        VeriSol.Ensures(_totalSupply > 0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > 0);
        VeriSol.Ensures(basePercent == 100);
        VeriSol.Ensures(_decimals > 0);
        VeriSol.Ensures(maxTxAmount > 0);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(basePercent));
        VeriSol.Ensures(_burnStopAmount <= value);
        VeriSol.Ensures(_burnStopAmount == VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(_burnStopAmount <= _allowed[msg.sender][spender]);
        VeriSol.Ensures(_burnStopAmount < _lastTokenSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_burnStopAmount < _totalSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_burnStopAmount < basePercent);
        VeriSol.Ensures(_burnStopAmount < _decimals);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < basePercent);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == _decimals);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(basePercent) == basePercent);
        VeriSol.Ensures(VeriSol.Old(basePercent) > _decimals);
        VeriSol.Ensures(VeriSol.Old(basePercent) != maxTxAmount);
        VeriSol.Ensures(value == _allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= _allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < basePercent);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _decimals);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < maxTxAmount);
        VeriSol.Ensures(_lastTokenSupply < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_lastTokenSupply == VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(maxTxAmount));
        VeriSol.Ensures(_lastTokenSupply < _totalSupply);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_lastTokenSupply > basePercent);
        VeriSol.Ensures(_lastTokenSupply > _decimals);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_lastTokenSupply != maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(currentOwner) == currentOwner);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != maxTxAmount);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) != basePercent);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) > _decimals);
        VeriSol.Ensures(VeriSol.Old(maxTxAmount) == maxTxAmount);
        VeriSol.Ensures(_totalSupply >= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_totalSupply > basePercent);
        VeriSol.Ensures(_totalSupply > _decimals);
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > basePercent);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _decimals);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(basePercent > _decimals);
        VeriSol.Ensures(basePercent < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(basePercent != maxTxAmount);
        VeriSol.Ensures(_decimals < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_decimals < maxTxAmount);
        //End of invariants
        require(spender != address(0));
        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(value <= _balances[from]);
        require(value <= _allowed[from][msg.sender]);
        require(to != address(0));
        address caller = msg.sender;
        require(to != caller, "you can't send to yourself");
        require(value <= maxTxAmount, "Transfer amount exceeds the maxTxAmount.");
        require(!_isBlackListed[to], "this address is blacklisted");
        _balances[from] = _balances[from].sub(value);
        uint256 tokensToBurn = findOnePercent(value);
        uint256 tokensToTransfer = value.sub(tokensToBurn);
        _balances[to] = _balances[to].add(tokensToTransfer);
        _totalSupply = _totalSupply.sub(tokensToBurn);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        emit Transfer(from, to, tokensToTransfer);
        emit Transfer(from, address(0), tokensToBurn);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        require(spender != address(0));
        _allowed[msg.sender][spender] = (_allowed[msg.sender][spender].add(addedValue));
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        require(spender != address(0));
        _allowed[msg.sender][spender] = (_allowed[msg.sender][spender].sub(subtractedValue));
        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
    }

    function _mint(address account, uint256 amount) internal {
        require(amount != 0);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(amount != 0);
        require(amount <= _balances[account]);
        _totalSupply = _totalSupply.sub(amount);
        _balances[account] = _balances[account].sub(amount);
        emit Transfer(account, address(0), amount);
    }

    function burnFrom(address account, uint256 amount) external {
        require(amount <= _allowed[account][msg.sender]);
        _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(amount);
        _burn(account, amount);
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(_burnStopAmount == 0);
        VeriSol.ContractInvariant(_lastTokenSupply == 200000000000000000000000);
        VeriSol.ContractInvariant(basePercent == 100);
        VeriSol.ContractInvariant(_decimals > 0);
        VeriSol.ContractInvariant(_burnStopAmount < _lastTokenSupply);
        VeriSol.ContractInvariant(_burnStopAmount < basePercent);
        VeriSol.ContractInvariant(_burnStopAmount < _decimals);
        VeriSol.ContractInvariant(_burnStopAmount <= maxTxAmount);
        VeriSol.ContractInvariant(_lastTokenSupply > basePercent);
        VeriSol.ContractInvariant(_lastTokenSupply > _decimals);
        VeriSol.ContractInvariant(_totalSupply != _decimals);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) >= _decimals);
        VeriSol.ContractInvariant(basePercent > _decimals);
        VeriSol.ContractInvariant(basePercent != maxTxAmount);
        VeriSol.ContractInvariant(_decimals != maxTxAmount);
    }
}