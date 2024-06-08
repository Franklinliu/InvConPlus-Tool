import os 
from glob import iglob
import subprocess
import re
import time

def runHoudiniForAll():
    files = list(map(os.path.basename,iglob("verisol_test/"+"*.verisol.sol")))
   
    output_file = 'verisol_output.txt'
    csv_file = 'result.csv'

    with open(output_file, 'w') as ofile, open(csv_file, 'w') as result_csv:
        result_csv.write('address,contract_name,time_taken,true_count,false_count,success\n')

        for file in files:
            shell_commands = []
            match = re.match(r"^((.*)\.etherscan\.io-(.*)).verisol.sol", file)
            if match:
                address = match.group(2)
                contract_name = match.group(3)
                inv_filename = address+"-"+contract_name+".inv"
            else:
                # print("Error: file name does not match the pattern")
                continue

            # # Add invariants to the .sol file
            # inv_filename = inv_name+"-"+contract_name+".inv"
            # add_inv_command = "ts-node --esm main.ts -i "+file+" -c "+ contract_name +" -v "+inv_filename
        
            # Run VeriSol
            verisol_command = "VeriSol verisol_test/"+file+" "+ contract_name +" /contractInfer"
        
            # Analyse the output
            analyse_command = "ts-node --esm ./AutoAnnotation/analyseresult.ts -i " + file.split(".sol")[0]+ "_out.bpl -o "+address+"-"+ contract_name + ".txt"
        
            # shell_commands.append(add_inv_command+" ; "+verisol_command+" ; "+analyse_command)
            shell_commands.append(verisol_command+" ; "+analyse_command)


            # Iterate over the PowerShell commands
            for i in range(len(shell_commands)):
                print(shell_commands[i])
                # Record starting time of the command
                start_time = time.time()
                process = subprocess.Popen(
                    shell_commands[i],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    shell=True
                )
                # Wait for the process to terminate
                out, err = process.communicate()
                # Record ending time of the command
                end_time = time.time()

                # Calculate the time taken in seconds, round to 3 decimal places
                time_taken = round(end_time - start_time, 3)

                # Check if the verification was successful
                success = False
                true_count = "-"
                false_count = "-"
                success_match = re.search(r"Proof found! Formal Verification successful!", out.decode('utf-8'))
                if success_match:
                    success = True
                    # Get integer value from "Variables with True value: XX"
                    count_match = re.search(r"Variables with True value: (\d+)\nVariables with False value: (\d+)", out.decode('utf-8'))
                    if count_match:
                        true_count = count_match.group(1)
                        false_count = count_match.group(2)
                
                # Write to CSV file
                result_csv.write(f'{address},{contract_name},{time_taken},{true_count},{false_count},{success}\n')

                # Write the output to the file
                ofile.write(f'Command: {shell_commands[i]}\n')
                ofile.write(f'Output:\n{out.decode("utf-8")}\n')
                ofile.write(f'Error:\n{err.decode("utf-8")}\n')
                ofile.write('\n---\n\n')

runHoudiniForAll()