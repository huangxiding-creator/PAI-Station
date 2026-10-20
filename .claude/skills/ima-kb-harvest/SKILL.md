---
name: ima-kb-harvest
description: 腾讯ima知识库广场收割器。当用户要把 ima 知识库广场上的知识库整库下载、按关键词批量收割 ima 知识库、下载 ima 知识库文件、整理 ima 知识库架构时使用。给定关键词 → 自动搜库/加入/整库下载/本地去重/重组知识库架构。触发词：ima知识库、知识库广场、ima整库下载、ima收割。
---

# IMA 知识库广场收割器

把「关键词」变成「整理好的本地知识库」：广场搜库 → 加入 → 整库下载 → sha256 去重 → 重组架构 + 总索引。
协议逆向自 IMA批量下载助手.exe v1.7.1（详见 `references/protocol.md`），直连 ima.qq.com 官方接口。

## 核心工作流

### 1. 登录态检查（每次先跑）

```bash
cd .claude/skills/ima-kb-harvest/scripts && py -3.13 -X utf8 harvest.py status
```

- `[✓]` → 直接进入第 2 步
- `[✗]` → 跑 `harvest.py login`，二维码弹窗 + 存 `login_qr.png`，**提醒用户微信扫码**（等用户确认扫完）。凭证存 scripts/credentials.json，token 自动刷新，refresh_token 约一个月有效

### 2. 广场搜索（Claude 审核相关性）

```bash
py -3.13 -X utf8 harvest.py search "<关键词>" --pages 5
```

- 输出候选库清单（id/名称/简介）。**Claude 职责：按用户意图筛掉不相关库**（名称或简介须命中主题；营销号壳库/主题漂移库剔除）
- 关键词太窄搜不到时，扩词重试（如「水利工程」→「水利」「水电站」「灌溉」）
- 需要更多候选就加 `--pages`

### 3. 一键收割

```bash
py -3.13 -X utf8 harvest.py harvest "<关键词>" --out <输出目录> --max-kbs 10 --min-files 5 --workers 4 --yes
```

或指定库（Claude 审核后的清单）：

```bash
py -3.13 -X utf8 harvest.py harvest --kb-ids id1,id2,id3 --out <输出目录>
```

全自动四步：搜索→join→整库下载（目录结构还原/笔记转md/报告转html/链接记台账）→去重重组。

**产出结构**：
```
<输出目录>/
├── _index/
│   ├── MANIFEST.json      # 全量清单（raw路径/最终路径/sha256/去重映射）
│   ├── 知识库总览.md       # 各库保留文件数统计
│   └── 重复文件报告.md     # 跨库重复明细（保留哪个+重复哪些）
├── <库名01>/…             # 去重后按库组织的文件树
├── <库名02>/…
└── _raw/                  # 原始未去重副本（清理纪律：删除须用户明示）
```

### 4. 知识库架构整理（Claude 增值步骤）

下载完成后，读 `_index/MANIFEST.json` + `知识库总览.md`，按用户要求做主题级重组：
- 常见诉求：按主题/文件类型/年份重排、生成各库 README、跨库专题抽取（如"所有规范类PDF集中"）
- 重组用**复制/移动到新子目录 + 更新索引**，不删源文件；删除只认用户明示（CLAUDE.md 清理铁律）

## 参数速查

| 参数 | 默认 | 说明 |
|---|---|---|
| `--pages` | 3 | 搜索翻页数（每页10库） |
| `--max-kbs` | 10 | 最多收割库数 |
| `--min-files` | 5 | 文件数低于此值的库跳过 |
| `--workers` | 4 | 下载并发（过高有风控风险，勿超8） |
| `--limit-files` | 0 | 每库限下N个文件（试跑用） |
| `--yes` | off | 不做相关性过滤全收（慎用） |

## 硬门与红线

1. **付费库不绕**：`get_media` 返回 `kb_payment_info` 非空/`jump_url_info: null` = ima 官方付费库，如实报错跳过，禁止绕过付费墙
2. **并发≤8、随机延迟已内置**：尊重官方接口，勿提高并发压测
3. **凭证敏感**：credentials.json 含 IMA-TOKEN，勿提交 git、勿外传
4. **大库预检**：先 `search` 看规模；数十万文件的巨库先 `--limit-files 20` 试跑确认质量再全量
5. **`_raw/` 是未去重副本**：占双倍磁盘；只在用户明示后清理（git 追踪的走 git checkout 恢复，未追踪删了就没）

## 常见坑（pits）

- **join 后仍下载失败(role:0)**：付费库或 need_review:true 的审核库 → 换库
- **文件夹进不去(30005)**：文件夹ID必须用条目的 `media_id`（`folder_` 前缀），不是 `folder_id` 字段 —— 客户端已内置处理，只在改代码时注意
- **refresh 报 token_type 错误**：必须传数字 `14`（trpc 枚举），不是字符串
- **搜索0结果**：广场搜索有分词限制，单词库（如"DeepSeek"）可能搜不到，扩词或换拼音近义
- **中文路径**：Windows 下 shell 操作中文目录用 `py` 脚本或加引号，勿用裸 head/cat
- **token 过期**：harvest 内置自动刷新；refresh_token 也过期（约30天）→ 重跑 `login` 扫码

## 实测锚点（2026-10-19）

- 登录→加入「知识库：AI资料库」(7476280295446827)→15/15 文件下载成功（157MB，%PDF- 真头验证）
- 搜索词实测：「工程」「AI」「知识库」命中良好；「DeepSeek」「python」0结果（分词限制）
