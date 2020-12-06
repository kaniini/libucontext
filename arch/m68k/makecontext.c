/*
 * Copyright (c) 2020 Ariadne Conill <ariadne@dereferenced.org>
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
#include <ucontext.h>
#include <string.h>
#include <stdint.h>
#include <stdio.h>
#include "defs.h"


extern void __start_context(void);


void
libucontext_makecontext(ucontext_t *ucp, void (*func)(void), int argc, ...)
{
	greg_t *sp;
	va_list va;
	int i;

	/* set up and align the stack. */
	sp = (greg_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
	sp -= (argc + 2);
	sp = (greg_t *) (((uintptr_t) sp & ~0x3));

	/* set up the ucontext structure */
	ucp->uc_mcontext.gregs[REG_SP] = (greg_t) sp;
	ucp->uc_mcontext.gregs[REG_A6] = 0;
	ucp->uc_mcontext.gregs[REG_D7] = argc;
	ucp->uc_mcontext.gregs[REG_PC] = (greg_t) func;

	/* return address */
	*sp++ = (greg_t) __start_context;

	va_start(va, argc);

	/* all arguments overflow into stack */
	for (i = 0; i < argc; i++)
		*sp++ = va_arg (va, greg_t);

	va_end(va);

	/* link pointer */
	*sp++ = (greg_t) ucp->uc_link;
}


extern __typeof(libucontext_makecontext) makecontext __attribute__((weak, __alias__("libucontext_makecontext")));
