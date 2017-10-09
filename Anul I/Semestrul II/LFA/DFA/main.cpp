/*
TIP FISIER INTRARE

- lungime alfabet
- caractere alfabet
- numar stari finale
- indici stari finale
- stare initiala
- numar muchii de transfer intre stari
- muchii de transfer intre stari de forma: stare curenta - caracter de trecere - stare finala
- input
*/

#include<cstdio>
#include<vector>
using namespace std;

const int NUMAR_MAXIM_STARI = 30;

int lungime_alfabet, numar_stari_finale, numar_muchii;
int stare_initiala;

vector < pair<char, int> > muchii[NUMAR_MAXIM_STARI];
vector <char> alfabet;
vector <int> stari_finale;

void citire() {

    char ch;

    scanf("%d\n", &lungime_alfabet);
    for(int i = 0; i < lungime_alfabet; i++) {

        scanf("%c", &ch);
        alfabet.push_back(ch);
    }

    scanf("%d", &numar_stari_finale);
    int x;

    for(int i = 0; i < numar_stari_finale; i++) {

        scanf("%d", &x);
        stari_finale.push_back(x);
    }

    scanf("%d", &stare_initiala);
    scanf("%d", &numar_muchii);
    pair <char, int> pereche;

    for(int i = 0; i < numar_muchii; i++) {

        scanf("%d %c %d", &x, &pereche.first, &pereche.second);
        muchii[x].push_back(pereche);
    }
}

int exista_stare_urmatoare(int &stare_curenta, char ch) {

    for(int i = 0; i < muchii[stare_curenta].size(); i++)
        if(muchii[stare_curenta][i].first == ch) {

            stare_curenta = muchii[stare_curenta][i].second;
            return 1;
        }

    return 0;
}


void rezolvare() {

    int stare_curenta = stare_initiala;
    char ch;

    scanf("\n");

    while(1) {

        scanf("%c", &ch);
        if(ch == '\n' || ch == '0')
            break;

        if(exista_stare_urmatoare(stare_curenta, ch) == 0) {
            printf("Inputul nu este valid!\n");
            return;
        }
    }

    for(int i = 0; i < stari_finale.size(); i++)
        if(stare_curenta == stari_finale[i]) {
            printf("Inputul este valid si se termina in starea finala %d.\n", stare_curenta);
            return;
        }

    printf("Inputul nu se termina intr-o stare finala.\n");

}

int main()  {

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    citire();
    rezolvare();

    return 0;
}
