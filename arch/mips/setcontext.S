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

LOCALSZ = 1

#include "defs.h"

ALIAS(setcontext, __setcontext)

FUNC(__setcontext)
	PUSH_FRAME(__setcontext)

	/* move the context to $v0 */	
	move	$v0, $a0

	/* load the registers */
	lw	$a0, ((4 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$a1, ((5 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$a2, ((6 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$a3, ((7 * REG_SZ) + MCONTEXT_GREGS)($v0)

	lw	$s0, ((16 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$s1, ((17 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$s2, ((18 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$s3, ((19 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$s4, ((20 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$s5, ((21 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$s6, ((22 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$s7, ((23 * REG_SZ) + MCONTEXT_GREGS)($v0)

	lw	$gp, ((28 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$sp, ((29 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$fp, ((30 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$ra, ((31 * REG_SZ) + MCONTEXT_GREGS)($v0)
	lw	$t9, (MCONTEXT_PC)($v0)

	move	$v0, $zero
	jr	$t9

	POP_FRAME(__setcontext)
END(__setcontext)
