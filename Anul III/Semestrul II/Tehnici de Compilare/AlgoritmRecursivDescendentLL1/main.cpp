/*
numar de sb neterminale
sir neterminali
numar de sb terminale
sir terminali
simbol de start
productia1
productia2
...
productia n



-- am notat lambda cu l
*/

#include <cstdio>
#include <vector>
#include <string>
#include <string.h>
#include <map>
#include <set>
#include <algorithm>
#include <iostream>

using namespace std;

const int NETERMINALIMAX = 100;

vector <char> neterminali;
vector <char> terminali;
vector <string> productii[NETERMINALIMAX];
map <char, int> neterminal_pozitie; // pastreaza pentru fiecare neterminal linia din vector pe care i se gasesc productiile
map <int, char> pozitie_neterminal;
map <char, set<char>> first;
map <char, set<char>> follow;

int numar_neterminali, numar_terminali;
char sb_start;

void citire() {
  scanf("%d\n", &numar_neterminali);
  for (int i = 0; i < numar_neterminali; i++) {
    char ch;
    scanf("%c ", &ch);
    neterminali.push_back(ch);
    neterminal_pozitie[ch] = i;
    pozitie_neterminal[i] = ch;
  }

  scanf("%d\n", &numar_terminali);
  for (int i = 0; i < numar_terminali; i++) {
    char ch;
    scanf("%c ", &ch);
    terminali.push_back(ch);
  }

  scanf("\n%c\n", &sb_start);

  char linie_productie[20];
  while(1) {
    gets(linie_productie);

    if(strlen(linie_productie) == 0) {
      break;
    }

    int lungime = strlen(linie_productie);
    string productie_curenta(linie_productie);

    char neterminal = linie_productie[0];
    int pozitie = neterminal_pozitie[neterminal];

    productii[pozitie].push_back(productie_curenta.substr(5));
  }
}


bool reuniune(set <char> first, set <char> begins) {
  int n = first.size();
  first.insert(begins.begin(), begins.end());
  return first.size() != n; // reuniunea are nr mai mare de elem decat first initial
}

void calculeaza_first_follow() {

  for(int i = 0; i < terminali.size(); i++) {
    first[terminali[i]].insert(terminali[i]);
  }

  follow[sb_start].insert('$');

  set <char> lambda;
  for (int i = 0; i < numar_neterminali; i++) {
    for (int j = 0; j < productii[i].size(); j++)
      if (productii[i][j] == "l") {
        char neterminal = pozitie_neterminal[i];
        lambda.insert(neterminal);
      }
  }

  bool ok = true;
  int old_len;

  do {
    ok = false;

    for (int i = 0; i < numar_neterminali; i++)
      for (int j = 0; j < productii[i].size(); j++) {
        char left = pozitie_neterminal[i];
        string right = productii[i][j];

        for (int k = 0; k < right.size(); k++) {
          char simbol = right[k];

          old_len = first[left].size();

          first[left].insert(first[simbol]);

          if (old_len != first[left].size()) {
              ok = false;
          }

          if (lambda.find(simbol) == nullptr) {
            break;
          } else {
            old_len = lambda.size();
            lambda.insert(left);
            if (old_len != lambda.size()) {
              ok = false;
            }
          }
        }

        set <char> new_set = follow[left];
        for (int k = right.size() - 1; k >= 0; k--) {
          char simbol = right[k];

          old_len = follow[simbol].size();
          follow[simbol].insert(new);
          if (lambda.find(simbol) != nullptr) {
            new_set.insert(first[simbol]);
          } else {
            new_set = first[simbol];
          }
        }
      }
  } while(ok == false);
}


int main() {

  freopen("date.in", "r", stdin);

  citire();
  calculeaza_first_follow();

  /*
  for (int i = 0; i < productii[2].size(); i++) {
    string cur(productii[2][i]);
    cout << cur << endl;
  }*/
  return 0;
}
