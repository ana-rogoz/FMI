#include<cstdio>
using namespace std;

const int NMAX = 100;
int v[NMAX + 2];

void interclasare(int v[], int st, int med, int dr) {

    int i = st, j = med + 1;
    int v2[NMAX + 2];
    v2[0] = 0;
    while(i <= med && j<= dr) {

        if(v[i] < v[j]) {
            v2[++v2[0]] = v[i];
            i++;
        }
        else {
            v2[++v[0]] = v[j];
            j++;
        }
    }

    if(i <= med) {

        for(int k = i; k <= med; k++)
            v2[++v2[0]] = v[k];
    }
    else {

        for(int k = j; k <= dr; k++)
            v2[++v2[0]] = v[k];
    }

    v2[0] = 0;

    for(int i = st; i <= dr; i++)
        v[i] = v2[++v2[0]];

}

void Merge(int v[], int st, int dr) {

    if(st < dr) {

        int med = (st + dr) / 2;
        Merge(v, st, med);
        Merge(v, med + 1, dr);
        interclasare(v, st, med, dr);
    }
}

int main() {

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    int n;

    scanf("%d", &n);
    for(int i = 1; i <= n; i++)
        scanf("%d", &v[i]);

    Merge(v, 1, n);

    for(int i = 1; i <= n; i++)
        printf("%d", v[i]);

    printf("\n");
    return 0;
}
