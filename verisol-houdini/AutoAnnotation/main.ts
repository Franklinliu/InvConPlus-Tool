import * as fs from 'fs';
import * as path from 'path';
import { CompileFailedError, CompileResult, compileSol, ASTReader, ContractDefinition, FunctionDefinition, Block, Identifier, SourceUnit, compile, compileSourceString, ASTWriter, PrettyFormatter, DefaultASTWriterMapping, StateVariableVisibility, MemberAccess, InferType, FunctionType, FunctionLikeSetType, FunctionKind, FunctionVisibility, FunctionStateMutability, ParameterList} from "solc-typed-ast";
import * as shell from 'shelljs';
import assert = require('assert');
import { exit } from 'process';

const output_file = 'new_result.csv'
fs.writeFileSync(output_file, "address,contract_name,time_taken,true_count,false_count,success\n", "utf-8");


const SetDifference = (a: Set<string>, b: Set<string>) => new Set([...a].filter(x => !b.has(x)));
const SetIntersection = (a: Set<string>, b: Set<string>) => new Set([...a].filter(x => b.has(x)));
const SetUnion = (a: Set<string>, b: Set<string>) => new Set([...a, ...b]);
class Compiler{
    contractName: string;
    contractFile: string;
    constructor(contractFile: string, contractName: string){
        this.contractFile = contractFile;
        this.contractName = contractName;
    }
    async compile(){
        let result: CompileResult;
        try {
            result = await compileSol(this.contractFile, "0.5.10");
            return result;
        } catch (e) {
            if (e instanceof CompileFailedError) {
                console.error("Compile errors encountered:");

                for (const failure of e.failures) {
                    console.error(`Solc ${failure.compilerVersion}:`);

                    for (const error of failure.errors) {
                        console.error(error);
                    }
                }
            } else {
                console.error(e);
            }
            console.assert(false);
        }
    }
    async instrument(invariants: Invariant[], assumptions: Invariant[]){
            // Read the input file as a string array
        let sourcestrarray = fs.readFileSync(this.contractFile, 'utf-8').split(/\r?\n/);

        // Search the pragma statement
        const pragmaRegex = /^pragma\s+.*/;
        
        // Get the index of the pragma statement
        const pragmaIndex = sourcestrarray.findIndex((str: string) => pragmaRegex.test(str));

        // Delete all pragma statements
        sourcestrarray = sourcestrarray.filter((str: string) => !pragmaRegex.test(str));

        // // Insert the pragma statement at the beginning of the file
        sourcestrarray.splice(0, 0, `pragma solidity ^0.5.10;`);

        // Insert the import statement after the pragma statement
        sourcestrarray.splice(1, 0, `import \"./VeriSolContracts.sol\";`);
        let result: CompileResult =  await compileSourceString(this.contractFile, sourcestrarray.join("\n"), "auto");
        let reader = new ASTReader();
        let ast = reader.read(result.data);
        // replace super.func() with the exact contract name
        for (let sourceUnit of ast){
            for (let contract of sourceUnit.getChildren()){
                if (contract instanceof ContractDefinition){
                    let vLinearizedBaseContracts = contract.vLinearizedBaseContracts;
                    for (let func of contract.vFunctions){
                        if (func.vBody != null)
                          func.vBody.walk((_node) => {
                            // if (_node.extractSourceFragment(sourcestrarray.join("\n")).indexOf("super") != -1){
                            //     console.log(_node.type, _node.extractSourceFragment(sourcestrarray.join("\n")));
                            // }
                           if (_node instanceof MemberAccess){
                                let vReferencedDeclaration = _node.vReferencedDeclaration;
                                let vExpression = _node.vExpression;
                                if (vExpression instanceof Identifier ){
                                    let infer = new InferType("0.5.10");
                                    if (vExpression.name == "super"){
                                        console.log(_node.type, _node.extractSourceFragment(sourcestrarray.join("\n")));
                                        // let targetFunc = infer.typeOfMemberAccess(_node);
                                        // console.log("targetFunc", targetFunc);
                                        // let firstFuncType;
                                        // if (targetFunc instanceof FunctionLikeSetType){
                                        //     firstFuncType = targetFunc.defs[0];
                                        // }else if (targetFunc instanceof FunctionType){
                                        //     firstFuncType = targetFunc;
                                        // }
                                        let memberName = _node.memberName;
                                        for (let _contract of vLinearizedBaseContracts.slice(1)){
                                                let match = false;
                                                for (let sub_func of _contract.vFunctions){
                                                    if (sub_func.name == memberName){
                                                        vExpression.name = _contract.name;

                                                        vExpression.referencedDeclaration = _contract.id;
                                                        console.log("super replaced with ", vExpression.name);
                                                        match = true;
                                                        break;
                                                    }
                                                }
                                                if (match){
                                                    break;
                                                }
                                            
                                        }
                                    }
                                }
                           }
                         
                        });
                      
                    }
                }
            }
        }

        for (let sourceUnit of ast){
            for (let node of sourceUnit.getChildren()){
                if (node instanceof ContractDefinition && node.name == this.contractName){
                    
                    let all_state_vars = new Set(node.vStateVariables.map((stateVar) => stateVar.name));
                    for (let baseContract of node.vLinearizedBaseContracts){
                        all_state_vars = SetUnion(all_state_vars, new Set(baseContract.vStateVariables.map((stateVar) => stateVar.name)));
                    }
                  
                    let all_funcs: Set<string> = new Set(invariants.map((inv) => inv.sourceFunc));
                    let captured_funcs: Set<string> = await this.walkAndInstrumentFunc(node, invariants, assumptions, ast, all_state_vars);
                    let uncaptured_funcs =  SetDifference(all_funcs, captured_funcs);
                    let uninstrumented_invs = invariants.filter((inv) => uncaptured_funcs.has(inv.sourceFunc));
                    if (uninstrumented_invs.length == 0){
                        await this.walkAndInstrumentContract(node, invariants, ast);
                        await this.dump2File(ast);
                        return;
                    }
                    for (let baseContract of node.vLinearizedBaseContracts){
                        let captured_funcs = await this.walkAndInstrumentFunc(baseContract, uninstrumented_invs, assumptions, ast, all_state_vars);
                        uncaptured_funcs = SetDifference(uncaptured_funcs, captured_funcs);
                        uninstrumented_invs = uninstrumented_invs.filter((inv) => uncaptured_funcs.has(inv.sourceFunc));
                    }
                    await this.walkAndInstrumentContract(node, invariants, ast);
                    await this.dump2File(ast);
                    return;
                }
            }
        }
    }

