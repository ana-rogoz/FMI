

#include <iostream>
#include <string>
#include <stdio.h>

using namespace std;

int nrS, nrS_fin, stari_fin[10], nr_simboluri, i, DFA[15][15];
char simboluri[10], cuvant[100];

int verificareCuvant(int stare, char simbol)
{
    for(int i = 0; i < nr_simboluri; i++)
        if(simbol == simboluri[i])
            return(DFA[i][stare]);
    return -1;
}
int main()
{
    int s = 0;
    cout << "Dati numarul de stari! ";
    cin >> nrS;
    cout << "Dati numarul de stari finale ";
    cin >> nrS_fin;
    cout << "Numiti starile finale ";
    for(int i = 0; i < nrS_fin; i++)
        cin>>stari_fin[i];
    cout << "Dati numarul de simboluri ";
    cin >> nr_simboluri;
    cout << "Introduceti simbolurile ";
    getchar();
    for(i=0; i<nr_simboluri; i++)
        cin>>simboluri[i];

    cout << "Matricea DFA este: \n";

    for(i = 0; i < nr_simboluri; i++)
        for(int j = 0; j < nrS; j++)
        {
            cin >> DFA[i][j];
        }
        cout << "Introduceti un cuvintel ";
    getchar();
    gets(cuvant);
    i = 0;
    while(cuvant[i] != NULL)
    {
        cout << s << " \n";
        s = verificareCuvant(s,cuvant[i]);
        if(s < 0)
            break;
        i++;
    }
    int ok = 0;
    for(i = 0; i < nrS_fin; i++)
        if(s == stari_fin[i])
            ok = 1;
    if(ok)
        cout << "Ati introdus un cuvant valid";
    else
        cout << "Ati introdus un cuvant invalid";
    return 0;
}
