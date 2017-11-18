#include <cstdio>
#include <vector>
#include <climits>
using namespace std;

vector <int> a;
vector <int> b;
int n, m;


int cautare_binara_in_a(int stanga, int dreapta, int jumatate_elemente) {

  int mediana;
  int elemente_stanga;

  while (stanga <= dreapta) {

    mediana = (stanga + dreapta) / 2;
    elemente_stanga = mediana - 1;
    for (int i = 1; i <= m; i++) {
      if (b[i] < a[mediana])
        elemente_stanga ++;
      else
        break;
    }

    if (elemente_stanga == jumatate_elemente)
      return mediana;
    if (elemente_stanga < jumatate_elemente)
      stanga = mediana + 1;
    if (elemente_stanga > jumatate_elemente)
      dreapta = mediana -1;
  }

  return -1;
}

int cautare_binara_in_b(int stanga, int dreapta, int jumatate_elemente) {

  int mediana;
  int elemente_stanga;

  while (stanga <= dreapta) {

    mediana = (stanga + dreapta) / 2;
    elemente_stanga = mediana - 1;
    for (int i = 1; i <= n; i++) {
      if (a[i] < b[mediana])
        elemente_stanga ++;
      else
        break;
    }

    if (elemente_stanga == jumatate_elemente)
      return mediana;
    if (elemente_stanga < jumatate_elemente)
      stanga = mediana + 1;
    if (elemente_stanga > jumatate_elemente)
      dreapta = mediana - 1;
  }

  return -1;
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);

  scanf("%d", &n);
  a.reserve(n + 2);
  for (int i = 1; i <= n; i++)
    scanf("%d", &a[i]);

  scanf("%d", &m);
  b.reserve(m + 2);
  for (int i = 1; i <= m; i++)
    scanf("%d", &b[i]);

  int jumatate_elemente = (n + m) / 2;

  int gasit = cautare_binara_in_a(1, n, jumatate_elemente);
  int mediana;

  if (gasit == -1) {
    gasit = cautare_binara_in_b(1, m, jumatate_elemente);
    mediana = b[gasit];
  }
  else
    mediana = a[gasit];

  int mediana2 = INT_MIN;
  if ((n + m) % 2 == 0) {
    for (int i = 1; i <= n; i++)
      if (a[i] < mediana && a[i] > mediana2)
        mediana2 = a[i];

    for (int i = 1; i <= m; i++)
      if (b[i] < mediana && b[i] > mediana2)
        mediana2 = b[i];
    printf("%d ", mediana2);
  }

  printf("%d\n", mediana);

  return 0;
}
