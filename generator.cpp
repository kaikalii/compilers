/*
 * File:	generator.cpp
 *
 * Description:	This file contains the public and member function
 *		definitions for the code generator for Simple C.
 *
 *		Extra functionality:
 *		- putting all the global declarations at the end
 */

# include <sstream>
# include <iostream>
# include <vector>
# include <assert.h>
# include "generator.h"
# include "register.h"
# include "machine.h"
# include "tree.h"

using namespace std;


/* This needs to be set to zero if temporaries are placed on the stack. */

# define SIMPLE_PROLOGUE 1


/* Okay, I admit it ... these are lame, but they work. */

# define isNumber(expr)		(expr->_operand[0] == '$')
# define isRegister(expr)	(expr->_register != nullptr)
# define isMemory(expr)		(!isNumber(expr) && !isRegister(expr))



Label::Label(string prefix) {
    _number = prefix + to_string(_counter++);
}
string Label::number() const {
    return _number;
}
unsigned Label::_counter = 0;

ostream &operator<<(ostream &ostr, const Label &label) {
    return ostr << label.number();
}

StringLabel::StringLabel(std::string s) :Label("string"), _s(s) {}
const string& StringLabel::str() const {
    return _s;
}

static vector<StringLabel> string_labels;
static Label return_label;

static int tempoffset;

/* The registers that we are using in the assignment. */

static Register *rax = new Register("%rax", "%eax", "%al");
static Register *rdi = new Register("%rdi", "%edi", "%dil");
static Register *rsi = new Register("%rsi", "%esi", "%sil");
static Register *rdx = new Register("%rdx", "%edx", "%dl");
static Register *rcx = new Register("%rcx", "%ecx", "%cl");
static Register *r8 = new Register("%r8", "%r8d", "%r8b");
static Register *r9 = new Register("%r9", "%r9d", "%r9b");
static vector<Register *> parameters = {rdi, rsi, rdx, rcx, r8, r9};
static Register *rbx = new Register("%rbx", "%ebx", "%bl");
static Register *r10 = new Register("%r10", "%r10d", "%r10b");
static Register *r11 = new Register("%r11", "%r11d", "%r11b");
static Register *r12 = new Register("%r12", "%r12d", "%r12b");
static Register *r13 = new Register("%r13", "%r13d", "%r13b");
static Register *r14 = new Register("%r14", "%r14d", "%r14b");
static Register *r15 = new Register("%r15", "%r15d", "%r15b");
static vector<Register *> registers = {rdi, rsi, rdx, rcx, r8, r9, rbx, r10, r11, r12, r13, r14, r15};

/*
* Function:	operator << (private)
*
* Description:	Write an expression to the specified stream.  This function
*		first checks to see if the expression is in a register, and
*		if not then uses its operand.
*/

static ostream &operator <<(ostream &ostr, Expression *expr)
{
    if (expr->_register != nullptr)
        return ostr << expr->_register;

    return ostr << expr->_operand;
}

void assign(Expression *expr, Register *reg) {
    if (expr != nullptr) {
        if (expr->_register != nullptr)
            expr->_register->_node = nullptr;
        expr->_register = reg;
    }
    if (reg != nullptr) {
        if (reg->_node != nullptr)
            reg->_node->_register = nullptr;
        reg->_node = expr;
    }
}

/*
 * Function:	suffix (private)
 *
 * Description:	Return the suffix for an opcode based on the given size.
 */

static string suffix(unsigned size)
{
    return size == 1 ? "b\t" : (size == 4 ? "l\t" : "q\t");
}

void assigntemp(Expression *expr) {
    stringstream ss;
    tempoffset = tempoffset - expr->type().size();
    ss << tempoffset << "(%rbp)";
    expr->_operand = ss.str();
}

void load(Expression *expr, Register *reg) {
    if (reg->_node != expr) {
        if(reg->_node != nullptr) {
            unsigned size = reg->_node->type().size();
            assigntemp(reg->_node);
            cout << "\tmov" << suffix(size) << reg->name(size) << ", " << reg->_node->_operand << endl;
        }
        if (expr != nullptr) {
            unsigned size = expr->type().size();
            cout << "\tmov" << suffix(size) << expr << ", ";
            cout << reg->name(size) << endl;
        }
        assign(expr, reg);
    }
}

