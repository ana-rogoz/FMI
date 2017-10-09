#include<cstdio>
using namespace std;

struct Nod {

    int info;
    Nod *next, *prev;
}*primul, *ultimul;

void adauga_inceput(int x, Nod *&primul, Nod *&ultimul) {

    Nod *p;
    p = new Nod;
    p->next = p->prev = NULL;
    p->info = x;
    if(primul == NULL) {
        p->next = primul;
        primul = ultimul = p;
    }
    else {
        p->next = primul;
        primul->prev = p;
        primul = p;
    }

}

void adauga_sfarsit(int x, Nod *&primul, Nod *&ultimul) {

    Nod *p;
    p = new Nod;
    p->next = p->prev = NULL;
    p->info = x;
    if(ultimul == NULL) {
        p->next = ultimul;
        primul = ultimul = p;
    }
    else {
        ultimul->next = p;
        p->prev = ultimul;
        ultimul = p;
    }
}

void adaugare_k(int x, int poz, Nod *&primul, Nod *&ultimul) {

    Nod *p, *i;
    p = new Nod;
    p->next = p->prev = NULL;
    p->info = x;

    int k = 1;
    i = primul;
    while(k < poz - 1) {
        i=i->next;
        k++;
    }

    Nod *next;
    next = i->next;

    next->prev = p;
    p->next = next;
    i->next = p;
    p->prev = i;

}

void afisare(Nod *&primul) {

    Nod *i;
    for(i = primul; i != NULL; i = i->next)
        printf("%d ", i->info);

    printf("\n");
}

void afisare_inversa(Nod *&ultimul) {

    Nod *i;
    for(i = ultimul; i != NULL; i = i->prev)
        printf("%d ", i->info);

    printf("\n");
}

void stergere_poz(int poz, Nod *&primul, Nod *&ultimul) {

    Nod *i;

    int k = 1;
    i = primul;
    while(k < poz) {
        i=i->next;
        k++;
    }

    Nod *next, *prev;
    next = i->next;
    prev = i->prev;
    prev->next= next;
    next->prev = prev;
}

void stergere_val(int x, Nod *&primul, Nod *&ultimul) {

    Nod *k;
    k = primul;
    while(k->info != x) {
        k = k->next;
    }

    Nod *next, *prev;
    next = k->next;
    prev = k->prev;
    prev->next= next;
    next->prev = prev;
}

int main() {

    freopen("date.in", "r", stdin);

    int n, x;
    scanf("%d", &n);

    for(int i = 1; i <= n; i++) {
        scanf("%d", &x);
        adauga_sfarsit(x, primul, ultimul);
    }

    stergere_val(4, primul, ultimul);
    afisare(primul);
    afisare_inversa(ultimul);
    return 0;
}
