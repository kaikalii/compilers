#ifndef CHECKER_H
#define CHECKER_H

#include <string>
#include <memory>
#include "type.h"

void openScope();

void closeScope();

std::string spec_to_str(int t);

void declareVariable(std::string id, std::shared_ptr<Type> type);

void defineFunction(std::string id, std::shared_ptr<Type> type);

unsigned num_to_int(std::string num);

#endif
