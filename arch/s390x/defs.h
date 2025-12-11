#ifndef __ARCH_S390X_DEFS_H
#define __ARCH_S390X_DEFS_H

#define REG_SZ		(8)
#define AREG_SZ		(4)
#define FPREG_SZ	(8)

#define MCONTEXT_GREGS	(56)
#define MCONTEXT_AREGS	(184)
#define MCONTEXT_FPC	(248)
#define MCONTEXT_FPREGS	(256)

#define AREG_OFFSET(__reg)	(MCONTEXT_AREGS + ((__reg) * AREG_SZ))
#define FPREG_OFFSET(__reg)	(MCONTEXT_FPREGS + ((__reg) * FPREG_SZ))

#include "common-defs.h"

#endif
