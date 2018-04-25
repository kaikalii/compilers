#ifndef SCOPE_H
#define SCOPE_H

#include <vector>
#include <memory>
#include "symbol.h"

typedef std::vector<std::shared_ptr<Symbol> > Symbols;

class Scope : std::enable_shared_from_this<Scope> {
private:
    typedef std::string	string;
    std::shared_ptr<Scope> _enclosing;
    Symbols _symbols;
public:
    Scope(std::shared_ptr<Scope> enclosing = std::shared_ptr<Scope>(nullptr));
    void insert(std::shared_ptr<Symbol> symbol);
    void remove(const string& name);
    const std::shared_ptr<Symbol> find(const string& name) const;
    const std::shared_ptr<Symbol> lookup(const string& name) const;
    const std::shared_ptr<Scope> enclosing() const;
    const Symbols& symbols() const;
};

#endif
