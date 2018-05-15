#include <iostream>
#include <string>
#include <memory>
#include "tokens.h"
#include "type.h"
#include "symbol.h"
#include "scope.h"
#include "checker.h"
#include "lexer.h"

using namespace std;

void openScope() {
    #ifdef DEBUG
    cout << "opening scope" << endl;
    #endif
    curr_scope = make_shared<Scope>(curr_scope);
}

void closeScope() {
    #ifdef DEBUG
    cout << "closing scope" << endl;
    #endif
    curr_scope = curr_scope->enclosing();
    if(!curr_scope) global_scope = curr_scope;
}

string spec_to_str(int t) {
    switch(t) {
        case token_t::INT: return "int";
        case token_t::LONG: return "long";
        case token_t::CHAR: return "char";
        case token_t::VOID: return "void";
        default: return "spec_to_str() error";
    }
}

void declareVariable(string id, std::shared_ptr<Type> type) {
    auto global_symbol = curr_scope->lookup(id);
    auto local_symbol = curr_scope->find(id);
    if (curr_scope != global_scope && local_symbol) {
        cout << "line " << lineno << ": redeclaration of '" << id << "'" << endl;
    }
    else if(local_symbol && *type != *(local_symbol->type())) {
        cout << "line " << lineno << ": conflicting types for '" << id << "'" << endl;
    }
    else {
        curr_scope->insert(make_shared<Symbol>(id, type));

        #ifdef DEBUG
        cout << "declaring " << spec_to_str(type->specifier()) << " " << string(type->indirection(), '*') << id;
        if(type->kind() == ARRAY) cout << "[" << type->length() << "]";
        else if(type->kind() == FUNCTION) cout << "()";
        cout << endl;
        #endif
    }
}

void defineFunction(std::string id, std::shared_ptr<Type> type) {

    // Check if the id is already in the global scope
    if(auto symbol = global_scope->find(id)) {
        // Check if the version of the symbol in scope has parameters...
        if(symbol->type()->parameters()) {
            cout << "line " << lineno << ": redefinition of '" << id << "'" << endl;
            *symbol = Symbol(id, type);
        }
        // ...if it doesn't, check if it is the same type
        else if(*type == *(symbol->type())) {
            *symbol = Symbol(id, type);

            #ifdef DEBUG
            cout << "defining " << spec_to_str(type->specifier()) << " " << string(type->indirection(), '*') << id << "(";
            unsigned i = 0;
            for(auto p: *type->parameters()) {
                cout << spec_to_str(p->specifier()) << string(p->indirection(), '*');
                if(i != type->parameters()->size() - 1) cout << ", ";
                i++;
            }
            cout << ")" << endl;
            #endif
        }
        else {
            cout << "line " << lineno << ": conflicting types for '" << id << "'" << endl;
            *symbol = Symbol(id, type);
        }
    }
    else {
        global_scope->insert(make_shared<Symbol>(id, type));
    }
}

unsigned num_to_int(string num) {
    if(*num.rbegin() == 'L' || *num.rbegin() == 'l') {
        num.pop_back();
    }
    return stoi(num);
}

Type checkLogicalOr(const Type& left, const Type& right) {
    if(left.kind() == ERROR || right.kind() == ERROR) return Type();
	if(left.promote().isLogical() && right.promote().isLogical()) return Type(INT);
	cerr << "line " << lineno << ": invalid operands to binary ||" << endl;
	return Type();
}

Type checkLogicalAnd(const Type& left, const Type& right) {
    if(left.kind() == ERROR || right.kind() == ERROR) return Type();
	if(left.promote().isLogical() && right.promote().isLogical()) return Type(INT);
	cerr << "line " << lineno << ": invalid operands to binary &&" << endl;
	return Type();
}

Type checkLogicalEqComp(const Type& left, const Type& right, const string& op) {
    if(left.kind() == ERROR || right.kind() == ERROR) return Type();
	if(left.promote().isCompatibleWith(right.promote())) return Type(INT);
	cerr << "line " << lineno << ": invalid operands to binary " << op << "" << endl;
	return Type();
}

Type checkAddition(const Type& left, const Type& right) {
    if(left.kind() == ERROR || right.kind() == ERROR) return Type();
    auto lp = left.promote();
    auto rp = right.promote();
    if(lp.isNumeric() && rp.isNumeric()) {
        if(lp.specifier() == LONG || rp.specifier() == LONG) return Type(LONG);
        else return Type(INT);
    }
    if(lp.isPointer() && rp.isNumeric()) return lp;
    if(lp.isNumeric() && rp.isPointer()) return rp;
    cerr << "line " << lineno << ": invalid operands to binary +" << endl;
    return Type();
}

