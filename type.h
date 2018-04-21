#ifndef TYPE_H
#define TYPE_H

#include <vector>
#include <ostream>

typedef std::vector<class Type> Parameters;

enum specifier_t {INT, LONG, CHAR};
enum kind_t {ARRAY, FUNCTION, SCALAR};

class Type {
private:
    specifier_t _specifier;
    unsigned _indirection;
    kind_t _kind;
    unsigned _length;
    Parameters* _parameters;
public:
    Type(specifier_t specifier, unsigned indirection = 0);
    Type(specifier_t specifier, unsigned indirection, unsigned length);
    Type(specifier_t specifier, unsigned indirection, Parameters *parameters);
    bool operator==(const Type& rhs) const;
    bool operator!=(const Type& rhs) const;
    specifier_t specifier() const;
    unsigned indirection() const;
    kind_t kind() const;
    unsigned length() const;
    Parameters* parameters() const;
};

std::ostream& operator<<(std::ostream& out, const Type& type);

#endif
