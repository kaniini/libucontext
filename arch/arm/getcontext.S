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
	add	r1, r0, #48
	stmia	r1, {r4-r12}
	str	r13, [r0,#84]
	str	r14, [r0,#92]

	/* return 0 */
	mov	r0, #0
	mov	pc, lr


.weak getcontext;
getcontext = __getcontext;
