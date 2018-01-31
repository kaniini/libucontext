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
	str	xzr, [x0, #R0_OFFSET + (0 * REGSZ)]

	/* save GPRs */
	stp	x2, x3,   [x0, #R0_OFFSET + (2 * REGSZ)]
	stp	x4, x5,   [x0, #R0_OFFSET + (4 * REGSZ)]
	stp	x6, x7,   [x0, #R0_OFFSET + (6 * REGSZ)]
	stp	x8, x9,   [x0, #R0_OFFSET + (8 * REGSZ)]
	stp	x10, x11, [x0, #R0_OFFSET + (10 * REGSZ)]
	stp	x12, x13, [x0, #R0_OFFSET + (12 * REGSZ)]
	stp	x14, x15, [x0, #R0_OFFSET + (14 * REGSZ)]
	stp	x16, x17, [x0, #R0_OFFSET + (16 * REGSZ)]
	stp	x18, x19, [x0, #R0_OFFSET + (18 * REGSZ)]
	stp	x20, x21, [x0, #R0_OFFSET + (20 * REGSZ)]
	stp	x22, x23, [x0, #R0_OFFSET + (22 * REGSZ)]
	stp	x24, x25, [x0, #R0_OFFSET + (24 * REGSZ)]
	stp	x26, x27, [x0, #R0_OFFSET + (26 * REGSZ)]
	stp	x28, x29, [x0, #R0_OFFSET + (28 * REGSZ)]
	str	x30,      [x0, #R0_OFFSET + (30 * REGSZ)]

	/* save current program counter in link register */
	str	x30, [x0, #PC_OFFSET]

	/* save current stack pointer */
	mov	x2, sp
	str	x2, [x0, #SP_OFFSET]

	/* save pstate */
	str	xzr, [x0, #PSTATE_OFFSET]

	/* context to swap to is in x1 so... we move to x0 and call setcontext */
	/* store our link register in x28 */
	mov	x28, x30

	/* move x1 to x0 and call setcontext */
	mov	x0, x1
	bl	__setcontext

	/* hmm, we came back here try to return */
	mov	x30, x28
	ret



.weak swapcontext;
swapcontext = __swapcontext;
