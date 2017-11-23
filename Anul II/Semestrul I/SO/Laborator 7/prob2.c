#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include <semaphore.h>
pthread_mutex_t mtx;
sem_t sem;
const int n = 5;
int nr;

typedef struct thread
{
	pthread_t thr;
	int id;
};

struct thread th[10];

void bariera()
{

	pthread_mutex_lock(&mtx);
	nr++;
	pthread_mutex_unlock(&mtx);

	if(nr < n) {
		sem_wait(&sem);
	}
	else {
    for(int i = 0; i < n-1;i++)
			sem_post(&sem);
	}
}

void* tfun(void* v)
{

	int id = *(int*) v;

	printf("%d a ajuns la bariera!\n", id);
	bariera();
	printf("%d a trecut de bariera!\n", id);

	return NULL;
}

int main()
{
	if(pthread_mutex_init(&mtx,NULL)) {
		perror(NULL);
		return errno;
	}

	sem_init(&sem, 0, 0);
	for(int i = 0; i < n; i++) {
		th[i].id = i;
		pthread_create(&th[i].thr, NULL, tfun, &th[i].id);
	}

	for(int i = 0; i < n; i++) {
		pthread_join(th[i].thr, NULL);
	}

	pthread_mutex_destroy(&mtx);
	sem_destroy(&sem);

	return 0;
}