    async walkAndInstrumentContract(contract: ContractDefinition, invariants: Invariant[], ast: SourceUnit[]){
        let contractInvariants = invariants.filter((inv) => inv.label == InvariantLabel.Contract);
        let current_scope_state_var_decls = new Set(contract.vStateVariables);
        for (let baseContract of contract.vLinearizedBaseContracts){
            current_scope_state_var_decls = new Set([...current_scope_state_var_decls, ...baseContract.vStateVariables]);
        }

        let identifiers: Identifier[] = [];
        for (let invariant of contractInvariants){
            current_scope_state_var_decls.forEach((stateVar) => {
                let regex = new RegExp("\\b" + stateVar.name + "\\b", "g");
                if (regex.test(invariant.candidate)){
                    if (stateVar.scope == contract.id){
                        // the state variable is declared in the current contract
                        // do not need to modify the visibility
                    }else{
                        // the state variable is declared in the base contract
                        // need to modify the visibility
                        stateVar.visibility = StateVariableVisibility.Public;
                    }
                }
            });
            if (invariant.candidate.indexOf("VeriSol.Old") == -1){
                invariant.candidate = invariant.candidate.replace("VeriSol.Ensures", "VeriSol.ContractInvariant");
                identifiers.push(new Identifier(0, "", "", invariant.candidate + ";", 0));
            }else{
                invariant.isValid = false;
            }
        }
        let block =  new Block(0, "", identifiers);

        let func = new FunctionDefinition(0, "", contract.id, FunctionKind.Function, "contractInvariant", false, FunctionVisibility.Private, FunctionStateMutability.View, false, new ParameterList(0, "", []), new ParameterList(0, "", []), [], null, block);
        // This is a trick to quickly insert a function to the contract
        contract.appendChild(func);
    }

