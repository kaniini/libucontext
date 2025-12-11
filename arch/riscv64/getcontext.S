/*
 * Copyright (c) 2020-2025 Ariadne Conill <ariadne@dereferenced.org>
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
	sd ra, REG_OFFSET(REG_PC)(a0)
	sd ra, REG_OFFSET(REG_RA)(a0)
	sd sp, REG_OFFSET(REG_SP)(a0)

	/* first saved register block */
	sd s0, REG_OFFSET(REG_S0)(a0)
	sd s1, REG_OFFSET(REG_S1)(a0)

	/* return register block */
	sd x0, REG_OFFSET(REG_A0)(a0)
	sd x0, REG_OFFSET(REG_A1)(a0)

	/* second saved register block */
	sd s2, REG_OFFSET(REG_S2)(a0)
	sd s3, REG_OFFSET(REG_S3)(a0)
	sd s4, REG_OFFSET(REG_S4)(a0)
	sd s5, REG_OFFSET(REG_S5)(a0)
	sd s6, REG_OFFSET(REG_S6)(a0)
	sd s7, REG_OFFSET(REG_S7)(a0)
	sd s8, REG_OFFSET(REG_S8)(a0)
	sd s9, REG_OFFSET(REG_S9)(a0)
	sd s10, REG_OFFSET(REG_S10)(a0)
	sd s11, REG_OFFSET(REG_S11)(a0)

#ifndef FORCE_SOFT_FLOAT
	/* floating point register block */
	frsr a1

	fsd fs0, FPREG_OFFSET(8)(a0)
	fsd fs1, FPREG_OFFSET(9)(a0)
	fsd fs2, FPREG_OFFSET(18)(a0)
	fsd fs3, FPREG_OFFSET(19)(a0)
	fsd fs4, FPREG_OFFSET(20)(a0)
	fsd fs5, FPREG_OFFSET(21)(a0)
	fsd fs6, FPREG_OFFSET(22)(a0)
	fsd fs7, FPREG_OFFSET(23)(a0)
	fsd fs8, FPREG_OFFSET(24)(a0)
	fsd fs9, FPREG_OFFSET(25)(a0)
	fsd fs10, FPREG_OFFSET(26)(a0)
	fsd fs11, FPREG_OFFSET(27)(a0)

	sw a1, MCONTEXT_FCSR(a0)
#endif

	/* done saving, return */
	mv a0, x0
	ret
END(libucontext_getcontext)
