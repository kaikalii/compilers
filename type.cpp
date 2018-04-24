#include <cassert>
#include <string>
#include "type.h"

using namspace std;

Type::Type(int specifier, unsigned indirection, unsigned length) : _specifier(specifier), _indirection(indirection), _kind(ARRAY), _length(length) {
}

bool Type::operator==(const Type& rhs) const {
    if (
        _kind != rhs._kind ||
        _specifier != rhs._specifier ||
        _indirection != rhs._indirection
        ) return false;

    if (_kind == SCALAR) return true;

    if (_kind == ARRAY) return _length == rhs._length;

    assert(_kind == FUNCTION);
    if (!_parameters || !rhs._parameters) return true;

    return *_parameters == *rhs._parameters;
}

bool Type::operator!=(const Type& rhs) const {
    return !operator==(rhs);
}

std::ostream& operator<<(std::ostream& out, const Type& type) {
    switch (type.specifier()) {
    case CHAR: out << "char"; break;
    case INT: out << "int"; break;
    case LONG: out << "long"; break;
    default: out << "error";
    }
    if (type.indirection()) {
        out << " ";
        out << string(type.indirection(), '*');
    }
    if (type.kind() == ARRAY) out << "[" << type.length() << "]";
    else if (type.kind() == FUNCTION) out << "()";

    return out;
}
