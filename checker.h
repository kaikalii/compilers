#ifndef CHECKER_H
#define CHECKER_H

#include <string>
#include <memory>
#include "type.h"
#include "scope.h"

extern std::shared_ptr<Scope> global_scope, curr_scope;

void openScope();

void closeScope();

std::string spec_to_str(int t);

void declareVariable(std::string id, std::shared_ptr<Type> type);

void defineFunction(std::string id, std::shared_ptr<Type> type);

unsigned num_to_int(std::string num);

Type checkLogicalOr(const Type& left, const Type& right);

Type checkLogicalAnd(const Type& left, const Type& right);

Type checkLogicalEqComp(const Type& left, const Type& right, const std::string& op);

Type checkAddition(const Type& left, const Type& right);

Type checkSubtraction(const Type& left, const Type& right);

Type checkMultiplication(const Type& left, const Type& right, const std::string& op);

Type checkCast(const Type& left, const Type& right);

Type checkReference(const Type& operand, const bool& lvalue);

Type checkDereference(const Type& operand);

Type checkNot(const Type& operand);

Type checkNegate(const Type& operand);

Type checkSizeOf(const Type& operand);

Type checkIndex(const Type& left, const Type& right);

Type checkFunctionCall(const Type& ret, const Parameters& args);

#endif
