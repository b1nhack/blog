+++
title = "First Patch to Linux Kernel"
date = "2025-05-30"
updated = 2025-06-02
description = "Linux Kernel开发所需的前置知识."
+++

Linux Kernel是地球最大的开源项目之一, 使用电子邮件工作流接受贡献.

推荐阅读[Outreachyfirstpatch](https://kernelnewbies.org/Outreachyfirstpatch), 指导创建第一个Linux Kernel补丁. 官方文档查看[Submitting patches](https://docs.kernel.org/process/submitting-patches.html).

## Kernel Tree

[Linux Kernel](https://git.kernel.org)项目有许多代码仓库, 称之为树. 不同的子系统或功能在不同的子树中开发, 最终由[Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds)将各个子树的补丁合并到[mainline](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/)仓库.

## Coding Style

{{ aside(text="在十几年前, 还很可能会收到一些不太优雅的回复.", position="right") }}

Linux Kernel有严格的编码风格要求, 细节查看[Linux kernel coding style](https://docs.kernel.org/process/coding-style.html). 违反编码风格的补丁会被维护者拒绝.

提交补丁前使用`scripts/checkpatch.pl`脚本检查编码风格, 如果违反编码风格的代码看起来更好, 那么最好保持原样, 常见的噪音查看[CheckpatchTips](https://kernelnewbies.org/CheckpatchTips).

## Email Workflow

Linux Kernel使用电子邮件工作流, 补丁通过电子邮件发送给维护者, 维护者审查通过后合并到子树. 使用`scripts/get_maintainer.pl`脚本通过commit或文件查询维护者的邮件地址和相关邮件列表.

推荐使用`git send-email`发送补丁, [sourcehut](https://sourcehut.org)创建了基于此的电子邮件工作流教程[git-send-email](https://git-send-email.io).

## Patch Philosophy

Linux Kernel对补丁有严格的格式要求, 细节查看[PatchPhilosophy](https://kernelnewbies.org/PatchPhilosophy).

下面是使用`git format-patch`生成的补丁示例:

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

`Subject: [PATCH] ...`是从补丁主题自动生成的邮件主题, 一般不直接修改, 而是使用`git commit --amend`修改commit, 并重新生成补丁. 补丁主题也有严格的格式要求, 细节查看[Patch subject formatting](https://kernelnewbies.org/PatchPhilosophy#Patch_subject_formatting). `Signed-off-by: ...`是一个补丁标签, 证明代码符合[Developer Certificate of Origin](https://developercertificate.org), 详细解释查看[PatchTipsAndTricks](https://kernelnewbies.org/PatchTipsAndTricks). 可以通过`git config format.signOff yes`命令启用自动补丁签署. 邮件主题下方[1]处是补丁描述. `---`下方[2]处可以添加注释, 应用补丁时被忽略.

维护者审查补丁后, 可能会要求修改, 修改后再次生成补丁应使用`git format-patch -v2`命令. `-v2`参数会在邮件主题中添加版本号: `Subject: [PATCH v2] ...`. 还需要在[2]处添加补丁版本说明:

```
Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
v2:
- Made commit message more clear
- Corrected grammer in code comment
- Used new API instead of depreciated API

 test | 0
```

一系列相关的补丁合并为补丁集提交, 可以使用`git format-patch --cover-letter`命令, 将注释写在单独的文件中.

## Reply Email

提交补丁后, 可能会需要一些讨论, 以确定最终方案, 开发者需要回复电子邮件参与讨论. Linux Kernel要求邮件是内联的纯文本格式, 禁用[format=flowed](https://www.ietf.org/rfc/rfc3676.txt), 自动换行和GPG签名, 并使用[UTF-8](https://en.wikipedia.org/wiki/UTF-8)编码. 推荐使用[NeoMutt](https://neomutt.org)电子邮件客户端, 其他被认为纯文本支持良好的电子邮件客户端查看[Use plain text email](https://useplaintext.email). 引用原始邮件内容时使用[内联回复](https://en.wikipedia.org/wiki/Posting_style#Interleaved_style).
