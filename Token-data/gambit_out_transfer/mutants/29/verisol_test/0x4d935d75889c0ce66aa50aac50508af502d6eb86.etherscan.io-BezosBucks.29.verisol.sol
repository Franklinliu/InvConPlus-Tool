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

contract BezosBucks is ERC20Detailed {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowed;
    string internal constant tokenName = "BezosBucks";
    string internal constant tokenSymbol = "BEZOS";
    uint8 internal constant tokenDecimals = 18;
    uint256 internal _totalSupply = 2800000e18;
    uint256 public basePercent = 100;
    address internal donateWallet = 0x92c277F157Ba2f704840D35eFe77fac0ce5b79d7;

    constructor() public payable ERC20Detailed(tokenName,tokenSymbol,tokenDecimals) {
        _mint(msg.sender, _totalSupply);
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
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) == 2800000000000000000000000);
        VeriSol.Ensures(VeriSol.Old(basePercent) == 100);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > 0);
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) > 0);
        VeriSol.Ensures(to != address(0));
        VeriSol.Ensures(VeriSol.Old(donateWallet) != address(0));
        VeriSol.Ensures(value > 0);
        VeriSol.Ensures(VeriSol.Old(uint256(_decimals)) == 18);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) == VeriSol.Old(_balances[donateWallet]));
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != VeriSol.Old(basePercent));
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) >= VeriSol.Old(_balances[to]));
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != value);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) != VeriSol.Old(basePercent));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) != VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) >= VeriSol.Old(_balances[to]));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) != value);
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) != VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > VeriSol.Old(basePercent));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) >= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > VeriSol.Old(_balances[to]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > value);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(_balances)) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(VeriSol.Old(basePercent) < VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(basePercent) != VeriSol.Old(_balances[to]));
        VeriSol.Ensures(VeriSol.Old(basePercent) < value);
        VeriSol.Ensures(VeriSol.Old(basePercent) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) >= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(_balances[to]));
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > value);
        VeriSol.Ensures(VeriSol.Old(_totalSupply) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(msg.sender != to);
        VeriSol.Ensures(msg.sender != VeriSol.Old(donateWallet));
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) > VeriSol.Old(_balances[to]));
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) >= value);
        VeriSol.Ensures(VeriSol.Old(_balances[msg.sender]) > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_balances[to]) != value);
        VeriSol.Ensures(VeriSol.Old(_balances[to]) != VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(value > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(basePercent == 100);
        VeriSol.Ensures(_totalSupply > 0);
        VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] > 0);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) == 2800000000000000000000000);
        VeriSol.Ensures(_balances[to] > 0);
        VeriSol.Ensures(_balances[donateWallet] > 0);
        VeriSol.Ensures(donateWallet != address(0));
        VeriSol.Ensures(_decimals == 18);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != basePercent);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) < _totalSupply);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) < _balances[VeriSol.Old(donateWallet)]);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != _balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != _balances[to]);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) < _balances[donateWallet]);
        VeriSol.Ensures(VeriSol.Old(_balances[VeriSol.Old(donateWallet)]) != _decimals);
        VeriSol.Ensures(basePercent < _totalSupply);
        VeriSol.Ensures(basePercent != VeriSol.Old(_balances[donateWallet]));
        VeriSol.Ensures(basePercent < _balances[VeriSol.Old(donateWallet)]);
        VeriSol.Ensures(basePercent < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(basePercent != _balances[msg.sender]);
        VeriSol.Ensures(basePercent < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(basePercent == VeriSol.Old(basePercent));
        VeriSol.Ensures(basePercent < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(basePercent < VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(basePercent < _balances[to]);
        VeriSol.Ensures(basePercent != VeriSol.Old(_balances[to]));
        VeriSol.Ensures(basePercent < _balances[donateWallet]);
        VeriSol.Ensures(basePercent > _decimals);
        VeriSol.Ensures(basePercent < value);
        VeriSol.Ensures(basePercent > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(_balances[donateWallet]));
        VeriSol.Ensures(_totalSupply > _balances[VeriSol.Old(donateWallet)]);
        VeriSol.Ensures(_totalSupply <= VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_totalSupply > _balances[msg.sender]);
        VeriSol.Ensures(_totalSupply <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_totalSupply > VeriSol.Old(basePercent));
        VeriSol.Ensures(_totalSupply == VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_totalSupply >= VeriSol.Old(_balances[msg.sender]));
        VeriSol.Ensures(_totalSupply > _balances[to]);
        VeriSol.Ensures(_totalSupply > VeriSol.Old(_balances[to]));
        VeriSol.Ensures(_totalSupply > _balances[donateWallet]);
        VeriSol.Ensures(_totalSupply > _decimals);
        VeriSol.Ensures(_totalSupply > value);
        VeriSol.Ensures(_totalSupply > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) < _balances[VeriSol.Old(donateWallet)]);
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) != _balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) != _balances[to]);
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) < _balances[donateWallet]);
        VeriSol.Ensures(VeriSol.Old(_balances[donateWallet]) != _decimals);
        VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] < VeriSol.SumMapping(_balances));
        VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] != _balances[msg.sender]);
        VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] < VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] > VeriSol.Old(basePercent));
        VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] < VeriSol.Old(_totalSupply));
        VeriSol.Ensures(_balances[VeriSol.Old(donateWallet)] > VeriSol.Old(uint256(_decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) > _balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(_balances) <= VeriSol.Old(VeriSol.SumMapping(_balances)));
        VeriSol.Ensures(VeriSol.SumMapping(_balances) >= VeriSol.Old(basePercent));
        //End of invariants
        require(value <= _balances[msg.sender]);
        require(false);
        uint256 tokensToDonate = findOnePercent(value);
        uint256 tokensToTransfer = value.sub(tokensToDonate);
        _balances[msg.sender] = _balances[msg.sender].sub(value);
        _balances[to] = _balances[to].add(tokensToTransfer);
        _balances[donateWallet] = _balances[donateWallet].add(tokensToDonate);
        emit Transfer(msg.sender, to, tokensToTransfer);
        emit Transfer(msg.sender, address(donateWallet), tokensToDonate);
        return true;
    }

    function multiTransfer(address[] memory receivers, uint256[] memory amounts) public {
        for (uint256 i = 0; i < receivers.length; i++) {
            transfer(receivers[i], amounts[i]);
        }
    }

    function approve(address spender, uint256 value) public returns (bool) {
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
        uint256 tokensToDonate = findOnePercent(value);
        uint256 tokensToTransfer = value.sub(tokensToDonate);
        _balances[to] = _balances[to].add(tokensToTransfer);
        _balances[donateWallet] = _balances[donateWallet].add(tokensToDonate);
        _totalSupply = _totalSupply.sub(tokensToDonate);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        emit Transfer(from, to, tokensToTransfer);
        emit Transfer(from, address(donateWallet), tokensToDonate);
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

    function contractInvariant() private view {}
}