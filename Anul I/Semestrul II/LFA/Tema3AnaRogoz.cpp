#include<cstdio>
#include<string.h>
#include<ctype.h>
using namespace std;

struct S
{

    char nodStare[3];
    char stari[30][30];
    int nr;
};

bool litere[30];

const int NMAX = 1000;

S v[1000];

bool AreDoarTerminale(int k)
{

    for(int i = 0; i < v[k].nr; i++)
        for(int j = 0; j < strlen(v[k].stari[i]); j++)
            if(v[k].stari[i][j] >= 'A' && v[k].stari[i][j] <= 'Z')
                return false;

    return true;
}

void Afisare(char ch, int x)
{

    printf("Y%d - ", x-1);

    if(ch >= 'a' && ch <= 'z')
        printf("%cY%d\n", ch - 'a' + 'A', x);
    else
        printf("%cY%d\n", ch, x);
}

int main()
{

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    int n, x;
    scanf("%d", &n);
    for(int i = 0; i < n; i++)
    {

        scanf("%d ", &v[i].nr);
        scanf("%s - ", &v[i].nodStare);
        for(int j = 0; j < v[i].nr; j++)
            scanf("%s ", v[i].stari[j]);
    }

    //Pasul 1 - eliminarea lambda tranzitilor

    int adaugate = 0;
    char sirAuxiliar[20], sirAuxiliar2[20];
    int poz;

    //O iau de jos in sus si caut lamda tranzitii
    for(int i = n - 1; i >= 0; i--)
    {

        //Pentru fiecare v[i] caut daca are productie lambda
        for(int j = 0; j < v[i].nr; j++)
            if(strcmp(v[i].stari[j], "0") == 0)
            {
                for(int k = v[i].nr; k > j; k--)
                    strcpy(v[i].stari[j-1], v[i].stari[j]);
                v[i].nr--;

                //am gasit lambda in productiile lui v[i] si caut starea v[i].nodStare in productiile de mai sus
                for(int k = i - 1; k >= 0; k--)
                    //pentru fiecare productie caut caracterul v[i].nodstare
                    for(int l = 0; l < v[k].nr; l++)
                    {

                        for(int d = 0; d < strlen(v[k].stari[l]); d++)
                            if(v[k].stari[l][d] == v[i].nodStare[0])
                            {
                                //am gasit nodStare in productia v[k].stari[l]

                                strcpy(sirAuxiliar, v[k].stari[l]); // retin sirul ce contine v[i].nodStare
                                //sterg din v[k] sirul v[k].stari[l]
                                for(int i1 = l + 1; i1 < v[k].nr; i1--)
                                    strcpy(v[k].stari[i1 - 1], v[k].stari[i1]);

                                //creez in sirAuxiliar2 noua varianta a lui sirAuxiliar in care inlocuiesc v[i].nodStare cu v[i].stari

                                //pentru lambda fac sirAuxiliar2
                                for(int i1 = 0; i1 < strlen(sirAuxiliar); i1++)
                                    if(sirAuxiliar[i1] == v[i].nodStare[0])
                                    {

                                        for(int i2 = i1 + 1; i2 <= strlen(sirAuxiliar); i2++)
                                            sirAuxiliar2[i2] = sirAuxiliar[i2 - 1];

                                        strcpy(v[k].stari[v[k].nr-1], sirAuxiliar2);
                                        break;
                                    }
                                    else
                                        sirAuxiliar2[i1] = sirAuxiliar[i1];

                                //adaug stari noi in care inlocuiesc v[i].nodStare[0] cu productile lui v[i]
                                for(int productie = 0; productie < v[k].nr; productie ++)
                                {
                                    for(int i1 = 0; i1 < strlen(sirAuxiliar); i1 ++)
                                        if(sirAuxiliar[i1] == v[i].nodStare[0])
                                        {

                                            //copiez productia dupa care copiez restul din sirAuxiliar
                                            for(int i2 = 1; i2 <= strlen(v[k].stari[productie]); i2 ++)
                                                sirAuxiliar2[i1 + i2] = v[k].stari[productie][i2 - 1];

                                            //copiez restul sirului sirAuxiliar
                                            poz = i1 + strlen(v[k].stari[productie]);
                                            for(int i2 = i1 + 1; i2 <= strlen(sirAuxiliar); i2++)
                                                sirAuxiliar2[poz + i2 - 1] = sirAuxiliar[poz + i2];

                                            strcpy(v[k].stari[++v[k].nr - 1], sirAuxiliar2);
                                            break;
                                        }
                                        else
                                            sirAuxiliar2[i1] = sirAuxiliar[i1];

                                }

                                break;
                            }

                    }

                //sterg v[i] si permut toate toate liniile de la i + 1 la n
                for(int k = i + 1; k < n; k++)
                {

                    v[k - 1].nodStare[0] = v[k].nodStare[0];
                    v[k - 1].nr = v[k].nr;
                    for(int l = 0; l < v[k].nr; l++)
                        strcpy(v[k - 1].stari[l], v[k].stari[l]);

                }
                n--;
                break;
            }
    }

    //Pasul 2 - elimin redemurile si inlocuiesc neterminalele cu productiile lor terminale

    for(int i = n - 1; i > 0; i--)
    {

        for(int j = 0; j < v[i].nr; j++)
            //v[i].stari[j] este un neterminal
            if(strlen(v[i].stari[j]) == 1 && v[i].stari[j][0] >= 'A' && v[i].stari[j][0] <= 'Z')
            {

                //am gasit un neterminal v[i].stari[j] si ii caut productiile
                for(int k = i + 1; k < n; k++)
                    if(v[k].nodStare[0] == v[i].stari[j][0])
                    {

                        //am gasit productiile neterminalului v[k] si le adaug in productiile lui v[i]
                        for(int d = 0; d < v[k].nr; d++)
                            strcpy(v[i].stari[v[i].nr + d], v[k].stari[d]);

                        v[i].nr += v[k].nr;

                        //sterg in intregime v[k]
                        for(int d = k + 1; d < n; d++)
                        {

                            v[d - 1].nodStare[0] = v[d].nodStare[0];
                            v[d - 1].nr = v[d].nr;

                            for(int l = 0; l < v[k].nr; l++)
                                strcpy(v[k - 1].stari[l], v[k].stari[l]);
                        }

                        n--;
                        break;
                    }

                //il sterg pe v[i].stari[j] adica pe v[k].nodStare
                for(int k = j + 1; k < v[i].nr; k++)
                    strcpy(v[i].stari[k - 1], v[i].stari[k]);
                v[i].nr--;

                break;
            }


        if(AreDoarTerminale(i) == true)
        {
            //inlocuiesc v[i].nodStare cu toate productiile sale in restul de la i - 1 la 0
            for(int k = i - 1; k >= 0; k--)
                //pentru fiecare productie caut caracterul v[i].nodstare
                for(int l = 0; l < v[k].nr; l++)
                {

                    for(int d = 0; d < strlen(v[k].stari[l]); d++)
                        if(v[k].stari[l][d] == v[i].nodStare[0])
                        {
                            //am gasit nodStare in productia v[k].stari[l]

                            // retin sirul ce contine v[i].nodStare
                            strcpy(sirAuxiliar, v[k].stari[l]);

                            //sterg din v[k] sirul v[k].stari[l]
                            for(int i1 = l + 1; i1 < v[k].nr; i1--)
                                strcpy(v[k].stari[i1 - 1], v[k].stari[i1]);

                            //creez in sirAuxiliar2 noua varianta a lui sirAuxiliar in care inlocuiesc v[i].nodStare cu v[i].stari

                            //adaug stari noi in care inlocuiesc v[i].nodStare[0] cu productile lui v[i]
                            for(int productie = 0; productie < v[k].nr; productie ++)
                            {
                                for(int i1 = 0; i1 < strlen(sirAuxiliar); i1 ++)
                                    if(sirAuxiliar[i1] == v[i].nodStare[0])
                                    {

                                        //copiez productia dupa care copiez restul din sirAuxiliar
                                        for(int i2 = 1; i2 <= strlen(v[k].stari[productie]); i2 ++)
                                            sirAuxiliar2[i1 + i2] = v[k].stari[productie][i2 - 1];

                                        //copiez restul sirului sirAuxiliar
                                        poz = i1 + strlen(v[k].stari[productie]);
                                        for(int i2 = i1 + 1; i2 <= strlen(sirAuxiliar); i2++)
                                            sirAuxiliar2[poz + i2 - 1] = sirAuxiliar[poz + i2];

                                        strcpy(v[k].stari[++v[k].nr - 1], sirAuxiliar2);
                                        break;
                                    }
                                    else
                                        sirAuxiliar2[i1] = sirAuxiliar[i1];

                            }

                            break;
                        }
                }
            n--;
        }

    }

    //Pasul 3 - fiecarui nod terminal ii asociez un neterminal

    int copie_n = n;

    for(int i = 0; i < n; i++)
        for(int j = 0; j < v[i].nr; j++)
            for(int k = 0; k < strlen(v[i].stari[j]); k++)
                if(v[i].stari[j][k] >= 'a' && v[i].stari[j][k] <= 'z' && litere[v[i].stari[j][k]] == false)
                {
                    litere[v[i].stari[j][k]] = true;
                    v[copie_n].nr = 1;
                    v[copie_n].nodStare[0] = 'X', v[copie_n].nodStare[1] = v[i].stari[j][k];
                    v[copie_n].stari[0][0] = v[i].stari[j][k];
                    printf("X%c - %c\n", v[i].stari[j][k], v[i].stari[j][k]);
                    copie_n ++;
                }

    // Pasul 4 - aduc fiecare productie la FNC

    int numar = 1;

    for(int i = 0; i < n; i++)
        for(int j = 0; j < v[i].nr; j ++)
        {

            //exceptie pentru prima afisare deoarece voi avea format v[i].nodStare - XX
            printf("%c - ", v[i].nodStare[0]);
            if(v[i].stari[j][0] >= 'a' && v[i].stari[j][0] <= 'z')
                printf("X%cY%d\n", v[i].stari[j][0], numar);
            else
                printf("%cY%d\n", v[i].stari[j][0], numar);

            numar ++;

            //afisez restul, mai putin ultimele doua caractere v[i].stari[j]
            for(int k = 1; k < strlen(v[i].stari[j]) - 2; k ++)
                Afisare(v[i].stari[j][k], numar), numar ++, x = k;

            //exceptie pentru ultimele 2 caractere

            //1) doua terminale
            if(islower(v[i].stari[j][x]) && islower(v[i].stari[j][x + 1]))
                printf("Y%d - X%cX%c\n", numar, v[i].stari[j][x], v[i].stari[j][x + 1]);
            else //2) primul e terminal si al doilea e neterminal
                if(islower(v[i].stari[j][x]) && !islower(v[i].stari[j][x + 1]))
                    printf("Y%d - X%c%c\n", numar, v[i].stari[j][x], v[i].stari[j][x +1]);
                else //3) primul e neterminal si al doilea e terminal
                    if(!islower(v[i].stari[j][x]) && islower(v[i].stari[j][x + 1]))
                        printf("Y%d - %cX%c\n", numar, v[i].stari[j][x], v[i].stari[j][x + 1]);
                    else //4) doua neterminale
                        if(!islower(v[i].stari[j][x]) && !islower(v[i].stari[j][x + 1]))
                            printf("Y%d - %c%c\n", numar, v[i].stari[j][x], v[i].stari[j][x + 1]);
            numar ++;
        }

    return 0;
}
