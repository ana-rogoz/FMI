#include <cstdio>
#include <iostream>
#include <string>
#include <string.h>
#include <vector>
using namespace std;

const int NMAX = 1000;
char cuvant_unu[NMAX];
char cuvant_doi[NMAX];

int solutie[NMAX][NMAX];
vector <string> mesaje_solutie;

int main() {

  freopen ("date.in", "r", stdin);
  freopen ("date.out", "w", stdout);

  gets(cuvant_unu + 1);
  gets(cuvant_doi + 1);

  int n = strlen(cuvant_unu + 1);
  int m = strlen(cuvant_doi + 1);

  int cost_inserare, cost_stergere, cost_inlocuire;
  scanf("%d %d %d", &cost_inserare, &cost_stergere, &cost_inlocuire);

  for (int i  = 1; i <= n; i++) //completez prima coloana -- cuvantul 1 intreg, cuvantul 2 nul
      solutie[i][0] = solutie[i-1][0] + cost_stergere;

  for (int j = 1; j <= m; j++) // completez prima linie -- cuvantul 1 nul, cuvantul 2 intreg
      solutie[0][j] = cost_inserare + solutie[0][j-1];

  for (int i = 1; i <= n; i++)
    for (int j = 1; j <= m; j++)
      if (cuvant_unu[i] == cuvant_doi[j])
        solutie[i][j] = solutie[i-1][j-1];
      else
        solutie[i][j] = min(solutie[i-1][j-1] + cost_inlocuire, min(solutie[i][j-1] + cost_inserare, solutie[i-1][j] + cost_stergere));

  printf("%d\n", solutie[n][m]);

  int pozitie_i = n, pozitie_j = m;

  do {
    if (cuvant_unu[pozitie_i] == cuvant_doi[pozitie_j]) {
      printf("pastram %c\n", cuvant_unu[pozitie_i]);
      pozitie_i--;
      pozitie_j--;
    }
    else
    if (solutie[pozitie_i][pozitie_j] - cost_inlocuire == solutie[pozitie_i - 1][pozitie_j-1]) {
      printf("inlocuim %c - %c\n", cuvant_unu[pozitie_i], cuvant_doi[pozitie_j]);
      pozitie_i--;
      pozitie_j--;
    }
    else
    if (solutie[pozitie_i][pozitie_j] - cost_inserare == solutie[pozitie_i][pozitie_j - 1]) {
      printf("inseram %c\n", cuvant_doi[pozitie_j]);
      pozitie_j--;
    }
    else
    if (solutie[pozitie_i][pozitie_j] - cost_stergere == solutie[pozitie_i - 1][pozitie_j]) {
      printf("stergem %c\n", cuvant_unu[pozitie_i]);
      pozitie_i--;
    }
  } while(pozitie_i > 0 && pozitie_j > 0);


  while(pozitie_i > 0) {
    printf("stergem %c", cuvant_unu[pozitie_i]);
    pozitie_i--;
  }

  while(pozitie_j > 0) {
    printf("inseram %c\n", cuvant_doi[pozitie_j]);
    pozitie_j--;
  }

  return 0;
}
