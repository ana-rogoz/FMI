#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define PROP_SIZE_MAX 5000
#define COMM_SIZE_MAX 10000
#define NUM_PROC_MAX 10000
#define PID_MAX 1000000

typedef struct proces
{

    char user[PROP_SIZE_MAX];
    int pid;
    int ppid;
    char cpu[PROP_SIZE_MAX];
    char mem[PROP_SIZE_MAX];
    char vsz[PROP_SIZE_MAX];
    char rss[PROP_SIZE_MAX];
    char tty[PROP_SIZE_MAX];
    char stat[PROP_SIZE_MAX];
    char start[PROP_SIZE_MAX];
    char time[PROP_SIZE_MAX];
    char command[COMM_SIZE_MAX];

};

struct proces procese[NUM_PROC_MAX];
int numarProcese = 0, succesori[NUM_PROC_MAX][NUM_PROC_MAX], numarSuccesori[NUM_PROC_MAX];
char pathUser[PROP_SIZE_MAX] = ""; // Directorul curent in care avem proiectul.

int mapPidProces[PID_MAX]; // Vector de mapare intre pid si indexul sau la citire.

void extragDate()
{
    system("ps -aux > process_details.txt");
    system("ps xao pid,ppid > process_parents.txt");
}

void parserFisiere()
{

    FILE *fs1, *fs2;
    fs1 = fopen("process_details.txt", "r"); // Fisierul cu statistici dat de ps -aux.
    fs2 = fopen("process_parents.txt", "r"); // Fisierul cu pid si ppid dat de ps xao pid,ppid.

    char iterator1_ch, iterator2_ch;

    // Citim prima linie din cele doua fisiere cu numele coloanelor.
    while(fscanf(fs1, "%c", &iterator1_ch))
    {
        if(iterator1_ch == '\n')
            break;
    }
    while(fscanf(fs2, "%c", &iterator2_ch))
    {
        if(iterator2_ch == '\n')
            break;
    }

    // Parsam cele doua fisiere si construim structul fiecarui proces.
    while(1)
    {
        numarProcese++;

        // Incepem sa parcurgem o linie din process details.
        fscanf(fs1, "%c", &iterator1_ch);
        procese[numarProcese].user[0] = iterator1_ch;
        if (iterator1_ch == '\n')
        {
            break;
        }
        // Citim user.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].user[strlen(procese[numarProcese].user)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].pid = (iterator1_ch - '0');
                break;
            }
        }
        // Citim PID.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].pid = procese[numarProcese].pid * 10 + (iterator1_ch - '0');
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].cpu[0] = iterator1_ch;
                break;
            }
        }
        // Citim %CPU.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].cpu[strlen(procese[numarProcese].cpu)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].mem[0] = iterator1_ch;
                break;
            }
        }
        // Citim MEM.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].mem[strlen(procese[numarProcese].mem)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].vsz[0] = iterator1_ch;
                break;
            }
        }
        // Citim VSZ.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].vsz[strlen(procese[numarProcese].vsz)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].rss[0] = iterator1_ch;
                break;
            }
        }
        // Citim RSS.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].rss[strlen(procese[numarProcese].rss)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].tty[0] = iterator1_ch;
                break;
            }
        }
        // Citim TTY.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].tty[strlen(procese[numarProcese].tty)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].stat[0] = iterator1_ch;
                break;
            }
        }
        // Citim STAT.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].stat[strlen(procese[numarProcese].stat)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].start[0] = iterator1_ch;
                break;
            }
        }
        // Citim START.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].start[strlen(procese[numarProcese].start)] = iterator1_ch;
        }
        // Trecem peste space.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch != ' ')
            {
                procese[numarProcese].time[0] = iterator1_ch;
                break;
            }
        }
        // Citim time.
        while(fscanf(fs1, "%c", &iterator1_ch))
        {
            if(iterator1_ch == ' ')
                break;
            procese[numarProcese].time[strlen(procese[numarProcese].time)] = iterator1_ch;
        }
        // Trecem peste space.
        while (fscanf(fs1, "%c", &iterator1_ch))
        {
            if (iterator1_ch != ' ')
            {
                procese[numarProcese].command[0] = iterator1_ch;
                break;
            }
        }
        // Citim COMMAND.
        while (fscanf(fs1, "%c", &iterator1_ch))
        {
            if (iterator1_ch == '\n')
                break;
            procese[numarProcese].command[strlen(procese[numarProcese].command)] = iterator1_ch;
        }
        // Am terminat de citit o linie din process details.

        // Parcurgem o linie din process parents.
        fscanf(fs2, "%c", &iterator2_ch);
        if (iterator2_ch == EOF)
            break;
        fscanf(fs2, "%d %d", &procese[numarProcese].pid, &procese[numarProcese].ppid);
        mapPidProces[procese[numarProcese].pid] =  numarProcese;
        // Am terminat de citit o linie din process parents.
    }
    fclose(fs1);
    fclose(fs2);
}

