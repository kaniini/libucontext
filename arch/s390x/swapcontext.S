/*
 * Copyright (c) 2018, 2020, 2024 Ariadne Conill <ariadne@dereferenced.org>
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

	lgr	%r5, %r0			/* copy %r0 to %r5 so that %r0 doesn't get clobbered */
	lam	%a2, %a15, AREG_OFFSET(2)(%r5)	/* load access registers, but skip %a0 and %a1 which are for TLS */
	lmg	%r0, %r15, REG_OFFSET(0)(%r5)	/* load general-purpose registers */

	br	%r14				/* return to new link register address */
END(libucontext_swapcontext)
