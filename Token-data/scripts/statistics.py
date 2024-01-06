import csv
import matplotlib.pyplot as plt
import numpy as np 
import os
import glob
import json 

import matplotlib 
font = {'family' : 'sans-serif',
        'weight' : 'normal',
        'size'   : 12}

matplotlib.rc('font', **font)

result_excel_file = "../result-excels/1-2-Sept-new_result.csv"
output_csv_file = "./statistics.csv"
final_results = dict()
with open(result_excel_file) as f:
    csv_file = csv.reader(f.readlines()[1:])
    iterations_sum_trueinvariants =  list()
    maxIteration =  0
    for line in csv_file:
        address, contract_name, time_taken, true_count, false_count, success = line 
        time_taken = int(time_taken)
        true_count =  int(true_count)
        false_count = int(false_count)
        success = True if success == "true" else False
        if success:
            if address not in final_results:
                final_results[address] = dict()
                final_results[address][1] = {   "contract_name": contract_name,\
                                                "time_taken": time_taken,  \
                                                "true_count":true_count
                                            }
            
            else:
                maxIteration = max(final_results[address].keys())
                final_results[address][maxIteration+1] = {   "contract_name": contract_name,\
                                                "time_taken": time_taken,  \
                                                "true_count":   true_count
                                            }
               
    print(len(final_results))


result_excel_file_wo_partial = "../result-excels/WO-PartialInvariant-12-Sept-new_result.csv"
wo_p_final_results = dict()
with open(result_excel_file_wo_partial) as f:
    csv_file = csv.reader(f.readlines()[1:])
    iterations_sum_trueinvariants =  list()
    maxIteration =  0
    for line in csv_file:
        address, contract_name, time_taken, true_count, false_count, success = line 
        time_taken = int(time_taken)
        true_count =  int(true_count)
        false_count = int(false_count)
        success = True if success == "true" else False
        if success:
            if address not in wo_p_final_results:
                if address not in final_results:
                    continue
                wo_p_final_results[address] = dict()
                wo_p_final_results[address][1] = {   "contract_name": contract_name,\
                                                "time_taken": time_taken,  \
                                                "true_count":true_count
                                            }
            
            else:
                maxIteration = max(wo_p_final_results[address].keys())
                wo_p_final_results[address][maxIteration+1] = {   "contract_name": contract_name,\
                                                "time_taken": time_taken,  \
                                                "true_count":   true_count
                                            }
               
    print(len(wo_p_final_results))

with open(output_csv_file, "w") as fo:
        fo.write(",".join(["address", "contract_name", "time_taken", "true_count", "iteration"])+ "\n")
        statistcs = list()
        for address in final_results:
            minIteration = min(final_results[address].keys())
            minItem = final_results[address][minIteration]
            maxIteration = max(final_results[address].keys())
            maxItem = final_results[address][maxIteration]
            statistcs.append(",".join([address,\
                                maxItem["contract_name"],\
                                    str(maxItem["time_taken"]),\
                                        str(maxItem["true_count"]), \
                                            str(maxIteration)]))
        fo.write("\n".join(statistcs))

