#include<cstdio>
#include<math.h>
#include<string.h>
using namespace std;

const int NMAX = 1000;
double B1[NMAX + 2][NMAX + 2]; //Baza initiala
double B2[NMAX + 2][NMAX + 2]; //Baza ortonormata

double B_curent[NMAX + 2]; // Vectorul pe care-l calculez din baza ortonormata
double auxiliar[NMAX + 2];

//Calculez ||v||
double norma(double v[], int dimensiune) {


    double rez = 0;

    for(int i = 1; i <= dimensiune; i++)
        rez += v[i]*v[i];

    rez = sqrt(rez);
    return rez;
}

//Calculeaza <a, c>
double produs(double a[], double c[], int dimensiune) {

    double rez = 0;
    for(int i = 1; i <= dimensiune; i++)
        rez += a[i] * c[i];

    return rez;
}

int main() {

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    int n;
    double Norma, Produs;

    //Citesc dimensiunea bazei
    scanf("%d", &n);

    //Citesc vectorii bazei
    for(int i = 1; i <= n; i++)
        for(int j = 1; j <= n; j++)
            scanf("%lf", &B1[i][j]);

    for(int i = 1; i <= n; i++) {

        memset(B_curent, 0, sizeof(B_curent)); // bi

        for(int j = 1; j <= n; j++)  //B_curent = ai adica vectorul i din B1
            B_curent[j] = B1[i][j];

        for(int j = 1; j < i; j++)  {//Scad din bi toti vectorii <ai, cj>*cj, cu j < i

            //Calculez <aj, cj>*cj in auxiliar
            Produs = produs(B1[i], B2[j], n);

            for(int d = 1; d <= n; d++)
                auxiliar[d] = B2[j][d] * Produs;

            //Scad din bn vectorul auxiliar

            for(int d = 1; d <= n; d++)
                B_curent[d] = B_curent[d] - auxiliar[d];
        }

        //Impart bi la ||bi||

        Norma = norma(B_curent, n);
        for(int j = 1; j <= n; j++)
            B_curent[j] = B_curent[j] / Norma;

        //pun in B2 noul vector calculat
        for(int j = 1; j <= n; j++)
            B2[i][j] = B_curent[j];
    }

    //Baza ortonormata se gaseste in B2
    //Afisez B2
    for(int i = 1; i <= n; i++) {
        printf("c%d = (", i);
        for(int j = 1; j <= n; j++)
            printf("%.2lf ", B2[i][j]);

        printf(")\n");
    }

    return 0;
}
