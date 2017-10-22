#include<cstdio>
#include<vector>
#include<algorithm>
#include<stack>
using namespace std;

struct intervale {

  int stanga, dreapta;
};

vector <intervale> v;
stack <intervale> st;

bool sortare(intervale a, intervale b) {

  if(a.stanga < b.stanga)
    return true;
  else
  if(a.stanga == b.stanga) {
    if(a.dreapta < b.dreapta)
      return true;
    else
      return false;
    }
  else
    return false;
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);

  int a, b;
  int n;
  intervale x;

  scanf("%d%d", &a, &b);
  scanf("%d", &n);

  for(int i = 0; i < n; i++) {
    scanf("%d%d", &x.stanga, &x.dreapta);
    if(x.dreapta < a || x.stanga > b)
      continue;
    else {
      v.push_back(x);
    }
  }

  if(v.size() == 0) {
    printf("-1\n");
    return 0;
  }

  sort(v.begin(), v.end(), sortare);

  if(v[0].stanga > a) {
    printf("-1\n");
    return 0;
  }

  int num = 1;
  intervale top1, top2;

  st.push(v[0]);

  for(int i = 1; i < n; i++) {
    top1 = st.top();
    if(v[i].stanga <= top1.dreapta && v[i].stanga >= top1.stanga && v[i].dreapta > top1.dreapta) {
      if(st.size() >= 2) {
        while(st.size()>=2) {
          top1 = st.top();
          st.pop();
          top2 = st.top();
          if(v[i].stanga <= top2.dreapta)
            continue;
          else {
            st.push(top1);
            st.push(v[i]);
            break;
          }
        }

        if(st.size() == 1)
          st.push(v[i]);
      }
      else {
        if(v[i].stanga <= a)
          st.pop();
        st.push(v[i]);
      }
    }

    if(st.top().dreapta >= b)
      break;
  }

  if(st.top().dreapta < b)
    printf("-1\n");
  else {
    printf("%d\n", st.size());
    while(!st.empty()) {
      printf("%d %d\n", st.top().stanga, st.top().dreapta);
      st.pop();
    }
  }

  return 0;
}
