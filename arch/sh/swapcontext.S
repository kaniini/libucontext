/*
 * Copyright (c) 2020 Ariadne Conill <ariadne@dereferenced.org>
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

ALIAS(swapcontext, libucontext_swapcontext)

FUNC(libucontext_swapcontext)
	mov	#0, r0						/* zero out r0, not preserved per ABI */

	mov.l	r0, @(REG_OFFSET(0), r4)			/* save GPRs r0-r15 */
	mov.l	r1, @(REG_OFFSET(1), r4)
	mov.l	r2, @(REG_OFFSET(2), r4)
	mov.l	r3, @(REG_OFFSET(3), r4)
	mov.l	r4, @(REG_OFFSET(4), r4)
	mov.l	r5, @(REG_OFFSET(5), r4)
	mov.l	r6, @(REG_OFFSET(6), r4)
	mov.l	r7, @(REG_OFFSET(7), r4)
	mov.l	r8, @(REG_OFFSET(8), r4)
	mov.l	r9, @(REG_OFFSET(9), r4)
	mov.l	r10, @(REG_OFFSET(10), r4)
	mov.l	r11, @(REG_OFFSET(11), r4)
	mov.l	r12, @(REG_OFFSET(12), r4)
	mov.l	r13, @(REG_OFFSET(13), r4)
	mov.l	r14, @(REG_OFFSET(14), r4)
	mov.l	r15, @(REG_OFFSET(15), r4)

	mov	r4, r0						/* move r4 to r0, and increment by REG_OFFSET(REG_MACL) + REG_SZ. */
	add	#(REG_OFFSET(REG_MACL + 1)), r0

	sts.l	macl, @-r0					/* save macl/mach registers */
	sts.l	mach, @-r0

	stc.l	gbr, @-r0					/* save gbr register */

	movt	r1						/* load T-flag into r1 */
	mov.l	r1, @-r0					/* save T-flag as SR register */

	sts.l	pr, @-r0					/* save current PR */
	sts.l	pr, @-r0					/* save current PR as PC as well */

	mov	r5, r0						/* now restore the new context */

	add	#(REG_OFFSET(REG_PC)), r0			/* restore PR */
	mov.l	@r0+, r2
	lds.l	@r0+, pr

	mov.l	@r0+, r1					/* restore T-flag */
	shlr	r1

	add	#REG_SZ, r0					/* skip GBR (used for TLS) */

	lds.l	@r0+, mach					/* load mach/macl registers */
	lds.l	@r0+, macl

	mov	r5, r0						/* bring r5 back to the top of the context */

	mov.l	@(REG_OFFSET(1), r0), r1			/* restore GPRs r1-15 */
	mov.l	@(REG_OFFSET(2), r0), r2
	mov.l	@(REG_OFFSET(3), r0), r3
	mov.l	@(REG_OFFSET(4), r0), r4
	mov.l	@(REG_OFFSET(5), r0), r5
	mov.l	@(REG_OFFSET(6), r0), r6
	mov.l	@(REG_OFFSET(7), r0), r7
	mov.l	@(REG_OFFSET(8), r0), r8
	mov.l	@(REG_OFFSET(9), r0), r9
	mov.l	@(REG_OFFSET(10), r0), r10
	mov.l	@(REG_OFFSET(11), r0), r11
	mov.l	@(REG_OFFSET(12), r0), r12
	mov.l	@(REG_OFFSET(13), r0), r13
	mov.l	@(REG_OFFSET(14), r0), r14
	mov.l	@(REG_OFFSET(15), r0), r15

	mov.l	@(REG_OFFSET(REG_PC), r0), r0
	jmp	@r0
END(libucontext_swapcontext)
