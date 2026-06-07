.RECIPEPREFIX := >

TOP ?= ..
BUILD ?= $(TOP)/build
ROOT ?= $(BUILD)/initramfs
INITRAMFS_IMAGE ?= $(BUILD)/initramfs.cpio.gz
USERLAND_DEST ?= $(BUILD)/userland

BUSYBOX ?= $(shell if [ -x "$(TOP)/result/bin/busybox" ]; then printf "%s" "$(TOP)/result/bin/busybox"; elif [ -x /bin/busybox ]; then printf "%s" "/bin/busybox"; else printf "%s" "busybox"; fi)

APPLET_MODE ?= minimal
APPLETS ?= sh mount umount echo printf cat clear ls pwd cd mkdir rmdir rm cp mv ln \
           dmesg uname sleep reboot poweroff halt sync setsid cttyhack hostname \
           ps kill grep sed awk vi less more touch chmod chown test true false \
           env id whoami df free head tail date

.PHONY: all clean list shell-check FORCE

all: $(INITRAMFS_IMAGE)

$(INITRAMFS_IMAGE): FORCE
>echo "[*] Construindo initramfs..."
>@if [ ! -x "$(BUSYBOX)" ]; then \
>    echo "[!] BusyBox não encontrado: $(BUSYBOX)"; \
>    echo "    Debian: sudo apt install busybox-static"; \
>    exit 1; \
>fi
>@if command -v file >/dev/null 2>&1; then \
>    file "$(BUSYBOX)"; \
>    file "$(BUSYBOX)" | grep -qi "statically linked" || { echo "[!] BusyBox precisa ser estático"; exit 1; }; \
>fi
>rm -rf "$(ROOT)"
>mkdir -p "$(ROOT)/bin" "$(ROOT)/dev" "$(ROOT)/etc" "$(ROOT)/proc" "$(ROOT)/sys" "$(BUILD)"
>cp "$(TOP)/initramfs/init" "$(ROOT)/init"
>sed -i 's/\r$$//' "$(ROOT)/init"
>chmod 755 "$(ROOT)/init"
>@if [ -d "$(TOP)/initramfs/etc" ]; then cp -a "$(TOP)/initramfs/etc/." "$(ROOT)/etc/"; fi
>cp "$(BUSYBOX)" "$(ROOT)/bin/busybox"
>chmod 755 "$(ROOT)/bin/busybox"
>cd "$(ROOT)/bin" && \
>if [ "$(APPLET_MODE)" = "full" ]; then \
>    for applet in $$(./busybox --list); do \
>        [ "$$applet" = "busybox" ] && continue; \
>        ln -sf busybox "$$applet"; \
>    done; \
>else \
>    for applet in $(APPLETS); do \
>        ./busybox --list | grep -qx "$$applet" && ln -sf busybox "$$applet" || true; \
>    done; \
>fi; \
>ln -sf busybox sh; \
>ln -sf busybox setsid; \
>ln -sf busybox cttyhack
>echo "[INITRAMFS] Copiando userland..."
>@if [ -d "$(USERLAND_DEST)/bin" ]; then \
>    cp -a "$(USERLAND_DEST)/bin/." "$(ROOT)/bin/"; \
>fi
>@if [ -d "$(USERLAND_DEST)/libexec" ]; then \
>    mkdir -p "$(ROOT)/libexec"; \
>    cp -a "$(USERLAND_DEST)/libexec/." "$(ROOT)/libexec/"; \
>fi
>@if [ -f "$(USERLAND_DEST)/init" ]; then \
>    cp "$(USERLAND_DEST)/init" "$(ROOT)/init"; \
>    chmod 755 "$(ROOT)/init"; \
>fi
>mknod -m 600 "$(ROOT)/dev/console" c 5 1 2>/dev/null || true
>mknod -m 666 "$(ROOT)/dev/null" c 1 3 2>/dev/null || true
>mknod -m 666 "$(ROOT)/dev/tty" c 5 0 2>/dev/null || true
>cd "$(ROOT)" && find . -print0 | cpio --null -o -H newc --owner=0:0 | gzip -9 > "$(INITRAMFS_IMAGE)"
>echo "[*] Conferindo arquivos críticos..."
>@gzip -dc "$(INITRAMFS_IMAGE)" | cpio -t | grep -E '^(\./)?(init|bin/busybox|bin/sh|bin/setsid|bin/cttyhack|bin/lunafetch)$$' || true
>echo "[✓] Initramfs pronta: $(INITRAMFS_IMAGE)"

list: $(INITRAMFS_IMAGE)
>gzip -dc "$(INITRAMFS_IMAGE)" | cpio -t

clean:
>rm -rf "$(ROOT)" "$(INITRAMFS_IMAGE)"

shell-check:
>head -1 "$(TOP)/initramfs/init" | cat -A

FORCE:
