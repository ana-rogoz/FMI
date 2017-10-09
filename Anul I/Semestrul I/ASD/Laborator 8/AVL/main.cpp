#include<cstdio>
#include<algorithm>
using namespace std;

struct nod {
    pair <int, int> valoare;
    int inaltime;
    nod *stanga;
    nod *dreapta;

    nod (pair <int, int> x) {
        this->valoare = x;
        stanga = dreapta = NULL;
        inaltime = 1;
    }
};

const int NMAX = 10000 + 1;

int n;
int v[NMAX];

int inaltime(nod *p) {
    if (p == NULL) return 0;
    return p->inaltime;
}

int factor(nod *p) {
    return inaltime(p->dreapta) - inaltime(p->stanga);
}

void calculeaza_inaltime(nod *p) {

    if (p == NULL)
        return;
    p->inaltime = 1 + max(inaltime(p->stanga), inaltime(p->dreapta));
}

nod* roteste_dreapta(nod* p) {

    nod* q = p->stanga;
    p->stanga = q->dreapta;
    q->dreapta = p;
    calculeaza_inaltime(p);
    calculeaza_inaltime(q);
    return q;
}

nod* roteste_stanga(nod* q) {

    nod *p = q->dreapta;
    q->dreapta = p->stanga;
    p->stanga = q;
    calculeaza_inaltime(q);
    calculeaza_inaltime(p);
    return p;
}

nod *balanseaza(nod *p) {
    calculeaza_inaltime(p);

    if (factor(p) == 2) {
        if (factor(p->dreapta) < 0)
            p->dreapta = roteste_dreapta(p->dreapta);
        return roteste_stanga(p);
    }
    if (factor(p) == -2) {
        if (factor(p->stanga) > 0)
            p->stanga = roteste_stanga(p->stanga);
        return roteste_dreapta(p);
    }

    return p;
}

nod* insereaza(nod* p, pair <int, int> x) {

    if (p == NULL) return new nod (x);

    if (x < p->valoare)
        p->stanga  = insereaza(p->stanga, x);
    else
        p->dreapta = insereaza(p->dreapta, x);

    return balanseaza(p);
}

nod* cauta_maxim(nod *p) {

    if (p->dreapta == NULL)
            return p;
    return cauta_maxim(p->dreapta);
}

nod *sterge_maxim(nod *&p) {

    if (p->dreapta == 0)
        return p->stanga;
    p->dreapta = sterge_maxim(p->dreapta);

    return balanseaza(p);
}

nod *sterge(nod *&p, pair <int, int> x) {

    if (p == NULL)
        return 0;
    if (x < p->valoare)
        p->stanga = sterge(p->stanga, x);
    else
    if (x > p->valoare)
        p->dreapta = sterge(p->dreapta, x);
    else {

        nod *q = p->stanga;
        nod *r = p->dreapta;
        delete p;
        if (r == NULL) return q;
        nod* maxim = cauta_maxim(r);
        maxim->dreapta = sterge_maxim(r);
        maxim->stanga = maxim;
        return balanseaza(maxim);
    }

    return balanseaza(p);
}

nod *afisare(nod *&p) {

    printf("%d", p->valoare);
    if(p->dreapta == NULL)
        return p;
    else
        afisare(p->dreapta);
}

nod *avl;

void rezolva() {

    pair <int, int> p;
    scanf("%d", &n);

    for (int i = 1; i <= n; i++) {
        scanf("%d", &v[i]);
        p.first = v[i];
        p.second = i;
        avl = insereaza(avl, p);
    }

}

int main() {

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    rezolva();

    return 0;
}
