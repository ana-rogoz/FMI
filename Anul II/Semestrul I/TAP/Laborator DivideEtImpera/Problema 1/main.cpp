#include<cstdio>
#include<vector>
using namespace std;
vector <int> v;

int bs(int left, int right) {

 int mediana = (left + right) / 2;
 if(left > right)
  return -1;
 if(v[mediana] == mediana)
  return mediana;
 if(v[mediana] > mediana) {
  right = mediana;
  bs(left, right);
 }
 if(v[mediana] < mediana) {
  left = mediana + 1;
  bs(left, right);
 }
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);
  int n;
  scanf("%d", &n);
  v.reserve(n + 2);
  for(int i = 0; i < n; i++)
    scanf("%d", &v[i]);
  int result = bs(0, n);
  if(result == -1)
    printf("Nu exista valoarea. \n");
  else
    printf("%d", result);

  return 0;
}
