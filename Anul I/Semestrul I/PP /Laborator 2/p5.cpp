#include<stdio.h>
int main()
{
    freopen("date.in", "r", stdin);
    int a, b, copie_a, suma_cif;
    scanf("%d", &a);
    while(1)
    {
        scanf("%d", &b);
        if(b == 0)
            break;
        copie_a = a;
        suma_cif = 0;
        do
        {
            suma_cif += copie_a % 10;
            copie_a /= 10;

        }while(copie_a);

        if(a % suma_cif == b)
            printf("%d %d\n", a, b);

        a = b;
    }
    return 0;

}
