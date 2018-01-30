ARCH := x86_64

CFLAGS = -ggdb -O2 -Wall

LIBUCONTEXT_C_SRC = \
	arch/${ARCH}/makecontext.c

LIBUCONTEXT_S_SRC = \
	arch/${ARCH}/getcontext.S \
	arch/${ARCH}/setcontext.S \
	arch/${ARCH}/swapcontext.S \
	arch/${ARCH}/startcontext.S

LIBUCONTEXT_OBJ = ${LIBUCONTEXT_C_SRC:.c=.o} ${LIBUCONTEXT_S_SRC:.S=.o}
LIBUCONTEXT_SOVERSION = 0
LIBUCONTEXT_NAME = libucontext.so.${LIBUCONTEXT_SOVERSION}
LIBUCONTEXT_PATH = /lib/${LIBUCONTEXT_NAME}

all: ${LIBUCONTEXT_NAME}

${LIBUCONTEXT_NAME}: ${LIBUCONTEXT_OBJ}
	$(CC) -o ${LIBUCONTEXT_NAME} -Wl,-soname,${LIBUCONTEXT_NAME} \
		-shared ${LIBUCONTEXT_OBJ}

${LOADER_NAME}: ${LOADER_OBJ}
	$(CC) -o ${LOADER_NAME} -fPIE -static ${LOADER_OBJ}

.c.o:
	$(CC) -std=c99 -D_BSD_SOURCE -fPIC -DPIC ${CFLAGS} ${CPPFLAGS} -c -o $@ $<

.S.o:
	$(CC) -fPIC -DPIC ${CFLAGS} ${CPPFLAGS} -c -o $@ $<

clean:
	rm -f ${LIBUCONTEXT_NAME} ${LIBUCONTEXT_OBJ}

install: all
	install -D -m755 ${LIBUCONTEXT_NAME} ${DESTDIR}/${LIBUCONTEXT_PATH}
