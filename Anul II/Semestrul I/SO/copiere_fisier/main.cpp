#include<cstdio>
using namespace std;

const int NMAX = 1000;

void Solve() {

    FILE *fptr1, *fptr2;
    char file[NMAX];
    scanf("%s",file);

    fptr1 = fopen(file, "r");
    if (fptr1 == NULL) {
        printf("Cannot open file %s \n", file);
        return;
    }
    scanf("%s",file);

    fptr2 = fopen(file, "w");
    if (fptr2 == NULL) {
        printf("Cannot open file %s \n", file);
        return;
    }

    char c = fgetc(fptr1);
    while (c != EOF) {
        fputc(c, fptr2);
        c = fgetc(fptr1);
    }

    printf("\nContents copied to %s", file);

    fclose(fptr1);
    fclose(fptr2);
}

int main() {

  Solve();
  return 0;
}
