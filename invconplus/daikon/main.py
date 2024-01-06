#!/bin/python3
import os 
import json 
import invconplus.daikon.Daikon as daikon
from invconplus.daikon import Contract
import time 
import argparse
import json 

def main(address, workdir, contractName, storageLayoutJson, input_abi, transactions):
    start = time.time()
    decls_file = os.path.join(workdir,"daikon_decls.txt") 
    dtraces_file = os.path.join (workdir,"daikon_dtraces.txt") 
    daikon_full_file = os.path.join(workdir,"daikon.full.dtraces.txt") 
    
    contract =Contract.Contract(address, workdir, contractName, storageLayoutJson, input_abi,  transactions)

    # generate daikon declarations
    g_decls = daikon.getDecl(contractName, contract, contractAbi=input_abi)
    
    with open(decls_file, "w") as f:
        f.write("\n".join(g_decls))

    with open(daikon_full_file, "w") as f:
        f.write("\n".join(g_decls))


    dtraces = contract.readAllTxs()

    with open(dtraces_file, "w") as f:
        f.write("\n".join(dtraces))

    with open(daikon_full_file, "a+") as f:
        f.write("\n".join(dtraces))

    contract.printStorageVariables()
   
    contract.Daikon(address=address, full_data_trace=daikon_full_file)

    print(">>>{0}: {1} transactions; {2} seconds".format(contract.address+"-"+contract.contractName, contract.tx_no, time.time()-start))

    return daikon_full_file

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description=\
                                     'InvCon: A Dynamic Invariant Detector for Ethereum Smart Contracts!')

    parser.add_argument('--metaData', type=str, required=True, 
                        help='meta data file (including contract name, abi, storage layout, transactions, and state changes)')
    
    args = parser.parse_args()

    print(args.metaData)
    assert os.path.exists(args.metaData)
    
    metaData = json.load(open(args.metaData))
    
    address = os.path.basename(args.metaData).split(".json")[0].strip()
    contractName = metaData["contractName"]
    storageLayout = metaData["storageLayout"]
    abi = metaData["abi"]
    transactions = metaData["transactions"]

    workdir = os.path.join("./Token-data/daikon", address)
    if not os.path.exists(workdir):
        os.makedirs(workdir)
    
    main(address=address, workdir=workdir, contractName=contractName, storageLayoutJson=storageLayout, input_abi=abi, transactions=transactions)