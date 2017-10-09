#include<fstream>
#include<iostream>
#include<vector>
#include<queue>
using namespace std;

const int NMAX = 1000;

ifstream in("date.in");
ofstream out("date.out");

int h_max, n;

class Node
{

    int value, noVecini;
    vector <int> vecini;
    bool viz;

public:

    Node (int x = 0)
    {
        value = x;
        noVecini = 0;
        new vector<int>();
        viz = false;
    }

    void setValue(int x)
    {
        value = x;
    }

    void setViz(bool x = false)
    {
        viz = x;
    }

    int getValue()
    {
        return value;
    }

    void addSon(int x)
    {
        vecini.push_back(x);
        noVecini++;
    }

    int getnoVecini()
    {
        return noVecini;
    }

    bool getViz()
    {
        return viz;
    }

    int dfs(int l);

    int bfs();

    Node operator = (Node a);

    ~Node()
    {
        vecini.erase(vecini.begin(), vecini.end());
        value = noVecini = 0;
        viz = false;
    }

    friend void resetViz();
};

Node arbore[NMAX];

Node Node :: operator = (Node a)
{
    value = a.value;
    noVecini = a.noVecini;
    vecini.resize(noVecini);
    for(int i = 0; i < a.noVecini; i++)
        vecini[i] = a.vecini[i];
    viz = a.viz;
    return *this;
}

int Node :: dfs(int l)
{
    if(l > h_max)  h_max = l;

    if(l == 1)
        out << "Parcurgerea in adancime a arborelui: ";

    viz = true;
    out << value <<" ";

    for(int i = 0; i < noVecini; i++)
    {
        if(arbore[vecini[i]].getViz() == false)
            arbore[vecini[i]].dfs(l + 1);
    }
    return 0;
}

queue <Node> q;

int Node :: bfs()
{
    out << "Parcurgerea in latime a arborelui: ";
    Node nod_curent, nod_urmator;

    viz = true;
    q.push(*this);

    while(!q.empty())
    {
        nod_curent = q.front();
        for(int i = 0; i < nod_curent.getnoVecini(); i++)
        {
            nod_urmator = arbore[nod_curent.vecini[i]];
            if(nod_urmator.getViz() == false)
            {
                arbore[nod_urmator.getValue()].setViz(true);
                q.push(nod_urmator);
            }
        }
        q.pop();
        out << nod_curent.getValue() << " ";
    }
    out << "\n";
    return 0;
}

int numarFrunze()
{
    int nr_frunze = 0;

    for(int i = 1; i <= n; i++)
        if(arbore[i].getnoVecini() == 1)
            nr_frunze++;

    return nr_frunze;
}

void setValues()
{
    for(int i = 1; i <= n; i++)
        arbore[i].setValue(i);
}

void resetViz()
{
    for(int i = 1; i <= n; i++)
        arbore[i].setViz(false);
}

void citire(int &x)
{
    int m, y;

    in >> n >> m;
    setValues();

    for(int i = 0; i < m; i++)
    {
        in >> x >> y;
        arbore[x].addSon(y);
        arbore[y].addSon(x);
    }

    in >> x;
}

void rezolvare(int x)
{
    arbore[x].dfs(1);
    out << "\n";
    resetViz();
    arbore[x].bfs();
    out << "Inaltimea arborelui este " << h_max <<"\n";
    if(arbore[x].getnoVecini() == 1)
        out << "Numarul de frunze al arborelui este " << numarFrunze() - 1 <<"\n";
    else
        out << "Numarul de frunze al arborelui este " << numarFrunze() <<"\n";
}

int main()
{
    int x;

    citire(x);
    rezolvare(x);

    return 0;
}
