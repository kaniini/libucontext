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

#ifndef TYPE
# define TYPE(__proc)	.type	__proc, @function;
#endif

#define FUNC(__proc)					\
	.global __proc;					\
	.align  2;					\
	TYPE(__proc)					\
	ENT(__proc)					\
__proc:							\
	SETUP_FRAME(__proc)
#ifdef __clang__
#define END(__proc)
#else
#define END(__proc)					\
	.end	__proc;					\
	.size	__proc,.-__proc;
#endif

#ifdef EXPORT_UNPREFIXED
#define ALIAS(__alias, __real)				\
	.weak	__alias;				\
	__alias = __real;
#else
#define ALIAS(...)
#endif

#define REG_OFFSET(__reg)       (MCONTEXT_GREGS + ((__reg) * REG_SZ))

#endif
