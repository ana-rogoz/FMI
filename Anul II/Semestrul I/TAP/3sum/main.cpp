#include<cstdio>
#include<vector>
#include<algorithm>
using namespace std;

struct StructCuPozitii {

  int val;
  int poz;
};

void Citire(int &n, int &sum, vector <StructCuPozitii> &v) {

  StructCuPozitii x;
  scanf("%d%d", &n, &sum);
  for(int i = 0; i < n; i++) {
    scanf("%d", &x.val);
    x.poz = i;
    v.push_back(x);
  }
}

void Varianta1(int &n, int &sum, vector <StructCuPozitii> &v) {

  for(int i = 0; i < n; i++)
    for(int j = i + 1; j < n; j++)
      for(int k = j + 1; k < n; k++)
        if(v[i].val + v[j].val + v[k].val == sum) {
          printf("Varianta brute-force a gasit pozitiile: %d %d %d. \n", i, j, k);
          return;
        }
  printf("Nu exista solutie. \n");
}

bool cmp(StructCuPozitii a, StructCuPozitii b) {

  return a.val < b.val;
}

int bs(int stanga, int dreapta, int x, vector <StructCuPozitii> &v) {

  while(stanga <= dreapta) {
    int med = (stanga + dreapta) / 2;
    if(v[med].val < x)
      stanga = med + 1;
    else
    if(v[med].val > x)
      dreapta = med - 1;
    else
      return med;
  }

  return -1;
}

void Varianta2(int &n, int &sum, vector <StructCuPozitii> &v) {

  sort(v.begin(), v.end(), cmp);

  for(int i = 0; i < n; i++)
    for(int j = i + 1; j < n; j++) {
      int rez = bs(1, n, sum - v[i].val - v[j].val, v);
      if(rez != -1) {
        printf("Varianta cu cautare binara a gasit pozitiile: %d %d %d. \n", i, j, rez);
        return;
      }
    }
  printf("Nu exista solutie. \n");
}

void Varianta3(int &n, int &sum, vector <StructCuPozitii> &v) {

  sort(v.begin(), v.end(), cmp);

  for(int i = 0; i < n; i++) {
    int stanga = i + 1, dreapta  = n - 1;
    int suma_aux;
    while(stanga < dreapta) {
      suma_aux = v[stanga].val + v[dreapta].val + v[i].val;
      if(suma_aux < sum)
        stanga ++;
      else
      if(suma_aux > sum)
        dreapta --;
      else {
        printf("Varianta cu sortare a gasit pe pozitiile: %d %d %d.\n", v[stanga].poz, v[dreapta].poz, v[i].poz);
        return;
      }
    }
  }
  printf("Nu exista solutie. \n");
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);
  int n, sum;
  vector <StructCuPozitii> v;

  Citire(n, sum, v);
  Varianta1(n, sum, v);
  Varianta2(n, sum, v);
  Varianta3(n, sum, v);

  return 0;
}
