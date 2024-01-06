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

contract DUMBLEDOGE is ERC20Detailed {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowed;
    string internal constant tokenName = "DUMBLEDOGE";
    string internal constant tokenSymbol = "DDOGE";
    uint8 internal constant tokenDecimals = 18;
    uint256 internal _totalSupply = 1000000000000 * (10 ** 18);
    uint256 public basePercent = 100;
    uint256 public _burnStopAmount;
    uint256 public _lastTokenSupply;

    constructor() public payable ERC20Detailed(tokenName,tokenSymbol,tokenDecimals) {
        _mint(msg.sender, _totalSupply);
        _burnStopAmount = 0;
        _lastTokenSupply = 200000 * (10 ** 18);
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
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(basePercent) == 100);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == 200000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) == 0);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > 0);
        VeriSol.Ensures(to != address(0));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > 0);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) > 0);
        VeriSol.Ensures(VeriSol.Old(_balances[to]) >= VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != value);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= value);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > value);
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) >= value);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > value);
        VeriSol.Ensures(_burnStopAmount == 0);
        VeriSol.Ensures(_lastTokenSupply == 200000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > 0);
        VeriSol.Ensures(_totalSupply > 0);
        VeriSol.Ensures(basePercent == 100);
        VeriSol.Ensures(_decimals > 0);
        VeriSol.Ensures(VeriSol.Old(_balances[to]) >= _burnStopAmount);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(basePercent));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_burnStopAmount == VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount < _lastTokenSupply);
        VeriSol.Ensures(_burnStopAmount != VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(_burnStopAmount < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_burnStopAmount < _totalSupply);
        VeriSol.Ensures(_burnStopAmount <= _balances[to]);
        VeriSol.Ensures(_burnStopAmount <= _balances[msg.sender]);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_burnStopAmount < basePercent);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_burnStopAmount < _decimals);
        VeriSol.Ensures(_burnStopAmount != value);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(basePercent) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) == basePercent);
        VeriSol.Ensures(VeriSol.Old(basePercent) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= _balances[to]);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= _balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < basePercent);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > basePercent);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > _decimals);
        VeriSol.Ensures(_lastTokenSupply <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_lastTokenSupply <= _totalSupply);
        VeriSol.Ensures(_lastTokenSupply < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_lastTokenSupply > basePercent);
        VeriSol.Ensures(_lastTokenSupply > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_lastTokenSupply > _decimals);
        VeriSol.Ensures(_lastTokenSupply != value);
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) > _balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > basePercent);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _decimals);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > value);
        VeriSol.Ensures(_totalSupply < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply > basePercent);
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_totalSupply > _decimals);
        VeriSol.Ensures(_totalSupply > value);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > _decimals);
        VeriSol.Ensures(basePercent > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(basePercent > _decimals);
        VeriSol.Ensures(basePercent != value);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == _decimals);
        VeriSol.Ensures(_decimals != value);
        //End of invariants
        require(value <= _balances[msg.sender]);
        require(to != address(0));
        uint256 tokensToBurn = findOnePercent(value);
        uint256 tokensToTransfer = value.sub(tokensToBurn);
        assert(true);
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
        VeriSol.Ensures(spender != address(0));
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(basePercent) == 100);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == 200000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) == 0);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > 0);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > 0);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == 18);
        VeriSol.Ensures(value > 0);
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(basePercent) < value);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != value);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) <= VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < value);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != value);
        VeriSol.Ensures(VeriSol.Old(_allowed[msg.sender][spender]) != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_allowed[msg.sender][spender]) != VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_allowed[msg.sender][spender]) <= value);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) != value);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) < value);
        VeriSol.Ensures(_burnStopAmount == 0);
        VeriSol.Ensures(_allowed[msg.sender][spender] > 0);
        VeriSol.Ensures(_lastTokenSupply == 200000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > 0);
        VeriSol.Ensures(_totalSupply > 0);
        VeriSol.Ensures(basePercent == 100);
        VeriSol.Ensures(_decimals == 18);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(basePercent));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_lastTokenSupply));
        VeriSol.Ensures(_burnStopAmount == VeriSol.Old(_burnStopAmount));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_burnStopAmount < _allowed[msg.sender][spender]);
        VeriSol.Ensures(_burnStopAmount < _lastTokenSupply);
        VeriSol.Ensures(_burnStopAmount < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_burnStopAmount < _totalSupply);
        VeriSol.Ensures(_burnStopAmount <= VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_burnStopAmount < basePercent);
        VeriSol.Ensures(_burnStopAmount < VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_burnStopAmount < _decimals);
        VeriSol.Ensures(_burnStopAmount < value);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(basePercent) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(basePercent) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(basePercent) == basePercent);
        VeriSol.Ensures(VeriSol.Old(basePercent) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) != _allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) == _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_lastTokenSupply) > _decimals);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < basePercent);
        VeriSol.Ensures(VeriSol.Old(_burnStopAmount) < _decimals);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) != _allowed[msg.sender][spender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > _lastTokenSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == _totalSupply);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > basePercent);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > _decimals);
        VeriSol.Ensures(_allowed[msg.sender][spender] != _lastTokenSupply);
        VeriSol.Ensures(_allowed[msg.sender][spender] != VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_allowed[msg.sender][spender] != _totalSupply);
        VeriSol.Ensures(_allowed[msg.sender][spender] >= VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(_allowed[msg.sender][spender] != VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_allowed[msg.sender][spender] > basePercent);
        VeriSol.Ensures(_allowed[msg.sender][spender] > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_allowed[msg.sender][spender] > _decimals);
        VeriSol.Ensures(_allowed[msg.sender][spender] == value);
        VeriSol.Ensures(_lastTokenSupply < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_lastTokenSupply < _totalSupply);
        VeriSol.Ensures(_lastTokenSupply != VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(_lastTokenSupply < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_lastTokenSupply > basePercent);
        VeriSol.Ensures(_lastTokenSupply > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_lastTokenSupply > _decimals);
        VeriSol.Ensures(_lastTokenSupply != value);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > basePercent);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _decimals);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) != value);
        VeriSol.Ensures(_totalSupply != VeriSol.Old(_allowed[msg.sender][spender]));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply > basePercent);
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_totalSupply > _decimals);
        VeriSol.Ensures(_totalSupply != value);
        VeriSol.Ensures(VeriSol.Old(_allowed[msg.sender][spender]) != basePercent);
        VeriSol.Ensures(VeriSol.Old(_allowed[msg.sender][spender]) != _decimals);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > basePercent);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > _decimals);
        VeriSol.Ensures(basePercent > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(basePercent > _decimals);
        VeriSol.Ensures(basePercent < value);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == _decimals);
        VeriSol.Ensures(_decimals < value);
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
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) > 0);
        VeriSol.ContractInvariant(_totalSupply > 0);
        VeriSol.ContractInvariant(basePercent == 100);
        VeriSol.ContractInvariant(_decimals > 0);
        VeriSol.ContractInvariant(_burnStopAmount < _lastTokenSupply);
        VeriSol.ContractInvariant(_burnStopAmount < VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(_burnStopAmount < _totalSupply);
        VeriSol.ContractInvariant(_burnStopAmount < basePercent);
        VeriSol.ContractInvariant(_burnStopAmount < _decimals);
        VeriSol.ContractInvariant(_lastTokenSupply <= VeriSol.SumMapping(_balances));
        VeriSol.ContractInvariant(_lastTokenSupply <= _totalSupply);
        VeriSol.ContractInvariant(_lastTokenSupply > basePercent);
        VeriSol.ContractInvariant(_lastTokenSupply > _decimals);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) == _totalSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) > basePercent);
        VeriSol.ContractInvariant(VeriSol.SumMapping(_balances) > _decimals);
        VeriSol.ContractInvariant(_totalSupply > basePercent);
        VeriSol.ContractInvariant(_totalSupply > _decimals);
        VeriSol.ContractInvariant(basePercent > _decimals);
    }
}