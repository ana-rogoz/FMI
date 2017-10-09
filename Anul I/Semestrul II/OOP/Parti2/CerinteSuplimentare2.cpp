#include<fstream>
#include<iostream>
#include<string.h>

using namespace std;

ifstream in("date.in");

class Farmacie_abstracta {

public:

    virtual double calcul_venit() = 0;

};

class Farmacie: public Farmacie_abstracta {

    private: int nr_angajati;

    protected:
        char *nume;
        int nr_luni;
        double *cifra_afaceri_luna;

    public:

    Farmacie () {

        nume = new char[100];
        nr_luni = 0;
        cifra_afaceri_luna = 0;
    }

    Farmacie(char *s, int x, double *cif) {

        int n = strlen(s);
        nume = new char[n + 2];
        nr_luni = x;
        cifra_afaceri_luna = new double[nr_luni + 2];

        for(int i = 0; i < n; i++)
            nume[i] = s[i];
        for(int i = 0; i < nr_luni; i++)
            cifra_afaceri_luna[i] = cif[i];
    }
    Farmacie(Farmacie& x) {
        strcpy(nume, x.getnume());
        nr_luni = x.getnr_luni();
        double *aux = new double[100];
        aux = x.getcifra_afaceri_luna();
        for(int i = 0; i < nr_luni; i++)
            cifra_afaceri_luna[i] = aux[i];
    }

    int getnr_luni() {
        return nr_luni;
    }

    double* getcifra_afaceri_luna() {
        return cifra_afaceri_luna;
    }

    char* getnume() {
        return nume;
    }

    virtual void Afisare() {
        cout<<nume<<" "<<nr_luni<<"\n";
        for(int i = 0; i < nr_luni; i++)
            cout<<cifra_afaceri_luna[i]<<" ";
    };

    Farmacie& operator= (Farmacie& x) {
        nr_luni = x.getnr_luni();
        delete [] nume;
        delete [] cifra_afaceri_luna;
        double *aux1;
        aux1 = new double[100];
        aux1 = x.getcifra_afaceri_luna();
        char *aux2;
        aux2 = new char[100];
        aux2 = x.getnume();
        nume = new char[100];
        cifra_afaceri_luna = new double [nr_luni + 2];
        nume = new char[strlen(aux2) + 2];
        for(int i = 0; i < strlen(aux2); i++)
            nume[i] = aux2[i];
        for(int i = 0; i < nr_luni; i++)
            cifra_afaceri_luna[i] = aux1[i];

        return *this;
    }

    double calcul_venit() {
        double suma = 0;
        for(int i = 0; i < nr_luni; i++)
            suma = suma + cifra_afaceri_luna[i];
        return suma;
    }

    friend ifstream& operator>> (ifstream& i, Farmacie &x);
    friend ostream& operator<< (ostream& o, Farmacie &x);

    ~Farmacie() {
        nr_luni = 0;
        delete [] nume;
        delete [] cifra_afaceri_luna;
    }
};

ifstream& operator>> (ifstream& i, Farmacie &x) {
    delete [] x.nume;
    x.nume = new char[100];
    i>>x.nume;
    i>>x.nr_luni;
    x.cifra_afaceri_luna = new double [x.nr_luni + 2];
    for(int j = 0; j < x.nr_luni; j++)
        i>>x.cifra_afaceri_luna[j];

    return i;
}

ostream& operator<< (ostream& o, Farmacie &x) {

    o<<x.nume<<"\n";
    o<<x.nr_luni<<"\n";
    for(int i = 0; i < x.nr_luni; i++)
        o<<x.cifra_afaceri_luna[i]<<" ";

    return o;
}

class Farmacie_online: public Farmacie {

    char *adresa_web;
    int nr_vizitatori;
    float discount;

public:

    Farmacie_online():Farmacie() {
        adresa_web = new char[100];
        nr_vizitatori = 0;
        discount = 0;
    }

    Farmacie_online(char s[], int aux_vizitatori, float disc, char *nume_aux, int x, double *cif) {

        int n = strlen(s);
        adresa_web = new char[n + 2];
        strcpy(adresa_web, s);

        nr_vizitatori = aux_vizitatori;
        discount = disc;
        int m = strlen(nume_aux);
        nume = new char[m+2];
        strcpy(nume, nume_aux);
        nr_luni = x;
        for(int i = 0; i < nr_luni; i++)
            cifra_afaceri_luna[i] = cif[i];
    }

    double calcul_venit() {

        double suma = 0;
        for(int i = 0; i < nr_luni; i++)
            suma = suma + cifra_afaceri_luna[i];

        suma = suma - nr_luni*discount;
        return suma;

    }

    int getDiscount() {
        return discount;
    }

    char* getadresa_web() {
        return adresa_web;
    }
    Farmacie_online operator= (Farmacie_online &x){

        nr_luni = x.getnr_luni();
        delete [] nume;
        delete [] cifra_afaceri_luna;
        delete [] adresa_web;
        double *aux1;
        aux1 = new double[100];
        aux1 = x.getcifra_afaceri_luna();
        cifra_afaceri_luna = new double[nr_luni + 2];
        char *aux2;
        aux2 = new char[100];
        aux2 = x.getnume();
        nume = new char[strlen(aux2) + 2];

        for(int i = 0; i < strlen(aux2); i++)
            nume[i] = aux2[i];
        for(int i = 0; i < nr_luni; i++)
            cifra_afaceri_luna[i] = aux1[i];
        adresa_web = new char[strlen(x.getadresa_web()) + 2];
        strcpy(adresa_web, x.getadresa_web());
        discount = x.getDiscount();
    }

    friend ifstream& operator>> (ifstream& i, Farmacie_online &x);
    friend ostream& operator<< (ostream& o, Farmacie_online &x);

    ~Farmacie_online() {
        delete[] adresa_web;
    }
};

ifstream& operator>> (ifstream& i, Farmacie_online &x) {

    delete [] x.nume;
    x.nume = new char[100];
    i>>x.nume;
    i>>x.nr_luni;
    for(int j = 0; j < x.nr_luni; j++)
        i>>x.cifra_afaceri_luna[j];

    i>>x.adresa_web;
    i>>x.nr_vizitatori;
    i>>x.discount;

    return i;
}

ostream& operator<< (ostream& o, Farmacie_online &x) {

    o<<x.nume<<"\n";
    o<<x.nr_luni<<"\n";
    for(int i = 0; i < x.nr_luni; i++)
        o<<x.cifra_afaceri_luna[i]<<" ";

    o<<"\n";
    o<<x.adresa_web<<"\n";
    o<<x.nr_vizitatori<<"\n";
    o<<x.discount<<"\n";

    return o;
}

int main() {

    Farmacie a, b;
    in>>a;
    in>>b;
    a = b;

    cout<<a;

    Farmacie_online c, d;

    Farmacie_abstracta *v;
    int n;
    in>>n;

    return 0;
}
