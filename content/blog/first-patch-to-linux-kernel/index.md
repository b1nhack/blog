+++
title = "First Patch to Linux Kernel"
description = "The background knowledge you need for Linux Kernel development."
date = 2025-05-30
updated = 2026-10-14
draft = false

[extra]
copy_button = true
code_block_name_links = false
mermaid = false
+++

The Linux Kernel is one of the largest open source projects on Earth, and it accepts contributions through an email-based workflow.

Recommended reading: [Outreachyfirstpatch](https://kernelnewbies.org/Outreachyfirstpatch), a guide to creating your first Linux Kernel patch. The official documentation is [Submitting patches](https://docs.kernel.org/process/submitting-patches.html).

## Kernel Tree

The Linux Kernel project spans many repositories, known as trees. Different subsystems and features are developed in separate subtrees, and eventually [Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) merges patches from each subtree into the [mainline](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/) repository.

## Coding Style

{{< aside text="A decade or so ago, this was likely to earn you some rather impolite replies." position="right" />}}

The Linux Kernel enforces a strict coding style — details in [Linux kernel coding style](https://docs.kernel.org/process/coding-style.html). Patches that violate the coding style get rejected by maintainers.

Run the `scripts/checkpatch.pl` script before submitting to check your patch against the style rules. If the style-violating code genuinely looks better, it's usually best to leave it as is; common noise is covered in [CheckpatchTips](https://kernelnewbies.org/CheckpatchTips).

## Email Workflow

The Linux Kernel uses an email workflow: patches are sent to maintainers by email, and once a maintainer approves them they are merged into the subtree. The `scripts/get_maintainer.pl` script looks up maintainer addresses and relevant mailing lists from a commit or file.

`git send-email` is the recommended way to send patches; [sourcehut](https://sourcehut.org) built an email workflow tutorial around it at [git-send-email](https://git-send-email.io).

## Patch Philosophy

Patches are held to strict formatting requirements — details in [PatchPhilosophy](https://kernelnewbies.org/PatchPhilosophy).

Here is an example patch generated with `git format-patch`:

```
From d446483f4cbfc8f89973fc2aea1f2e7351d73c43 Mon Sep 17 00:00:00 2001
From: Xingquan Liu <b1n@b1n.io>
Date: Fri, 30 May 2025 13:08:53 -0400
Subject: [PATCH] ...

[1]

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
[2]

 test | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test

diff --git a/test b/test
new file mode 100644
index 000000000000..e69de29bb2d1
```

`Subject: [PATCH] ...` is the email subject auto-generated from the patch title — don't edit it directly; instead amend the commit with `git commit --amend` and regenerate the patch. Patch subjects follow strict formatting rules too; see [Patch subject formatting](https://kernelnewbies.org/PatchPhilosophy#Patch_subject_formatting). `Signed-off-by: ...` is a patch tag certifying that the code complies with the [Developer Certificate of Origin](https://developercertificate.org); a detailed explanation is in [PatchTipsAndTricks](https://kernelnewbies.org/PatchTipsAndTricks). You can enable automatic sign-off with `git config format.signOff yes`. Below the subject, the area marked [1] is the patch description. Below the `---` separator, the area marked [2] takes comments, which are ignored when the patch is applied.

After reviewing your patch, a maintainer may request changes. Regenerate the patch with `git format-patch -v2` — the `-v2` flag adds a version to the subject: `Subject: [PATCH v2] ...`. You should also add version notes at [2]:

```
Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
v2:
- Made commit message more clear
- Corrected grammer in code comment
- Used new API instead of depreciated API

 test | 0
```

A series of related patches is submitted together as a patch set; use `git format-patch --cover-letter` and write the notes in the separate cover letter file.

## Reply Email

Once your patch is submitted, some back-and-forth discussion is often needed to settle on the final approach, and that happens by replying to email. The Linux Kernel requires mail in inline plain text: disable [format=flowed](https://www.ietf.org/rfc/rfc3676.txt), auto-wrapping, and GPG signatures, and use [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoding. [NeoMutt](https://neomutt.org) is the recommended email client; other clients considered good at plain text are listed at [Use plain text email](https://useplaintext.email). When quoting the original message, use [inline replies](https://en.wikipedia.org/wiki/Posting_style#Interleaved_style).
