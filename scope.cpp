#include <vector>
#include <memory>
#include <algorithm>
#include <iostream>
#include "symbol.h"
#include "scope.h"

using namespace std;

Scope::Scope(shared_ptr<Scope> enclosing) : _enclosing(enclosing) {}

void Scope::insert(shared_ptr<Symbol> symbol) {
    _symbols.push_back(symbol);
}

void Scope::remove(const string& name) {
    Symbols new_symbols;
    for(auto &s: _symbols) {
        if(s->id() != name) new_symbols.push_back(s);
    }
    _symbols = new_symbols;
}

const shared_ptr<Symbol> Scope::find(const string& name) const {
    for(auto &s: _symbols) {
        if(s->id() == name) return s;
    }
    return shared_ptr<Symbol>(nullptr);
}

const shared_ptr<Symbol> Scope::lookup(const string& name) const {
    #ifdef DEBUG
    cout << "Scope::lookup(" << name << ")" << endl;
    #endif
    auto curr_scope = shared_from_this();
    while(curr_scope) {
        if(auto symbol = curr_scope->find(name)) return symbol;
        curr_scope = curr_scope->enclosing();
    }

    #ifdef DEBUG
    cout << "Scope::lookup(" << name << ") failed" << endl;
    #endif

    return shared_ptr<Symbol>(nullptr);
}

const shared_ptr<Scope> Scope::enclosing() const {
    return _enclosing;
}

const Symbols& Scope::symbols() const {
    return _symbols;
}
