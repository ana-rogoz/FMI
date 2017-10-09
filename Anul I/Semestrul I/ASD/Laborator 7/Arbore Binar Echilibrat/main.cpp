#include<cstdio>
using namespace std;
int v[20];
struct Nod
{

    int val;
    Nod *left, *right;
}*Radacina;

struct coada
{
    Nod *x;
    coada *next;
}*first, *last;

void parcurgereRSD(Nod *varf)
{

    printf("%d ", varf->val);
    if(varf->left != NULL)
        parcurgereRSD(varf->left);
    if(varf->right != NULL)
        parcurgereRSD(varf->right);
}

void parcurgereSRD(Nod *varf)
{

    if(varf->left != NULL)
        parcurgereSRD(varf->left);
    printf("%d ", varf->val);
    if(varf->right != NULL)
        parcurgereSRD(varf->right);
}

void parcurgereSDR(Nod *varf)
{

    if(varf->left != NULL)
        parcurgereSDR(varf->left);
    if(varf->right != NULL)
        parcurgereSDR(varf->right);
    printf("%d ", varf->val);
}

int main()
{

    freopen("date.in", "r", stdin);

    int n, x;
    scanf("%d", &n);

    for(int i = 0; i < n; i++)
        scanf("%d", &v[i]);

    Nod *curent_nod, *fiu;
    coada *curent_coada, *nou_coada;

    curent_nod = new Nod;
    curent_nod->val = v[0];
    curent_nod->left = curent_nod->right = NULL;

    Radacina = curent_nod;
    first = new coada;
    last = new coada;

    first->x = last->x = curent_nod;
    first->next = last->next = NULL;

    last = first;

    curent_coada = first;

    int poz = 1;
    while(curent_coada != NULL && poz < n)
    {

        curent_nod = curent_coada->x;

        if(curent_nod->left == NULL)
        {

            fiu = new Nod;
            fiu->val = v[poz];
            poz++;
            fiu->left = fiu->right = NULL;
            curent_nod->left = fiu;

            nou_coada = new coada;
            nou_coada->x = fiu;
            nou_coada->next = NULL;
            last->next = nou_coada;
            last = nou_coada;
        }
        else if(curent_nod->right == NULL)
        {
            fiu = new Nod;
            fiu->val = v[poz];
            poz++;
            fiu->left = fiu->right = NULL;
            curent_nod->right = fiu;

            nou_coada = new coada;
            nou_coada->x = fiu;
            nou_coada->next = NULL;
            last->next = nou_coada;
            last = nou_coada;

            curent_coada = curent_coada->next;
        }

    }

    parcurgereRSD(Radacina);
    printf("\n");

    parcurgereSRD(Radacina);
    printf("\n");

    parcurgereSDR(Radacina);

    return 0;

}


