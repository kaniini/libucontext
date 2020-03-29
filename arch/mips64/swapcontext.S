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

LOCALSZ = 2

#include "defs.h"

A1_OFFSET = FRAMESZ - (1 * REG_SZ)

FUNC(__swapcontext)
	/* copy $gp, $sp, $fp to temporary registers so we don't clobber them */
	move	$a2, $gp
	move	$a3, $sp
	move	$a4, $fp

	PUSH_FRAME(__swapcontext)

	/* set the magic flag */
	li	$v0, 1
	sd	$v0, ((0 * REG_SZ) + MCONTEXT_GREGS)($a0)

	/* set registers */
	sd	$s0, ((16 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$s1, ((17 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$s2, ((18 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$s3, ((19 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$s4, ((20 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$s5, ((21 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$s6, ((22 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$s7, ((23 * REG_SZ) + MCONTEXT_GREGS)($a0)

	sd	$a2, ((28 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$a3, ((29 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$a4, ((30 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$ra, ((31 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sd	$ra, (MCONTEXT_PC)($a0)

	/* copy new context address in $a1 to stack */
	sd	$a1, A1_OFFSET($sp)

	/* load new context address into $v0 */
	ld	$v0, A1_OFFSET($sp)

	/* load the registers */
	ld	$a0, ((4 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$a1, ((5 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$a2, ((6 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$a3, ((7 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$a4, ((8 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$a5, ((9 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$a6, ((10 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$a7, ((11 * REG_SZ) + MCONTEXT_GREGS)($v0)

	ld	$s0, ((16 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$s1, ((17 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$s2, ((18 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$s3, ((19 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$s4, ((20 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$s5, ((21 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$s6, ((22 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$s7, ((23 * REG_SZ) + MCONTEXT_GREGS)($v0)

	ld	$gp, ((28 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$sp, ((29 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$fp, ((30 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$ra, ((31 * REG_SZ) + MCONTEXT_GREGS)($v0)
	ld	$t9, (MCONTEXT_PC)($v0)

	move	$v0, $zero
	jr	$t9

fail:
	dla	$t9, exit

	POP_FRAME(__swapcontext)

	move	$v0, $zero
	jalr	$t9
END(__swapcontext)

.weak swapcontext;
swapcontext = __swapcontext;
