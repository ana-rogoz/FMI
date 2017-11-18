#include <cstdio>
#include <vector>
using namespace std;

vector <int> postordine; // SDR
vector <int> inordine; // SRD
vector <pair<int, int>> arbore_binar; // in asta construiesc arborele
bool valid = true;

int construiesteArbore(int stanga_post, int dreapta_post, int stanga_in, int dreapta_in) {

  if(valid == false)
    return 0;

  int radacina = postordine[dreapta_post];
  int radacinaPozitieInordine = -1;

  for(int i = stanga_in; i <= dreapta_in; i++)
    if(inordine[i] == radacina)
      radacinaPozitieInordine = i;

  if(radacinaPozitieInordine == -1) {
    valid = false;
    return 0;
  }

  int nr_elemente_subarbore_stang = radacinaPozitieInordine - stanga_in; // 1 2 3 radacina-4 5 6 ----- 4 - 1 = 3 elemente
  int nr_elemente_subarbore_drept = dreapta_in - radacinaPozitieInordine; // 1 2 3 radacina-4 5 6 ----- 6 - 4 = 2 elemente

  if(nr_elemente_subarbore_stang > 0) {
    arbore_binar[radacina].first = postordine[stanga_post + nr_elemente_subarbore_stang - 1];
    construiesteArbore(stanga_post, stanga_post + nr_elemente_subarbore_stang - 1, stanga_in, radacinaPozitieInordine - 1); //subarbore stang
  } else
    arbore_binar[radacina].first = -1;

  if(nr_elemente_subarbore_drept > 0) {
    arbore_binar[radacina].second = postordine[dreapta_post - 1];
    construiesteArbore(dreapta_post - nr_elemente_subarbore_drept , dreapta_post - 1, radacinaPozitieInordine + 1, dreapta_in); //subarbore drept
  } else
    arbore_binar[radacina].second = -1;
}

void parcurgerePreordine(int radacina) {

  printf("%d ", radacina);

  if(arbore_binar[radacina].first != -1)
    parcurgerePreordine(arbore_binar[radacina].first);

  if(arbore_binar[radacina].second != -1)
    parcurgerePreordine(arbore_binar[radacina].second);
}

int main() {

  freopen("date.in", "r", stdin);
  freopen("date.out", "w", stdout);

  int n;
  scanf("%d", &n);

  postordine.reserve(n + 2);
  inordine.reserve(n + 2);
  arbore_binar.reserve(n + 2);

  for (int i = 0; i < n; i++)
    scanf("%d", &postordine[i]);
  for (int i = 0; i < n; i++)
    scanf("%d", &inordine[i]);

  construiesteArbore(0, n-1, 0, n-1);
  if (valid == false) {
    printf("nu\n");
    return 0;
  }

  parcurgerePreordine(postordine[n-1]);
  printf("\n");
  for (int i = 0; i < n; i++)
    printf("%d ", inordine[i]);
  printf("\n");
  for (int i = 0; i < n; i++)
    printf("%d ", postordine[i]);
  printf("\n");

  return 0;
}
