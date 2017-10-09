#include<iostream>
#include<string.h>
#include<fstream>

using namespace std;

ifstream in ("date.in");

class Baza
{

public:

    virtual int calculPret() = 0;
};

class Ingrediente
{

    char *nume;
    int pret_unitar, cantitate;

public:

    Ingrediente ()
    {

        nume = new char[100];
        pret_unitar = 0;
        cantitate ++;
    }

    Ingrediente(char *n, int p, int c) : pret_unitar(p), cantitate(c)
    {

        nume = new char[strlen(n) + 3];
        strcpy(nume, n);
    }


    Ingrediente& operator= (Ingrediente &b)
    {

        nume = new char[20];
        strcpy(nume, b.nume);
        cantitate = b.cantitate;
        pret_unitar = b.pret_unitar;
        cantitate = b.cantitate;

        return *this;
    }

    int getPretUnitar ()
    {
        return pret_unitar;
    }
    int getCantitate ()
    {
        return cantitate;
    }
    char* getNume()
    {
        return nume;
    }

    friend ifstream& operator>> (ifstream& i, Ingrediente &x);
    friend ostream& operator<< (ostream& o, Ingrediente &y);

};


ifstream& operator>> (ifstream& i, Ingrediente &x)
{

    i >> x.nume;
    i>> x.pret_unitar;
    i >> x.cantitate;

    return i;
}


ostream& operator<< (ostream& o, Ingrediente &y)
{

    o<<y.nume;
    o<<y.cantitate << " ";
    o<<y.pret_unitar << endl;

    return o;
}

class Pizza : public Baza
{

protected:

    Ingrediente *v;

    int numar_ingrediente;

public:

    Pizza()
    {

        v = new Ingrediente[100];
        numar_ingrediente = 0;
    }

    Pizza (Ingrediente *x, int numar)
    {

        numar_ingrediente = numar;
        v = new Ingrediente[numar + 2];
        for(int i = 0; i < numar; i++)
            v[i] = x[i];

    }

    Pizza& operator= (Pizza Peeeetza)
    {

        numar_ingrediente = Peeeetza.getNumarIngrediente();

        for(int i = 0; i < numar_ingrediente; i++)
            v[i] = Peeeetza.v[i];

        return *this;
    }

    int getNumarIngrediente()
    {
        return numar_ingrediente;
    }
    void setNumarIngrediente(int x)
    {
        numar_ingrediente = x;
    }
    char* getIngredient(int j)
    {
        return v[j].getNume();
    }
    int getCantitate(int j)
    {
        return v[j].getCantitate();
    }
    int getPretUnitar(int j)
    {
        return v[j].getPretUnitar();
    }

    int calculPret()
    {

        int s = 0;

        for(int i = 0; i < numar_ingrediente; i++)
            s += v[i].getPretUnitar() * v[i].getCantitate();

        return s;
    }

    friend ifstream& operator>> (ifstream &i, Pizza pizzaa);
    friend ostream& operator<< (ostream &o, Pizza pizzza);

};

ifstream& operator>> (ifstream &i, Pizza pizzaa)
{

    i >> pizzaa.numar_ingrediente;


    for(int j = 0; j < pizzaa.numar_ingrediente; j++)
        i >> pizzaa.v[j];

    return i;
}

ostream& operator<< (ostream &o, Pizza pizzaa)
{

    o << pizzaa.numar_ingrediente << endl;

    for(int j = 0; j < pizzaa.numar_ingrediente; j++)
        o << pizzaa.v[j] << " ";

    o << endl;
    return o;
}

class PizzaOnline : public Pizza
{

    int distanta;

public:

    PizzaOnline()
    {

        Pizza();
        distanta = 0;

    }

    PizzaOnline(Ingrediente *x, int numar, int dist)
    {

        Pizza(x, numar);
        distanta = dist;
    }