def calculateAvgUsefulnessRecall():
    my_result_1 = dict()
    statistic_logs = "../ground_truth/statistics.log"
    with open(statistic_logs) as f:
        lines = f.readlines()[1:]
        size =  0
        address = None
        iteration = None
        while size < len(lines):
            if lines[size].startswith(">>>") and lines[size].find("-")!=-1:
                address = lines[size].split(">>>")[1].split("-")[0].strip()
                if address not in final_results:
                    address = None
                    iteration = None
                    size += 1
                    continue
                iteration = int(lines[size].split(">>>")[1].split("-")[1].strip())+1
            elif lines[size].startswith("usefulness") and address is not None and iteration is not None:
                usefulness = float(lines[size].split("usefulness:")[1].split(",")[0].strip())
                recall = float(lines[size].split("recall:")[1].strip())
                if address not in my_result_1:
                    my_result_1[address] = dict()
                my_result_1[address][iteration] = {"usefulness": usefulness, "recall": recall}
                inv_file =glob.glob(os.path.join("../out-2-Sept-smt-simply", address+ "-*.txt-"+str(iteration-1)))[0]
                assert os.path.exists(inv_file)
                with open(inv_file) as f:
                    summary = f.readlines()[0].strip()
                    true_count = int(summary.split("smt-simplified result:")[1].split("invariants")[0].strip())
                my_result_1[address][iteration]["true_count"] = true_count
                address = None
                iteration = None
            else:
                pass 
            size += 1

    statistic_logs = "../ground_truth/statistics.log"
    init_result = dict()
    with open(statistic_logs) as f:
        lines = f.readlines()[1:]
        size =  0
        address = None
        while size < len(lines):
            if lines[size].startswith(">>>") and lines[size].find("-")==-1:
                address = lines[size].split(">>>")[1].strip()
                if address not in final_results:
                    address = None
                    size += 1
                    continue
                
            elif lines[size].startswith("usefulness") and address is not None:
                usefulness = float(lines[size].split("usefulness:")[1].split(",")[0].strip())
                recall = float(lines[size].split("recall:")[1].strip())
                if address not in my_result_1:
                    my_result_1[address] = dict()
                init_result[address] = {"usefulness": usefulness, "recall": recall}
                # get invariant number
                inv_file =glob.glob(os.path.join("../result", address+ "-*.inv.json"))[0]
                assert os.path.exists(inv_file)
                with open(inv_file) as f:
                    data = json.load(f)
                    true_count = sum([
                        len(item["preconditions"]) + len(item["postconditions"]) if item["func"] is not None else 
                        len(item["postconditions"])
                        for item in data
                        if item["executionType"] == "TxType.NORMAL"
                    ])
                init_result[address]["true_count"] = true_count
                address = None
            else:
                pass 
            size += 1
    
    my_result_2 = dict()
    statistic_logs = "../ground_truth/statistics-out-12-Sept.log"
    with open(statistic_logs) as f:
        lines = f.readlines()[1:]
        size =  0
        address = None
        iteration = None
        while size < len(lines):
            if lines[size].startswith(">>>") and lines[size].find("-")!=-1:
                address = lines[size].split(">>>")[1].split("-")[0].strip()
                if address not in final_results:
                    address = None
                    iteration = None
                    size += 1
                    continue
                iteration = int(lines[size].split(">>>")[1].split("-")[1].strip())+1
            elif lines[size].startswith("usefulness") and address is not None and iteration is not None:
                usefulness = float(lines[size].split("usefulness:")[1].split(",")[0].strip())
                recall = float(lines[size].split("recall:")[1].strip())
                if address not in my_result_2:
                    my_result_2[address] = dict()
                my_result_2[address][iteration] = {"usefulness": usefulness, "recall": recall}
                inv_file =glob.glob(os.path.join("../out-12-Sept-WO-PartialInvariant-smt-simply", address+ "-*.txt-"+str(iteration-1)))[0]
                assert os.path.exists(inv_file)
                with open(inv_file) as f:
                    summary = f.readlines()[0].strip()
                    true_count = int(summary.split("smt-simplified result:")[1].split("invariants")[0].strip())
                my_result_2[address][iteration]["true_count"] = true_count
                address = None
                iteration = None
            else:
                pass 
            size += 1

    # InvCon statistics
    maxUsefulness = []
    maxRecall = []
    maxTrueCount = []
    minUsefulness = []
    minRecall = []
    minTrueCount = []
    for address in my_result_1:
        maxIteration = max(my_result_1[address].keys())
        maxItem = my_result_1[address][maxIteration]
        maxUsefulness.append(maxItem["usefulness"])
        maxRecall.append(maxItem["recall"])
        maxTrueCount.append(maxItem["true_count"])
        minIteration = min(my_result_1[address].keys())
        minItem = my_result_1[address][minIteration]
        minUsefulness.append(minItem["usefulness"])
        minRecall.append(minItem["recall"])
        minTrueCount.append(minItem["true_count"])
    print("average usefulness (InvCon): ", np.average(maxUsefulness))
    print("average recall (InvCon): ", np.average(maxRecall))
    print("true count (InvCon): ", np.sum(maxTrueCount))
    print("average usefulness (InvCon) (w/o implication): ", np.average(minUsefulness))
    print("average recall (InvCon) (w/o implication): ", np.average(minRecall))
    print("true count (InvCon) (w/o implication): ", np.sum(minTrueCount))
    
    maxUsefulness = []
    maxRecall = []
    maxTrueCount = []
    minUsefulness = []
    minRecall = []
    minTrueCount = []
    for address in my_result_2:
        maxIteration = max(my_result_2[address].keys())
        maxItem = my_result_2[address][maxIteration]
        maxUsefulness.append(maxItem["usefulness"])
        maxRecall.append(maxItem["recall"])
        maxTrueCount.append(maxItem["true_count"])
        minIteration = min(my_result_2[address].keys())
        minItem = my_result_2[address][minIteration]
        minUsefulness.append(minItem["usefulness"])
        minRecall.append(minItem["recall"])
        minTrueCount.append(minItem["true_count"])
    
    print("average usefulness (InvCon) (w/o p): ", np.average(maxUsefulness))
    print("average recall (InvCon) (w/o p): ", np.average(maxRecall))
    print("true count (InvCon) (w/o p): ", np.sum(maxTrueCount))
    print("average usefulness (InvCon) (w/o implication) (w/o p): ", np.average(minUsefulness))
    print("average recall (InvCon) (w/o implication) (w/o p): ", np.average(minRecall))
    print("true count (InvCon) (w/o implication) (w/o p): ", np.sum(minTrueCount))

    # init statistics
    maxUsefulness = []
    maxRecall = []
    maxTrueCount = []
    for address in init_result:
        maxUsefulness.append(init_result[address]["usefulness"])
        maxRecall.append(init_result[address]["recall"])
        maxTrueCount.append(init_result[address]["true_count"])
    print("average usefulness (init): ", np.average(maxUsefulness))
    print("average recall (init): ", np.average(maxRecall))
    print("true count (init): ", np.sum(maxTrueCount))


