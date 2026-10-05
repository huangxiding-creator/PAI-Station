---
name: muse-image-search
description: Use when a text query needs public image URLs plus their source pages — feeds, artifacts, visual references; covers picking the renderable locator and running a download-safe preflight. Not for identifying a supplied image or person.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/image-search/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》→ MuseAI-Skills 仓库（https://github.com/win4r/MuseAI-Skills）@ `38bbb45` 的非官方快照。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/image-search/SKILL.md`（vendored 原件；本技能上游仅此一个文件，无 references/ 附属件）。
> - 本版（muse-image-search v0.1.0）是 Claude Code 本地适配移植版：保留上游正文结构与实质（英文正文保持英文），仅把依赖 Muse 运行时、会误导本机执行的指令改为参考式表述并逐条标注【Muse 环境专用】。

## 本环境适配

上游依赖逐条对照（相对说明尽量指向 vendored 原件目录 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/image-search/`）：

1. **`/opt/hatch/bin/image-search` 捆绑 CLI（`/opt/hatch` 路径）**【Muse 环境专用】——本机不存在该二进制与该路径，正文中的调用命令保留为上游原文参考（完整版见 vendored 原件）。本地以文搜图的参考路径：用本机在役检索工具（WebSearch / WebFetch，或已装检索技能如 `zh-search-pro`）以文字查询找公开图片，取图片 URL 与来源页；拿到候选 URL 后，正文的筛选规则与预检流程照常适用。
2. **结构化输出字段（`media_url` / `thumbnail_cdn_url` / `media_handle` / `candidate_ref` / `page_url`）**【Muse 环境专用】——仅上述 CLI 的输出契约。本地检索结果的近似映射：图片直链 ≈ `media_url`，缩略图/CDN 预览 ≈ `thumbnail_cdn_url`，来源页 ≈ `page_url`；`media_handle`/`candidate_ref` 无本地对应物，按上游规则一律不渲染、不当图片 URL 用。
3. **Meta CDN 缩略图（`thumbnail_cdn_url`）**【Muse 环境专用】——Meta 侧 CDN 字段本地不出现；"缓存 URL 不是唯一持久副本"的原则对本地拿到的任何第三方图床/CDN URL 同样适用。
4. **Feed / Artifact 与"Artifact 支持的媒体摄取路径"（Muse VM 内媒体机制）**【Muse 环境专用】——本地映射：需产物落盘时走已移植技能 `muse-artifact-pdf` / `muse-artifact-markdown`（`E:/AI-Station/.claude/skills/`），或直接把预检通过的图片字节复制进产物自有目录（对应原文 "copy those bytes into Artifact-owned storage"）。
5. **搜索结果预审批（locator 逐字节复用即免再次提示的权限门）**【Muse 环境专用】——Muse 权限机制。本地由 Claude Code 权限系统接管；"URL 逐字节原样使用、失败不连环重试、不偷换无关本地图片"的纪律照旧遵守。
6. **Muse 连接器 OAuth**——本上游文件正文未出现 OAuth/登录态依赖（捆绑 CLI 直调，未见鉴权步骤），故无本地映射项；快照内其他技能如涉及，以 `06 技能/library/MuseAI-Skills/` 对应原件为准。
7. **curl 预检/下载命令**——非 Muse 专有；Git Bash 自带 curl，替换占位符后原样可用。

## 移植正文（上游内容，英文保持英文，最小编辑）

# Image Search

Use the bundled CLI to find public images by text query (【Muse 环境专用】本机无此 CLI，以下命令为上游原文参考，本地替代见「本环境适配」第 1 条):

```sh
/opt/hatch/bin/image-search "Golden Gate Bridge at sunset" --max-results 5
```

Optional result language:

```sh
/opt/hatch/bin/image-search "Paris architecture" \
  --max-results 5 \
  --language fr
```

The CLI returns structured results and omits unavailable fields. Interpret the URLs as follows:

- `media_url` is the public source image locator and the preferred full-image URL when present.
- `thumbnail_cdn_url` is Meta's renderable CDN preview and the fallback when `media_url` is absent. Treat it as a cache URL, not the sole durable copy of an artifact.
- `media_handle` and `candidate_ref` are internal, non-renderable fields. Do not fetch, display, or pass them as image URLs.
- `page_url` is the source page. Retain it for provenance or attribution.

The service returns only results with `media_url` or `thumbnail_cdn_url`. Ignore any result that lacks both renderable URL fields. Choose the result that best matches the request rather than blindly taking the first one.

This skill returns locators only: it does not download, upload, or turn an image into a Muse media reference. A Feed may use a suitable remote image URL. For an Artifact that needs a durable local copy, pass the chosen locator and source page through the Artifact's supported media-ingestion path (【Muse 环境专用】本地映射见「本环境适配」第 4 条); do not treat the CDN thumbnail as permanent storage.

For an Artifact, choose a download-safe locator before starting any fetch:

1. Inspect all returned results and prefer an HTTPS `media_url` with no URL credentials, query string, or fragment. Preserve result order among those simple public URLs.
2. Preflight each candidate like a browser, with a cross-origin referer, then fetch one candidate at a time with bounded connect and total timeouts (substitute real values for the placeholders; curl 在本机可直接使用):

   ```sh
   curl -fsSLI -A 'Mozilla/5.0' -H 'Accept: image/png,image/jpeg,image/gif,image/webp,image/*;q=0.5' -H 'Referer: <any-https-origin-that-is-not-the-image-host>' '<image-url>'
   curl -fsSL --connect-timeout 10 --max-time 60 -A 'Mozilla/5.0' -H 'Accept: image/png,image/jpeg,image/gif,image/webp,image/*;q=0.5' -o '<dest-file>' '<image-url>'
   ```

   Accept only a final `2xx` whose content type and file magic are an image, then copy those bytes into Artifact-owned storage. Prefer PNG or JPEG: WEBP is fine except in a Word document, and AVIF except on a web page, which refuses it at share time with no retry that fixes it. Convert a HEIC to JPEG anywhere. Reject hotlink-blocked, expiring, redirecting, 403/404, non-image, watermarked, or unstable URLs. The referer matters: a hotlink-protected host serves a plain fetch but refuses requests that look like they come from someone else's page, so a URL that fails this probe breaks after the Artifact ships even though it loads for you today. The same preflight applies to any external image URL an Artifact uses, however it was found.
3. If no simple `media_url` succeeds, consider a query-bearing `media_url` or `thumbnail_cdn_url`. Use the returned locator byte-for-byte; never remove or rewrite its query string to make it look simpler.

Search-result pre-approval records the returned locator's exact path and query, so a plain GET/HEAD that uses it byte-for-byte is normally allowed without another prompt even when it has a query string (【Muse 环境专用】本地由 Claude Code 权限系统接管，见「本环境适配」第 5 条). Do not keep retrying or substitute an unrelated local image when a fetch fails.

This is text-to-image search, not reverse-image identification. Do not use it to identify an unknown person from a supplied photograph.
