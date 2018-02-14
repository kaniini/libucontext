/*
 * Copyright (c) 2018 William Pitcock <nenolod@dereferenced.org>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * This software is provided 'as is' and without any warranty, express or
 * implied.  In no event shall the authors be liable for any damages arising
 * from the use of this software.
 */

.globl __start_context;
__start_context:
	/* get the proper context into position and test for NULL */
	leal	(%esp,%ebx,4), %esp
	cmpl	$0, (%esp)
	je	hosed

	/* call setcontext to switch to the linked context */
	call	__setcontext@plt
	movl	%eax, (%esp)

hosed:
	/* we are returning into a null context, it seems, so maybe we should exit */
	call	exit@plt

	/* something is really hosed, call hlt to force termination */
	hlt
