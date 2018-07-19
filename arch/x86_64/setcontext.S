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

.globl __setcontext;
__setcontext:
	/* set all of the registers */
	movq    40(%rdi), %r8
	movq    48(%rdi), %r9
	movq    56(%rdi), %r10
	movq    64(%rdi), %r11
	movq    72(%rdi), %r12
	movq    80(%rdi), %r13
	movq    88(%rdi), %r14
	movq    96(%rdi), %r15
	movq    112(%rdi), %rsi
	movq    120(%rdi), %rbp
	movq    128(%rdi), %rbx
	movq    136(%rdi), %rdx
	movq    144(%rdi), %rax
	movq    152(%rdi), %rcx
	movq    160(%rdi), %rsp

	/* set the jump target by pushing it to the stack.
	   ret will pop the new %rip from the stack, causing us to jump there. */
	pushq   168(%rdi)

	/* finally, set %rdi correctly. */
	movq    104(%rdi), %rdi

	/* we're all done here, return 0 */
	xorl    %eax, %eax
	ret

.weak setcontext;
setcontext = __setcontext;
