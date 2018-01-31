/*
 * libucontext test program based on POSIX example program.
 * Public domain.
 */

#include <stdio.h>
#include <ucontext.h>
#include <stdint.h>
#include <string.h>


static ucontext_t ctx[3];


static void f1 (void) {
	printf("start f1\n");
	swapcontext(&ctx[1], &ctx[2]);
	printf("finish f1\n");
}


static void f2 (void) {
	printf("start f2\n");
	swapcontext(&ctx[2], &ctx[1]);
	printf("finish f2\n");
}


int main (int argc, const char *argv[]) {
	char st1[8192];
	char st2[8192];


	/* poison each coroutine's stack memory for debugging purposes */
	memset(st1, 'A', sizeof st1);
	memset(st2, 'B', sizeof st2);


	getcontext(&ctx[1]);
	ctx[1].uc_stack.ss_sp = st1;
	ctx[1].uc_stack.ss_size = sizeof st1;
	ctx[1].uc_link = &ctx[0];
	makecontext(&ctx[1], f1, 0);


	getcontext(&ctx[2]);
	ctx[2].uc_stack.ss_sp = st2;
	ctx[2].uc_stack.ss_size = sizeof st2;
	ctx[2].uc_link = &ctx[1];
	makecontext(&ctx[2], f2, 0);


	swapcontext(&ctx[0], &ctx[2]);
	return 0;
}
