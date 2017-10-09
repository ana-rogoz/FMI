#include<cstdio>
using namespace std;

struct Nod {

    int val;
    Nod *left, *right;

} *radacina;

void inserare_nod(Nod *radacina, int val)

int main()
{

    freopen("date.in", "r", stdin);

    int n, x;
    scanf("%d", &n);

    for(int i = 1; i <= n; i++)
    {
        scanf("%d", &x);
        inserare_nod(radacina, x);
    }

    return 0;

}
