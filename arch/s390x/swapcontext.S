/*
 * Copyright (c) 2018-2025 Ariadne Conill <ariadne@dereferenced.org>
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
ALIAS(__swapcontext, libucontext_swapcontext)

FUNC(libucontext_swapcontext)
	lgr	%r1, %r2			/* use %r1 to save current context to */
	lgr	%r0, %r3			/* use %r0 for source context */

	la	%r2, 0				/* zero out future return value */

	stam	%a0, %a15, AREG_OFFSET(0)(%r1)	/* store access registers */
	stmg	%r0, %r15, REG_OFFSET(0)(%r1)	/* store general-purpose registers */

#ifndef FORCE_SOFT_FLOAT
	stfpc	MCONTEXT_FPC(%r1)		/* store fpc register */
	std	%f0, FPREG_OFFSET(0)(%r1)	/* store fpregs %f0-%f15 */
	std	%f1, FPREG_OFFSET(1)(%r1)
	std	%f2, FPREG_OFFSET(2)(%r1)
	std	%f3, FPREG_OFFSET(3)(%r1)
	std	%f4, FPREG_OFFSET(4)(%r1)
	std	%f5, FPREG_OFFSET(5)(%r1)
	std	%f6, FPREG_OFFSET(6)(%r1)
	std	%f7, FPREG_OFFSET(7)(%r1)
	std	%f8, FPREG_OFFSET(8)(%r1)
	std	%f9, FPREG_OFFSET(9)(%r1)
	std	%f10, FPREG_OFFSET(10)(%r1)
	std	%f11, FPREG_OFFSET(11)(%r1)
	std	%f12, FPREG_OFFSET(12)(%r1)
	std	%f13, FPREG_OFFSET(13)(%r1)
	std	%f14, FPREG_OFFSET(14)(%r1)
	std	%f15, FPREG_OFFSET(15)(%r1)
#endif

	lgr	%r5, %r0			/* copy %r0 to %r5 so that %r0 doesn't get clobbered */

#ifndef FORCE_SOFT_FLOAT
	lfpc	MCONTEXT_FPC(%r5)		/* load fpc register */
	ld	%f0, FPREG_OFFSET(0)(%r5)	/* load %f0-%f15 from context */
	ld	%f1, FPREG_OFFSET(1)(%r5)
	ld	%f2, FPREG_OFFSET(2)(%r5)
	ld	%f3, FPREG_OFFSET(3)(%r5)
	ld	%f4, FPREG_OFFSET(4)(%r5)
	ld	%f5, FPREG_OFFSET(5)(%r5)
	ld	%f6, FPREG_OFFSET(6)(%r5)
	ld	%f7, FPREG_OFFSET(7)(%r5)
	ld	%f8, FPREG_OFFSET(8)(%r5)
	ld	%f9, FPREG_OFFSET(9)(%r5)
	ld	%f10, FPREG_OFFSET(10)(%r5)
	ld	%f11, FPREG_OFFSET(11)(%r5)
	ld	%f12, FPREG_OFFSET(12)(%r5)
	ld	%f13, FPREG_OFFSET(13)(%r5)
	ld	%f14, FPREG_OFFSET(14)(%r5)
	ld	%f15, FPREG_OFFSET(15)(%r5)
#endif

	lam	%a2, %a15, AREG_OFFSET(2)(%r5)	/* load access registers, but skip %a0 and %a1 which are for TLS */
	lmg	%r0, %r15, REG_OFFSET(0)(%r5)	/* load general-purpose registers */

	br	%r14				/* return to new link register address */
END(libucontext_swapcontext)
