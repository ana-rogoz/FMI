//Se citesc de la tastatură m ṣi n naturale nenule reprezentând dimensiunile unei matrice ṣi elementele matricei. Să se construiască ṣi să se afiṣeze matricea transpusă.

#include<stdio.h>
#define NMAX 100
int a[NMAX + 2][NMAX + 2], a_transpus[NMAX + 2][NMAX + 2];
int main()
{

    int n, m;
    scanf("%d%d", &m, &n);
    for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++)
            scanf("%d", &a[i][j]);
    for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++)
            a_transpus[j][i] = a[i][j];

    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= m; j++)
            printf("%d ", a_transpus[i][j]);
        printf("\n");
        }

    return 0;
}
