pragma solidity ^0.5.10;

import "./VeriSolContracts.sol";

contract YouToken {
    using SafeMath for uint256;

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    event Transfer(address indexed from, address indexed to, uint tokens);

    string public constant name = "YOUTOKEN";
    string public constant symbol = "YTK";
    uint8 public constant decimals = 8;
    mapping(address => uint256) internal balances;
    mapping(address => mapping(address => uint256)) internal allowed;
    uint256 public totalSupply;
    address public owner;
    address public technologyBalances;
    address public operationBalances;

    constructor() public {
        uint256 tmp = 10 ** 8;
        totalSupply = 10000000000 * tmp;
        owner = msg.sender;
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public returns (bool) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(receiver!=address(0));
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires(totalSupply==1000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(numTokens>0);
        VeriSol.Requires(operationBalances==address(0));
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(technologyBalances==address(0));
        VeriSol.Requires(balances[msg.sender]>0);
        VeriSol.Requires(receiver != msg.sender);
        VeriSol.Requires(receiver != (operationBalances));
        VeriSol.Requires(receiver != (owner));
        VeriSol.Requires(receiver != (technologyBalances));
        VeriSol.Requires((balances[receiver]) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[receiver]) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[receiver]) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((balances[receiver]) <= (totalSupply));
        VeriSol.Requires((balances[receiver]) < (totalSupply));
        VeriSol.Requires((balances[receiver]) != (totalSupply));
        VeriSol.Requires((balances[receiver]) != numTokens);
        VeriSol.Requires((balances[receiver]) != (balances[msg.sender]));
        VeriSol.Requires((VeriSol.SumMapping(balances)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= numTokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) > numTokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) != numTokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (balances[msg.sender]));
        VeriSol.Requires((totalSupply) >= numTokens);
        VeriSol.Requires((totalSupply) > numTokens);
        VeriSol.Requires((totalSupply) != numTokens);
        VeriSol.Requires((totalSupply) >= (balances[msg.sender]));
        VeriSol.Requires(msg.sender != (operationBalances));
        VeriSol.Requires(msg.sender != (technologyBalances));
        VeriSol.Requires(numTokens <= (balances[msg.sender]));
        VeriSol.Requires((operationBalances) != (owner));
        VeriSol.Requires((operationBalances) == (technologyBalances));
        VeriSol.Requires((owner) != (technologyBalances));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==1000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Ensures(balances[receiver]>0);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(operationBalances==address(0));
        VeriSol.Ensures(technologyBalances==address(0));
        VeriSol.Ensures(receiver != owner);
        VeriSol.Ensures(receiver != operationBalances);
        VeriSol.Ensures(receiver != technologyBalances);
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(balances[receiver]));
        VeriSol.Ensures(totalSupply > VeriSol.Old(balances[receiver]));
        VeriSol.Ensures(totalSupply != VeriSol.Old(balances[receiver]));
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= numTokens);
        VeriSol.Ensures(totalSupply > numTokens);
        VeriSol.Ensures(totalSupply != numTokens);
        VeriSol.Ensures(totalSupply >= balances[receiver]);
        VeriSol.Ensures(totalSupply > balances[receiver]);
        VeriSol.Ensures(totalSupply != balances[receiver]);
        VeriSol.Ensures(totalSupply >= balances[msg.sender]);
        VeriSol.Ensures(totalSupply > balances[msg.sender]);
        VeriSol.Ensures(totalSupply != balances[msg.sender]);
        VeriSol.Ensures(totalSupply >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(balances[receiver]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) > VeriSol.Old(balances[receiver]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) != VeriSol.Old(balances[receiver]));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= numTokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > numTokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != numTokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= balances[receiver]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > balances[receiver]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != balances[receiver]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != balances[msg.sender]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(balances[receiver]) <= balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(balances[receiver]) < balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(balances[receiver]) != balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) > balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) > balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) > balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) != balances[receiver]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) > balances[msg.sender]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) != balances[msg.sender]);
        VeriSol.Ensures(msg.sender != operationBalances);
        VeriSol.Ensures(msg.sender != technologyBalances);
        VeriSol.Ensures(numTokens <= balances[receiver]);
        VeriSol.Ensures(numTokens != balances[msg.sender]);
        VeriSol.Ensures(balances[receiver] != balances[msg.sender]);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] < VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(balances[msg.sender] != VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(operationBalances) != owner);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == operationBalances);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(VeriSol.Old(owner) != operationBalances);
        VeriSol.Ensures(VeriSol.Old(owner) != technologyBalances);
        VeriSol.Ensures(owner != operationBalances);
        VeriSol.Ensures(owner != VeriSol.Old(technologyBalances));
        VeriSol.Ensures(owner != technologyBalances);
        VeriSol.Ensures(operationBalances == VeriSol.Old(technologyBalances));
        VeriSol.Ensures(operationBalances == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(technologyBalances) == technologyBalances);
        //End of invariants
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint numTokens) public returns (bool) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(delegate!=address(0));
        VeriSol.Requires(allowed[msg.sender][delegate]==0);
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires(totalSupply==1000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(numTokens>0);
        VeriSol.Requires(numTokens==1996700000000000);
        VeriSol.Requires(operationBalances==address(0));
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(technologyBalances==address(0));
        VeriSol.Requires(delegate != msg.sender);
        VeriSol.Requires(delegate != (operationBalances));
        VeriSol.Requires(delegate != (owner));
        VeriSol.Requires(delegate != (technologyBalances));
        VeriSol.Requires((allowed[msg.sender][delegate]) <= (VeriSol.SumMapping(balances)));
        VeriSol.Requires((allowed[msg.sender][delegate]) < (VeriSol.SumMapping(balances)));
        VeriSol.Requires((allowed[msg.sender][delegate]) != (VeriSol.SumMapping(balances)));
        VeriSol.Requires((allowed[msg.sender][delegate]) <= (totalSupply));
        VeriSol.Requires((allowed[msg.sender][delegate]) < (totalSupply));
        VeriSol.Requires((allowed[msg.sender][delegate]) != (totalSupply));
        VeriSol.Requires((allowed[msg.sender][delegate]) <= numTokens);
        VeriSol.Requires((allowed[msg.sender][delegate]) < numTokens);
        VeriSol.Requires((allowed[msg.sender][delegate]) != numTokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= numTokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) > numTokens);
        VeriSol.Requires((VeriSol.SumMapping(balances)) != numTokens);
        VeriSol.Requires((totalSupply) >= numTokens);
        VeriSol.Requires((totalSupply) > numTokens);
        VeriSol.Requires((totalSupply) != numTokens);
        VeriSol.Requires(msg.sender != (operationBalances));
        VeriSol.Requires(msg.sender != (owner));
        VeriSol.Requires(msg.sender != (technologyBalances));
        VeriSol.Requires((operationBalances) != (owner));
        VeriSol.Requires((operationBalances) == (technologyBalances));
        VeriSol.Requires((owner) != (technologyBalances));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==1000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Ensures(allowed[msg.sender][delegate]>0);
        VeriSol.Ensures(allowed[msg.sender][delegate]==1996700000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(operationBalances==address(0));
        VeriSol.Ensures(technologyBalances==address(0));
        VeriSol.Ensures(delegate != owner);
        VeriSol.Ensures(delegate != operationBalances);
        VeriSol.Ensures(delegate != technologyBalances);
        VeriSol.Ensures(totalSupply >= VeriSol.Old(allowed[msg.sender][delegate]));
        VeriSol.Ensures(totalSupply > VeriSol.Old(allowed[msg.sender][delegate]));
        VeriSol.Ensures(totalSupply != VeriSol.Old(allowed[msg.sender][delegate]));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= numTokens);
        VeriSol.Ensures(totalSupply > numTokens);
        VeriSol.Ensures(totalSupply != numTokens);
        VeriSol.Ensures(totalSupply >= allowed[msg.sender][delegate]);
        VeriSol.Ensures(totalSupply > allowed[msg.sender][delegate]);
        VeriSol.Ensures(totalSupply != allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][delegate]) <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][delegate]) < VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][delegate]) != VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][delegate]) <= allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][delegate]) < allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(allowed[msg.sender][delegate]) != allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= numTokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > numTokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != numTokens);
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) > allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.SumMapping(balances) != allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) >= allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) > allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(VeriSol.SumMapping(balances)) != allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) >= allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) > allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(totalSupply) != allowed[msg.sender][delegate]);
        VeriSol.Ensures(msg.sender != owner);
        VeriSol.Ensures(msg.sender != operationBalances);
        VeriSol.Ensures(msg.sender != technologyBalances);
        VeriSol.Ensures(numTokens == allowed[msg.sender][delegate]);
        VeriSol.Ensures(numTokens >= allowed[msg.sender][delegate]);
        VeriSol.Ensures(numTokens <= allowed[msg.sender][delegate]);
        VeriSol.Ensures(VeriSol.Old(operationBalances) != owner);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == operationBalances);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(VeriSol.Old(owner) != operationBalances);
        VeriSol.Ensures(VeriSol.Old(owner) != technologyBalances);
        VeriSol.Ensures(owner != operationBalances);
        VeriSol.Ensures(owner != VeriSol.Old(technologyBalances));
        VeriSol.Ensures(owner != technologyBalances);
        VeriSol.Ensures(operationBalances == VeriSol.Old(technologyBalances));
        VeriSol.Ensures(operationBalances == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(technologyBalances) == technologyBalances);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        //End of invariants
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address from, address delegate) public view returns (uint) {
        return allowed[from][delegate];
    }

    function transferFrom(address from, address buyer, uint numTokens) public returns (bool) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires(totalSupply==1000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(operationBalances==address(0));
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(technologyBalances==address(0));
        VeriSol.Requires((VeriSol.SumMapping(balances)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= (totalSupply));
        VeriSol.Requires(msg.sender != (operationBalances));
        VeriSol.Requires(msg.sender != (technologyBalances));
        VeriSol.Requires((operationBalances) != (owner));
        VeriSol.Requires((operationBalances) == (technologyBalances));
        VeriSol.Requires((owner) != (technologyBalances));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==1000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(operationBalances==address(0));
        VeriSol.Ensures(technologyBalances==address(0));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(msg.sender != operationBalances);
        VeriSol.Ensures(msg.sender != technologyBalances);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(operationBalances) != owner);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == operationBalances);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(VeriSol.Old(owner) != operationBalances);
        VeriSol.Ensures(VeriSol.Old(owner) != technologyBalances);
        VeriSol.Ensures(owner != operationBalances);
        VeriSol.Ensures(owner != VeriSol.Old(technologyBalances));
        VeriSol.Ensures(owner != technologyBalances);
        VeriSol.Ensures(operationBalances == VeriSol.Old(technologyBalances));
        VeriSol.Ensures(operationBalances == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(technologyBalances) == technologyBalances);
        //End of invariants
        require(numTokens <= balances[from]);
        require(numTokens <= allowed[from][msg.sender]);
        balances[from] = balances[from].sub(numTokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(from, buyer, numTokens);
        return true;
    }

    function burnFrom(address from, uint numTokens) public returns (bool) {
        //Begin of assumptions
        //End of assumptions
        //Begin of invariants
        VeriSol.Requires(VeriSol.SumMapping(balances)>0);
        VeriSol.Requires(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Requires(totalSupply>0);
        VeriSol.Requires(totalSupply==1000000000000000000);
        VeriSol.Requires(msg.sender!=address(0));
        VeriSol.Requires(operationBalances==address(0));
        VeriSol.Requires(owner!=address(0));
        VeriSol.Requires(technologyBalances==address(0));
        VeriSol.Requires((VeriSol.SumMapping(balances)) == (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) >= (totalSupply));
        VeriSol.Requires((VeriSol.SumMapping(balances)) <= (totalSupply));
        VeriSol.Requires(msg.sender != (operationBalances));
        VeriSol.Requires(msg.sender != (technologyBalances));
        VeriSol.Requires((operationBalances) != (owner));
        VeriSol.Requires((operationBalances) == (technologyBalances));
        VeriSol.Requires((owner) != (technologyBalances));
        VeriSol.Ensures(totalSupply>0);
        VeriSol.Ensures(totalSupply==1000000000000000000);
        VeriSol.Ensures(VeriSol.SumMapping(balances)>0);
        VeriSol.Ensures(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.Ensures(owner!=address(0));
        VeriSol.Ensures(operationBalances==address(0));
        VeriSol.Ensures(technologyBalances==address(0));
        VeriSol.Ensures(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.Ensures(totalSupply == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(totalSupply == VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(totalSupply <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(VeriSol.SumMapping(balances)));
        VeriSol.Ensures(VeriSol.SumMapping(balances) == VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) >= VeriSol.Old(totalSupply));
        VeriSol.Ensures(VeriSol.SumMapping(balances) <= VeriSol.Old(totalSupply));
        VeriSol.Ensures(msg.sender != operationBalances);
        VeriSol.Ensures(msg.sender != technologyBalances);
        VeriSol.Ensures(balances[msg.sender] <= VeriSol.Old(balances[msg.sender]));
        VeriSol.Ensures(VeriSol.Old(operationBalances) != owner);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == operationBalances);
        VeriSol.Ensures(VeriSol.Old(operationBalances) == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(owner) == owner);
        VeriSol.Ensures(VeriSol.Old(owner) != operationBalances);
        VeriSol.Ensures(VeriSol.Old(owner) != technologyBalances);
        VeriSol.Ensures(owner != operationBalances);
        VeriSol.Ensures(owner != VeriSol.Old(technologyBalances));
        VeriSol.Ensures(owner != technologyBalances);
        VeriSol.Ensures(operationBalances == VeriSol.Old(technologyBalances));
        VeriSol.Ensures(operationBalances == technologyBalances);
        VeriSol.Ensures(VeriSol.Old(technologyBalances) == technologyBalances);
        //End of invariants
        require(numTokens <= balances[from]);
        require(msg.sender == owner);
        balances[from] = balances[from].sub(numTokens);
        balances[owner] = balances[owner].add(numTokens);
        return true;
    }

    function contractInvariant() private view {
        VeriSol.ContractInvariant(operationBalances==address(0));
        VeriSol.ContractInvariant(totalSupply>0);
        VeriSol.ContractInvariant(totalSupply==1000000000000000000);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)>0);
        VeriSol.ContractInvariant(VeriSol.SumMapping(balances)==1000000000000000000);
        VeriSol.ContractInvariant(owner!=address(0));
        VeriSol.ContractInvariant(technologyBalances==address(0));
        VeriSol.ContractInvariant(operationBalances != owner);
        VeriSol.ContractInvariant(operationBalances == technologyBalances);
        VeriSol.ContractInvariant(totalSupply == VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(totalSupply >= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(totalSupply <= VeriSol.SumMapping(balances));
        VeriSol.ContractInvariant(owner != technologyBalances);
    }
}

library SafeMath {
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