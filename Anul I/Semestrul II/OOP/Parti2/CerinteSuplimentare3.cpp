#include<iostream>
#include<string.h>

using namespace std;

struct DataLunii
{

    int zi, luna, an;
    int valoare;
};

class Pacient
{

private:

    char *nume;
    int zi, luna, an;
    char *adresa;
    int nr_analize;
    DataLunii colesterol[20], tensiune[20], proteine[20];
    bool boala_cardio_vasculara;
    int ProteinaC;

public:

    Pacient()
    {

        nume = new char[30];
        zi = luna = an = 0;
        nr_analize = 0;
        adresa = new char[30];
        memset(colesterol, 0, sizeof(colesterol));
        memset(tensiune, 0, sizeof(tensiune));
        memset(proteine, 0, sizeof(proteine));
        boala_cardio_vasculara = false;
        ProteinaC = 0;
    }

    int getAn()
    {
        return an;
    }
    bool getBoalaCardioVasculara()
    {
        return boala_cardio_vasculara;
    }
    int getNumarAnalize()
    {
        return nr_analize;
    }
    int getTensiune(int i)
    {
        return tensiune[i].valoare;
    }
    int getColesterol(int i)
    {
        return colesterol[i].valoare;
    }

    Pacient(char* n, int z, int l, int a, char* adresa, bool blcv, int pc = 0)
    {

        nume = new char[strlen(n) + 2];
        strcpy(nume, n);
        zi = z;
        luna = l;
        an = a;
        nr_analize = 0;
        boala_cardio_vasculara = blcv;
        ProteinaC = pc;
    }

    Pacient& operator= (Pacient x)
    {

        delete [] nume;
        delete [] adresa;

        nume = new char[strlen(x.nume) + 2];
        adresa = new char[strlen(x.adresa) + 2];
        strcpy(nume, x.nume);
        strcpy(adresa, x.adresa);
        zi = x.zi;
        an = x.an;
        luna = x.luna;
        nr_analize = x.nr_analize;
        for(int i = 0; i < nr_analize; i++)
        {
            colesterol[i] = x.colesterol[i];
            proteine[i] = x.proteine[i];
            tensiune[i] = x.tensiune[i];
        }

        boala_cardio_vasculara = x.boala_cardio_vasculara;
        ProteinaC = x.ProteinaC;

        return *this;
    }

    friend istream& operator>> (istream& i, Pacient& x);
    friend ostream& operator<< (ostream& o, Pacient &x);

    /*~Pacient() {

     an = luna = zi = 0;
     nr_analize = 0;
     memset(colesterol, 0, sizeof(colesterol));
     memset(tensiune, 0, sizeof(tensiune));
     memset(proteine, 0, sizeof(proteine));
     delete [] nume;
     delete [] adresa;

    }*/
};

istream& operator>> (istream& i, Pacient &x)
{

    i >> x.nume;
    i >> x.zi >> x.luna >> x.an;
    i >> x.adresa;
    i >> x.nr_analize;
    for(int i = 0; i < x.nr_analize; i++)
        i >> x.colesterol[i].zi >> x.colesterol[i].luna >> x.colesterol[i].an >> x.colesterol[i].valoare;
    for(int i = 0; i < x.nr_analize; i++)
        i >> x.proteine[i].zi >> x.proteine[i].luna >> x.proteine[i].an >> x.proteine[i].valoare;
    for(int i = 0; i < x.nr_analize; i++)
        i >> x.tensiune[i].zi >> x.tensiune[i].luna >> x.tensiune[i].an >> x.tensiune[i].valoare;
    return i;
}

ostream& operator<< (ostream& o, Pacient &x)
{

    o << x.nume << " ";
    o << x.zi << "." << x.luna << "." << x.an << endl;
    o << x.adresa << endl;
    o << x.nr_analize << endl;
    o << "Valorile colesterolului:" << endl;
    for(int i = 0; i < x.nr_analize; i++)
        o << x.colesterol[i].zi << "." << x.colesterol[i].luna << "." << x.colesterol[i].an << endl << x.colesterol[i].valoare << endl;

    o << "Valorile protenilelor:" << endl;
    for(int i = 0; i < x.nr_analize; i++)
        o << x.proteine[i].zi << "."  << x.proteine[i].luna << "." << x.proteine[i].an << endl << x.proteine[i].valoare << endl;

    o << "Valorile tensiunii:" << endl;
    for(int i = 0; i < x.nr_analize; i++)
        o << x.tensiune[i].zi << "." << x.tensiune[i].luna << "." << x.tensiune[i].an << endl << x.tensiune[i].valoare << endl;

    return o;
}

