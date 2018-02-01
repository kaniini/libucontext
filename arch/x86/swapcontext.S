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

.globl __swapcontext;
__swapcontext:
	/* load address of the ucontext structure */
	movl	4(%esp), %eax

	/* EAX is not a preserved register */
	movl	$0, OFFSET_REG_EAX(%eax)

	/* copy all of the current registers into the ucontext structure */
	movl	%ecx, OFFSET_REG_ECX(%eax)
	movl	%ebx, OFFSET_REG_EBX(%eax)
	movl	%edx, OFFSET_REG_EDX(%eax)
	movl	%edi, OFFSET_REG_EDI(%eax)
	movl	%esi, OFFSET_REG_ESI(%eax)
	movl	%ebp, OFFSET_REG_EBP(%eax)

	/* the first argument on the stack is the jump target (%eip), so we store it in the EIP
	   register in the ucontext structure. */
	movl	(%esp), %ecx
	movl	%ecx, OFFSET_REG_EIP(%eax)

	/* take the stack pointer address (%esp) offsetting by 4 to skip over the jump target. */
	leal	4(%esp), %ecx
	movl	%ecx, OFFSET_REG_ESP(%eax)

	/* finally, save the FS segment register */
	xorl	%ecx, %ecx
	movw	%fs, %cx
	movl	%ecx, OFFSET_REG_FS(%eax)

	/* load address of the ucontext structure */
	movl	8(%esp), %eax

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


.weak swapcontext;
swapcontext = __swapcontext;
