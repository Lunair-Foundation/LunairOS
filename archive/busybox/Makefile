TOP ?= $(abspath ..)
BUSYBOX_VERSION ?= 1.36.1
BUSYBOX_CC ?= musl-gcc
JOBS ?= $(shell nproc)

DL_DIR := $(TOP)/build/distfiles
SRC_DIR := $(TOP)/build/busybox-$(BUSYBOX_VERSION)
OUT_DIR := $(TOP)/build/busybox
TARBALL := $(DL_DIR)/busybox-$(BUSYBOX_VERSION).tar.bz2
CONFIG_FILE := $(TOP)/configs/busybox.config
OUT := $(OUT_DIR)/busybox

.PHONY: all fetch extract config menuconfig build clean distclean list check

all: $(OUT)

fetch:
	mkdir -p "$(DL_DIR)"
	test -f "$(TARBALL)" || wget -O "$(TARBALL)" "https://busybox.net/downloads/busybox-$(BUSYBOX_VERSION).tar.bz2"

extract: fetch
	mkdir -p "$(TOP)/build"
	test -d "$(SRC_DIR)" || tar -xf "$(TARBALL)" -C "$(TOP)/build"

config: extract
	cd "$(SRC_DIR)" && make allnoconfig
	python3 "$(TOP)/busybox/set-busybox-config.py" "$(SRC_DIR)/.config"
	cd "$(SRC_DIR)" && yes "" | make oldconfig
	mkdir -p "$(TOP)/configs"
	cp "$(SRC_DIR)/.config" "$(CONFIG_FILE)"
	@echo "[✓] Config salva em $(CONFIG_FILE)"

menuconfig: config
	cd "$(SRC_DIR)" && make menuconfig
	cp "$(SRC_DIR)/.config" "$(CONFIG_FILE)"

build: config
	cd "$(SRC_DIR)" && make -j$(JOBS) CC="$(BUSYBOX_CC)"

$(OUT): build
	mkdir -p "$(OUT_DIR)"
	cp "$(SRC_DIR)/busybox" "$(OUT)"
	chmod +x "$(OUT)"
	file "$(OUT)"
	"$(OUT)" --list | wc -l

list: $(OUT)
	"$(OUT)" --list

check: $(OUT)
	file "$(OUT)"
	"$(OUT)" --list
	"$(OUT)" --list | wc -l

clean:
	test ! -d "$(SRC_DIR)" || $(MAKE) -C "$(SRC_DIR)" clean
	rm -rf "$(OUT_DIR)"

distclean:
	rm -rf "$(SRC_DIR)" "$(OUT_DIR)"