Type checkSubtraction(const Type& left, const Type& right) {
    if(left.kind() == ERROR || right.kind() == ERROR) return Type();
    auto lp = left.promote();
    auto rp = right.promote();
    if(lp.isNumeric() && rp.isNumeric()) {
        if(lp.specifier() == LONG || rp.specifier() == LONG) return Type(LONG);
        else return Type(INT);
    }
    if(lp.isPointer() && rp.isNumeric()) return lp;
    if(lp.isPointer() && rp.isPointer() && lp.specifier() == rp.specifier()) return Type(LONG);
    cerr << "line " << lineno << ": invalid operands to binary -" << endl;
    return Type();
}

Type checkMultiplication(const Type& left, const Type& right, const string& op) {
    if(left.kind() == ERROR || right.kind() == ERROR) return Type();
    auto lp = left.promote();
    auto rp = right.promote();
    if(lp.isNumeric() && rp.isNumeric()) {
        if(lp.specifier() == LONG || rp.specifier() == LONG) return Type(LONG);
        else return Type(INT);
    }
    cout << left << " -> " << lp << ", " << right << " -> " << rp << endl;
    cerr << "line " << lineno << ": invalid operands to binary " << op << endl;
    return Type();
}

Type checkCast(const Type& to, const Type& from) {
    if(to.kind() == ERROR || from.kind() == ERROR) return Type();
    if(to.promote().isNumeric() && from.promote().isNumeric()) return to;
    if(to.promote().isPointer() && from.promote().isPointer()) return to;
    if(to.promote().isPointer() && from.promote().specifier() == LONG) return to;
    if(to.promote().specifier() == LONG && from.promote().isPointer()) return to;
    cerr << "line " << lineno << ": invalid operand in cast expression" << endl;
    return Type();
}

Type checkReference(const Type& operand, const bool& lvalue) {
    if(operand.kind() == ERROR) return Type();
    if(lvalue) {
        return operand.reference();
    }
    else {
        cerr << "line " << lineno << ": lvalue required in expression" << endl;
        return Type();
    }
}

Type checkDereference(const Type& operand) {
    if(operand.kind() == ERROR) return Type();
    if(operand.promote().isPointer()) {
        return operand.promote().dereference();
    }
    else {
        cerr << "line " << lineno << ": invalid operand to unary *" << endl;
        return Type();
    }
}

Type checkNot(const Type& operand) {
    if(operand.kind() == ERROR) return Type();
    if(operand.isLogical()) return Type(INT);
    else {
        cerr << "line " << lineno << ": invalid operand to unary !" << endl;
        return Type();
    }
}

Type checkNegate(const Type& operand) {
    if(operand.kind() == ERROR) return Type();
    if(operand.isNumeric()) return operand.promote();
    else {
        cerr << "line " << lineno << ": invalid operand to unary -" << endl;
        return Type();
    }
}

Type checkSizeOf(const Type& operand) {
    if(operand.kind() == ERROR) return Type();
    if(operand.kind() != FUNCTION) {
        return Type(LONG);
    }
    else {
        cerr << "line " << lineno << ": invalid operand in sizeof expression" << endl;
        return Type();
    }
}

Type checkIndex(const Type& left, const Type& right) {
    if(left.kind() == ERROR || right.kind() == ERROR) return Type();
    if(left.promote().isPointer() && right.promote().isNumeric()) return left.promote().dereference();
    else {
        cerr << "line " << lineno << ": invalid operands to binary []" << endl;
        return Type();
    }
}

Type checkFunctionCall(const Type& ret, const Parameters& args) {
    if(ret.kind() == FUNCTION) {
        if(!ret.parameters()) return Type(ret.specifier(), ret.indirection());
        if(ret.parameters()->size() != args.size()) {
            cerr << "line " << lineno << ": invalid arguments to called function" << endl;
            return Type();
        }
        for(int i = 0; i < args.size(); i++) {
            if( !(*ret.parameters())[i]->isCompatibleWith(*args[i]) ) {
                cerr << "line " << lineno << ": invalid arguments to called function" << endl;
                return Type();
            }
        }
        return Type(ret.specifier(), ret.indirection());
    }
    else {
        cerr << "line " << lineno << ": called object is not a function" << endl;
        return Type();
    }
}
