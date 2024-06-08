pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

interface tokenRecipient {
    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata _extraData) external;
}

contract TokenERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Burn(address indexed from, uint256 value);

    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 initialSupply, string memory tokenName, string memory tokenSymbol) public {
        totalSupply = initialSupply * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
        name = tokenName;
        symbol = tokenSymbol;
    }


    function contractInvariant() private view {
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf)>0);
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf)==1000000000000000000000000000);
        // VeriSol.ContractInvariant(totalSupply>0);
        // VeriSol.ContractInvariant(totalSupply==1000000000000000000000000000);
        // VeriSol.ContractInvariant(VeriSol.Old(VeriSol.SumMapping(balanceOf))>0);
        // VeriSol.ContractInvariant(VeriSol.Old(VeriSol.SumMapping(balanceOf))==1000000000000000000000000000);
        // VeriSol.ContractInvariant(decimals>0);
        // VeriSol.ContractInvariant(decimals==18);
        // VeriSol.ContractInvariant(VeriSol.Old(totalSupply)>0);
        // VeriSol.ContractInvariant(VeriSol.Old(totalSupply)==1000000000000000000000000000);
        // VeriSol.ContractInvariant(VeriSol.Old(decimals)>0);
        // VeriSol.ContractInvariant(VeriSol.Old(decimals)==18);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) == totalSupply);
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) >= totalSupply);
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) <= totalSupply);
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) == VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) >= VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(VeriSol.SumMapping(balanceOf) <= VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(totalSupply == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.ContractInvariant(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.ContractInvariant(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.ContractInvariant(totalSupply == VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(totalSupply >= VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(totalSupply <= VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(VeriSol.Old(VeriSol.SumMapping(balanceOf)) == VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(VeriSol.Old(VeriSol.SumMapping(balanceOf)) >= VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(VeriSol.Old(VeriSol.SumMapping(balanceOf)) <= VeriSol.Old(totalSupply));
        // VeriSol.ContractInvariant(uint(decimals) == VeriSol.Old(uint(decimals)));
        // VeriSol.ContractInvariant(uint(decimals) >= VeriSol.Old(uint(decimals)));
        // VeriSol.ContractInvariant(uint(decimals) <= VeriSol.Old(uint(decimals)));
    }

    function _transfer(address _from, address _to, uint _value) internal {
        require(_to != address(0));
        require(balanceOf[_from] >= _value);
        require((balanceOf[_to] + _value) > balanceOf[_to]);
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        assert((balanceOf[_from] + balanceOf[_to]) == previousBalances);
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        //__verisol__transfer(_to,_value)
        //VeriSol.Requires(msg.value==0);
        // VeriSol.Requires(VeriSol.Old(decimals)==18);
        // VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==1000000000000000000000000000);
        // VeriSol.Requires(VeriSol.Old(VeriSol.SumMapping(balanceOf))==1000000000000000000000000000);
        // VeriSol.Requires(VeriSol.Old(totalSupply)==1000000000000000000000000000);
        // VeriSol.Ensures(decimals==18);
        // VeriSol.Ensures(totalSupply==1000000000000000000000000000);
        // VeriSol.Ensures(_value <= VeriSol.SumMapping(balanceOf));
        // VeriSol.Ensures(_value < VeriSol.SumMapping(balanceOf));
        // VeriSol.Ensures(_value != VeriSol.SumMapping(balanceOf));
        // VeriSol.Requires(_value <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Requires(_value < VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Requires(_value != VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Requires(_value <= VeriSol.Old(balanceOf[msg.sender]));
        // VeriSol.Ensures(VeriSol.Old(decimals) == decimals);
        // VeriSol.Ensures(VeriSol.Old(decimals) >= decimals);
        // VeriSol.Ensures(VeriSol.Old(decimals) <= decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Ensures(VeriSol.SumMapping(balanceOf) >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Ensures(VeriSol.SumMapping(balanceOf) <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Ensures(VeriSol.SumMapping(balanceOf) >= VeriSol.Old(balanceOf[msg.sender]));
        // VeriSol.Requires(VeriSol.Old(VeriSol.SumMapping(balanceOf)) >= VeriSol.Old(balanceOf[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(totalSupply) == totalSupply);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= totalSupply);
        VeriSol.Ensures(VeriSol.Old(totalSupply) <= totalSupply);
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        //__verisol__transferFrom(_from,_to,_value)
        // VeriSol.Requires(msg.value==0);
        // VeriSol.Requires(VeriSol.Old(decimals)==18);
        // VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==1000000000000000000000000000);
        // VeriSol.Requires(VeriSol.Old(VeriSol.SumMapping(balanceOf))==1000000000000000000000000000);
        // VeriSol.Requires(VeriSol.Old(totalSupply)==1000000000000000000000000000);
        // VeriSol.Ensures(decimals==18);
        // VeriSol.Ensures(totalSupply==1000000000000000000000000000);
        // VeriSol.Ensures(_value <= VeriSol.SumMapping(balanceOf));
        // VeriSol.Ensures(_value < VeriSol.SumMapping(balanceOf));
        // VeriSol.Ensures(_value != VeriSol.SumMapping(balanceOf));
        // VeriSol.Requires(_value <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Requires(_value < VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Requires(_value != VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        // VeriSol.Ensures(VeriSol.Old(decimals) == decimals);
        // VeriSol.Ensures(VeriSol.Old(decimals) >= decimals);
        // VeriSol.Ensures(VeriSol.Old(decimals) <= decimals);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(VeriSol.Old(totalSupply) == totalSupply);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= totalSupply);
        VeriSol.Ensures(VeriSol.Old(totalSupply) <= totalSupply);
        VeriSol.Ensures(allowance[_from][msg.sender] >= 0);
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        //__verisol__approve(_spender,_value)
        // VeriSol.Ensures(VeriSol.SumMapping(balanceOf)==1000000000000000000000000000);
        // VeriSol.Ensures(totalSupply==1000000000000000000000000000);
        // // VeriSol.Requires(VeriSol.Old(VeriSol.SumMapping(balanceOf))==1000000000000000000000000000);
        // VeriSol.Requires(_value==10000000000000000000000000000);
        // VeriSol.Ensures(decimals==18);
        // VeriSol.Requires(VeriSol.Old(totalSupply)==1000000000000000000000000000);
        //VeriSol.Requires(msg.value==0);
        //VeriSol.Requires(VeriSol.Old(decimals)==18);
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) == VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) >= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(VeriSol.SumMapping(balanceOf) <= VeriSol.Old(VeriSol.SumMapping(balanceOf)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(allowance[msg.sender][_spender] == _value);
        //VeriSol.Ensures(decimals == VeriSol.Old(decimals));
        //VeriSol.Ensures(decimals >= VeriSol.Old(decimals));
        //VeriSol.Ensures(decimals <= VeriSol.Old(decimals));
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    function approveAndCall(address _spender, uint256 _value, bytes memory _extraData) public returns (bool success) {
        //__verisol__approveAndCall(_spender,_value,_extraData)
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, address(this), _extraData);
            return true;
        }
    }

    function burn(uint256 _value) public returns (bool success) {
        //__verisol__burn(_value)
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Burn(msg.sender, _value);
        return true;
    }

    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        //__verisol__burnFrom(_from,_value)
        require(balanceOf[_from] >= _value);
        require(_value <= allowance[_from][msg.sender]);
        balanceOf[_from] -= _value;
        allowance[_from][msg.sender] -= _value;
        totalSupply -= _value;
        emit Burn(_from, _value);
        return true;
    }
}