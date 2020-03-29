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

FUNC(__setcontext)
	PUSH_FRAME(__setcontext)

	/* move the context to $v0 */	
	move	$v0, $a0

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

	POP_FRAME(__setcontext)
END(__setcontext)

.weak setcontext;
setcontext = __setcontext;
