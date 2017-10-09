/*
Sa se creeze o matrice patratica, in spirala, dupa regulile:
- numerele pornesc de la 1, din 1 in 1, in ordine crescatoare;
- dupa fiecare numar neprim x se adauga cel mai mic divizor propriu al sau, dupa care se continua cu x+1.
*/
#include<stdio.h>
#include<math.h>
int matrice[102][102];
int prim(int k)
{
    if(k % 2 == 0 && k != 2)
        return 0;
    int lim = sqrt(k);
    for(int i = 3; i <= lim; i++)
        if(k % i == 0)
            return 0;
    return 1;
}
int val_curenta, divizor, n;

void solve(int linie, int coloana)
{
    int d;

    if(divizor != 0)
    {
        matrice[linie][coloana] = divizor;
        divizor = 0;
    }
    else
    if(prim(val_curenta) == 0) {
        matrice[linie][coloana] = val_curenta;

        for(d = 2; d <= n; d ++)
            if(val_curenta % d == 0)
            {
                divizor = d;
                break;
            }
          val_curenta ++;
    }
    else
    {
        matrice[linie][coloana] = val_curenta;
        val_curenta ++;
    }
}

int main()
{
    int nr_patrate;
    scanf("%d", &n);
    nr_patrate = (n + 1) / 2;

    int i, j, k;
    val_curenta = 1;

    for(k = 1; k <= nr_patrate; k ++)
    {
        for(j = k; j <= n - k + 1; j ++)
            solve(k, j);

        for(i = k + 1; i <= n - k + 1; i ++)
            solve(i, n - k + 1);

        for(j = n - k; j >= k; j --)
            solve(n -k + 1, j);

        for(i = n - k; i > k; i --)
            solve(i,k);
    }

    for(i = 1; i <= n; i++) {
        for(j = 1; j <= n; j++)
            printf("%d ", matrice[i][j]);
        printf("\n");
    }
    return 0;
}
