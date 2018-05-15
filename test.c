#include <stdio.h>

int main(int argc, char** argv) {
    if(argc) main(argc - 1, argv);
    printf("%d\n", argc);
    return 0;
}
