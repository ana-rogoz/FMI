#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
int main(int argc, char* argv[]) {

	int i; 
	printf("Starting Parent %d\n", getpid());
	//pid_t pid = fork();
	for(i = 1; i <= argc; i++) {
		pid_t pid = fork();
		if(pid < 0)
			return errno;
		else 
		if (pid == 0) {
			int numarul = atoi(argv[i]);
			printf("%d: ", numarul);
			while(1) {
				printf("%d ", numarul);
				if(numarul == 1)
						break;
				if(numarul % 2 == 0)
					numarul = numarul / 2;
				else
					numarul = 3*numarul + 1;
			}
			
			printf("\n");
			printf("Done Parent %d Me %d\n",  getppid(), getpid());
			exit(1);
		}
	}

	for(i = 1; i <= argc; i++)
		wait();
	printf("Done Parent %d Me %d\n", getppid(), getpid());
	return 0;
}
