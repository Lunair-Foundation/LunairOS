
.RECIPEPREFIX := >

TOP := $(CURDIR)

PROJECT := LunairOS
VERSION := 0.2.0

BUILD := $(TOP)/build
ROOTFS := $(BUILD)/rootfs

.PHONY: all rootfs base-files clean distclean rebuild-rootfs

all: base-files

rootfs:
>mkdir -p "$(ROOTFS)/bin"
>mkdir -p "$(ROOTFS)/dev"
>mkdir -p "$(ROOTFS)/etc"
>mkdir -p "$(ROOTFS)/home"
>mkdir -p "$(ROOTFS)/proc"
>mkdir -p "$(ROOTFS)/root"
>mkdir -p "$(ROOTFS)/run"
>mkdir -p "$(ROOTFS)/sys"
>mkdir -p "$(ROOTFS)/tmp"
>mkdir -p "$(ROOTFS)/usr"
>mkdir -p "$(ROOTFS)/var"

base-files: rootfs
>echo 'root:x:0:0:root:/root:/bin/sh' > "$(ROOTFS)/etc/passwd"
>echo 'root:x:0:' > "$(ROOTFS)/etc/group"
>echo 'lunairos' > "$(ROOTFS)/etc/hostname"

>printf '%s\n' \
>'NAME="LunairOS"' \
>'PRETTY_NAME="LunairOS $(VERSION)"' \
>'ID=lunairos' \
>'VERSION="$(VERSION)"' \
>'VERSION_ID="$(VERSION)"' \
>'HOME_URL="https://github.com/Lunair-Foundation/LunairOS"' \
>'SUPPORT_URL="https://github.com/Lunair-Foundation/LunairOS/issues"' \
>'BUG_REPORT_URL="https://github.com/Lunair-Foundation/LunairOS/issues"' \
> > "$(ROOTFS)/etc/os-release"

rebuild-rootfs:
>rm -rf "$(ROOTFS)"
>$(MAKE) base-files

clean:
>rm -rf "$(ROOTFS)"

distclean:
>rm -rf "$(BUILD)"
