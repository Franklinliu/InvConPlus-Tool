pragma solidity ^0.5.5;

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    require(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // require(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // require(a == b * c + a % b); // There is no case in which this doesn't hold
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
    
    string public name = "星豆";      //  token name
    
    string public symbol = "XD";           //  token symbol
    
    uint256 public decimals = 18;            //  token digit

    mapping (address => uint256) public balanceOf;
    
    mapping (address => mapping (address => uint256)) public allowance;
 
    
    uint256 public totalSupply = 0;

    uint256 constant valueFounder = 2000000000000000000000000000;
    
    

    modifier validAddress {
        require(address(0x0) != msg.sender);
        _;
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Burn(address indexed _from , uint256 _value);
    
    constructor() public {

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
    
    function transfer(address _to, uint256 _value) validAddress public returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) validAddress public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) validAddress public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    function burn(uint256 _value) validAddress public returns (bool success) {
        require (balanceOf[msg.sender] >= _value);// Check if the sender has enough
        require (_value > 0);
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);           // Subtract from the sender
        totalSupply = totalSupply.sub(_value);                       // Updates totalSupply
        emit Burn(msg.sender, _value);
        return true;
    }
}