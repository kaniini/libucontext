# `libucontext`

`libucontext` is a library which provides the `ucontext.h` C API.  Unlike other implementations,
it faithfully follows the kernel process ABI when doing context swaps.

Notably, when combined with `gcompat`, it provides a fully compatible implementation of the ucontext
functions that are ABI compatible with glibc.


## supported architectures

Adding support for new architectures is easy, but you need to know assembly language to do it.

Right now these archs are supported and should work on bare metal:

 * x86
 * x86_64
 * armv6+ (`arm`)
 * aarch64

These archs require kernel assistance and use a syscall (the only assembly is the trampoline):

 * ppc
