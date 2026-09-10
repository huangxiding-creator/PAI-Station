# 巨人优点吸收蓝图（ABSORPTION_PLAN）

> 2026-09-10 · 基于 GITHUB_CATALOG.md 103 项目 + book-to-skill 源码解剖
> 原则（项目宪法 C4）：站在巨人肩膀上——≥80% 相似度直接克隆改造，绝不重新发明。
> 每条吸收点标注：来源项目 → 落点模块 → 搬法（直接抄/改造搬/只借思想）。

---

## 总览：吸收分三档

- **P1 立即吸收**（进 B1/B2 首建，全是 MIT/Apache 可直接抄）
- **P2 架构级采纳**（schema/检索/清洗的层设计，影响面大，按阶段排入）
- **P3 后期/观察**（扫描 PDF、TTS 正式产出、图谱、微调、MCP 分发）

---

## P1 立即吸收（进首建管线）

### P1-A 安全闸门（全部管线共用，最先落地）

| # | 来源 | 落点 | 搬法 |
|---|---|---|---|
| A1 | book-to-skill `sanitize.py`（151 行，MIT，零依赖） | `src/paistation/forge/sanitize.py` | **直接抄**：剥离 Trojan Source bidi（CVE-2021-42574）/零宽/Unicode tag 走私/变体选择器——微信读书 HTML 同样是注入面，"人眼看到的=模型读到的" |
| A2 | book-to-skill `scan_generated_skill.py`（359 行） | T1 出厂闸门 | **直接抄**：生成后注入特征扫描（"ignore previous"/伪造 system 前缀/tool_call 定界符）+ 外泄启发式（curl×.env）+ 体量闸门（≤1000 文件/≤2MB 每文件） |
| A3 | book-to-skill 双层复用同码位集合的设计 | 闸门架构 | **照搬设计**：sanitize 与 scan 共用一份码位常量，防两层防御漂移 |

### P1-B T1「书→技能包」管线（B1 主工程）

| # | 来源 | 落点 | 搬法 |
|---|---|---|---|
| B1 | book-to-skin 输出契约（full_text.txt+metadata.json） | book.json 适配器 | **改造搬（战略核心）**：写 `book.json → full_text.txt + metadata.json` 适配器，**字段契约原样保留**（estimated_tokens/chapters_detected/chapters_method/has_toc）——下游规格/预算/预检全部白拿，且我们的章节树比它的 11 语言正则保真度高（Pro Git 式无编号章节它检测不到，我们天然有） |
| B2 | book-to-skill 输出布局 | skills/ 产物结构 | **直接抄**：SKILL.md≤4K **前重后轻**（compaction 从尾截断）+ `chapters/chNN-slug.md` 懒加载 + glossary(≤1.5K)/patterns(≤2K)/cheatsheet(≤1.2K) 三索引 + **Topic Index（agent 导航唯一通道）** + Chapter Index 表 |
| B3 | book-to-skill cheatsheet 定位 | 合成 prompt | **写进 prompt**：决策规则(When X do Y because Z)>决策树>权衡矩阵>阈值默认值>征兆启发；**明令排除**词条式定义（glossary 的活）和散文（章节的活） |
| B4 | book-to-skill Step 7 预算矩阵 | 合成参数 | **参数化**：BOOK_TYPE×DEPTH 四象限 800-3000 token/章；study 深度必须复现 Worked Example（"深靠内容挣不靠数字凑"）；DEPTH/BOOK_TYPE 是 CLI 参数不是运行时提问 |
| B5 | book-to-skill estimate_tokens | 计费预检 | **直接抄**：CJK 字符/1.5 + 增补平面 U+20000-3FFFF 覆盖（专为我们中文书）；成本公式 input≈tokens×1.3 + output≈章×预算+8.5K |
| B6 | book-to-skill REPL 式探测（grep 偏移+sed 切片） | 大书合成 | **照搬约定**：>50K token 的书按章切片访问，成本正比输出而非源（它注释里的账：28 章×75K=2M token 就是我们的成本下界论证） |
| B7 | book-to-skill Update-Fold-in 模式 | 增量并书 | **保留**：微信读书重抓/续抓后，新章从最大编号续排、glossary 字母序合并多章引用——管线必备 |
| B8 | book-to-skill `discovery_tax.py` | ROI 账本 | **改造搬**：T1 的商业叙事实证工具——book.json 全文 vs SKILL.md+单章 的 token 对比，tiktoken 实测口径 |
| B9 | agentskills.io 开放标准 | 产物合规 | **遵守规范**：name=目录名/[a-z0-9-]、description 含 what+when+关键词、渐进披露三段、文件引用一层深 |
| B10 | book-to-skill evals 回放评分 | T1 质检 | **借鉴思路**：answer_correct/opens 路由准确率/usage token 数三指标给 T1 建回归 |

### P1-C T2「书→记忆闭环」管线（B2 主工程）

