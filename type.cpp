#include "type.h"

using namspace std;

bool Type::operator!=(const Type& rhs) const {
    return !operator==(rhs);
}
