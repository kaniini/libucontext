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

#include "defs.h"

FUNC(libucontext_trampoline)
	lea	(%sp, %d7.l * REG_SZ), %sp	/* place uc_link in $sp */

	tst.l	(%sp)				/* test next content for NULL */
	jeq	no_linked_context

	jbsr	libucontext_setcontext			/* call setcontext */
	move.l	%d0, (%sp)

no_linked_context:
	jbsr	exit
END(libucontext_trampoline)
