#!/usr/bin/env python

import logging
import subprocess
import sys
import pprint
import json
from .src import chifra
from alive_progress import alive_bar 
import math
import os 

def test():
    sys.argv = sys.argv[1:]
    obj = chifra().dispatch()
    pprint.pprint(obj)

def run():
    return chifra().dispatch()

def fetchBatchTransaction(tx_hashes: list):
    global sys 
    cmds =  ["chifra",  "traces"]
    for tx_hash in tx_hashes:
        cmds.append("{0}".format(tx_hash))
    cmds.extend(["-a"])
    sys.argv =  cmds 
    result = run()
    while result is None or "data" not in result or len(result["data"]) == 0:
        result = run()
        os.sleep(1)
    new_results = list()
    for tx_hash in tx_hashes:
        new_result = list()
        for tx in result["data"]:
            if tx["transactionHash"] == tx_hash:
                new_result.append(tx)
        new_results.append(new_result)
    return new_results


def fetchTransaction(tx_hash):
    global sys 

    sys.argv =  ["chifra", "traces", "{0}".format(tx_hash), "-a"]
    result = run()
    while result is None or "data" not in result or len(result["data"]) == 0:
        result = run()
    return result["data"]

def fetchTransactionsForUSDT(address, maxCount=2000, cached_record_number=0):
    global sys 
    transactions = list()
    result = json.load(open("./0xdAC17F958D2ee523a2206206994597C13D831ec7-USDT-3000txs.json"))
    batch_size = 25
    logging.warning("trace size of transactions to fetch:"+str(min(maxCount, len(result))))
    with alive_bar(math.ceil(min(maxCount, len(result))/batch_size)) as bar:
        for i in range(0, min(maxCount, len(result)), batch_size):
            tx_hashes = list()
            for tx in result[i:i+batch_size]:
                tx_hashes.append(tx["transaction_hash"])
            transactions.extend(fetchBatchTransaction(tx_hashes=tx_hashes))
            bar()
    json.dump(transactions, open("./0xdAC17F958D2ee523a2206206994597C13D831ec7-USDT-3000txs-traces.json", "w"))
    return transactions 

if __name__ == "__main__":
    TokenAddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7"
    fetchTransactionsForUSDT(address=TokenAddress, no=100)


    