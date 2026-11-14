# PROPOSAL CX · 用户上下文极致收集工程（立项方案书）

> 2026-09-16 · 五路并行调研（GitHub API 实证 + 学术/商业一手来源）合成
> 目标一句话：**把"了解电脑主人"做成可度量、可证伪的工程——比用户本人更懂他自己。**

---

## 0. 批准点（先看这里）

| 期 | 内容 | 需要什么 | 建议 |
|---|---|---|---|
| **P0 取证回填** | Windows 取证五件套 + git 时间线 + Claude 会话蒸馏 + 读书划线 + 通知中心/作息边界等 🟢 尾巴源 | 无（全本机只读） | **批准即跑，今晚可完成大半** |
| **P1 行为流升级** | ActivityWatch 元数据层（常驻）+ screenpipe 像素/语音层（可选） | screenpipe 吃 CPU 5-10%/内存 0.5-3GB/约 20GB 月 | ActivityWatch 批；screenpipe 先装 48h 试用期再定去留 |
| **P2 融合架构** | 统一事件封套（全源主时间轴）+ graphiti 时序知识图谱 + splink 中文实体消解 | 无 | **本工程核心架构，强推** |
| **P3 画像引擎** | 固定 schema 画像 + ADD-only 事实抽取 + 夜间 dream 整合 + "主人问答"金标准评测 | 无 | 强推（含护城河证明） |
| **P4 外部源** | 手机备份（只解析工作面）/ 邮件 | **需你配合**：手机连机备份；SRUM/Prefetch 需管理员一次性授权 | 你有空时逐项挂起清单 |

红线全部不变：不解密密码/Cookie、聊天只走官方导出、agent 永不代登、零云上传、账号安全四件套。

---

## 1. 目标与验收

**目的边界（2026-09-16 用户明确）**：了解这个人 = **本人 + 他的工作**，目的是帮助他工作。个人消费（支付账单/消费结构）与纯私人化内容**不采集、不入画像**。手机等混合源只解析工作相关面（通讯录/日程/工作沟通），相册/健康/私人聊天不解析。

**主轴（2026-09-16 用户再明确）**：深刻理解**工作相关的一切**。落地为《SELF_PROFILE/工作全景地图_20260916.md》七域分解——工作对象/人际/知识/方法/日程/观点/演化（六维在工作镜头下的投影）。后续所有采集与画像工作以此图为总清单，每接入一源即登记覆盖度。

**六维框架为工程顶层方法（2026-09-16 用户批准）**：**事实 × 行为 × 关系 × 观点 × 节律 × 演化**。落地为 `src/paistation/cx/dimensions.py`：每维登记数据源映射 + L0-L4 成熟度等级（L0无数据→L1数据在位→L2管线化→L3融合可检索→L4可评测）+ 量化探针；`tools/cx_dimensions.py` 随时产出六维记分卡快照。所有 P0-P4 工作最终以"把某维推到 L3/L4"为验收口径。

可证伪度量（学界空白=我们的机会，借 NTCIR Lifelog 思路自建）：
- **主人问答集**：≥100 个模糊自传问题（"我去年九月主要在忙哪个项目？""白龟湖的对方律师是谁？"），以全源日志为金标准，月度跑召回率
- **行为预测命中率**：下一小时打开哪个应用/文档的 top-3 命中率
- 两项跑分进每月企微报告——"更懂你"从口号变成数字

## 2. 现状盘点（资产 vs 缺口）

已有重资产（不重复建设）：
- 60 源全景清单（SELF_PROFILE/可挖信息源全景清单_20260916.md，实测 A-H 八类）
- 静态清点第一波（SELF_PROFILE/static_inventory/2026-09-16/：143 程序/20 扩展/184 Recent/49 计划任务/Claude 会话库 51 会话 1138MB）
- 常驻感知：M7a 七路信号源 + 意图层七层栈 + 深读安全脑（夜间微信）
- 文件宇宙：Everything 29.6 万文件 + L0-L4 提取管线夜跑 + FTS5/vec0 混检 + MCP 三工具
- 云端/协作：会议/网盘/微信 21 库/飞书 530 万字/金山/腾讯文档/企微/ima
- SELF_PROFILE 画像层：ICD203 情报画像、KWP-7 人格、master profile 系列

缺口（本工程要补）：行为流纵深（取证工件全量回填）、融合架构（平行仓→一张图一条轴）、画像引擎（画像可更新可遗忘可评测）、移动端与外部源。

## 3. 业界全景（五路调研结论）

