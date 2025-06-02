+++
title = "Quality of Cyber Life"
date = "2025-05-29"
updated = 2025-06-02
description = "一些重要的非技术知识清单, 提升效率和生活质量."
+++

记录我在赛博世界的生活方式, 仅包含足以让感兴趣的人前进的指引. 推荐阅读[The Missing Semester of Your CS Education](https://missing.csail.mit.edu).

## Privacy Guides

真的需要仔细阅读[Privacy Guides](https://privacyguides.org).

## Keyboard Layout

我使用[Colemak](https://colemak.com)键盘布局, 并且将[Caps Lock](https://en.wikipedia.org/wiki/Caps_Lock)映射为[Esc](https://en.wikipedia.org/wiki/Esc_key)[^1]. 始终应该使用任何更高效, 更舒适的键盘布局替代[QWERTY](https://en.wikipedia.org/wiki/QWERTY), 如果你的余生需要长时间敲击键盘.

## Package Manager

我使用[Homebrew](https://brew.sh)和[Nix](https://nixos.org)包管理器, 分别用于管理GUI应用程序([Casks](https://formulae.brew.sh/cask/))和CLI软件包([Packages](https://search.nixos.org/packages)). 使用[Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)安装Nix.

[Brewfile](https://github.com/b1nhack/dotfiles/blob/main/Brewfile)记录了我通过Homebrew安装的Casks, 通过`brew bundle dump`命令导出. [nix-packages](https://github.com/b1nhack/dotfiles/blob/main/nix-packages)记录了我通过Nix安装的Packages, 通过`nix profile list > nix-packages`命令导出.

## Terminal Emulator

我使用[kitty](https://sw.kovidgoyal.net/kitty)终端模拟器, [WezTerm](https://wezterm.org)也是个不错的选择.

kitty配置文件[kitty.conf](https://github.com/b1nhack/dotfiles/blob/main/kitty/kitty.conf).

## Font

我使用[JetBrains Mono](https://www.jetbrains.com/lp/mono/)字体, 用于终端模拟器[^2]和博客.

## Unix Shell

我使用[Zsh](https://www.zsh.org), 配置文件目录[zsh](https://github.com/b1nhack/dotfiles/tree/main/zsh).

## Version Control System

我使用[Git](https://git-scm.com) DVCS (Distributed Version Control System), 并使用[delta](https://github.com/dandavison/delta)增强Git的输出.

Git配置文件[config](https://github.com/b1nhack/dotfiles/blob/main/git/config), delta配置文件[delta.gitconfig](https://github.com/b1nhack/dotfiles/blob/main/delta/delta.gitconfig).

## Password Manager

我使用[KeePassXC](https://keepassxc.org)密码管理器, 配置文件[keepassxc.ini](https://github.com/b1nhack/dotfiles/blob/main/keepassxc/keepassxc.ini). 一定要备份密码数据库文件!

## Code Editor

我使用[Neovim](https://neovim.io)代码编辑器, 配置文件目录[nvim](https://github.com/b1nhack/nvim).

## Email Client

我使用[NeoMutt](https://neomutt.org)电子邮件客户端. [Linux Kernel](https://www.kernel.org)使用电子邮件工作流.

配置文件目录[neomutt](https://github.com/b1nhack/dotfiles/tree/main/neomutt).

## OpenPGP Implementation

我使用[GnuPG](https://gnupg.org) OpenPGP实现, 主要用于电子邮件加密和代码签名.

配置文件目录[gnupg](https://github.com/b1nhack/dotfiles/tree/main/gnupg).

## Software Development Platform

我主要使用[GitHub](https://github.com)软件开发平台, 一些重要的代码仓库会使用[Codeberg](https://codeberg.org), 再通过Mirror功能同步到GitHub.

[^1]: Neovim需要频繁使用Esc切换模式.

[^2]: 终端模拟器使用[JetBrainsMono Nerd Font](https://www.programmingfonts.org/#jetbrainsmono)以显示大量图标.