    async walkAndInstrumentFunc(contract: ContractDefinition, invariants: Invariant[], assumptions: Invariant[], ast: SourceUnit[], all_state_vars: Set<string>){
        invariants  = invariants.filter((inv) => inv.label != InvariantLabel.Contract);
        let current_scope_state_vars = new Set(contract.vStateVariables.map((stateVar) => stateVar.name));
        for (let baseContract of contract.vLinearizedBaseContracts){
            current_scope_state_vars = SetUnion(current_scope_state_vars, new Set(baseContract.vStateVariables.map((stateVar) => stateVar.name)));
        }

        let current_scope_state_var_decls = new Set(contract.vStateVariables);
        for (let baseContract of contract.vLinearizedBaseContracts){
            current_scope_state_var_decls = new Set([...current_scope_state_var_decls, ...baseContract.vStateVariables]);
        }

        let out_scope_state_vars: Set<string> = SetDifference(all_state_vars, current_scope_state_vars);
        let captured_funcs: Set<string> = new Set();
        // insert function invariants
        for (let func of contract.vFunctions){
            let funcName = func.name;
            let params = func.vParameters.vParameters;
            let paramNames = params.map((param) => param.name).join(",");
            let fullFuncName = funcName + "(" + paramNames + ")";
            if (func.isConstructor){
                // constructor
                fullFuncName = contract.name + "()";
            }
            let invs = invariants.filter((inv) => inv.sourceFunc == fullFuncName && inv.isValid == true);
            if (invs.length == 0){
                continue;
            }
            captured_funcs.add(fullFuncName);

            if (func.stateMutability == "pure" || func.stateMutability == "view" || func.stateMutability == "constant"){
                console.log("pure/view/constant function: " + fullFuncName);
                invs.forEach((inv) => {
                    inv.isValid = false;
                });
                continue ;
            }else if (func.stateMutability == "nonpayable"){
                console.log("nonpayable function: " + fullFuncName);
                invs.forEach((inv) => {
                    if (inv.candidate.indexOf("msg.value") != -1){
                        inv.isValid = false;
                    }
                });
                invs =  invs.filter((inv) => inv.candidate.indexOf("msg.value") == -1);
            }else{
                console.log("payable function: " + fullFuncName);
            }
            let new_invs: Invariant[] = [];
            invs.forEach((inv) => {
                    if (inv.candidate.indexOf("VeriSol.Requires") != -1){
                        inv.candidate = inv.candidate.replace(/VeriSol\.Old/g, "");
                    }
                    new_invs.push(inv);
            });

           invs = new_invs;

           let _assumptions = assumptions.filter((assumption) => assumption.sourceFunc == fullFuncName);
           
           for (let node of func.getChildren()){
                if (node instanceof Block){
                        node.insertAtBeginning(new Identifier(0, "", "", "//End of invariants", 0));
                        for (let invariant of invs.reverse()) {
                            let invalid = false;
                            out_scope_state_vars.forEach((stateVar) => {
                                if (invariant.candidate.search(stateVar) != -1){
                                    invalid = true;
                                    return 
                                }
                            });
                            if (invalid){
                                console.log("Invalid invariant: " + invariant.candidate);
                                invariant.isValid = false;
                                continue;
                            }
                            
                            current_scope_state_var_decls.forEach((stateVar) => {
                                let regex = new RegExp("\\b" + stateVar.name + "\\b", "g");
                                if (regex.test(invariant.candidate)){
                                    if (stateVar.scope == contract.id){
                                        // the state variable is declared in the current contract
                                        // do not need to modify the visibility
                                    }else{
                                        // the state variable is declared in the base contract
                                        // need to modify the visibility
                                        stateVar.visibility = StateVariableVisibility.Public;
                                    }
                                }
                            });
                            // classify invariants
                            // 1. involved only state variables that are declared in the current contract
                            // 2. involved only local variables, namely function parameters or sodidity variables (e.g., msg.sender)
                            let involved_local_vars = false
                            func.vParameters.vParameters.forEach((param) => {
                                if (invariant.candidate.search(param.name) != -1){
                                    involved_local_vars = true;
                                    return 
                                }
                            });
                            if (invariant.candidate.search("msg.sender") != -1){
                                involved_local_vars = true;
                            }
                            if (invariant.candidate.search("msg.value") != -1){
                                involved_local_vars = true;
                            }
                            if (involved_local_vars){
                                invariant.label = InvariantLabel.Local;
                            }else{
                                // default set the label to unknown because we do not know whether the invariant involving state variables are contract/instance invariants
                                // because there may be a candidate invariant between a state variable and a constant
                                // invariant.label = InvariantLabel.Unknown;
                            }

                            let id = new Identifier(0, "", "", invariant.candidate + ";", 0);
                            node.insertAtBeginning(id);
                        }
                        // Insert the modifier name
                        node.insertAtBeginning(new Identifier(0, "", "", "//Begin of invariants", 0));
                        


                        node.insertAtBeginning(new Identifier(0, "", "", "//End of assumptions", 0));
                        for (let invariant of _assumptions.reverse()) {
                            let invalid = false;
                            out_scope_state_vars.forEach((stateVar) => {
                                if (invariant.candidate.search(stateVar) != -1){
                                    invalid = true;
                                    return 
                                }
                            });
                            if (invalid){
                                console.log("Invalid invariant: " + invariant.candidate);
                                invariant.isValid = false;
                                continue;
                            }
                            
                            current_scope_state_var_decls.forEach((stateVar) => {
                                let regex = new RegExp("\\b" + stateVar.name + "\\b", "g");
                                if (regex.test(invariant.candidate)){
                                    if (stateVar.scope == contract.id){
                                        // the state variable is declared in the current contract
                                        // do not need to modify the visibility
                                    }else{
                                        // the state variable is declared in the base contract
                                        // need to modify the visibility
                                        stateVar.visibility = StateVariableVisibility.Public;
                                    }
                                }
                            });
                            // classify invariants
                            // 1. involved only state variables that are declared in the current contract
                            // 2. involved only local variables, namely function parameters or sodidity variables (e.g., msg.sender)
                            let involved_local_vars = false
                            func.vParameters.vParameters.forEach((param) => {
                                if (invariant.candidate.search(param.name) != -1){
                                    involved_local_vars = true;
                                    return 
                                }
                            });
                            if (invariant.candidate.search("msg.sender") != -1){
                                involved_local_vars = true;
                            }
                            if (invariant.candidate.search("msg.value") != -1){
                                involved_local_vars = true;
                            }
                            if (involved_local_vars){
                                invariant.label = InvariantLabel.Local;
                            }else{
                                // default set the label to unknown because we do not know whether the invariant involving state variables are contract/instance invariants
                                // because there may be a candidate invariant between a state variable and a constant
                                // invariant.label = InvariantLabel.Unknown;
                            }

                            let id = new Identifier(0, "", "", invariant.candidate + ";", 0);
                            node.insertAtBeginning(id);
                        }
                        // Insert the modifier name
                        node.insertAtBeginning(new Identifier(0, "", "", "//Begin of assumptions", 0));

                        break;
                }
           }
            
        }

        return captured_funcs;
    }

