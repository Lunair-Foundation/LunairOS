.RECIPEPREFIX := >

TOP ?= ..
BUILD ?= $(TOP)/build
PROJECT ?= LunairOS
VERSION ?= 0.1.0
CODENAME ?= Mirage

ISO_ROOT ?= $(BUILD)/iso
KERNEL_IMAGE ?= $(BUILD)/kernel/bzImage
INITRAMFS_IMAGE ?= $(BUILD)/initramfs.cpio.gz
ISO_IMAGE ?= $(BUILD)/$(PROJECT)-$(CODENAME)-$(VERSION).iso
GRUB_CFG ?= $(TOP)/iso/boot/grub/grub.cfg

.PHONY: all clean list FORCE

all: $(ISO_IMAGE)

$(ISO_IMAGE): FORCE
>echo "[*] Montando ISO $(PROJECT) $(VERSION) \"$(CODENAME)\"..."
>@test -f "$(KERNEL_IMAGE)" || { echo "[!] Kernel não encontrado: $(KERNEL_IMAGE)"; exit 1; }
>@test -f "$(INITRAMFS_IMAGE)" || { echo "[!] Initramfs não encontrada: $(INITRAMFS_IMAGE)"; exit 1; }
>@command -v grub-mkrescue >/dev/null 2>&1 || { echo "[!] grub-mkrescue não encontrado"; exit 1; }
>rm -rf "$(ISO_ROOT)"
>mkdir -p "$(ISO_ROOT)/boot/grub"
>cp "$(KERNEL_IMAGE)" "$(ISO_ROOT)/boot/bzImage"
>cp "$(INITRAMFS_IMAGE)" "$(ISO_ROOT)/boot/initramfs.cpio.gz"
>cp "$(GRUB_CFG)" "$(ISO_ROOT)/boot/grub/grub.cfg"
>grub-mkrescue -o "$(ISO_IMAGE)" "$(ISO_ROOT)"
>echo "[✓] ISO pronta: $(ISO_IMAGE)"

list: $(ISO_IMAGE)
>xorriso -indev "$(ISO_IMAGE)" -find / -type f -print

clean:
>rm -rf "$(ISO_ROOT)" "$(ISO_IMAGE)"

FORCE:
