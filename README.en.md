# LunairOS

### [Português](README.md) • English

LunairOS is an independent Linux distribution focused on bringing a modern take on skeuomorphism, while maintaining stability and incorporating elements of the BSD philosophy. 

## Current release

**LunairOS 0.1.1 "Turmoil"**

## Status

Currently, the system:
- Compiles a custom Linux kernel
- Builds a BusyBox-based initramfs
- Includes a small custom userland
- Generates a bootable ISO image with GRUB
- Can be tested in QEMU

## Dependencies

### Tools required to build the ISO

- GRUB
- xorriso
- mtools
- cpio
- gzip
- file

### Tools required to compile the kernel

- gcc or clang
- make
- bc
- bison
- flex
- OpenSSL
- libelf
- dwarves

### Additional dependencies

- Static BusyBox
- musl-tools
- wget
- tar
- xz

## Install dependencies (Debian/Ubuntu)

```sh
make install-deps-debian
```

## Compile the system

### Compile only the userland

```sh
make builduserland
```

### Build the initramfs

```sh
make buildworld
```

### Build the full release

```sh
make release
```

This will:
- Check dependencies
- Compile the kernel
- Build the userland
- Generate the initramfs
- Create the bootable ISO

## Run in QEMU

```sh
make run
```

## Cleanup

### Clean intermediate files

```sh
make clean
```

### Remove the entire build directory

```sh
make distclean
```

## Project structure

```text
kernel/        - Linux kernel build and configuration
initramfs/     - Initramfs structure
userland/      - Userland programs
iso/           - ISO generation and GRUB configuration
build/         - Files generated during the build
```

## License

LunairOS is licensed under the GNU General Public License v3.0 (GPLv3). 

## Third-party software

LunairOS uses:

- Linux kernel (GPLv2)
- BusyBox (GPLv2)
- GRUB
