#include<cstdio>
#include<vector>
#include<stdlib.h>
using namespace std;
vector <pair<int, int>> puncte;

int arie_triunghi(int x1, int y1, int x2, int y2, int x3, int y3) {

  return abs(x1*y2 + x2*y3 + x3*y1 - y2*x3 - y3*x1 - y1*x2);
}


int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);

  int nr_puncte, xp, yp;
  scanf("%d", &nr_puncte);
  for (int i = 0; i <= nr_puncte; i++) {
    scanf("%d %d", &xp, &yp);
    puncte.push_back({xp, yp});
  }

  scanf("%d%d", &xp, &yp);
  // caz particular varf 0, varf n-2, varf n-1

  int arie_triunghi1, arie_triunghi2, arie_triunghi3, arie_triunghi_total;

  for (int i = 1; i <= nr_puncte-3; i++) {
    arie_triunghi1 = arie_triunghi(puncte[0].first, puncte[0].second, xp, yp, puncte[i].first, puncte[i].second);
    arie_triunghi2 = arie_triunghi(puncte[i].first, puncte[i].second, xp, yp, puncte[i + 1].first, puncte[i + 1].second);
    arie_triunghi3 = arie_triunghi(puncte[0].first, puncte[0].second, xp, yp, puncte[i + 1].first, puncte[i + 1].second);
    arie_triunghi_total = arie_triunghi(puncte[0].first, puncte[0].second, puncte[i].first, puncte[i].second, puncte[i + 1].first, puncte[i + 1].second);

    if (arie_triunghi2 == 0) {
      printf("Punctul se afla pe latura poligonului!");
      return 0;
    }

    if (arie_triunghi1 + arie_triunghi2 + arie_triunghi3 == arie_triunghi_total) {
      printf("Punctul se afla in interiorul poligonului!");
      return 0;
    }
  }

  // caz particular 1: varf 0 + varf 1 + varf 2
  arie_triunghi1 = arie_triunghi(puncte[0].first, puncte[0].second, xp, yp, puncte[1].first, puncte[1].second);
  arie_triunghi2 = arie_triunghi(puncte[1].first, puncte[1].second, xp, yp, puncte[2].first, puncte[2].second);
  arie_triunghi3 = arie_triunghi(puncte[0].first, puncte[0].second, xp, yp, puncte[2].first, puncte[2].second);
  arie_triunghi_total = arie_triunghi(puncte[0].first, puncte[0].second, puncte[1].first, puncte[1].second, puncte[2].first, puncte[2].second);

  if (arie_triunghi1 == 0) {
    printf("Punctul se afla pe latura poligonului!");
    return 0;
  }

  if (arie_triunghi2 == 0) {
    printf("Punctul se afla pe latura poligonului!");
    return 0;
  }

  if (arie_triunghi1 + arie_triunghi2 + arie_triunghi3 == arie_triunghi_total) {
    printf("Punctul se afla in interiorul poligonului!");
    return 0;
  }

  // caz particular 2: varf 0, varf n-2, varf n-1
  arie_triunghi1 = arie_triunghi(puncte[0].first, puncte[0].second, xp, yp, puncte[nr_puncte-2].first, puncte[nr_puncte-2].second);
  arie_triunghi2 = arie_triunghi(puncte[nr_puncte-2].first, puncte[nr_puncte-2].second, xp, yp, puncte[nr_puncte-1].first, puncte[nr_puncte-1].second);
  arie_triunghi3 = arie_triunghi(puncte[0].first, puncte[0].second, xp, yp, puncte[nr_puncte-1].first, puncte[nr_puncte-1].second);
  arie_triunghi_total = arie_triunghi(puncte[0].first, puncte[0].second, puncte[nr_puncte-2].first, puncte[nr_puncte-2].second, puncte[nr_puncte-1].first, puncte[nr_puncte - 1].second);
  if (arie_triunghi1 + arie_triunghi2 + arie_triunghi3 == arie_triunghi_total) {
    printf("Punctul se afla in interiorul poligonului!");
    return 0;
  }

  if (arie_triunghi2 == 0) {
    printf("Punctul se afla pe latura poligonului!");
    return 0;
  }

   if (arie_triunghi3 == 0) {
    printf("Punctul se afla pe latura poligonului!");
    return 0;
  }

  printf("Punctul se afla in exteriorul poligonului!");
  printf("\n");

  return 0;
}