Register *getreg() {
    for (unsigned i = 0; i < registers.size(); i ++) {
        if(registers[i]->name(4) == "%eax" || registers[i]->name(4) == "%edx")
            continue;
        if (registers[i]->_node == nullptr)
            return registers[i];
    }
    abort();
}

void release() {
    for(auto &reg: registers) {
        assign(nullptr, reg);
    }
}


/*
 * Function:	align (private)
 *
 * Description:	Return the number of bytes necessary to align the given
 *		offset on the stack.
 */

static int align(int offset)
{
    if (offset % STACK_ALIGNMENT == 0)
	return 0;

    return STACK_ALIGNMENT - (abs(offset) % STACK_ALIGNMENT);
}




/*
 * Function:	Number::generate
 *
 * Description:	Generate code for a number.  Since there is really no code
 *		to generate, we simply update our operand.
 */

void Number::generate()
{
    stringstream ss;


    ss << "$" << _value;
    _operand = ss.str();
}


/*
 * Function:	Identifier::generate
 *
 * Description:	Generate code for an identifier.  Since there is really no
 *		code to generate, we simply update our operand.
 */

void Identifier::generate()
{
    stringstream ss;


    if (_symbol->_offset == 0)
	ss << global_prefix << _symbol->name() << global_suffix;
    else
	ss << _symbol->_offset << "(%rbp)";

    _operand = ss.str();
}


void String::generate() {
    StringLabel label(_value);
    _operand = label.number();
    string_labels.push_back(label);
}


/*
 * Function:	Call::generate
 *
 * Description:	Generate code for a function call.  Arguments are first
 *		evaluated in case any them are in fact other function
 *		calls.  The first six arguments are placed in registers and
 *		any remaining arguments are pushed on the stack from right
 *		to left.  Each argument on the stack always requires eight
 *		bytes, so the stack will always be aligned on a multiple of
 *		eight bytes.  To ensure 16-byte alignment, we adjust the
 *		stack pointer if necessary.
 *
 *		NOT FINISHED: Ignores any return value.
 */

void Call::generate()
{
    unsigned size, bytesPushed = 0;


    /* Generate code for all the arguments first. */

    for (unsigned i = 0; i < _args.size(); i ++)
	_args[i]->generate();


    /* Adjust the stack if necessary. */

    if (_args.size() > NUM_ARGS_IN_REGS) {
	bytesPushed = align((_args.size() - NUM_ARGS_IN_REGS) * SIZEOF_ARG);

	if (bytesPushed > 0)
	    cout << "\tsubq\t$" << bytesPushed << ", %rsp" << endl;
    }


    /* Move the arguments into the correct registers or memory locations. */

    for (int i = _args.size() - 1; i >= 0; i --) {
	size = _args[i]->type().size();

	if (i < NUM_ARGS_IN_REGS) {
	    cout << "\tmov" << suffix(size) << _args[i] << ", ";
	    cout << parameters[i]->name(size) << endl;
	} else {
	    bytesPushed += SIZEOF_ARG;

	    if (isRegister(_args[i]))
		cout << "\tpushq\t" << _args[i]->_register->name() << endl;
	    else if (isNumber(_args[i]) || size == SIZEOF_ARG)
		cout << "\tpushq\t" << _args[i] << endl;
	    else {
		cout << "\tmov" << suffix(size) << _args[i] << ", ";
		cout << rax->name(size) << endl;
		cout << "\tpushq\t%rax" << endl;
	    }
	}
    }


    /* Call the function.  Technically, we only need to assign the number
       of floating point arguments to %eax if the function being called
       takes a variable number of arguments.  But, it never hurts. */

    if (_id->type().parameters() == nullptr)
	cout << "\tmovl\t$0, %eax" << endl;

    cout << "\tcall\t" << global_prefix << _id->name() << endl;


    /* Reclaim the space of any arguments pushed on the stack. */

    if (bytesPushed > 0)
	cout << "\taddq\t$" << bytesPushed << ", %rsp" << endl;

    assign(this, rax);
}