**① 屏幕与行为流**：业界共识"元数据优先、像素兜底"。screenpipe（21.6k★，YC S26）主抓 accessibility tree、OCR 兜底、SQLite+fMP4 存储、官方 MCP；ActivityWatch（18.9k★）纯元数据 watcher 体系趋近零开销；Windrecorder（停滞）的增量索引+跳过条件思想值得吸收；MS Recall 的增量快照+本地向量索引+系统级隐私过滤可借鉴。Win10 中文最优栈：Windows OCR API 起步 → RapidOCR/WeChat OCR 升级 + FunASR 音频。

**② 记忆与画像**：画像三路线——文件式（Letta block 自编辑/Memobase 固定 schema）、图谱式（Graphiti bi-temporal/cognee）、事件溯源式（Mem0 v3 ADD-only+检索期消解）。共识：遗忘=失效标记不物理删除；在线轻抽取+夜间 dream 巩固是标配；评测基准 LoCoMo/LongMemEval 只测对话记忆，个人画像无公认基准。

**③ 学术与商业 30 年**：MyLifeBits 最大遗产=元数据一等公民+检索优于理解；Rewind→Limitless 教训=全屏常录三输（性能/隐私/信噪比），收窄场景才有即时价值；分层降级管线 raw→transcript→summary→index 是定式；数据主权本地聚合是大厂结构性做不到的位置（Limitless 已被 Meta 收购、Apple 常听入表）。

**④ 分源采集器**：Windows 工件由 libyal+Zimmerman 双璧全覆盖（libpff/python-registry/JLECmd/MFTECmd/rifiuti2，许可干净）；手机走 pymobiledevice3+pyiosbackup（iOS）/android-backup-extractor+seednaut（安卓）+apple-health-parser+google_takeout_parser；浏览器 Hindsight（1.5k★）；输入法：深蓝词库转换 10.3k★ 唯一正解，微软拼音 dat 无解（尝试官方导出，失败即弃）。

**⑤ 融合与隐私**：graphiti 一石三鸟（时态图+实体消解+provenance，本地 Kuzu 可全离线）；中文人名消解是最大坑（微信花名 vs 真名零重叠）——正解=强标识符 blocking（wxid/手机/邮箱）+拼音归一+bge-m3 本地嵌入召回，splink 比较器做第二道；时间轴融合没有轮子，本质是事件模型统一（抄 ActivityWatch bucket/event 封套+双时态）；个人数据湖正确姿势=联邦式（每源一提取器→单仓 SQLite/DuckDB→统一索引，dogsheep 模式）；Presidio 中文 PII 需全自建 recognizer。

## 4. 站在巨人肩膀：选型清单

| 层 | 选型 | 仓库 | 许可 | 用法 |
|---|---|---|---|---|
| 取证工件 | python-registry / JLECmd / MFTECmd / rifiuti2 / libpff | williballenthin / EricZimmerman×2 / libyal | Apache/MIT/BSD/LGPL | 直接用 |
| 浏览器 | Hindsight | RyanDFIR/hindsight | Apache-2.0 | 直接用 |
| 元数据行为流 | ActivityWatch | ActivityWatch/activitywatch | MPL | 直接部署常驻 |
| 像素/语音流 | screenpipe（**source-available 非 OSI**） | screenpipe/screenpipe | 需读条款 | 48h 试用评估，只部署不抄码 |
| 手机/健康 | pymobiledevice3 / pyiosbackup / android-backup-extractor / seednaut / apple-health-parser / google_takeout_parser | doronz88 / matan1008 / nelenkov / Baltram / … | GPL/MIT 混合 | 直接用（GPL 仅本地跑不分发，合规） |
| 输入法 | 深蓝词库转换 imewlconverter | studyzy/imewlconverter | GPL-3.0 | 直接用（若装搜狗） |
| 元数据 | ExifTool / es.exe（闭源免费例外） | exiftool / voidtools | GPL / 免费 | 直接用 |
| Git 挖掘 | git-quick-stats（hercules 停更备用） | git-quick-stats | MIT | 直接用 |
| 时序图谱 | graphiti（+Kuzu 本地图库） | getzep/graphiti | Apache-2.0 | 直接用 |
| 实体消解 | splink（DuckDB 后端） | moj-analytical-services/splink | MIT | 直接用 |
| 本地嵌入 | bge-m3 / bge-small-zh | BAAI | MIT | 直接用 |
| 画像 schema | Memobase 模型 / Monica 四表模型 | memodb-io / monicahq | Apache / 参考不抄码 | 抄数据模型 |
| 事实抽取 | Mem0 ADD-only 范式 | mem0ai/mem0 | Apache-2.0 | 抄管线思想 |
| 评测 | LoCoMo/LongMemEval 方法论 + 自建主人问答集 | snap-research / xiaowu0162 | 开源 | 借鉴出题法 |

