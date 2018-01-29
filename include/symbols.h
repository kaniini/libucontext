/* Heavily stripped down version of glibc include/libc-symbols.h */

/* Support macros for making weak and strong aliases for symbols,
   and for using symbol sets and linker warnings with GNU ld.
   Copyright (C) 1995-2018 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#ifndef __INCLUDE_SYMBOLS_H
#define __INCLUDE_SYMBOLS_H

#ifndef C_SYMBOL_NAME
# define C_SYMBOL_NAME(name) name
#endif

#ifndef __ASSEMBLER__

/* Define ALIASNAME as a weak alias for NAME.
   If weak aliases are not available, this defines a strong alias.  */
# define weak_alias(name, aliasname) _weak_alias (name, aliasname)
# define _weak_alias(name, aliasname) \
  extern __typeof (name) aliasname __attribute__ ((weak, alias (#name)));

#else

# define weak_alias(original, alias)                                    \
  .weak C_SYMBOL_NAME (alias) ;                                         \
  C_SYMBOL_NAME (alias) = C_SYMBOL_NAME (original)

#endif

#endif