/*
 * Function:	Assignment::generate
 *
 * Description:	Generate code for an assignment statement.
 *
 *		NOT FINISHED: Only works if the right-hand side is an
 *		integer literal and the left-hand size is an integer
 *		scalar.
 */

void Assignment::generate()
{
    _left->generate();
    _right->generate();

    if(auto child = _left->isDereference()) {
        if(_right->_register == nullptr)
            load(_right, getreg());
        if(child->_register == nullptr)
            load(child, getreg());
        cout << "\tmov" << suffix(_left->type().size()) << _right << ", (" << child << ")" << endl;
    }
    else {
        if(_left->_register == nullptr && _right->_register == nullptr)
            load(_right, getreg());
        cout << "\tmov" << suffix(_left->type().size()) << _right << ", " << _left << endl;
    }
}


/*
 * Function:	Block::generate
 *
 * Description:	Generate code for this block, which simply means we
 *		generate code for each statement within the block.
 */

void Block::generate()
{
    for (unsigned i = 0; i < _stmts.size(); i ++) {
    	_stmts[i]->generate();
        release();
    }
}


/*
 * Function:	Function::generate
 *
 * Description:	Generate code for this function, which entails allocating
 *		space for local variables, then emitting our prologue, the
 *		body of the function, and the epilogue.
 */

void Function::generate()
{
    int offset = 0;
    unsigned numSpilled = _id->type().parameters()->size();
    const Symbols &symbols = _body->declarations()->symbols();

    // Set the return label
    return_label = Label(".function_");


    /* Assign offsets to all symbols within the scope of the function. */

    allocate(offset);

    /* Generate the prologue, body, and epilogue. */

    cout << global_prefix << _id->name() << ":" << endl;
    cout << "\tpushq\t%rbp" << endl;
    cout << "\tmovq\t%rsp, %rbp" << endl;

    if (SIMPLE_PROLOGUE) {
    	offset -= align(offset);
    	cout << "\tsubq\t$" << -offset << ", %rsp" << endl << endl;
    } else {
    	cout << "\tmovl\t$" << _id->name() << ".size, %eax" << endl;
    	cout << "\tsubq\t%rax, %rsp" << endl << endl;
    }

    if (numSpilled > NUM_ARGS_IN_REGS)
	numSpilled = NUM_ARGS_IN_REGS;

    for (unsigned i = 0; i < numSpilled; i ++) {
	unsigned size = symbols[i]->type().size();
	cout << "\tmov" << suffix(size) << parameters[i]->name(size);
	cout << ", " << symbols[i]->_offset << "(%rbp)" << endl;
    }

    tempoffset = offset;

    _body->generate();

    offset = tempoffset;

    // Epilogue
    cout << "\n" << return_label << ":" << endl;
    cout << "\tmovq\t%rbp, %rsp" << endl;
    cout << "\tpopq\t%rbp" << endl;
    cout << "\tret" << endl << endl;


    /* Finish aligning the stack. */

    if (!SIMPLE_PROLOGUE) {
	offset -= align(offset);
	cout << "\t.set\t" << _id->name() << ".size, " << -offset << endl;
    }

    cout << "\t.globl\t" << global_prefix << _id->name() << endl << endl;
}

