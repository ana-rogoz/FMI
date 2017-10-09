#include<stdio.h>
int main()
{
    int x, y, n, p, poz_bit;
    scanf("%d%d%d%d", &x, &y, &p, &n);

    for(int i = 0; i < n; i++)
    {
        if((y>>i)&1)
            x = x|(1<<p);
        else
            x = x|(~(1<<p));
        p++;

    }

    printf("%d\n", x);
    return 0;
}