void construiesteArbore()
{

    int i;
    int pid_proces, pid_tata, index_tata;

    // Parcurgem toate procesele si formam "muchii" intre ppid si pid.
    for (i = 0; i < numarProcese; i++)
    {
        pid_proces = procese[i].pid;
        pid_tata = procese[i].ppid;
        index_tata = mapPidProces[pid_tata];
        if (pid_proces != pid_tata)
        {
            numarSuccesori[index_tata]++;
            succesori[index_tata][numarSuccesori[index_tata]] = i;
        }
    }
}


void construiesteSistemFisiere(int proces_curent, char pathCurent[PROP_SIZE_MAX])
{

    // Formam fisierul cu stats pentru fiecare proces in parte, diferit de radacina.
    if (proces_curent != 0)
    {
        FILE *fisierIesire;
        char pathAuxiliar[PROP_SIZE_MAX] = "";
        strcpy(pathAuxiliar, pathCurent);
        strcat(pathAuxiliar, "stats");
        fisierIesire = fopen(pathAuxiliar, "w+r");
        fprintf(fisierIesire, "USER: %s\nPID: %d\nPPID: %d\nCPU: %s\nMEM: %s\nVSZ: %s\nRSS: %s\nTTY: %s\nSTAT: %s\nSTART: %s\nTIME: %s\nCOMMAND: %s\n",
                procese[proces_curent].user,
                procese[proces_curent].pid,
                procese[proces_curent].ppid,
                procese[proces_curent].cpu,
                procese[proces_curent].mem,
                procese[proces_curent].vsz,
                procese[proces_curent].rss,
                procese[proces_curent].tty,
                procese[proces_curent].stat,
                procese[proces_curent].start,
                procese[proces_curent].time,
                procese[proces_curent].command);
        fclose(fisierIesire);
    }

    // Parcurgem fiii procesului curent si apelam recursiv construiesteSistemFisiere.
    int i, pid_fiu, j, fiu;
    for (i = 1; i <= numarSuccesori[proces_curent]; i++)
    {
        fiu = succesori[proces_curent][i];
        pid_fiu = procese[fiu].pid;
        // Pentru fiecare fiu transformam pidul din valoare intreaga in string.
        char pidString[PROP_SIZE_MAX] = "";
        if (pid_fiu == 0)
            strcpy(pidString, "0");
        else
        {
            char c;
            do
            {
                c = (char)(pid_fiu % 10 + '0');
                strncat(pidString, &c, 1);
                pid_fiu /= 10;
            }
            while(pid_fiu != 0);
        }

        // Rasturnam stringul pentru a obtin
        int lungimePid = strlen(pidString);
        char aux;
        for (j = 0; j < lungimePid / 2; j++)
        {
            aux = pidString[j];
            pidString[j] = pidString[lungimePid - j - 1];
            pidString[lungimePid - j - 1] = aux;
        }

        struct stat st = {0};
        // Formam noua cale pentru folderul fiului curent, pe care ulterior o vom trimite in recursivitate.
        char pathFiu[PROP_SIZE_MAX] = "";
        strcpy(pathFiu, pathCurent);
        strcat(pathFiu, "/");
        strcat(pathFiu, pidString);


        if (stat(pathFiu, &st) == -1)
            mkdir(pathFiu, 0777);

        strcat(pathFiu, "/");
        construiesteSistemFisiere(fiu, pathFiu);
    }

}

int main(int argc, char* argv[])
{

    extragDate(); // Formez cele doua fisiere txt cu date necesare.
    parserFisiere(); // Separ datele convenabil si le pun in structura.
    construiesteArbore(); // Stabilesc legaturi intre pid si ppid.

    strcpy(pathUser, get_current_dir_name()); // Copiem in pathUser calea directorului in care se afla proiectul.

    struct stat st = {0};
    char pathProcDir[PROP_SIZE_MAX] = ""; // Formam folderul principal de procese.
    strcpy(pathProcDir, pathUser);
    strcat(pathProcDir, "/Procese");

    if (stat(pathProcDir, &st) == -1)
        mkdir(pathProcDir, 0777);
    strcat(pathProcDir, "/");
    construiesteSistemFisiere(0, pathProcDir); // Pornim recursivitatea din procesul radacina 0 si calea formata.

    return 0;
}
