---
name: ebook-treasure
description: 24,071 本中文电子书城通网盘书库检索（ebook-treasure-chest 本地索引）。按书名/分类/作者搜书出下载清单，密码统一 8866。当用户要找某主题/某作者的中文电子书、或研究课题需要配套书单时使用。
# EXTENDED METADATA (github-to-skills 规范, skill-manager 幂等更新用)
github_url: https://github.com/jbiaojerry/ebook-treasure-chest
github_hash: 93cf3ffcf5a2
version: 0.1.0
created_at: 2026-10-03
entry_point: scripts/search_books.py
dependencies: []
---

# ebook-treasure — 中文电子书宝库检索

上游仓库: jbiaojerry/ebook-treasure-chest（19.9k stars，1000 分类，24,071 本书
全结构化于 `docs/all-books.json`）。本机已落地 vendor 缓存:
`E:\AI-Station\vendors\ebook-treasure-chest\`。

## 能做什么

- **搜书**: 书名/分类/作者关键词 → 排序书单（书名前缀 > 书名包含 > 分类 > 作者）
- **清单交付**: 每条含 城通网盘(ctfile)直链 + 统一密码 `8866` + 格式(epub/mobi/azw3 打包 zip)
- **库画像**: 文学 2711 / 历史 1748 / 管理 613 / 经济 487 / 心理 396 / 投资 365 …
  泛知识大众阅读向; 专业工程类极薄（"工程" 仅 2 本）——**窄专业词先试宽词**

## 用法

```bash
# 基本检索
python .claude/skills/ebook-treasure/scripts/search_books.py "管理" -n 10

# 多词 OR + 分类过滤 + JSON 输出 (程序化消费)
python .claude/skills/ebook-treasure/scripts/search_books.py "投资" "金融" -c 金融 --json

# 换索引路径 (vendor 更新后)
python ... --index <path/to/all-books.json>
```

## 下载方式（重要边界）

链接在浏览器打开 → 输密码 8866 → 页面「普通下载」。**匿名直链 API 已死**
（2026-10-03 实证: webapi.ctfile.com 第二步 get_file_url.php 恒空体，真浏览器
上下文同死，file_chk 每请求轮换——社区旧配方已被服务端升级废掉）。所以：
按需单件手动下载，不做批量自动化。上游声明仅供测试研究、24 小时删除、支持正版。

## vendor 缓存更新

```bash
cd /e/AI-Station/vendors
curl -sL "https://codeload.github.com/jbiaojerry/ebook-treasure-chest/tar.gz/refs/heads/main" -o etc.tar.gz
tar -xzf etc.tar.gz && rm -rf ebook-treasure-chest && mv ebook-treasure-chest-main ebook-treasure-chest && rm etc.tar.gz
```
（git 协议被 DPI 掐时走 codeload tarball 直下，本机实证可行）

## 调研渠道形态

已注册为 ResearchFactory-Eng 渠道 `ebook`（清单模式: 关键词→书单 manifest 落
战役 02 目录），见 `channels/ebook_channel.py`。
