#include<cstdio>
#include<vector>
#include<algorithm>
using namespace std;

struct evenimente {
  int index;
  int lungime;
  int timp;
};

vector <evenimente> v;

bool comparare(evenimente a, evenimente b) {
  if(a.timp < b.timp)
    return true;
  if(a.timp == b.timp) {
      if(a.lungime > b.lungime)
        return true;
      else
        return false;
  }

  return false;
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);
  int n;

  evenimente x;

  scanf("%d", &n);
  for(int i = 0; i < n; i++) {
    scanf("%d%d", &x.lungime, &x.timp);
    x.index = i + 1;
    v.push_back(x);
  }

  sort(v.begin(), v.end(), comparare);

  int timp, delay_maxim;
  timp = delay_maxim = 0;

  for(int i = 0; i < n; i ++) {
    timp += v[i].lungime;
    printf("activitatea %d: intervalul %d %d intarziere %d\n", v[i].index, timp - v[i].lungime, timp, timp - v[i].timp);
    if(timp - v[i].timp > delay_maxim)
      delay_maxim = timp - v[i].timp;
  }

  printf("Intarziere planificare %d\n", delay_maxim);

  return 0;
}
