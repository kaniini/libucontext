#ifndef LIBUCONTEXT_BITS_H
#define LIBUCONTEXT_BITS_H

typedef unsigned long long int libucontext_greg_t;
typedef unsigned long int libucontext_sigset_t;

typedef struct {
	__uint128_t vregs[32];
	libucontext_greg_t fpsr;
	libucontext_greg_t fpcr;
} libucontext_fpregset_t;

typedef struct {
	libucontext_greg_t fault_address;
	libucontext_greg_t regs[31];
	libucontext_greg_t sp, pc, pstate;
	double __reserved[256];
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
	libucontext_sigset_t uc_sigmask;
	unsigned char __pad[128];
	libucontext_mcontext_t uc_mcontext;
} libucontext_ucontext_t;

#endif