    async dump2File(ast: SourceUnit[]){
        let result: CompileResult;
        //writing AST back to source
        const formatter = new PrettyFormatter(4, 0);
        const writer = new ASTWriter(
            DefaultASTWriterMapping,
            formatter,
            "0.5.10" // set to the version of the compiler that veriSol supports
        );
        for (let sourceUnit of ast){
            let absolutePath = sourceUnit.absolutePath;
            if (absolutePath.indexOf("VeriSolContracts.sol") == -1){
                let newpath = absolutePath.replace(".sol", ".verisol.sol");
                // console.log(newpath);
                fs.writeFileSync(newpath, writer.write(sourceUnit));
                console.log(`File ${newpath} created successfully!`);
            }
        }

    }

}

enum InvariantLabel{
    Unknown = 0,
    Contract = 1,
    Instance = 2,
    Local = 3,
}

enum CandidateType{
    MINED = 0,
    DERIVED = 1,
}

class Invariant{
    candidate: string; 
    candidateType: CandidateType;
    sourceFunc: string; 
    label: InvariantLabel;
    isProved: boolean;
    isValid: boolean;
    constructor(candidate :string, sourceFunc :string, label: InvariantLabel){
        this.candidateType = CandidateType.MINED;
        this.candidate = candidate;
        this.sourceFunc = sourceFunc;
        this.label = label;
        this.isProved = false;
        this.isValid = true;
    }
    equals(other: Invariant){
        return this.candidate === other.candidate && this.sourceFunc === other.sourceFunc && this.label === other.label;
    }
    get(){
        return this.candidate;
    }
}

class AutoAnnotation {
    invariants: any;
    assumptions: any;
    contractFile: string;
    contractName: string;
    contractAddress: string;
    proved_invariants: Invariant[];
    contract_invariants: Invariant[];
    instance_invariants: Invariant[];
    iteration: number;
    startTimestamp: number;
    constructor(invariant_json_file: string, contract_file: string) {
        this.contract_invariants = [];
        this.invariants =  {};
        this.assumptions = {};
        this.contractAddress = "";
        this.contractName = "";
        this.contractFile = contract_file;
        this.iteration = 0;
        this.startTimestamp = Date.now();
        invariant_json_file.replace(/.*\/(.*)-(.*)\.inv\.json/, (match, p1, p2) => {
            this.contractAddress = p1;
            this.contractName = p2;
            return invariant_json_file
        });
        let invariants = JSON.parse(fs.readFileSync(invariant_json_file,"utf8"));
        for (let invariant of invariants){
            let type =  invariant.type;
            let executionType =  invariant.executionType;
            let sourceFunc = invariant.func;
            let preconditions = invariant.preconditions;
            let postconditions = invariant.postconditions;
         
            if (executionType == "TxType.NORMAL" && type == "PptType.EXIT"){
                this.invariants[sourceFunc] = Array();
                for (let pre of preconditions){
                    this.invariants[sourceFunc].push(new Invariant(pre, sourceFunc, InvariantLabel.Unknown));
                }
                for (let post of postconditions){
                    this.invariants[sourceFunc].push(new Invariant(post, sourceFunc, InvariantLabel.Unknown));
                }
            }else if (executionType == "TxType.NORMAL" && type =="PptType.CONTRACT"){
                // this is a contract invariant candidate
                this.invariants[this.contractName] = Array();
                for (let post of postconditions){
                    let inv = new Invariant(post.replace("Ensures", "ContractInvariant"), this.contractName, InvariantLabel.Contract);
                    this.invariants[this.contractName].push(inv);
                    this.contract_invariants.push(inv);
                }
            }
        }
        this.instance_invariants = [];
        this.proved_invariants = [];
       
    }
    toString(){
        return JSON.stringify(this.invariants, null, 4);
    }

