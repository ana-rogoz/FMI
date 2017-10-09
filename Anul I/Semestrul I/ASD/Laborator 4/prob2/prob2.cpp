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
    Nod *primulA = NULL, *primulB = NULL, *ultimulA, *ultimulB, *primulC = NULL, *ultimulC;
    int n, m, val;
    scanf("%d%d", &n, &m);
    for(int i = 1; i <= n; i++) {
        scanf("%d", &val);
        add(primulA, ultimulA, val);
    }

    for(int i = 1; i <= m; i++) {
        scanf("%d", &val);
        add(primulB, ultimulB, val);
    }

    Nod *indiceA, *indiceB;
    indiceA = primulA;
    indiceB = primulB;

    while(indiceA != NULL && indiceB != NULL) {
        if(indiceA->value < indiceB->value) {
            add(primulC, ultimulC, indiceA->value);
            indiceA = indiceA->next;
        }
        else {
            add(primulC, ultimulC, indiceB->value);
            indiceB = indiceB->next;
        }
    }

    if(indiceA != NULL) {
        while(indiceA != NULL) {
            add(primulC, ultimulC, indiceA->value);
            indiceA = indiceA->next;
        }
    }
    else {
        while(indiceB != NULL) {
            add(primulC, ultimulC, indiceB->value);
            indiceB = indiceB->next;
        }
    }

    for(Nod *i = primulC; i != NULL; i = i->next)
        printf("%d ", i->value);
    printf("\n");

	return 0;
}
