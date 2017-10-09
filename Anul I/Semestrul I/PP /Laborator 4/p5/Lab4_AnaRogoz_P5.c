//Să se parcurgă o matrice în spirală.
#include<stdio.h>
int a[102][102];
int main()
{
    int n, i, j;
    scanf("%d", &n);

    for(i = 1; i <= n; i ++)
        for(j = 1; j <= n; j ++)
            scanf("%d", &a[i][j]);

    int nr_patrate = (n + 1) / 2;
    for(int k = 1; k <= nr_patrate; k ++)
    {
        for(j = k; j <= n - k + 1; j ++)
            printf("%d ", a[k][j]);

        for(i = k + 1; i <= n - k + 1; i ++)
            printf("%d ", a[i][n - k + 1]);

        for(j = n - k; j >= k; j --)
            printf("%d ", a[n - k + 1][j]);

        for(i = n - k; i > k; i --)
            printf("%d ", a[i][k]);
    }

    printf("\n");
    return 0;
}
