#include <cassert>
#include <string>
#include "type.h"

using namespace std;

Type::Type(token_t specifier, unsigned indirection) : _specifier(specifier), _indirection(indirection), _kind(SCALAR) {
}
Type::Type(token_t specifier, unsigned indirection, unsigned length) : _specifier(specifier), _indirection(indirection), _kind(ARRAY), _length(length) {
}
Type::Type(token_t specifier, unsigned indirection, Parameters *parameters) : _specifier(specifier), _indirection(indirection), _kind(FUNCTION), _parameters(parameters) {
}

bool Type::operator==(const Type& rhs) const {
    if(
        _kind != rhs._kind ||
        _specifier != rhs._specifier ||
        _indirection != rhs._indirection
    ) return false;

    if(_kind == SCALAR) return true;

    if(_kind == ARRAY) return _length == rhs._length;

    assert(_kind == FUNCTION);
    if(!_parameters || !rhs._parameters) return true;

    return *_parameters == *rhs._parameters;
}

bool Type::operator!=(const Type& rhs) const {
    return !operator==(rhs);
}

std::ostream& operator<<(std::ostream& out, const Type& type) {
    switch(type.specifier()) {
    case CHAR: out << "char"; break;
    case INT: out << "int"; break;
    case LONG: out << "long"; break;
    default: out << "error";
    }
    if(type.indirection()) {
        out << " ";
        out << string(type.indirection(), '*');
    }
    if(type.kind() == ARRAY) out << "[" << type.length() << "]";
    else if(type.kind() == FUNCTION) out << "()";

    return out;
}

token_t Type::specifier() const {
    return _specifier;
}
unsigned Type::indirection() const {
    return _indirection;
}
kind_t Type::kind() const {
    return _kind;
}
unsigned Type::length() const {
    return _length;
}
Parameters* Type::parameters() const {
    return _parameters;
}