| # | 来源 | 落点 | 搬法 |
|---|---|---|---|
| C1 | genanki（MIT） | Anki 导出主路 | **直接抄**：纯 Python .apkg 无需装 Anki；**GUID=hash(bookId+chapterIdx+卡序号)** 只哈希身份字段——人改写后重导出=原地更新，复习历史不丢 |
| C2 | Anki Note→NoteType→Card 三层 | 卡数据模型 | **照搬模型**：RIA 4 字段 NoteType（R问题含原文片段/I经验/A行动/出处回链），模板派生 R→I 正面卡 + A 行动卡（reminder 型只展示不判分） |
| C3 | flashcards-obsidian 权责铁律 | 互通设计 | **照搬**：AI-Station 拥有内容/卡型/牌组，Anki 只拥有调度历史；单向推送永不反向写内容；`^q-xxxx` 锚点回链 |
| C4 | AnkiGPT 人审模式 | 改写关卡 UI | **借鉴**：逐卡编辑/删除才准入队（340 万卡产品的共识：AI 会错，卡必须人审）；长文按章分段并行出题 |
| C5 | obsidian-quiz-generator | 质量闸 | **借鉴**：题型×数量用户受控（"这章 3 简答+5 填空"）；**先自答再保存**——能被答对的卡才是完整卡 |
| C6 | llm-flashcards | 制卡标准 | **借鉴**：一卡一概念 + 卡组带 prerequisite 学习路径（入队按路径排序非乱序） |
| C7 | Lute v3 | 卡形态 | **照搬**：卡正面必带书中原句（语境），防脱离语境死卡 |
| C8 | foliole 增量阅读 | 制卡时机 | **借鉴**：摘录发生在阅读会话中，人改写发生在记忆还热的当天，而非复习前夜 |
| C9 | py-fsrs 未用满的能力 | fsrs_queue 升级 | **直接用**：desired_retention 分档（概念卡 0.9/行动卡 0.8）+ fuzz 防扎堆 + ReviewLog 落库（未来接 fsrs-rs Optimizer 按个人历史重训遗忘曲线——免费午餐） |
| C10 | anki-mcp-server（MIT，50 工具） | 会话内复习 | **后期接入**：Claude 会话直接 get_due_cards→present→rate，每日 3 卡在对话里复习 |

---

## P2 架构级采纳（按阶段排入）

### P2-A book.json schema 升级（docling/pandoc 思想，零依赖成本）

| # | 来源 | 改造 |
|---|---|---|
| A1 | docling DoclingDocument | 元素级 provenance（来源文件/章/段落序号，出错可回溯重解析）；表格保留结构化形态不拍平 |
| A2 | pandoc Reader/Writer+AST | book.json 定位为唯一 AST 位：新来源只写 reader→book.json，weread 专属字段收进 `source_meta` 扩展位不泄漏进核心层 |
| A3 | marker 页级三分类 | 每章记录"提取方式"字段；页间重复短文本聚类剔广告（可直接移植到微信读书 html 清洗） |
| A4 | turndown 规则表 | weread_html 清洗从 if-else 链改造为规则对象列表（每规则可单测/按源启停） |
| A5 | epubcheck | 外部 EPUB 来料先过校验清单（spine 完整性/图片引用断链）再进管线 |

### P2-B 书库问答层（B 阶段后建）

| # | 来源 | 改造 |
|---|---|---|
| B1 | txtai（Apache-2.0） | MVP 底座：单进程嵌入库吃 SQL+向量+关键词三路（内置 RRF），不动零服务器架构 |
| B2 | onyx 配方（借思想不抄码，AGPL） | 中文书混合检索：BM25 路**jieba 预分词**（否则中文关键词路失效）+ GLM embedding 向量路 + RRF 融合（异构分数免调权） |
| B3 | R2R citations + privateGPT quote | 引用三件套：prompt 强制论断句尾 [n] → API 返回 citations[{bookId,chapterIdx,章名,段落号,原文切片,分数}] → **生成后与 book.json text 精确子串校验，不过标黄降级**（防记忆背诵式幻觉） |
| B4 | BookRAG（借思想） | 层级索引：章节树(已有)+GLM 抽实体图(语义缓存省钱)+query 分类路由（局部查找 vs 全局推理；本章/跨章/全书库三档） |
| B5 | Verba（借思想） | 父子合并：小块召回、命中向上合并到节/章喂模型——书的天然层级 |
| B6 | echo-reading | 原文只读层=引用锚定基础：一切引用解析回 bookId+chapterIdx+段落序号三元组 |
| B7 | h2oGPT/BookRAG 评测 | 固定中文 QA 集+LLM 判分进语义缓存——书库问答回归测试 |

### P2-C T5 对谈播客（三件套一周可通）

| # | 来源 | 改造 |
|---|---|---|
| C1 | personalized-podcast PROMPT.md | 中文化脚本模板：JSON `[{speaker,text}]`、A=好奇者/B=分析者、三段结构（30s/8min/30s）、口语化硬规则（每轮 1-4 句、强制反应词"等一下""这个有意思了"、**书面语改写成说人话**、数字读法） |
| C2 | notebookllama（MIT） | Pydantic 硬约束：ConversationTurn(speaker Literal)+交替 validator+3-50 轮+字数预算（10min≈2200 中文字），不合格验证层打回重生成 |
| C3 | ChatTTS 标记思想（不集成 AGPL 码） | 脚本层内嵌 `[break_2]` 停顿标记，渲染层翻译成各引擎参数——标记在脚本、引擎无关 |
| C4 | edge-tts 起步 | 免费试听/草稿批量（生态默认） |

