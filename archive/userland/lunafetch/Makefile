.RECIPEPREFIX := >

PROG := lunafetch
SRCS := lunafetch.c

CC ?= musl-gcc
CFLAGS ?= -static -Os -s -Wall -Wextra

DESTDIR ?= ../../build/userland
BINDIR := $(DESTDIR)/bin

.PHONY: all install clean

all: $(PROG)

$(PROG): $(SRCS)
>$(CC) $(CFLAGS) -o $(PROG) $(SRCS)

install: $(PROG)
>mkdir -p "$(BINDIR)"
>cp "$(PROG)" "$(BINDIR)/$(PROG)"
>chmod 755 "$(BINDIR)/$(PROG)"

clean:
>rm -f "$(PROG)"