def calculateAvgTimeCost():
    minTimes = list()
    maxTimes = list()
    for address in final_results:
        minIteration = min(final_results[address].keys())
        minItem = final_results[address][minIteration]
        minTimes.append(minItem["time_taken"])
        maxIteration = max(final_results[address].keys())
        maxItem = final_results[address][maxIteration]
        maxTimes.append(maxItem["time_taken"])

    print("average time cost (seconds) (w/o implication): ", np.average(minTimes)/1000)
    print("average time cost (seconds) (with implication): ", np.average(maxTimes)/1000)

    minTimes = list()
    maxTimes = list()
    for address in wo_p_final_results:
        minIteration = min(wo_p_final_results[address].keys())
        minItem = wo_p_final_results[address][minIteration]
        minTimes.append(minItem["time_taken"])
        maxIteration = max(wo_p_final_results[address].keys())
        maxItem = wo_p_final_results[address][maxIteration]
        maxTimes.append(maxItem["time_taken"])
    print("average time cost (seconds) (w/o p): ", np.average(maxTimes)/1000)


    # capped at four 
    fourTimes = list()
    for address in final_results:
        maxIteration = max(final_results[address].keys())
        if maxIteration > 4:
            maxIteration = 4
        maxItem = final_results[address][maxIteration]
        fourTimes.append(maxItem["time_taken"])
    
    print("average time cost (seconds) (capped at 4): ", np.average(fourTimes)/1000)

def plotTimeCost():               
    # time cost 
    my_iterations = list()
    my_time_takens = list()
    for address in final_results:
        for iteration in final_results[address]:
            my_time_takens.append(final_results[address][iteration]["time_taken"])
            my_iterations.append(iteration)
    fig, ax = plt.subplots()
    
    X = np.array(range(1, np.max(my_iterations)+1))
    Y1 = np.array([ np.average([ my_time_takens[index]
                  for index in range(len(my_time_takens)) if my_iterations[index] == iteration]) for iteration in range(1, np.max(my_iterations)+1)])

    print(X, Y1)
    ax.plot(X, Y1/1000)
    ax.set_ylabel('time (seconds)', fontsize = 14)
    ax.set_xlabel('iterations',fontsize = 14)
    plt.savefig("TimeCost-Iteration.pdf")

    fig, ax = plt.subplots()
    my_iterations
    my_invariants = list()
    addresses =  list()
    for address in final_results:
        for iteration in final_results[address]:
            inv_file =glob.glob(os.path.join("../out-2-Sept-smt-simply", address+ "-*.txt-"+str(iteration-1)))[0]
            assert os.path.exists(inv_file)
            with open(inv_file) as f:
                summary = f.readlines()[0].strip()
                true_count = int(summary.split("smt-simplified result:")[1].split("invariants")[0].strip())
                my_invariants.append(true_count)
                my_iterations.append(iteration)
                addresses.append(address)
    

    X  = np.array(range(1, np.max(my_iterations)+1))
    Y2 = np.array([ np.average([ my_invariants[index]
                    for index in range(len(my_invariants)) if my_iterations[index] == iteration or \
                         ( max(final_results[addresses[index]].keys()) < iteration\
                           and my_iterations[index] == max(final_results[addresses[index]].keys()) )]) \
                            for iteration in range(1, np.max(my_iterations)+1)])
    print(X, Y2)
    ax.plot(X, Y2)
    ax.set_ylabel('invariant number (per contract)', fontsize = 14)
    ax.set_xlabel('iterations', fontsize = 14)
    plt.savefig("Iteration-Invariant-Per-Contract.pdf")

    fig, ax1 = plt.subplots()
    ax1.plot(X, Y1/1000, color="C0", label = "time")
    ax1.set_ylabel('time (seconds)', fontsize = 14, color="C0")
    ax1.tick_params(axis='y', color='C0', labelcolor='C0')

    ax2 = ax1.twinx()
    ax2.plot(X, Y2, color="C1", label = "invariant")
    ax2.set_ylabel('invariant', fontsize = 14, color="C1")
    ax2.tick_params(axis='y', color='C1', labelcolor='C1')

    ax1.set_xlabel('iterations', fontsize = 14)
    plt.savefig("Iteration-Time-Invariant.pdf")


    usefulnesses = list()
    recalls = list()
    my_iterations = list()
    addresses =  list()
    statistic_logs = "../ground_truth/statistics.log"
    with open(statistic_logs) as f:
        lines = f.readlines()[1:]
        size =  0
        address = None
        iteration = None
        while size < len(lines):
            if lines[size].startswith(">>>") and lines[size].find("-")!=-1:
                address = lines[size].split(">>>")[1].split("-")[0].strip()
                if address not in final_results:
                    address = None
                    iteration = None
                    size += 1
                    continue
                iteration = int(lines[size].split(">>>")[1].split("-")[1].strip())+1
                my_iterations.append(iteration)
                addresses.append(address)
            elif lines[size].startswith("usefulness") and address is not None and iteration is not None:
                usefulnesses.append(float(lines[size].split("usefulness:")[1].split(",")[0].strip()))
                recalls.append(float(lines[size].split("recall:")[1].strip()))
                address = None
                iteration = None
            else:
                pass 
            size += 1

    X = np.array(range(1, np.max(my_iterations)+1))
    Y1 = np.array([ np.average([ usefulnesses[index]
                    for index in range(len(usefulnesses)) if my_iterations[index] == iteration or \
                         ( max(final_results[addresses[index]].keys()) < iteration\
                           and my_iterations[index] == max(final_results[addresses[index]].keys()) )]) \
                            for iteration in range(1, np.max(my_iterations)+1)])
    Y2 = np.array([ np.average([ recalls[index]
                    for index in range(len(recalls)) if my_iterations[index] == iteration or \
                         ( max(final_results[addresses[index]].keys()) < iteration\
                           and my_iterations[index] == max(final_results[addresses[index]].keys()) )]) \
                            for iteration in range(1, np.max(my_iterations)+1)])
    fig, ax = plt.subplots()
    ax.plot(X, Y1, label = "usefulness")
    ax.plot(X, Y2, label = "recall")
    ax.set_ylabel('usefulness/recall', fontsize = 14)
    ax.set_xlabel('iterations', fontsize = 14)
    ax.legend()
    plt.savefig("Iteration-Usefulness-Recall.pdf")
    


