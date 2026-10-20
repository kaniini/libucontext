/*
 * Copyright (c) 2026 Jianhui Zhao <jianhui.zhao@gl-inet.com>
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

#ifdef __MACH__
.private_extern PROC_NAME(libucontext_trampoline)
#else
.hidden libucontext_trampoline
#endif

FUNC(libucontext_trampoline)
	/* makecontext leaves the address of uc_link in the callee-saved %rbx.
	   Read it before any C code can reuse that register. */
	movq	(%rbx), %rdi

	/* The context entry function returned here, rather than calling us.
	   Align the stack before making ordinary ABI calls. */
	andq	$-16, %rsp
	testq	%rdi, %rdi
	je	no_linked_context

	call	PROC_NAME(libucontext_setcontext)
	movl	%eax, %edi

no_linked_context:
	/* A null uc_link exits successfully; a failed setcontext supplies status. */
	call	PROC_NAME(exit)
	hlt
END(libucontext_trampoline)