template <class T> class FisePacienti
{

    Pacient **p;
    static int index;
    static int nr_adulti;
    static int nr_copii;

public:

    FisePacienti()
    {

        p = NULL;
    }

    FisePacienti& operator+= (Pacient &x)
    {

        Pacient **aux;

        for(int i = 0; i < index; i++)
            aux[i] = p[i];

        aux[index] = &x;
        Pacient **a;
        aux = a;
        a = p;
        p = aux;
        delete [] aux;

        incrementare();
    }

    static void incrementare()
    {
        index ++;
    }
    static void incrementareCopii()
    {
        nr_copii ++;
    }
    static void incrementareAdulti()
    {
        nr_adulti ++;
    }

    void exceptiiClinicSanatos(Pacient &x);
    void exceptiiBoliCardioVasculare(Pacient &x);
    void exceptiiCopii(Pacient &x);

};

template <class T> int FisePacienti<T> :: index = 0;
template <class T> int FisePacienti<T> :: nr_adulti = 0;
template <class T> int FisePacienti<T> :: nr_copii = 0;

template <> void FisePacienti <int> :: exceptiiClinicSanatos(Pacient &x)
{

    try
    {

        //risc cardio-vascular
        if(2017 - x.getAn() <= 18 && x.getBoalaCardioVasculara() == true)
            throw 1;
        for(int i = 0; i < x.getNumarAnalize(); i++)
        {
            if(x.getColesterol(i) > 240)
                throw 2;
            if(x.getTensiune(i) > 139)
                throw 3;
        }
        throw 0;
    }

    catch(int x)
    {

        if(x == 0)
            cout << x;
    }
}
template <> void FisePacienti <int> :: exceptiiCopii(Pacient &x)
{

    try
    {

        if(2017 - x.getAn() <= 18 && x.getBoalaCardioVasculara() == true)
            throw 1;
    }

    catch(int x)
    {

        if(x == 1)
            cout << x;
    }
}

template <> void FisePacienti <int> :: exceptiiBoliCardioVasculare(Pacient &x)
{

    try
    {

        //adulti risc cardio-vascular
        for(int i = 0; i < x.getNumarAnalize(); i++)
        {
            if(x.getColesterol(i) > 240)
                throw 2;
            if(x.getTensiune(i) > 139)
                throw 3;
        }
        throw 0;
    }

    catch(int x)
    {

        if(x == 1)
            cout << "Pacientul este un copil cu antecedente de boli cardio-vasculare in familie" << endl;
        if(x == 2)
            cout << "Pacientul are valoarea colesterolului peste limita superioara" << endl;
        if(x == 3)
            cout << "Pacientul are tensiunea peste limita superioara" << endl;
    }
}

Pacient v[20];

int main()
{

    int n;
    cin >> n;
    FisePacienti <int> f;
    //citire pacienti
    for(int i = 0; i < n; i++)
    {
        cin >> v[i];
        f += v[i];
    }

    //afisare pacienti
    for(int i = 0; i < n; i++)
        cout << v[i];

    cout << "Alegeti o optiune: " << endl;
    cout << "1) Afisati informatiile medicale pentru toti pacientii" << endl;
    cout << "2) Afisati informatiile medicale pentru toti copiii cu factor de risc cardiovascular" << endl;
    cout << "3) Afisati informatiile adultilor clinic sanatosi" << endl;

    int x;
    cin >> x;

    switch(x)
    {

    case 1:
    {
        for(int i = 0; i < n; i++)
            cout << v[i];
        break;
    }
    case 2:
    {
        for(int i = 0; i < n; i++)
            f.exceptiiCopii(v[i]);
        break;
    }
    case 3:
    {
        for(int i = 0; i < n; i++)
            f.exceptiiBoliCardioVasculare(v[i]);
        break;
    }

    default:
        break;
    }

    return 0;
}