def calculateInvariantMiningTimeCost():  
    invariant_log = "../batch.log"
    with open(invariant_log) as f:
        invariant_times = list()
        address = None 
        tx_count = None 
        time = None 
        for line in f.readlines():
            if line.startswith("0x"):
                address =  line.strip()
                tx_count =  None 
                time = None 
            elif line.find("Generating invariants... for")!=-1:
                tx_count = int(line.strip().split("Generating invariants... for")[-1].split("txs")[0].strip())
            elif line.find("Time used: ")!=-1:
                time = float(line.strip().split("Time used: ")[-1].split("seconds")[0].strip())
                invariant_times.append((address, tx_count, time))
            else:
                pass
        
        my_tx_counts =  list()
        my_time_takens = list()
        for item in invariant_times:
            my_tx_counts.append(item[1])
            my_time_takens.append(item[2])
        
        my_tx_counts = np.array(my_tx_counts)
        my_time_takens = np.array(my_time_takens)

        print("average transaction mining time: ", np.average(my_time_takens), np.max(my_time_takens))
        print("total transaction number: ", np.sum(my_tx_counts))

def calculateDaikonInvariantMiningTimeCost():  
    invariant_log = "../batch_daikon.log"
    with open(invariant_log) as f:
        import re 
        invariant_times = list()
        address = None 
        tx_count = None 
        time = None 
        for line in f.readlines():
            if line.startswith(">>>"):
                line = line.strip()
                # print(line)
                pattern = re.compile(">>>(0x[0-9a-fA-F]*)-([\$\w]+):\s+(\d+)\s+transactions;\s+(\d+\.\d+)\s+seconds")
                m = pattern.match(line)
                address =  m.group(1)
                name = m.group(2)
                tx_count =  int(m.group(3))
                time = float(m.group(4))
                if time > 10:
                    print(address, name, tx_count, time)
                invariant_times.append((address, tx_count, time))
            else:
                pass
        
        my_tx_counts =  list()
        my_time_takens = list()
        for item in invariant_times:
            my_tx_counts.append(item[1])
            my_time_takens.append(item[2])
        
        my_tx_counts = np.array(my_tx_counts)
        my_time_takens = np.array(my_time_takens)
        print(">>> Daikon")
        print("average transaction mining time: ", np.average(my_time_takens), np.max(my_time_takens))
        print("total transaction number: ", np.sum(my_tx_counts))



# calculateAvgTimeCost()
# plotTimeCost()
# calculateInvariantMiningTimeCost()
# calculateAvgUsefulnessRecall()
calculateDaikonInvariantMiningTimeCost()


    


