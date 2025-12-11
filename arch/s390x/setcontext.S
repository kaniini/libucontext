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

ALIAS(setcontext, libucontext_setcontext)
ALIAS(__setcontext, libucontext_setcontext)

FUNC(libucontext_setcontext)
	lgr	%r1, %r2			/* use %r1 as our working register */

#ifndef FORCE_SOFT_FLOAT
	lfpc	MCONTEXT_FPC(%r1)		/* load fpc register */
	ld	%f0, FPREG_OFFSET(0)(%r1)	/* load %f0-%f15 from context */
	ld	%f1, FPREG_OFFSET(1)(%r1)
	ld	%f2, FPREG_OFFSET(2)(%r1)
	ld	%f3, FPREG_OFFSET(3)(%r1)
	ld	%f4, FPREG_OFFSET(4)(%r1)
	ld	%f5, FPREG_OFFSET(5)(%r1)
	ld	%f6, FPREG_OFFSET(6)(%r1)
	ld	%f7, FPREG_OFFSET(7)(%r1)
	ld	%f8, FPREG_OFFSET(8)(%r1)
	ld	%f9, FPREG_OFFSET(9)(%r1)
	ld	%f10, FPREG_OFFSET(10)(%r1)
	ld	%f11, FPREG_OFFSET(11)(%r1)
	ld	%f12, FPREG_OFFSET(12)(%r1)
	ld	%f13, FPREG_OFFSET(13)(%r1)
	ld	%f14, FPREG_OFFSET(14)(%r1)
	ld	%f15, FPREG_OFFSET(15)(%r1)
#endif

	lam	%a2, %a15, AREG_OFFSET(2)(%r1)	/* load access registers, but skip %a0 and %a1 which are for TLS */
	lmg	%r0, %r15, REG_OFFSET(0)(%r1)	/* store general-purpose registers */

	br	%r14				/* return to new link register address */
END(libucontext_setcontext)
