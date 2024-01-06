import * as fs from 'fs';
import * as path from 'path';
import { CompileFailedError, CompileResult, compileSol, ASTReader, ContractDefinition, FunctionDefinition, Block, Identifier, SourceUnit, compile, compileSourceString, ASTWriter, PrettyFormatter, DefaultASTWriterMapping, StateVariableVisibility, MemberAccess, InferType, FunctionType, FunctionLikeSetType, FunctionKind, FunctionVisibility, FunctionStateMutability, ParameterList} from "solc-typed-ast";
import * as shell from 'shelljs';
import assert = require('assert');
import { permutations } from "combinatorial-generators";
import { glob, globSync, globStream, globStreamSync, Glob } from 'glob'

import { exit, listenerCount } from 'process';
import { unescapeLeadingUnderscores } from 'typescript';


// use date to name the output file
let date_ob = new Date();
let hour = ("0" + date_ob.getHours()).slice(-2);
let date = ("0" + date_ob.getDate()).slice(-2);
let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
let year = date_ob.getFullYear();
// prints date & time in YYYY-MM-DD format
console.log(year + "-" + month + "-" + date);

let output_file = "./Token-data/result-excels/"+ hour+ "-" + date + "-" + month+ "-"+ year + ".csv"

let out_dir = "./Token-data/out/"

let boogieOutputFile = "./boogie.txt"

let iteration_cap = 100;
let unique_id = "";

// const Flag_With_PartialInvariants = false;
let Flag_With_PartialInvariants = true;

let contract_instrumentation_time = 0;
let houdini_verification_time = 0;
let finding_implication_time = 0;
let weaken_implication_time = 0;

if (!fs.existsSync(output_file)){
    fs.writeFileSync(output_file, "address,contract_name,time_taken,true_count,false_count,success\n", "utf-8");
}


const SetDifference = (a: Set<string>, b: Set<string>) => new Set([...a].filter(x => !b.has(x)));
const SetIntersection = (a: Set<string>, b: Set<string>) => new Set([...a].filter(x => b.has(x)));
const SetUnion = (a: Set<string>, b: Set<string>) => new Set([...a, ...b]);

