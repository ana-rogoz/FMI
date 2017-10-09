/*Fie lista simplu inlantuita C. Sa se distribuie elementele din C in doua liste
simplu inlatuite A si B, astfel: A contine elementele de pe pozitiile impare din C, iar B
contine elementele din C de pe pozitiile pare.*/

#include<cstdio>
using namespace std;
struct Nod {
    int value;
    Nod *next;
};

void add(Nod *&primul, Nod *&ultimul, int x) {

    Nod *p;
    p = new Nod;
    p->value = x;
    p->next = NULL;
    if(primul == NULL) {
        primul = p;
        ultimul = p;
    }
    else {
        ultimul->next = p;
        ultimul = p;
    }

}
int main() {

    freopen("date.in", "r", stdin);
    int val;
    Nod *primulC = NULL, *ultimulC, *primulA = NULL, *ultimulA, *primulB = NULL, *ultimulB;
    while(scanf("%d", &val) != EOF) {
        add(primulC, ultimulC, val);
    }

    Nod *i;
    int poz = 1;
    for(i = primulC; i != NULL; i = i->next) {
        if(poz % 2 == 1)
            add(primulA, ultimulA, i->value);
        else
            add(primulB, ultimulB, i->value);
        poz ++;
    }

    for(i = primulA; i != NULL; i = i->next)
        printf("%d ", i->value);
    printf("\n");
    for(i = primulB; i != NULL; i = i->next)
        printf("%d ", i->value);
    printf("\n");
    return 0;
}
