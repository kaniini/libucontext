#pragma once

typedef unsigned long libucontext_greg_t, libucontext_gregset_t[48];
typedef double libucontext_fpregset_t[33];

typedef struct {
#ifdef __GNUC__
	__attribute__((__aligned__(16)))
#endif
	unsigned vrregs[32][4];
	struct {
#if __BIG_ENDIAN__
		unsigned _pad[3], vscr_word;
#else
		unsigned vscr_word, _pad[3];
#endif
	} vscr;
	unsigned vrsave, _pad[3];
} libucontext_vrregset_t;

typedef struct {
	unsigned long _unused[4];
	int signal;
	int _pad0;
	unsigned long handler;
	unsigned long oldmask;
	struct pt_regs *regs;
	libucontext_gregset_t gp_regs;
	libucontext_fpregset_t fp_regs;
	libucontext_vrregset_t *v_regs;
	long vmx_reserve[34+34+32+1];
} libucontext_mcontext_t;

typedef struct {
	void *ss_sp;
	int ss_flags;
	size_t ss_size;
} libucontext_stack_t;

typedef struct __ucontext {
	unsigned long uc_flags;
	struct __ucontext *uc_link;
	libucontext_stack_t uc_stack;
	unsigned char __sigmask[128];
	libucontext_mcontext_t uc_mcontext;
} libucontext_ucontext_t;
