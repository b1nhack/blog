+++
title = "Linux Kernel Development and Debugging on macOS"
date = "2025-06-02"
updated = 2025-06-03
description = "macOS搭建Linux Kernel开发调试环境"
+++

我使用搭载[Apple silicon](https://en.wikipedia.org/wiki/Apple_silicon)的MacBook Pro, 通过Linux虚拟机跨平台编译x86_64内核, 开发和调试都在macOS中原生进行. Linux Kernel VRED (Vulnerability Research and Exploit Development)通常不修改内核代码, 不需要频繁编译.

## Create Disk Image

Linux内核开发需要大小写敏感的文件系统. macOS文件系统默认大小写不敏感, 查看[Create a blank disk image for storage](https://support.apple.com/guide/disk-utility/create-a-disk-image-dskutl11888/22.6/mac/15.0), 创建一个大小写敏感的空白磁盘映像.

挂载创建的磁盘映像, 克隆Linux Kernel仓库. 默认挂载到`/Volumes`下.

## Create Linux VM

我使用[Parallels Desktop](https://www.parallels.com)虚拟机管理程序创建[Debian](https://www.debian.org)虚拟机, 也可以使用[UTM](https://mac.getutm.app), 开源免费.

安装Debian软件包:

```bash
sudo apt update
sudo apt install build-essential crossbuild-essential-amd64 bc bison flex libncurses-dev libelf-dev libssl-dev
sudo apt install debootstrap qemu-user-static # syzkaller create-image.sh required
```

共享大小写敏感的磁盘到虚拟机. 虚拟机需要安装Parallels Tools, 否则不会自动挂载共享的磁盘. 默认自动挂载到`/media/psf`下.

## Compile

设置一些跨平台编译所需的环境变量:

```bash
export ARCH=x86_64
export CROSS_COMPILE=x86_64-linux-gnu-
export CC=x86_64-linux-gnu-gcc
```

生成默认的内核配置文件: `make defconfig`, 编辑`.config`文件启用下面的内核配置选项:

```
# Debug info for symbolization.
CONFIG_DEBUG_INFO_DWARF4=y

# Required for Debian Stretch and later
CONFIG_CONFIGFS_FS=y
CONFIG_SECURITYFS=y
```

更新内核配置文件: `make olddefconfig`, 编译内核: ``` make -j`nproc` ```.

## Code Navigation

我使用[Ctags](https://ctags.io)和[Cscope](https://cscope.sourceforge.net)导航内核代码, 速度极快. Neovim需要安装第三方Cscope插件, 推荐使用[cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim).

Linux内核项目的Makefile中有`tags`和`cscope`目标, 生成各自依赖的索引文件. 仅对已编译的源文件生成索引文件, 可通过设置`COMPILED_SOURCE`环境变量实现.

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

查看[syzkaller](https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md#image)的教程, 创建Debian Linux映像, 复制到共享磁盘.

使用[QEMU](https://www.qemu.org)运行Linux内核:

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

参数说明查看[System Emulation](https://www.qemu.org/docs/master/system/index.html)官方文档.

使用[gdb](https://www.sourceware.org/gdb) + [pwndbg](https://pwndbg.re)调试内核, 推荐使用Nix安装pwndbg: `nix profile install github:pwndbg/pwndbg`.
