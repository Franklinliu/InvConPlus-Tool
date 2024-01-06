import os 
import re  
import json

daikon_result_dir = "../daikon"
daikon_result_dir_normalized = "../daikon_normalized"


def total_invs_daikon_result(daikon_inv_file):
    total_invs = 0
    with open(daikon_inv_file, 'r') as f:
        lines = f.readlines()[5:]
        for line in lines:
            line = line.strip()
            if not line.endswith("EXIT1") and not line.endswith("Exiting Daikon.") and line != "":
                total_invs += 1
    return total_invs

def obtain_full_sig(short_func, abi):
    short_func = short_func.strip().split("(")[0]
    for item in abi:
        if item["type"] == "function":
            if item["name"] == short_func:
                return item["name"] + "(" + ",".join([input["name"] for input in item["inputs"]]) + ")"
    assert False, "Cannot find full signature for " + short_func
    return None

def normalize_daikon_result(daikon_inv_file, daikon_inv_file_normalized):
    total_inv_count = 0
    result = list()
    contractName = os.path.basename(daikon_inv_file).split(".")[0]
    address = os.path.basename(os.path.dirname(daikon_inv_file))

    abi = json.load(open("../../tmp/" + address + ".json", "r"))["abi"]
    storageLayout = json.load(open("../../tmp/" + address + ".json", "r"))["storageLayout"]["storage"]
    referenceVariables = [ item["label"] for item in storageLayout if item["type"] not in \
                          ["string", "bool", "bytes", "address", "address payable"] + ["uint"+str(i*8) for i in range(1,33)] + ["int"+str(i*8) for i in range(1,33)] + ["bytes"+str(i*8) for i in range(1,33)]]

    sumMappingVariables = [ item["label"] for item in storageLayout if item["type"] in ["mapping(address => uint256)"]]
    # print(sumMappingVariables)

    with open(daikon_inv_file_normalized, 'w') as fo:
        with open(daikon_inv_file, 'r') as f:
            lines = f.readlines()[5:]
            preconditions = []
            postconditions = []
            current_func = None 
            for line in lines:
                line = line.strip()
                if not line.endswith("EXIT1") and not line.endswith("Exiting Daikon.") and line != "" and line !=   "===========================================================================":
                    if line.find("only one value") == -1 and line.find("elements") == -1 and line.find("null") == -1 and line.find("one of") == -1 :
                        line  = line.replace("orig", "VeriSol.Old").replace("this.", "").replace(".getValue()", "")
                        line = line.replace("sum", "VeriSol.SumMapping").replace("VeriSol.SumMapping(VeriSol.Old", "VeriSol.Old(VeriSol.SumMapping").replace("[]", "")
                        if line.find("VeriSol.Old")!=-1 and line.find("post")!=-1:
                            line = line.replace("post", "")
                        
                        if line.find(".getSubValue()")!=-1:
                            if line.find("sum")!=-1:
                                continue
                            line = line.replace(".getSubValue()", "")

                        line = re.sub(r'\[\(*pair\(([\w|\.]+),([\w|\.]+)\)\)*\]', r'[\1][\2]', line)
                        if line.find("this") != -1:
                            continue
                        if line.find("lexically") != -1:
                            continue
                        if line.find(".getSubLength()")!=-1:
                            continue
                        if line.find("sorted by") != -1:
                            continue
                        if line.find("**")!=-1:
                            continue

                        line = re.sub(r'\[VeriSol\.Old\(([\w|\.]+)\)\]', r'[\1]', line)
                        line = line.replace("[(", "[").replace(")]", "]")

                        if re.match(r'.*VeriSol\.SumMapping\((\w+)\).*', line):
                            m = re.match(r'.*VeriSol\.SumMapping\((\w+)\).*VeriSol\.SumMapping\((\w+)\).*', line)
                            if m is not None and (m.group(1) not in sumMappingVariables or m.group(2) not in sumMappingVariables):
                                print(line)
                                continue
                            else:
                                m = re.match(r'.*VeriSol\.SumMapping\((\w+)\).*', line)
                                if m.group(1) not in sumMappingVariables:
                                    print(line)
                                    continue

                        if re.match(r'VeriSol\.Old\(.*\)\s+[>|<|=]+\s+VeriSol\.Old\(.*\)', line):
                            m = re.match(r'VeriSol\.Old\((.*)\)\s+[>|<|=]+\s+VeriSol\.Old\((.*)\)', line)
                            if m.group(1) == m.group(2):
                                if m.group(1) in referenceVariables:
                                    continue
                            preconditions.append(line)
                            line += "\t" + "precondition"
                        else:
                            if re.match(r'VeriSol\.Old\(.*\)\s+[>|<|=]*\s+[0-9]*$', line):
                                preconditions.append(line)
                                line += "\t" + "precondition"
                            else:
                                m = re.match(r'VeriSol\.Old\((.*)\)\s+[>|<|=]*\s+(.*)$', line)
                                if m is not None and m.group(1) == m.group(2):
                                    if m.group(1) in referenceVariables:
                                        continue
                                m = re.match(r'(.*)\s+[>|<|=]*\s+VeriSol\.Old\((.*)\)$', line)
                                if m is not None and m.group(1) == m.group(2):
                                    if m.group(1) in referenceVariables:
                                        continue
                                postconditions.append(line)
                                line += "\t" + "postcondition"

                        # fo.write(line + "\n")
                        total_inv_count += 1
                else:
                    if line.endswith("EXIT1"):
                        if current_func is not None:
                            result.append(dict(func = obtain_full_sig(current_func.split(":::EXIT1")[0].split(".")[1], abi), type= "PptType.EXIT",
                                    executionType= "TxType.NORMAL", preconditions = preconditions, postconditions = postconditions, falsified_preconditions = [], falsified_postconditions = []))
                            
                        current_func = line.strip() 
                        preconditions = []
                        postconditions = []
                    elif line.endswith("Exiting Daikon."):
                        result.append(dict(func =  obtain_full_sig(current_func.split(":::EXIT1")[0].split(".")[1], abi), type= "PptType.EXIT",
                                    executionType= "TxType.NORMAL", preconditions = preconditions, postconditions = postconditions, falsified_preconditions = [], falsified_postconditions = []))
                        preconditions = []
                        postconditions = []
                        current_func = None

                    # fo.write(line + "\n")
        json.dump(result, fo, indent=4)
    return total_inv_count

my_total_invs = 0
my_total_invs_normalized = 0
for root, dirs, files in os.walk(daikon_result_dir):
    print(root)
    new_root = daikon_result_dir_normalized
    if not os.path.exists(new_root):
        os.makedirs(new_root)
    for file in files:
        if file.endswith(".inv"):
            print(os.path.join(root, file))
            my_total_invs += total_invs_daikon_result(os.path.join(root, file))
            my_total_invs_normalized += normalize_daikon_result(os.path.join(root, file), os.path.join(new_root, os.path.basename(root)+"-"+file+".json"))

print("Total invariants: ", my_total_invs)
print("Total invariants normalized: ", my_total_invs_normalized)