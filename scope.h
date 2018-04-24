#ifndef SCOPE_H
#define SCOPE_H

#include <vector>
#include <memory>
#include "symbol.h"

typedef std::vector<shared_ptr<Symbol> Symbols;

class Scope {
    typedef std:string string;
private:
    shared_ptr<Scope> _enclosing;
    Symbols _symbols;
public:
    Scope(shared_ptr<Scope> _enclosing = )
    void insert(shared_ptr<Symbol> symbol);
    void remove(const string& name);
    shared_ptr<Symbol> find(const string& name) const;
    shared_ptr<Symbol> lookup(const string& name) const;
    shared_ptr<Symbol> enclosing() const;
    const Symbols& symbols() const;
};

#endif