    async algorithm() {
        let analyseresult: any;

        // 1. prove all the easy contract/function invariants
        do {
            let worklist = this.invariants;
            await this.performInstrument();
            analyseresult = this.performHoudini(worklist);
            this.performImplication();
            this.iteration++;
        }while (this.addCandidate());       

        // 2. prove all the hard contract invariants
        // Assume-Guarantee reasoning
        // Verify: if contract invariants hold for the constructor (postcondition), then they hold for all the functions (guarantee)

        let unproved_contract_invs =  this.contract_invariants.filter((inv) => !inv.isProved && inv.isValid);
        for (let inv of unproved_contract_invs){
            let _inv = new Invariant(inv.candidate.replace("ContractInvariant", "Ensures"), inv.sourceFunc, inv.label);
            this.addConstructorPostCondition(_inv);
        }
        // constructor(){
        // //postcondiiton: b = a + 1;
        // }
        // contract invariant : b = a + 1;
        // loop:
        //    f();  a>0; b>0;

        // func f() a > 0; b>0;
        // {
        // assummption: b = a + 1;
        //    a =  a+ 1;
        //    b = a +1;
        //  postcondiiton: b = a + 1;
        // }

        await this.performInstrument();

        let worklist = this.invariants;
        let analyseresult2 = this.performHoudini(worklist);
        this.performImplication();
        this.iteration++;

        // newly proved invariants
        let new_proved_invs = analyseresult2.filter((inv) => analyseresult.indexOf(inv) == -1 && inv.sourceFunc == this.contractName+"()");
        // The newly proved invariants are the contract invariants that hold for the constructor
        
        // now we need to prove the contract invariants for all the functions
        // we need to insert the contract invariants into the functions as the assumptions
        // we need to insert the contract invariants into the functions as the postconditions
        for (let inv of new_proved_invs){
            let all_funcs = Object.keys(this.invariants).filter((func) => func.split("(")[0] != this.contractName);
            let _inv = new Invariant(inv.candidate.replace("Ensures", "AssumesBeginningOfFunction"), inv.sourceFunc, InvariantLabel.Local);
            // console.log(_inv);
            // console.log(all_funcs);
            for (let func of all_funcs){
                // add the contract invariants as the assumptions at the beginning of the functions
                this.addFunctionPreAssumption(_inv, func);
                // add the contract invariants as the postconditions at the end of the functions
                let new_inv = new Invariant(inv.candidate, func, InvariantLabel.Local);
                new_inv.candidateType = CandidateType.DERIVED;
                this.invariants[func].push(new_inv);
            }
        }
        

        await this.performInstrument();
        let worklist2 = this.invariants;
        let analyseresult3 = this.performHoudini(worklist2);
        this.performImplication();
        this.iteration++;

        // newly proved invariants
        let new_proved_invs2 = analyseresult3.filter((inv) => analyseresult2.indexOf(inv) == -1);

        // the new proved contract invariants
        let new_proved_contract_invs = new_proved_invs2.filter((inv) => inv.sourceFunc == this.contractName);

        // the new proved function invariants
        let new_proved_function_invs = new_proved_invs2.filter((inv) => inv.sourceFunc != this.contractName);


        // 3. prove all the hard instance invariants 
        // Assume-Guarantee reasoning
        // Verify: if instance invariants hold for the constructor (assumption), then they hold for all the functions (guarantee)
        let unproved_instance_invs =  this.contract_invariants.filter((inv) => !inv.isProved && inv.isValid);
        for (let inv of unproved_instance_invs){
            let _inv = new Invariant(inv.candidate.replace("ContractInvariant", "AssumesEndingOfFunction"), inv.sourceFunc, InvariantLabel.Instance);
            this.addConstructorPostAssumption(_inv);
            let _inv2 = new Invariant(inv.candidate.replace("ContractInvariant", "Ensures"), inv.sourceFunc, InvariantLabel.Instance);
            this.addConstructorPostCondition(_inv2);
        }

        await this.performInstrument();

        let worklist3 = this.invariants;
        let analyseresult4 = this.performHoudini(worklist3);
        this.performImplication();
        this.iteration++;

        // newly proved invariants ()
        let new_proved_invs3 = analyseresult4.filter((inv) => analyseresult3.indexOf(inv) == -1 && inv.sourceFunc == this.contractName+"()" );

        // now we need to prove the contract invariants for all the functions
        // we need to insert the contract invariants into the functions as the assumptions
        // we need to insert the contract invariants into the functions as the postconditions
        for (let inv of new_proved_invs3){
            let all_funcs = Object.keys(this.invariants).filter((func) => func.split("(")[0] != this.contractName);
            let _inv = new Invariant(inv.candidate.replace("Ensures", "AssumesBeginningOfFunction"), inv.sourceFunc, InvariantLabel.Instance);
            for (let func of all_funcs){
                // add the contract invariants as the assumptions at the beginning of the functions
                this.addFunctionPreAssumption(_inv, func);
                // add the contract invariants as the postconditions at the end of the functions
                let new_inv = new Invariant(inv.candidate, func, InvariantLabel.Instance);
                new_inv.candidateType = CandidateType.DERIVED;
                this.invariants[func].push(new_inv);
            }
        }

        await this.performInstrument();
        let worklist4 = this.invariants;
        let analyseresult5 = this.performHoudini(worklist4);
        this.performImplication();
        this.iteration++;

        // newly proved invariants
        let new_proved_invs6 = analyseresult5.filter((inv) => analyseresult4.indexOf(inv) == -1);

        // the new proved contract invariants
        let new_proved_contract_invs6 = new_proved_invs6.filter((inv) => inv.sourceFunc == this.contractName);

        // the new proved function invariants
        let new_proved_function_invs6 = new_proved_invs6.filter((inv) => inv.sourceFunc != this.contractName);

    }
    
    async performInstrument(){
        let compiler = new Compiler(this.contractFile, this.contractName);
        let invariants :Invariant[] = [];
        for (let func in this.invariants){
            invariants = invariants.concat(this.invariants[func]);
        }
        let assumptions :Invariant[] = [];
        for (let func in this.assumptions){
            assumptions = assumptions.concat(this.assumptions[func]);
        }
        await compiler.instrument(invariants, assumptions);
    }

