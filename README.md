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
 * s390x

These archs require kernel assistance and use a syscall (the only assembly is the trampoline):

 * ppc
 * ppc64 (ELFv2 ABI spec only, ELFv1 not supported)


## building

`libucontext` uses a simple makefile build system.  You should define `ARCH=` at build time, otherwise
the build system will attempt to guess using `uname -m`.

```
$ make ARCH=x86_64
$ make ARCH=x86_64 check
$ make ARCH=x86_64 DESTDIR=out install
```


## support

`libucontext` is offered as part of the `gcompat` project.  Accordingly, please address all questions
and bug reports to gcompat@lists.adelielinux.org.
