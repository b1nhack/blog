+++
title = "Linux Kernel Development and Debugging on macOS"
description = "A Linux Kernel development and debugging environment on macOS."
date = 2025-06-02
updated = 2025-06-03
draft = false

[extra]
copy_button = true
code_block_name_links = true
mermaid = false
+++

I use a MacBook Pro with [Apple silicon](https://en.wikipedia.org/wiki/Apple_silicon) and cross-compile the x86_64 kernel through a Linux VM, while all development and debugging happens natively on macOS. Linux Kernel VRED (Vulnerability Research and Exploit Development) usually doesn't modify kernel code, so frequent rebuilds aren't needed.

## Create Disk Image

Linux kernel development requires a case-sensitive filesystem. The macOS filesystem is case-insensitive by default — follow [Create a blank disk image for storage](https://support.apple.com/guide/disk-utility/create-a-disk-image-dskutl11888/22.6/mac/15.0) to create a blank case-sensitive disk image.

Mount the image you created and clone the Linux Kernel repository into it. Mounted images show up under `/Volumes` by default.

## Create Linux VM

I use the [Parallels Desktop](https://www.parallels.com) hypervisor to create a [Debian](https://www.debian.org) VM; [UTM](https://mac.getutm.app) also works and is open source and free.

Install the Debian packages:

```bash
sudo apt update
sudo apt install build-essential crossbuild-essential-amd64 bc bison flex libncurses-dev libelf-dev libssl-dev
sudo apt install debootstrap qemu-user-static # syzkaller create-image.sh required
```

Share the case-sensitive disk with the VM. Parallels Tools must be installed inside the VM, otherwise the shared disk won't be mounted automatically. It auto-mounts under `/media/psf` by default.

## Compile

Set the environment variables needed for cross-compiling:

```bash
export ARCH=x86_64
export CROSS_COMPILE=x86_64-linux-gnu-
export CC=x86_64-linux-gnu-gcc
```

Generate the default kernel config with `make defconfig`, then edit the `.config` file to enable the following kernel config options:

```
# Debug info for symbolization.
CONFIG_DEBUG_INFO_DWARF4=y

# Required for Debian Stretch and later
CONFIG_CONFIGFS_FS=y
CONFIG_SECURITYFS=y
```

Update the kernel config with `make olddefconfig`, then build the kernel: ``` make -j`nproc` ```.

## Code Navigation

I navigate the kernel with [Ctags](https://ctags.io) and [Cscope](https://cscope.sourceforge.net) — extremely fast. Neovim requires a third-party Cscope plugin; [cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim) is recommended.

The Linux kernel Makefile provides `tags` and `cscope` targets that generate the respective index files. To generate indexes only for sources that have been compiled, set the `COMPILED_SOURCE` environment variable.

```sh,name=https://elixir.bootlin.com/linux/v6.15/source/scripts/tags.sh#L109
all_target_sources()
{
	if [ -n "$COMPILED_SOURCE" ]; then
		all_compiled_sources
	else
		all_sources
	fi
}
```

## Debugging

Follow the [syzkaller](https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md#image) tutorial to create a Debian Linux image, then copy it to the shared disk.

Boot the Linux kernel with [QEMU](https://www.qemu.org):

```bash
qemu-system-x86_64 \
	-m 2G \
	-smp 2 \
	-kernel <bzImage> \
	-append "console=ttyS0 root=/dev/sda net.ifnames=0" \
	-drive file=<stretch.img>,format=raw \
	-net user,host=10.0.2.31,hostfwd=tcp:127.0.0.1:2222-:22 \
	-net nic,model=e1000 \
	-nographic \
	-no-reboot \
	-pidfile vm.pid -s
```

See the official [System Emulation](https://www.qemu.org/docs/master/system/index.html) documentation for what the options do.

Debug the kernel with [gdb](https://www.sourceware.org/gdb) + [pwndbg](https://pwndbg.re); installing pwndbg via Nix is recommended: `nix profile install github:pwndbg/pwndbg`.
