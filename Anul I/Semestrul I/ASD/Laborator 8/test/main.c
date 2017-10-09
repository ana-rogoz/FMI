#include <stdio.h>
#include <stdlib.h>


void citire(int *n, int **v) {

    int suma = 0;
    scanf("%d", &(*n));
    *v = (int *)malloc((*n) * sizeof(int*));
    for(int i = 0; i < (*n); i++)
        scanf("%d", &(*v)[i]), suma += (*v)[i];

    printf("%d", suma);

}


int minim(int n, int *v) {

    int vmin = 1999;
    for(int i = 0; i < n; i++)
        if(v[i] < vmin)
            vmin = v[i];

}

int main()
{

    freopen("date.in", "r", stdin);

    int n, *v;

    citire(&n, &v);

    minim(n, v);

    free(v);
    return 0;
    }
