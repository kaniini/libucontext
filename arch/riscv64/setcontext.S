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

ALIAS(setcontext, libucontext_setcontext)
ALIAS(__setcontext, libucontext_setcontext)

FUNC(libucontext_setcontext)
	/* move $a0 to $t0 to avoid clobbering. */
	mv t0, a0

#ifndef FORCE_SOFT_FLOAT
	/* floating point register block */
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

	ld t1, PC_OFFSET(t0)
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

	/* done restoring, jump to new pc in S1 */
	jr t1
END(libucontext_setcontext)
