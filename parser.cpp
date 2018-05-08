#include <string>
#include <iostream>
#include <assert.h>
#include <memory>

#include "type.h"
#include "symbol.h"
#include "scope.h"
#include "lexer.h"
#include "checker.h"

using namespace std;

token_t lookahead, nexttoken;
string lexbuf, nextbuf;
bool peeked = false;
int	lineno = 1;
shared_ptr<Scope> global_scope = make_shared<Scope>(nullptr);
shared_ptr<Scope> curr_scope = global_scope;

void match(token_t t) {
    if(peeked) {
        lookahead = nexttoken;
        lexbuf	  = nextbuf;
        peeked	  = false;
    } else {
        if(lookahead == t) lookahead = lexan(lexbuf);
        else {
            cout << "error on line: " << lineno << endl;
            cout << "expected token " << t + 8 << ", found token " << lookahead + 8 << endl;
            lookahead = lexan(lexbuf);
        }
    }
}

token_t peek() {
    if(!peeked) {
        nexttoken = lexan(nextbuf);
        peeked	  = true;
    }
    return nexttoken;
}

unsigned pointers() {
    unsigned count = 0;

    while(lookahead == STAR) {
        match(STAR);
        count++;
    }
    return count;
}

bool isSpecifier(token_t t) {
    return t == token_t::INT || t == token_t::LONG || t == token_t::CHAR;
}

token_t specifier() {
    token_t temp = lookahead;

    if(lookahead == token_t::INT) match(token_t::INT);
    else if(lookahead == token_t::LONG) match(token_t::LONG);
    else if(lookahead == token_t::CHAR) match(token_t::CHAR);
    return temp;
}

Type expression(bool& lvalue);

Type term(bool& lvalue) {
    Type type = Type();
    if(lookahead == ID) {
        auto symbol = curr_scope->lookup(lexbuf);
        if(!symbol) cerr << "line " << lineno << ": '" << lexbuf << "' undeclared" << endl;
        type = *symbol->type();
        if(type.kind() == SCALAR) lvalue = true;
        match(ID);
        if(lookahead == LPAREN) {
            lvalue = false;
            Parameters params;
            match(LPAREN);
            if(lookahead == RPAREN) match(RPAREN);
            else {
                params.push_back(make_shared<Type>(expression(lvalue)));
                while(lookahead == COMMA) {
                    match(COMMA);
                    params.push_back(make_shared<Type>(expression(lvalue)));
                }
                match(RPAREN);
            }
            type = checkFunctionCall(type, params);
        }
    }
    else if(lookahead == NUM) {
        if(lexbuf.back() == 'l' || lexbuf.back() == 'L') type = Type(LONG);
        else type = Type(INT);
        lvalue = false;
        match(NUM);
    }
    else if(lookahead == STRING) {
        type = Type(CHAR, 1);
        lvalue = false;
        match(STRING);
    }
    else if(lookahead == LPAREN) {
        match(LPAREN);
        type = expression(lvalue);
        match(RPAREN);
    }
    return type;
}

Type expIndex(bool& lvalue) {
    Type left = term(lvalue);
    while(lookahead == LBRACKET) {
        match(LBRACKET);
        left = checkIndex(left, expression(lvalue));
        lvalue = true;
        match(RBRACKET);
    }
    return left;
}

Type expUn(bool& lvalue) {
    if(lookahead == ADDR) {
        match(ADDR);
        Type operand = expUn(lvalue);
        operand = checkReference(operand, lvalue);
        lvalue = false;
        return operand;

    } else if(lookahead == STAR) {
        match(STAR);
        Type operand = expUn(lvalue);
        operand = checkDereference(operand);
        lvalue = true;
        return operand;

    } else if(lookahead == NOT) {
        match(NOT);
        Type operand = expUn(lvalue);
        operand = checkNot(operand);
        lvalue = false;

    } else if(lookahead == MINUS) {
        match(MINUS);
        Type operand = expUn(lvalue);
        operand = checkNegate(operand);
        lvalue = false;

    } else if(lookahead == SIZEOF) {
        match(SIZEOF);
        Type operand;
        if(lookahead == LPAREN && isSpecifier(peek())) {
            match(LPAREN);
            token_t spec = specifier();
            unsigned indirection = pointers();
            match(RPAREN);
            operand = Type(spec, indirection);
        } else {
            operand = expUn(lvalue);
        }
        lvalue = false;
        return operand;
    }
    return expIndex(lvalue);
}

