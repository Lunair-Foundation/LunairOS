.RECIPEPREFIX := >

TOP ?= $(abspath ..)
DESTDIR ?= $(TOP)/build/userland

SUBDIRS := $(sort $(dir $(wildcard */Makefile)))

.PHONY: all install clean $(SUBDIRS)

all:
>@for dir in $(SUBDIRS); do \
>    echo "[USERLAND] build $$dir"; \
>    $(MAKE) -C $$dir TOP="$(TOP)" DESTDIR="$(DESTDIR)" all || exit 1; \
>done

install:
>mkdir -p "$(DESTDIR)"
>@for dir in $(SUBDIRS); do \
>    echo "[USERLAND] install $$dir"; \
>    $(MAKE) -C $$dir TOP="$(TOP)" DESTDIR="$(DESTDIR)" install || exit 1; \
>done

clean:
>@for dir in $(SUBDIRS); do \
>    echo "[USERLAND] clean $$dir"; \
>    $(MAKE) -C $$dir TOP="$(TOP)" DESTDIR="$(DESTDIR)" clean || exit 1; \
>done
