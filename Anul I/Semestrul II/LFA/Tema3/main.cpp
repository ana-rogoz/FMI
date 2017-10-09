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
        printf("X%cY%d\n", ch, x);
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
    int copie_n;

    //O iau de jos in sus si caut lamda tranzitii
    for(int i = n - 1; i >= 0; i--)
    {

        //Pentru fiecare v[i] caut daca are productie lambda
        for(int j = 0; j < v[i].nr; j++)
            if(strcmp(v[i].stari[j], "0") == 0)
            {
                for(int k = v[i].nr - 1; k > j; k--)
                    strcpy(v[i].stari[j-1], v[i].stari[j]);
                v[i].nr--;

                //am gasit lambda in productiile lui v[i] si caut starea v[i].nodStare in productiile de mai sus
                for(int k = i - 1; k >= 0; k--) {
                    //pentru fiecare productie caut caracterul v[i].nodstare
                    copie_n = v[k].nr;
                    for(int l = 0; l < v[k].nr; l++)
                    {

                        for(int d = 0; d < strlen(v[k].stari[l]); d++)
                            if(v[k].stari[l][d] == v[i].nodStare[0])
                            {
                                //am gasit nodStare in productia v[k].stari[l]

                                strcpy(sirAuxiliar, v[k].stari[l]); // retin sirul ce contine v[i].nodStare
                                //sterg din v[k] sirul v[k].stari[l]
                                for(int i1 = l + 1; i1 < v[k].nr; i1 ++)
                                    strcpy(v[k].stari[i1 - 1], v[k].stari[i1]);

                                //creez in sirAuxiliar2 noua varianta a lui sirAuxiliar in care inlocuiesc v[i].nodStare cu v[i].stari

                                //pentru lambda fac sirAuxiliar2
                                for(int i1 = 0; i1 < strlen(sirAuxiliar); i1++)
                                    if(sirAuxiliar[i1] == v[i].nodStare[0])
                                    {

                                        for(int i2 = i1 + 1; i2 <= strlen(sirAuxiliar); i2++)
                                            sirAuxiliar2[i2 - 1] = sirAuxiliar[i2];

                                        strcpy(v[k].stari[v[k].nr-1], sirAuxiliar2);
                                        break;
                                    }
                                    else
                                        sirAuxiliar2[i1] = sirAuxiliar[i1];

                                if(v[i].nr > 0)
                                    strcpy(v[k].stari[copie_n], sirAuxiliar), copie_n ++;
                                l--;
                                break;
                            }

                    }
                    v[k].nr = copie_n;
                }

                //sterg v[i] si permut toate toate liniile de la i + 1 la n
                if(v[i].nr == 0) {

                    for(int k = i + 1; k < n; k++)
                    {

                        v[k - 1].nodStare[0] = v[k].nodStare[0];
                        v[k - 1].nr = v[k].nr;
                        for(int l = 0; l < v[k].nr; l++)
                            strcpy(v[k - 1].stari[l], v[k].stari[l]);

                    }
                    n--;
                }
                 break;
            }
    }

    printf("In urma pasului 1: \n");

    for(int i = 0; i < n; i++) {

        printf("%c - ", v[i].nodStare[0]);
        for(int j = 0; j < v[i].nr; j++)
            printf("%s | ", v[i].stari[j]);

        printf("\n");
    }

    //Pasul 2 - elimin redemurile si inlocuiesc neterminalele cu productiile lor terminale

    int indice_auxiliar1, indice_auxiliar2;
    bool ok;

    for(int i = n - 1; i > 0; i--)
    {
        ok = false;
        for(int j = 0; j < v[i].nr; j++)
            //v[i].stari[j] este un neterminal
            if(strlen(v[i].stari[j]) == 1 && v[i].stari[j][0] >= 'A' && v[i].stari[j][0] <= 'Z')
            {

                //am gasit un neterminal v[i].stari[j] si ii caut productiile
                for(int k = n - 1; k > 0; k--)
                    if(v[k].nodStare[0] == v[i].stari[j][0])
                    {

                        //am gasit productiile neterminalului v[k] si le adaug in productiile lui v[i]
                        for(int d = 0; d < v[k].nr; d++)
                            strcpy(v[i].stari[v[i].nr + d], v[k].stari[d]);

                        v[i].nr += v[k].nr;
                        //il sterg pe v[i].stari[j] adica pe v[k].nodStare
                        for(int d = j + 1; d < v[i].nr; d++)
                            strcpy(v[i].stari[d - 1], v[i].stari[d]);
                        v[i].nr--;

                        //sterg in intregime v[k]
                        for(int d = k + 1; d < n; d++)
                        {

                            v[d - 1].nodStare[0] = v[d].nodStare[0];
                            v[d - 1].nr = v[d].nr;

                            for(int l = 0; l < v[k].nr; l++)
                                strcpy(v[k - 1].stari[l], v[k].stari[l]);
                        }

                        ok = true;
                        n--;
                        break;
                    }

                break;
            }


        if(AreDoarTerminale(i) == true)
        {
            //inlocuiesc v[i].nodStare cu toate productiile sale in restul de la i - 1 la 0
            for(int k = i - 1; k >= 0; k--) {
                //pentru fiecare productie caut caracterul v[i].nodstare
                copie_n = v[k].nr;
                for(int l = 0; l < v[k].nr; l++)
                {

                    for(int d = 0; d < strlen(v[k].stari[l]); d++)
                        if(v[k].stari[l][d] == v[i].nodStare[0])
                        {
                            //am gasit nodStare in productia v[k].stari[l]

                            // retin sirul ce contine v[i].nodStare
                            strcpy(sirAuxiliar, v[k].stari[l]);

                            //sterg din v[k] sirul v[k].stari[l]
                            for(int i1 = l + 1; i1 < copie_n; i1++)
                                strcpy(v[k].stari[i1 - 1], v[k].stari[i1]);

                            copie_n--;

                            //creez in sirAuxiliar2 noua varianta a lui sirAuxiliar in care inlocuiesc v[i].nodStare cu v[i].stari

                            //adaug stari noi in care inlocuiesc v[i].nodStare[0] cu productile lui v[i]
                            for(int productie = 0; productie < v[i].nr; productie ++)
                            {
                                for(int i1 = 0; i1 < d; i1 ++)
                                    sirAuxiliar2[i1] = sirAuxiliar[i1];

                                for(int i1 = 0; i1 <= strlen(v[i].stari[productie]); i1++)
                                    sirAuxiliar2[i1 + d] = v[i].stari[productie][i1];

                                indice_auxiliar1 = d + 1;
                                indice_auxiliar2 = d + strlen(v[i].stari[productie]);
                                for(int i1 = 0; i1 + indice_auxiliar1 <= strlen(sirAuxiliar); i1++)
                                    sirAuxiliar2[indice_auxiliar2 + i1] = sirAuxiliar[indice_auxiliar1 + i1];

                                strcpy(v[k].stari[copie_n], sirAuxiliar2);
                                copie_n ++;
                            }
                            l--;
                            break;
                        }
                }
                v[k].nr = copie_n;
            }

              //sterg nodul ce are doar terminale
                    for(int k = i + 1; k < n; k++)
                    {

                        v[k - 1].nodStare[0] = v[k].nodStare[0];
                        v[k - 1].nr = v[k].nr;
                        for(int l = 0; l < v[k].nr; l++)
                            strcpy(v[k - 1].stari[l], v[k].stari[l]);

                    }
                    if(ok == true)
                        i--;
                    n--;

        }

    }


    printf("\nIn urma pasului 2: \n");

    for(int i = 0; i < n; i++) {

        printf("%c - ", v[i].nodStare[0]);
        for(int j = 0; j < v[i].nr; j++)
            printf("%s | ", v[i].stari[j]);

        printf("\n");
    }


    //Pasul 3 - fiecarui nod terminal ii asociez un neterminal

    printf("\nIn urma pasului 3: \n");
    copie_n = n;

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

    printf("\nIn urma pasului 4:");

    for(int i = 0; i < n; i++)
        for(int j = 0; j < v[i].nr; j ++)
        {
            printf("\n");

            if(strlen(v[i].stari[j]) == 1)
            {
                printf("%c - %c\n", v[i].nodStare[0], v[i].stari[j][0]);
                continue;
            }

            if(strlen(v[i].stari[j]) == 2)
            {
                printf("%c - X%cX%c\n", v[i].nodStare[0], v[i].stari[j][0], v[i].stari[j][1]);
                continue;
            }
            //exceptie pentru prima afisare deoarece voi avea format v[i].nodStare - XX
            printf("%c - ", v[i].nodStare[0]);
            if(v[i].stari[j][0] >= 'a' && v[i].stari[j][0] <= 'z')
                printf("X%cY%d\n", v[i].stari[j][0], numar);
            else
                printf("%cY%d\n", v[i].stari[j][0], numar);

            copie_n = strlen(v[i].stari[j]) - 2;

            //afisez restul, mai putin ultimele doua caractere v[i].stari[j]
            for(int d = 1; d < copie_n; d ++) {
                numar ++;
                Afisare(v[i].stari[j][d], numar);
                x = d;
            }
            //exceptie pentru ultimele 2 caractere

            //1) doua terminale
            if(islower(v[i].stari[j][x + 1]) && islower(v[i].stari[j][x + 2]))
                printf("Y%d - X%cX%c\n", numar, v[i].stari[j][x+1], v[i].stari[j][x + 2]);
            else //2) primul e terminal si al doilea e neterminal
                if(islower(v[i].stari[j][x + 1]) && !islower(v[i].stari[j][x + 2]))
                    printf("Y%d - X%c%c\n", numar, v[i].stari[j][x + 1], v[i].stari[j][x + 2]);
                else //3) primul e neterminal si al doilea e terminal
                    if(!islower(v[i].stari[j][x + 1]) && islower(v[i].stari[j][x + 2]))
                        printf("Y%d - %cX%c\n", numar, v[i].stari[j][x + 1], v[i].stari[j][x + 2]);
                    else //4) doua neterminale
                        if(!islower(v[i].stari[j][x + 1]) && !islower(v[i].stari[j][x + 2]))
                            printf("Y%d - %c%c\n", numar, v[i].stari[j][x + 1], v[i].stari[j][x + 2]);
            numar ++;
        }

    return 0;
}
