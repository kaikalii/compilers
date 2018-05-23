#include <iostream>
#include <cmath>
#include "tree.h"
#include "generator.h"

using namespace std;

vector<string> arg_reg = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};

unsigned nextBoundary(unsigned x) {
    return ceil(float(x)/16.f) * 16.f;
}

void Function::generate() {

    // Calculate and assign offsets
    unsigned offset = 0;
    for(auto &sym: _body->declarations()->symbols()) {
        unsigned size = sym->type().size();
        if(size < 8) size = 8;
        // size = nextBoundary(size);
        if(nextBoundary(offset) - offset < size) {
            offset = nextBoundary(offset);
        }
        offset += size;
        sym->offset = "-" + to_string(offset) + "(%rbp)";
    }
    offset = nextBoundary(offset);

    // Generate the prologue
    cout <<
        _id->name() <<":\n"
        "\tpushq\t%rbp\n"
        "\tmovq\t%rsp, %rbp\n"
        "\tsubq\t$" << offset << ", %rsp\n"
    << endl;

    // Spill parameters
    for(unsigned i = 0; i < 6 && i < _id->type().parameters()->size(); i++) {
        cout << "\tmovq\t" << arg_reg[i] << ", " << _body->declarations()->symbols()[i]->offset << endl;
    }

    // Call the body generator
    _body->generate();

    // Generate the epilogue
    cout <<
        "\n\tmovq\t%rbp, %rsp\n"
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
    _operand = _symbol->offset;
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
