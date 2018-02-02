/*
 * Copyright (c) 2018 William Pitcock <nenolod@dereferenced.org>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * This software is provided 'as is' and without any warranty, express or
 * implied.  In no event shall the authors be liable for any damages arising
 * from the use of this software.
 */

#define _GNU_SOURCE
#include <stddef.h>
#include <stdarg.h>
#include <signal.h>
#include <string.h>
#include <stdint.h>
#include <errno.h>
#include <unistd.h>
#include <sys/syscall.h>


int
__getcontext(ucontext_t *ucp)
{
#ifdef SYS_swapcontext
	int r;

	r = syscall(SYS_swapcontext, ucp, NULL, sizeof(ucontext_t));
	if (r < 0)
	{
		errno = -r;
		return -1;
	}

	return 0;
#else
	errno = ENOSYS;
	return -1;
#endif
}


extern __typeof(__getcontext) getcontext __attribute__((weak, __alias__("__getcontext")));
