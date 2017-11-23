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

char* functia(void* v) {

  char* sir = (char *)v;

  int n = strlen(sir) - 1;
  char* result = (char*)malloc(n + 2);

  result[0] = 0;
  for(int i = n; i >= 0; i--)
    result[++result[0]] = sir[i];

  return result;
}

int main(int argc, char* argv[]) {

  pthread_t thr;
  if(pthread_create(&thr, NULL, functia, argv[1])) {
    perror(NULL);
    return errno;
  }

	char* result;
  if(pthread_join(thr, &result)) {
    perror(NULL);
    return errno;
  }

  printf("%s\n", (char *)result+1);
	return 0;
}

