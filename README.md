<div align="center">

# 🧬 PAI-Station

### 个人主权智能体运行时 —— 记忆不是功能，是带得走的人生卷宗

[![License: MIT](https://img.shields.io/badge/License-MIT-1F3A5F.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows_10%2B-0078D6.svg)]()
[![Tests](https://img.shields.io/badge/测试-1598_全绿-success.svg)]()
[![Dossier](https://img.shields.io/badge/主权卷宗-P0_已落地-e8b04b.svg)]()
[![LLM Cost](https://img.shields.io/badge/LLM_成本-默认¥0_永不锁定-success.svg)]()

**液态 12 器官 · 感知型意图发现 · 云感知连接器 · 7×24 主循环 · 两阶段调研管线 · 微信夜间深读 · 微信简报夜间流水线 · FDE 方案工厂 · 每周进化提案**

[提案全文](PROPOSAL_V2.md) · [V3 提案](PROPOSAL_V3/PROPOSAL.md) · [愿景档案](00%20愿景/) · [方案商店](09%20发布/store/index.json)

</div>

<details>
<summary><strong>English</strong> — what is this?</summary>

**PAI-Station** is a sovereign personal agent runtime for Windows — not a tool, but a *relationship*: it reads your local activity signals, understands intent before you ask, ships deliverables, and converges toward you through every correction. The destination of all that understanding is a **sovereign dossier**: your judgments, lessons and deliverables unified into one plain-text, git-versioned dossier (sha256 fingerprinted per file) that exports with a single command — human-readable and grep-able on any machine without this product, consumable by any AI. Key subsystems: a liquid 12-organ directory architecture with SHA-256 credential chains, perception-first intent discovery (15 signal sources → 7-layer understanding stack, fail-closed), cloud-aware connectors (Tencent Meeting / Baidu Netdisk / WeChat intelligence), a two-phase research pipeline, an FDE plan factory with a three-stage funnel, and a weekly self-evolution proposal loop that the user — never the system — approves. LLM calls start at ¥0 (free Zhipu chain by default, any endpoint via 3 lines of config); data stays 100% local; paid artifacts never enter this public repo.

</details>

> **最近更新（2026-09-17）**
> 📜 **P0 主权卷宗落地**：三源统一 OKF 明文目录 + 内部 git 独立版本化 + 一条命令导出自包含包（sha256 逐件验证，实测 34 文件；在无本产品的机器上人可读、可 grep）（`ccfdefb`）
> 🧪 全量回归 **1598 项全绿**（WinRT OCR 子进程隔离等回归卫生三补丁，`189dc2f`）
> 📡 本周渠道线：微信双实例桥 · RSS 905 源首轮 17,759 篇 · Dify 私有实例接入

---

## 💡 它是什么

你的一生产出——判断、教训、成果——散落在聊天记录、文档、会议里，平台一关就蒸发。

**PAI-Station 是一个个人主权智能体运行时**：7×24 常驻 Windows，替你感知、理解意图、交付成果、每周进化。而这一切的终点不是"更好用的工具"，是把「懂你」沉淀成一份**主权卷宗**——三源统一（画像 · 记忆 · 证据）的明文资产，git 版本化、sha256 逐件指纹、一条命令整体导出；在没装它的机器上人可读、可 grep，任何 AI 可直接消费。不锁定于本产品，不锁定于任何厂商。

> **合一指数 U = 0.35·NPI + 0.35·F_pass + 0.30·(1 − C_rate)**
>
> 需求逼近 × 一次通过 × 纠正趋零。"直至合一"不是复制你，是纠正趋零的渐进极限——
> 每个任务域的 U 持续上升并跨过 60 分奇点，即该域"上岗"。永远在逼近，从不宣布完成。

模型调用默认 **¥0 起步、永不锁定**（智谱免费链起跑，3 行配置可换任意端点）；数据 100% 本地；付费成品永不进公开仓库。

---

## 📜 主权卷宗：记忆的资产形态（P0 已落地）

「记忆」做成产品功能，就是平台的库存；做成明文卷宗，才是你的资产。P0 四件套落在 `src/paistation/sovereign/dossier/`：

| 能力 | 命令 | 验收 |
|---|---|---|
| 三源统一构建 | `python -m paistation.sovereign.dossier build` | 画像五层 + 记忆转录 + 证据编目 → OKF 目录（一文件一条目，YAML frontmatter，坏 YAML 拒收） |
| 整体导出 | `python -m paistation.sovereign.dossier export --dest <目录>` | 自包含明文包：文物 + README + MANIFEST（sha256 逐件指纹；实测 34 文件） |
| 完整性校验 | `python -m paistation.sovereign.dossier verify <导出包>` | 纯指纹校验：缺失/篡改/未登记三态全零才 ok |
| 版本化 | `python -m paistation.sovereign.dossier status` | data/dossier 内部独立 git 快照式提交（人生资产不上公开仓） |

真机验收判据（DISRUPTION_PLAN 原文「导出包在无 PAI-Station 的机器上人可读可 grep」）：`grep 白龟湖` 命中 `vault/evidence/` 两份档案。换电脑、换 AI、隔十年——卷宗还是你的。

---

## 🏗️ 液态架构：目录即器官（M8 已上线）

产品本体不是代码，是 **12 个自主更新的器官目录**——引擎重写不丢资产：

| 器官 | 使命 | 器官 | 使命 |
|---|---|---|---|
| `00 愿景` | 不变式中枢：宪法/裁决记录 | `06 技能` | SKILL.md 库：四源蒸馏+血缘图 |
| `01 用户` | 自我镜像：画像+纠正资产 | `07 任务` | 8 源任务识别+用户裁决 |
| `02 规则` | 国/行/地/企四级规则库 | `08 成果` | 答案/文稿/报告/方案/工具五层 |
| `03 样本` | 终稿库+企业内网镜像 | `09 发布` | FDE 商店+书城+宣传 |
| `04 智库` | 顶级大脑一手成果（687 篇在库） | `10 反馈` | 返钱账本/评价/漏斗数据 |
| `05 方法` | 从智库炼出的方法论 | `11 进化` | 免疫/复盘/合一指数/进化提案 |

每个器官 = `README.md`（宪法）+ `_state.json`（水位状态）+ `_credentials/chain.jsonl`（**sha256 凭证链**——器官间流转必落凭证，篡改即时可验，红线 R14）。

## 🧠 感知型意图发现：活动 → 意图（V3 意图层，M7/M8）

GitHub 十万星项目都在做「指令 → 操作」的执行型 agent；PAI 做的是反方向的蓝海——**「活动 → 意图」的感知型理解**：不等你开口，先看懂你在干什么。方法论栈来自 71 项调研（20 年学术谱系 TaskTracer→SWISH→SummAct + 工程互证，见 `RESEARCH_DOCKET/v3/11-intent-recognition/`）：

```
15 路信号源                    七层理解栈
─────────────────────         ─────────────────────────────
前台窗口/AFK 迟滞/剪贴板        ① 事件流分段（task-blocks 断块规则）
浏览器域名反查(免扩展)/进程      ② L1 快通道（10 类规则级联，零 LLM）
会话锁屏/网络 SSID/语音/fs      ③ L2 慢通道（UItron 三档路由按需烧 token）
        │                      ④ 双层拒识门（「无关」是一等输出）
        ▼                      ⑤ 时序记忆（MIRIX↔profile 五层对接）
  IntentService 常驻            ⑥ 纠正飞轮（晨报修正→ICL 注入）
  （增量游标·断点续跑）          ⑦ 屏幕观察档位（OCR/VLM 升级件）
```

- **拒识方向性**：车载语音 fail-open（漏识代价高）→ PAI **fail-closed**（主动助理误触发代价高，宁沉默勿打扰），闸门异常一律保守不触发
- **省 token 秩序**：L1 统计门先拦（拒掉的块不进 LLM）→ L2 摘要 → LLM 出品再过细判门
- **降级矩阵**：无 LLM 网关 → L1 直判照常出意图；OCR/VLM 缺席 → tier 0 纯信号；全部缺席不崩
- **隐私红线**：剪贴板密码形状零痕迹（连元数据不留）；正文永不入事件流；屏幕观察遇黑名单窗口提供方零调用
- **金标准验收**：81 行（69 分类 + 10 拒识 + 2 接受），L1 准确率 ≥90% 断言 + 拒识零漏放，测试卡死不漂移
- **7 天无人值守浸泡**：`python tools/soak_unattended.py --data-dir <目录>`（journal 断点续跑、单轮异常不杀、随时 Ctrl-C）

## ☁️ 云感知连接器：事件流长出云上触角（V3 M9）

「只要用户能提供就能感知」——ConnectorRegistry 把云端变化汇入与本地信号同一条事件流，新源=注册即接入：

| 连接器 | 感知方式 | 事件类型 |
|---|---|---|
| 腾讯会议 | MCP JSON-RPC（38 工具真机验证） | `cloud.meeting.list` |
| 百度网盘 | bdpan CLI 只读 ls diff（有界 BFS 深度 3 封顶） | `cloud.drive.change` |
| 微信情报 | 产物目录 mtime 轮询 | `cloud.wih.insight` |

- **opt-in 授权门**：GrantsStore 落盘重启不丢、随时可撤；登录永不由 agent 代走（用户浏览器授权）
- **水位线增量**：会议=(id,status) 集合 / 网盘={路径:大小} 快照——重复 collect 零重复事件，故障时水位线原地踏步不丢账
- **账号安全四件套**（节流+冷却+日限额+熔断）为框架强制件，单源故障隔离零风暴
- **沙箱边界实证**：bdpan 授权范围=/apps/bdpan 应用目录（开放平台安全设计），连接器只做只读，删除永不执行

**渠道栈**（`.claude/skills/`，skill 生态即插件）：飞书 23 域 lark-cli · 企微双通道 · 金山文档 kdocs-cli · 腾讯文档 mcporter 四服务 444 工具 · 百度网盘 bdpan · 钉钉 dws · 腾讯会议 MCP。

### 📡 用户上下文渠道全景（2026-09-16）

「比用户更懂用户」的数据底盘——五层渠道全部只读，红线统一：密码库/Cookie 永不解密｜聊天内容只收平台官方导出｜剪贴板密码形状零痕迹｜agent 永不代登：

| 层 | 渠道 | 机制与战果 | 状态 |
|---|---|---|---|
| **本地信号** | 窗口焦点·在场·剪贴板·浏览器域名·进程·锁屏·WiFi | M7a 七路采样（AFK 迟滞、签名去重、单源故障隔离） | ✅ 常驻 |
| | 语音环境 | sounddevice → silero VAD → SenseVoice int8（M1 管线） | ✅ |
| **文件宇宙** | 全盘清单 + 内容索引 | Everything MFT/USN 29 万文件 33 秒 · 提取缓存阶梯（行业空白）· FTS5 trigram+vec0 混检 · **MCP 只读三工具**（任意 agent 会话可问「哪份文档讲过 X／某文件在哪」） | ✅ 33k 已提取，25 万队列夜跑中 |
| **云端事件** | 腾讯会议 · 百度网盘 · 微信情报 | M9 连接器汇入 cloud.* 事件流（opt-in+水位线增量+账号安全四件套） | ✅ |
| **协作平台** | 飞书 · 企微 · 金山文档 · 腾讯文档 · 钉钉 | lark-cli 23 域 530 万字语料 · 企微双通道 · kdocs 46 文件全量元数据 · mcporter 444 工具 · dws | ✅（钉钉待登录） |
| **深数据** | 微信本地库 · 微信读书 · 浏览器考古 | wechat-cli 21 库只读 · 会员整书提取（日限 3 本+书间冷却）· Chrome/Edge/360 历史+书签+下载（self-profile 五层考古） | ✅ |
| **记忆画像** | 检索记忆 · 用户画像 | memory 混检（FTS5+vec0+RRF）· profile 五层双时间线 · SELF_PROFILE dossier + 覆盖度四态声明（✓/◐/⏸/🔒） | ✅ |

外部情报渠道（秘塔/搜狗微信/研报等）属调研线，不采集用户数据，不在本表。

## 📰 微信简报夜间流水线（2026-09-16 上线，端到端实测）

「深数据」的产品化第一弹——每天替你读完微信，早上一句话知道该干什么：

```
每晚 22:00（schtasks WeChatBriefDaily）
  S1 全天索引（80 会话×500 条） → S2 机器初筛（话题/跨群链接/信号雷达）
  → S3 无头 Claude 语义编辑（甄别培训投放≠商单、转发者≠品牌方）
  → S4 旗舰交互 HTML → S5 PDF（Edge 无头）
  → S6 发布阿里云 :8883（index + latest.pdf + archive/日归档）
  → S7 双通道推送：微信（PDF+网址，桥发件箱·离线补送）+ 企微（必达）
```

- 全链路只读本地微信库；单轮约 10 分钟；失败段企微告警；`WeChatBriefPause` 旗标一键暂停
- 运维口径：日志/状态/断点全落 `tools/logs/`，技术细节不进推送（用户视角大白话）

## ⚙️ 7×24 主循环（一行命令）

```bash
python tools/run_station.py
```

每分钟一拍：**在场探测**（键鼠<5 分钟深读让路）→ **增量补扫**（watchdog+mtime 兜底）→ **微信深读状态机**（夜间窗口）→ **进化提案闸**（每周）→ **PDCA 复盘**（每日）。单环节故障不杀主循环（附录 P 底线）。

## 🌙 微信深读：安全工程，不是爬虫（M10）

PC 微信**纯视觉零注入**——截图 → GLM 视觉理解 → 文本摘要入画像，**截图永不落盘**（即读即删）。

五重安全脑（`src/paistation/sense/deepread.py`，14 项测试锁死）：

| 件 | 参数 | 红线 |
|---|---|---|
| 夜间窗口 | 00:00–05:00，每夜 ≤1 会话 | R13 永久生效 |
| 启动提醒 | 会话前 10 分钟企微提醒，含 STOP | 提醒未送达→当夜不执行 |
| 预算硬顶 | ≤300 屏 / ≤90 分钟，先到为准 | 不抓屏不烧模型 |
| 连续熔断 | 连续 2 夜异常 → 暂停等用户 ACK | 用户确认才恢复 |
| 在场让路 | 最近键鼠 <5 分钟自动推迟 | 夜间也绝不抢鼠标 |

缺席语义：应用没开 = 成功空转，**不熔断**（缺席 ≠ 故障）。

## 🔬 两阶段调研管线（M9，已实跑）

```
框架提取(parse_toc) → 框架合成(聚类/频次) → 问题清单(≥300 闸门)
  → 综合调研(Bing 证据池) → 知识炼金(GLM 结论卡) → 三层重构 → 密度计验收
```

首课题《EPC 合同风险与索赔管理》实跑：3 框架 → 85 节点主框架 → **600 问过闸** → **599/600 有证据（99.8%）** → 结论卡 → 密度分验收（`08 成果/research/`）。

问题生成算法：节点 × 5W1H 模板 × 8 利益相关方 → 归一化去重 → 频次分级（must≥0.7 / should≥0.4 / may）。

## 🏭 FDE 方案工厂 + 漏斗三段（M11）

```
04 智库语料 → Reconstructor 逐节重构（密度闸门+断点续传+降级明示）
  → 成品 data/foundry/plans/ → 上架 09 发布/store（manifest+试读 20%）
```

- **三段漏斗**：¥9.8–19.8 钩子（试读 20%+反馈入口）→ ¥198–498 全案 → 定制开发线索
- **定价实验**：plan_id 哈希稳定分 A/B 桶，账本可回溯
- **红线**：全案只留本地 `data/`（gitignore），商店目录只放 manifest+试读
- **7.4 可证伪目标**（90 天）：上架 20 案 / 净进账 ≥¥10,000 / 反馈 ≥60 / 定制线索 ≥3——`funnel_stats()` 实时读数，零数据=0 不编造

## 🧬 进化闭环 v2（M12）：系统每周主动变异

```
合一指数 U 分域报告 + 漏斗账本 + 90 天零用清单
  → 进化提案生成器（每周）：每案必附 before→after 证据+风险+回滚
  → 企微卡片：批准/驳回/改期（用户一键裁决）
  → 批准 → PR 落对应器官 + R14 凭证 + 全量回归
```

- **R15 红线**：系统永不自批——`land()` 无用户批准即 `PermissionError`
- **不可裁撤清单**：深读参数/只读守卫/账号节流/熔断器永不出现在裁撤候选
- 裁决 CLI：`python tools/evolution_approve.py`（列表 / `--approve` / `--reject`）

## 🛡️ 安全与隐私红线（不可协商）

- **账号安全第一**：微信读书/搜狗/PC 微信采集必配 节流+冷却+日限额+熔断+串行铁律
- **只读守卫**：项目目录外只读；`FileGuard` 审计全部访问
- **密钥永不进仓库**：`config/*.secret.ini` 全部 gitignore，环境变量优先
- **隐私分层**：原始截图/凭据/身份证/银行卡 永不外发（`never_send` 白名单制）
- **凭证链**：器官间每次流转 sha256 落链，`audit_chain()` 全站审计
- **只增不删**：账本/凭证/归档永不物理删除

## 🧩 缝合怪宪法：三层选型律

> 自有资产（40+ 项目：We-AIPO/ResearchFactory/SouGouWeDown2/微信读书链…）
> → 全球 GitHub 既有成果 → 才自研。

本项目自研仅两件真难点：**问题清单生成器**（节点×5W1H×利益相关方算法）与**夜间深读调度器**（五重安全脑状态机）——其余全部站在巨人肩膀上。

---

## 🚀 快速开始

```bash
# 1. 环境（Windows + Python 3.11+）
python -m venv .venv && .venv\Scripts\pip install -e ".[dev]"

# 2. 配置（密钥外置，参考 config/pai.ini）
#    PAI_LLM_KEY=智谱key  PAI_WECOM_WEBHOOK=企微机器人

# 3. 测试（1352 项全绿为出厂标准，2026-09-16 实测）
.venv\Scripts\python -m pytest

# 4. 器官自检 + 启动主循环
python tools/bootstrap_organs.py     # 幂等：建 12 器官目录/宪法/凭证链
python tools/run_station.py          # 7×24：感知/深读/进化/PDCA
```

### 常用工具

| 工具 | 用途 |
|---|---|
| `tools/run_station.py` | 7×24 主循环守护 |
| `tools/research_run.py` | 两阶段调研管线实跑 |
| `tools/fde_factory.py` | FDE 20 案排产（断点账本） |
| `tools/soak_unattended.py` | 意图层 7 天无人值守浸泡（断点续跑） |
| `tools/maoxuan_harvest.py` | 搜狗微信采集（35 分钟冷却/串行） |
| `tools/evolution_approve.py` | 进化提案用户裁决 |
| `tools/wechat_brief_daily.py` | 微信简报夜间流水线（22:00 七段：索引→编辑→渲染→PDF→发布→推送） |
| `tools/notify_wecom.py` | 企微通知 |

## 📁 代码结构

```
src/paistation/
├── organ/        # 12 器官注册表/状态/凭证链/巡检（液态架构内核）
├── intent/       # 感知型意图发现：segmenter/l1_fast/l2_slow/reject_gate
│                #   /intent_memory/flywheel/screen_tier/常驻服务（M7/M8）
├── ops/          # 无人值守长跑基建：浸泡跑/断点续跑/随时可停（M8）
├── resident/     # 常驻 daemon/托盘/IPC（V3 骨架，服务契约 tick(paused)）
├── profile/      # 用户画像五层模型+双时间线+夜间整合（V3）
├── execute/      # LlmGateway 多供应商 failover + AgentRunner（V3）
├── sovereign/    # 主权架构；dossier/=主权卷宗四件套（OKF 构建/导出/校验/git）
├── gate/ control/ market/ governance/   # V4 五阶段主权架构其余四件
├── evolve/       # 合一指数 U + 每周进化提案（M12）
├── foundry/      # 调研管线/框架合成/问题生成/FDE工厂/漏斗（M9/M11）
├── sense/        # 15 路信号源/增量扫描/深读安全脑/视觉读取器（M7a/M10）
│   └── cloud/    # 三云感知连接器：腾讯会议/百度网盘/微信情报（V3 M9）
├── llm/          # 智谱免费链客户端（429自愈/余额摘链/视觉bytes直传）
├── memory/ security/ learn/ proactive/ channels/ soul/ skills/ forge/ rules/
└── runtime.py    # 整机装配：每分钟一拍的主循环状态机
```

## 🗺️ 里程碑

| 里程碑 | 内容 | 状态 |
|---|---|---|
| M1–M7 | 感知/记忆/规则/技能/商店/方案工厂（V1 工具范式） | ✅ |
| M8 | 液态 12 器官 + 凭证链（V2 关系范式） | ✅ |
| M9 | 两阶段调研管线 + 首课题实跑 | ✅（毛选语料采集中） |
| M10 | 深读安全脑 + V1 纯视觉读取器 + 7 夜实测 | ✅ 代码 / 🌙 实测进行中 |
| M11 | FDE 扩产 20 案 + 漏斗三段 + 定价实验 | 🏭 排产中（断点账本） |
| M12 | 合一指数 U 仪表盘 + 每周进化提案 | ✅ |
| V3 M1–M6 | 常驻 daemon/事件流/画像/执行网关/规则/分发（10 路调研 454 项） | ✅ |
| V4 五阶段 | sovereign/gate/control/market/governance 主权架构 + CHARTER | ✅ |
| M7 意图层 | 七路信号源补全 + 意图最小闭环 + 理解深化（71 项调研落地） | ✅ |
| M8 意图运营 | 常驻服务接线 + 屏幕观察档位 + 金标准 81 行 + 7 天浸泡基建 | ✅ / 🌙 浸泡实测待跑 |
| 云感知连接器（V3 M9） | 腾讯会议/百度网盘/微信情报三连接器 + opt-in 授权 + 水位线增量 | ✅ 真机闭环（会议预订/网盘 3 事件/上传验证） |
| 运行时自治（2026-09-16） | 七路信号源常驻上电 · 微信桥自启看护 · 微信简报夜间流水线（阿里云站点+双通道推送） | ✅ 端到端实测 |
| **P0 主权卷宗（2026-09-17）** | 三源统一 OKF 明文目录 + git 独立版本化 + 一条命令导出（sha256 逐件验证，无本产品机器可读可 grep） | ✅ 真机验收（`ccfdefb`） |

## 📜 治理

- 宪法：C0 复利元则 / C4 站在巨人肩膀 / C7 十倍方案先批 / C8 批后全自主 / C11 修复必附 before→after / C12 黄金标准验证 / C14 不编造数据
- 红线：R1–R15（代理即关/账号安全/只增不删/日预算/密钥外置/深读夜间+提醒/流转落凭证/系统永不自批）
- 收紧免问，放宽须批。

---

<div align="center">

**"懂你是起点，合一是方向。"**

PAI-Station · 与你共同进化 · [提案](PROPOSAL_V2.md) · [V3 提案](PROPOSAL_V3/PROPOSAL.md) · [愿景](00%20愿景/) · [商店](09%20发布/store/index.json)

</div>
