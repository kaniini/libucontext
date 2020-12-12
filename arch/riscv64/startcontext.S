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
	/* check for linked context */
	beqz	s1, no_linked_context

	/* if one is set, invoke it */
	mv	a0, s1
	jal	libucontext_setcontext

	/* otherwise, exit. */
no_linked_context:
	tail	exit@plt
END(libucontext_trampoline)
