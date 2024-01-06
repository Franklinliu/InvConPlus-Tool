import os 

def cp(address, src, dst):
    for item in os.listdir(src):
        _address = item.split(".etherscan.io")[0]
        if _address == address:
            os.system("cp -rf " + src + "/" + item + " " + dst)


dst = "./verisol_test"
src = "./crytic-export/etherscan-contracts"
for item in os.listdir(dst):
    address = item.split("-")[0]
    print(address)
    cp(address, src, dst)