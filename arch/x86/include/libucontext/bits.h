#ifndef LIBUCONTEXT_BITS_H
#define LIBUCONTEXT_BITS_H

#define LIBUCONTEXT_REG_GS		(0)
#define LIBUCONTEXT_REG_FS		(1)
#define LIBUCONTEXT_REG_ES		(2)
#define LIBUCONTEXT_REG_DS		(3)
#define LIBUCONTEXT_REG_EDI		(4)
#define LIBUCONTEXT_REG_ESI		(5)
#define LIBUCONTEXT_REG_EBP		(6)
#define LIBUCONTEXT_REG_ESP		(7)
#define LIBUCONTEXT_REG_EBX		(8)
#define LIBUCONTEXT_REG_EDX		(9)
#define LIBUCONTEXT_REG_ECX		(10)
#define LIBUCONTEXT_REG_EAX		(11)
#define LIBUCONTEXT_REG_EIP		(14)

typedef int libucontext_greg_t, libucontext_gregset_t[19];

typedef struct libucontext_fpstate {
	unsigned long cw, sw, tag, ipoff, cssel, dataoff, datasel;
	struct {
		unsigned short significand[4], exponent;
	} _st[8];
	unsigned long status;
} *libucontext_fpregset_t;

typedef struct {
	libucontext_gregset_t gregs;
	libucontext_fpregset_t fpregs;
	unsigned long oldmask, cr2;
} libucontext_mcontext_t;

typedef struct {
	void *ss_sp;
	int ss_flags;
	size_t ss_size;
} libucontext_stack_t;

typedef struct libucontext_ucontext {
	unsigned long uc_flags;
	struct libucontext_ucontext *uc_link;
	libucontext_stack_t uc_stack;
	libucontext_mcontext_t uc_mcontext;
	unsigned char __sigmask[128];
	unsigned long __fpregs_mem[28];
} libucontext_ucontext_t;

#endif
