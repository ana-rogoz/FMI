#include<stdio.h>
int nr_baza2[32];
char baza_16[16];
int main()
{
    freopen("date.in", "r", stdin);
    int size_nr = 0;
    char ch;
    //citesc
    while(1)
    {
        scanf("%c", &ch);
        if(ch != '0' && ch != '1')
            break;

        nr_baza2[size_nr] = ch - '0';
        size_nr ++;
    }


    for(int i = 0; i <= 9; i++)
        baza_16[i] = '0' + i;
    baza_16[10] = 'A', baza_16[11] = 'B', baza_16[12] = 'C', baza_16[13] = 'D', baza_16[14] = 'E', baza_16[15] = 'F';

    //adaug zerouri astfel incat sa pot grupa numarul in secvente de 4
    int nr_curent, rest;
    rest = size_nr % 4;
    rest = 4 - rest;
    for(int i = size_nr - 1; i >= 0; i--)
        nr_baza2[i + rest] = nr_baza2[i];
    for(int i = 0; i < rest; i++)
        nr_baza2[i] = 0;

    size_nr = (size_nr + rest)/ 4;

    // transform grupe de 4 biti in baza 16
    for(int i = 0; i < size_nr; i++)
    {
        nr_curent = nr_baza2[4 * i + 3] + nr_baza2[4 * i + 2] * 2 + nr_baza2[4 * i + 1] * 4 + nr_baza2[4 * i] * 8;
        printf("%c", baza_16[nr_curent]);

    }
    printf("\n");
    return 0;
}
