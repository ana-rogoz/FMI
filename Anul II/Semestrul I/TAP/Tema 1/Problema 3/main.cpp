#include <cstdio>
#include <vector>
using namespace std;
const int NMAX = 1000;
vector <int> subsiruri[NMAX];

int cautare_binara(int stanga, int dreapta, int valoare) {
  int mediana, lungime;
  while(stanga < dreapta) {
    mediana = (stanga + dreapta) / 2;
    lungime = subsiruri[mediana].size() - 1;
    if (subsiruri[mediana][lungime] <= valoare)
      stanga = mediana + 1;
    else
      dreapta = mediana;
  }

  return stanga;
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);

  int n, x;
  int poz, nr_subsiruri;

  scanf("%d", &n);

  for (int i = 1; i <= n; i++) {
    scanf("%d", &x);
    poz = cautare_binara(0, nr_subsiruri, x);
    if (poz == nr_subsiruri) {
      nr_subsiruri++;
      subsiruri[nr_subsiruri-1].push_back(x);
    }
    else
      subsiruri[poz].push_back(x);
  }

  for (int i = 0; i < nr_subsiruri; i++) {
    for (int j = 0; j < subsiruri[i].size(); j++)
      printf("%d ", subsiruri[i][j]);
    printf("\n");
  }
  return 0;
}
