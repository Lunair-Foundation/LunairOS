.RECIPEPREFIX := >

TOP ?= ..
BUILD ?= $(TOP)/build
KERNEL_VERSION ?= 6.9.12
KERNEL_URL ?= https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$(KERNEL_VERSION).tar.xz
JOBS ?= $(shell nproc 2>/dev/null || echo 1)

KBUILD ?= $(BUILD)/kernel
CONFIG ?= $(TOP)/configs/kernel.config
DEFAULT_KSRC := $(if $(wildcard $(TOP)/linux-$(KERNEL_VERSION)/Makefile),$(TOP)/linux-$(KERNEL_VERSION),$(KBUILD)/linux-$(KERNEL_VERSION))
KSRC ?= $(DEFAULT_KSRC)
TARBALL ?= $(KBUILD)/linux-$(KERNEL_VERSION).tar.xz
KERNEL_IMAGE ?= $(KBUILD)/bzImage

.PHONY: all config menuconfig clean distclean mrproper

all: $(KERNEL_IMAGE)

$(KBUILD):
>mkdir -p "$@"

$(TARBALL): | $(KBUILD)
>echo "[*] Baixando Linux $(KERNEL_VERSION)..."
>wget -c -O "$@" "$(KERNEL_URL)"

ifeq ($(wildcard $(KSRC)/Makefile),)
$(KSRC)/Makefile: $(TARBALL)
>echo "[*] Extraindo kernel em $(KBUILD)..."
>rm -rf "$(KSRC)"
>mkdir -p "$(KBUILD)"
>tar -C "$(KBUILD)" -xf "$(TARBALL)"
else
$(KSRC)/Makefile:
>@true
endif

$(KSRC)/.config: $(CONFIG) $(KSRC)/Makefile
>echo "[*] Aplicando config do kernel..."
>cp "$(CONFIG)" "$(KSRC)/.config"
>@if [ -x "$(KSRC)/scripts/config" ]; then \
>    "$(KSRC)/scripts/config" --disable WERROR || true; \
>    "$(KSRC)/scripts/config" --set-str SYSTEM_TRUSTED_KEYS "" || true; \
>    "$(KSRC)/scripts/config" --set-str SYSTEM_REVOCATION_KEYS "" || true; \
>fi
>$(MAKE) -C "$(KSRC)" olddefconfig

config: $(KSRC)/.config

menuconfig: $(KSRC)/.config
>$(MAKE) -C "$(KSRC)" menuconfig
>cp "$(KSRC)/.config" "$(CONFIG)"

$(KERNEL_IMAGE): $(KSRC)/.config
>echo "[*] Compilando kernel com $(JOBS) job(s)..."
>$(MAKE) -C "$(KSRC)" -j"$(JOBS)"
>mkdir -p "$(KBUILD)"
>cp "$(KSRC)/arch/x86/boot/bzImage" "$(KERNEL_IMAGE)"
>echo "[✓] Kernel pronto: $(KERNEL_IMAGE)"

clean:
>@if [ -d "$(KSRC)" ]; then $(MAKE) -C "$(KSRC)" clean || true; fi
>rm -f "$(KERNEL_IMAGE)"

mrproper:
>@if [ -d "$(KSRC)" ]; then $(MAKE) -C "$(KSRC)" mrproper || true; fi
>rm -f "$(KERNEL_IMAGE)"

distclean:
>rm -rf "$(KBUILD)"
