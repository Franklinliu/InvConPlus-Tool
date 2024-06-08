// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
namespace SolToBoogie
{
    using System.Diagnostics;
    using SolidityAST;

    public class VeriSolInvCollector : BasicASTVisitor
    {
        private TranslatorContext context;

        public VeriSolInvCollector(TranslatorContext context)
        {
            this.context = context;
        }

        public override bool Visit(FunctionDefinition node)
        {
            if (node.Body == null) return false;
            foreach (ASTNode child in node.Body.Statements)
            {

                // Traverse all the statements in the function body
                if (child is ExpressionStatement exprStmt)
                {
                    if (exprStmt.Expression is FunctionCall funcCall)
                    {
                        if (funcCall.Expression is MemberAccess ident)
                        {
                            if (ident.MemberName.Equals("Requires") || ident.MemberName.Equals("Ensures"))
                            {
                                // Found an verisol statement
                                context.AddVeriSolInvariantToFunction(node, funcCall);
                            }
                        }
                    }
                }
            }
            return false;
        }
    }
}
