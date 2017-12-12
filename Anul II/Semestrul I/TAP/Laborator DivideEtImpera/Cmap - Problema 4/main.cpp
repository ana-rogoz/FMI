#include <cstdio>
#include <algorithm>
#include <limits.h>
#include <math.h>
#include <vector>
using namespace std;

struct punct {

  int x, y;
};

vector <punct> v;

long long dist(punct a, punct b) {
  return (long long)(a.x - b.x) * (a.x - b.x) + (long long)(a.y - b.y) * (a.y - b.y);
}

bool functia_de_comparare(punct a, punct b) {
  if(a.x < b.x)
    return true;
  if(a.x > b.x)
    return false;
  return a.y < b.y;
}

bool functia_de_comparare2(punct a, punct b) {

  return a.y < b.y;
}

long long solutie(int inceput, int sfarsit) {

  if(sfarsit - inceput == 1) {
    return dist(v[inceput], v[sfarsit]);
  }

  if(sfarsit - inceput == 2) {
    return min(dist(v[inceput], v[inceput + 1]), min(dist(v[inceput + 1], v[inceput + 2]), dist(v[inceput + 2], v[inceput + 1])));
  }

  int mediana = (inceput + sfarsit) / 2;
  long long distanta_minima = min(solutie(inceput, mediana), solutie(mediana + 1, sfarsit));

  vector <punct> auxiliar;
  for (int i = inceput; i <= sfarsit; i ++)
    if ((v[i].x - v[mediana].x) * (v[i].x - v[mediana].x) <= distanta_minima)
      auxiliar.push_back(v[i]);

  sort(auxiliar.begin(), auxiliar.end(), functia_de_comparare2);
  for (int i = 0; i < auxiliar.size(); i++)
    for (int j = i + 1; j <= i + 7 && j < auxiliar.size(); j++)
      distanta_minima = min(distanta_minima, dist(auxiliar[i], auxiliar[j]));

  return distanta_minima;
}

int main() {

  freopen("cmap.in", "r", stdin);
  freopen("cmap.out", "w", stdout);

  int n;
  scanf("%d", &n);
  punct x;
  for (int i = 0; i < n; i++) {
    scanf("%d %d", &x.x, &x.y);
    v.push_back(x);
  }

  sort(v.begin(), v.end(), functia_de_comparare);

  double distanta = sqrt(solutie(0, n-1));
  printf("%.6lf", distanta);

  return 0;
}
