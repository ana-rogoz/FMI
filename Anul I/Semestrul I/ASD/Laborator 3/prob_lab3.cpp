#include<cstdio>
using namespace std;
struct Nod {
    int val;
    Nod *next;
};
void add(Nod *&prim, Nod *&ultim, int x)
{
    Nod *p;
    p = new Nod;
    p -> val = x;
    p -> next = NULL;
    if(prim == NULL)
    {
        prim = p;
        ultim = p;
    }
    else
    if(p -> val < prim -> val)
    {
        p -> next = prim;
        prim = p;
    }
    else
    {
        Nod *k, *anterior = NULL;
        for(k = prim; k != NULL; k = k->next)
        {
            if(k -> val <= p -> val)
            {
                anterior = k;
                continue;
            }
            else
                break;
        }
        if(k == NULL)
        {
            ultim -> next = p;
            ultim = p;
        }
        else
        {
            p -> next = k;
            anterior -> next = p;
        }
    }
}

int main()
{
    freopen("date.in", "r", stdin);
    Nod *prim = NULL, *ultim;
    int n, val_curenta;
    scanf("%d", &n);
    for(int i = 1; i <= n; i++)
    {
        scanf("%d", &val_curenta);
        add(prim, ultim, val_curenta);
    }
    Nod *k;
    for(k = prim; k!=NULL; k = k -> next)
        printf("%d ", k->val);
    return 0;
}
