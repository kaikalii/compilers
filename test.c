int printf();
int main(void) {
    int i, j;
    i = 0;
    while(i < 10) {
        j = 0;
        while(j < i) {
            printf("%d * %d = %d\n", i, j, i * j);
            j = j + 1;
        }
        i = i + 1;
    }
}
