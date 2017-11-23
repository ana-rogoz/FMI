#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
int main(int argc, char* argv[]) {

	int i;
	printf("Starting Parent %d\n", getpid());

	char shm_name[] = "myshm";
	int shm_fd;
	shm_fd = shm_open(shm_name , O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
	if (shm_fd < 0) {
		perror(NULL) ;
		return errno;
	}

	size_t shm_size = getpagesize() * argc;
	size_t page_size = getpagesize();
	if(ftruncate(shm_fd, shm_size) == -1) {
		perror(NULL);
		shm_unlink(shm_name);
		return errno;
	}

	char* shm_ptr;
	for(i = 1; i < argc; i++) {
		shm_ptr = mmap(0, page_size, PROT_WRITE, MAP_SHARED, shm_fd, (i-1) * page_size);
		pid_t pid = fork();
		if(pid < 0)
			return errno;
		else
		if (pid == 0) {
			int numarul = atoi(argv[i]);
			shm_ptr += sprintf(shm_ptr, "%d: ", numarul);
			while(1) {
				shm_ptr += sprintf(shm_ptr, "%d ", numarul);
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
	       munmap(shm_ptr, page_size);
	}

	for (i = 1; i < argc; i++) {
		wait(NULL);
	}

	for (i = 1; i < argc; i++) {
		shm_ptr = mmap(0, page_size, PROT_READ, MAP_SHARED, shm_fd, (i-1) * page_size);
		printf("%s\n", shm_ptr);
		munmap(shm_ptr, page_size);
	}
	shm_unlink(shm_name);
	printf("Done Parent %d Me %d\n", getppid(), getpid());

	return 0;
}
