---
name: pan-hunter
description: >-
  全网网盘资源检索与免登下载 CLI（PAN-HUNTER，逆向工程/pan-hunter/ph.py）— 聚合 9 实测活源搜全网网盘分享链
  （夸克/百度/阿里/迅雷/UC/蓝奏/123/115/139…21 盘红绿灯标注，发现/交付两栏分列）；绿盘五盘（uc/lanzou/ilanzou/feijipan/ecpan）
  免登直链真件下载；黄盘五盘（百度/阿里/夸克/迅雷/139）免登发现层=列表+探活；十盘真件门台账/源健康轮/凭据插件态体检。
  TRIGGER: 用户要「全网搜网盘资源/找网盘分享链接/按主题找资料/下载分享链接/看资源红绿灯/分享链探活列清单/盘矩阵体检」；
  或提到 pan-hunter/panhunter/ph.py；或调研课题需要网盘语料发现与绿盘直下。
  DO NOT TRIGGER: 自家百度网盘的文件管理操作（→bdn 或 baidu-drive）；按中文书名找电子书（→ebook-treasure）；
  已持直链的普通文件下载；付费墙/会员加速/账号池类诉求（法务红线，直接拒绝）。
---

# pan-hunter — 全网网盘资源检索与免登下载技能

包装 `E:\AI-Station\逆向工程\pan-hunter\ph.py`（engine/sourcehub 源中枢 + 十盘 adapter + 五盘发现层）。
北极星口径：**全网免登发现 + 绿盘免登直下**；黄盘交付=可选本地凭据插件（默认关，凭据零托管）。

## 调用形态

```powershell
python -I E:\AI-Station\逆向工程\pan-hunter\ph.py <子命令> [参数]
```

- 任何 cwd 都能跑；Windows 系统 python 3.13（带 curl_cffi 0.17）。
- 零凭据零登录：不读任何盘账号/Cookie；BDCLND 等分享面派生令牌不算凭据。
- 首选 `--json` 拿结构化结果（search 支持）；其余命令输出即台账口径文本。

## 分区路由表（四技能各管一段，先路由再动手）

| 用户诉求 | 去处 |
|---|---|
| **全网找网盘分享链/主题找资料/资源红绿灯/绿盘免登直下/黄盘列表探活** | **本技能** |
| 自家百度网盘操作（远端路径 `/` 开头：列目录/上传/下载/镜像/删改） | `bdn` |
| 百度网盘 /apps/bdpan/ 沙箱、Agent 记忆备份恢复、转存他人分享、开会员 | `baidu-drive` |
| 按中文书名/作者找电子书（24,071 本库） | `ebook-treasure` |

边界细则与冲突裁决：[references/zoning.md](references/zoning.md)。

## 命令映射表（自然语言 → 命令）

| 用户意图 | 命令 |
|---|---|
| 全网搜某关键词的网盘资源 | `search "水电站 施工组织"`（两栏：交付层绿盘可直下 + 发现层全部命中） |
| 只要 JSON / 限源搜 | `search "民法典" --json`、`search 词 --source melost,bixin` |
| 看某条黄盘链接里有什么（不下载） | `discover "https://pan.quark.cn/s/xxx"`（百度/阿里/夸克/迅雷/139 五盘；`--pwd 提取码`） |
| 下载绿盘分享链文件 | `download "https://www.lanzoui.com/xxx" --out E:\dst`（`--min-mb 10` 选件门槛） |
| 十盘真件门/红绿灯权威台账 | `gates`（读 analysis/W1_GREEN_GATES.md） |
| 体检：盘矩阵+发现层+插件态 | `doctor`（零网络）；`doctor --sources` 加 9 源探活 |
| 源健康轮（趋势对比历轮） | `python -I E:\AI-Station\逆向工程\pan-hunter\scripts\health_round.py` |
| MCP 三工具挂接（Claude Code 直连） | 见仓 README「MCP 挂接」节（mcp_server.py） |

全参数、退出码、JSON 字段：[references/commands.md](references/commands.md)。

## 红绿灯三级口径（对外声明口径，详见 references/lights.md）

- **绿（5 盘过真件门）**：uc / lanzou / ilanzou / feijipan / ecpan —— 免登全链真件落盘实证，可承诺直下。
- **绿?（3 盘链路就绪）**：115 / 光鸭=owner 开关型（分享者开链即绿）；wss=无当活公开链。**不得当绿承诺**。
- **黄**：百度/阿里/夸克/迅雷/139/189/ctfile/pikpak/123 —— 免登发现+列表+探活；交付走本地凭据插件（默认关）。123=免费层墙 5112 如实。
- **红**：微云/沃盘 —— 仅发现，不承诺交付。奶牛 transfer 已停服除名。

## 安全节（精要；全表见 references/safety.md）

1. **只打公开分享面**：免登录公开分享索引 + 用户自有通道下载；不碰限速破解/账号池/向下载收费。
2. **凭据零托管**：永不代收用户盘 Cookie；黄盘插件默认关（config.json enabled=[]），凭据文件禁读禁打印。
3. **频控默认在身**：单源串行间隔≥2s 随机、并发≤4、发现层总预算≤150 发硬熔断；不要并发多进程跑同一命令加压。
4. **下载内容用途声明**：每次 download 成功自动落审计行 analysis/download_audit.jsonl（ts/url/盘/大小/sha1/purpose=research）。
   **收割物只进内部调研语料，不进任何付费交付物**；对外交付只收整编/原创。
5. **红黄盘如实口径**：黄盘说「可发现可列表」不说「可下载」；红盘不承诺；绿?不冒充绿。数字一律以 analysis/ 台账为准，禁手填。
