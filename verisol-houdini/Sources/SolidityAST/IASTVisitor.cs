﻿// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.
namespace SolidityAST
{
    public interface IASTVisitor
    {
        bool Visit(SourceUnitList node);
        bool Visit(SourceUnit node);
        bool Visit(PragmaDirective node);
        bool Visit(UsingForDirective node);
        bool Visit(ImportDirective node);
        bool Visit(ContractDefinition node);
        bool Visit(InheritanceSpecifier node);
        bool Visit(FunctionDefinition node);
        bool Visit(ParameterList node);
        bool Visit(ModifierDefinition node);
        bool Visit(ModifierInvocation node);
        bool Visit(EventDefinition node);
        bool Visit(StructDefinition node);
        bool Visit(EnumDefinition node);
        bool Visit(EnumValue node);
        bool Visit(VariableDeclaration node);
        bool Visit(ElementaryTypeName node);
        bool Visit(UserDefinedTypeName node);
        bool Visit(Mapping node);
        bool Visit(ArrayTypeName node);
        bool Visit(Block node);
        bool Visit(PlaceholderStatement node);
        bool Visit(IfStatement node);
        bool Visit(WhileStatement node);
        bool Visit(DoWhileStatement node);
        bool Visit(ForStatement node);
        bool Visit(Continue node);
        bool Visit(Break node);
        bool Visit(Return node);
        bool Visit(Throw node);
        bool Visit(EmitStatement node);
        bool Visit(VariableDeclarationStatement node);
        bool Visit(InlineAssembly node);
        bool Visit(ExpressionStatement node);
        bool Visit(Literal node);
        bool Visit(Identifier node);
        bool Visit(ElementaryTypeNameExpression node);
        bool Visit(UnaryOperation node);
        bool Visit(BinaryOperation node);
        bool Visit(Conditional node);
        bool Visit(Assignment node);
        bool Visit(TupleExpression node);
        bool Visit(FunctionCall node);
        bool Visit(NewExpression node);
        bool Visit(MemberAccess node);
        bool Visit(IndexAccess node);

        void EndVisit(SourceUnitList node);
        void EndVisit(SourceUnit node);
        void EndVisit(PragmaDirective node);
        void EndVisit(UsingForDirective node);
        void EndVisit(ImportDirective node);
        void EndVisit(ContractDefinition node);
        void EndVisit(InheritanceSpecifier node);
        void EndVisit(FunctionDefinition node);
        void EndVisit(ParameterList node);
        void EndVisit(ModifierDefinition node);
        void EndVisit(ModifierInvocation node);
        void EndVisit(EventDefinition node);
        void EndVisit(StructDefinition node);
        void EndVisit(EnumDefinition node);
        void EndVisit(EnumValue node);
        void EndVisit(VariableDeclaration node);
        void EndVisit(ElementaryTypeName node);
        void EndVisit(UserDefinedTypeName node);
        void EndVisit(Mapping node);
        void EndVisit(ArrayTypeName node);
        void EndVisit(Block node);
        void EndVisit(PlaceholderStatement node);
        void EndVisit(IfStatement node);
        void EndVisit(WhileStatement node);
        void EndVisit(DoWhileStatement node);
        void EndVisit(ForStatement node);
        void EndVisit(Continue node);
        void EndVisit(Break node);
        void EndVisit(Return node);
        void EndVisit(Throw node);
        void EndVisit(EmitStatement node);
        void EndVisit(VariableDeclarationStatement node);
        void EndVisit(InlineAssembly node);
        void EndVisit(ExpressionStatement node);
        void EndVisit(Literal node);
        void EndVisit(Identifier node);
        void EndVisit(ElementaryTypeNameExpression node);
        void EndVisit(UnaryOperation node);
        void EndVisit(BinaryOperation node);
        void EndVisit(Conditional node);
        void EndVisit(Assignment node);
        void EndVisit(TupleExpression node);
        void EndVisit(FunctionCall node);
        void EndVisit(NewExpression node);
        void EndVisit(MemberAccess node);
        void EndVisit(IndexAccess node);
    }
}