let global_all_state_vars = new Set<string>();
class Compiler{
    contractName: string;
    contractFile: string;
    isSingle: boolean
    constructor(contractFile: string, contractName: string, isSingle: boolean){
        this.contractFile = contractFile;
        this.contractName = contractName;
        this.isSingle = isSingle;
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

    addVeriSolImport(file){
        let sourcestrarray = fs.readFileSync(file, 'utf-8').split(/\r?\n/);

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
        fs.writeFileSync(file, sourcestrarray.join("\n"))
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
                                let vExpression = _node.vExpression;
                                if (vExpression instanceof Identifier ){
                                    if (vExpression.name == "super"){
                                        // console.log(_node.type, _node.extractSourceFragment(sourcestrarray.join("\n")));
                                        
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
        global_all_state_vars = SetUnion(global_all_state_vars, new Set(contract.vStateVariables.map((stateVar) => stateVar.name)));
        let current_scope_state_var_decls = new Set(contract.vStateVariables);
        for (let baseContract of contract.vLinearizedBaseContracts){
            current_scope_state_var_decls = new Set([...current_scope_state_var_decls, ...baseContract.vStateVariables]);
            global_all_state_vars = SetUnion(global_all_state_vars, new Set(baseContract.vStateVariables.map((stateVar) => stateVar.name)));
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
     
           let _assumptions = assumptions.filter((assumption) => assumption.sourceFunc == fullFuncName);
           
           for (let node of func.getChildren()){
                if (node instanceof Block){
                        node.insertAtBeginning(new Identifier(0, "", "", "//End of invariants", 0));
                        for (let invariant of invs.reverse()) {
                            let invalid = false;
                            out_scope_state_vars.forEach((stateVar) => {
                                let regex = new RegExp("\\b" + stateVar + "\\b", "g");
                                if (regex.test(invariant.candidate)){
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
                                let regex = new RegExp("\\b" + param.name + "\\b", "g");
                                if (regex.test(invariant.candidate)){
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
                            if (invariant.candidate.indexOf("VeriSol.Requires") != -1){
                                // let id = new Identifier(0, "", "", invariant.candidate.replace(/VeriSol\.Old/g, "") + ";", 0);
                                let id = new Identifier(0, "", "", invariant.candidate.replace(/VeriSol\.Requires/g, "VeriSol.Ensures") + ";", 0);
                                node.insertAtBeginning(id);
                            }else{
                                let id = new Identifier(0, "", "", invariant.candidate + ";", 0);
                                node.insertAtBeginning(id);
                            }
                        }
                        // Insert the modifier name
                        node.insertAtBeginning(new Identifier(0, "", "", "//Begin of invariants", 0));
                        

                        node.insertAtBeginning(new Identifier(0, "", "", "//End of assumptions", 0));

                        let assumption = "VeriSol.AssumesBeginningOfFunction(msg.sender != address(0))"
                        let id = new Identifier(0, "", "", assumption + ";", 0);
                        node.insertAtBeginning(id);

                        if (func.name == "transferFrom"){
                            // insert assumption to differentiate allowance and balances
                            let params = func.vParameters.vParameters;
                            let from = params[0].name;
                            let to = params[1].name;
                            let amount = params[2].name; 
                            let balanceOf = undefined
                            let allowance = undefined
                            current_scope_state_var_decls.forEach((state_var) => {
                                if (state_var.name == "balances" || state_var.name == "_balances" || state_var.name == "balanceOf"){
                                    balanceOf = state_var.name
                                }
                                if (state_var.name == "allowances" || state_var.name == "allowance" 
                                || state_var.name == "_allowance" || state_var.name == "_allowances" || state_var.name == "_allowed" || state_var.name == "allowed"){
                                    allowance = state_var.name
                                }
                            });
                            if (balanceOf != undefined && allowance != undefined){
                                let assumption = "VeriSol.AssumesBeginningOfFunction( " + 
                                allowance + "[" + from + "][msg.sender] != " +  balanceOf + "[" + to + "]"+ "&&" +
                                 allowance + "[" + from + "][msg.sender] != " + balanceOf + "[" + from + "])"
                                let id = new Identifier(0, "", "", assumption + ";", 0);
                                node.insertAtBeginning(id);
                            }
                        }

                        for (let invariant of _assumptions.reverse()) {
                            let invalid = false;
                            out_scope_state_vars.forEach((stateVar) => {
                                let regex = new RegExp("\\b" + stateVar + "\\b", "g");
                                if (regex.test(invariant.candidate)){
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
                if (this.isSingle){
                    let new_file = undefined;
                    if (unique_id!=""){
                        new_file = absolutePath.replace(".sol", "."+unique_id+".verisol.sol");
                    }else{
                        new_file = absolutePath.replace(".sol", ".verisol.sol");
                    }
                    // console.log(newpath);
                    fs.writeFileSync(new_file, writer.write(sourceUnit));
                    console.log(`File ${new_file} created successfully!`);
                }else{
                    let newpath = undefined;
                    if (unique_id!=""){
                        newpath = path.join(path.dirname(absolutePath), "verisol" + "-" + unique_id);
                    }else{
                        newpath = path.join(path.dirname(absolutePath), "verisol");
                    }
                    if (!fs.existsSync(newpath))
                        fs.mkdirSync(newpath)
                    let verisol_file  = path.join(newpath, "VeriSolContracts.sol");
                    if (!fs.existsSync(verisol_file)){ 
                        let cmd = `cp ${path.dirname(absolutePath)}/VeriSolContracts.sol ${newpath}`
                        shell.exec(cmd);
                    }
                    let new_file = path.join(newpath, path.basename(absolutePath))

                    fs.writeFileSync(new_file, writer.write(sourceUnit));

                    if (absolutePath!=this.contractFile){
                        this.addVeriSolImport(new_file);
                    }
                    console.log(`File ${new_file} created successfully!`);
                }
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
enum InvariantRelation{
    NONE = 0,
    IMPLICATION = 1,
    AND = 2,
    OR = 3,
}

class Invariant{
    candidate: string; 
    candidateType: CandidateType;
    sourceFunc: string; 
    label: InvariantLabel;
    isProved: boolean;
    isValid: boolean;
    from: Invariant;
    to: Invariant;
    relation: InvariantRelation; 
    constructor(candidate :string, sourceFunc :string, label: InvariantLabel){
        this.candidateType = CandidateType.MINED;
        this.candidate = candidate;
        this.sourceFunc = sourceFunc;
        this.label = label;
        this.isProved = false;
        this.isValid = true;
        this.from = null;
        this.to = null;
        this.relation = InvariantRelation.NONE;
    }
    equals(other: Invariant){
        return this.candidate === other.candidate && this.sourceFunc === other.sourceFunc && this.label === other.label;
    }
    get(){
        return this.candidate;
    }
    is_primitive(){
        return this.from == null && this.to == null && this.relation == InvariantRelation.NONE;
    }
    is_pre(){
        return this.candidate.indexOf("VeriSol.Requires")!=-1;
    }
    is_post(){
        return this.candidate.indexOf("VeriSol.Ensures")!=-1;
    }
    toExpr(){
        if (this.is_primitive()){
            let expr =  this.candidate.replace(/VeriSol\.Requires/g, "").replace(/VeriSol\.Ensures/g, "");
            if (expr.startsWith("(")){
                expr = expr.slice(1, expr.length-1);
            }
            return expr;
        }else{
            let op = "";
            if (this.relation == InvariantRelation.IMPLICATION){
                op = "=>";
            }else if (this.relation == InvariantRelation.AND){
                op = "&&";
            }else if (this.relation == InvariantRelation.OR){   
                op = "||";
            }else{
                assert(false);
            }
            return  this.from.toExpr() + " " + op + " " + this.to.toExpr();
        }
    }
}

class AutoAnnotation {
    invariants: any;
    falsified_invariants: any;
    assumptions: any;
    contractFile: string;
    contractName: string;
    contractAddress: string;
    proved_invariants: Invariant[];
    contract_invariants: Invariant[];
    instance_invariants: Invariant[];
    iteration: number;
    startTimestamp: number;
    isSingleFile: boolean;
    constructor(invariant_json_file: string, contract_file: string, isSingle: boolean) {
        this.contract_invariants = [];
        this.invariants =  {};
        this.falsified_invariants = {};
        this.assumptions = {};
        this.contractAddress = "";
        this.contractName = "";
        this.contractFile = contract_file;
        this.iteration = 0;
        this.startTimestamp = Date.now();
        this.isSingleFile = isSingle == undefined? true: isSingle;
        let basename = path.basename(invariant_json_file)
        this.contractAddress = basename.split(".inv.json")[0].split("-")[0]
        this.contractName = basename.split(".inv.json")[0].split("-")[1]

        let invariants = JSON.parse(fs.readFileSync(invariant_json_file,"utf8"));
        for (let invariant of invariants){
            let type =  invariant.type;
            let executionType =  invariant.executionType;
            let sourceFunc = invariant.func;
            let preconditions = invariant.preconditions;
            let postconditions = invariant.postconditions;
            let falsified_preconditions = [];
            let falsified_postconditions = [];
            if (Flag_With_PartialInvariants){
                falsified_preconditions = invariant.falsified_preconditions;
                falsified_postconditions = invariant.falsified_postconditions;
            }
         
            if (executionType == "TxType.NORMAL" && type == "PptType.EXIT"){
                this.invariants[sourceFunc] = Array();
                for (let pre of preconditions){
                    this.invariants[sourceFunc].push(new Invariant(pre, sourceFunc, InvariantLabel.Unknown));
                }
                for (let post of postconditions){
                    this.invariants[sourceFunc].push(new Invariant(post, sourceFunc, InvariantLabel.Unknown));
                }

                this.falsified_invariants[sourceFunc] = Array();
                for (let pre of falsified_preconditions){
                    this.falsified_invariants[sourceFunc].push(new Invariant(pre, sourceFunc, InvariantLabel.Unknown));
                }
                for (let post of falsified_postconditions){
                    this.falsified_invariants[sourceFunc].push(new Invariant(post, sourceFunc, InvariantLabel.Unknown));
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

    async algorithm_program() {
            this.iteration = 0;
            let worklist = this.invariants;
            let start_time = Date.now();
            await this.performInstrument();
            contract_instrumentation_time += Date.now() - start_time;

            start_time = Date.now();
            let analyseresult = await this.performHoudini(worklist);
            houdini_verification_time += Date.now() - start_time;
           
            if (this.iteration >= iteration_cap){
                return;
            }
            this.iteration ++;

            start_time = Date.now();
            this.addImplicationCandidates();       
            finding_implication_time += Date.now() - start_time;


            worklist = this.invariants;

            start_time = Date.now();
            await this.performInstrument();
            contract_instrumentation_time += Date.now() - start_time;

            start_time = Date.now();
            analyseresult = await this.performHoudini(worklist);
            houdini_verification_time += Date.now() - start_time;

            start_time = Date.now();
            while (this.weakenImplicationCandidates()){
                if (this.iteration >= iteration_cap){
                    break;
                }
                this.iteration++;

                weaken_implication_time += Date.now() - start_time;

                worklist = this.invariants;

                start_time = Date.now();
                await this.performInstrument();
                contract_instrumentation_time += Date.now() - start_time;

                start_time = Date.now();
                analyseresult = await this.performHoudini(worklist);
                houdini_verification_time += Date.now() - start_time;
            }
            console.log("Contract Instrumentation Time: " + contract_instrumentation_time);
            console.log("Houdini Verification Time: " + houdini_verification_time);
            console.log("Finding Implication Time: " + finding_implication_time);
            console.log("Weaken Implication Time: " + weaken_implication_time);

            contract_instrumentation_time = 0;
            houdini_verification_time = 0;
            finding_implication_time = 0;
            weaken_implication_time = 0;
    }
    translateExpr(from: Invariant){
        let from_expr = from.toExpr();
        let flag = false;
        global_all_state_vars.forEach((stateVar) => {
            if (!flag){
            if (from_expr.search(stateVar) != -1 && from_expr.search("VeriSol.Old") == -1){
                // replace it with old(stateVar)
                let re = new RegExp("("+stateVar+"\\[[\\w\\.]*\\]\\[[\\w\\.]*\\]"+")","g");
                if (re.test(from_expr)){
                        from_expr = from_expr.replace(re, "VeriSol.Old($1)");
                        flag = true;
                }
                else {

                    let re = new RegExp("("+stateVar+"\\[[\\w\\.]*\\]"+")","g");
                    if (re.test(from_expr)){
                            from_expr = from_expr.replace(re, "VeriSol.Old($1)");
                            flag = true;
                    } else{
                        re = new RegExp("(\\s)("+stateVar+")(\\s)","g");
                        if (re.test(from_expr)){
                            from_expr = from_expr.replace(re, "$1 VeriSol.Old($2) $3 ");
                            flag = true;
                        }else{
                            re = new RegExp("(VeriSol\\.SumMapping\\("+stateVar+"\\))","g");
                            if (re.test(from_expr)){
                                from_expr = from_expr.replace(re, "VeriSol.Old($1)");
                                flag = true;
                            }
                        }
                    }
                    }
                }
                }
            }
        );
        return from_expr;
    }

    weakenImplicationCandidates(){
        let new_invs : Invariant[] = [];
        let unproved_contract_invs :Invariant[] =  this.contract_invariants.filter((inv) => !inv.isProved && inv.isValid);
        for (let func in this.invariants){
            let unproved_function_invs = this.invariants[func].filter((inv) => !inv.isProved && inv.isValid && !unproved_contract_invs.includes(inv) && ! inv.is_primitive() && inv.relation == InvariantRelation.IMPLICATION );
            let i=0; 
            for (let j=i+1; j<unproved_function_invs.length; j++){
                    let inv1 = unproved_function_invs[i];
                    let inv2 = unproved_function_invs[j];
                    if (inv1 == inv2){
                        continue;
                    }
                    assert(inv1.relation == InvariantRelation.IMPLICATION && inv2.relation == InvariantRelation.IMPLICATION);
                    if (inv1.to == inv2.to){
                        let new_from = new Invariant("VeriSol.Requires("+inv1.from.toExpr() + " && " + inv2.from.toExpr()+")", inv1.sourceFunc, InvariantLabel.Unknown);
                        new_from.candidateType = CandidateType.DERIVED;
                        new_from.from = inv1.from;
                        new_from.to = inv2.from;
                        new_from.relation = InvariantRelation.AND;

                        let from_expr = this.translateExpr(new_from);
                       
                        let new_inv = new Invariant(`VeriSol.Ensures(!(${from_expr}) || (${inv1.to.toExpr()}))`, inv1.sourceFunc, InvariantLabel.Unknown);
                        new_inv.candidateType = CandidateType.DERIVED;
                        new_inv.from = new_from;
                        new_inv.to = inv1.to;
                        new_inv.relation = InvariantRelation.IMPLICATION;
                        new_invs.push(new_inv);
                        i++;
                       
                    }else {
                        if (inv1.from == inv2.from){
                            let new_to = new Invariant("VeriSol.Ensures("+inv1.to.toExpr() + " || " + inv2.to.toExpr()+")", inv1.sourceFunc, InvariantLabel.Unknown);
                            new_to.candidateType = CandidateType.DERIVED;
                            new_to.from = inv1.to;
                            new_to.to = inv2.to;
                            new_to.relation = InvariantRelation.OR;

                            let from_expr = this.translateExpr(inv1.from);

                            let new_inv = new Invariant(`VeriSol.Ensures(!(${from_expr}) || (${new_to.toExpr()}))`, inv1.sourceFunc, InvariantLabel.Unknown);
                            new_inv.candidateType = CandidateType.DERIVED;
                            new_inv.from = inv1.from;
                            new_inv.to = new_to;
                            new_inv.relation = InvariantRelation.IMPLICATION;
                            new_invs.push(new_inv);
                            i++;
                          
                        }
                    }
                }
        }
        if (new_invs.length == 0){
            return false;
        }else{
            // replace this.invariants with new_invs
            // filter out all the unproved invariants
            for (let func in this.invariants){
                this.invariants[func] = this.invariants[func].filter((inv) => inv.isProved && inv.isValid);
            }
            for (let inv of new_invs){
                if (!(inv.sourceFunc in this.invariants)){
                    this.invariants[inv.sourceFunc] = [];
                }
                this.invariants[inv.sourceFunc].push(inv);
                this.invariants[inv.sourceFunc].push(inv.to);
            }
            return true;
        }
    }

    addImplicationCandidates(){
        // add implication candidate invariants
        // FIXME: how to add implication candidate invariants
        // 1. recall what is feasible implication invariant (a => b) for smart contracts
        //    * a, b are both unproved invariants
        //    * a is pre-condition, b is post-condition
        //    * there are dependencies between a and b. that is, b possibly depends on evaluation of a
        // 2. how to find the feasible implication invariants
        let new_invs : Invariant[] = [];
        let unproved_contract_invs :Invariant[] =  this.contract_invariants.filter((inv) => !inv.isProved && inv.isValid);
        let query_invs = [];
        let query_invs_expr = [];
        for (let func in this.invariants){
            let unproved_function_invs :Invariant[] =  this.invariants[func].filter((inv) => !inv.isProved && inv.isValid && !unproved_contract_invs.includes(inv));
            
            let falsified_func_invariants :Invariant[] = [];
            if (func in this.falsified_invariants)
                falsified_func_invariants = this.falsified_invariants[func];
            
            let primitive_predicates = unproved_function_invs;
            
            if(falsified_func_invariants.length>0)
                primitive_predicates = primitive_predicates.concat(falsified_func_invariants);

            // add negation form of primitive predicates a == b, or a != b
            // the resulting predicates are a != b or a == b

            let new_negation_primitive_predicates = [];
            for (let pred of primitive_predicates){
                if (pred.candidate.indexOf("==")!=-1){
                    let invariant = new Invariant(pred.candidate.replace("==", "!="), pred.sourceFunc, pred.label)
                    invariant.candidateType = CandidateType.DERIVED
                    new_negation_primitive_predicates.push(invariant);
                }else if (pred.candidate.indexOf("!=")!=-1){
                    let invariant = new Invariant(pred.candidate.replace("!=", "=="), pred.sourceFunc, pred.label)
                    invariant.candidateType = CandidateType.DERIVED
                    new_negation_primitive_predicates.push(invariant);
                }
            }
            primitive_predicates = primitive_predicates.concat(new_negation_primitive_predicates)

            const sequences = [...permutations(primitive_predicates, 2)];
            for (let sequence of sequences){
                let inv1 = sequence[0];
                let inv2 = sequence[1];
                if (inv1 == inv2){
                    continue;
                }
                if (!((inv1.candidate.indexOf("VeriSol.Requires") != -1 && inv2.candidate.indexOf("VeriSol.Ensures") != -1) || (inv2.candidate.indexOf("VeriSol.Requires") != -1 && inv1.candidate.indexOf("VeriSol.Ensures") != -1) )){
                    continue;
                }
                let inv1_pure_exp = inv1.toExpr();
                let inv2_pure_exp = inv2.toExpr();
                if ((inv1.candidate.indexOf("VeriSol.Requires") != -1 && inv2.candidate.indexOf("VeriSol.Ensures") != -1)){
                    query_invs.push([inv1, inv2]);
                    query_invs_expr.push([inv1_pure_exp, inv2_pure_exp, inv1.sourceFunc.split("(")[0]]);
                }else{
                    query_invs.push([inv2, inv1]);
                    query_invs_expr.push([inv2_pure_exp, inv1_pure_exp, inv1.sourceFunc.split("(")[0]]);
                }
            }

            // for (let i=0; i<primitive_predicates.length; i++){
            //         let inv1 = primitive_predicates[i];
            //         for (let j=i+1; j<primitive_predicates.length; j++){
            //             let inv2 = primitive_predicates[j];
            //             if (inv1 == inv2){
            //                 continue;
            //             }
            //             if (!( (inv1.candidate.indexOf("VeriSol.Requires") != -1 && inv2.candidate.indexOf("VeriSol.Ensures") != -1) || (inv2.candidate.indexOf("VeriSol.Requires") != -1 && inv1.candidate.indexOf("VeriSol.Ensures") != -1) )){
            //                 continue;
            //             }
            //             let inv1_pure_exp = inv1.toExpr();
            //             let inv2_pure_exp = inv2.toExpr();
            //             if ((inv1.candidate.indexOf("VeriSol.Requires") != -1 && inv2.candidate.indexOf("VeriSol.Ensures") != -1)){
            //                 query_invs.push([inv1, inv2]);
            //                 query_invs_expr.push([inv1_pure_exp, inv2_pure_exp, inv1.sourceFunc.split("(")[0]]);
            //             }else{
            //                 query_invs.push([inv2, inv1]);
            //                 query_invs_expr.push([inv2_pure_exp, inv1_pure_exp, inv1.sourceFunc.split("(")[0]]);
            //             }
            //         }
            // }
        }

        fs.writeFileSync("query.json-"+unique_id, JSON.stringify(query_invs_expr));
        // batch query the feasibility of implication invariants
        let cmd = `python3 -m invconplus.dependency.dependency batch --contract_file ${this.contractFile} --contract_name ${this.contractName} --query_arrays query.json-${unique_id}`;
        console.log(cmd);
       
        const { stdout, stderr, code } = shell.exec(cmd, { silent: true});
        if (stderr){
            console.log(stderr);
            exit(1);
        }else{
            // console.log(stdout);
            // parse the result
            let results = JSON.parse(stdout);
            let indice = Object.keys(results);
            // if (indice.length > 4000){
            //     indice = indice.slice(0, 4000);
            // }
            // filter out the feasible implication results
            for (let index of indice){
                if (results[index] == "feasible"){
                    let inv1 = query_invs[index][0];
                    let inv2 = query_invs[index][1];
                  
                    let inv1_pure_exp = this.translateExpr(inv1);
                   
                    let new_inv = new Invariant(`VeriSol.Ensures(!(${inv1_pure_exp}) || (${inv2.toExpr()}))`, inv1.sourceFunc, InvariantLabel.Unknown);
                    new_inv.candidateType = CandidateType.DERIVED;
                    new_inv.from = inv1;
                    new_inv.to = inv2;
                    new_inv.relation = InvariantRelation.IMPLICATION;
                    new_invs.push(new_inv);
                }
            }
        }

        
        if (new_invs.length == 0){
            return false;
        }else{
            // replace this.invariants with new_invs
            // filter out all the unproved invariants
            for (let func in this.invariants){
                this.invariants[func] = this.invariants[func].filter((inv) => inv.isProved && inv.isValid );
            }
            for (let inv of new_invs){
                if (!(inv.sourceFunc in this.invariants)){
                    this.invariants[inv.sourceFunc] = [];
                }
                this.invariants[inv.sourceFunc].push(inv);
            }
            return true;
        }
    }

    async algorithm() {
        let analyseresult: any;

        // 1. prove all the easy contract/function invariants
        do {
            let worklist = this.invariants;
            await this.performInstrument();
            analyseresult = await this.performHoudini(worklist);
            this.performImplication();
            this.iteration++;
        }while (this.addCandidate());       

        // 2. prove all the hard contract invariants
        // Assume-Guarantee reasoning
        // Verify: if contract invariants hold for the constructor (postcondition), then they hold for all the functions (guarantee)

        let unproved_contract_invs =  this.contract_invariants.filter((inv) => !inv.isProved && inv.isValid);
        for (let inv of unproved_contract_invs){
            let _inv = new Invariant(inv.candidate.replace("ContractInvariant", "Ensures"), inv.sourceFunc, inv.label);
            _inv.candidateType = CandidateType.DERIVED;
            this.addConstructorPostCondition(_inv);
        }
    
        await this.performInstrument();

        let worklist = this.invariants;
        let analyseresult2 = await this.performHoudini(worklist);
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
        let analyseresult3 = await this.performHoudini(worklist2);
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
        let analyseresult4 = await this.performHoudini(worklist3);
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
        let analyseresult5 = await this.performHoudini(worklist4);
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
        let compiler = new Compiler(this.contractFile, this.contractName, this.isSingleFile);
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

    async performHoudini(worklist: any) {
        // run verisol-houdini approach
        // get all the invariant verification results
        // *. get all the invariants that are proved
        // *. get all the invariants that are not proved

        // 1. run verisol-houdini on the instrumented contract
        let instrumented_contract = undefined;
        if (unique_id != ""){
            instrumented_contract = this.contractFile.replace(".sol",  "." + unique_id + ".verisol.sol");
        }else{
            instrumented_contract = this.contractFile.replace(".sol", ".verisol.sol");
        }
  
        if (fs.existsSync(instrumented_contract)){
            let content = fs.readFileSync(instrumented_contract, 'utf-8');
            if (content.indexOf("contract ERC721")!=-1){
                // this.contractName  = "ERC721";

                let result: CompileResult =  await compileSourceString(instrumented_contract, fs.readFileSync(instrumented_contract, "utf-8"), "auto");
                let reader = new ASTReader();
                let ast = reader.read(result.data);
                
                for (let sourceUnit of ast){
                    let myERC721 = undefined;
                    for (let node of sourceUnit.getChildren()){
                        if (node instanceof ContractDefinition && node.name == "ERC721"){
                            myERC721 = node;
                            break;
                        }
                    }
                    if (myERC721 != undefined){
                        let delete_funcs =  [];
                        for (let func in this.invariants){
                            if (["transferFrom", "safeTransferFrom", "approve", "setApprovalForAll", "approve"].indexOf(func.split("(")[0]) == -1){
                                delete_funcs.push(func);
                            }
                        }
                        for (let func of delete_funcs){
                            delete this.invariants[func];
                        }

                        let all_base_contracts = myERC721.vLinearizedBaseContracts;
                        // remove children node in SourceUnit if it is not in all_base_contracts and it is not myERC721
                        let deletes = [];
                        for (let node of sourceUnit.getChildren()){
                            if (node instanceof ContractDefinition)
                                if (myERC721!=node && node.vLinearizedBaseContracts.indexOf(myERC721)!=-1) {
                                    console.log("remove node: " + node.name)
                                    deletes.push(node);
                                }
                        }
                        for (let node of deletes){
                            sourceUnit.removeChild(node);
                        }
                        
                    }
                }

                //writing AST back to source
                const formatter = new PrettyFormatter(4, 0);
                const writer = new ASTWriter(
                    DefaultASTWriterMapping,
                    formatter,
                    "0.5.10" // set to the version of the compiler that veriSol supports
                );

                for (let sourceUnit of ast){
                    let absolutePath = sourceUnit.absolutePath;
                    let source = writer.write(sourceUnit);
                    fs.writeFileSync(absolutePath, source);
                    console.log(absolutePath);
                }

                if (unique_id!=""){
                    boogieOutputFile = "boogie.txt" + "-" + unique_id
                }
                let cmd = "VeriSol " + instrumented_contract + " " + "ERC721" + " /contractInfer" + " /boogieOutFile:"+boogieOutputFile;
                console.log(cmd);
                let { stdout, stderr, code } = shell.exec(cmd, { silent: true});
                console.log(stdout);
                let success = stdout.indexOf("Proof found! Formal Verification successful!") != -1;
        
                // 2. perform analysis on the houdini result
                let boogieFileName = path.basename(instrumented_contract).replace(".sol", "_out.bpl");
                let analyseresult = this.performAnalysis(boogieFileName, this.contractAddress+"-"+this.contractName+".txt", success);
                return analyseresult;
            }else{
                if (unique_id!=""){
                    boogieOutputFile = "boogie.txt" + "-" + unique_id
                }
                let cmd = "VeriSol " + instrumented_contract + " " + this.contractName + " /contractInfer" +  " /boogieOutFile:"+boogieOutputFile;
                console.log(cmd);
                let { stdout, stderr, code } = shell.exec(cmd, { silent: true});
                console.log(stdout);
                let success = stdout.indexOf("Proof found! Formal Verification successful!") != -1;
        
                // 2. perform analysis on the houdini result
                let boogieFileName = path.basename(instrumented_contract).replace(".sol", "_out.bpl");
                let analyseresult = this.performAnalysis(boogieFileName, this.contractAddress+"-"+this.contractName+".txt", success);
                return analyseresult;
            }
        }else{
            let verisol_dir = undefined;
            if (unique_id != ""){
                verisol_dir = "verisol" + "-" + unique_id;
            }else{
                verisol_dir = "verisol";
            }
            if (fs.existsSync(path.join(path.dirname(this.contractFile), verisol_dir, "ERC721.sol"))){
                let delete_funcs =  [];
                for (let func in this.invariants){
                    if (["transferFrom", "safeTransferFrom", "approve", "setApprovalForAll", "approve"].indexOf(func.split("(")[0]) == -1){
                        delete_funcs.push(func);
                    }
                }
                for (let func of delete_funcs){
                    delete this.invariants[func];
                }


                // this.contractName  = "ERC721";
                if (unique_id!=""){
                    boogieOutputFile = "boogie.txt" + "-" + unique_id
                }
                instrumented_contract = path.join(path.dirname(this.contractFile), verisol_dir, "ERC721.sol");
                let cmd = "VeriSol " + instrumented_contract + " " + "ERC721" + " /contractInfer" +  " /boogieOutFile:"+boogieOutputFile;
                console.log(cmd);
                let { stdout, stderr, code } = shell.exec(cmd, { silent: true});
                console.log(stdout);
                let success = stdout.indexOf("Proof found! Formal Verification successful!") != -1;
        
                // 2. perform analysis on the houdini result
                let boogieFileName = path.basename(instrumented_contract).replace(".sol", "_out.bpl");
                let analyseresult = this.performAnalysis(boogieFileName, this.contractAddress+"-"+this.contractName+".txt", success);

                return analyseresult;
            }else{
                let instrumented_contract = path.join(path.dirname(this.contractFile), verisol_dir, path.basename(this.contractFile));

                if (unique_id!=""){
                    boogieOutputFile = "boogie.txt" + "-" + unique_id
                }
                let cmd = "VeriSol " + instrumented_contract + " " + this.contractName + " /contractInfer"  +  " /boogieOutFile:"+boogieOutputFile;
               
                console.log(cmd);
                let { stdout, stderr, code } = shell.exec(cmd, { silent: true});
                console.log(stdout);
                let success = stdout.indexOf("Proof found! Formal Verification successful!") != -1;
    
                // 2. perform analysis on the houdini result
                let boogieFileName = path.basename(instrumented_contract).replace(".sol", "_out.bpl");
                let analyseresult = this.performAnalysis(boogieFileName, this.contractAddress+"-"+this.contractName+".txt", success);
                return analyseresult;
            }
        }
    }

    performAnalysis(inputFileName: string, outputFileName: string, success: boolean) {
        // const houdiniResultFileName = `./boogie.txt`;
        const houdiniResultFileName = boogieOutputFile;
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
                        try{
                            let invariant = funcInvariant[index - Math.min(...function_inv_index[func])];
                            invariant.isProved = true;
                            invariant.label = InvariantLabel.Local;
                            this_proved_invariants.push(invariant);
                            break
                        }catch(e){
                            console.log(this.contractFile, this.contractAddress, this.contractName);
                            console.log(variable, func_sig, index, Math.min(...function_inv_index[func]), funcInvariant.length, funcInvariant);
                            throw new Error("Invariant index out of range");
                        }
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
         let proved_invariants = this.proved_invariants.filter(invariant => invariant.isProved == true && invariant.isValid == true && (invariant.candidateType == CandidateType.MINED || invariant.candidateType == CandidateType.DERIVED));
         let all_implication_invariants =  proved_invariants.filter(invariant => invariant.relation == InvariantRelation.IMPLICATION);
         let non_implication_invariants = proved_invariants.filter(invariant => invariant.relation != InvariantRelation.IMPLICATION);
        
         let unproved_invariants = all_invariants.filter(invariant => invariant.isProved == false && invariant.isValid == true && (invariant.candidateType == CandidateType.MINED || invariant.candidateType == CandidateType.DERIVED));
         let unproved_Implications = unproved_invariants.filter(invariant=> ! invariant.is_primitive());
         
         if (unproved_Implications.length>0){
            // the unproved invaraints have implications 
            // we need to remove all unproved primitive invariants
            unproved_invariants = unproved_invariants.filter(invariant => !invariant.is_primitive());
         }

         
         let unused_invariants = []
         for (let implication of all_implication_invariants){
            // remove implication invariants whose postcondition hold forever in contract functions
            for (let primitive of non_implication_invariants){
                if (implication.to == primitive){
                    unused_invariants.push(implication);
                    unused_invariants.push(primitive);
                    implication.isValid = false;
                    primitive.isValid = false;
                }
            }
            if (unproved_invariants.indexOf(implication.to)!=-1){
                unproved_invariants.splice(unproved_invariants.indexOf(implication.to), 1);
                implication.to.isValid = false;
            }
         }
         proved_invariants = proved_invariants.filter(invariant => unused_invariants.indexOf(invariant)==-1)
         
         console.log('Proved Invariant Number:', proved_invariants.length);
         console.log('Unproved Invariant Number:', unproved_invariants.length);

         let outputContent = `Invariants with True value:${proved_invariants.length}\nInvariants with False value:${unproved_invariants.length}\n\n`;
         outputContent += "True Invariants:\n";
         for (let invariant of proved_invariants){
            outputContent += invariant.sourceFunc + ": " + (invariant.is_pre()? "Requires ":"Ensures ") + invariant.toExpr() + `\n`;
            // outputContent += invariant.sourceFunc + ": " + invariant.candidate + `\n`;
         }
        outputContent += "\nFalse Invariants:\n";
        for (let invariant of unproved_invariants){
            outputContent += invariant.sourceFunc + ": " + (invariant.is_pre()? "Requires ":"Ensures ") + invariant.toExpr() + `\n`;
            // outputContent += invariant.sourceFunc + ": " + invariant.candidate + `\n`;
        }
        let ofile = ""
        if (unique_id!=""){
            ofile = path.join(out_dir, `${outputFileName}-${this.iteration}-${unique_id}`) 
        }else{
            ofile = path.join(out_dir, `${outputFileName}-${this.iteration}`);
        }

        fs.writeFileSync(ofile, outputContent, 'utf8');
 
        fs.appendFileSync(output_file, [this.contractAddress, this.contractName, Date.now()-this.startTimestamp, proved_invariants.length, unproved_invariants.length, success].join(",") + "\n", 'utf8')
 
        console.log(`File ${ofile} written successfully`);
       
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

function help(){
    console.log("Usage: ts-node auto_annotation.ts --inv_file=invariant_json_file --contract_dir=contract_dir --output_dir=output_dir --iteration_cap=100 --unique_id='' --disablepartial");
    console.log("Example: node auto_annotation.js --inv_file=0x3fa18875876794040105ff06dd50662d8e4b3054.inv.json --contract_dir=./verisol_test/ --output_dir=./out/");
}

async function main(){
    const myargs = require('args-parser')(process.argv);
    if (myargs.help){
        help();
        return;
    }
    if (! myargs.inv_file){
        console.log("Please specify the invariant json file");
        help();
        return;
    }
    if (! myargs.contract_dir){
        console.log("Please specify the contract directory");
        help();
        return;
    }

    if (! myargs.output_dir){
        console.log("Please specify the output directory");
        help();
        return;
    }

    if (! myargs.unique_id){
        myargs.unique_id = ""
    }

    if (myargs.iteration_cap == undefined){
        // default iteration cap is 100
        // cannot reach 100 iterations in 30 minutes which is impossible and impractical
        myargs.iteration_cap = 100;
    }else{
        myargs.iteration_cap = parseInt(myargs.iteration_cap)
    }

    if (myargs.disablepartial){
        Flag_With_PartialInvariants = false;
    }

    out_dir = myargs.output_dir;
    if (!fs.existsSync(out_dir)){
        fs.mkdirSync(out_dir);
    }

    unique_id = myargs.unique_id;
    iteration_cap = myargs.iteration_cap;
    let invariant_json_file = myargs.inv_file;
    let contract_dir = myargs.contract_dir;
    let basename = path.basename(invariant_json_file);
    let contractAddress = basename.split("-")[0];

    // glob all the contract files with the contract address
    let contract_files = glob.sync(contract_dir+"/*"+contractAddress+".etherscan.io-*.sol");
    
    contract_files = contract_files.filter((item) => false == item.endsWith(".verisol.sol"))

    let contract_file = undefined;
    if (contract_files.length == 1){
        let isSingle = true;
        contract_file = contract_files[0];
        let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file, isSingle);
        await autoAnnotation.algorithm_program();
    // }else if (contract_files.length == 2){
    //     let isSingle = true;
    //     if (contract_files[0].indexOf("verisol")==-1){
    //         contract_file = contract_files[0];
    //     }else{
    //         contract_file = contract_files[1];
    //     }
    //     console.log(contract_file);
    //     let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file, isSingle);
    //     await autoAnnotation.algorithm_program();
    }else{
        let isSingle = false; 
        let contract_file_dirs = glob.sync(contract_dir+"/*"+contractAddress+".etherscan.io-*");
        if (contract_file_dirs.length != 1){
            throw new Error(`There should be only one contract file dir about ${contract_dir} ${contractAddress}`)
        }
        let contract_file_dir = contract_file_dirs[0];
        let mainContract = contract_file_dir.split("-")[1];
        let contract_file = path.join(contract_file_dir, mainContract+".sol")
        assert(fs.existsSync(contract_file), contract_file+" does not exist");
        // mv VeriSolContracts.sol to contract_file_dir
        
        if (! fs.existsSync(path.join(contract_file_dir, "VeriSolContracts.sol"))){
            let basedir = path.dirname(contract_file_dir);
            let cmd = `cp ${basedir}/VeriSolContracts.sol  ${contract_file_dir}`;
            shell.exec(cmd);
        }
        let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file, isSingle);
        await autoAnnotation.algorithm_program();
    }

    // let contract_file = path.join(contract_dir, basename.replace(".inv.json", ".sol").replace("-", ".etherscan.io-"));

    // if (fs.existsSync(contract_file)){
    //     let isSingle = true;
    //     let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file, isSingle);
    //     await autoAnnotation.algorithm_program();
    // }else{
    //     let contract_file_dir = path.join(contract_dir,basename.replace(".inv.json", "").replace("-", ".etherscan.io-"));
    
    //     let mainContract = contract_file_dir.split("-")[1];
    //     let contract_file = path.join(contract_file_dir, mainContract+".sol")
    //     assert(fs.existsSync(contract_file), contract_file+" does not exist");
    //     // mv VeriSolContracts.sol to contract_file_dir
        
    //     if (! fs.existsSync(path.join(contract_file_dir, "VeriSolContracts.sol"))){
    //         let basedir = path.dirname(contract_file_dir);
    //         let cmd = `cp ${basedir}/VeriSolContracts.sol  ${contract_file_dir}`;
    //         shell.exec(cmd);
    //     }
    //     let isSingle = false; 
    //     let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file, isSingle);
    //     await autoAnnotation.algorithm_program();
    // }
}

async function testSingle(){
    let contract_file = path.join(__dirname, "./../verisol_test/0x3fa18875876794040105ff06dd50662d8e4b3054.etherscan.io-TokenMintERC20Token.sol");
    let invariant_json_file = path.join(__dirname, "./../verisol_test/0x3fa18875876794040105ff06dd50662d8e4b3054-TokenMintERC20Token.inv.json");
    let autoAnnotation = new AutoAnnotation(invariant_json_file, contract_file, true);
    await autoAnnotation.algorithm_program();

    console.log(autoAnnotation.toString());
}
main();
