#include <iostream>
#include <string>
#include "tokens.h"
#include "type.h"
#include "checker.h"

using namespace std;

void openScope() {
    cout << "opening scope" << endl;
}

void closeScope() {
    cout << "closing scope" << endl;
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
    cout << "declaring " << spec_to_str(type->specifier()) << " " << string(type->indirection(), '*') << id;
    if(type->kind() == ARRAY) cout << "[" << type->length() << "]";
    else if(type->kind() == FUNCTION) cout << "()";
    cout << endl;
}

void defineFunction(std::string id, std::shared_ptr<Type> type) {
    cout << "defining " << spec_to_str(type->specifier()) << " " << string(type->indirection(), '*') << id << "(";
    unsigned i = 0;
    for(auto p: *type->parameters()) {
        cout << spec_to_str(p->specifier()) << string(p->indirection(), '*');
        if(i != type->parameters()->size() - 1) cout << ", ";
        i++;
    }
    cout << ")" << endl;;
}

unsigned num_to_int(string num) {
    if(*num.rbegin() == 'L' || *num.rbegin() == 'l') {
        num.pop_back();
    }
    return stoi(num);
}
