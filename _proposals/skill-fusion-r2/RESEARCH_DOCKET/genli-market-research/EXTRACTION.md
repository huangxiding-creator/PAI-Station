# genli-ai/market-research-skills 深读提取报告

- 仓库：E:\AI-Station\_proposals\skill-fusion-r2\research\vendor\market-research-skills\（clone，v1.7.1，MIT，作者 ligen/thu）
- 深读日期：2026-09-26。中文版为主、英文版交叉核对（下文引用以 `.zh.md` 为主，行号均为本次实读行号）
- 已通读：analyst-research 全部文件（SKILL / MODE_REGISTRY / workflow 路由 / light / medium / heavy / report_style_spec / chart_template.py / 两个 quarto yml / publication HTML 模板）、local-vault（SKILL / sync.py 关键函数 / mineru_client.py / config.py）、topic-brief（SKILL / schema.py / renderer.py / fix_quotes.py / prompts/system.md / templates/briefing.html）、verifying SKILL.zh.md、README.md、docs/2026-05-26-design.md、CHANGELOG.md（双语全读）、FEEDBACK.md、hooks/hooks.json、scripts/announce-loaded.sh、scripts/pack.sh、.claude-plugin/plugin.json + marketplace.json
- 一句话定位：这不是一个「资料采集」仓库，而是一个「单研究员出稿工作台」——它把一份研报从选题到 PDF/Word/HTML/公众号四种成品的**出稿端工程**做到了字段级。我方（全渠道调度器 + 弹药池 + 饱和引擎 + Manus 军团 + Jev 判断层 + 七步方法论）覆盖的是**弹药端与判断端**；本仓最强的恰是我们最薄的：**成稿端**（版式规范、图表管线、一致性门、防缩水合同、语言红线 grep、状态文件）。

---

## 零、仓库速览

| 项 | 值 |
|---|---|
| 定位 | 面向投研分析师/政策研究者的 4-skill 合集（Claude 插件形态） |
| 版本 | v1.7.1（2026-06-09），Keep a Changelog + SemVer，双语 CHANGELOG |
| 四 skill | verifying（信息核实）/ topic-brief（主题简报 HTML）/ analyst-research（三档研报主线）/ local-vault（本地知识库） |
| 主线体量 | analyst-research references 共 5 个 workflow/spec 文件 2000+ 行 + chart_template.py 541 行 |
| 实战背书 | 沙特 Vision 2030 深度报告（heavy 档，35 图、1.5 万字+） |
| 安装形态 | marketplace 自注册 / clone / sparse-checkout / zip release / npx skills 六路 |
| 与我方关系 | 上下游互补：它是出稿端工作台，我方是弹药端+判断端工厂 |

主线文件的分工（读法地图）：

```
SKILL.md            选档菜单+路由（~100 行，瘦入口）
MODE_REGISTRY.md    三档参数单一事实源（~90 行）
workflow.md         跨档不变量+按档分发表（路由器）
workflow_light.md   light 6 步全文（~430 行）
workflow_medium.md  medium 8 步全文（~750 行）
workflow_heavy.md   heavy 11 步全文（~1300 行，最厚资产）
report_style_spec.md 版式/图表/出版宪法（~800 行）
chart_template.py   图表样式与三产物落盘（541 行）
_quarto-{light,medium}.yml  每档一份渲染模板
publication-style-template.html  HTML 出版模板
```

---

## 一、MODE_REGISTRY 三档机制（analyst-research 的骨架）

来源：skills/analyst-research/MODE_REGISTRY.zh.md（+ SKILL.zh.md Step 0、references/workflow.zh.md）

### 1.1 三档参数总表（MODE_REGISTRY.zh.md:8-25）

| 维度 | light | medium | heavy |
|---|---|---|---|
| 产出 | 4-5 页决策备忘 | 12-15 页主题分析 | 30-40 页 / 1.5 万字+ 旗舰 |
| 图表 | 0 | 6-10 | 25-35+ |
| 时间预算 | 约 15 分钟 | 约 1 小时 | 约 2-3 小时 |
| LLM | 单 LLM | 单 LLM | Claude + GPT + DeepSeek 可选 |
| 硬停 | 0（仅软停） | 1（draft 后 sign-off） | 3（outline / draft / final） |
| 引用 | 纯 Markdown footnote | footnote | BibTeX + APA |
| 派生 | PDF + Word | PDF + Word | PDF + Word + 公众号 md + HTML |
| onboarding 问题数 | 2 | 3-5 | 4 |

设计要点（docs/2026-05-26-design.md）：V1 明确**不做 flag 分发**（`--light/--heavy`），改为触发时口头选档——理由是自然语言触发天然携带范围线索（页数、时长），AI 推断档位后一句话确认即可。这个「先推断后一句话确认」比弹菜单摩擦小。

### 1.2 按档加载文件（上下文经济性）

