/*
 * Copyright (c) 2018 Ariadne Conill <ariadne@dereferenced.org>
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
#include <stdio.h>
#include "defs.h"


extern void __start_context(void);


void
__makecontext(ucontext_t *ucp, void (*func)(void), int argc, ...)
{
	greg_t *sp, *regp;
	va_list va;
	int i;

	/* set up and align the stack. */
	sp = (greg_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
	sp -= argc < 8 ? 0 : argc - 8;
	sp = (greg_t *) (((uintptr_t) sp & -16L));

	/* set up the ucontext structure */
	ucp->uc_mcontext.gregs[REG_PC] = (greg_t) __start_context;
	ucp->uc_mcontext.gregs[REG_S0] = 0;
	ucp->uc_mcontext.gregs[REG_S1] = (greg_t) func;
	ucp->uc_mcontext.gregs[REG_S2] = (greg_t) ucp->uc_link;
	ucp->uc_mcontext.gregs[REG_SP] = (greg_t) sp;
	ucp->uc_mcontext.gregs[REG_PC_SAVE] = 0;

	va_start(va, argc);

	/* first 8 args go in $a0 through $a7. */
	regp = &(ucp->uc_mcontext.gregs[REG_A0]);

	for (i = 0; (i < argc && i < 8); i++)
		*regp++ = va_arg (va, greg_t);

	/* remainder overflows into stack */
	for (; i < argc; i++)
		*sp++ = va_arg (va, greg_t);

	va_end(va);
}


extern __typeof(__makecontext) makecontext __attribute__((weak, __alias__("__makecontext")));
