#include<stdio.h>
int main() {

    int *p, a, b, x, *p2;
    a = 13;
    p = &a;
    printf("%d\n", a);
    printf("%x\n", &a);
    printf("%x\n", p);
    printf("%d\n", *p);

    return 0;
}
