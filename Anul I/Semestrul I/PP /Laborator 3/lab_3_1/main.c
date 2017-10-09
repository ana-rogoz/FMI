#include<stdio.h>
#include "fisier.h"
#define switch_l2(a) { \
    if(a >= 'a' && a <= 'z')\
        a = a - 32; \
    else\
        a = a + 32;\
}

char switch_litera(char a);
int eval(int a, char op, int b);

int main()
{
    freopen("date.in", "r", stdin);

    char ch, rez;
    scanf("%c", &ch);
    switch_l2(ch);
    printf("%c\n", ch);

    /*int nr1, nr2;
    char op;
    scanf("%d %c %d", &nr1, &op, &nr2);

    int rez = eval(nr1, op, nr2);
    if(rez == -1)
        printf("Numitorul este 0");
    else
        printf("%d\n", rez);*/
    return 0;
}
