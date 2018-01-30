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


extern void __start_context(void);


void
__makecontext(ucontext_t *ucp, void (*func)(void), int argc, ...)
{
	greg_t *sp;
	va_list va;
	int i;
	unsigned int uc_link;

	uc_link = (argc > 6 ? argc - 6 : 0) + 1;

	sp = (greg_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
	sp -= uc_link;
	sp = (greg_t *) (((uintptr_t) sp & -16L) - 8);

	ucp->uc_mcontext.gregs[REG_RIP] = (uintptr_t) func;
	ucp->uc_mcontext.gregs[REG_RBX] = (uintptr_t) &sp[uc_link];
	ucp->uc_mcontext.gregs[REG_RSP] = (uintptr_t) sp;

	sp[0] = (uintptr_t) &__start_context;
	sp[uc_link] = (uintptr_t) ucp->uc_link;

	va_start(va, argc);

	for (i = 0; i < argc; i++)
		switch (i)
		{
		case 0:
			ucp->uc_mcontext.gregs[REG_RDI] = va_arg (va, greg_t);
			break;
		case 1:
			ucp->uc_mcontext.gregs[REG_RSI] = va_arg (va, greg_t);
			break;
		case 2:
			ucp->uc_mcontext.gregs[REG_RDX] = va_arg (va, greg_t);
			break;
		case 3:
			ucp->uc_mcontext.gregs[REG_RCX] = va_arg (va, greg_t);
			break;
		case 4:
			ucp->uc_mcontext.gregs[REG_R8] = va_arg (va, greg_t);
			break;
		case 5:
			ucp->uc_mcontext.gregs[REG_R9] = va_arg (va, greg_t);
			break;
		default:
			sp[i - 5] = va_arg (va, greg_t);
			break;
		}

	va_end(va);
}


extern __typeof(__makecontext) makecontext __attribute__((weak, __alias__("__makecontext")));
