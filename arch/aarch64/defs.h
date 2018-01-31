#ifndef __ARCH_AARCH64_DEFS_H
#define __ARCH_AARCH64_DEFS_H

#define REGSZ		8
#define R0_OFFSET	184
#define SP_OFFSET	432
#define PC_OFFSET	440
#define PSTATE_OFFSET	448

#ifndef FPSIMD_MAGIC
# define FPSIMD_MAGIC	0x46508001
#endif

#ifndef ESR_MAGIC
# define ESR_MAGIC	0x45535201
#endif

#endif
