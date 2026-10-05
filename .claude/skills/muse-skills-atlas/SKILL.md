---
name: muse-skills-atlas
description: Index and lookup map covering all 72 vendored Meta Muse (MuseAI-Skills) agent skills. Consult whenever you need to find which Muse skill covers a capability (agent workflow/memory, artifact building and QA gates, travel search and booking, office/mail/knowledge connectors, social messaging, shopping/health/media, or Muse product and device mechanics), locate its original SKILL.md in the vendored snapshot, or map one of the 17 activated muse-* ports back to its upstream source.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: .
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

# MuseAI-Skills 全量索引（muse-skills-atlas）

## 来源说明

本索引整理自微信文章《Meta Muse 的 68 个 Skills 全貌曝光》所梳理的 GitHub 仓库 [win4r/MuseAI-Skills](https://github.com/win4r/MuseAI-Skills)（快照 commit `38bbb45a2c5a0f70de975f6387385770b9ad8aac`）。该仓库是 muse.ai（Muse/Hatch）个人 AI Agent 运行环境的**非官方快照存档**——不是官方开源发布，核心程序为 Linux ELF 二进制且未随源码，但其中 `opt/hatch/skills/` 下的技能文本（何时触发、如何分流、怎样验收）完整可读，是本批移植的唯一上游。快照已完整落地在本地：**vendored 根 = `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/`**（下文所有 `skills/...` 路径均相对此根）。仓库级导读见同目录 `PROJECT_ANALYSIS.md`（架构/缺项/风险）与 `README.md`（技能目录/文件导航）。本仓库对其中 17 个技能做了激活移植（`E:/AI-Station/.claude/skills/muse-*`），其余以参考形态入库。

**状态图例**：★ = 已激活移植（箭头后为本地 `muse-*` 技能名，可直接触发使用）；◇ = 参考入库（vendored 原文路径，按需阅读）；stub = 仅 19-28 字节的占位重定向文件，正文为一行 `../<目标>/SKILL.md` 相对链接，无实质内容。

## 全量分类表（72 个 SKILL.md = 68 个独立技能 + 4 个 stub 别名）

### Agent 工作流与记忆（6）

| 技能 | 一句话职责 | 状态 |
|---|---|---|
| wide-research | 多输入并行研究：协调者+worker 分工、统一输出字段契约、覆盖率与失败项报告 | ★ muse-wide-research |
| goals | 按生活领域创建目标、记录承诺并持续跟进进展（附 creation/ 首建与 guides/ 跟进指南） | ★ muse-goals |
| skill-creator | 技能编写法：触发式描述、目录拆分（SKILL.md/references/assets）、编写检查清单 | ★ muse-skill-creator |
| self-awareness | 把"我是谁/能做什么/记得什么/建过什么"锚定在 Agent 实际文件系统事实上作答 | ★ muse-self-awareness |
| forget | 跨记忆及衍生内容的遗忘流程：规划→确认→验证，防副本与后台任务写回 | ★ muse-forget |
| muse_db | 受限只读 SQL 跨表追踪，诊断执行与交付记录（references/schema.md 记 17 命名空间 195 关系） | ★ muse-db |

### 文档与产物验收（6）

| 技能 | 一句话职责 | 状态 |
|---|---|---|
| artifacts/document | Word .docx/.dotx 生成与编辑：python-docx、OOXML 直改、修订批注、渲染验证 | ★ muse-artifact-document |
| artifacts/markdown | Markdown 交付物（笔记/README/纪要）：格式规范与交付前回读验证 | ★ muse-artifact-markdown |
| artifacts/pdf | 固定版式 PDF：print-CSS HTML 源、渲染/几何/验证门，既有 PDF 合并拆分填表 | ★ muse-artifact-pdf |
| artifacts/presentation | 幻灯片（默认 pptx）：逐页 HTML、StylePlan 主题、字体内嵌、组装与 PPTX 导出 | ★ muse-artifact-presentation |
| artifacts/spreadsheet | 表格 .xlsx/.xlsm/.csv/.tsv：openpyxl 生成、公式重算、脏数据重构、验证门 | ★ muse-artifact-spreadsheet |
| artifacts/testing | 交付前验收：按产物类型跑 gate、渲染后亲眼看、残留占位符扫描 | ★ muse-artifact-testing |

### 旅行搜索预订（7）

| 技能 | 一句话职责 | 状态 |
|---|---|---|
| travel-planning | 行程规划/可行性/入境转机/地面交通研究；可订项分流给 booking 腿 | ★ muse-travel-planning |
| booking | 航班/酒店/餐厅/门票实时可订查询与交易的总入口（先于各 provider 技能加载） | ◇ skills/booking/ |
| places-search | 按地点查找比较餐厅/咖啡馆/景点/商店等实体场所，不做行程与导航 | ◇ skills/places-search/ |
| duffel | 航班搜索/预订/付款/订单管理，及明确请求的已订航班票价监测 | ◇ skills/duffel/ |
| flightaware | 核实具体日期航班时刻/延误/取消，监控已订航班运行变化 | ◇ skills/flightaware/ |
| opentable | 餐厅可订时段查询，创建/修改/取消预订 | ◇ skills/opentable/ |
| ticketmaster | 活动与座位票价搜索，交付购票链接，不代完成购买 | ◇ skills/ticketmaster/ |

### 办公邮箱知识（16）

| 技能 | 一句话职责 | 状态 |
|---|---|---|
| gmail | Gmail 检索/阅读/草稿/发送/回复/转发/退订/标签/附件 | ◇ skills/gmail/ |
| google-calendar | Google 日历议程视图、事件详情与日程变更 | ◇ skills/google-calendar/ |
| google-contacts | Google 联系人搜索/创建/更新/删除 | ◇ skills/google-contacts/ |
| google-docs | Google 文档读取/创建/编辑 | ◇ skills/google-docs/ |
| google-drive | Drive 文件与文件夹管理、上传下载与分享 | ◇ skills/google-drive/ |
| google-forms | Google 表单读取/创建/更新与回复读取 | ◇ skills/google-forms/ |
| google-sheets | Google 表格读取/写入/管理 | ◇ skills/google-sheets/ |
| google-slides | Google 幻灯片读取/创建/编辑 | ◇ skills/google-slides/ |
| google-tasks | Google Tasks 列表与任务的创建/更新/完成 | ◇ skills/google-tasks/ |
| outlook-calendar | Outlook 日程事件的查看/创建/更新/删除 | ◇ skills/outlook-calendar/ |
| outlook-contacts | Outlook 联系人列表/搜索/增删改 | ◇ skills/outlook-contacts/ |
| outlook-mail | Outlook 邮件读取/搜索/发送/回复/删除 | ◇ skills/outlook-mail/ |
| notion | 经 Notion MCP 搜索/读取/创建/更新页面 | ◇ skills/notion/ |
| granola | 经 OAuth MCP 搜索读取 Granola 会议笔记与转录 | ◇ skills/granola/ |
| muse-mail | Muse Mail 专用邮箱与转发邮件的路由处理 | ◇ skills/muse-mail/ |
| calendly | Calendly 事件与事件类型查看、预约数据管理 | ◇ skills/calendly/ |

### 社交消息（8，含 2 个 stub 别名）

| 技能 | 一句话职责 | 状态 |
|---|---|---|
| facebook-cli | 读取 Facebook 帖子/评论/反应/好友/动态/群组/活动/收藏，管理自家 Marketplace 刊登 | ◇ skills/facebook-cli/ |
| instagram | Instagram 帖子与 Reels 问答、账号与洞察读取，按请求发布故事/Reels/轮播 | ◇ skills/instagram/ |
| instagram-messages | Instagram 收件箱/会话/接收方/私信搜索与发送 | ◇ skills/instagram-messages/ |
| messenger | Messenger 联系人/通话记录/会话检索，发送/反应/撤回/编辑消息 | ◇ skills/messenger/ |
| threads | Threads 账号/帖子/信息流/洞察/搜索，按请求发布 | ◇ skills/threads/ |
| threads-messages | Threads 消息收件箱与会话读取、发送消息 | ◇ skills/threads-messages/ |
| facebook | 占位 stub，实际指向 facebook-cli（读那边即可） | ◇ stub→facebook-cli |
| meta-threads | 占位 stub，实际指向 threads | ◇ stub→threads |

### 购物健康媒体（19，含 2 个 stub 别名；行序 = 购物金融 → 健康 → 媒体语音）

| 技能 | 一句话职责 | 状态 |
|---|---|---|
| shopping | 商品搜索/以图搜商品/比价/购买流程总路由，含 Facebook Marketplace 浏览购买 | ◇ skills/shopping/ |
| printify | Printify 商品目录/店铺/商品管理与订单处理 | ◇ skills/printify/ |
| plaid | 读取 Plaid 连接的金融账户：元数据/余额/交易/负债/投资 | ◇ skills/plaid/ |
| apple-healthkit | 读取同步的 Apple Health 每日指标/睡眠分期/运动记录 | ◇ skills/apple-healthkit/ |
| google-health-connect | 读取 Android Health Connect 同步的每日指标/睡眠/运动 | ◇ skills/google-health-connect/ |
| function-health | 读取 Function Health 检验指标与临床备注 | ◇ skills/function-health/ |
| healthex | 连接 HealthEx 查询药物/化验及其他健康记录 | ◇ skills/healthex/ |
| peloton | Peloton 健身课程浏览/课表/训练预约 | ◇ skills/peloton/ |
| withings | Withings 身体/活动/睡眠/心脏/日内数据读取 | ◇ skills/withings/ |
| image-search | 按文本查询搜公开图片 URL 与来源页面，不做识图 | ★ muse-image-search |
| media-library | 搜索查看用户图库及已连接设备相册 | ◇ skills/media-library/ |
| spotify | Spotify 音乐/播客搜索与管理、播放列表管理 | ◇ skills/spotify/ |
| generate_podcast | 创作单/多声音播客/简报/口播摘要并交付 MP3 | ★ muse-generate-podcast |
| tts | 把给定文本转单人或多人语音 | ★ muse-tts |
| voice-design | 按用户请求选择或设计新语音 | ◇ skills/voice-design/ |
| voice-selector | 系统静态语音目录，本身不是用户工作流 | ◇ skills/voice-selector/ |
| magic-moment | 把真人口播视频编排成 Agent 工作成果回放的竖屏视频 | ★ muse-magic-moment |
| podcast | 占位 stub，实际指向 generate_podcast | ◇ stub→generate_podcast |
| voice-calls | 占位 stub，实际指向 voice-selector（不能据名推断能代打电话） | ◇ stub→voice-selector |

### Meta 产品机制（10；行序 = Muse 产品操作 → 设备与网络）

| 技能 | 一句话职责 | 状态 |
|---|---|---|
| muse-early-access | Muse 抢先体验计划的申请/查询/撤回 | ◇ skills/muse-early-access/ |
| muse-feedback | 按用户授权提交/查看/撤回对 Muse 团队的反馈与功能请求 | ◇ skills/muse-feedback/ |
| share-ideas | 按明确请求发布可复用的原生 Muse Idea | ◇ skills/share-ideas/ |
| subscription-status | 查询 Muse 套餐/额度/用量/重置时间/计费状态 | ◇ skills/subscription-status/ |
| device-data | 读取缓存联系人与日历，删除 Muse 本地副本不动配对设备 | ◇ skills/device-data/ |
| wearable-device-skills | 发现/调用配对手机或穿戴设备动态发布的 agent 能力 | ◇ skills/wearable-device-skills/ |
| wearables-comms | 从穿戴设备发起的通话/短信：解析联系人歧义并经原设备执行 | ◇ skills/wearables-comms/ |
| philips-hue | Philips Hue 智能灯/房间/场景控制（Hue Remote API v2） | ◇ skills/philips-hue/ |
| tessie | Tesla 车辆状态监控与明确授权的命令端点调用 | ◇ skills/tessie/ |
| tailscale | Muse 内置 Tailscale 连接器：加入 tailnet、经 TCP 代理访问私网机器 | ◇ skills/tailscale/ |

> 口径备注：另有 40 个 `manifest.yaml`（连接器方法级权限）与 12 份 `eval/*.yaml`（行为评测场景）为配套件，不计入技能数；`spaces/` 目录只有运行时文档无 SKILL.md，同样不计。

## 优先阅读推荐

按工作流设计参考价值选出五份，均指 vendored 原文（相对 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/`）：

1. **skills/wide-research/SKILL.md**（仅 45 行）——协调者与 worker 职责边界、统一输出 schema、失败与覆盖率上报的最小完整范例；篇幅短而契约意识密度最高。
2. **skills/artifacts/testing/SKILL.md**——把"生成成功"与"交付物可用"分开验收的完整设计：按类型 gate、渲染后亲眼看、占位符扫描、三次修复失败即上报求助。
3. **skills/skill-creator/（含 references/authoring_guide.md）**——触发条件怎么写才不会漏触发/误触发、主文件如何精简、参考资料如何按需加载；写任何技能前都值得对照。
4. **skills/forget/（含 references/artifact-inventory.md）**——遗忘远不止删主记录：副本、衍生索引、后台任务写回的完整对抗清单，是数据治理类设计的范本。
5. **skills/goals/（含 creation/ 与 guides/）**——按领域区分首次建目标与后续跟进、避免重复 intake 的分流设计，配套文件展示了"主文件+分域指南"的组织法。

## 已激活移植映射（17）

| 上游技能 | 本地技能 | 适配要点 |
|---|---|---|
| wide-research | muse-wide-research | 纯方法学技能（45 行无附属脚本），范式原样保留，隐式 Muse 机制以「本地注」映射 |
| goals | muse-goals | 领域划分/承诺记录/跟进节奏全保留，Goals-tab 创建契约等专属入口改通用表述 |
| skill-creator | muse-skill-creator | 编写法保留；与 github-to-skills 工厂互补——本技能管"写得好"，工厂管"搬得对" |
| self-awareness | muse-self-awareness | "自指问题锚定实际文件系统"改为 Claude Code 下检查自身技能/记忆/配置/渠道 |
| forget | muse-forget | 规划-确认-验证三段式保留；hatch 的 forget.plan/confirm 改为两段子代理+用户确认 |
| muse_db | muse-db | 受限只读 SQL 诊断方法论保留，Muse schema 文档（17 命名空间/195 关系）在库作参考 |
| artifacts/document | muse-artifact-document | .src/ 发生器脚本、真结构不造假、渲染验收工艺保留，Muse 专用路径改参考式 |
| artifacts/markdown | muse-artifact-markdown | 格式规范与回读验证保留，Muse 专有工具与 /opt/hatch 路径改参考式表述 |
| artifacts/pdf | muse-artifact-pdf | print-CSS 源+渲染/几何/验证门保留，上游 gate 脚本逐条标注本地映射 |
| artifacts/presentation | muse-artifact-presentation | 逐页 HTML+StylePlan+组装纪律保留，hatch-slide-style 等未分发脚本按 vendored 契约等价执行 |
| artifacts/spreadsheet | muse-artifact-spreadsheet | 交付规则/公式存活纪律/验收门语义保留，脚本路径改参考式 |
| artifacts/testing | muse-artifact-testing | 验收哲学原样保留，Muse 专用脚本路径改为参考式并逐条标注 |
| travel-planning | muse-travel-planning | 规划方法论与状态纪律保留英文原文实质，booking/Duffel 等连接器腿逐条给本地映射 |
| image-search | muse-image-search | 文本搜图+可渲染定位符+下载预检保留，Muse 搜索连接器改本地可用渠道 |
| magic-moment | muse-magic-moment | 分镜/素材组织/审阅门方法学可本地执行，渲染基建（mm 等）仅作 vendored 参考 |
| tts | muse-tts | 单/多说话人合成工作流保留，上游语音设施本机无等价物、逐条标注参考式 |
| generate_podcast | muse-generate-podcast | 创作/配音/封面/发布流程保留，Save-to-Spotify 等 Muse 发布腿标注【Muse 环境专用】 |

移植通则：正文忠实保留上游英文内容与章节结构，仅把依赖 Muse 运行时（/opt/hatch 路径、hatch_* CLI、连接器 OAuth、VM 机制）的指令改为参考式表述并标注【Muse 环境专用】+本地映射，不发明本机不存在的命令。

## 检索指引

在本仓库找某个 Muse 技能的原文，按下列顺序定位：

1. **vendored 原文**：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/<目录名>/SKILL.md`（目录名即上表"技能"列，注意含下划线的如 `generate_podcast`、`muse_db`；artifacts 系在 `artifacts/<种类>/` 下）。
2. **已激活版**：`E:/AI-Station/.claude/skills/<muse-*>/SKILL.md`，其 frontmatter 的 `upstream_path` 字段即上游路径，正文首节「来源与适配说明」记录了原文位置与行数。
3. **stub 别名**：facebook/meta-threads/podcast/voice-calls 四个文件仅一行 `../<目标>/SKILL.md` 重定向，直接读目标技能。
4. **配套件**：同目录下的 `references/`（深度参考）、`manifest.yaml`（方法级权限与 OAuth scopes）、`eval/scenarios.yaml`（行为评测场景）——连接器类技能（gmail、duffel、plaid 等）应三者连读。
5. **仓库级入口**：vendored 根上两级的 `README.md`（含全部技能的可点击分类目录）与 `PROJECT_ANALYSIS.md`（架构图、交付缺项、风险与证据索引）。
