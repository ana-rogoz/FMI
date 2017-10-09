#include<cstdio>
#include<vector>
#include<algorithm>
#include<unordered_map>
using namespace std;

struct StructCuPozitii {

  int val;
  int poz;
};

unordered_map <int, int> map_vector;

bool cmp(StructCuPozitii a, StructCuPozitii b) {

  return a.val < b.val;
}

void Varianta1(int &n, int &sum, vector <StructCuPozitii> &v) {

  StructCuPozitii x;
  bool gasit = false;

  scanf("%d%d", &n, &sum);
  for(int i = 0; i < n; i++) {
    scanf("%d", &x.val);
    x.poz = i;
    v.push_back(x);

    if(gasit == false) {
      int complement = sum - x.val;
      auto rezultat = map_vector.find(complement);
      if(rezultat != map_vector.end()) {
        printf("Varianta cu hasuri a gasit pe pozitiile: %d %d.\n", i, rezultat->second);
        gasit = true;
      }
      map_vector.insert({x.val, x.poz});
    }
  }

  if(gasit == false) {
    printf("Nu exista solutie. \n");
  }
}

void Varianta2(int &n, int &sum, vector <StructCuPozitii> &v) {

  for(int i = 0; i < n; i++)
    for(int j = i + 1; j < n; j++)
      if(v[i].val + v[j].val == sum) {
        printf("Varianta brute force a gasit pe poztiile: %d %d.\n", i, j);
        return;
      }
  printf("Nu exista solutie. \n");
}

void Varianta3(int &n, int &sum, vector <StructCuPozitii> &v) {

  sort(v.begin(), v.end(), cmp);
  int stanga = 0, dreapta  = n - 1;
  int suma_aux;

  while(stanga < dreapta) {
    suma_aux = v[stanga].val + v[dreapta].val;
    if(suma_aux < sum)
      stanga ++;
    else
    if(suma_aux > sum)
      dreapta --;
    else {
      printf("Varianta cu sortare a gasit pe pozitiile: %d %d.\n", v[stanga].poz, v[dreapta].poz);
      return;
    }
  }
  printf("Nu exista solutie. \n");
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);

  vector <StructCuPozitii> v;
  int n, sum;

  Varianta1(n, sum, v);
  Varianta2(n, sum, v);
  Varianta3(n, sum, v);

  return 0;
}
