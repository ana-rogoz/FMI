/* Format intrare:

stare_initiala
nr_stari_finale
stare_finala_1, ..., stare_finala_n
alfabet_intrare
alfabet_iesire
alfabet_stiva
simbol_initial_stiva
nr_tranzitii
stare_1 stare_2 simbol_tranzitie varf_stiva adauga_stiva scrie
etc.


Vom folosi pentru lambda simbolul *, iar pentru simbolul initial al stivei #
*/

/*
Exemplul 1:
0
1
3
*abc
*cd
a#
#
8
0 1 b , a | * ; cc
1 2 * , a | * ; d
2 3 * , # | * ; *
0 0 a , # | a# ; *
0 0 a , a | aa ; *
1 0 * , a | a ; *
1 1 b , a | * ; cc
2 2 * , a | * ; d
3
aaaaabbaaa
aaaaabbbbb
aaabaabb

Exemplul 2:
0
1
2
*ab
*123
abs#
#
7
0 1 * , # | S# ; *
1 1 * , S | ASBS ; 1
1 1 * , S | BSAS ; 2
1 1 * , S | * ; 3
1 1 a , A | * ; *
1 1 b , B | * ; *
1 2 * , # | # ; *
*/

#include <stdio.h>
#include <string>
#include <set>
#include <vector>
#include <string.h>
#include <queue>
using namespace std;

struct translator_stiva {
  char simbol_automat;
  char varf_stiva;
  char adauga_in_stiva[5];
  char scrie[5];
};

struct intrare_iesire {
  string sir_intrare;
  string sir_iesire;
  string stiva;
};

set <int> stari_finale;
set <char> alfabet_intrare;
set <char> alfabet_iesire;
set <char> alfabet_stiva;
vector <pair<int, translator_stiva>> tranzitii[1000];

queue <pair<int, intrare_iesire>> rezolva;

int nr_inputuri;
int stare_initiala, nr_stari_finale, nr_tranzitii;
char simbol_initial_stiva;

void citire() {

  scanf("%d", &stare_initiala);
  scanf("%d", &nr_stari_finale);
  for (int i = 0; i < nr_stari_finale; i++) {
    int stare;
    scanf("%d", &stare);
    stari_finale.insert(stare);
  }

  char alfabet[20];
  memset(alfabet, 0, sizeof(alfabet));
  // Alfabet_intrare.
  scanf("\n");
  gets(alfabet);
  for (int i = 0; i < strlen(alfabet); i++) {
    alfabet_intrare.insert(alfabet[i]);
  }

  // Alfabet iesire.
  gets(alfabet);
  for (int i = 0; i < strlen(alfabet); i++) {
    alfabet_iesire.insert(alfabet[i]);
  }

  // Alfabet stiva.
  gets(alfabet);
  for (int i = 0; i < strlen(alfabet); i++) {
    alfabet_stiva.insert(alfabet[i]);
  }

  // Simbol initial stiva.
  scanf("%c \n", &simbol_initial_stiva);

  // Tranzitii.
  scanf("%d ", &nr_tranzitii);
  for (int i = 0; i < nr_tranzitii; i++) {
    translator_stiva tranz_curenta;
    int stare_curenta, stare_urmatoare;
    scanf("%d %d ", &stare_curenta, &stare_urmatoare);
    scanf("%c , %c | %s ; %s\n", &tranz_curenta.simbol_automat, &tranz_curenta.varf_stiva, &tranz_curenta.adauga_in_stiva, &tranz_curenta.scrie);
    tranzitii[stare_curenta].push_back(make_pair(stare_urmatoare, tranz_curenta));
  }

  scanf("%d", &nr_inputuri);
}

void rezolvare() {

  char intrare[30];
  intrare_iesire curent;
  scanf("%s", &intrare);
  curent.sir_intrare = intrare;
  curent.stiva = simbol_initial_stiva;
  rezolva.push(make_pair(stare_initiala, curent));

  printf("Pentru intrarea '%s' avem urmatoarele translatii: \n", intrare);
  while(!rezolva.empty()) {

    pair <int, intrare_iesire> nod_curent = rezolva.front();
    // Daca nu mai avem sir de intrare si ne aflam intr-o stare finala.
    if (nod_curent.second.sir_intrare.size() == 0 && stari_finale.find(nod_curent.first) != stari_finale.end()) {
      for (std::string::iterator it = nod_curent.second.sir_iesire.begin(); it != nod_curent.second.sir_iesire.end(); it++) {
        printf("%c", *it);
      }
      printf("\n");
    }
    else {
      int stare_curenta = nod_curent.first;
      intrare_iesire siruri_curente = nod_curent.second;
      for (int i = 0; i < tranzitii[stare_curenta].size(); i++) {
        int stare_urmatoare = tranzitii[stare_curenta][i].first;
        translator_stiva tranzitie = tranzitii[stare_curenta][i].second;

        // Cazul 1: Tranzitie pentru ca prima litera din cuvant = litera de pe muchie si varful stivei de pana acum e la fel ca varful stivei de pe tranzitie.
        if (tranzitie.simbol_automat == siruri_curente.sir_intrare.front() && tranzitie.varf_stiva == siruri_curente.stiva.front()) {
          // Adaug o noua intrare in stiva.
          intrare_iesire urmator;
          urmator.sir_intrare = siruri_curente.sir_intrare.substr(1, siruri_curente.sir_intrare.size());
          if (tranzitie.scrie[0] == '*') {
            urmator.sir_iesire = siruri_curente.sir_iesire;
          } else {
            urmator.sir_iesire = siruri_curente.sir_iesire + tranzitie.scrie;
          }
          if (tranzitie.adauga_in_stiva[0] == '*') {
            urmator.stiva = siruri_curente.stiva.substr(1, siruri_curente.stiva.size());
          } else {
            urmator.stiva = tranzitie.adauga_in_stiva + siruri_curente.stiva.substr(1, siruri_curente.stiva.size());
          }
          rezolva.push(make_pair(stare_urmatoare, urmator));
        }
        // Cazul 2: Lambda - tranzitie si varful stivei de pana acum e la fel ca varful stivei de pe tranzitie.
        if (tranzitie.simbol_automat == '*' && tranzitie.varf_stiva == siruri_curente.stiva.front()) {
          intrare_iesire urmator;
          urmator.sir_intrare = siruri_curente.sir_intrare;
          if (tranzitie.scrie[0] == '*') {
            urmator.sir_iesire = siruri_curente.sir_iesire;
          } else {
            urmator.sir_iesire = siruri_curente.sir_iesire + tranzitie.scrie;
          }
          if (tranzitie.adauga_in_stiva[0] == '*') {
            urmator.stiva = siruri_curente.stiva.substr(1, siruri_curente.stiva.size());
          } else {
            urmator.stiva = tranzitie.adauga_in_stiva + siruri_curente.stiva.substr(1, siruri_curente.stiva.size());
          }
          rezolva.push(make_pair(stare_urmatoare, urmator));
        }
      }
    }
    rezolva.pop();
  }
  printf("\n");
}

int main() {

  freopen("date2.in", "r", stdin);
  freopen("date.out", "w", stdout);

  citire();

  for (int i = 0; i < nr_inputuri; i++) {
    rezolvare();
  }

  return 0;
}
