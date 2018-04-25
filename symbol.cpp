#include <string>
#include <memory>
#include "type.h"
#include "symbol.h"

using namespace::std;

Symbol::Symbol(const string& id, shared_ptr<Type> type) : _id(id), _type(type) {
}

string Symbol::id() {
    return _id;
}
shared_ptr<Type> Symbol::type() {
    return _type;
}

bool Symbol::operator==(const Symbol& rhs) {
    return _id == rhs._id;
}
bool Symbol::operator!=(const Symbol& rhs) {
    return !operator==(rhs);
}
