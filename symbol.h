#ifndef SYMBOL_H
#define SYMBOL_H

#include <string>
#include <memory>
#include "type.h"

class Symbol {
private:
    typedef std::string string;
    string _id;
    std::shared_ptr<Type> _type;
public:
    Symbol(const string& id, std::shared_ptr<Type> type);
    string id();
    std::shared_ptr<Type> type();
    bool operator==(const Symbol& rhs);
    bool operator!=(const Symbol& rhs);
};

#endif
