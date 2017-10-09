#include<cstdio>
#include<vector>
#include<algorithm>
using namespace std;
const int NMAX = 1000;

bool a[NMAX + 2][NMAX + 2];

bool stari_finale[NMAX + 2];

struct muchie {

    int x, y;
    char ch;
};

vector < pair<int, int> > liste[NMAX][NMAX];

vector <muchie> muchii_transfer;
muchie aux;

char alfabet[20];

int main() {

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    int nr_stari, nr_tranzitii, nr_stari_finale;
    int nr_alfabet, x, y;

    scanf("%d\n", &nr_alfabet);
    for(int i = 0; i < nr_alfabet; i++)
        scanf("%c", &alfabet[i]);

    scanf("%d", &nr_stari);

    scanf("%d", &nr_stari_finale);
    for(int i = 0; i < nr_stari_finale; i++) {
        scanf("%d", &x);
        stari_finale[x] = true;
    }

    scanf("%d", &nr_tranzitii);

    for(int i = 0; i < nr_tranzitii; i++) {
        scanf("%d %c %d", &aux.x, &aux.ch, &aux.y);
        muchii_transfer.push_back(aux);
    }

    for(int i = 0; i < nr_stari; i ++)
        for(int j = 0; j < nr_stari; j++)
            if(stari_finale[i] != stari_finale[j])
                a[i][j] = a[j][i] = true;

    int x2, y2, numar_lista;
    int marcate;
    pair <int, int> aux2;

    for(int p = 0; p < nr_stari; p++)
        for(int q = 0; q < p; q++)
        if(a[p][q] == false) {
            for(int i = 0; i < nr_alfabet; i++) {
                x2 = -1;
                y2 = -1;
                for(int k = 0; k < nr_tranzitii; k++) {
                    if(muchii_transfer[k].x == p && muchii_transfer[k].ch == alfabet[i])
                        x2 = muchii_transfer[k].y;
                    if(muchii_transfer[k].x == q && muchii_transfer[k].ch == alfabet[i])
                        y2 = muchii_transfer[k].y;
                }

               if(x2 != -1 && y2 != -1 && a[x2][y2] == true && x2 != y2) {

                    a[p][q] = a[q][p] = true;
                    for(int k = 0; k < liste[p][q].size(); k++)
                        a[liste[p][q][k].first][liste[p][q][k].second] = a[liste[p][q][k].second][liste[p][q][k].first] = true;
               }
               else
               if(x2 != -1 && y2 != -1 && a[x2][y2] == false && x2 != y2){
                    aux2.first = p;
                    aux2.second = q;
                    liste[x2][y2].push_back(aux2);
                    liste[y2][x2].push_back(aux2);
                }

            }

        }

    for(int i = 0; i < nr_stari; i ++) {
        for(int j = 0; j < nr_stari; j ++)
            printf("%d", a[i][j]);
        printf("\n");
    }

    return 0;
}