    performHoudini(worklist: any) {
        // run verisol-houdini approach
        // get all the invariant verification results
        // *. get all the invariants that are proved
        // *. get all the invariants that are not proved

        // 1. run verisol-houdini on the instrumented contract
        let instrumented_contract = this.contractFile.replace(".sol", ".verisol.sol");
        const { stdout, stderr, code } = shell.exec("VeriSol " + instrumented_contract + " " + this.contractName + " /contractInfer", { silent: true });
        console.log(stdout);
        let success = stdout.indexOf("Proof found! Formal Verification successful!") != -1;

        // 2. perform analysis on the houdini result
        let boogieFileName = path.basename(instrumented_contract).replace(".sol", "_out.bpl");
        let analyseresult = this.performAnalysis(boogieFileName, this.contractAddress+"-"+this.contractName+".txt", success);

        return analyseresult;
    }

    performAnalysis(inputFileName: string, outputFileName: string, success: boolean) {
        const houdiniResultFileName = `./boogie.txt`;
        const houdiniResultFileContent = fs.readFileSync(houdiniResultFileName, 'utf8');

        // Split the file content into individual lines
        const resultFileLines = houdiniResultFileContent.trim().split('\n');
        
        const trueVariables: string[] = [];
        const falseVariables: string[] = [];

        let lineIndex = 0;

        // Process the variable names and values until the footer
        while (lineIndex < resultFileLines.length) {
            const line = resultFileLines[lineIndex];
            if (line.startsWith('Houdini')) {
                const [variableName, value] = line.split('=').map(str => str.trim());

                // Check the value and add the variable name to the corresponding list
                if (value === 'True') {
                    trueVariables.push(variableName);
                } else if (value === 'False') {
                    falseVariables.push(variableName);
                }
            }
            lineIndex++;
        }

        // Print the number of variables
        // console.log('Variables with True value:', trueVariables.length);
        // console.log('Variables with False value:', falseVariables.length);

        // Initialize an object to store the variable content
        const trueVariableContent: { [variable: string]: string } = {};
        const falseVariableContent: { [variable: string]: string } = {};

        const boogieFileName = `${inputFileName}`;
        const boogieFileContent = fs.readFileSync(boogieFileName, 'utf8');

        // Iterate over the variable names and extract the content using regular expressions
        trueVariables.forEach(variable => {
            const regex = new RegExp(`(requires|ensures|invariant|)\\s+\\(*${variable}\\)*\\s+==>${'\\s+'}(.+);`);
            const match = regex.exec(boogieFileContent);
            if (match) {
                const keyword = match[1];
                const content = match[2];
                trueVariableContent[variable] = `${keyword} ${content.trim()}`;
            } else {
                trueVariableContent[variable] = '';
            }
        });

        falseVariables.forEach(variable => {
            const regex = new RegExp(`(requires|ensures|invariant)\\s+\\(*${variable}\\)*\\s+==>${'\\s+'}(.+);`);
            const match = regex.exec(boogieFileContent);
            if (match) {
                const keyword = match[1];
                const content = match[2];
                falseVariableContent[variable] = `${keyword} ${content.trim()}`;
            } else {
                falseVariableContent[variable] = '';
            }
        });

        // Write the variable content to a file
        // const outputContent = `Invariants with True value:${trueVariables.length}\nInvariants with False value:${falseVariables.length}\n\n
        // True Invariants:\n${Object.entries(trueVariableContent).map(([variable, content]) => `${variable}: ${content}`).join('\n')}\n\n
        // False Invariants:\n${Object.entries(falseVariableContent).map(([variable, content]) => `${variable}: ${content}`).join('\n')}`;
        // fs.writeFileSync(`./out/${outputFileName}-${this.iteration}`, outputContent, 'utf8');

        // fs.appendFileSync(output_file, [this.contractAddress, this.contractName, Date.now()-this.startTimestamp, trueVariables.length, falseVariables.length, success].join(",") + "\n", 'utf8')

        // console.log(`File ${outputFileName}-${this.iteration} written successfully`);

        let this_proved_invariants = [];
        let this_invariants = this.invariants;

        // console.log("trueVariables", trueVariables);

        // collect all the invariant index, function and contract
        let function_inv_index = {};
        let contract_inv_index = {};
        trueVariables.forEach(variable => {
            let regex = new RegExp(`^HoudiniF([0-9]+)\_(_?[0-9a-zA-Z]+)\_(_?[0-9a-zA-Z]+)`);
            let match = regex.exec(variable);
            if (match) {
                let index = parseInt(match[1]);
                let func = match[2];
                let contract = match[3];
                if (function_inv_index[func] == undefined){
                    function_inv_index[func] = [];
                }
                function_inv_index[func].push(index);
            }else{
                regex = new RegExp(`HoudiniC([0-9]+)\_(_?[0-9a-zA-Z]+)$`);
                match = regex.exec(variable);
                if (match) {
                    let index = parseInt(match[1]);
                    let contract = match[2];
                    if (contract_inv_index[contract] == undefined){
                        contract_inv_index[contract] = [];
                    }
                    contract_inv_index[contract].push(index);
                }
            }
        });

        falseVariables.forEach(variable => {
            let regex = new RegExp(`^HoudiniF([0-9]+)\_(_?[0-9a-zA-Z]+)\_(_?[0-9a-zA-Z]+)`);
            let match = regex.exec(variable);
            if (match) {
                let index = parseInt(match[1]);
                let func = match[2];
                let contract = match[3];
                if (function_inv_index[func] == undefined){
                    function_inv_index[func] = [];
                }
                function_inv_index[func].push(index);
            }else{
                regex = new RegExp(`HoudiniC([0-9]+)\_(_?[0-9a-zA-Z]+)$`);
                match = regex.exec(variable);
                if (match) {
                    let index = parseInt(match[1]);
                    let contract = match[2];
                    if (contract_inv_index[contract] == undefined){
                        contract_inv_index[contract] = [];
                    }
                    contract_inv_index[contract].push(index);
                }
            }
        });

        // console.log("function_inv_index", function_inv_index);

        trueVariables.forEach(variable => {
            // use regex to get the invariant index, function and contract
            let regex = new RegExp(`^HoudiniF([0-9]+)\_(_?[0-9a-zA-Z]+)\_(_?[0-9a-zA-Z]+)`);
            let match = regex.exec(variable);
            if (match) {
                let index = parseInt(match[1]);
                let func = match[2];
                let contract = match[3];
                // add the invariant to the proved invariant list
                for (let func_sig in this.invariants){
                    if (func_sig.indexOf("(")!=-1 && func_sig.split("(")[0] == func){
                        let funcInvariant = this_invariants[func_sig].filter(invariant => invariant.isValid == true);
                        let invariant = funcInvariant[index - Math.min(...function_inv_index[func])];
                        invariant.isProved = true;
                        invariant.label = InvariantLabel.Local;
                        this_proved_invariants.push(invariant);
                        break
                    }
                }
            }
            regex = new RegExp(`HoudiniC([0-9]+)\_(_?[0-9a-zA-Z]+)$`);
            match = regex.exec(variable);
            if (match) {
                let index = parseInt(match[1]);
                let contract = match[2];
                // add the invariant to the proved invariant list
                for (let contract_sig in this_invariants){
                    if (contract_sig == contract){
                        let contractInvariants = this_invariants[contract_sig].filter(invariant => invariant.isValid == true);
                        let invariant =contractInvariants[index - Math.min(...contract_inv_index[contract])];
                        invariant.isProved = true;
                        invariant.label = InvariantLabel.Contract;
                        this_proved_invariants.push(invariant);
                        break;
                    }
                }
            }
        });

        this.proved_invariants = this_proved_invariants;


         // Write the proved invariants and unproved invariants to a file
         let all_invariants: Invariant[] = [];
         for (let func_sig in this.invariants){
                all_invariants = all_invariants.concat(this.invariants[func_sig]);
         }
         let proved_invariants = this.proved_invariants.filter(invariant => invariant.isProved == true && invariant.isValid == true && invariant.candidateType == CandidateType.MINED);
         let unproved_invariants = all_invariants.filter(invariant => invariant.isProved == false && invariant.isValid == true && invariant.candidateType == CandidateType.MINED);
         
         console.log('Proved Invariant Number:', proved_invariants.length);
         console.log('Unproved Invariant Number:', unproved_invariants.length);

         let outputContent = `Invariants with True value:${proved_invariants.length}\nInvariants with False value:${unproved_invariants.length}\n\n`;
         outputContent += "True Invariants:\n";
         for (let invariant of proved_invariants){
            outputContent += invariant.sourceFunc + ": " + invariant.candidate + `\n`;
         }
        outputContent += "\nFalse Invariants:\n";
        for (let invariant of unproved_invariants){
            outputContent += invariant.sourceFunc + ": " + invariant.candidate + `\n`;
        }
        fs.writeFileSync(`./out/${outputFileName}-${this.iteration}`, outputContent, 'utf8');
 
        fs.appendFileSync(output_file, [this.contractAddress, this.contractName, Date.now()-this.startTimestamp, proved_invariants.length, unproved_invariants.length, success].join(",") + "\n", 'utf8')
 
        console.log(`File ${outputFileName}-${this.iteration} written successfully`);
        return this_proved_invariants;
    }

