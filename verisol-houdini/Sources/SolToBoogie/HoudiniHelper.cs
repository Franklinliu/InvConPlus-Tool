// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
namespace SolToBoogie
{
    using System;
    using System.Collections.Generic;
    using BoogieAST;
    using SolidityAST;
    using SolToBoogie;

    public class HoudiniHelper
    {
        // returns a map from integer id to an atomic Boogie predicate
        public static (Dictionary<int, BoogieExpr>, int ) GenerateHoudiniVarMapping(ContractDefinition contract, TranslatorContext context, Dictionary<string, List<BoogieExpr>> contractInvariants)
        {
            Dictionary<int, BoogieExpr> ret = new Dictionary<int, BoogieExpr>();
            HashSet<VariableDeclaration> stateVars = context.GetVisibleStateVarsByContract(contract);

            // collect all state variables of type address
            List<VariableDeclaration> addressVariables = new List<VariableDeclaration>();
            List<VariableDeclaration> stringVariables = new List<VariableDeclaration>();
            List<VariableDeclaration> uint256Variables = new List<VariableDeclaration>();
            List<VariableDeclaration> boolVariables = new List<VariableDeclaration>();

            foreach (VariableDeclaration stateVar in stateVars)
            {
                if (stateVar.TypeName is ElementaryTypeName elementaryType)
                {
                    // Address variables
                    if (elementaryType.TypeDescriptions.TypeString.Equals("address") ||
                        elementaryType.TypeDescriptions.TypeString.Equals("address payable"))
                    {
                        addressVariables.Add(stateVar);
                    }

                    // String variables
                    if (elementaryType.TypeDescriptions.TypeString.Equals("string"))
                    {
                        stringVariables.Add(stateVar);
                    }

                    // unsign integers
                    if (elementaryType.TypeDescriptions.TypeString.Equals("uint256"))
                    {
                        uint256Variables.Add(stateVar);
                    }

                    // bool
                    if (elementaryType.TypeDescriptions.TypeString.Equals("bool"))
                    {
                        boolVariables.Add(stateVar);
                    }
                }
            }

            int id = 0;

            // equaility and disequality to null
            foreach (VariableDeclaration addressVar in addressVariables)
            {
                BoogieExpr lhs = GetBoogieExprOfStateVar(addressVar, context);
                BoogieExpr rhs = new BoogieIdentifierExpr("null");
                BoogieExpr equality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.EQ, lhs, rhs);
                ret[++id] = equality;
                BoogieExpr disequality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.NEQ, lhs, rhs);
                ret[++id] = disequality;
            }

            // equaility and disequality to 0
            foreach (VariableDeclaration stringVar in stringVariables)
            {
                BoogieExpr lhs = GetBoogieExprOfStateVar(stringVar, context);
                BoogieExpr rhs = new BoogieIdentifierExpr("0");
                BoogieExpr equality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.EQ, lhs, rhs);
                ret[++id] = equality;
                BoogieExpr disequality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.NEQ, lhs, rhs);
                ret[++id] = disequality;
            }

            // equaility and disequality to 0
            foreach (VariableDeclaration uint256Var in uint256Variables)
            {
                BoogieExpr lhs = GetBoogieExprOfStateVar(uint256Var, context);
                BoogieExpr rhs = new BoogieIdentifierExpr("0");
                BoogieExpr equality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.EQ, lhs, rhs);
                ret[++id] = equality;
                BoogieExpr disequality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.NEQ, lhs, rhs);
                ret[++id] = disequality;
                BoogieExpr greater = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.GE, lhs, rhs);
                ret[++id] = greater;
                BoogieExpr lesser = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.LE, lhs, rhs);
                ret[++id] = lesser;
            }

            // equaility to true and false
            foreach (VariableDeclaration boolVar in boolVariables)
            {
                BoogieExpr lhs = GetBoogieExprOfStateVar(boolVar, context);
                BoogieExpr rhs1 = new BoogieIdentifierExpr("true");
                BoogieExpr trueexpr = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.EQ, lhs, rhs1);
                ret[++id] = trueexpr;
                BoogieExpr rhs2 = new BoogieIdentifierExpr("false");
                BoogieExpr falseexpr = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.EQ, lhs, rhs2);
                ret[++id] = falseexpr;
            }

            // pair-wise equality and disequality
            for (int i = 0; i < addressVariables.Count; ++i)
            {
                BoogieExpr lhs = GetBoogieExprOfStateVar(addressVariables[i], context);
                for (int j = i + 1; j < addressVariables.Count; ++j)
                {
                    BoogieExpr rhs = GetBoogieExprOfStateVar(addressVariables[j], context);
                    BoogieExpr equality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.EQ, lhs, rhs);
                    ret[++id] = equality;
                    BoogieExpr disequality = new BoogieBinaryOperation(BoogieBinaryOperation.Opcode.NEQ, lhs, rhs);
                    ret[++id] = disequality;
                }
            }

            int derivedHoudiniCandidateCount = id;

            // add the contract invariant if present
            if (contractInvariants.ContainsKey(contract.Name))
            {
                foreach (BoogieExpr inv in contractInvariants[contract.Name])
                {
                    ret[++id] = inv;
                }
            }
            
            // PrintHoudiniCandidateMap(ret);
            return (ret, derivedHoudiniCandidateCount);
        }
        
        private static BoogieMapSelect GetBoogieExprOfStateVar(VariableDeclaration varDecl, TranslatorContext context)
        {
            string name = TransUtils.GetCanonicalStateVariableName(varDecl, context);
            BoogieMapSelect mapSelect = new BoogieMapSelect(new BoogieIdentifierExpr(name), new BoogieIdentifierExpr("this"));
            return mapSelect;
        }

        private static void PrintHoudiniCandidateMap(Dictionary<int, BoogieExpr> map)
        {
            Console.WriteLine("Houdini Candidates:");
            foreach (int key in map.Keys)
            {
                Console.WriteLine($"{key} --> {map[key]}");
            }
            Console.WriteLine();
        }
    }
}
