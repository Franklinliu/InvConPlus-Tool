import * as fs from 'fs';

const args: string[] = process.argv.slice(2);
const inputIndex: number = args.findIndex(arg => arg === '-i');
const outputIndex: number = args.findIndex(arg => arg === '-o');

if (inputIndex === -1 || inputIndex === args.length - 1) {
    // If the `-i` flag is not found or out of range, log an error message and exit
    console.error('Error: Input filename is missing. Usage: ts-node --analyseresult.ts -i <filename> -o <filename>');
    process.exit(1);
}

if (outputIndex === -1 || outputIndex === args.length - 1) {
    // If the `-i` flag is not found or out of range, log an error message and exit
    console.error('Error: Output filename is missing. Usage: ts-node --analyseresult.ts -i <filename> -o <filename>');
    process.exit(1);
}

const inputFileName: string = args[inputIndex + 1];

// If the input file not exist, log an error message and exit
if (!fs.existsSync(`./${inputFileName}`)) {
    console.error(`Error: Input file ${inputFileName} does not exist`);
    process.exit(1);
}

const outputFileName: string = args[outputIndex + 1];

const houdiniResultFileName = `./boogie.txt`;

// Read the file synchronously
const houdiniResultFileContent = fs.readFileSync(houdiniResultFileName, 'utf8');


// Split the file content into individual lines
const resultFileLines = houdiniResultFileContent.trim().split('\n');

// Initialize lists for variables with True and False values
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
console.log('Variables with True value:', trueVariables.length);
console.log('Variables with False value:', falseVariables.length);

// Initialize an object to store the variable content
const trueVariableContent: { [variable: string]: string } = {};
const falseVariableContent: { [variable: string]: string } = {};

const boogieFileName = `./${inputFileName}`;
const boogieFileContent = fs.readFileSync(boogieFileName, 'utf8');

// Iterate over the variable names and extract the content using regular expressions
trueVariables.forEach(variable => {
    const regex = new RegExp(`(requires|ensures|invariant)\\s+\\(*${variable}\\)*\\s+==>${'\\s+'}(.+);`);
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
const outputContent = `Invariants with True value:${trueVariables.length}\nInvariants with False value:${falseVariables.length}\n\n
True Invariants:\n${Object.entries(trueVariableContent).map(([variable, content]) => `${variable}: ${content}`).join('\n')}\n\n
False Invariants:\n${Object.entries(falseVariableContent).map(([variable, content]) => `${variable}: ${content}`).join('\n')}`;
fs.writeFileSync(`./out/${outputFileName}`, outputContent, 'utf8');

console.log(`File ${outputFileName} written successfully`);