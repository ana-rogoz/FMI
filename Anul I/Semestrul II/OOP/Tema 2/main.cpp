#include<fstream>
#include<stdarg.h>
#include<iostream>
#include<math.h>
using namespace std;

class Vector
{

    int dim;
    int *a;

public:

    Vector()
    {
        dim = 0;
        a = new int[100];
    }

    Vector(int x)
    {
        a = new int[x + 2];
    }

    Vector(int x, ...)
    {
        dim = x;
        a = new int[dim + 1];
        va_list lista;
        va_start(lista, x);
        int elem;
        for(int i = 0; i < x; i++)
        {
            elem = va_arg(lista, int);
            a[i] = elem;
        }
    }

    void setVector(int x,...)
    {
        dim = x;
        delete [] a;
        a = new int [dim + 1];
        va_list lista;
        va_start(lista, x);
        int elem;
        for(int i = 0; i < x; i++)
        {
            elem = va_arg(lista, int);
            a[i] = elem;
        }
    }

    void setDim(int n)
    {
        dim = n;
    }

    int getDim()
    {
        return dim;
    }

    int* getVector()
    {
        return a;
    }

    Vector& operator= (Vector &b)
    {
        dim = b.getDim();
        a = new int[dim + 2];
        for(int i = 0; i < dim; i ++)
            a[i] = b.a[i];

        return *this;
    }

    friend istream& operator>> (istream& i, Vector &x);
    friend ostream& operator<< (ostream& o, Vector &x);

    int& operator[] (int x)
    {
        return a[x];
    }

    ~Vector()
    {
        dim = 0;
        delete [] a;
    }
};

istream& operator>> (istream& i, Vector &x)
{

    delete [] x.a;
    int n;
    i >> n;
    x.setDim(n);
    x.a = new int[n + 1];

    for(int i = 0; i < x.dim; i++)
        i >> x.a[i];

    return i;
}

ostream& operator<< (ostream& o, Vector &x)
{

    o << x.getDim();
    o << "\n";

    for(int i = 0; i < x.getDim(); i++)
        o << x.a[i] << " ";
    o<<"\n";

    return o;
}

class Matrice
{

protected:
    Vector *v;

public:

    Matrice()
    {
        v = new Vector[100];
    }

    Matrice(Matrice& x)
    {
        int m = x[0].getDim();
        int n = x.getLin();

        v = new Vector[max(n, m) + 1];

        for(int i = 0; i < n; i++)
            for(int j = 0; j < m; j ++)
                v[i][j] = x[i][j];
    }

    virtual bool matriceDiagonala() {};
    virtual int determinant() {};
    virtual int getLin() {};

    Vector& operator[] (int x)
    {
        return v[x];
    }

    friend istream& operator>> (istream& i, Matrice &x);
    friend ostream& operator<< (ostream& o, Matrice &x);

    ~Matrice()
    {
        delete [] v;
    }
};

istream& operator>> (istream& i, Matrice &x)
{

    int n, m;
    i >> n >> m;
    for(int i = 0; i < n; i ++)
        for(int j = 0; j < m; j++)
            i >> x[i][j];

    return i;
}

ostream& operator<< (ostream& o, Matrice &x)
{

    int n = x.getLin();
    int m = x[0].getDim();

    o << n << " " << m << "\n";

    for(int i = 0; i < n; i ++)
    {
        for(int j = 0; j < m; j++)
            o << (x[i])[j]<< " ";
        o << "\n";
    }

    return o;
}

class Matrice_oarecare: public Matrice
{

    int lin;

public:

    Matrice_oarecare()
    {
        v = new Vector[100];
    }

    Matrice_oarecare(int x)
    {
        lin = x;
        Matrice(v);
    }

    int getLin()
    {
        return lin;
    }
};

class Matrice_patratica: public Matrice
{
    int dim;

public:

    Matrice_patratica()
    {
        Matrice();
    }

    Matrice_patratica(int x)
    {
        dim = x;
        Matrice(v);
    }

    int getLin()
    {
        return dim;
    }

    void setDim(int x)
    {
        dim = x;
    }

    bool matriceDiagonala()
    {

        for(int i = 0; i < dim; i++)
            for(int j = 0; j < dim; j++)
                if((i == j && v[i][j] == 0) || (i != j && v[i][j] != 0))
                    return false;

        return true;
    }

    int determinant()
    {
        int det = 0, p, h, k, i, j;
        Matrice_patratica temp(dim);

        if(dim == 1)
        {
            return v[0][0];
        }
        else
            if(dim == 2)
            {
                det = (v[0][0] * v[1][1] - v[0][1] * v[1][0]);
                return det;
            }
            else
            {
                for(p = 0; p < dim; p++)
                {
                    h = 0;
                    k = 0;
                    for(i = 1; i < dim; i++)
                    {
                        for(j = 0; j < dim; j++)
                        {
                            if(j==p)
                            {
                                continue;
                            }
                            temp[h][k] = v[i][j];
                            k++;

                            if(k == dim-1)
                            {
                                h++;
                                k = 0;
                            }
                        }
                    }
                    temp.setDim(dim - 1);
                    det = det + v[0][p] * pow(-1,p) * temp.determinant();
                }
                return det;
            }
    }

};

int main()
{

    Vector a(4, 1, 6, 4, 5), b(4, 1, 3, 2, 4), c(4, 1, 2, 0, 8), d(4, 2, 8, 5, 1), e;

    cout << a;
    Matrice_oarecare m(2);
    m[0] = a;
    m[1] = b;
    cout << a;
    cout << m;
    Matrice_patratica m2(4);
    m2[0] = a;
    m2[1] = b;
    m2[2] = c;
    m2[3] = d;

    Matrice m1(m2);
    cout <<m2;
    cout<<m2.matriceDiagonala()<<"\n";
    cout << m2.determinant();

    return 0;
}
