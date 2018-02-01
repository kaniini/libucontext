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

#include "defs.h"

.globl __setcontext;
__setcontext:
	/* load address of the ucontext structure */
	movl	4(%esp), %eax

	/* set up the FS segment register */
	movl	OFFSET_REG_FS(%eax), %ecx
	movw	%cx, %fs

	/* fetch the new EIP */
	movl	OFFSET_REG_EIP(%eax), %ecx

	/* set up the new stack pointer */
	movl	OFFSET_REG_ESP(%eax), %esp

	/* push the return address onto the stack */
	pushl	%ecx

	/* set all of the registers */
	movl	OFFSET_REG_EBX(%eax), %ebx
	movl	OFFSET_REG_ECX(%eax), %ecx
	movl	OFFSET_REG_EDX(%eax), %edx
	movl	OFFSET_REG_EBP(%eax), %ebp
	movl	OFFSET_REG_EDI(%eax), %edi
	movl	OFFSET_REG_ESI(%eax), %esi
	movl	OFFSET_REG_EAX(%eax), %eax

	ret


.weak setcontext;
setcontext = __setcontext;
