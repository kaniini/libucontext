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

ALIAS(swapcontext, libucontext_swapcontext)
ALIAS(__swapcontext, libucontext_swapcontext)

FUNC(libucontext_swapcontext)
	/* move $a1 to $t0 to avoid clobbering. */
	mv t0, a1

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

	/* restore new floating point register block */
	lw t1, MCONTEXT_FCSR(t0)

	fld fs0, FPREG_OFFSET(8)(t0)
	fld fs1, FPREG_OFFSET(9)(t0)
	fld fs2, FPREG_OFFSET(18)(t0)
	fld fs3, FPREG_OFFSET(19)(t0)
	fld fs4, FPREG_OFFSET(20)(t0)
	fld fs5, FPREG_OFFSET(21)(t0)
	fld fs6, FPREG_OFFSET(22)(t0)
	fld fs7, FPREG_OFFSET(23)(t0)
	fld fs8, FPREG_OFFSET(24)(t0)
	fld fs9, FPREG_OFFSET(25)(t0)
	fld fs10, FPREG_OFFSET(26)(t0)
	fld fs11, FPREG_OFFSET(27)(t0)

	fssr t1
#endif

	/* restore the other context from $t0. */
	ld t1, REG_OFFSET(REG_PC)(t0)
	ld ra, REG_OFFSET(REG_RA)(t0)
	ld sp, REG_OFFSET(REG_SP)(t0)

	/* first saved register block */
	ld s0, REG_OFFSET(REG_S0)(t0)
	ld s1, REG_OFFSET(REG_S1)(t0)

	/* return register block */
	ld a0, REG_OFFSET(REG_A0)(t0)
	ld a1, REG_OFFSET(REG_A1)(t0)

	/* argument register block */
	ld a2, REG_OFFSET(REG_A2)(t0)
	ld a3, REG_OFFSET(REG_A3)(t0)
	ld a4, REG_OFFSET(REG_A4)(t0)
	ld a5, REG_OFFSET(REG_A5)(t0)
	ld a6, REG_OFFSET(REG_A6)(t0)
	ld a7, REG_OFFSET(REG_A7)(t0)

	/* second saved register block */
	ld s2, REG_OFFSET(REG_S2)(t0)
	ld s3, REG_OFFSET(REG_S3)(t0)
	ld s4, REG_OFFSET(REG_S4)(t0)
	ld s5, REG_OFFSET(REG_S5)(t0)
	ld s6, REG_OFFSET(REG_S6)(t0)
	ld s7, REG_OFFSET(REG_S7)(t0)
	ld s8, REG_OFFSET(REG_S8)(t0)
	ld s9, REG_OFFSET(REG_S9)(t0)
	ld s10, REG_OFFSET(REG_S10)(t0)
	ld s11, REG_OFFSET(REG_S11)(t0)

	/* done swapping, jump to new PC in S1 */
	jr t1
END(libucontext_swapcontext)
