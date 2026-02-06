#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main() {
    for (int i = 0; i < 3; i++) {
        pid_t pid = fork();

        if (pid == 0) {
            printf("Child process %d exiting\n", getpid());
            exit(0);
        }
    }

    int status;
    pid_t child;

    while ((child = wait(&status)) > 0) {
        printf("Parent cleaned child process PID: %d\n", child);
    }

    return 0;
}

