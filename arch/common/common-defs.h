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

#define FUNC(__proc)					\
	.globl 	__proc;					\
	.align  2;					\
	.type   __proc, @function;			\
	.ent    __proc, 0;				\
__proc:							\
	SETUP_FRAME(__proc)

#define END(__proc)					\
	.end	__proc;					\
	.size	__proc,.-__proc;

#endif
