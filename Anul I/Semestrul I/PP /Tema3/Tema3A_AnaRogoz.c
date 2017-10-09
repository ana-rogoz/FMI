#include<stdio.h>
#include<string.h>
#include<ctype.h>

char current_word[101];

/* Rezolv cele doua cerinte:
1) Sa se afiseze cuvintele formate doar din vocale
2) Sa se afiseze doar numerele
*/

void solve()
{

    char ch;
    int wordSize = -1;
    //citesc caracter cu caracter pana la finalul fisierului
    while(scanf("%c", &ch) != EOF)
    {

    	//Daca ch contine o litera sau o cifra continui sa construiesc sirul curent
        if(isdigit(ch) || isalpha(ch))
            current_word[++wordSize] = ch;
        else
        {
        	//Daca primul caracter este o litera vom verifica daca sirul este format doar din vocale
            if(isalpha(current_word[0]))
                checkWord(current_word, wordSize);

            //Daca primul caracter este o cifra vom verifica daca sirul este un numar
            if(isdigit(current_word[0]))
                checkNumber(current_word, wordSize);

            //Resetez sirul current_word
            memset(current_word, 0, sizeof(current_word));
            wordSize = -1;
        }
    }

}

//Verific daca este format numai din vocale cuvantul curent
void checkWord(char s[], int n)
{

    int i;
    char justVowels = 1;

    //Verific daca toate caracterele sunt vocale si folosesc variabila logica justVowels
    for(i = 0; i <= n; i++)
        if(s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u')
            continue;
        else
        {
            justVowels = 0;
            break;
        }

    if(justVowels == 1)
        printf("%s ", s);
}

//Verific daca este format doar din cifre cuvantul curent
void checkNumber(char s[], int n)
{

    int i;
    char isNumber = 1;

    if(s[0] == '0') // Daca prima cifra a numarului este 0 atunci nu il consider valid
        return;

    //Verific daca toate caracterele sunt cifre folosind variabila logica isNumber
    for(i = 0; i <= n; i++)
        if(isdigit(s[i]))
            continue;
        else
        {
            isNumber = 0;
            break;
        }

    if(isNumber == 1)
        printf("%s ", s);
}

int main()
{

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    solve();

    return 0;
}
