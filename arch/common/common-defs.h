#ifndef __ARCH_COMMON_COMMON_DEFS_H
#define __ARCH_COMMON_COMMON_DEFS_H

#ifndef SETUP_FRAME
# define SETUP_FRAME(__proc)
#endif

#ifndef PUSH_FRAME
# define PUSH_FRAME(__proc)
#endif

#ifndef POP_FRAME
# define POP_FRAME(__proc)
#endif

#ifndef ENT
# define ENT(__proc)
#endif

#define FUNC(__proc)					\
	.global __proc;					\
	.align  2;					\
	.type   __proc, @function;			\
	ENT(__proc)					\
__proc:							\
	SETUP_FRAME(__proc)

#define END(__proc)					\
	.end	__proc;					\
	.size	__proc,.-__proc;

#define ALIAS(__alias, __real)				\
	.weak	__alias;				\
	__alias = __real;

#define REG_OFFSET(__reg)       (MCONTEXT_GREGS + ((__reg) * REG_SZ))

#endif
