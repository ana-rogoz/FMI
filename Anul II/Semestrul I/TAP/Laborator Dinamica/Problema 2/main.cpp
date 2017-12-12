#include <cstdio>
#include <vector>
using namespace std;

const int NMAX = 1000;
int matrice[NMAX][NMAX], solutie[NMAX][NMAX];
vector <pair<int, int>> pozitii_solutie;

int main() {

  freopen ("date.in", "r", stdin);
  freopen ("date.out", "w", stdout);

  int n, m;
  scanf("%d%d", &n, &m);

  for (int i = 1; i <= n; i++)
    for (int j = 1; j <= m; j++)
      scanf("%d", &matrice[i][j]);

  for (int i = 1; i <= n; i++)
    solutie[i][1] = solutie[i-1][1] + matrice[i][1];

  for (int j = 1; j <= m; j++)
    solutie[1][j] = solutie[1][j-1] + matrice[1][j];

  for (int i = 2; i <= n; i++)
    for (int j = 2; j <= m; j++)
      solutie[i][j] = max(solutie[i-1][j], solutie[i][j-1]) + matrice[i][j];

  printf("%d\n", solutie[n][m]);

  int pozitie_i = n, pozitie_j = m;
  pozitii_solutie.push_back({n, m});

  do {


    if (solutie[pozitie_i][pozitie_j] - matrice[pozitie_i][pozitie_j] == solutie[pozitie_i-1][pozitie_j])
      pozitie_i--;
    else
      pozitie_j--;
    pozitii_solutie.push_back({pozitie_i, pozitie_j});
  } while (!(pozitie_i == 1 && pozitie_j == 1));

  for (int i = pozitii_solutie.size() - 1; i >= 0; i--)
    printf("%d %d\n", pozitii_solutie[i].first, pozitii_solutie[i].second);

  return 0;
}
