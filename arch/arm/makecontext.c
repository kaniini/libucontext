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
#include <stdio.h>


extern void __start_context(void);


void
__makecontext(ucontext_t *ucp, void (*func)(void), int argc, ...)
{
	unsigned long *sp;
	unsigned long *regp;
	va_list va;
	int i;

	sp = (unsigned long *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss_size);
	sp = (unsigned long *) (((uintptr_t) sp & -16L) - 8);

	if (argc > 4)
		sp -= (argc - 4);

	ucp->uc_mcontext.arm_sp = (uintptr_t) sp;
	ucp->uc_mcontext.arm_pc = (uintptr_t) func;
	ucp->uc_mcontext.arm_r4 = (uintptr_t) ucp->uc_link;
	ucp->uc_mcontext.arm_lr = (uintptr_t) &__start_context;

	va_start(va, argc);

	regp = &(ucp->uc_mcontext.arm_r0);

	for (i = 0; (i < argc && i < 4); i++)
		*regp++ = va_arg (va, unsigned long);

	for (; i < argc; i++)
		*sp++ = va_arg (va, unsigned long);

	va_end(va);

/*
	printf("R4 offset = %d\n", offsetof(ucontext_t, uc_mcontext.arm_r4));
	printf("SP offset = %d\n", offsetof(ucontext_t, uc_mcontext.arm_sp));
	printf("LR offset = %d\n", offsetof(ucontext_t, uc_mcontext.arm_lr));
	printf("PC offset = %d\n", offsetof(ucontext_t, uc_mcontext.arm_pc));
 */
}


extern __typeof(__makecontext) makecontext __attribute__((weak, __alias__("__makecontext")));
