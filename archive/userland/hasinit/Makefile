.RECIPEPREFIX := >

PROG := hasinit
SRCS := hasinit.c

CC ?= musl-gcc
CFLAGS ?= -static -Os -s -Wall -Wextra

DESTDIR ?= ../../build/userland
LIBEXECDIR := $(DESTDIR)/libexec/lunairos

.PHONY: all install clean

all: $(PROG)

$(PROG): $(SRCS)
>$(CC) $(CFLAGS) -o $(PROG) $(SRCS)

install: $(PROG)
>mkdir -p "$(LIBEXECDIR)"
>cp "$(PROG)" "$(LIBEXECDIR)/$(PROG)"
>chmod 700 "$(LIBEXECDIR)/$(PROG)"

clean:
>rm -f "$(PROG)"