void Add::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# add" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tadd" << suffix(_left->type().size()) << _right << ", " << _left << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void Subtract::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# subtract" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tsub" << suffix(_left->type().size()) << _right << ", " << _left << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void Multiply::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# multiply" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\timul" << suffix(_left->type().size()) << _right << ", " << _left << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void Divide::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# divide" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());
    load(_right, getreg());

    unsigned left_size = _left->type().size();
    cout << "\tmov" << suffix(left_size) << _left << ", " << rax->name(left_size) << endl;
    cout << "\tmov" << suffix(left_size) << rax->name(left_size) << ", " << rdx->name(left_size) << endl;
    cout << "\tsar" << suffix(left_size) << "$31, " << rdx->name(left_size) << endl;
    cout << "\tidiv" << suffix(_right->type().size()) << _right << endl;
    cout << "\tmov" << suffix(_right->type().size()) << rax->name(_right->type().size()) << ", " << _left << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void Remainder::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# remainder" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());
    load(_right, getreg());

    unsigned left_size = _left->type().size();
    cout << "\tmov" << suffix(left_size) << _left << ", " << rax->name(left_size) << endl;
    cout << "\tmov" << suffix(left_size) << rax->name(left_size) << ", " << rdx->name(left_size) << endl;
    cout << "\tsar" << suffix(left_size) << "$31, " << rdx->name(left_size) << endl;
    cout << "\tidiv" << suffix(_right->type().size()) << _right << endl;
    cout << "\tmov" << suffix(_right->type().size()) << rdx->name(_right->type().size()) << ", " << _left << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void LessThan::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# less than" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tcmp" << suffix(_left->type().size()) << _right << ", " << _left << endl;
    cout << "\tsetl\t" << _left->_register->name(1) << endl;
    cout << "\tmovzbl\t" << _left->_register->name(1) << ", " << _left->_register->name(4) << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void GreaterThan::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# greater than" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tcmp" << suffix(_left->type().size()) << _right << ", " << _left << endl;
    cout << "\tsetg\t" << _left->_register->name(1) << endl;
    cout << "\tmovzbl\t" << _left->_register->name(1) << ", " << _left->_register->name(4) << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void LessOrEqual::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# less than or equal" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tcmp" << suffix(_left->type().size()) << _right << ", " << _left << endl;
    cout << "\tsetle\t" << _left->_register->name(1) << endl;
    cout << "\tmovzbl\t" << _left->_register->name(1) << ", " << _left->_register->name(4) << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void GreaterOrEqual::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# greater than or equal" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tcmp" << suffix(_left->type().size()) << _right << ", " << _left << endl;
    cout << "\tsetge\t" << _left->_register->name(1) << endl;
    cout << "\tmovzbl\t" << _left->_register->name(1) << ", " << _left->_register->name(4) << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void Equal::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# equal" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tcmp" << suffix(_left->type().size()) << _right << ", " << _left << endl;
    cout << "\tsete\t" << _left->_register->name(1) << endl;
    cout << "\tmovzbl\t" << _left->_register->name(1) << ", " << _left->_register->name(4) << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void NotEqual::generate() {
    _left->generate();
    _right->generate();

    cout << "\t# not equal" << endl;
    if(_left->_register == nullptr)
        load(_left, getreg());

    cout << "\tcmp" << suffix(_left->type().size()) << _right << ", " << _left << endl;
    cout << "\tsetne\t" << _left->_register->name(1) << endl;
    cout << "\tmovzbl\t" << _left->_register->name(1) << ", " << _left->_register->name(4) << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void Not::generate() {
    _expr->generate();

    cout << "\t# not" << endl;
    if(_expr->_register == nullptr)
        load(_expr, getreg());

    cout << "\tcmp" << suffix(_expr->type().size()) << "$0, " << _expr << endl;
    cout << "\tsete\t" << _expr->_register->name(1) << endl;
    cout << "\tmovzbl\t" << _expr->_register->name(1) << ", " << _expr->_register->name(4) << endl;
    assign(this, _expr->_register);
}

void Negate::generate() {
    _expr->generate();

    cout << "\t# negate" << endl;
    if(_expr->_register == nullptr)
        load(_expr, getreg());

    cout << "\tneg" << suffix(_expr->type().size()) << _expr << endl;

    assign(this, _expr->_register);
}

void Cast::generate() {
    _expr->generate();

    if(_type.size() > _expr->type().size()) {

        cout << "\t# cast" << endl;
        if(_expr->_register == nullptr)
            load(_expr, getreg());

        cout << "\tmovs" <<
            (_expr->type().size() == 1 ? 'b' : _expr->type().size() == 4 ? 'l' : 'q') <<
            (_type.size() == 1 ? 'b' : _type.size() == 4 ? 'l' : 'q') <<
            "\t" << _expr << ", " << _expr->_register->name(_type.size()) << endl;
    }

    load(_expr, getreg());
    assign(this, _expr->_register);
}

void Address::generate() {

    if(auto child = _expr->isDereference()) {
        child->generate();
        load(child, getreg());
        assign(this, child->_register);
    }
    else {
        _expr->generate();

        cout << "\t# address" << endl;

        assign(this, getreg());
        cout << "\tlea" << suffix(_type.size()) << _expr << ", " << this << endl;

    }

}

void Dereference::generate() {
    _expr->generate();

    cout << "\t# dereference" << endl;
    load(_expr, getreg());

    assign(this, getreg());
    cout << "\tmov" << suffix(_type.size()) << "(" << _expr << "), " << this << endl;

}

void LogicalOr::generate() {

    cout << "\t# begin logical or" << endl;
    _left->generate();
    load(_left, getreg());

    Label l1, l2;

    cout << "\tcmp" << suffix(_left->type().size()) << "$0, " << _left << endl;
    cout << "\tjne\t" << l1 << endl;
    _right->generate();
    cout << "\tcmp" << suffix(_left->type().size()) << "$0, " << _right << endl;
    cout << "\tjne\t" << l1 << endl;
    cout << "\tmov" << suffix(_left->type().size()) << "$0, " << _left << endl;
    cout << "\tjmp\t" << l2 << endl;
    cout << l1 << ":" << endl;
    cout << "\tmov" << suffix(_left->type().size()) << "$1, " << _left << endl;
    cout << l2 << ":" << endl;

    cout << "\t# end logical or" << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void LogicalAnd::generate() {

    cout << "\t# begin logical and" << endl;
    _left->generate();
    load(_left, getreg());

    Label l1, l2;

    cout << "\tcmp" << suffix(_left->type().size()) << "$0, " << _left << endl;
    cout << "\tje\t" << l1 << endl;
    _right->generate();
    cout << "\tcmp" << suffix(_left->type().size()) << "$0, " << _right << endl;
    cout << "\tje\t" << l1 << endl;
    cout << "\tmov" << suffix(_left->type().size()) << "$1, " << _left << endl;
    cout << "\tjmp\t" << l2 << endl;
    cout << l1 << ":" << endl;
    cout << "\tmov" << suffix(_left->type().size()) << "$0, " << _left << endl;
    cout << l2 << ":" << endl;

    cout << "\t# end logical and" << endl;

    assign(_right, nullptr);
    assign(this, _left->_register);
}

void While::generate() {
    Label loop(".loop"), _exit(".exit");

    cout << "\t# begin while" << endl;
    cout << loop << ":" << endl;
    _expr->generate();
    cout << "\tcmp" << suffix(_expr->type().size()) << "$0, " << _expr << endl;
    cout << "\tje\t\t" << _exit << endl;
    _stmt->generate();
    cout << "\tjmp\t" << loop << endl;
    cout << _exit << ":" << endl;
    cout << "\t# end while" << endl;
}

void If::generate() {
    Label skip(".skip"), _exit(".exit");

    cout << "\t# begin if" << endl;
    _expr->generate();
    cout << "\tcmp" << suffix(_expr->type().size()) << "$0, " << _expr << endl;
    cout << "\tje\t\t" << skip << endl;
    _thenStmt->generate();
    if(_elseStmt)
        cout << "\tjmp\t" << _exit << endl;
    cout << skip << ":" << endl;
    if(_elseStmt) {
        _elseStmt->generate();
        cout << _exit << ":" << endl;
    }
    cout << "\t# end if" << endl;
}

void Return::generate() {
    _expr->generate();

    load(_expr, rax);
    cout << "\tjmp\t" << return_label << endl;
}

/*
 * Function:	generateGlobals
 *
 * Description:	Generate code for any global variable declarations.
 */

void generateGlobals(Scope *scope)
{
    const Symbols &symbols = scope->symbols();

    for (unsigned i = 0; i < symbols.size(); i ++)
    	if (!symbols[i]->type().isFunction()) {
    	    cout << "\t.comm\t" << global_prefix << symbols[i]->name() << ", ";
    	    cout << symbols[i]->type().size() << endl;
    	}

    for(auto &sl: string_labels) {
        cout << "\t" << sl.number() << ": .asciz\t" << sl.str() << endl;
    }
}
