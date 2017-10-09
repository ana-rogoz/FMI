#include<stdio.h>

_Bool frecventa_A[4002], frecventa_B[4002];

int main()
{
    int n, m;
    int val;
    scanf("%d%d", &n, &m);
    for(int i = 1; i <= n; i++) {
        scanf("%d", &val);
        frecventa_A[val + 2000] = 1;
    }

    for(int i = 1; i <= m; i++) {
        scanf("%d", &val);
        frecventa_B[val + 2000] = 1;
    }

    int nr = 0;
    for(int i = 1; i <= 4000; i++)
        if(frecventa_A[i] == 1 && frecventa_B[i] == 1)
            nr ++;

    printf("%d\n", nr);

    return 0;
}