    PizzaOnline& operator= (PizzaOnline Peeeetza)
    {


        numar_ingrediente = Peeeetza.numar_ingrediente;

        for(int i = 0; i < getNumarIngrediente(); i++)
            v[i] = Peeeetza.v[i];

        distanta = Peeeetza.distanta;

        return *this;
    }

    void setDistanta(int x)
    {
        distanta = x;
    }

    friend ifstream& operator>> (ifstream &i, PizzaOnline pizzzaa);
    friend ostream& operator<< (ostream &o, PizzaOnline pizzzaa);

    int calculPret()
    {

        int s = 0;

        for(int i = 0; i < numar_ingrediente; i++)
            s += v[i].getPretUnitar() * v[i].getCantitate();

        int km_plus = distanta / 10;

        s += (s * 5 * km_plus) / 100 ;

        return s;


    }
};

ifstream& operator>> (ifstream &i, PizzaOnline pizzaa)
{

    i >> pizzaa.numar_ingrediente;

    for(int j = 0; j < pizzaa.numar_ingrediente; j++)
        i >> pizzaa.v[j];

    i >> pizzaa.distanta;

    return i;

}

ostream& operator<< (ostream &o, PizzaOnline pizzaa)
{

    o << pizzaa.numar_ingrediente << endl;

    for(int j = 0; j < pizzaa.numar_ingrediente; j++)
        o << pizzaa.v[j] << " ";

    o << endl << pizzaa.distanta << endl;

    return o;

}

template <class T> class Meniu
{

    Pizza **t;

    static int index;

public:

    Meniu operator += (Pizza& x)
    {

        Pizza **aux;
        aux = new Pizza* [index + 2];
        for(int i = 0; i < index; i++)
            aux[i] = t[i];

        aux[index] = &x;
        Pizza **a;
        a = aux;
        aux = t;
        t = a;

        incrementare();
    }

    static void incrementare()
    {
        index ++;
    }

    int vegetariana()
    {

        int suma_veg = 0;
        bool ok;
        for(int i = 0; i < index; i++)
        {
            ok = true;
            for(int j = 0; j < t[i]->getNumarIngrediente(); j ++)
                if(strcmp(t[i]->getIngredient(j), "carne") == 0)
                {
                    ok = false;
                    break;
                }
            if(ok == true)
                suma_veg += t[i]->calculPret();
        }
        return suma_veg;
    }

    void exceptie(Pizza a);


};

template <class T> int Meniu <T> :: index = 0;

template <> void Meniu<int>:: exceptie(Pizza a)
{

    try
    {

        for(int i = 0; i < a.getNumarIngrediente(); i++)
        {
            if(a.getCantitate(i) < 0)
                throw 2;
            if(a.getPretUnitar(i) < 0)
                throw 3;
        }

        if(a.calculPret() < 0)
            throw 1;
    }

    catch (int x)
    {

        if(x == 1)
            cout << "Pizza data are pretul negativ. \n";
        if(x == 2)
            cout << "Pizza data are o un ingredient cu o cantitate negativa. \n";
        if(x == 3)
            cout << "Pizza data are un ingredient cu un pret negativ. \n";

    }

}

int main()
{

    Ingrediente ing1("sunca", 2, 4), ing2("cascaval", 1, 5);

    Ingrediente ing3[20], ing4[20];
    int n, m;
    in >> n;
    char nume[20];
    int cant, pr;

    for(int i = 0; i < n; i++)
        in >> ing3[i];

    in >> m;
    for(int i = 0; i < m; i++)
        in >> ing4[i];

    Pizza x(ing3, n), y(ing4, m);

    Meniu <int> menu;

    menu += x;

    menu += y;

    Pizza pizzzaa;
    pizzzaa = x;

    PizzaOnline pizzaaOnline = static_cast<PizzaOnline&>(pizzzaa);

    pizzaaOnline.setDistanta(2);

    menu += pizzaaOnline;

    menu.exceptie(y);

    cout << menu.vegetariana();

    return 0;
}
