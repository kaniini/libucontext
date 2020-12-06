# `libucontext`

`libucontext` is a library which provides the `ucontext.h` C API.  Unlike other implementations,
it faithfully follows the kernel process ABI when doing context swaps.

Notably, when combined with `gcompat`, it provides a fully compatible implementation of the ucontext
functions that are ABI compatible with glibc.

Since version 0.13, for some architectures, you can deploy to bare metal using newlib via the
`FREESTANDING=yes` make option.  Systems which use a syscall cannot work this way.  The table
below shows which architecture ports have been adapted to build with `FREESTANDING=yes`.


## supported architectures

Adding support for new architectures is easy, but you need to know assembly language to do it.

| Architecture | Works on musl | Syscall | Supports FREESTANDING |
|--------------|---------------|---------|-----------------------|
|    aarch64   | ✓             |         | ✓                     |
|      arm     | ✓             |         | ✓                     |
|     m68k     | ✓             |         | ✓                     |
|     mips     | ✓             |         | ✓                     |
|    mips64    | ✓             |         | ✓                     |
|      ppc     | ✓             | ✓       |                       |
|     ppc64    | ✓             | ✓       |                       |
|    riscv64   | ✓             |         | ✓                     |
|     s390x    | ✓             |         | ✓                     |
|      x86     | ✓             |         | ✓                     |
|    x86_64    | ✓             |         | ✓                     |


## building

`libucontext` uses a simple makefile build system.  You should define `ARCH=` at build time, otherwise
the build system will attempt to guess using `uname -m`.

```
$ make ARCH=x86_64
$ make ARCH=x86_64 check
$ make ARCH=x86_64 DESTDIR=out install
```