    performImplication()  {
        // run SMT implication approach
        // 1. get all the invariants
        let result: Invariant[]= [];
        this.proved_invariants = this.proved_invariants.concat(result);
        return result;
    }
    addCandidate(){
        // add candidate invariants
        // FIXME: how to add candidate invariants
        // 1. recall what is program invariant for smart contracts
        //  1.1. for each function, the pre-condition and post-condition
        //  1.2. for each loop, the loop invariant, namely the contract invariant
        //  1.3. for each contract instance, its specialized contract invariant
        // 2. add candidate invariants that can prove the loop/instance invariant
        
        let success = false;
        // attempt 1: add all the proved function invariants to other functions
        for (let func_sig in this.invariants){
            let func_invariants = this.invariants[func_sig];
            this.proved_invariants.forEach(invariant => {
                if (invariant.label != InvariantLabel.Contract){
                    let sourceFunc = invariant.sourceFunc;
                    let paramNames = sourceFunc.split("(")[1].split(")")[0].split(",");
                    // avoid adding the invariant specialized for the function itself
                    let invalid = false;
                    if (sourceFunc != func_sig){
                        paramNames.forEach(paramName => {
                            let regex = new RegExp(`\\b${paramName}\\b`);
                            if (regex.test(invariant.candidate)){
                                invalid = true;
                            }
                        });
                        if (invalid == false){
                            let newInvariant = new Invariant(invariant.candidate, func_sig, invariant.label);
                            newInvariant.candidateType = CandidateType.DERIVED;
                            if (func_invariants.some((inv) => { return inv.equals(newInvariant)}) == false){
                                func_invariants.push(newInvariant);
                                success = true;
                            }
                        }
                    }
                }
            });
        }
        return success;
    }

