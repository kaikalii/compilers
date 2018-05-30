int putchar();
int newline;
int space;
int foo(int a, int b, int c, int d, int e, int f, int g, int h, int i) {
    putchar(a);
    putchar(b);
    putchar(c);
    putchar(d);
    putchar(e);
    putchar(f);
    putchar(g);
    putchar(h);
    putchar(i);
}

int main(void) {
    int a, b, n;
    a = 65;
    b = 66;
    n = 78;
    space = 32;
    newline = 10;
    foo(a, space, b, 65, n, a, n, a, newline);
}
