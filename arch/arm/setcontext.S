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
	/* copy all of the current registers into the ucontext structure */
	add	r14, r0, #32
	ldmia	r14, {r0-r12}
	ldr	r13, [r14, #52]
	add	r14, r14, #56

	/* load link register and jump to new context */
	ldmia	r14, {r14, pc}


.weak setcontext;
setcontext = __setcontext;