### P2-D T4 课程（classbuild 黄金模板裁剪）

| # | 来源 | 改造 |
|---|---|---|
| D1 | classbuild（MIT） | 五阶段裁四件产物（阅读章/课件/有声书/测验）；**五条循证原则织入生成 prompt**：检索练习（先测后讲）/交错（概念混排）/双重编码（文字+可视化）/具体案例/精细加工（跨章回调） |
| D2 | classbuild 置信度校准 | T6 测验设计：自评"多确信"+错配高确信=重点复习信号（比裸难度分级科学） |
| D3 | PPTAgent | 课件层走"生成 python-pptx 代码+沙箱执行+报错回灌"——产物可校验可回归可 diff |
| D4 | MoneyPrinterTurbo | 素材策略：同一 LLM 写讲稿+提炼检索关键词，素材靠免费库匹配不生成 |

### P2-E 双链笔记与发布

| # | 来源 | 改造 |
|---|---|---|
| E1 | obsidian-readwise（借思想） | 文献笔记落盘 schema：一书一 md 三层（frontmatter 书卡/章节分组摘录/用户区隔离），重同步只重渲染摘录层 |
| E2 | claude-obsidian（MIT） | 自动建链：每章→LLM 抽 3-7 张原子概念卡，规则强制 ≥2 个既有卡链接+1 个回链文献笔记 |
| E3 | siyuan 块 ID 思想（借思想） | 锚点不复制：锚=hash(bookId+chapterIdx+range)，书重导入不碎链 |
| E4 | quartz+digital-garden（均 MIT） | 发布零成本：frontmatter publish 标志定可见性→git push md 子集→quartz 预建 backlink/搜索/图视图→GitHub/CF Pages 免费托管 |
| E5 | emanote 断链思想 | 选题队列：统计"被链接最多但未创建"的笔记→"最想写的 10 篇"推送——写作复利飞轮入口 |
| E6 | Zettlr citekey 思想 | book.json 生成稳定 citekey（zengming2020），永久笔记带 source citekey，写作自动汇出参考文献表 |

---

## P3 后期/观察

| 项 | 来源 | 时机 |
|---|---|---|
| 扫描 PDF 来料 | MinerU 两阶段+marker 分层+RapidOCR 轻量+pdfplumber 字号启发 | 接纸质书/扫描件需求出现时 |
| TTS 正式产出 | CosyVoice 3.0（Apache，中文天花板+instruct 控情感）/GPT-SoVITS（MIT，固定主播音色克隆） | T5 脚本管线跑通后 |
| 书库图谱化 | LightRAG（1/25 成本双层图）+rahulnyk 概念图 | 书库≥30 本 |
| 领域大脑微调 | easy-dataset 生成-评测闭环 | 领域考卷(T6)验证价值后 |
| MCP 双分发 | weread-omni 40 原子操作 API 面+notebooklm-mcp 形态 | 技能包/书库稳定后暴露为 MCP server |
| 阅读器壳 | readest/koodo（划线多目的地同步矩阵） | 有"读"侧需求时 |
| 章节记忆状态 | roaming-mode 思想：章节也有 S/D 值，没读完的章自动浮上来 | fsrs_queue 升级时 |

---

## 防走偏红线（License）

1. **直接抄代码仅限 MIT/Apache/BSD**（book-to-skill 全家、genanki、py-fsrs、txtai、classbuild、notebookllama、quartz、claude-obsidian 等）
2. **AGPL 项目只借思想**：onyx/BookRAG/khoj/siyuan/logseq/ChatTTS/PyMuPDF/ebooklib——代码并入会传染
3. **GPL 项目思想+子进程隔离**：pandoc 可二进制调用转格式（进程边界）
4. **自定义许可先读 LICENSE**：MinerU/quivr/PageLM/emanote/edge-tts（仓库含 GPL 文件）
5. book-to-skill 解剖确认 **MIT 可整体抄**（含 762 行规格）——已克隆在 `research/book-value/src/book-to-skill/`

## 首建顺序建议（与 B1/B2 对齐）

1. **安全闸门 P1-A**（半天）：sanitize+scan 落 forge/，全管线共用
2. **B1 管线**（2-3 天）：适配器(P1-B1)→合成 prompt(P1-B2/B3/B4)→产物入 skills/→闸门验收→discovery_tax 出 ROI 数
3. **B2 管线**（2-3 天，可与 B1 并行设计）：RIA 出题(C5/C6/C7)→人改写关卡(C4)→fsrs 分档入队(C9)→genanki 导出(C1/C2/C3)
4. 金标准验收：《智能商业》全链跑通（技能包+卡片+10 分钟对谈脚本）；EPC 三本做 B3 试验田
