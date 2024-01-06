import web3 
from web3 import Web3
import json 

my_provider = Web3.HTTPProvider("https://eth.llamarpc.com")
w3 = web3.Web3(my_provider)

def decodeFunctionInput(address, abi, tx_input):
    contract = w3.eth.contract(address=Web3.to_checksum_address(address), abi=abi)
    result = contract.decode_function_input(tx_input)
    funcName = result[0].fn_name
    inputs =  result[1]
    decoded_input = dict(name=funcName, inputs = inputs)
    return decoded_input

if __name__ == "__main__":
    address = "0x1dac5649e2a0c943ffc4211d708f6ddde4742fd6"
    contractobject = json.load(open("./tmp/"+address+".json"))
    abi = contractobject["abi"]
    tx_input = "0x211e28b60000000000000000000000000000000000000000000000000000000000000000"
    decodeFunctionInput(address=address, abi=abi, tx_input=tx_input)
    