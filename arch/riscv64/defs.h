#ifndef __ARCH_RISCV64_DEFS_H
#define __ARCH_RISCV64_DEFS_H

#define REG_SZ		(8)
#define MCONTEXT_GREGS	(176)

/* program counter is saved in x0 as well as x1, similar to mips */
#define REG_PC_SAVE	(0)
#define REG_PC		(1)
#define REG_SP		(2)
#define REG_S0		(8)
#define REG_S1		(9)
#define REG_A0		(10)
#define REG_A1		(11)
#define REG_A2		(12)
#define REG_A3		(13)
#define REG_A4		(14)
#define REG_A5		(15)
#define REG_A6		(16)
#define REG_A7		(17)
#define REG_S2		(18)
#define REG_S3		(19)
#define REG_S4		(20)
#define REG_S5		(21)
#define REG_S6		(22)
#define REG_S7		(23)
#define REG_S8		(24)
#define REG_S9		(25)
#define REG_S10		(26)
#define REG_S11		(27)

#define PC_OFFSET	REG_OFFSET(REG_PC_SAVE)

#include "common-defs.h"

#endif
