#include<stdio.h>
int main()
{
    int n, x;
    scanf("%d %d", &x, &n);

    //afiseaza bitul n din x
    printf("%d\n", (x>>n)&1);

    //se seteaza bitul n din x
    printf("%d\n", x|(1<<n));

    //se sterge bitul n din x
    printf("%d\n", x&(~(1<<n)));

    //se complementeaza bitul n
    printf("%d\n",x^(1<<n));

    return 0;
}
