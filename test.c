
char foo(int x, long *y) {
    return (char)x + *((char*)y);
}

long pow(long a, long b) {
    long result;
    result = 1;
    while(b) {
        result = result * a;
    }
    return result;
}

long strlen(char *s) {
    long len, curr;
    curr = 0;
    len = 0;
    while(s[curr] != *"\0") {
        len = len + 1;
        curr = curr + 1;
    }
    return len;
}

long stoi(char *s) {
    int curr;
    long result;
    int len;
    long power;

    result = 0;
    len = strlen(s) - 1;
    power = 0;

    while(len >= 0) {
        result = result + (s[len] - 48) * pow(10,power);
        len = len - 1;
        power = power + 1;
    }

    return result;
}

int main(void) {
    int a, *b, **c;
    long x, *y, **z;
    char p, *q, **r;

    q = b + 5; /* invalid operator to binary = */
    q = (char*)(b + 5);

    if(a) {
        if(b) {
            if(foo) { /* invalid type for test expression */
                a = *(*c + 5);
            }
        }
    }

    a = foo(a, y);
    a = foo(a, y + z); /* invalid operator to binary + */

    b = *c;
    *&b = *c;
    **&&b = *c; /* lvalue required in expression */
    1 = a; /* lvalue required in expression */
    *&b = *&b + 0 * (long)(c);


    return 0;
}
