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


#include "defs.h"


extern void __start_context(void);


void
__makecontext(ucontext_t *ucp, void (*func)(void), int argc, ...)
{
	greg_t *sp, *argp;
	va_list va;
	int i;
	unsigned int uc_link, stack_args;

	stack_args = argc > 8 ? argc - 8 : 0;
	uc_link = stack_args + 1;

	sp = (greg_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
	sp -= (uc_link + 1);
	sp = (greg_t *) ((uintptr_t) sp & -16L);

	ucp->uc_mcontext.gregs[REG_NIP]  = (uintptr_t) func;
	ucp->uc_mcontext.gregs[REG_LNK]  = (uintptr_t) &__start_context;
	ucp->uc_mcontext.gregs[REG_R31]  = (uintptr_t) ucp->uc_link;
	ucp->uc_mcontext.gregs[REG_SP]   = (uintptr_t) sp;

	sp[0] = (uintptr_t) &__start_context;
	sp[uc_link] = (uintptr_t) ucp->uc_link;
	argp = &sp[2];

	va_start(va, argc);

	for (i = 0; i < argc; i++)
		switch (i)
		{
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
			ucp->uc_mcontext.gregs[i + 3] = va_arg (va, greg_t);
			break;
		default:
			*argp++ = va_arg (va, greg_t);
			break;
		}

	va_end(va);
}


extern __typeof(__makecontext) makecontext __attribute__((weak, __alias__("__makecontext")));
