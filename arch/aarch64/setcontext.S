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
	/* restore GPRs */
	ldp	x18, x19, [x0, #R0_OFFSET + (18 * REGSZ)]
	ldp	x20, x21, [x0, #R0_OFFSET + (20 * REGSZ)]
	ldp	x22, x23, [x0, #R0_OFFSET + (22 * REGSZ)]
	ldp	x24, x25, [x0, #R0_OFFSET + (24 * REGSZ)]
	ldp	x26, x27, [x0, #R0_OFFSET + (26 * REGSZ)]
	ldp	x28, x29, [x0, #R0_OFFSET + (28 * REGSZ)]
	ldr	x30,      [x0, #R0_OFFSET + (30 * REGSZ)]

	/* save current stack pointer */
	ldr	x2, [x0, #SP_OFFSET]
	mov	sp, x2

	/* TODO: SIMD / FPRs */

	/* save current program counter in link register */
	ldr	x16, [x0, #PC_OFFSET]

	/* restore args */
	ldp	x2, x3, [x0, #R0_OFFSET + (2 * REGSZ)]
	ldp	x4, x5, [x0, #R0_OFFSET + (4 * REGSZ)]
	ldp	x6, x7, [x0, #R0_OFFSET + (6 * REGSZ)]
	ldp	x0, x1, [x0, #R0_OFFSET + (0 * REGSZ)]

	/* jump to new PC */
	br	x16


.weak setcontext;
setcontext = __setcontext;

