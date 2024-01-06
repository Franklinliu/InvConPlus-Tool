import os 
import json 


arithemtic = "./Token-data/scripts/arithmetic.md"

arithemtic_address  = []
with open(arithemtic, "r") as f:
    for line in f:
        print(line)
        if line.startswith("verisol_test"):
            address = line.strip().split("verisol_test/")[1].split("-")[0]
            arithemtic_address.append(address)

print(len(arithemtic_address), " detect arithmetic operations")
# exit(0)
workdir =  "./tmp"

for json_file in os.listdir(workdir):
    address = json_file.split(".")[0]
    if os.path.isdir(workdir + "/" + json_file):
        continue
    obj = json.load(open(workdir + "/" + json_file))
    if "transactions" not in obj:
        continue
    transactions = obj["transactions"]
    for transaction in transactions:
        for call_item in transaction:
            txHash = call_item["transactionHash"]
            
            if "from" in call_item["action"]:
                msgSender = call_item["action"]["from"]
            else:
                msgSender = None
            if "callType" in call_item["action"]:
                callType = call_item["action"]["callType"]
            else:
                callType = None
            if msgSender is not None and callType is not None:
                if "articulatedTrace" in  call_item:
                    if "name" in call_item["articulatedTrace"]:
                        funcName = call_item["articulatedTrace"]["name"]
                        if funcName == "transfer":
                            inputs = call_item["articulatedTrace"]["inputs"]
                            for var in inputs:
                                    MaybeToAddress = inputs[var]
                                    if MaybeToAddress == msgSender:
                                        print(txHash)
                                        print(msgSender)
                                        print(MaybeToAddress)
                                        print(callType)
                                        print(workdir + "/" + json_file)
                                        if address in arithemtic_address:
                                            print("arithmetic")
                                        print("=====================================")
