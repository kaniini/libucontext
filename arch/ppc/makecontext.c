/*
 * Copyright (c) 2018 William Pitcock <nenolod@dereferenced.org>
 * Copyright (c) 2019 Bobby Bingham <koorogi@koorogi.info>
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
#include <stdarg.h>
#include <signal.h>
#include <stdint.h>


#include "defs.h"


extern void __start_context(void);


void
__makecontext(ucontext_t *ucp, void (*func)(), int argc, ...)
{
	greg_t *sp;
	va_list va;
	int i;
	unsigned int stack_args;

	stack_args = argc > 8 ? argc - 8 : 0;

	sp = (greg_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
	sp -= stack_args + 2;
	sp = (greg_t *) ((uintptr_t) sp & -16L);

	ucp->uc_mcontext.gregs[REG_NIP]  = (uintptr_t) func;
	ucp->uc_mcontext.gregs[REG_LNK]  = (uintptr_t) &__start_context;
	ucp->uc_mcontext.gregs[REG_R31]  = (uintptr_t) ucp->uc_link;
	ucp->uc_mcontext.gregs[REG_SP]   = (uintptr_t) sp;

	sp[0] = 0;

	va_start(va, argc);

	for (i = 0; i < argc; i++) {
		if (i < 8)
			ucp->uc_mcontext.gregs[i + 3] = va_arg (va, greg_t);
		else
			sp[i-8 + 2] = va_arg (va, greg_t);
	}

	va_end(va);
}


extern __typeof(__makecontext) makecontext __attribute__((weak, __alias__("__makecontext")));
