#include<stdio.h>
#define NMAX 1000
#define eps 0.0001

/* Declar grid-ul curent si grid-ul pentru urmatoarea generatie de tip _Bool deoarece acestea contin doar 0 si 1
   dx respectiv dy sunt vectori de pozitii ce acceseaza toti cei 8 vecini ai unui element de pe pozitiile N, NE, E, SE, S, SV, V, NV*/
_Bool grid_current[NMAX + 1][NMAX + 1], grid_next[NMAX + 1][NMAX + 1];
int dx[] = {0, -1, -1, 0, 1, 1, 1, 0, -1}, dy[] = {0, 0, 1, 1, 1, 0, -1, -1, -1};
int n, m, k, number_cells, val;
char tip;

// Utilizand vectorii de pozitii numar cei 8 posibili vecini ai elementului de pe (i,j)
int countNeighbors(int i, int j) {

    int newx, newy, no = 0;
    for(int d = 1; d <= 8; d++) {
        newx = i + dx[d];
        newy = j + dy[d];
        if(tip == 'T') {
            if(newx == 0)
                newx = n;
            else
            if(newx == n + 1)
                newx = 1;

            if(newy == 0)
                newy = m;
            else
            if(newy == m + 1)
                newy = 1;
        }
        no += grid_current[newx][newy];
    }
   return no;
}

//Setez celula (i,j) in generatia urmatoare in functie de numarul de vecini
void setCell(int i, int j, int nb) {

    if(grid_current[i][j] == 1 && nb < 2)
        grid_next[i][j] = 0;
    else
    if(grid_current[i][j] == 1 && nb > 3)
        grid_next[i][j] = 0;
    else
    if(grid_current[i][j] == 0 && nb == 3)
        grid_next[i][j] = 1;
    else
        grid_next[i][j] = grid_current[i][j];
}

//Calculez urmatoarea generatie si numar celulele in viata din generatia curenta
void nextGeneration() {

    for(int i = 1; i <= n; i ++)
        for(int j = 1; j <= m; j ++) {
            if(grid_current[i][j] == 1)
                    number_cells ++;
        grid_current[i][j] = grid_next[i][j];
    }
}

//Citesc gridul
void Read() {

    for(int i = 1; i <= n; i ++)
        for(int j = 1; j <= m; j ++) {
            scanf("%d", &val);
            if(val == 1)
                grid_current[i][j] = 1;
        }
}

//Afisez gridul
void Write() {

    for(int i = 1; i <= n; i ++) {
        for(int j = 1; j <= m; j ++)
            if(grid_current[i][j] == 1)
                printf("1 ");
            else
                printf("0 ");
        printf("\n");
    }
}

void Solve() {

    int generation = 1, number_neighbors;
    double percentage = 0, max_percentage = 0, total_cells;

    scanf("%d%d%d", &m, &n, &k);

    // Citesc gridul
    Read();
    total_cells = m * n;

    int newx, newy;
    // Simulez cei k pasi
    while(generation <= k) {

        number_cells = 0;

        // Construiesc in grid_next urmatoarea generatie in functie de regulile jocului
        for(int i = 1; i <= n; i ++)
            for(int j = 1; j <= m; j ++) {
                number_neighbors = countNeighbors(i, j);
                setCell(i, j, number_neighbors);
            }

        /*Copiez in grid_current valorile din grid_next pentru a putea simula urmatoarea generatie
          De asemenea, calculez si procentul generatiei actuale*/

        nextGeneration();
        percentage = number_cells * 100 / total_cells;

        //Compar procentul maxim existent cu procentul actual cu o precizie de 3 zecimale
        if(max_percentage - percentage < -eps)
            max_percentage = percentage;

        generation ++;
    }

    //Afisez grid-ul dupa cei k pasi
    Write();

    printf("%.3lf% \n", max_percentage);
}

int main() {

    freopen("date.in", "r", stdin);

    scanf("%c", &tip);
    Solve();

    return 0;
}
