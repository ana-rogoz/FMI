#include <cstdio>
#include <vector>
using namespace std;

const int NMAX = 1000;

struct piesa {
  int partea_stanga, partea_dreapta;
};

int lungime_maxima[NMAX];
vector <int> pozitii_lungime_maxima[NMAX];
int predecesor[NMAX];
piesa vector_piese[NMAX];

int main() {

  freopen ("date.in", "r", stdin);
  freopen ("date.out", "w", stdout);
  int n;
  scanf("%d", &n);

  for (int i = 1; i <= n; i++) {
    scanf("%d%d", &vector_piese[i].partea_stanga, &vector_piese[i].partea_dreapta);
    lungime_maxima[i] = 1;
  }

  int lungime_maxima_sir = 1;
  int numar_aparitii_lungime_maxima = n;
  int pozitie_lungime_maxima = 1;

  for (int i = 2; i <= n; i++) {

    for (int j = i - 1; j >= 1; j--)
      if (vector_piese[j].partea_dreapta == vector_piese[i].partea_stanga) {

        if (lungime_maxima[j] + 1 >= lungime_maxima[i]) {
          lungime_maxima[i] = lungime_maxima[j] + 1;
          predecesor[i] = j;

          if (lungime_maxima[i] > lungime_maxima_sir) {

            lungime_maxima_sir = lungime_maxima[i];
            numar_aparitii_lungime_maxima = 1;
            pozitie_lungime_maxima = i;
          }
          else
          if (lungime_maxima[i] == lungime_maxima_sir)
            numar_aparitii_lungime_maxima ++;
        }
    }
  }

  vector <piesa> solutie;
  int pozitie = pozitie_lungime_maxima;
  while (pozitie != 0) {

    solutie.push_back(vector_piese[pozitie]);
    pozitie = predecesor[pozitie];
  }

  for (int i = solutie.size() - 1; i >= 0; i--)
    printf("%d %d\n", solutie[i].partea_stanga, solutie[i].partea_dreapta);

  printf("%d\n", numar_aparitii_lungime_maxima);

  return 0;
}
