/*
 * File:	generator.h
 *
 * Description:	This file contains the function declarations for the code
 *		generator for Simple C.  Most of the function declarations
 *		are actually member functions provided as part of tree.h.
 */

# ifndef GENERATOR_H
# define GENERATOR_H
# include <iostream>
# include <string>
# include "scope.h"

void generateGlobals(Scope *scope);

class Label {
    static unsigned _counter;
    std::string _number;
public:
    Label(std::string prefix = ".L");
    std::string number() const;
};

std::ostream &operator <<(std::ostream &ostr, const Label &label);

class StringLabel : public Label  {
    std::string _s;
public:
    StringLabel(std::string s);
    const std::string& str() const;
};

# endif /* GENERATOR_H */
