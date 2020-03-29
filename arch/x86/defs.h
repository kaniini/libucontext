#ifndef __ARCH_X86_DEFS_H
#define __ARCH_X86_DEFS_H

#ifndef REG_GS
# define REG_GS		(0)
# define REG_FS		(1)
# define REG_ES		(2)
# define REG_DS		(3)
# define REG_EDI	(4)
# define REG_ESI	(5)
# define REG_EBP	(6)
# define REG_ESP	(7)
# define REG_EBX	(8)
# define REG_EDX	(9)
# define REG_ECX	(10)
# define REG_EAX	(11)
# define REG_EIP	(14)
#endif

#define REG_SZ		(4)

#define MCONTEXT_GREGS	(20)

#include "common-defs.h"

#endif
