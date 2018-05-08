#ifndef TYPE_H
#define TYPE_H

#include <vector>
#include <ostream>
#include <memory>
#include "tokens.h"

typedef std::vector<std::shared_ptr<class Type> > Parameters;

enum kind_t { ERROR, ARRAY, FUNCTION, SCALAR };

class Type {
private:
token_t _specifier;
unsigned _indirection;
kind_t _kind;
unsigned _length;
std::shared_ptr<Parameters> _parameters;
public:
Type();
Type(token_t specifier, unsigned indirection = 0);
Type(token_t specifier, unsigned indirection, unsigned length);
Type(token_t specifier, unsigned indirection, Parameters *parameters);
bool operator==(const Type& rhs) const;
bool operator!=(const Type& rhs) const;
token_t specifier() const;
unsigned indirection() const;
Type reference() const;
Type dereference() const;
kind_t kind() const;
unsigned length() const;
std::shared_ptr<Parameters> parameters() const;
Type promote() const;
bool isNumeric() const;
bool isLogical() const;
bool isPointer() const;
bool isCompatibleWith(const Type& other) const;
};

std::ostream& operator<<(std::ostream& out, const Type& type);

#endif
