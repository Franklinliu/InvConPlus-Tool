pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

library SafeMath {
    function mul(uint256 _a, uint256 _b) internal pure returns (uint256) {
        if (_a == 0) {
            return 0;
        }
        uint256 c = _a * _b;
        require((c / _a) == _b);
        return c;
    }

    function div(uint256 _a, uint256 _b) internal pure returns (uint256) {
        require(_b > 0);
        uint256 c = _a / _b;
        return c;
    }

    function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
        require(_b <= _a);
        return _a - _b;
    }

    function add(uint256 _a, uint256 _b) internal pure returns (uint256) {
        uint256 c = _a + _b;
        require(c >= _a);
        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

contract Ownable {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    address public owner;
    address public newOwner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyNewOwner() {
        require(msg.sender != address(0));
        require(msg.sender == newOwner);
        _;
    }

    constructor() public {
        owner = msg.sender;
        newOwner = address(0);
    }

    function transferOwnership(address _newOwner) public onlyOwner() {
        require(_newOwner != address(0));
        newOwner = _newOwner;
    }

    function acceptOwnership() public onlyNewOwner() {
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}

contract ERC20 {
    event Approval(address indexed owner, address indexed spender, uint256 value);

    event Transfer(address indexed from, address indexed to, uint256 value);

    function totalSupply() public view returns (uint256);

    function balanceOf(address who) public view returns (uint256);

    function allowance(address owner, address spender) public view returns (uint256);

    function transfer(address to, uint256 value) public returns (bool);

    function transferFrom(address from, address to, uint256 value) public returns (bool);

    function approve(address spender, uint256 value) public returns (bool);
}

interface TokenRecipient {
    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata) external;
}

contract Finder is ERC20, Ownable {
    using SafeMath for uint256;

    event Burn(address indexed owner, uint256 value);

    event lock(address indexed holder);

    event unLock(address indexed holder);

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 internal initialSupply;
    uint256 internal totalSupply_;
    mapping(address => uint256) internal balances;
    mapping(address => bool) public frozen;
    mapping(address => mapping(address => uint256)) internal allowed;

    modifier notFrozen(address _holder) {
        require(!frozen[_holder]);
        _;
    }

    constructor() public {
        name = "Finder";
        symbol = "FIND";
        decimals = 0;
        initialSupply = 1000000000;
        totalSupply_ = 1000000000;
        balances[owner] = totalSupply_;
        emit Transfer(address(0), owner, totalSupply_);
    }

    function () external payable {
        revert();
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function _transfer(address _from, address _to, uint _value) internal {
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
    }

    function transfer(address _to, uint256 _value) public notFrozen(msg.sender) returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(_to != address(0));
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(_value <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(owner == VeriSol.Old(owner));
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(totalSupply_) == totalSupply_);
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        VeriSol.Ensures(initialSupply == VeriSol.Old(initialSupply));
        VeriSol.Ensures(_value <= balances[_to]);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[_to] >= VeriSol.Old(balances[_to]));
        //End of invariants
        require(false);
        require(_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function balanceOf(address _holder) public view returns (uint256 balance) {
        return balances[_holder];
    }

    function transferFrom(address _from, address _to, uint256 _value) public notFrozen(_from) returns (bool) {
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _holder, address _spender) public view returns (uint256) {
        return allowed[_holder][_spender];
    }

    function Lock(address _holder) public onlyOwner() returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(VeriSol.Old(frozen[_holder]) == false);
        VeriSol.Ensures(VeriSol.Old(owner) != address(0));
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(owner) == msg.sender);
        VeriSol.Ensures(owner != address(0));
        VeriSol.Ensures(frozen[_holder] == true);
        VeriSol.Ensures(owner == VeriSol.Old(owner));
        VeriSol.Ensures(owner == msg.sender);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(totalSupply_) == totalSupply_);
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        VeriSol.Ensures(initialSupply == VeriSol.Old(initialSupply));
        //End of invariants
        require(!frozen[_holder]);
        frozen[_holder] = true;
        emit lock(_holder);
        return true;
    }

    function UnLock(address _holder) public onlyOwner() returns (bool) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(msg.sender != address(0));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(VeriSol.Old(owner) != address(0));
        VeriSol.Ensures(msg.sender != address(0));
        VeriSol.Ensures(VeriSol.Old(owner) == msg.sender);
        VeriSol.Ensures(owner != address(0));
        VeriSol.Ensures(owner == VeriSol.Old(owner));
        VeriSol.Ensures(owner == msg.sender);
        VeriSol.Ensures(decimals == VeriSol.Old(uint256(decimals)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.Old(totalSupply_) == totalSupply_);
        VeriSol.Ensures(VeriSol.Old(newOwner) == newOwner);
        VeriSol.Ensures(initialSupply == VeriSol.Old(initialSupply));
        //End of invariants
        require(frozen[_holder]);
        frozen[_holder] = false;
        emit unLock(_holder);
        return true;
    }

    function burn(uint256 _value) public onlyOwner() returns (bool) {
        require(_value <= balances[msg.sender]);
        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
        emit Burn(burner, _value);
        return true;
    }

    function isContract(address addr) internal view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(owner != address(0));
        VeriSol.ContractInvariant(decimals == 0);
        VeriSol.ContractInvariant(initialSupply == 1000000000);
        VeriSol.ContractInvariant(decimals <= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(decimals < initialSupply);
        VeriSol.ContractInvariant(decimals <= totalSupply_);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) <= initialSupply);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances) == totalSupply_);
        VeriSol.ContractInvariant(initialSupply >= totalSupply_);
    }
}