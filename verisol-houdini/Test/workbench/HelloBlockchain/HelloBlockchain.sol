pragma solidity ^0.4.20;

contract HelloBlockchain /* is WorkbenchBase('HelloBlockchain', 'HelloBlockchain') */
{

     //Set of States
    enum StateType { Request, Respond}

    //List of properties
    StateType public  State;
    address public  Requestor;
    address public  Responder;

    string public RequestMessage;
    string public ResponseMessage;

    // constructor function
    function HelloBlockchain(string message) public
    {
        Requestor = msg.sender;
        RequestMessage = message;
        State = StateType.Request;

        // call ContractCreated() to create an instance of this workflow
        // ContractCreated();
    }

    // call this function to send a request
    function SendRequest(string requestMessage) public
    {
        if (Requestor != msg.sender)
        {
            revert();
        }

        RequestMessage = requestMessage;
        State = StateType.Request;

        // call ContractUpdated() to record this action
        // ContractUpdated('SendRequest');
    }

    // call this function to send a response
    function SendResponse(string responseMessage) public
    {
        Responder = msg.sender;

        // call ContractUpdated() to record this action
        ResponseMessage = responseMessage;
        State = StateType.Respond;
        // ContractUpdated('SendResponse');
    }
}