
import subprocess 
import os 
import csv
import time 

csv.register_dialect('myDialect', delimiter = ',', quoting=csv.QUOTE_NONE)
myreader = csv.reader(open('./Token-data/filtered-erc20-token-year2021-22.csv').readlines(), dialect='myDialect')

all_result = os.listdir("./Token-data/result")

def mineInvariant(address):
    try:
        result = subprocess.run(["python3", "-m", "invconplus.main", "--address", address, "--maxCount",  "200"], capture_output=True, text=True, check=True, timeout=60*30)
        print(result.stdout)
        print(result.stderr)
    except subprocess.TimeoutExpired:
        print("timeout for 30 minutes for address: " + address)

address_list = list()
for item in all_result:
    if item.endswith("inv.json"):
        item = item.split("-")[0]
        address_list.append(item)

count = 0
time_start =  time.time()
for row in myreader:
    if row[0] == "address":
        continue
    count += 1
    if row[0] in address_list:
        mineInvariant(row[0])
        count += 1
        print(count, row[0], str(time.time() - time_start) + " seconds")
    
