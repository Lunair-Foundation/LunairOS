#!/usr/bin/env bash
set -euo pipefail

TOP="$(cd "$(dirname "$0")/.." && pwd)"

VERSION="1.36.1"

BUILD="$TOP/build"
ROOTFS="$BUILD/rootfs"

SRC="$BUILD/sources"
BUSYBOX_SRC="$SRC/busybox-$VERSION"

mkdir -p "$SRC" "$ROOTFS"

if [ ! -d "$BUSYBOX_SRC" ]; then
    wget "https://busybox.net/downloads/busybox-$VERSION.tar.bz2" \
        -O "$SRC/busybox.tar.bz2"

    tar -xf "$SRC/busybox.tar.bz2" -C "$SRC"
fi

cd "$BUSYBOX_SRC"

make mrproper

cp "$TOP/configs/busybox.config" .config


make defconfig
make oldconfig

make -j"$(nproc)"

make CONFIG_PREFIX="$ROOTFS" install
