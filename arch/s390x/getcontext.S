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

ALIAS(getcontext, libucontext_getcontext)
ALIAS(__getcontext, libucontext_getcontext)

FUNC(libucontext_getcontext)
	lgr	%r1, %r2			/* use %r1 as our working register */
	la	%r2, 0				/* we will return 0 */

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

	br	%r14				/* return to where we came from */
END(libucontext_getcontext)
