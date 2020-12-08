SCDOC := scdoc

ARCH := $(shell uname -m)
ifeq ($(ARCH),$(filter $(ARCH),i386 i686))
	override ARCH = x86
endif

LIBDIR := /lib
INCLUDEDIR := /usr/include
PKGCONFIGDIR := /usr/lib/pkgconfig
CFLAGS := -ggdb3 -O2 -Wall
CPPFLAGS := -Iinclude -Iarch/${ARCH} -Iarch/common
EXPORT_UNPREFIXED := yes
FREESTANDING := no

ifeq ($(FREESTANDING),yes)
	CFLAGS += -DFREESTANDING -isystem arch/${ARCH}/freestanding
	EXPORT_UNPREFIXED = no
endif

ifeq ($(EXPORT_UNPREFIXED),yes)
	CFLAGS += -DEXPORT_UNPREFIXED
endif

LIBUCONTEXT_C_SRC = $(wildcard arch/${ARCH}/*.c)
LIBUCONTEXT_S_SRC = $(wildcard arch/${ARCH}/*.S)

LIBUCONTEXT_VERSION = 0.13
LIBUCONTEXT_OBJ = ${LIBUCONTEXT_C_SRC:.c=.o} ${LIBUCONTEXT_S_SRC:.S=.o}
LIBUCONTEXT_SOVERSION = 0
LIBUCONTEXT_NAME = libucontext.so
LIBUCONTEXT_STATIC_NAME = libucontext.a
LIBUCONTEXT_PC = libucontext.pc
LIBUCONTEXT_SONAME = libucontext.so.${LIBUCONTEXT_SOVERSION}
LIBUCONTEXT_PATH = ${LIBDIR}/${LIBUCONTEXT_SONAME}
LIBUCONTEXT_STATIC_PATH = ${LIBDIR}/${LIBUCONTEXT_STATIC_NAME}
LIBUCONTEXT_HEADERS = \
	include/libucontext/libucontext.h \
	include/libucontext/bits.h

all: ${LIBUCONTEXT_SONAME} ${LIBUCONTEXT_STATIC_NAME} ${LIBUCONTEXT_PC}

${LIBUCONTEXT_STATIC_NAME}: ${LIBUCONTEXT_OBJ}
	$(AR) rcs ${LIBUCONTEXT_STATIC_NAME} ${LIBUCONTEXT_OBJ}

${LIBUCONTEXT_NAME}: ${LIBUCONTEXT_HEADERS} ${LIBUCONTEXT_OBJ}
	$(CC) -fPIC -o ${LIBUCONTEXT_NAME} -Wl,-soname,${LIBUCONTEXT_SONAME} \
		-shared ${LIBUCONTEXT_OBJ} ${LDFLAGS}

${LIBUCONTEXT_SONAME}: ${LIBUCONTEXT_NAME}
	ln -sf ${LIBUCONTEXT_NAME} ${LIBUCONTEXT_SONAME}

${LIBUCONTEXT_PC}: libucontext.pc.in
	sed -e s:@LIBUCONTEXT_VERSION@:${LIBUCONTEXT_VERSION}:g \
	    -e s:@LIBUCONTEXT_LIBDIR@:${LIBDIR}:g \
	    -e s:@LIBUCONTEXT_INCLUDEDIR@:${INCLUDEDIR}:g $< > $@

MANPAGES_SYMLINKS_3 = \
	doc/libucontext_getcontext.3 \
	doc/libucontext_makecontext.3 \
	doc/libucontext_setcontext.3 \
	doc/libucontext_swapcontext.3
MANPAGES_3 = doc/libucontext.3

MANPAGES = ${MANPAGES_3}

.scd.3:
	${SCDOC} < $< > $@

.SUFFIXES: .scd .3

docs: ${MANPAGES}

.c.o:
	$(CC) -std=c99 -D_BSD_SOURCE -fPIC -DPIC ${CFLAGS} ${CPPFLAGS} -c -o $@ $<

.S.o:
	$(CC) -fPIC -DPIC -DLIBUCONTEXT_ASSEMBLY ${CFLAGS} ${CPPFLAGS} -c -o $@ $<

clean:
	rm -f ${LIBUCONTEXT_NAME} ${LIBUCONTEXT_SONAME} ${LIBUCONTEXT_STATIC_NAME} \
		${LIBUCONTEXT_OBJ} ${LIBUCONTEXT_PC} \
		include/libucontext/bits.h test_libucontext ${MANPAGES}

install: all
	install -D -m755 ${LIBUCONTEXT_NAME} ${DESTDIR}${LIBUCONTEXT_PATH}
	install -D -m664 ${LIBUCONTEXT_STATIC_NAME} ${DESTDIR}${LIBUCONTEXT_STATIC_PATH}
	ln -sf ${LIBUCONTEXT_SONAME} ${DESTDIR}${LIBDIR}/${LIBUCONTEXT_NAME}
	for i in ${LIBUCONTEXT_HEADERS}; do \
		destfn=$$(echo $$i | sed s:include/::g); \
		install -D -m644 $$i ${DESTDIR}${INCLUDEDIR}/$$destfn; \
	done
	install -D -m644 ${LIBUCONTEXT_PC} ${DESTDIR}${PKGCONFIGDIR}

check: test_libucontext ${LIBUCONTEXT_SONAME}
	env LD_LIBRARY_PATH=$(shell pwd) ./test_libucontext

test_libucontext: test_libucontext.c ${LIBUCONTEXT_NAME}
	$(CC) -std=c99 -D_BSD_SOURCE ${CFLAGS} ${CPPFLAGS} $@.c -o $@ -L. -lucontext

ifeq ($(FREESTANDING),no)

include/libucontext/bits.h: arch/common/bits.h
	cp arch/common/bits.h $@

else

include/libucontext/bits.h: arch/${ARCH}/freestanding/bits.h
	cp arch/${ARCH}/freestanding/bits.h $@

endif

.PHONY: check
