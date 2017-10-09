/*

    Baza de date a unei edituri


    Initial se citeste de la tastatura numarul autorilor ce au publicatii in cadrul editurii date.
Ulterior sunt introduse in baza de date numele acestora, id-ul lor de inregistrare si numarul cartilor
pe care acestia le au in cadrul editurii. In cadrul bazei de date pot si efectuate o serie de operatii:
introducerea unor carti in baza de date, introducerea unor adrese de contact, introducerea unor stiri cat
si introducerea unor conturi de utilizatori pe care cumparatorii editurii le pot avea.

    In cadrul bazei de date poate fi setat un orar dat, pot fi sortati autorii in functie de numele acestora
si poate fi calculat numarul mediu de carti pe care autorii bazei de date le public, dupa care aceasta noua
stire este introdusa in baza de date.

    De asemenea, am construit un vector de pointeri la cele 4 functii de adaugare a cartilor, conturilor,
adreselor si stirilor, cat si functii ce verifica caracterul valid al datelor introduse de la tastatura.

    Pentru incheierea introducerii unui tip de date (carti, conturi, adrese, stiri) trebuie introdusa valoarea 0.

*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define NMAX 100

struct Books
{

    char title[50];
    int noPages, noVol, price;
    char genre[20];
} book[NMAX + 1];

struct Authors
{

    char lastName[20], firstName[20];
    int id, noBooks;
} author[NMAX + 1];

struct News
{

    int day, month, year;
    char info[250];
} news[NMAX + 1];

struct Contacts
{

    char address[250];
    char tel[10];
} contact[NMAX + 1];

struct userAccounts
{

    char username[20];
    char pass[20];
    double ratioUserPass;
} accounts[NMAX + 1];

enum daysWeek
{

    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday

} day;

struct Schedule
{

    int beginHour, endHour;

} daySchedule[6];

void inputIncorect()
{

    printf("Inputul introdus este incorect\n");
}

void makeSchedule()
{

    for(day = Monday; day <= Friday; day++)
    {
        daySchedule[day].beginHour = 10;
        daySchedule[day].endHour = 22;
    }

}

_Bool valid;

_Bool validNoBooks(int nbooks)
{

    valid = 1;
    if(nbooks >= 0)
        return 1;

    valid = 0;
    return 0;
}

_Bool validPrice(int price)
{

    valid = 1;
    if(price > 0)
        return 1;

    valid = 0;
    return 0;
}

_Bool validnoVol(int noVol)
{

    valid = 1;
    if(noVol > 0)
        return 1;

    valid = 0;
    return 0;
}

_Bool validDate(int day, int month, int year)
{

    valid = 0;
    if(!(day >= 1 && day <= 31))
        return 0;
    if(!(month>= 1 && day <= 12))
        return 0;
    if(year <= 0)
        return 0;

    valid = 1;
    return 1;
}

void readAuthors(int noAuthors)
{

    int i;
    for(i = 1; i <= noAuthors; i++)
    {
        scanf("%d %s %s %d", &author[i].id, author[i].firstName, author[i].lastName, &author[i].noBooks);
        if(validNoBooks(author[i].noBooks) == 0)
            inputIncorect();
    }
}

void addUser(int *noUsers)
{

    ++(*noUsers);
    scanf("%s %s", accounts[*noUsers].username, accounts[*noUsers].pass);

}

void addNews(int *noNews)
{

    ++(*noNews);
    scanf("%d.%d.%d ", &news[*noNews].day, &news[*noNews].month, &news[*noNews].year);
    if(validDate(news[*noNews].day, news[*noNews].month, news[*noNews].year) == 0)
        inputIncorect();
    gets(news[*noNews].info);

}

void addContact(int *noContacts)
{

    ++(*noContacts);
    gets(contact[*noContacts].address);
    gets(contact[*noContacts].tel);

}

void addBooks(int *noBooks)
{

    ++(*noBooks);
    scanf("%s %d %d %d %s", book[*noBooks].title, &book[*noBooks].noVol, &book[*noBooks].noPages, &book[*noBooks].price, book[*noBooks].genre);
    if(validnoVol(book[*noBooks].noVol) == 0 || validnoVol(book[*noBooks].noPages) == 0 || validPrice(book[*noBooks].price) == 0)
        inputIncorect();

}

void writeAuthors(int noAuthors)
{

    int i;
    for(i = 1; i <= noAuthors; i++)
        printf("%d %s %s %d\n", author[i].id, author[i].firstName, author[i].lastName, author[i].noBooks);

}

int myCmp(struct Authors *s1, struct Authors *s2)
{

    return strcmp(s1->firstName, s2->firstName);

}

void sortAuthors(int noAuthors)
{

    qsort(author + 1, noAuthors, sizeof(struct Authors), myCmp);

}

_Bool validOpt(int opt)
{

    if(opt > 7 ||  opt < 1)
        return 0;
    return 1;
}

void menu(int opt, int noAuthors, int *noNews, int *noUsers, int *noContacts, int *noBooks, void(*addFunctions[]) (int*))
{

    int num, i;

    if(validOpt(opt) == 0)
        printf("Operatia aleasa este invalida");
    else
    {

        switch (opt)
        {

        case 1:
        {

            sortAuthors(noAuthors);
            writeAuthors(noAuthors);

            break;
        }

        case 2:
        {

            printf("Fiecare stire trebuie sa fie de forma: ID Zi.Luna.An Text\n");
            scanf("%d", &num);
            while(num != 0)
            {
                addFunctions[1](noNews);
                scanf("%d", &num);
            }

            if(valid == 1)
                printf("\nAu fost introduse stirile corect\n");

            break;
        }

        case 3:
        {

            printf("Fiecare user trebuie sa fie de forma: ID user_name parola\n");
            scanf("%d ", &num);
            while(num != 0)
            {
                addFunctions[2](noUsers);
                scanf("%d ", &num);
            }

            printf("\nAu fost introduse conturile corect\n");

            break;
        }

        case 4:
        {

            printf("Fiecare contact trebuie sa fie de forma: ID adresa *linie noua* numar_de_telefon\n");
            scanf("%d", &num);
            while(num != 0)
            {
                addFunctions[0](noContacts);
                scanf("%d", &num);
            }

            printf("\nAu fost introdusele adresele de contact corect\n");

            break;
        }

        case 5:
        {

            printf("Fiecare carte trebuie sa fie de forma: ID Titlu Numar_pagini Numar_volume Pret Genul_literaturii\n");
            scanf("%d", &num);
            while(num != 0)
            {
                addFunctions[3](noBooks);
                scanf("%d", &num);
            }

            if(valid == 1)
                printf("\nAu fost introduse cartile corect\n");

            break;
        }

        case 6:
        {

            makeSchedule();
            printf("Programul editurii a fost calculat!");

            break;
        }

        case 7:
        {

            int nr = 0;
            for(i = 1; i <= noAuthors; i++)
                nr += author[i].noBooks;

            nr /= noAuthors;

            ++*noNews;
            news[*noNews].day = 1;
            news[*noNews].month = 1;
            news[*noNews].year = 2010;

            char number[10];
            int l = 56;
            number[0] = 0;
            while(nr > 0)
            {

                number[++number[0]] = ('0' + nr % 10);
                nr = nr/10;
            }

            strcpy(news[*noNews].info, "Numarul mediu de carti pe care un autor il publica este ");
            for(i = number[0]; i >= 1; i--)
                news[*noNews].info[++l] = (number[i]);

            printf("Numarul mediu de carti pe care un autor il publica a fost calculat si introdus in categoria stiri");

            break;
        }

        default:

            break;
        }
    }
}

void Options()
{

    printf("\n\nTipuri de operatii:\n");
    printf("Operatia 1 sorteaza autorii si ii afiseaza\n");
    printf("Operatia 2 adauga in baza de date a editurii stirile existente\n");
    printf("Operatia 3 adauga in baza de date a editurii conturile utilizatorilor\n");
    printf("Operatia 4 adauga in baza de date a editurii adresele de contact\n");
    printf("Operatia 5 adauga in baza de date a editurii carti\n");
    printf("Operatia 6 seteaza orarul editurii in baza de date\n");
    printf("Operatia 7 calculeaza numarul mediu de carti publicate de catre un autor si introduce stirea");

}

int main()
{

    //freopen("date.in", "r", stdin);
    int opt, noAuthors, noNews = 0, noUsers = 0, noContacts = 0, noBooks;

    void(*addFunctions[4])(int*)  = {addContact, addNews, addUser, addBooks};

    printf("Introduceti numarul de autori: ");
    scanf("%d", &noAuthors);

    printf("Fiecare autor trebuie sa aiba formatul urmator: ID Nume Prenume Numar_carti_editura \n");
    readAuthors(noAuthors);

    Options();

    scanf("%d", &opt);

    if(opt > 7 || opt < 1)
    {

        printf("Input incorect\n");
        return 0;
    }

    menu(opt, noAuthors, &noNews, &noUsers, &noContacts, &noBooks, addFunctions);

    return 0;

}
