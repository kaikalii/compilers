#include <iostream>
#include <cmath>
#include "tree.h"
#include "scope.h"
#include "generator.h"

using namespace std;

vector<string> arg_reg = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};

unsigned nextBoundary(unsigned x) {
    return ceil(float(x)/16.f) * 16.f;
}

void declareGlobals(Scope *scope) {
    bool globals_declared = false;
    for(auto &sym: scope->symbols()) {
        if(!sym->type().isFunction()) {
            if(!globals_declared) globals_declared = true, cout << "# declare globals" << endl;
            cout << ".comm\t" << sym->name() << "," << sym->type().size() << "," << sym->type().size() << endl;
        }
    }
}

void Function::generate() {

    // Generate the prologue
    cout <<
        _id->name() << ":\n"
        "\t# " << _id->name() << "() prologue\n" <<
        "\tpushq\t%rbp\n"
        "\tmovq\t%rsp, %rbp\n"
        "\tsubq\t$" << _id->name() << ".size, %rsp\n"
    << endl;

    // Calculate and assign offsets
    unsigned neg_offset = 0;
    unsigned pos_offset = 8;
    auto& sym = _body->declarations()->symbols();
    for(unsigned i = 0; i < sym.size(); i++) {
        unsigned size = sym[i]->type().size();
        if(size < 8) size = 8;
        // One of the first six parameters
        if(i < 6) {
            if(nextBoundary(neg_offset) - neg_offset < size) {
                neg_offset = nextBoundary(neg_offset);
            }
            neg_offset += size;
            sym[i]->_offset = "-" + to_string(neg_offset) + "(%rbp)";
            cout << "\tmovq\t" << arg_reg[i] << ", " << sym[i]->_offset << endl;
        }
        else if(i >= 6) {
            // One of the parameters after the sixth
            if(i < _id->type().parameters()->size()) {
                if(nextBoundary(pos_offset) - pos_offset < size) {
                    pos_offset = nextBoundary(pos_offset);
                }
                pos_offset += size;
                sym[i]->_offset = to_string(pos_offset) + "(%rbp)";
            }
            // Local variables
            else {
                if(nextBoundary(neg_offset) - neg_offset < size) {
                    neg_offset = nextBoundary(neg_offset);
                }
                neg_offset += size;
                sym[i]->_offset = "-" + to_string(neg_offset) + "(%rbp)";
            }
        }
    }
    neg_offset = nextBoundary(neg_offset);
    cout << "\t.set\t" << _id->name() << ".size, " << neg_offset << endl << endl;

    // Call the body generator
    _body->generate();

    // Generate the epilogue
    cout <<
        "\n\t# " << _id->name() << "() epilogue" << endl <<
        "\tmovq\t%rbp, %rsp\n"
        "\tpopq\t%rbp\n"
        "\tret\n"
        "\t.globl\t" << _id->name()
    << endl << endl;
}

void Block::generate() {
    for(auto &s: _stmts) {
        s->generate();
    }
}

void Number::generate() {
    _operand = "$" + _value;
}

void Identifier::generate() {
    if(_symbol->_offset == "$0") _operand = _symbol->name() + "(%rip)";
    else _operand = _symbol->_offset;
}

void Call::generate() {

    for(auto &arg: _args) {
        arg->generate();
    }
    for(unsigned i = 0; i < 6 && i < _args.size(); i++) {
        cout << "\tmovq\t" << _args[i]->_operand << ", " << arg_reg[i] << endl;
    }
    for(int i = _args.size() - 1; i >= 6; i--) {
        cout << "\tpushq\t" << _args[i]->_operand << endl;
    }
    cout << "\tcall\t" << _id->name() << endl;
    if(_args.size() > 6) cout << "\taddq\t$" << (_args.size() - 6) * 16 << ", %rsp" << endl;
}

void Assignment::generate() {
    //TODO: phase 6 - generate actual expressions
    ((Identifier*)_left)->generate();
    ((Number*)_right)->generate();
    string mov = "mov";
    switch(_left->type().size()) {
        case 1: mov += "b"; break;
        case 4: mov += "l"; break;
        case 8: mov += "q"; break;
    }
    cout << "\t" << mov << "\t" << _right->_operand << ", " << _left->_operand << endl;
}
