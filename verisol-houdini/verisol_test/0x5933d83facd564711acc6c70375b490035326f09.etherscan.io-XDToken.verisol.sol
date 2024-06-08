pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require((c / a) == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }
}

contract XDToken {
    using SafeMath for uint256;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    event Burn(address indexed _from, uint256 _value);

    string public name = "星豆";
    string public symbol = "XD";
    uint256 public decimals = 18;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    uint256 public totalSupply = 0;
    uint256 internal constant valueFounder = 2000000000000000000000000000;

    modifier validAddress() {
        require(address(0x0) != msg.sender);
        _;
    }

    constructor() public {
        //Begin of assumptions
        VeriSol.AssumesEndingOfFunction(totalSupply>0);
        VeriSol.AssumesEndingOfFunction(totalSupply==2000000000000000000000000000);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.AssumesEndingOfFunction(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.AssumesEndingOfFunction(totalSupply >= decimals);
        VeriSol.AssumesEndingOfFunction(totalSupply > decimals);
        VeriSol.AssumesEndingOfFunction(totalSupply != decimals);
        VeriSol.AssumesEndingOfFunction(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesEndingOfFunction(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesEndingOfFunction(decimals != VeriSol.SumMapping(balanceOf));
        //End of assumptions
        //Begin of invariants
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==2000000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balanceOf));
        //End of invariants
        totalSupply = valueFounder;
        balanceOf[msg.sender] = valueFounder;
        emit Transfer(address(0x0), msg.sender, valueFounder);
    }

    function _transfer(address _from, address _to, uint256 _value) private {
        require(_to != address(0x0));
        require(balanceOf[_from] >= _value);
        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        emit Transfer(_from, _to, _value);
    }

    function transfer(address _to, uint256 _value) public validAddress() returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(totalSupply==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(totalSupply >= decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply > decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply != decimals);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(balanceOf));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.Requires(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.Requires(_to!=address(0));
        VeriSol.Requires(_value>0);
        VeriSol.Requires(balanceOf[msg.sender]>0);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires(totalSupply==2000000000000000000000000000);
        VeriSol.Requires((decimals) <= (VeriSol.SumMapping(balanceOf)));
        VeriSol.Requires((decimals) < (VeriSol.SumMapping(balanceOf)));
        VeriSol.Requires((decimals) != (VeriSol.SumMapping(balanceOf)));
        VeriSol.Requires((decimals) <= _value);
        VeriSol.Requires((decimals) < _value);
        VeriSol.Requires((decimals) != _value);
        VeriSol.Requires((decimals) <= (balanceOf[msg.sender]));
        VeriSol.Requires((decimals) < (balanceOf[msg.sender]));
        VeriSol.Requires((decimals) != (balanceOf[msg.sender]));
        VeriSol.Requires((decimals) <= (totalSupply));
        VeriSol.Requires((decimals) < (totalSupply));
        VeriSol.Requires((decimals) != (totalSupply));
        VeriSol.Requires((decimals) != (balanceOf[_to]));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) >= _value);
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) >= (balanceOf[msg.sender]));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) <= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) >= (balanceOf[_to]));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) > (balanceOf[_to]));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) != (balanceOf[_to]));
        VeriSol.Requires(_to != msg.sender);
        VeriSol.Requires(_value <= (balanceOf[msg.sender]));
        VeriSol.Requires(_value <= (totalSupply));
        VeriSol.Requires((balanceOf[msg.sender]) <= (totalSupply));
        VeriSol.Requires((totalSupply) >= (balanceOf[_to]));
        VeriSol.Requires((totalSupply) > (balanceOf[_to]));
        VeriSol.Requires((totalSupply) != (balanceOf[_to]));
        VeriSol.Ensures(balanceOf[_to]>0);
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==2000000000000000000000000000);
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.Ensures(balanceOf[_to] >= VeriSol.Old(decimals));
        VeriSol.Ensures(balanceOf[_to] > VeriSol.Old(decimals));
        VeriSol.Ensures(balanceOf[_to] != VeriSol.Old(decimals));
        VeriSol.Ensures(balanceOf[_to] <= totalSupply);
        VeriSol.Ensures(balanceOf[_to] >= decimals);
        VeriSol.Ensures(balanceOf[_to] > decimals);
        VeriSol.Ensures(balanceOf[_to] != decimals);
        VeriSol.Ensures(balanceOf[_to] <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(balanceOf[_to] >= _value);
        VeriSol.Ensures(balanceOf[_to] <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(balanceOf[_to] <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(balanceOf[_to] >= VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(balanceOf[_to] > VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(balanceOf[_to] != VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(VeriSol.Old(decimals) <= totalSupply);
        VeriSol.Ensures(VeriSol.Old(decimals) < totalSupply);
        VeriSol.Ensures(VeriSol.Old(decimals) != totalSupply);
        VeriSol.Ensures(VeriSol.Old(decimals) == decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) >= decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) <= decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) != balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(decimals) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(decimals) < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(decimals) != VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply >= _value);
        VeriSol.Ensures(totalSupply >= VeriSol.Old(balanceOf[msg.sender]));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= balanceOf[msg.sender]);
        VeriSol.Ensures(totalSupply > balanceOf[msg.sender]);
        VeriSol.Ensures(totalSupply != balanceOf[msg.sender]);
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(totalSupply > VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(totalSupply != VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(decimals <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(decimals < VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(decimals != VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(decimals <= _value);
        VeriSol.Ensures(decimals < _value);
        VeriSol.Ensures(decimals != _value);
        VeriSol.Ensures(decimals <= VeriSol.Old(balanceOf[msg.sender]));
        VeriSol.Ensures(decimals < VeriSol.Old(balanceOf[msg.sender]));
        VeriSol.Ensures(decimals != VeriSol.Old(balanceOf[msg.sender]));
        VeriSol.Ensures(decimals <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(decimals < VeriSol.Old(totalSupply));
        VeriSol.Ensures(decimals != VeriSol.Old(totalSupply));
        VeriSol.Ensures(decimals != balanceOf[msg.sender]);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals != VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) >= balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) > balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) != balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(_value <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) >= balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) > balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) != balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) > balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) != balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(balanceOf[msg.sender] <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(balanceOf[msg.sender] < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(balanceOf[msg.sender] != VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) >= VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) > VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) != VeriSol.Old(balanceOf[_to]));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==2000000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balanceOf));
        //End of invariants
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public validAddress() returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(totalSupply==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(totalSupply >= decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply > decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply != decimals);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(balanceOf));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) <= (totalSupply));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(VeriSol.Old(decimals) == decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) >= decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) <= decimals);
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) >= balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==2000000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balanceOf));
        //End of invariants
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public validAddress() returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(totalSupply==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(totalSupply >= decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply > decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply != decimals);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(balanceOf));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) <= (totalSupply));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(VeriSol.Old(decimals) == decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) >= decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) <= decimals);
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) >= balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==2000000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balanceOf));
        //End of invariants
        require(balanceOf[msg.sender] >= _value);
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function burn(uint256 _value) public validAddress() returns (bool success) {
        //Begin of assumptions
        VeriSol.AssumesBeginningOfFunction(totalSupply>0);
        VeriSol.AssumesBeginningOfFunction(totalSupply==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.AssumesBeginningOfFunction(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.AssumesBeginningOfFunction(totalSupply >= decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply > decimals);
        VeriSol.AssumesBeginningOfFunction(totalSupply != decimals);
        VeriSol.AssumesBeginningOfFunction(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.AssumesBeginningOfFunction(decimals != VeriSol.SumMapping(balanceOf));
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(decimals>0);
        VeriSol.Requires(decimals==18);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balanceOf)) <= (totalSupply));
        VeriSol.Ensures(decimals>0);
        VeriSol.Ensures(decimals==18);
        VeriSol.Ensures(VeriSol.Old(decimals) == decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) >= decimals);
        VeriSol.Ensures(VeriSol.Old(decimals) <= decimals);
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balanceOf)) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(balanceOf[msg.sender]) >= balanceOf[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) == VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(VeriSol.Old(totalSupply) <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==2000000000000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.Ensures(totalSupply >= decimals);
        VeriSol.Ensures(totalSupply > decimals);
        VeriSol.Ensures(totalSupply != decimals);
        VeriSol.Ensures(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.Ensures(decimals != VeriSol.SumMapping(balanceOf));
        //End of invariants
        require(balanceOf[msg.sender] >= _value);
        require(_value > 0);
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        totalSupply = totalSupply.sub(_value);
        emit Burn(msg.sender, _value);
        return true;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(totalSupply>0);
        VeriSol.ContractInvariant(totalSupply==2000000000000000000000000000);
        VeriSol.ContractInvariant(decimals>0);
        VeriSol.ContractInvariant(decimals==18);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf)==2000000000000000000000000000);
        VeriSol.ContractInvariant(totalSupply >= decimals);
        VeriSol.ContractInvariant(totalSupply > decimals);
        VeriSol.ContractInvariant(totalSupply != decimals);
        VeriSol.ContractInvariant(totalSupply == VeriSol.SumMapping(balanceOf));
        VeriSol.ContractInvariant(totalSupply >= VeriSol.SumMapping(balanceOf));
        VeriSol.ContractInvariant(totalSupply <= VeriSol.SumMapping(balanceOf));
        VeriSol.ContractInvariant(decimals <= VeriSol.SumMapping(balanceOf));
        VeriSol.ContractInvariant(decimals < VeriSol.SumMapping(balanceOf));
        VeriSol.ContractInvariant(decimals != VeriSol.SumMapping(balanceOf));
    }
}