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

#define MAX_RESOURCES 30
int available_resources = MAX_RESOURCES;
pthread_mutex_t mtx;

int decrease_count(int count) {
  pthread_mutex_lock(&mtx);
  if(available_resources < count) {
    pthread_mutex_unlock(&mtx); 
    return -1;
  }
  else {
	available_resources -= count;
	printf("Got %d resources %d remaining\n", count, available_resources);
  }
  pthread_mutex_unlock(&mtx);
  return 0;

}

int increase_count(int count) {

  pthread_mutex_lock(&mtx);
  available_resources += count;
  printf("Released %d resources %d remaining\n", count, available_resources);
  pthread_mutex_unlock(&mtx);

  return 0;
}

void* solve(void *arg) {
  
  int count = (int) arg;
  
  while (decrease_count(count) == -1);
  increase_count(count);

  return NULL;
}


int main(int argc, char* argv[]) {

  int count;
  pthread_t thr[MAX_RESOURCES + 2];
  printf("MAX_RESOURCES = %d\n", available_resources); 
  for (int i = 0; i < MAX_RESOURCES; i++) {
    count = rand() % (MAX_RESOURCES + 1);
    if (pthread_create(&thr[i], NULL, solve, count)) {
        perror(NULL);
        return errno;
    }
  }

  for (int i = 0; i < MAX_RESOURCES; i++)
    pthread_join(thr[i], NULL);
  pthread_mutex_destroy(&mtx);

  return 0;
}
