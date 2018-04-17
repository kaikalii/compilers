#include <string>
#include <iostream>

#include "lexer.h"

using namespace std;

#define DEBUG false

token_t lookahead, nextahead;
string lexbuf, nextbuf;
bool peeked = false;

void match(token_t t) {
    if(DEBUG) cout << lookahead + 8 << " ?= " << t + 8 << ": " << (lookahead == t) << endl;
    if(!peeked) {
        if(lookahead == t) lookahead = lexan(lexbuf);
        else cout << "error" << endl;
    }
    else {
        lookahead = nextahead;
        lexbuf = nextbuf;
        peeked = false;
    }
}

token_t peek() {
    if(peeked) {
        return nextahead;
    }
    else {
        nextahead = lexan(nextbuf);
        peeked = true;
    }
}

void pointers() {
    while(lookahead == STAR) match(STAR);
}

bool isSpecifier(token_t t) {
    return t == INT || t == LONG || t == CHAR;
}

void specifier() {
    if(lookahead == INT) match(INT);
    else if(lookahead == LONG) match(LONG);
    else if(lookahead == CHAR) match(CHAR);
}

void expOr();

void term() {
    // impl expression-list
    if(lookahead == ID) {
        match(ID);
        if(lookahead == LPAREN) {
            match(LPAREN);
            match(RPAREN);
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
    else if(lookahead == NEG) {
        match(NEG);
        expUn();
        cout << "neg" << endl;
    }
    else if(lookahead == SIZEOF) {
        match(SIZEOF);
        if(lookahead == LPAREN) {
            match(LPAREN);
            if(isSpecifier(lookahead)) {
                specifier();
                pointers();
            }
            else {
                expUn();
            }
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
    if(lookahead == LPAREN) {
        match(LPAREN);
        bool sp = false;
        if(isSpecifier(lookahead)) {
            specifier();
            pointers();
            sp = true;
        }
        else {
            expOr();
        }
        match(RPAREN);
        if(sp) {
            expUn();
            cout << "cast" << endl;
        }
    }
    else expUn();
}

void expMul() {
    expCast();
    if(lookahead == STAR) {
        match(STAR);
        expMul();
        cout << "mul" << endl;
    }
    else if(lookahead == DIV) {
        match(DIV);
        expMul();
        cout << "div" << endl;
    }
    else if(lookahead == REM) {
        match(REM);
        expMul();
        cout << "rem" << endl;
    }
}

void expAdd() {
    expMul();
    if(lookahead == ADD) {
        match(ADD);
        expAdd();
        cout << "add" << endl;
    }
    else if(lookahead == SUB) {
        match(SUB);
        expAdd();
        cout << "sub" << endl;
    }
}

void expComp() {
    expAdd();
    if(lookahead == LTN) {
        match(LTN);
        expComp();
        cout << "ltn" << endl;
    }
    else if(lookahead == GTN) {
        match(GTN);
        expComp();
        cout << "gtn" << endl;
    }
    else if(lookahead == LEQ) {
        match(LEQ);
        expComp();
        cout << "leq" << endl;
    }
    else if(lookahead == GEQ) {
        match(GEQ);
        expComp();
        cout << "geq" << endl;
    }
}

void expEql() {
    expComp();
    if(lookahead == EQL) {
        match(EQL);
        expEql();
        cout << "eql" << endl;
    }
    else if(lookahead == NEQ) {
        match(NEQ);
        expEql();
        cout << "neq" << endl;
    }
}

void expAnd() {
    expEql();
    if(lookahead == AND) {
        match(AND);
        expAnd();
        cout << "and" << endl;
    }
}

void expOr() {
    expAnd();
    if(lookahead == OR) {
        match(OR);
        expOr();
        cout << "or" << endl;
    }
}

void expression() {
    if(DEBUG) cout << "start expression" << endl;
    expOr();
    if(DEBUG) cout << "expression" << endl;
}

void expList() {
    if(DEBUG) cout << "start expression-list" << endl;
    expression();
    while(lookahead == COMMA) {
        match(COMMA);
        expOr();
    }
    if(DEBUG) cout << "expression-list" << endl;
}

void declarator() {
    if(DEBUG) cout << "start declarator" << endl;
    pointers();
    if(lookahead == ID) {
        match(ID);
        if(lookahead == LBRACKET) {
            match(LBRACKET);
            match(NUM);
            match(RBRACKET);
        }
    }
    if(DEBUG) cout << "declarator" << endl;
}

void declaratorList() {
    if(DEBUG) cout << "start declarator-list" << endl;
    declarator();
    while(lookahead == COMMA) {
        match(COMMA);
        declarator();
    }
    if(DEBUG) cout << "declarator-list" << endl;
}

void declaration() {
    if(DEBUG) cout << "start declaration" << endl;
    if(isSpecifier(lookahead)) {
        specifier();
        declaratorList();
        match(SEMICOLON);
    }
    if(DEBUG) cout << "declaration" << endl;
}

void declarations() {
    if(DEBUG) cout << "start declarations" << endl;
    while(isSpecifier(lookahead)) {
        declaration();
    }
    if(DEBUG) cout << "declarations" << endl;
}

void statements();

void statement() {
    if(DEBUG) cout << "start statement" << endl;
    if(lookahead == LCURLY) {
        match(LCURLY);
        declarations();
        statements();
        match(RCURLY);
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
    if(DEBUG) cout << "statement" << endl;
}

void statements() {
    if(DEBUG) cout << "start statements" << endl;
    while(lookahead != RCURLY) {
        statement();
    }
    if(DEBUG) cout << "statement" << endl;
}

void parameter() {
    if(isSpecifier(lookahead)) {
        specifier();
        pointers();
        match(ID);
    }
}

void parameterList() {
    parameter();
    while(lookahead == COMMA) {
        match(COMMA);
        parameter();
    }
}

void parameters() {
    if(lookahead == VOID) {
        match(VOID);
    }
    else {
        parameterList();
    }
}

void functionDefinition() {
    if(isSpecifier(lookahead)) {
        specifier();
        pointers();
        match(ID);
        match(LPAREN);
        parameters();
        match(RPAREN);
        match(LCURLY);
        declarations();
        statements();
        match(RCURLY);
    }

}

int main() {
    lookahead = lexan(lexbuf);
    // while(lookahead != DONE) {
        functionDefinition();
    // }
    return 0;
}
