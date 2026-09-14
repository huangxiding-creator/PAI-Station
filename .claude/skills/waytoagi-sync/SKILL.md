---
name: waytoagi-sync
description: 通往AGI之路飞书知识库 → 本地 04 智库（md+docx 分类归置）→ 秘塔知识库（章节二级目录）全流程同步。触发词：waytoagi、通往AGI、同步知识库、上传秘塔。含增量对比、Word 转换、断点续跑。
---

# waytoagi-sync —— 通往AGI之路 → 智库 → 秘塔 全流程同步

## 数据流

```
飞书 wiki (waytoagi.feishu.cn, 公开免登录)
  │ ① enum-parent-map.js     精确父子树（纯元数据，2-4s/批节流，断点续跑）
  │ ② sync_incremental.py    对比本地 md → new-pages.json（新文档清单）
  │      └ --download        → feishu-Down/wiki-crawler.js 只抓缺失（~20s/篇）
  ▼
ResearchFactory-Eng/feishu-Down/wiki-output/waytoagi/*.md   （暂存区，扁平）
  │ ③ finalize_tree.py       token → 章节/完整路径 → state/doc-map.json
  │ ④ md2docx_batch.py       pandoc(gfm) → docx（中文字体参照），断点续跑
  ▼
04 智库/通往AGI之路/<L1章节>/<标题>.md + <标题>.docx
  │ ⑤ upload_metaso.py       DrissionPage 页内 fetch → 秘塔（见下）
  ▼
metaso.cn subject 8673582927558737920 / cfid 2096794719386992640
  └ 二级目录 = L1 章节；每篇上传 .md + .docx 双格式；台账断点续跑
```

## 使用

**格式政策（2026-09-12 用户定）**：补齐/增量文档**只归置 md、不转 docx**；
秘塔**只传 md**。存量 3398 篇的 docx 保留不动。

```bash
cd E:/AI-Station/.claude/skills/waytoagi-sync/scripts

# 全量同步（首次或大版本更新）
node enum-parent-map.js                    # 树元数据（续跑安全）
python finalize_tree.py                    # 章节归属
python md2docx_batch.py --md-only          # 只归置 md（旧库转 docx 去掉 --md-only）
python upload_metaso.py --smoke            # 秘塔冒烟（1章节2篇）
python upload_metaso.py --only md          # 全量上传（断点续跑）

# 日常增量同步
node enum-parent-map.js
python sync_incremental.py                 # 刷新 api-pages.json + 缺失清单
python sync_incremental.py --download      # 只抓新文档（可 --chapters "1.2,1.3" 分批）
python finalize_tree.py && python md2docx_batch.py --md-only && python upload_metaso.py --only md
```

### wiki-crawler 补齐三坑（2026-09-12 实战）
1. **crawl-state.json 陷阱**：爬虫优先读输出目录的 crawl-state.json，
   刷新 api-pages.json 后必须把旧 crawl-state.json 移走，否则按旧宇宙
   "已全部采集完成"秒退（已踩：state/crawl-state-old-3466.bak.json）
2. **MAX_PAGES 默认 9999** < 全树 14455，必须 `MAX_PAGES=99999 node wiki-crawler.js`
3. **Playwright 浏览器**：`npx playwright install chromium`（exporter 目录下，
   一次性）；或给爬虫加 channel:"chrome" 用系统浏览器

## 关键配方（踩坑结晶，勿改）

### 秘塔上传（借 We-AIPO 生产验证）
- **cookie 认证，绝不在写请求带 token header**：meta-token 是只读 token，
  加上反而覆盖 cookie 写权限 → "您没有权限"
- 端点：上传 `PUT /api/file/{cfid}`（FormData）；建夹 `PUT /api/file/{parentId}/folder`
  `{"name":...}`（2026-09-12 改版端点，旧 `/api/dir` 已 404；已存在 errCode==1 时查
  `GET /api/knowledge/{sid}/search?parentId=...` 列表拿现有夹 id）；
  成功契约 HTTP 200 且 **errCode==0**
- DrissionPage 持久 profile（E:\CPOPC\We-AIPO\data\browser_profile\metaso）+
  CRC32 稳定端口（禁 auto_port）；登录标记：退出登录/个人中心/我的会员
- 上传间隔 2-4s 随机；连败 5 次熔断；docx 走 base64→Uint8Array→File
- 台账 state/metaso-uploads.jsonl（status=ok 跳过）；章节→cfid 缓存 state/metaso-dirs.json

### 飞书树枚举
- 内部 API `GET /space/api/wiki/v2/tree/get_node_child/?space_id=7226178700923011075&wiki_token=X`
  （页面上下文 fetch，公开库免登录）；**响应按父 token 分组返回=天然精确父子关系**
- 必须节流：批 20 token、批内 100ms、批间 2s；否则空响应（Unexpected end of JSON input）
- 失败重试 3 次 + 连败 5 批熔断 60s；周期落盘 state/parent-map.json 断点续跑
- ⚠️ ResearchFactory-Eng 的 api-pages.json 是 BFS 序且丢了父 token，**不能**用于章节归属
  （历史教训：启发式重建精度不足，2026-09-12）

### Word 转换
- pypandoc(pandoc 3.9) gfm 输入（管道表格/任务列表）；--reference-doc=state/reference.docx
  （正文宋体小四、标题黑体，w:eastAsia 东亚字体必须显式设置）
- YAML frontmatter 先剥离；远程图片降级为文字（无 rsvg-convert，可接受）

### 飞书 CLI（官方路线，未来优先）
- 已装 @larksuite/cli + 项目级 lark skills；`lark-cli wiki +node-list` 可精确列树
- 首次配置：`lark-cli config init --new` → 打开输出链接完成开发者后台配置 →
  `lark-cli auth login --domain docs --domain wiki`
- 配置完成后 enum 可换 CLI 实现；wiki-crawler 仅作正文抓取兜底

### API 漂移探测（2026-09-12 实战：建夹端点改版）
站方改 API 时（老端点 404），**不要盲猜端点**：用 `scripts/probe_metaso_api.py`
—— DrissionPage 打开管理页，页内注入 fetch/XHR monkey-patch 钩子
（`window.__reqs` 收集 url/method/body），再驱动 UI 按钮触发操作，读回真实请求。
CDP listen 在弹窗交互下会失效，页内钩子免疫。实测抓到：
`PUT /api/file/{parentId}/folder {"name":...}`。

## 安全红线
- 采集节流红线见 memory「账号安全第一」；waytoagi 公开免登录但同样守节流
- 秘塔上传"只增不删"；失败不阻断（台账续跑）
- 每次全量跑前先 --smoke / --limit 验证

## 状态文件
- state/doc-map.json         md → 章节/路径/置信度
- state/parent-map.json      精确父子树（枚举缓存）
- state/node-info.json       token → {title,parent,level}
- state/new-pages.json       增量缺失清单
- state/metaso-uploads.jsonl 上传台账
- state/metaso-dirs.json     章节 → 秘塔 cfid 映射
- state/convert-errors.log   转换失败清单
