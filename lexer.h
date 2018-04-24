#ifndef LEXER_H
#define LEXER_H

#include <string>
#include "tokens.h"

extern int lineno, numerrors;

token_t lexan(std::string &lexbuf);

#endif
