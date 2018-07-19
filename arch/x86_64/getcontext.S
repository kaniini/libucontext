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

.globl __getcontext;
__getcontext:
	/* copy all of the current registers into the ucontext structure */
	movq	%r8, 40(%rdi)
	movq	%r9, 48(%rdi)
	movq	%r10, 56(%rdi)
	movq	%r11, 64(%rdi)
	movq	%r12, 72(%rdi)
	movq	%r13, 80(%rdi)
	movq	%r14, 88(%rdi)
	movq	%r15, 96(%rdi)
	movq	%rdi, 104(%rdi)
	movq	%rsi, 112(%rdi)
	movq	%rbp, 120(%rdi)
	movq	%rbx, 128(%rdi)
	movq	%rdx, 136(%rdi)
	movq	$1, 144(%rdi)		/* $1 is %rax */
	movq	%rcx, 152(%rdi)

	/* the first argument on the stack is the jump target (%rip), so we store it in the RIP
	   register in the ucontext structure. */
	movq	(%rsp), %rcx
	movq	%rcx, 168(%rdi)

	/* finally take the stack pointer address (%rsp) offsetting by 8 to skip over the jump
	   target. */
	leaq	8(%rsp), %rcx
	movq	%rcx, 160(%rdi)

	/* we're all done here, return 0 */
	xorl	%eax, %eax
	ret


.weak getcontext;
getcontext = __getcontext;
