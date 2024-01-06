import csv 
import subprocess 
import time
csv.register_dialect('myDialect', delimiter = ',', quoting=csv.QUOTE_NONE)
myreader = csv.reader(open('./Token-data/filtered-erc20-token-year2021-22.csv').readlines(), dialect='myDialect')

def mineInvariant(address):
    try:
        result = subprocess.run(["python3", "-m", "invconplus.main", "--address", address, "--maxCount",  "200"], capture_output=True, text=True, check=True, timeout=60*30)
        print(result.stdout)
        print(result.stderr)
    except subprocess.TimeoutExpired:
        print("timeout for 30 minutes for address: " + address)

LIMIT = 3000
start = 0
count = 0
time_start =  time.time()
for row in myreader:
    if row[0] == "address":
        continue
    count += 1
    if count < start:
        continue
    print(count, row)
    if count >= LIMIT:
        break
    try:
        mineInvariant(row[0])
        print(row[0], str(time.time() - time_start) + " seconds")
    except:
        print("Invariant mining error")
   
