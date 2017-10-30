#include <cstdio>
#include <queue>
#include <vector>
using namespace std;
const int NMAX = 1000;
class cmp{
  public:
    bool operator() (pair<int, int> a, pair<int, int> b) {
      return a.first > b.first;
    }

};
priority_queue <pair<int, int>, vector<pair<int, int>>, cmp> heap;
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

  int lungime;
  pair<int, int> element;
  for (int i = 0; i < nr_subsiruri; i++) {
    lungime = subsiruri[i].size();
    element.first = subsiruri[i][lungime - 1];
    element.second = i;
    heap.push(element);
  }

  pair<int, int> varf;
  while (!heap.empty()) {
    varf = heap.top();
    heap.pop();
    printf("%d ", varf.first);
    subsiruri[varf.second].pop_back();
    if (subsiruri[varf.second].size() == 0)
      continue;
    else {
      lungime = subsiruri[varf.second].size();
      element.first = subsiruri[varf.second][lungime - 1];
      element.second = varf.second;
      heap.push(element);
    }
  }
  printf("\n");

  return 0;
}
