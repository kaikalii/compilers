#include <string>
#include <iostream>
#include <assert.h>
#include <memory>

#include "type.h"
#include "lexer.h"
#include "checker.h"

using namespace std;

token_t lookahead, nexttoken;
string lexbuf, nextbuf;
bool peeked = false;
int lineno = 1;

void match(token_t t) {
    if(peeked) {
        lookahead = nexttoken;
        lexbuf = nextbuf;
        peeked = false;
    }
    else {
        if(lookahead == t) lookahead = lexan(lexbuf);
        else {
            cout << "error on line: " << lineno << endl;
            cout << "expected token " << t + 8 << ", found token " << lookahead + 8 << endl;
            assert(lookahead == t);
        }
    }
}

token_t peek() {
    if(!peeked) {
        nexttoken = lexan(nextbuf);
        peeked = true;
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

void expOr(), expression();

void term() {
    if(lookahead == ID) {
        match(ID);
        if(lookahead == LPAREN) {
            match(LPAREN);
            if(lookahead == RPAREN) match(RPAREN);
            else {
                expression();
                while(lookahead == COMMA) {
                    match(COMMA);
                    expression();
                }
                match(RPAREN);
            }
        }
    }
    else if(lookahead == NUM) match(NUM);
    else if(lookahead == STRING) match(STRING);
    else if(lookahead == LPAREN) {
        match(LPAREN);
        expOr();
        match(RPAREN);
    }
}

void expIndex() {
    term();
    while(lookahead == LBRACKET) {
        match(LBRACKET);
        expOr();
        match(RBRACKET);
        cout << "index" << endl;
    }
}

void expUn() {
    if(lookahead == ADDR) {
        match(ADDR);
        expUn();
        cout << "addr" << endl;
    }
    else if(lookahead == STAR) {
        match(STAR);
        expUn();
        cout << "deref" << endl;
    }
    else if(lookahead == NOT) {
        match(NOT);
        expUn();
        cout << "not" << endl;
    }
    else if(lookahead == MINUS) {
        match(MINUS);
        expUn();
        cout << "neg" << endl;
    }
    else if(lookahead == SIZEOF) {
        match(SIZEOF);
        if(lookahead == LPAREN && isSpecifier(peek())) {
            match(LPAREN);
            specifier();
            pointers();
            match(RPAREN);
        }
        else expUn();
        cout << "sizeof" << endl;
    }
    else {
        expIndex();
    }
}

void expCast() {
    if(lookahead == LPAREN && isSpecifier(peek())) {
        match(LPAREN);
        specifier();
        pointers();
        match(RPAREN);
        expCast();
        cout << "cast" << endl;
    }
    expUn();
}

void expMul() {
    expCast();
    while(1) {
        if(lookahead == STAR) {
            match(STAR);
            expCast();
            cout << "mul" << endl;
        }
        else if(lookahead == DIV) {
            match(DIV);
            expCast();
            cout << "div" << endl;
        }
        else if(lookahead == REM) {
            match(REM);
            expCast();
            cout << "rem" << endl;
        }
        else break;
    }
}

void expAdd() {
    expMul();
    while(1) {
        if(lookahead == PLUS) {
            match(PLUS);
            expMul();
            cout << "add" << endl;
        }
        else if(lookahead == MINUS) {
            match(MINUS);
            expMul();
            cout << "sub" << endl;
        }
        else break;
    }
}

void expComp() {
    expAdd();
    while(1) {
        if(lookahead == LTN) {
            match(LTN);
            expAdd();
            cout << "ltn" << endl;
        }
        else if(lookahead == GTN) {
            match(GTN);
            expAdd();
            cout << "gtn" << endl;
        }
        else if(lookahead == LEQ) {
            match(LEQ);
            expAdd();
            cout << "leq" << endl;
        }
        else if(lookahead == GEQ) {
            match(GEQ);
            expAdd();
            cout << "geq" << endl;
        }
        else break;
    }
}

void expEql() {
    expComp();
    while(1) {
        if(lookahead == EQL) {
            match(EQL);
            expComp();
            cout << "eql" << endl;
        }
        else if(lookahead == NEQ) {
            match(NEQ);
            expComp();
            cout << "neq" << endl;
        }
        else break;
    }
}

void expAnd() {
    expEql();
    while(1) {
        if(lookahead == AND) {
            match(AND);
            expEql();
            cout << "and" << endl;
        }
        else break;
    }
}

void expOr() {
    expAnd();
    while(1) {
        if(lookahead == OR) {
            match(OR);
            expAnd();
            cout << "or" << endl;
        }
        else break;
    }
}

void expression() {
    #ifdef DEBUG
    cout << "start expression" << endl;
    #endif
    expOr();
    #ifdef DEBUG
    cout << "expression" << endl;
    #endif
}

void expList() {
    #ifdef DEBUG
    cout << "start expression-list" << endl;
    #endif
    expression();
    while(lookahead == COMMA) {
        match(COMMA);
        expOr();
    }
    #ifdef DEBUG
    cout << "expression-list" << endl;
    #endif
}

void declarator(token_t typespec) {
    #ifdef DEBUG
    cout << "start declarator" << endl;
    #endif

    unsigned indirection = pointers();
    if(lookahead == ID) {
        string id = lexbuf;
        match(ID);
        if(lookahead == LBRACKET) {
            match(LBRACKET);
            declareVariable(id, make_shared<Type>(typespec, indirection, num_to_int(lexbuf)));
            match(NUM);
            match(RBRACKET);
        }
        else declareVariable(id, make_shared<Type>(typespec, indirection));
    }

    #ifdef DEBUG
    cout << "declarator" << endl;
    #endif
}

void declaratorList(token_t typespec) {
    #ifdef DEBUG
    cout << "start declarator-list" << endl;
    #endif

    declarator(typespec);
    while(lookahead == COMMA) {
        match(COMMA);
        declarator(typespec);
    }

    #ifdef DEBUG
    cout << "declarator-list" << endl;
    #endif
}

void declaration() {
    #ifdef DEBUG
    cout << "start declaration" << endl;
    #endif

    token_t typespec = specifier();
    declaratorList(typespec);
    match(SEMICOLON);

    #ifdef DEBUG
    cout << "declaration" << endl;
    #endif
}

void declarations() {
    #ifdef DEBUG
    cout << "start declarations" << endl;
    #endif
    while(isSpecifier(lookahead)) {
        declaration();
    }
    #ifdef DEBUG
    cout << "declarations" << endl;
    #endif
}

void statements();

void statement() {
    #ifdef DEBUG
    cout << "start statement" << endl;
    #endif
    if(lookahead == LCURLY) {
        openScope();
        match(LCURLY);
        declarations();
        statements();
        match(RCURLY);
        closeScope();
    }
    else if(lookahead == RETURN) {
        match(RETURN);
        expression();
        match(SEMICOLON);
    }
    else if(lookahead == WHILE) {
        match(WHILE);
        match(LPAREN);
        expression();
        match(RPAREN);
        statement();
    }
    else if(lookahead == IF) {
        match(IF);
        match(LPAREN);
        expression();
        match(RPAREN);
        statement();
        if(lookahead == ELSE) {
            match(ELSE);
            statement();
        }
    }
    else {
        expression();
        if(lookahead == ASSIGN) {
            match(ASSIGN);
            expression();
        }
        match(SEMICOLON);
    }
    #ifdef DEBUG
    cout << "statement" << endl;
    #endif
}

void statements() {
    #ifdef DEBUG
    cout << "start statements" << endl;
    #endif
    while(lookahead != RCURLY) {
        statement();
    }
    #ifdef DEBUG
    cout << "statement" << endl;
    #endif
}

shared_ptr<Type> parameter() {
    if(isSpecifier(lookahead)) {
        token_t typespec = specifier();
        unsigned indirection = pointers();
        string id = lexbuf;
        match(ID);
        shared_ptr<Type> type = make_shared<Type>(typespec, indirection);
        declareVariable(id, type);
        return type;
    }
    else return shared_ptr<Type>();
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
    string id = lexbuf;
    match(ID);
    if(lookahead == LPAREN) {
        match(LPAREN);
        match(RPAREN);
        declareVariable(id, make_shared<Type>(typespec, indirection, new Parameters));
    }
    else if(lookahead == LBRACKET) {
        match(LBRACKET);
        declareVariable(id, make_shared<Type>(typespec, indirection, num_to_int(lexbuf)));
        match(NUM);
        match(RBRACKET);
    }
}

void translationUnit() {
    token_t typespec = specifier();
    unsigned indirection = pointers();
    string id = lexbuf;
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
        }
        else {
            match(RPAREN);
            declareVariable(id, make_shared<Type>(typespec, indirection, new Parameters));
            while(lookahead == COMMA) {
                match(COMMA);
                globalDeclarator(typespec);
            }
            match(SEMICOLON);
        }
    }
    else if(lookahead == LBRACKET) {
        match(LBRACKET);
        declareVariable(id, make_shared<Type>(typespec, indirection, num_to_int(lexbuf)));
        match(NUM);
        match(RBRACKET);
        while(lookahead == COMMA) {
            match(COMMA);
            globalDeclarator(typespec);
        }
        match(SEMICOLON);
    }
    else {
        while(lookahead == COMMA) {
            match(COMMA);
            globalDeclarator(typespec);
        }
        match(SEMICOLON);
    }
}

int main() {
    lookahead = lexan(lexbuf);
    openScope();
    while(lookahead != DONE) {
        translationUnit();
    }
    closeScope();
    return 0;
}