Type expCast(bool& lvalue) {
    if(lookahead == LPAREN && isSpecifier(peek())) {
        match(LPAREN);
        token_t spec = specifier();
        unsigned indirection = pointers();
        match(RPAREN);
        Type from = expCast(lvalue);
        Type to = Type(spec, indirection);
        to = checkCast(to, from);
        lvalue = false;

        return to;
    }
    else {
        return expUn(lvalue);
    }
}

Type expMul(bool& lvalue) {
    Type left = expCast(lvalue);
    while(1) {
        if(lookahead == STAR) {
            match(STAR);
            Type right = expCast(lvalue);
            left = checkMultiplication(left, right, "*");
            lvalue = false;

        } else if(lookahead == DIV) {
            match(DIV);
            Type right = expCast(lvalue);
            left = checkMultiplication(left, right, "/");
            lvalue = false;

        } else if(lookahead == REM) {
            match(REM);
            Type right = expCast(lvalue);
            left = checkMultiplication(left, right, "%");
            lvalue = false;

        } else break;
    }
    return left;
}

Type expAdd(bool& lvalue) {
    Type left = expMul(lvalue);
    while(1) {
        if(lookahead == PLUS) {
            match(PLUS);
            Type right = expMul(lvalue);
            left = checkAddition(left, right);
            lvalue = false;

        } else if(lookahead == MINUS) {
            match(MINUS);
            Type right = expMul(lvalue);
            left = checkSubtraction(left, right);
            lvalue = false;

        } else break;
    }
    return left;
}

Type expComp(bool& lvalue) {
    Type left = expAdd(lvalue);
    while(1) {
        if(lookahead == LTN) {
            match(LTN);
            Type right = expAdd(lvalue);
            left = checkLogicalEqComp(left, right, "<");
            lvalue = false;

        } else if(lookahead == GTN) {
            match(GTN);
            Type right = expAdd(lvalue);
            left = checkLogicalEqComp(left, right, ">");
            lvalue = false;

        } else if(lookahead == LEQ) {
            match(LEQ);
            Type right = expAdd(lvalue);
            left = checkLogicalEqComp(left, right, "<=");
            lvalue = false;

        } else if(lookahead == GEQ) {
            match(GEQ);
            Type right = expAdd(lvalue);
            left = checkLogicalEqComp(left, right, ">=");
            lvalue = false;

        } else break;
    }
    return left;
}

Type expEql(bool& lvalue) {
    Type left = expComp(lvalue);
    while(1) {
        if(lookahead == EQL) {
            match(EQL);
            Type right = expComp(lvalue);
            left = checkLogicalEqComp(left, right, "==");
            lvalue = false;

        } else if(lookahead == NEQ) {
            match(NEQ);
            Type right = expComp(lvalue);
            left = checkLogicalEqComp(left, right, "!=");
            lvalue = false;

        } else break;
    }
    return left;
}

Type expAnd(bool& lvalue) {
    Type left = expEql(lvalue);
    while(lookahead == AND) {
        match(AND);
        Type right = expEql(lvalue);
        left = checkLogicalAnd(left, right);
        lvalue = false;

    }
    return left;
}

Type expOr(bool& lvalue) {
    Type left = expAnd(lvalue);
    while(lookahead == OR) {
        match(OR);
        Type right = expAnd(lvalue);
        left = checkLogicalOr(left, right);
        lvalue = false;

    }
    return left;
}

Type expression(bool& lvalue) {

    Type result = expOr(lvalue);

    return result;
}

void expList() {

    bool lvalue;
    expression(lvalue);
    while(lookahead == COMMA) {
        match(COMMA);
        expression(lvalue);
    }

}

void declarator(token_t typespec) {


    unsigned indirection = pointers();
    if(lookahead == ID) {
        string id = lexbuf;
        match(ID);
        if(lookahead == LBRACKET) {
            match(LBRACKET);
            declareVariable(id, make_shared<Type>(typespec, indirection, num_to_int(lexbuf)));
            match(NUM);
            match(RBRACKET);
        } else declareVariable(id, make_shared<Type>(typespec, indirection));
    }


}

