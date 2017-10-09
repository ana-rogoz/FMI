#include<cstdio>
using namespace std;
struct Nod {
    int val;
    Nod *urmator;
};

void add(Nod *&prim, Nod *&ultim, int x) {
    Nod *p;
    p = new Nod;
    p -> val = x;
    p -> urmator = NULL;
    if(prim == NULL) {
        prim = p;
        ultim = prim;
    }
    else
    {
        ultim -> urmator = p;
        ultim = p;
    }
}
void add_sfarsit(Nod *&primB, Nod *&ultimB, int x) {
    Nod *p;
    p = new Nod;
    p -> val = x;
    p -> urmator = NULL;
    if(primB == NULL) {
        primB = p;
        ultimB = primB;
    }
    else
    {
        p -> urmator = primB;
        primB = p;
    }
}

void reverse_function(Nod *&prim)
{
    Nod *a, *b, *c;
    a = prim;
    b = NULL;
    while(a != NULL)
    {
        c = b;
        b = a;
        a = a -> urmator;
        b -> urmator = c;
    }
    prim = b;
}
int main()
{
    freopen("date.in", "r", stdin);
    int x;
    Nod *prim = NULL, *ultim, *primB = NULL, *ultimB;
    while(scanf("%d", &x) != EOF) {
        add(prim, ultim, x);
    }

    Nod *i;
    for(i = prim; i != NULL; i = i -> urmator)
        add_sfarsit(primB, ultimB, i->val);

    for(i = primB; i != NULL; i = i -> urmator)
        printf("%d ", i -> val);
    printf("\n");

    reverse_function(prim);
    for(i = prim; i != NULL; i = i -> urmator)
        printf("%d ", i->val);
    printf("\n");
    return 0;
}
