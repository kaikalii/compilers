/* fib.c */

int printf(), scanf();

/*
 * return the nth fibonacci number
 */

int fib(int n)
{
    int result;
    result = 0;
    printf("%d\n", n);
    if (n == 0 || n == 1) result = 1;
    else result = fib(n - 1) + fib(n - 2);
    printf("-%d\n", result);
    return result;
}


int main (void)
{
    int n;

    scanf("%d", &n);
    printf("%d\n", fib(n));
}
