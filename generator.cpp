#include <iostream>
#include "tree.h"
#include "generator.h"

using namespace std;

void Function::generate() {
    // Generate the prologue
    cout <<
        "; function prologue\n"
        "pushq %%rbp\n"
        "movq %%rsp, %%rbp\n"
        "subq $n, %%rsp\n"
    << endl;

    // Generate the epilogue
    cout <<
        "; function epilogue\n"
        "movq %%rbp, %%rsp\n"
        "popq %%rbp\n"
        "ret\n"
    << endl;
}
