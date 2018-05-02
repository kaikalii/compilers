#include <iostream>
#include <string>
#include <memory>
#include "tokens.h"
#include "type.h"
#include "symbol.h"
#include "scope.h"
#include "checker.h"
#include "lexer.h"

using namespace std;

void openScope() {
    #ifdef DEBUG
    cout << "opening scope" << endl;
    #endif
    curr_scope = make_shared<Scope>(curr_scope);
}

void closeScope() {
    #ifdef DEBUG
    cout << "closing scope" << endl;
    #endif
    curr_scope = curr_scope->enclosing();
    if(!curr_scope) global_scope = curr_scope;
}

string spec_to_str(int t) {
    switch(t) {
        case token_t::INT: return "int";
        case token_t::LONG: return "long";
        case token_t::CHAR: return "char";
        case token_t::VOID: return "void";
        default: return "spec_to_str() error";
    }
}

void declareVariable(string id, std::shared_ptr<Type> type) {
    auto global_symbol = curr_scope->lookup(id);
    auto local_symbol = curr_scope->find(id);
    if(!global_symbol) {
        curr_scope->insert(make_shared<Symbol>(id, type));

        #ifdef DEBUG
        cout << "declaring " << spec_to_str(type->specifier()) << " " << string(type->indirection(), '*') << id;
        if(type->kind() == ARRAY) cout << "[" << type->length() << "]";
        else if(type->kind() == FUNCTION) cout << "()";
        cout << endl;
        #endif
    }
    else if (curr_scope != global_scope && local_symbol) {
        cerr << "line " << lineno << ": redeclaration of '" << id << "'" << endl;
    }
    else if(local_symbol && *type != *(local_symbol->type())) {
        cerr << "line " << lineno << ": conflicting types for '" << id << "'" << endl;
    }
}

void defineFunction(std::string id, std::shared_ptr<Type> type) {

    // Check if the id is already in the global scope
    if(auto symbol = global_scope->find(id)) {
        // Check if the version of the symbol in scope has parameters...
        if(symbol->type()->parameters()) {
            cerr << "line " << lineno << ": redefinition of '" << id << "'" << endl;
            *symbol = Symbol(id, type);
        }
        // ...if it doesn't, check if it is the same type
        else if(*type == *(symbol->type())) {
            *symbol = Symbol(id, type);

            #ifdef DEBUG
            cout << "defining " << spec_to_str(type->specifier()) << " " << string(type->indirection(), '*') << id << "(";
            unsigned i = 0;
            for(auto p: *type->parameters()) {
                cout << spec_to_str(p->specifier()) << string(p->indirection(), '*');
                if(i != type->parameters()->size() - 1) cout << ", ";
                i++;
            }
            cout << ")" << endl;
            #endif
        }
        else {
            cerr << "line " << lineno << ": conflicting types for '" << id << "'" << endl;
            *symbol = Symbol(id, type);
        }
    }
    else {
        global_scope->insert(make_shared<Symbol>(id, type));
    }
}

unsigned num_to_int(string num) {
    if(*num.rbegin() == 'L' || *num.rbegin() == 'l') {
        num.pop_back();
    }
    return stoi(num);
}
