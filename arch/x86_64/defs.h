#ifndef __ARCH_X86_64_DEFS_H
#define __ARCH_X86_64_DEFS_H

#ifndef _GNU_SOURCE
# define REG_R8		(0)
# define REG_R9		(1)
# define REG_R10	(2)
# define REG_R11	(3)
# define REG_R12	(4)
# define REG_R13	(5)
# define REG_R14	(6)
# define REG_R15	(7)
# define REG_RDI	(8)
# define REG_RSI	(9)
# define REG_RBP	(10)
# define REG_RBX	(11)
# define REG_RDX	(12)
# define REG_RAX	(13)
# define REG_RCX	(14)
# define REG_RSP	(15)
# define REG_RIP	(16)
# define REG_EFL	(17)
# define REG_CSGSFS	(18)
# define REG_ERR	(19)
# define REG_TRAPNO	(20)
# define REG_OLDMASK	(21)
# define REG_CR2	(22)
#endif

#define MCONTEXT_GREGS	(40)

#define REG_SZ		(8)

#include "common-defs.h"

#endif
