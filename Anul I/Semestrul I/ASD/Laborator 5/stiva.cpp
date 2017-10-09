#include<cstdio>
struct Nod {
    int info;
    Nod *next;
};

void push(int val, Nod *&varf) {

    Nod *p = new Nod;
    p->info = val;
    p->next = NULL;
    if(varf == NULL)
        varf = p;
    else {
        p->next = varf;
        varf = p;
    }
}

void pop(Nod *&varf) {

    Nod *temp = varf;
    varf = varf->next;
    delete temp;
}

bool isEmpty(Nod *&varf) {

    if(varf == NULL)
        return true;
    return false;
}

int peek(Nod *&varf) {
    return varf->info;
}

void afisare(Nod *&varf) {

    while(isEmpty(varf) == false) {
        printf("%d ", varf->info);
        pop(varf);
    }
    printf("\n");
}

int main() {
    freopen("date.in", "r", stdin);
    int n, val;
    Nod *varf = NULL;
    scanf("%d", &n);
    for(int i = 1; i <= n; i++) {
        scanf("%d", &val);
        push(val, varf);
    }

    for(int i = 1; i <= 3; i++)
        pop(varf);
    push(11, varf);
    int x = peek(varf);
    printf("%d\n", x);
    afisare(varf);

    return 0;
}