    // Add the candidate invariants to the contract constructor
    // because we need to prove the contract invariant modularly
    addConstructorPostCondition(inv: Invariant){
        assert(inv.candidate.startsWith("VeriSol.Ensures"), "This is not a post-condition")
        let success = false;
        let contract = inv.sourceFunc;
        let constructor_sig = `${contract}()`;
        let constructor_invariants = this.invariants[constructor_sig];
        if (constructor_invariants == undefined){
            this.invariants[constructor_sig] = [];
            constructor_invariants = this.invariants[constructor_sig];
            this.invariants[constructor_sig] = constructor_invariants;
        }
        let newInv = new Invariant(inv.candidate, constructor_sig, InvariantLabel.Local);
        newInv.candidateType = CandidateType.DERIVED;
        if (constructor_invariants.some((_inv) => { return _inv.equals(newInv)}) == false){
            constructor_invariants.push(newInv);
            success = true;
        }
        return success;
    }

    // Add the practical assumption (about instance) to the contract constructor
    // because we need to prove the contract invariant modularly
    addConstructorPostAssumption(inv: Invariant){
        assert(inv.candidate.startsWith("VeriSol.AssumesEndingOfFunction"), "This is not a post-assumption")
        let success = false;
        let contract = inv.sourceFunc;
        let constructor_sig = `${contract}()`;
        let constructor_assumptions = this.assumptions[constructor_sig];
        if (constructor_assumptions == undefined){
            this.assumptions[constructor_sig] = [];
            constructor_assumptions = this.assumptions[constructor_sig];
            this.assumptions[constructor_sig] = constructor_assumptions;
        }
        let newInv = new Invariant(inv.candidate, constructor_sig, InvariantLabel.Instance);
        newInv.candidateType = CandidateType.DERIVED;
        if (constructor_assumptions.some((_inv) => { return _inv.equals(newInv)}) == false){
            constructor_assumptions.push(newInv);
            success = true;
        }
        return success;
    }

    // We need to add the assumption to the contract functions 
    // then we can prove more invariants
    addFunctionPreAssumption(inv: Invariant, func: string){
        if (! inv.candidate.startsWith("VeriSol.AssumesBeginningOfFunction")){
            return false;
        }
        assert(inv.candidate.startsWith("VeriSol.AssumesBeginningOfFunction"), "This is not a pre-assumption")
        let success = false;
        let func_assumptions = this.assumptions[func];
        if (func_assumptions == undefined){
            this.assumptions[func] = [];
            func_assumptions = this.assumptions[func];
        }
        let newInv = new Invariant(inv.candidate, func, InvariantLabel.Local);
        newInv.candidateType = CandidateType.DERIVED;
        if (func_assumptions.some((_inv) => { return _inv.equals(newInv)}) == false){
            func_assumptions.push(newInv);
            success = true;
        }
        return success;
    }

}


async function main(){
    for (let file of fs.readdirSync(path.join(__dirname, "../verisol_test"))){
        if (file.endsWith(".inv.json")){
            let contract_file = path.join(__dirname, "../verisol_test", file.replace(/-(.*)\.inv\.json/, ".etherscan.io-$1.sol"));
            if (fs.existsSync(contract_file) == false)
                continue;
            console.log(contract_file);
            let invariant_json_file = path.join(__dirname, "../verisol_test", file);
            let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file);
            await autoAnnotation.algorithm();
            // console.log(autoAnnotation.toString());
        }
    }
    // console.log(__dirname);
    // let contract_file = path.join(__dirname, "./../verisol_test/0xe0b9bcd54bf8a730ea5d3f1ffce0885e911a502c.etherscan.io-ZumToken.sol");
    // let invariant_json_file = path.join(__dirname, "./../verisol_test/0xe0b9bcd54bf8a730ea5d3f1ffce0885e911a502c-ZumToken.inv.json");
    // let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file);
    // await autoAnnotation.algorithm();

    // console.log(autoAnnotation.toString());
}

main();