+++
title = "Quality of Cyber Life"
description = "A list of essential non-technical knowledge for better efficiency and quality of life."
date = 2025-05-29
updated = 2025-06-02
draft = false

[extra]
copy_button = false
code_block_name_links = false
mermaid = false
+++

A record of how I live my life in cyberspace, containing just enough guidance for anyone interested to follow along. Recommended reading: [The Missing Semester of Your CS Education](https://missing.csail.mit.edu).

## Privacy Guides

You really should read [Privacy Guides](https://privacyguides.org) carefully.

## Keyboard Layout

I use the [Colemak](https://colemak.com) keyboard layout, with [Caps Lock](https://en.wikipedia.org/wiki/Caps_Lock) remapped to [Esc](https://en.wikipedia.org/wiki/Esc_key)[^1]. If you'll be hammering keys for the rest of your life, you should always replace [QWERTY](https://en.wikipedia.org/wiki/QWERTY) with any more efficient, more comfortable layout.

## Package Manager

I use [Homebrew](https://brew.sh) and [Nix](https://nixos.org) as package managers — the former for GUI applications ([Casks](https://formulae.brew.sh/cask/)), the latter for CLI packages ([Packages](https://search.nixos.org/packages)). Install Nix with the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).

My [Brewfile](https://github.com/b1nhack/dotfiles/blob/main/Brewfile) records the Casks I've installed via Homebrew, exported with `brew bundle dump`. [nix-packages](https://github.com/b1nhack/dotfiles/blob/main/nix-packages) records the Packages I've installed via Nix, exported with `nix profile list > nix-packages`.

## Terminal Emulator

My terminal emulator is [kitty](https://sw.kovidgoyal.net/kitty); [WezTerm](https://wezterm.org) is also a solid choice.

kitty config file: [kitty.conf](https://github.com/b1nhack/dotfiles/blob/main/kitty/kitty.conf).

## Font

My font is [JetBrains Mono](https://www.jetbrains.com/lp/mono/), used in the terminal emulator[^2] and on this blog.

## Unix Shell

My shell is [Zsh](https://www.zsh.org); config lives in [zsh](https://github.com/b1nhack/dotfiles/tree/main/zsh).

## Version Control System

I use [Git](https://git-scm.com), a DVCS (Distributed Version Control System), with [delta](https://github.com/dandavison/delta) to dress up Git's output.

Git config file: [config](https://github.com/b1nhack/dotfiles/blob/main/git/config). delta config file: [delta.gitconfig](https://github.com/b1nhack/dotfiles/blob/main/delta/delta.gitconfig).

## Password Manager

My password manager is [KeePassXC](https://keepassxc.org); config file at [keepassxc.ini](https://github.com/b1nhack/dotfiles/blob/main/keepassxc/keepassxc.ini). Always back up your password database!

## Code Editor

My code editor is [Neovim](https://neovim.io); config lives in [nvim](https://github.com/b1nhack/nvim).

## Email Client

My email client is [NeoMutt](https://neomutt.org) — the [Linux Kernel](https://www.kernel.org) runs on an email workflow.

Config lives in [neomutt](https://github.com/b1nhack/dotfiles/tree/main/neomutt).

## OpenPGP Implementation

My OpenPGP implementation is [GnuPG](https://gnupg.org), used mainly for email encryption and code signing.

Config lives in [gnupg](https://github.com/b1nhack/dotfiles/tree/main/gnupg).

## Software Development Platform

My main software development platform is [GitHub](https://github.com); important repositories go on [Codeberg](https://codeberg.org) first and are then synced to GitHub through its mirroring.

[^1]: Neovim requires frequent Esc presses to switch modes.

[^2]: The terminal emulator uses [JetBrainsMono Nerd Font](https://www.programmingfonts.org/#jetbrainsmono) for its wide range of icons.
