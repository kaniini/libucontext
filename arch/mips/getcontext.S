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

ALIAS(getcontext, __getcontext)

FUNC(__getcontext)
	/* copy $gp, $sp, $fp to temporary registers so we don't clobber them */
	move	$a2, $gp
	move	$a3, $sp
	move	$a1, $fp

	PUSH_FRAME(__getcontext)

	/* set registers */
	sw	$s0, ((16 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$s1, ((17 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$s2, ((18 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$s3, ((19 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$s4, ((20 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$s5, ((21 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$s6, ((22 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$s7, ((23 * REG_SZ) + MCONTEXT_GREGS)($a0)

	sw	$a2, ((28 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$a3, ((29 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$a1, ((30 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$ra, ((31 * REG_SZ) + MCONTEXT_GREGS)($a0)
	sw	$ra, (MCONTEXT_PC)($a0)

	POP_FRAME(__getcontext)

	jr	$ra
END(__getcontext)
