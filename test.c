int x[10], *y, z, f();

int main(void) {
    int i;
    i = 0;
    while(i < 10) {
        f(i);
        q(p(i));
        i = i + 1;
    }
    i + *y = z - -!f(x);
}

char a, b, c;
long p(), q(), r[100];

int f(int x) {
    return *((int*)(((char *)&x)[1] + sizeof((long)x)));
}

int p(int x) {
    return 45 - 2 * x / (x + 1)%13;
}

int q(int x) {
    return x > 0 && x <= 5 || !q(-f(x)) && x == f(x);
}