**自研件（真难点，护城河）**：① 统一事件封套与全源主时间轴；② 中文人名跨渠道消解的 blocking 策略；③ 主人问答金标准与月度跑分；④ 与现有七路信号/意图层/夜间流水线的接线。

## 5. 五期路线图

### P0 取证回填（1-2 晚，零风险）
- 取证五件套全量解析：跳转列表深解（含 D:\白龟湖 深路径）、USN/MFT 增量（MFTECmd）、回收站 $I、注册表 MRU/TypedPaths 常规化、ActivitiesCache 常驻月度增量
- 60 源清单 🟢 尾巴清零：wpndatabase 通知中心解析、电源/登录事件（作息边界）、文件关联 50 扩展名、微信 Files 附件月度流、企微附件目录登记、微信读书划线/笔记
- git-quick-stats 全仓聚合：64+ 仓库 commit 时间线 → 工作节律+主题演化表
- **Claude Code 会话库蒸馏**：51 会话 1138MB（We-AIPO 682MB 等 20 项目）→ 事实/决策/偏好三线抽取入画像（这是最大未开发金矿）
- 输入法：测搜狗是否在用→深蓝词库转换；微软拼音试官方导出，失败登记放弃

### P1 行为流升级（ActivityWatch 立即 / screenpipe 试用）
- ActivityWatch 常驻（窗口/AFK/浏览器 watcher → bucket/event 本地 REST）——与七路信号源互补不替代
- screenpipe 48 小时试用期：实测 CPU/磁盘/干扰度，出评估报告，你决定去留
- 默认不开全屏常录（Rewind 教训）；隐私排除名单内置（密码框/黑名单窗口）

### P2 融合架构（核心架构件）
- 统一事件封套：`{source, source_id, start, end, type, payload}` + 幂等键 + 双时态（事件时间 vs 入库时间）——全源汇入一张 SQLite/DuckDB 主时间轴（微信/浏览器/文件/git/会议/ Recent/信号源/未来的手机与邮件）
- graphiti + Kuzu 本地时序图谱：人-组织-项目-主题四类节点，bi-temporal 边（"何时为真、何时被取代"）
- splink + bge-m3 中文实体消解：强标识符 blocking（wxid/手机/邮箱/证件后4）→ 拼音归一 → 嵌入召回 → 比较器二道
- Presidio 中文化：手机号/身份证 recognizer 自建，送 LLM 前走脱敏视图

### P3 画像引擎（把收集变成理解）
- 固定 schema 画像文件（Memobase 模型：basic/work/skill/preference/relationship/health + 事件时间线），人可读 + <100ms 注入
- ADD-only 事实抽取管线（Mem0 范式）：新增事实只追加，检索期消解冲突，永不覆写历史
- 夜间 dream 整合（MIRIX auto-dream 范式）：合并去重、失效标记陈旧条目，挂进现有夜间流水线作息
- **主人问答金标准**：100+ 题自建基准 + 行为预测命中率 → 月度跑分进企微报告

### P4 外部源（挂起清单，你有空逐项触发）
- 手机：pymobiledevice3 备份 → pyiosbackup 解析，**只解析工作面**（通讯录/日程/工作沟通），相册/健康/私人聊天不解析（目的边界）；安卓走官方备份+seednaut
- 邮件：你惯用网页邮箱则走 IMAP（imapsync 增量拉）或官方 Takeout；无 Outlook 桌面端
- ~~支付账单/消费结构~~：2026-09-16 用户明确移出范围（个人消费不采集）
- SRUM/Prefetch：需你管理员一次性授权

## 6. 治理与红线（新增三条）

原有红线全部继承。新增：
1. **第三方在场隐私**：任何含他人的内容（聊天/会议/录音）入库打 bystander 标记，画像层只用聚合统计不用原文
2. **许可纪律**：AGPL（Khoj）只借架构不抄码；screenpipe source-available 只部署不改造分发；GPL 工具仅本地运行
3. **保留期限**：原始像素/音频类设默认保留期（建议 90 天滚动，索引与事实永存）——到期自动清理，学 Recall 的数据治理

## 7. 工作量与顺序

P0（2 晚）→ P2（1-2 周，与 P0 可并行）→ P3（1 周，依赖 P2 骨架）→ P1（随时，ActivityWatch 半小时）→ P4（事件驱动）。P0+P2 先行使"数据齐+图成型"，P3 让画像活起来，跑分体系最后闭环。

---

*附：五路调研原始报告存档于本次会话；本方案批准后进入 C8 批后全自主模式，按 R15 永不自批、每期完成附 before→after 证据。*
