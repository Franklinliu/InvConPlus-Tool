import csv 
import subprocess 
import time
import glob 
import os 
import sys 
import signal

csv.register_dialect('myDialect', delimiter = ',', quoting=csv.QUOTE_NONE)
myreader = csv.reader(open('./Token-data/filtered-erc20-token-year2021-22.csv').readlines(), dialect='myDialect')

# verisol_test=./verisol_test
# for file in $(ls ./Token-data/result/*.inv.json)
# do
#     IN=$(basename $file)
#     arrIN=(${IN//-/ })
#     address=${arrIN[0]}  
#     echo $address
#     timeout 1800 python3 -m invconplus.main --address $address --maxCount 200
#     cp $file $verisol_test
#     echo "mv $file $verisol_test"
#     timeout 1800 ts-node ./AutoAnnotation/main.ts $verisol_test/$IN
# done
dst = "./verisol_test"
src = "./crytic-export/etherscan-contracts"

def cp(address, src, dst):
    for item in os.listdir(src):
        _address = item.split(".etherscan.io")[0]
        if _address == address:
            if not os.path.exists(os.path.join(dst, item)):
                os.system("cp -rf " + src + "/" + item + " " + dst)

def run(cmd, timeout_s):
    try:
        p = subprocess.Popen(cmd, start_new_session=True)
        # p.wait(timeout=timeout_s)
        stdout, stderr = p.communicate(timeout= timeout_s)
        print(stdout)
        print(stderr)
        print(f'Command {cmd} finished with return code {p.returncode}')
    except subprocess.TimeoutExpired:
        print(f'Timeout for {cmd} ({timeout_s}s) expired', file=sys.stderr)
        print('Terminating the whole process group...', file=sys.stderr)
        print(f'pid: {p.pid}', file=sys.stderr)
        os.killpg(os.getpgid(p.pid), signal.SIGTERM)


def mineInvariant(address):
    cmd = ["python3", "-m", "invconplus.main", "--address", address, "--maxCount",  "200"]
    timeout_s = 60*30
    run(cmd, timeout_s)

def genAnnotation(inv_file):
    cmd = ["ts-node", "./AutoAnnotation/main.ts",  inv_file]
    timeout_s = 60*30
    run(cmd, timeout_s)

def fresh_invariant_detection():
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
   
def fresh_annotation():
    LIMIT = 3000
    start = 0
    count = 0
    addrs = list()
    for row in myreader:
        if row[0] == "address":
            continue
        count += 1
        if count < start:
            continue
        # print(count, row)
        addrs.append(row[0].strip())
        if count >= LIMIT:
            break
    print(addrs)

    invs = glob.glob("./Token-data/result/*.inv.json")
    verisol_test = "./verisol_test"
    for inv in invs:
        address = os.path.basename(inv).split("-")[0].strip()
        if address in addrs:
            time_start =  time.time()
            print(">>>>", address)
            # cp(address, src, dst)
            if not os.path.exists(os.path.join(verisol_test, os.path.basename(inv))):
                cmd = "cp {0} {1}".format(inv, verisol_test)
                os.system(cmd)
            try:
                new_file = os.path.join(verisol_test, os.path.basename(inv))
                print(new_file)
                genAnnotation(new_file)
                print(row[0], str(time.time() - time_start) + " seconds")
            except:
                print("annotation generating error")

fresh_annotation()
