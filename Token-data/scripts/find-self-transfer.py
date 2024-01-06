import os 
import json 

workdir =  "./tmp"

token_dir = "./Token-data/result"

token_address = []
for json_file in os.listdir(token_dir):
    if json_file.startswith("0x") and json_file.endswith(".json") and not json_file.endswith(".inv.json"):
        token_address.append(json_file.split(".")[0].split("-")[0])

for json_file in os.listdir(workdir):
    if os.path.isdir(workdir + "/" + json_file):
        continue
    obj = json.load(open(workdir + "/" + json_file))
    if "transactions" not in obj:
        continue

    address = json_file.split(".")[0]
    if address not in token_address:
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
                                        print("=====================================")
