/*
 * Copyright (c) 2019 Bobby Bingham <koorogi@koorogi.info>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * This software is provided 'as is' and without any warranty, express or
 * implied.  In no event shall the authors be liable for any damages arising
 * from the use of this software.
 */

.global libucontext_setcontext
.hidden __swapcontext
libucontext_setcontext:
	mr 4, 3
	li 3, 0
	b __swapcontext@local

.weak setcontext
setcontext = libucontext_setcontext
