#include<stdio.h>
#include<string.h>
#define medie_admitere(mate, info, bac, medie)  medie =  (mate + info) / 2 * 0.8 + bac * 0.2

struct elevi
{
    int nr_legitimatie;
    char nume[25];
    double nota_mate, nota_info, nota_bac, medie;
    _Bool admis, buget;
} st[300], curent, aux;

const nota_minima = 5;
int n, i, nr_admisi, operatie;

void citire()
{
    int j;
    scanf("%d %s %lf %lf %lf", &curent.nr_legitimatie, &curent.nume, &curent.nota_mate, &curent.nota_info, &curent.nota_bac);

    medie_admitere(curent.nota_mate, curent.nota_info, curent.nota_bac, curent.medie);

    if(curent.medie < 5)
        curent.admis = 0;
    else
        curent.admis = 1, nr_admisi++;

    for(j = 1; j < i; j ++)
        if(strcmp(st[j].nume, curent.nume) > 0)
        {
            for(int k = i-1; k >=j; k--)
                st[k+1] = st[k];

            st[j] = curent;
            break;

        }
    if(j == i)
        st[i] = curent;
}

void buget()
{
    int nr_buget = (double)(0.75 * nr_admisi);
    int ok;
    do
    {
        ok = 1;
        for(int i = 1; i < n; i++)
            if(st[i].medie < st[i + 1].medie)
            {
                aux = st[i];
                st[i] = st[i+1];
                st[i+1] = aux;
                ok = 0;
            }

    }while(ok == 0);

    for(int i = 1; i <= nr_buget; i++)
        st[i].buget = 1;

}

void rezolvare()
{
    switch(operatie)
    {
        case 1:
        {
            for(int i = 1; i <= n; i++)
                printf("%s\n", st[i].nume);
            break;

        }

        case 2:
        {
            buget();
            for(int i = 1; i <= n; i++)
                if(st[i].buget == 1)
                    printf("%s\n", st[i].nume);
            break;
        }

        case 3:
        {
            buget();
            for(int i = 1; i <= n; i++)
                if(st[i].buget == 0 && st[i].medie >= nota_minima)
                    printf("%s\n", st[i].nume);

            break;
        }
        case 4:
        {
            buget();
            for(int i = 1; i <= n; i++)
                if(st[i].buget == 0 && st[i].medie < nota_minima)
                    printf("%s\n", st[i].nume);

            break;
        }
        default:
            break;
    }

}

int main()
{
    freopen("date.in", "r", stdin);

    scanf("%d", &n);

    for(i = 1; i <= n; i++)
        citire();
    scanf("%d", &operatie);

    rezolvare();


    return 0;
}
