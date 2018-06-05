/*
 * File:	generator.h
 *
 * Description:	This file contains the function declarations for the code
 *		generator for Simple C.  Most of the function declarations
 *		are actually member functions provided as part of tree.h.
 */

# ifndef GENERATOR_H
# define GENERATOR_H
# include "scope.h"

void generateGlobals(Scope *scope);

# endif /* GENERATOR_H */
