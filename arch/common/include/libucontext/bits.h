#ifndef LIBUCONTEXT_BITS_H
#define LIBUCONTEXT_BITS_H

#ifndef FREESTANDING

#include <ucontext.h>

/* glibc on powerpc does not define greg_t */
#if defined(__GLIBC__) && defined(__powerpc__)
typedef unsigned long greg_t;
#endif

typedef greg_t libucontext_greg_t;
typedef ucontext_t libucontext_ucontext_t;

#endif

#endif