void declaratorList(token_t typespec) {


    declarator(typespec);
    while(lookahead == COMMA) {
        match(COMMA);
        declarator(typespec);
    }


}

void declaration() {


    token_t typespec = specifier();
    declaratorList(typespec);
    match(SEMICOLON);


}

void declarations() {

    while(isSpecifier(lookahead)) {
        declaration();
    }

}

void statements();

void statement() {
    bool lvalue;
    if(lookahead == LCURLY) {
        openScope();
        match(LCURLY);
        declarations();
        statements();
        match(RCURLY);
        closeScope();
    } else if(lookahead == RETURN) {
        match(RETURN);
        expression(lvalue);
        match(SEMICOLON);
    } else if(lookahead == WHILE) {
        match(WHILE);
        match(LPAREN);
        expression(lvalue);
        match(RPAREN);
        statement();
    } else if(lookahead == IF) {
        match(IF);
        match(LPAREN);
        expression(lvalue);
        match(RPAREN);
        statement();
        if(lookahead == ELSE) {
            match(ELSE);
            statement();
        }
    } else {
        expression(lvalue);
        if(lookahead == ASSIGN) {
            match(ASSIGN);
            expression(lvalue);
        }
        match(SEMICOLON);
    }

}

void statements() {

    while(lookahead != RCURLY) {
        statement();
    }

}

shared_ptr<Type> parameter() {


    token_t typespec = specifier();
    unsigned indirection = pointers();
    string id = lexbuf;
    match(ID);
    shared_ptr<Type> type = make_shared<Type>(typespec, indirection);
    declareVariable(id, type);



    return type;
}

Parameters parameterList() {


    Parameters types(1, parameter());

    while(lookahead == COMMA) {
        match(COMMA);
        types.push_back(parameter());
    }



    return types;
}

Parameters parameters() {
    if(lookahead == VOID) {
        match(VOID);
        return Parameters(1, make_shared<Type>(VOID));
    }
    return parameterList();
}

void globalDeclarator(token_t typespec) {
    unsigned indirection = pointers();
    string	 id			 = lexbuf;

    match(ID);
    if(lookahead == LPAREN) {
        match(LPAREN);
        match(RPAREN);
        declareVariable(id, make_shared<Type>(typespec, indirection, nullptr));
    } else if(lookahead == LBRACKET) {
        match(LBRACKET);
        declareVariable(id, make_shared<Type>(typespec, indirection, num_to_int(lexbuf)));
        match(NUM);
        match(RBRACKET);
    }
    else {
        declareVariable(id, make_shared<Type>(typespec, indirection));
    }
}

void translationUnit() {
    token_t	 typespec	 = specifier();
    unsigned indirection = pointers();
    string	 id			 = lexbuf;

    match(ID);
    if(lookahead == LPAREN) {
        match(LPAREN);
        if(lookahead != RPAREN) {
            openScope();
            auto function_parameters = parameters();
            match(RPAREN);
            defineFunction(id, make_shared<Type>(typespec, indirection, new Parameters(function_parameters)));
            match(LCURLY);
            declarations();
            statements();
            match(RCURLY);
            closeScope();
        } else {
            match(RPAREN);
            declareVariable(id, make_shared<Type>(typespec, indirection, nullptr));
            while(lookahead == COMMA) {
                match(COMMA);
                globalDeclarator(typespec);
            }
            match(SEMICOLON);
        }
    } else if(lookahead == LBRACKET) {
        match(LBRACKET);
        declareVariable(id, make_shared<Type>(typespec, indirection, num_to_int(lexbuf)));
        match(NUM);
        match(RBRACKET);
        while(lookahead == COMMA) {
            match(COMMA);
            globalDeclarator(typespec);
        }
        match(SEMICOLON);
    } else {
        declareVariable(id, make_shared<Type>(typespec, indirection));
        while(lookahead == COMMA) {
            match(COMMA);
            globalDeclarator(typespec);
        }
        match(SEMICOLON);
    }
}

int main() {
    lookahead = lexan(lexbuf);
    while(lookahead != DONE) {
        translationUnit();
    }
    return 0;
}