SKILL.md 规定每档只加载所需文件（lazy loading）：light 只读 workflow_light + _quarto-light.yml；medium 读 workflow_medium + _quarto-medium.yml + report_style_spec + chart_template；heavy 读全部 + publication HTML 模板。**SKILL.md 本体只留路由（选档菜单 + 三档速览表），细节全部下沉 references/**——技能入口瘦、按需加载，这是 Claude Skills 架构的标准用法，但本仓执行得最彻底（SKILL.zh.md 约 100 行，重内容全在 references 4 个文件共 2000+ 行）。

### 1.3 选档信号与反触发

MODE_REGISTRY 给了「适用 / 不适用」双列表（正反都写，反触发防误用）：
- light 适用：快速决策备忘、内部讨论稿、时效优先；不适用：需要图、需要外部审阅的正式品
- medium 适用：单主题深挖、需要图但不写 BibTeX；不适用：多章旗舰、需要多 LLM 交叉
- heavy 适用：对外旗舰、35 图级、可付 2-3 小时；不适用：赶时间、范围没锁定

SKILL.zh.md Step 0 的选档菜单把「时间预算 + 图数」直接摆给用户看，用户按预算选档而不是按功能选档——**预算驱动的 UX**。

### 1.4 升降档路径

- 升档：light 项目可重新以 medium/heavy 触发，因为三档**共享 hypothesis-lock 第一步**，第一步成果直接迁移（SKILL.zh.md「升档路径」节）
- 降档：明确写「一般不值得」（直接砍交付物即可）
- heavy 模式特殊动作：**把整个 skill 目录拷进项目根**，允许项目内 override 模板与规范（本地优先，不污染全局 skill）

### 1.5 传播协议（这是最值得抄的治理件）

MODE_REGISTRY.zh.md:70-75 规定改档位参数时的 5 步传播顺序：
1. MODE_REGISTRY.md（单一事实源）
2. SKILL.md 选档表
3. CHANGELOG
4. workflow 路由表（workflow.md）
5. README

它把「参数散落在 N 个文件必然漂移」这个痛点显式制度化了。但注意：本仓自己也没执行干净（见第九节漂移证据）——协议正确 ≠ 协议被遵守，这本身就是移植时要吸取的教训。

---

## 二、report_style_spec 结构（成稿端的宪法）

来源：skills/analyst-research/references/report_style_spec.zh.md（800+ 行，medium/heavy 加载，light 跳过）

章节地图：一 版式（字号六级表）/ 二 FT 图表五原则 / 三 图表制作规则（§3.1-§3.13）/ 四 视觉检查（AI 不做）/ 五 Quarto 默认值 / 六 chart_template 接口契约 / 七 publication HTML / 八 AI 使用披露。

### 2.1 版式：六级字号 + 禁 h3

- 「研报正文仅两级：h1 大节 / h2 小节。**禁止 h3 及更深**。三级标题让目录冗长、读者迷路。如果一节有多个子点，让段首结论句承担分层。」（report_style_spec.zh.md:90）
- 字号六级体系（18/16/14/12/11/10pt），每一级写明「用在哪 + 为什么是这个字号」，而不是只给数字——例如正文 12pt 对应 A4 双栏阅读密度、figsource/tblsource 10pt 灰字弱化来源行。spec 的写法范式：**参数必须附带理由**，让后来者改参数前先读懂代价
- keywords 作为**正文首行内联摘要行**而非 YAML 字段（进 PDF 才可见，YAML 字段读者看不到）
- 表格用 Markdown 表而非图片（§3.9，可检索/可复制/体积小）；禁数学符号与 emoji（§3.10，xelatex 编译风险 + 研报正式感）

### 2.2 FT 图表五原则（§二）

FT chart-doctor 五原则被列为 medium/heavy 所有图表的审美底座：标题即结论（chart title states the finding，不是「XX 趋势图」）、少即是多、合理基线、色义一致（同一数据系列全文同色）、来源必注。配合 §三 的工程规则把「审美原则」翻译成「代码约束」——原则→规则→脚本三级落地，这是 spec 最可学的结构。

### 2.3 图表规则的「为什么」密度

每条硬规则都带事故级理由，可移植价值极高：
- §3.12 FIG_W 锁：「所有 make_fig_*.py 必须用 figsize=(FIG_W, h)——FIG_W……值为 6.69 inch（= A4 21cm − 20mm × 2 边距）……锁定后缩放比 = 1.0，**matplotlib rcParams 字号即 PDF 实际字号**」（:443-445）。手写 (10,5) 会让 10pt 字被 Quarto 压成 6-7pt
- §3.7 一图一 plot：禁 `plt.subplots(1,2,...)`，单图吃满 6.69 inch 宽，多图需求拆成多张（:383-390）
- §3.8 legend 三禁：禁盖在 plot 内、禁垂直堆叠、必须水平排开且以**图像中心**（非 plot 中心）对齐；附 ncol 溢出降级实战案例（7 项长名 legend ncol=7 溢出 → ncol=4 两行）（:409-413）
- §3.11 JPG 长边 ≤ 2000px（Anthropic API 多图上限，:433）
- §3.1 一图一脚本：`make_fig_<节号>_<编号>_<topic>.py`，head docstring 写用途/输入/输出

### 2.4 「AI 不做视觉检查」（§四，:506-508）

「**AI 不做视觉检查**。图渲染完后 AI 仅列出 JPG / PDF 路径，用户自己开来看。原因：① AI 视觉模型对中文字体识别不稳定会误判；② 多张图累积会触发 API 多图像素上限；③ 用户审美与论点强调点比 AI 准。」「不设 checklist 与硬停 gate。用户判定有问题再回退到具体脚本修。」

这条与我们「Jev 判断层」思路互补：**机器查可计算项（grep/计数/一致性），人查审美项**，不假装 AI 能看图。

### 2.5 §八 AI 使用披露

medium/heavy 必放 5 行双语披露段（置于 references 章之前），light 可选。给「AI 生产线出对外研报」提供了合规样板——工程行业研报对外交付时同样需要。

---

## 三、三档 workflow 详解（输入输出契约 / 质量门 / 停点）

### 3.1 跨档不变量（references/workflow.zh.md:27-30，router 文件）

1. 「**hypothesis 优先**：每个项目都从一句话 hypothesis lock 起步。hypothesis 从第一天起随项目文件走，**永不从 draft 反推**。」（:27）
2. 来源可追溯（每数每图能回到台账）
3. 三态标注：事实/估算/推断措辞分离（「据 X」/「市场估计约」/「可能」）
4. 「**不造数**：『未公开』『待核实』永远好过一个看似合理的猜测。」（:30）
5. 回复语言随提问语言、报告语言独立确认（默认英文）——**对话语言与交付语言分离**，双语生产线的第一条

router 同时声明：「真相之源是 MODE_REGISTRY.md」——workflow 文件与 SKILL 表若与 registry 冲突，以 registry 为准。**冲突仲裁规则显式化**，而不是靠读者猜。

第四条与 verifying SKILL 红线同源（「宁可输出『无法核实』，不要给似是而非的数字或日期」）——同一纪律在核实端和成稿端各出现一次，双闸。

### 3.2 light：6 步 / 0 硬停（workflow_light.zh.md）

步骤与时间：hypothesis 5min → 搜索 25 → plan 5 → draft 20 → self-check 10 → freeze 5。

每步输入输出契约（task 要求项）：

| 步 | 输入 | 落盘产物 | 停点 |
|---|---|---|---|
| 1 hypothesis | 用户一句话需求 | `01_hypothesis/hypothesis.md`（一句话假设+关键约束段+时间锁） | 软停 |
| 2 搜索 | hypothesis 关键词 | 资料台账 20-30 条 + 5-8 份核心 PDF 全文下载 | 软停 |
| 3 plan | 台账 | 三段式提纲（结论先行） | 软停 |
| 4 draft | 提纲+台账 | draft.qmd + 内联 footnote 引用 | 软停 |
| 5 self-check | draft.pdf | 12 项 grep 表逐项贴数 | 机器门（失败回 4） |
| 6 freeze | 全过的 draft | 定稿 PDF + Word + 冻结说明 | 终态 |

- 「**全部 0 硬停**——AI 各步落盘后简短告知用户阶段产出，立即推进下一步。」（:99）
- 但「0 硬停 ≠ 0 自检门」：self-check 失败必须回 step 4 重写重渲重 grep，「直到全过才进 step 6——0 硬停 ≠ 0 自检门。light 没有用户审 PDF 的硬停 gate，self-check 失败就裸进 step 6 等于把红线甩给用户」（:273）。**无人工门时机器门升格为唯一门**，这是全自动生产线的正确姿态
- 模糊 hypothesis 的 nudge：不硬停追问，AI 自行给出 assumption 写入 hypothesis.md 关键约束段并一句话明示「按以下假设推进……您可叫停修正」（:111）——**assumption 透明化代替硬停**
- BLUF 摘要纪律：单段 80-150 字，结论 + 关键数字 + so-what，附正反例
- 12 项 grep 红线表（破折号/手写编号/emoji/h3+/正文加粗/冒号句号比/抒情词/学术腔/模糊量化词/meta-language/页数/渲染）
- 页数地板处理：<4 页太薄要补；10+ 页提示用户「再精简或升 heavy」

### 3.3 medium：8 步 / 1 硬停（workflow_medium.zh.md）

步骤骨架与契约（含 medium 特有的「继承/砍掉」标注——medium 文件自己写明每步是 heavy 哪步的压缩，:103-114）：

| 步 | 内容 | 停点 | 时间 | 与 heavy 的关系 |
|---|---|---|---|---|
| 1 | 话题+思路 | 软停 | 15 min | 融合 heavy 1+3，砍 heavy 4 话题硬停 |
| 2 | 广搜（4 类以上，15 源左右） | 软停/用户可选硬停 | 45 min | 完整继承 heavy 2 + 附录 A，规模压缩 |
| 3 | plan+outline（即合同） | 软停 | — | heavy 6 的简化版 |
| 4 | 数据+图表 6-10 张（一图一脚本、双双落盘、视觉自检 4 项） | 软停 | 60-90 min | 完整继承 heavy 7 纪律，张数压缩 |
| 5 | draft | 软停 | — | heavy 8 |
| 6 | self-check（计数地板 12-15 页/6-10 图） | 机器门 | — | heavy 9 的子集 |
| 7 | 用户 sign off（通读 v1 PDF 提意见迭代） | **硬停** | 看用户 | heavy 9d |
| 8 | freeze+派生 PDF/Word | — | — | heavy 10 的子集 |

「**step 7 是唯一强制硬停**。step 2 是否硬停由用户在 onboarding Q3 决定。」（:112）砍掉的 heavy 步骤清单也明文列出（:114）：3（AI 单独建议方向）/4（话题硬停）/5（补搜）/9a（润色）/9b-9c 拆分/10c HTML/10d 公众号/11（复盘）——**档位差异=步骤级 diff 而不是重写**，这是三档能共享一个 spec 的前提。

可移植的精华：
- **图表前置**：「先做图再写正文是钻石级实战洞察。曾有项目先写了 outline 和正文『X 国某政策目标 65%』，画图时才发现这个数字根本不对应该指标。如果先做图，画图过程中口径不可比的问题立刻暴露。」（:274；heavy :436 同文附口径细节）——图表是数据口径的试金石，先图后文把口径错误拦在写作前
- **outline 即合同 + 计数地板**：「outline 的章节数 + 图清单是 step 5 draft 与 step 8 定稿要被比对的合同……签字的数字成为 §六 计数门地板——终稿图比合同少即为违约（补回，或告诉用户哪个计划项被砍、为什么）。**静默缩水是典型偷懒失败模式**。」（:258；heavy :422 加「不允许」三字）——**用签字数当地板反 AI 偷懒缩水**，配合 `git tag outline-final` / outline-locked
- 图增删判据表：add-chart 6 行标准（新论点需要视觉证据/口径对比/趋势…），remove-chart 5 行（信息重复/口径存疑且不可修/与论点无关…），删图须走「commit 删除 + outline 同步 + 数字内联进正文」的合规路径
- **title-from-CSV**：图标题禁手写数字，从数据反推：`title=f"私营女性 +{df.loc[...].max():.0%}"` 并加 `assert` 兜底——标题数字与数据永远同源
- **三处一致**：脚本内 title/source/note ↔ CSV ↔ 正文引用数字，三处对不上即修
- time-lock 快照表：明示哪些数是时点快照（汇率/股价/大宗价），draft 时须重拉，>5% 漂移要更新或标注
- `_state.md` vs `CLAUDE.md` 分工：状态（当前位置/交付物索引/悬决项/git 时间线）进 `_state.md`，规则进 `CLAUDE.md`，判据一句话——「这条信息一周后还成立吗？」成立→规则，不成立→状态

### 3.4 heavy：11 步 / 3 硬停（workflow_heavy.zh.md，1200+ 行，本仓最厚资产）

步骤骨架：1 hypothesis lock → 2 广搜+台账 → 3 AI 建议方向 → **4 话题硬停** → 5 补搜 → **6 outline 硬停（即合同）** → 7 数据+图表 → 8 draft → 9a 润色 9b 批判 9c 核实 **9d 终审硬停** → 10 派生链 → 11 复盘。

关键机制逐条：

- **§2.2 定位口诀（研究边界宪法）**：「先穷尽搜索现成研究 → 找到的优先引用 → 描述性测算与可视化大胆做（这是研报的看点）→ 简单计量需要用户认可 → 永远不试图复现已有学术界的精细方法。」（:197）——直接回答「工程行业研报里 AI 该做什么不该做什么」：综合与可视化是主场，原创建模是禁区
- **多 LLM 协作表**：每步标注谁主谁辅（Claude 主写 / GPT 批判 / DeepSeek 中文润色+备源），错误诊断顺序固定「**模型→prompt→通道**」：换模型 → 改 prompt → 查通道，附 DeepSeek V4 Pro Thinking Max 实战案例
- **step 7 标题禁 hardcode + 18/41 图不一致战史**：曾发生正文 18 处图引用与实际 41 张图对不上（44% 错位），此后规定图标题从脚本落盘产物自动带出，正文引用由编号系统生成
- **§5.8 五处一致**：脚本 title/source/note ↔ CSV ↔ draft 正文 ↔ figsource 块 ↔ bib，五处数字一致性核对（medium 三处的超集）
- **9b 批判不盲信**：GPT 批判意见三种去向——接受 / 否决（记录理由）/ 降级为 caveat；批判者说的「问题」本身要独立核实后才能改稿。**多模型互查也要有判断层**，与我方 Jev 接线位思路一致
- **step 10 派生链单向**：10a freeze → 10b Word → 10c HTML → 10d 公众号 JPG，「后续 10b-10d 的所有派生稿只能从这份 frozen qmd 抄内容，**不允许在派生品里反向修订原文**。若 10b-10d 期间发现内容问题须改，回到 step 9d 重新走 sign off 流程，重新冻结主报告。」（:735）——单一母本，派生只读
- **§7.1 文风工程**：7.1.1 七条中文行文规则（源自 DeepSeek 反馈）；7.1.2 框架节（摘要/引言/结论）二遍重写规范；7.1.3 口语→书面语三类映射表
- **§7.4 贴证据纪律（反形式化自检，:1146）**：「宣称自检通过时，**必须贴出最近一次实际 grep / 计数输出的数字；口头『全清』不算**。」这是对我们所有计数门最直接的补强——门不仅要有，还必须**把门的原始输出贴进交付物**防口头过关
- **§7.4 计数门地板（:1168-1169）**：「页数地板：`pdfinfo draft.pdf | grep -i Pages`……**< 25 = 停，回 step 5/6/7，不准宣称完成**」「图数地板：`grep -cE "^!\[" draft.qmd`……且 **≥ 签字的 step 6 合同**；**< 20 = 停**」——grep 表里页数/图数/字数三行是硬地板，其余语言红线行是软修（超标回改再 grep），**完整度用「停」、风格用「改」**，两种失败两种处置，不混为一谈
- **9b 批判批处理与三去向**：B1 结构批（逻辑链/覆盖缺口）/ B2 证据批（引用强度/口径）/ B3 语言批（行文/术语）；每批意见逐条三去向——accept（核实后改稿）/ veto-with-log（否决并记录理由，防止批判者编造的问题污染稿子）/ downgrade-to-caveat（降级为正文限定语）。9c 对 caveat 再分三种提升路径：upgrade（补到正文结论）/ multi-source-equivalent-primary（多源等价一手）/ keep caveat
- **§6.5 错误诊断顺序（多 LLM 失败排查）**：固定「模型→prompt→通道」——先换模型（同 prompt 换 GPT/DS 试）、再改 prompt（简化/拆步）、最后查通道（key/网络/版本）；附 DeepSeek V4 Pro Thinking Max「看似超时实为通道参数」实战案例。**排障顺序制度化**比每次临场判断省一半时间
- **§7.1 文风工程三件**：7.1.1 七条中文行文规则（节奏/句长变化/禁排比堆砌等，注明源自 DeepSeek 反馈迭代）；7.1.2 框架节（摘要/引言/结论）在全文完成后**二遍重写**——首遍写正文时框架节只是占位，全文定调后回头重写才不会空转；7.1.3 口语→书面语三类映射表（口语连接词/口头强调/网络语分别替换为书面等价物）
- **多 LLM 分工表**（每步标注）：广搜=Claude+GPT 并行不同关键词域、draft=Claude solo、批判=GPT、中文润色=DeepSeek、核实=Claude——**不是「多模型一起写」而是每步单主责**，边界清晰才不互相覆盖
- **§11 项目脚手架**：10 个编号目录（01_hypothesis / 02_data / 03_analysis … 10_report），`_process/` 存中间产物不进交付；research.md 台账推荐字段：编号/类型/机构/标题/年份/PDF路径/重要性/关键字段/获取方式；附录 A.1-A.9 完整源类别清单（国际机构/主权政府/监管/学术/智库/投行/咨询/媒体/聚合库）+ 覆盖度自检表模板（每类打勾或注明为何缺）——**台账字段与覆盖表直接可搬进我方 EPC100 台账**
- §11 复盘三段式：踩坑 / 处理 / 是否沉淀（三选一强制：已沉淀为 skill 条文 / 未沉淀+原因 / 下次再观察）——强制三选一堵住「复盘写完就忘」的口子
- **§12 _state.md 模板**：当前位置 / 已完成交付物索引 / 悬而未决项 / git 时间线（每次硬停更新）；§13 开放问题列表——跨 session 续跑的状态锚点

---

## 四、图表与出版工程（chart_template.py + Quarto + HTML）

### 4.1 chart_template.py（v8，541 行）

`save_fig` 接口契约（spec §六 与实现一致）：

| 参数 | 语义 | 关键约束 |
|---|---|---|
| fig_id | 图编号（节号+序号） | 进文件名，重跑不撞名 |
| title / source / note | 标题/来源/注 | 只烧进 JPG 与 _clean.jpg 之外的自包含产物；PDF 裸图不带（Quarto caption 提供） |
| clean | True 产出 _clean.jpg | medium/heavy HTML 派生用（页面自带标题，防双重标题） |
| lang | 'zh'/'en' | 切换 来源:/Source: 前缀 |

三产物的分工逻辑（spec §3.3）：**同一份图数据，三种内容配置**——PDF=裸矢量+Quarto 排版层；JPG=全信息自包含（微信/粘贴场景）；_clean.jpg=裸栅格（HTML 嵌入）。用「raw LaTeX 环境而非 ::: div」实现 figsource 块也是同思路：样式归排版引擎，数据归图脚本。

- FT 调色板 HEX 常量（主 #0F5499 / 次 #208FCE / 三 #C2B7AF / 强调 #7F062E Claret），`setup_style()` 统一 rcParams + CJK 字体可用性警告
- `legend_above(ax, ncol, mode="centered")`：用 `x_axes = (0.5 - pos.x0) / pos.width` 把图例对齐**图像中心**而非 plot 中心（视觉居中修正）
- `_wrap_text_precise`：二分前缀 + `_WORD_CHAR_RE` 词保护（英文单词/数字/百分号不拦腰折行）
- `save_fig(fig, fig_id, title, source, note, subdir, lang, clean)` **三产物**：
  - PDF（bbox_inches='tight'）——裸图，无标题/来源（由 Quarto caption + figure-source 块提供，内容与样式分离）
  - JPG——动态扩画布自包含图（suptitle+source+note 烧进图内），`jpg_dpi = min(200, int(2000/max(w,h)))` 保证 ≤2000px
  - `_clean.jpg`（clean=True 时）——裸栅格图，给 HTML 派生用，避免与页面内标题双重出现
  - legend-above 自动检测（get_window_extent）加 0.30in 顶距；多 axes 警告
- `FIG_W = 6.69` 常量导出，配合 spec §3.12 实现字号所见即所得

### 4.2 Quarto 模板

- `_quarto-light.yml`：无 toc 无编号，15pt flushleft 标题，脚注 10pt——5 页备忘密度优先
- `_quarto-medium.yml`：toc + lof，13/11.5pt 标题，`fig-pos: 'H'` 防浮动，figsource 环境带 `\par\penalty10000` 防跨页断行
- 渲染栈 Quarto + xelatex + ctexart；LaTeX 头 hack（tocloft 钩子、titlesec、titling、\pretocmd/\apptocmd 在 \AtBeginDocument 里）都是踩坑沉淀
- 两个 yml 的共同点：**每档一份 yml 而不是一份带开关**——档位差异（有无 toc/字号/编号）直接体现在模板里，运行时不做条件渲染，降低出错面
- caption/来源行与图本体分离（PDF 裸图 + `{.figure-source}` 块）意味着**同一张图换版式零重绘**——源数据脚本一次，排版层随便换

### 4.3 publication HTML（1 div = 1 页 A4）

- publication-style-template.html：`.page { width:210mm; height:297mm; overflow:hidden; counter-increment:pagenum }`，页脚页码用 CSS counter，@page margin 0，@media print 规则 + print-color-adjust
- 工作流约定：VS Code Live Preview 人工翻页检查 → 浏览器 Cmd+P 存 PDF；**不留 builder 脚本**（成品即静态 HTML）
- topic-brief 的 briefing.html 是另一极：全 inline style + table 布局 + 实体装饰元素（无伪元素/渐变/CSS 变量），**为微信公众号编辑器兼容性设计**——「既适合浏览器查看也适合直接复制粘贴到微信公众号编辑器」
- heavy 10d 公众号派生：从冻结 qmd 抽正文 → 图用 `_clean.jpg`（避免与页面标题重复）→ 表格转图片或简化排版 → 长文按公众号单图上限切片。四格式派生（PDF/Word/HTML/公众号）共用一个冻结母本，代价是每种格式各有一份「格式适配清单」写进 workflow——**派生不是格式转换而是逐格式的适配工程**，这条认知对做企业定制交付（客户要 Word/PPT/公众号三件套）直接可用

---

## 五、topic-brief schema（结构化简报的数据契约）

来源：skills/topic-brief/（SKILL.zh.md / lib/schema.py / lib/renderer.py / lib/fix_quotes.py / prompts/system.md / templates/briefing.html）

- 数据结构 dataclass 链：Briefing{brand/subject/issue_title/period_start/period_end/period_label/summary/focus/sections[4]/disclaimer} → Section{label, items[3-4]} → Item{headline≤30字, body 100-300字, event_date, SourceRef{label,url}}；`from_dict` 兼容旧字段别名（region_name→subject_name 等）
- **event_date 是核心创新**（v0.4.0 由真实反馈驱动，见 FEEDBACK.md 2026-05-13「时间窗口失守」条）：每条 item 必填事件日期且必须落在 [period_start, period_end] 内；焦点正文可引窗口外背景但**必须显式标注时点**。配套纪律：**每次搜索 query 强制注入 `after:/before:` 时间过滤**——「不带时间过滤 → 引擎按相关性返回，半年前的『大事件』因 SEO 权重高会被召回 → 失守」
- 四子板块分轴规则（prompts/system.md + schema.py docstring）：区域→国家/地理、行业→价值链环节、议题→时间线/维度、机构→职能域——**行业简报按价值链分节**可直接用于工程行业研报
- 撰写纪律六条（system.md）：数字不造/来源可追溯（URL 必须来自输入清单）/三态分离（据X·市场估计约·可能）/焦点单一权威/不带情绪（禁「令人震惊」「标志着」「势必」）/时间窗口
- 工程细节三件：renderer 的脚注 URL 去重（首现编号复用）；fix_quotes.py 状态机修中文引号配对（手写 JSON 99% 死于此）；issue_title ≤24 字（超了封面换行——格式约束写明物理原因，模型才会自觉遵守）
- 步骤 3 强制方向确认：列候选条目**每条带事件日期**让用户 spot-check，「跳过本步会导致写完才发现选偏方向，浪费 5000 字撰写工作量」
- 撰写后自检 checklist（SKILL.zh.md 全表照搬级可用）：issue_title ≤24 字 / 4 板块×3-4 条 / summary 恰好 4 条对应 4 板块 / 每个数字能在素材中找到出处 / 每个 source 有完整 URL / **每个 event_date 落在窗口内** / 焦点引窗口外背景已标时点 / headline ≤30 字 / 焦点 3-5 节 1500-2500 字 / 引号配对无直引号 / subject_name 与两个 ISO 日期字段已填
- 渲染端工程：`render.py` 自动先跑 fix_quotes 再渲染；文件名 `{period_end}_{issue_title 前60字符安全化}.html`；失败处理表明确「JSON 解析失败 99% 是中文引号问题」——**把最高频失败模式写进失败处理表并自动兜底**
- 工具调用映射表（跨 LLM 适配）：通用动词（搜索引擎检索/抓取正文/用户提问入口/通读全文/执行命令）↔ 各终端对等工具；缺工具时优雅降级（如无交互提问则合并为一条纯文本等待回复）——技能跨终端分发的标配写法

---

## 六、local-vault / MinerU：PDF→结构化文本管线

来源：skills/local-vault/（SKILL.zh.md / scripts/sync.py 2102 行 / mineru_client.py / config.py）

### 6.1 路由总表（config.py + sync.py route()）

本地优先三级 PDF 策略：
1. pymupdf4llm（数字版 PDF 主路，write_images 带尺寸下限 12% 页面积 + 最小 6000 字节 + md5 去重，图改名 ascii img-N.png 防中文路径断链）
2. **PyMuPDF 纯文本兜底**（v1.7.0）：pymupdf4llm 崩（如字体缺失）时先本地纯文本 `page.get_text()`，不再直接上云——「可检索性 >>> 完整性 >>> 美观」的取舍排序明文化；产物标 `converted_by: pymupdf (plain text)` 识别降级
3. MinerU 云 OCR 仅兜底（扫描版：<200 字/页判定；profile 路由 vlm/pipeline/html）

其他类型：xlsx 值+公式双读、pptx 本地解析+图片 claude -p OCR、html pandoc 本地清洗（剥 style/class/id + 布局 div，保 raw HTML 防表格降级 [TABLE]）、音视频本地 whisper（平台自动选引擎）。

sync 管线整体序列：route() 按扩展名分流 → 各转换器产出 md + frontmatter → 图片落地 `attachments/<stem>/`（ascii 改名+字节下限+md5 去重）→ `claude -p` 增强元数据（fail-soft）→ 孤儿检测 → 不支持类型**结尾统一报告，绝不静默丢弃**。「绝不静默丢弃」与我方「静默缺席不许收官」同构。

### 6.2 MinerU 批量客户端（mineru_client.py）

- 批量协议：POST file-urls/batch 拿上传 URL → ThreadPoolExecutor 并发 OSS PUT（指数退避重试）→ **流式轮询生成器**：先收割已完成的 download futures 并 yield，未完成的继续轮询，超时只 fail 未完成者——下载与轮询交错，不用等整批
- 心跳用状态签名（变化才算活）

### 6.3 检索纪律与元数据增强

frontmatter 检索层字段（SKILL.zh.md schema）：`abstract`（claude -p 抽取）/ `auto_tags` / `synonyms`（同义词，中文检索召回关键）/ `key_data`（关键数字与口径）/ `source`（回原文的双链）——**转换产物天生可检索**是整个 vault 的设计目标，转换不是终点，检索可用才是。

- frontmatter 增强：`claude -p` 子进程抽 abstract/auto_tags/synonyms/key_data，**只采样 head+tail 各 5000 字**（省 token），YAML-only 输出 + 围栏剥离 + fail-soft
- **「永不改文档正文——所有自动化只动 frontmatter」**：工具零内容丢失风险的架构保证
- 检索自监控信号表：>30 个 grep 命中 / 连读 5 文件无答案 → 触发换策略；MOC（内容地图）每会话至多提 1 个、7 天冷却——防自动化侵蚀库
- 孤儿暂存（删源→orphaned/<日期>/，绝不硬删）+ 增量同步（只转无对应 md 的源）

---

## 七、工程组织件（hooks / 双语 / 打包 / 反馈闭环）

- **SessionStart announce hook**（hooks/hooks.json + announce-loaded.sh）：插件加载即注入 additionalContext，列三 skill 触发词；区分 startup/clear 与 compact/resume 两种文案；Bash 3.2 兼容（macOS 原生）
- **双语纪律**：英文 SKILL.md 是唯一权威源（被 LLM 加载），`.zh.md` 是人读镜像；每个 skill 头部写死同步规则「永远先改英文，再在同一次改动里同步到 .zh.md，绝不只改中文」；pack.sh 打包时**排除 .zh.md**（zip 只发英文权威版）
- **frontmatter YAML 兼容教训**（CHANGELOG 1.7.1）：description 单行标量含 `: ` 被严格解析器拒（skills.sh 只识别 4/2），改 `>-` 折叠块标量修复——技能要跨终端分发，frontmatter 必须过严格 YAML
- **pack.sh**：zip 内层级从 `<skill-name>/` 开始，排除 .DS_Store/downloads//output//SKILL.zh.md；发版铁律 `gh release create vX.Y.Z releases/*.zip`（v0.4.0 漏挂 zip 的事故沉淀进 CLAUDE.md）
- **marketplace 自注册**：.claude-plugin/marketplace.json 指向 "./"，装方 `/plugin install genli-ai/market-research-skills` 即用
- **FEEDBACK.md 三段式**：每条反馈=反馈/分析/方案三段，倒序；三条全读了，每条都是真实用户反馈驱动的迭代（时间窗口失守→event_date 四件套；PDF 丢图→write_images；HTML 噪音→pandoc 本地清洗）——**反馈进 CHANGELOG 的闭环**可移植
- **verifying 的「放弃判定」演进**（CHANGELOG 0.2.0）：三层搜索深度规则被删，因为「复盘历史调用记录发现，『层数计数』的脚手架在真实核实工作里从未被模型实际采用」，改为「**线索真正穷尽时才停，不要按任意计数停**」；六项元数据从必填改为「**差异时才暴露**」（diverge 不标 = 隐式口径偷换 = 红线）——**规则由复盘实证驱动删除/简化**，这个元方法本身就值得抄
- **verifying 的可信源三判据**（SKILL.zh.md:76-82）：机构性质（官方/权威专业/独立第三方 vs 博客自媒体）/ 内容性质（一手披露/一手统计/权威研究 vs 二手转述/AI 摘要）/ 可追溯性（署名+日期+原文定位 vs 匿名转述）。并声明「代表清单 vs 穷举清单」：列表只是示例，**同等级同类性质类比适用**——白名单做成「判据+示例」双层而非死列表，渠道扩张时不用改规则。另有「不接受作为最终来源」负面清单（维基/知乎/AI 摘要/仅 SERP 摘要必须点入原文）与我方渠道账本直接对表
- **范围排除闸门模式**（verifying/topic-brief 同款）：政治/军事/宗教/八卦五类命中即只回一行「超出能力范围。(Out of scope.)」，**检查在场景识别之前**，不走部分核实、不提供变通。高风险站点我方有 domain_blocklist，此模式可扩为「主题级闸门」

---

## 八、可移植做法清单（对「给某企业写工程行业研报」）

### 8.1 基线对照：它有什么是我们没有的

| 能力位 | 我方现状（更强） | 本仓补位（我们没有） |
|---|---|---|
| 采集/调度 | 全渠道调度器 17+ 源、完备门、账本 | 无（它只有「6 类来源+台账字段」的静态清单） |
| 弹药/饱和 | 弹药池 1000 万字门、饱和双门+ACH | 无 |
| 产能 | Manus 军团 750 任务/日 | 无（单研究员工作台） |
| 判断 | Jev 判断层（免费位级引擎+双轨影子） | 单点「批判不盲信」三去向（可并入 Jev 后处理） |
| 方法论 | 七步循环+校准/快照/红队 | 无 |
| **成稿版式** | 无系统规范 | **report_style_spec 字号六级/禁 h3/FT 五原则/Quarto 模板** |
| **图表管线** | 无 | **chart_template 三产物+FIG_W 锁+legend 图像居中** |
| **防缩水** | 字数门（准入向） | **outline 合同+计数地板+git tag（交付向）** |
| **一致性** | 金标准 86 | **三/五处数字一致+title-from-CSV+assert** |
| **语言质量** | 无机械门 | **grep 红线表+文风三件+三态措辞** |
| **状态管理** | RUN_LEDGER 等 | **_state.md/CLAUDE.md 判据分离+复盘三段式** |
| **模式分级** | 无显式分档 | **MODE_REGISTRY 三档+升档路径** |

结论：**弹药端我方碾压，成稿端它全空白补位**——两者是上下游关系而非竞争关系。融合的最短路径是把它的「出稿端十二条纪律」接到我方七步方法论的生产步之后。

### 8.2 按优先级排序的移植清单

1. **outline 即合同 + 计数地板 + git tag**（medium :258 / heavy :422,1168）：签字的章节数/图数进 git tag，终稿 `pdfinfo|grep Pages` 与 `grep -cE "^!\["` 机械计数，低于地板=不准宣称完成。落点：EPC100 成稿段加「合同门」，反缩水。
2. **贴证据纪律**（heavy :1146）：所有自检门（含我方完备门/饱和门/Jev 门）输出时必须**贴最近一次实际命令输出数字**，口头「全清」不算。落点：conductor/board 报表列加「证据列」。
3. **title-from-CSV + 三/五处一致**：图标题数字由数据 f-string 生成 + assert；脚本↔CSV↔正文↔图源↔bib 一致性核对。落点：EPC100 图表腿。
4. **图表前置**（先图后文）：口径错误在画图时暴露。落点：七步方法论的「生产」步前插「图表先行」子步。
5. **语言红线 grep 表 + 文风三件**（light 12 项表 / heavy §7.4 全表 / §7.1 七规则 + 口语→书面映射 / 三态措辞分离）：可计算的语言质量门，中文研报直接可用。落点：成稿段 grep 闸。
6. **三产物图表管线 + FIG_W 字号锁**（chart_template.py 整体抄）：PDF 裸图/JPG 自包含/_clean.jpg，FT 调色板，legend 图像居中。工程行业图表同样适用，模板改名即可。
7. **_state.md 与 CLAUDE.md 分离**（判据「这条信息一周后还成立吗？」）+ heavy 的 10 目录脚手架 + research.md 台账字段。落点：EPC100 项目目录规范。
8. **MODE_REGISTRY 单一事实源 + 5 步传播顺序**：我们的生产线迟早要分「快报/月报/深度」三档，参数表先立 registry 再谈分发。
9. **§2.2 研究边界口诀**：工程行业版改写为「先穷尽现成行业研究→优先引用→描述性测算与可视化大胆做→工程计量须用户认可→不复现学术界精细模型」——写进 METHODOLOGY.md 边界节。
10. **派生链单向 + AI 披露段**：PDF→Word→HTML→公众号只从冻结母本抄，反向改动须回终审重冻结；对外成品带 5 行披露。
11. **event_date + after:/before: 强制时间过滤**（topic-brief）：工程研报引用政策/项目动态时同样要时点纪律。
12. **复盘三段式**（踩坑/处理/是否沉淀三选一强制）：接我方 SuperSkillWeekly 蒸馏环。

### 8.3 工程行业研报专用改写要点（本仓通用模式 → 工程语境）

- **§2.2 口诀工程版**：「先穷尽现成行业研究（行业协会/设计院/龙头白皮书）→ 优先引用 → 描述性测算与可视化大胆做（产能利用率/造价对比/投资节奏图是工程研报看点）→ 工程计量（如投资拉动测算）须用户认可 → 永不复现学术级结构仿真/精细模型」
- **四板块分轴**（topic-brief）：工程行业按价值链分——规划咨询/设计/施工/设备材料/运维，或按项目阶段分——立项/招投标/施工/竣工运营；企业定制版再叠加「该企业主营业务相关的 2-3 个板块 + 政策监管板块」
- **time-lock 快照表工程版**：大宗建材价格/钢材价格/汇率/利率为快照数，成稿前重拉；政策文件号/项目核准日期为永久数，引一次即锁定——比金融研报更强调「文件号+发布日期」双引
- **event_date 纪律工程版**：政策动态/中标公告/产能投产消息必须带事件日期与文号，窗口外背景显式标时点——工程行业信息时效衰减快，混入旧政策是典型错误
- **台账字段工程版**：research.md 字段加「文号/发布机关/数据口径（概算 vs 预算 vs 结算）」——工程数据口径陷阱比金融更多

---

## 九、诚实质量评估（不许全说好）

### 真好的

1. **成稿端工程密度全仓独一档**：FIG_W 字号锁、三产物、五处一致、title-from-CSV——每条都带事故理由，是被真实项目（沙特 Vision 2030，35 图 1.5 万字）打过的工作流，不是纸面设计
2. **「贴证据」与「计数地板」**是对 AI 形式化自检最锋利的反制（:1146/:1168）
3. **规则由复盘驱动增删**（verifying 层数规则被实证删除、FEEDBACK 三条全闭环、CHANGELOG 记录「为什么」）——治理成熟度高于绝大多数 skill 仓
4. chart_template.py 代码质量高：词保护折行二分、legend 图像居中、dpi 动态限幅，注释即文档

### 平庸/缺陷的（同样有证据）

1. **文档漂移实锤——自己的传播协议没执行干净**：workflow_light.zh.md:420 与 workflow_medium.zh.md:738 的对比表都写 heavy「硬停 2（step 4 / 9d）」，而 SKILL.zh.md:92、MODE_REGISTRY.zh.md:17、workflow.zh.md:11 均为「3（outline/draft/final）」——light/medium 的边界表落后 registry 一个版本
2. **announce-loaded.sh 严重滞后**：仍写「v0.6.0」（实际 1.7.1）；light 参数停留在旧版「60-80 min」（现 registry 为约 15 分钟）、medium「10-15p / 3-8 charts」（现 12-15p / 6-10 图）、heavy「20-35+ charts」（现 25-35+）；battle-tested 宣传「41 figures」而 SKILL.md/CHANGELOG 写 35——同一个仓四套参数并存
3. **三档时间预算被整体重定义却无 CHANGELOG 记录**：design 文档与 CHANGELOG 0.5.0/1.0.0 记 light=60-80min、medium=3-5h、heavy=days-weeks；现行全部压缩为 15min/1h/2-3h，1.0.0 之后无任何条目记载这次重定义——违反自家 Keep a Changelog 承诺。且「2-3 小时出 30-40 页 1.5 万字 35 图」的预算与 CHANGELOG 自述 heavy 实战跨「days-weeks」明显矛盾，预算数字可信度存疑
4. **平台偏置**：整套渲染栈（Quarto+xelatex+ctexart+Songti SC）与 local-vault（sync.command 双击入口、mlx-whisper、Bash 3.2 兼容声明）都是 macOS-first，Windows/Linux 未验证；JPG≤2000px 上限是 Anthropic 单家约束却写成全局硬规则
5. **零自动化测试**：chart_template/save_fig/fix_quotes/mineru_client 无一测试文件；语言红线表全是「请 AI 自觉 grep」，没有一条被固化成 CI 可跑脚本——纪律全靠 prompt 约束，漂移（见 1-3）因此无人拦截
6. **规模上限**：单研究员视角，无并发/无队列/无断点续跑概念；MinerU 云依赖无配额治理；与我方 7×24 双车道、EPC100 工厂级产能相比是手工作坊（但它本来就是这个定位）
7. **多数「实战案例」不可复核**：65% 口径事故、18/41 图错位、DeepSeek 诊断案例均只有叙述没有 artifact，吸收时按「方向正确、数字存疑」处理

### 总评

定位互补度 9/10（成稿端整段填补我方空白），纪律设计 9/10，执行一致性 6/10（漂移三处实锤），工程健壮性 5/10（无测试、单平台）。**抄它的制度与模板，不抄它的执行松弛**——移植计数门/贴证据纪律时，把门做成 CI 可跑脚本而非 prompt 约定，正好补上它没做到的。

### 9.1 移植时的三个警惕

1. **时间预算数字不可信**：15min/1h/2-3h 是后来压缩的口径且无记录，按 heavy 实战（days-weeks）估工期；我方接线时预算另测
2. **平台假设要剥离**：Songti SC/xelatex/sync.command/mlx-whisper 是 macOS 假设；我方 Windows 栈需替换字体链（如宋体/思源）与渲染验证；JPG 2000px 上限是 Anthropic 单家约束，按我方实际模型放宽
3. **规则搬过来要配执行器**：本仓所有门都是 prompt 约定（无 CI/无测试），漂移因此无人拦；我方移植时每条门配一个可跑脚本（conductor tick 或 gate_ckpt 式），把「贴证据」从自觉变成机制

---

## 附：一句话回答「这个仓有什么是我们没有的」

我们有弹药与判断（采集/调度/饱和/Jev），它有**出稿端的字段级工程**：版式宪法、图表三产物管线、outline 合同+计数地板、贴证据自检、语言红线 grep、状态文件分离、三档模式注册表、复盘沉淀闭环——以及一套「每条规则都带事故理由」的写法范式。

## 附二：移植时优先重读的 5 个源文件（绝对路径）

1. E:\AI-Station\_proposals\skill-fusion-r2\research\vendor\market-research-skills\skills\analyst-research\references\workflow_heavy.zh.md（§2.2 口诀 :197、§5.8 五处一致、§7.4 贴证据与计数门 :1146-1169、§11 脚手架）
2. ...\references\workflow_medium.zh.md（outline 即合同 :258、图表前置 :274、time-lock、_state.md 判据）
3. ...\references\report_style_spec.zh.md（§3 全部硬规则、§四 AI 不做视觉检查 :506、§六 chart_template 契约）
4. ...\scripts\chart_template.py（save_fig 三产物、FIG_W、legend_above 可整文件搬）
5. ...\skills\verifying\SKILL.zh.md（可信源三判据 :76-82、放弃判定、六维差异暴露）
