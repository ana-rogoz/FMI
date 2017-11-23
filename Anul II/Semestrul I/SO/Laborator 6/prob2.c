#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <pthread.h>

struct element {
  int x, y;
};

int n, m, k;
int a[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
int b[3][3] = {{1, 1, 1}, {13, 14, 15}, {16, 17, 18}};
int rez[3][3];


int* inmultire(void* v) {

  struct element *poz_curenta = v;
  int* result = 0;
  for(int i = 0; i < m; i++)
    result += a[poz_curenta->x][i]*b[i][poz_curenta->y];
  return result;
}

int main(int argc, char* argv[]) {

  n = m = k = 3;

  // a este de dimensiune nXk, b este de dimensiune kXm => rez de dimensiune nXm
  for(int i = 0; i < n; i++)
    for(int j = 0; j < m; j++) {
      struct element *poz_curenta = (struct element*)malloc(sizeof(struct element));
      poz_curenta->x = i;
      poz_curenta->y = j;
      pthread_t thr;
      if(pthread_create(&thr, NULL, inmultire, poz_curenta)) {
        perror(NULL);
        return errno;
      }

      // ar fi trebuit sa am o matrice de threaduri si sa dau join la final, thr[i][j], result[i][j]
      int* result;
      if(pthread_join(thr, result)) {
        perror(NULL);
        return errno;
      }
      rez[i][j] = *(result);
    }

  for(int i = 0; i < n; i++) {
    for(int j = 0; j < m; j++)
      printf("%d ", rez[i][j]);
    printf("\n");
  }

  return 0;
}

