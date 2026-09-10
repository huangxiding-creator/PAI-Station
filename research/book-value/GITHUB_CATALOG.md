# 书籍深加工开源项目总目录（GITHUB_CATALOG）

> 2026-09-10 · 六路并行调研实测（`gh api` 逐仓核验 star/push/license，无编造）
> 总计 **103 个在册项目** + 2 个死链存档。按管线分层组织，与 ABSORPTION_PLAN.md 配套使用。

## 目录结构

| 层 | 项目数 | 对应我们的环节 |
|---|---|---|
| L0 解析清洗层 | 15 | book.json 原料层强化（PDF/EPUB/OCR 来料） |
| L1 检索问答层 | 12 | 书库问答（单书精读+跨书检索） |
| L2 记忆闪卡层 | 18 | T2 书→复习卡→FSRS |
| L3 多形态生成层 | 14 | T4 课程 / T5 播客 / T6 评测集 |
| L4 笔记复利层 | 14 | 书→笔记→双链→发布→写作 |
| L5 Skill/记忆/图谱层 | 21 | T1 书→技能包 + 领域大脑 |
| L6 RAG 平台/阅读器（原始29） | 9 | 平台级参照 |

---

## L0 解析清洗层（15）

| 项目 | ★ | 活跃 | License | 定位 | 关键机制 |
|---|---|---|---|---|---|
| [PaddleOCR](https://github.com/PaddlePaddle/PaddleOCR) | 89,242 | 2026-07 | Apache-2.0 | 中文 OCR 标准 | PP-Structure 版面恢复：OCR 裸文本按区域重组回段落结构 |
| [MinerU](https://github.com/opendatalab/MinerU) | 79,605 | 2026-09 | ⚠️自定义 | PDF→MD/JSON | 两阶段 VLM：降采样全局布局→全分辨率精识，避级联误差 |
| [docling](https://github.com/docling-project/docling) | 66,231 | 2026-09 | MIT | IBM 文档转换 | **DoclingDocument 统一中间表示**：元素级 provenance+表格保结构 |
| [pandoc](https://github.com/jgm/pandoc) | 46,213 | 2026-09 | GPL-2.0 | 万能格式转换 | **Reader/Writer+AST**：N×M 组合降为 N+M |
| [marker](https://github.com/datalab-to/marker) | 39,628 | 2026-09 | Apache-2.0 | PDF→MD | **嵌入文本优先、OCR 兜底**分层链；页间重复短文本聚类剔页眉脚 |
| [olmocr](https://github.com/allenai/olmocr) | 19,458 | 2026-03 | Apache-2.0 | LLM 式 OCR | 渲染成图+文档锚定 prompt 重排；配套 olmOCR-Bench 基准 |
| [unstructured](https://github.com/Unstructured-IO/unstructured) | 15,412 | 2026-09 | Apache-2.0 | 统一预处理 | partition→clean→chunk 三段 brick 可组合流水线 |
| [jina reader](https://github.com/jina-ai/reader) | 11,971 | 2026-05 | Apache-2.0 | URL→LLM md | 客户端渲染→服务端解析→触发器抓取逐级降级链 |
| [turndown](https://github.com/mixmark-io/turndown) | 11,429 | 2026-09 | MIT | HTML→MD | **规则表架构**：每标签一条可插拔规则，未知节点 fallback 递归 |
| [pdfplumber](https://github.com/jsvine/pdfplumber) | 10,730 | 2026-08 | MIT | PDF 字符几何 | 字符级 bbox/字体聚类重建行与表格；字号推断标题层级 |
| [PyMuPDF](https://github.com/pymupdf/PyMuPDF) | 10,675 | 2026-09 | ⚠️AGPL | PDF 基础库 | get_text("dict") 带 span/block 结构页面树；注意传染 |
| [RapidOCR](https://github.com/RapidAI/RapidOCR) | 7,763 | 2026-09 | Apache-2.0 | 轻量 OCR | PaddleOCR 模型转 ONNX，剥离重框架 CPU 可跑 |
| [epubcheck](https://github.com/w3c/epubcheck) | 1,955 | 2026-09 | BSD-3 | EPUB 官方校验 | spine/资源引用/元数据逐条规则校验——来料质检关 |
| [ebooklib](https://github.com/aerkalov/ebooklib) | 1,808 | 2026-07 | ⚠️AGPL | EPUB 读写 | manifest+spine+toc 三表分离，与 book.json 章节树同构 |
| [epublifier](https://github.com/maoserr/epublifier) | 841 | 2026-09 | GPL-3.0 | 网页→EPUB | 用户可编辑 CSS 选择器分章规则，按站点保存复用 |

## L1 检索问答层（12）

| 项目 | ★ | 活跃 | License | 定位 | 关键机制 |
|---|---|---|---|---|---|
| [private-gpt](https://github.com/zylon-ai/private-gpt) | 57,501 | 2026-09 | Apache-2.0 | 私有 AI API 层 | OpenAI 兼容可直插 GLM；答案强制内嵌逐字 quote |
| [quivr](https://github.com/The-Vibe-Company/quivr) | 39,501 | 2026-08 | ⚠️自定义 | Opinionated RAG | parser/retriever/llm 三件全可插拔的薄封装边界 |
| [khoj](https://github.com/khoj-ai/khoj) | 37,236 | 2026-08 | ⚠️AGPL | AI 第二大脑 | 语义搜索+多 agent+定时研究自动化 |
| [onyx](https://github.com/onyx-dot-app/onyx) | 32,008 | 2026-09 | ⚠️NOASSERTION | 企业 AI 平台 | **Vespa 混合索引+RRF 融合**（代码级核验）——工程标准答案 |
| [localGPT](https://github.com/PromtEngineer/localGPT) | 22,200 | 2026-08 | MIT | 本地文档问答 | 最简五段流水线，MVP 对照参考 |
| [txtai](https://github.com/neuml/txtai) | 12,942 | 2026-09 | Apache-2.0 | AI 数据框架 | **单进程嵌入库吃 SQL+向量+关键词三路（内置 RRF）**+引用标记 |
| [h2ogpt](https://github.com/h2oai/h2ogpt) | 11,969 | 已归档 | Apache-2.0 | 本地私有问答 | 遗产：多模型检索问答横评框架 |
| [R2R](https://github.com/SciPhi-AI/R2R) | 7,994 | 2025-11 | MIT | agentic RAG API | retrieval.rag() 自带 **citations 对象**（chunk+metadata 逐条返回） |
| [Verba](https://github.com/weaviate/Verba) | 7,707 | 已归档 | BSD-3 | Golden RAGtriever | **AutoMergeRetriever：小块召回、父段落合并喂模型** |
| [echo-reading](https://github.com/plustar35/echo-reading) | 142 | 2026-06 | 无 | 中文精读笔记本 | raw.md 原文只读层=引用锚定；insight 跨书沉淀层 |
| [BookRAG](https://github.com/sam234990/BookRAG) | 129 | 2026-07 | ⚠️AGPL | VLDB2026 书籍 RAG | **层级索引：文档树+实体图+倒排映射**；query 分类路由检索算子 |
| [weft](https://github.com/dpunj/weft) | 40 | 2026-05 | MIT | 终端读书+对话 | 极简阅读器内嵌问答交互形态 |

## L2 记忆闪卡层（14 主 + 4 备）

| 项目 | ★ | 活跃 | License | 定位 | 关键机制 |
|---|---|---|---|---|---|
| [anki](https://github.com/ankitects/anki) | 30,448 | 2026-09 | ⚠️AGPL例外 | 间隔重复标准 | **Note→NoteType→Card 三层解耦**：内容一份，卡由模板派生 |
| [genanki](https://github.com/kerrickstaley/genanki) | 2,692 | 低维护 | MIT | Python 产 .apkg | **GUID=身份字段哈希**：再导入即覆盖，复习历史不丢 |
| [Obsidian_to_Anki](https://github.com/ObsidianToAnki/Obsidian_to_Anki) | 2,043 | 停更 | GPL-3 | MD→Anki | 用户可注册「笔记语法→正则」映射的自定义解析器 |
| [anki-connect](https://github.com/FooSoft/anki-connect) | 2,080 | 已归档 | NOASS | Anki 本地 HTTP API | 事实标准运行时通道（addNotes/findNotes/cardInfo） |
| [PageLM](https://github.com/CaviraOSS/PageLM) | 1,962 | 2026-08 | ⚠️社区许可 | 社区 NotebookLM | 同一素材→测验/闪卡/笔记/播客多形态编排层 |
| [lute-v3](https://github.com/LuteOrg/lute-v3) | 1,553 | 2026-09 | MIT | 句挖掘语言学习 | **卡正面=书中原句**（带语境），非孤立词条 |
| [flashcards-obsidian](https://github.com/reuseman/flashcards-obsidian) | 1,086 | 2026-09 | MIT | Obsidian写卡Anki复习 | **权责铁律：内容归笔记、调度归 Anki**；`^q-xxx` 锚点回链；reminder 卡型 |
| [ts-fsrs](https://github.com/open-spaced-repetition/ts-fsrs) | 780 | 2026-09 | MIT | FSRS TS 版 | 同算法多语言绑定（另有 fsrs-rs 417★ 含 Optimizer） |
| [py-fsrs](https://github.com/open-spaced-repetition/py-fsrs) | 482 | 2026-08 | MIT | FSRS Python 版 | desired_retention 定向+fuzz 防扎堆+ReviewLog 全日志 |
| [anki-mcp-server](https://github.com/ankimcp/anki-mcp-server) | 474 | 2026-09 | MIT | Anki MCP | **50 工具**：复习流+制卡流+改期（记日志/不记日志语义区分） |
| [incremental-reading](https://github.com/jdlorimer/incremental-reading) | 228 | 2022停更 | — | Anki IR 鼻祖 | 增量阅读附加包范式 |
| [AnkiGPT](https://github.com/nilsreichardt/AnkiGPT) | 183 | 2026-04 | ⚠️AGPL | 讲义→闪卡（340万卡） | **逐卡编辑/删除人审 UI**；长文分段并行；助记字段 |
| [obsidian-quiz-generator](https://github.com/ECuiDev/obsidian-quiz-generator) | 175 | 2024-11 | MIT | 笔记→AI 出题 | **7 题型×数量受控**；先自答再保存（测试即质量关） |
| [foliole](https://github.com/campfirium/foliole) | 121 | 2026-09 | Apache-2.0 | 原生增量阅读 | **阅读队列中摘录→就地 cloze**；SQLite 主+MD 镜像 |
| [roaming-mode-ir](https://github.com/ebAobS/roaming-mode-incremental-reading) | 51 | 2026-06 | MIT | 思源稍后读插件 | FSRS 调度用于**文章推荐**——章节也有记忆状态 |
| 备选 | — | — | — | llm-flashcards 132★（一卡一概念+学习路径标杆）/ yanki 59★ / incremental-reading-obsidian 16★（活跃） | |

## L3 多形态生成层（14）

| 项目 | ★ | 活跃 | License | 定位 | 关键机制 |
|---|---|---|---|---|---|
| [MoneyPrinterTurbo](https://github.com/harry0703/MoneyPrinterTurbo) | 122,077 | 当天 | MIT | 主题→短视频 | **同一 LLM 写文案+提炼素材检索关键词**；素材全靠免费库匹配 |
| [GPT-SoVITS](https://github.com/RVC-Boss/GPT-SoVITS) | 61,676 | 2026-08 | MIT | 少样本声音克隆 | UVR5 人声分离→ASR 标注→训练→推理全链 WebUI |
| [ChatTTS](https://github.com/2noise/ChatTTS) | 39,829 | 2026-04 | ⚠️AGPL | 对话 TTS | 细粒度韵律 token：`[laugh][break_6][uv_break]` |
| [CosyVoice](https://github.com/QwenAudio/CosyVoice) | 23,543 | 2026-05 | Apache-2.0 | 阿里语音大模型 | **中文天花板**：18 方言+instruct 控情感+零样本克隆+150ms 流式 |
| [edge-tts](https://github.com/rany2/edge-tts) | 11,906 | 2026-03 | ⚠️Other | 免费 Edge TTS | 免 key 多音色；rate/volume/pitch+SSML——生态默认起步件 |
| [ShortGPT](https://github.com/RayVentura/ShortGPT) | 7,929 | 2025-02 | MIT | 短视频自动化 | 资产(脚本/素材/配音)→时间线→渲染的编辑引擎抽象 |
| [PPTAgent](https://github.com/icip-cas/PPTAgent) | 5,014 | 2026-09 | MIT | 反思式 PPT（ACL2026） | 学模板布局→LLM 写 python-pptx **代码**→执行→报错回灌修复 |
| [notebookllama](https://github.com/run-llama/notebookllama) | 1,970 | 2026-03 | MIT | 官方播客复刻 | **Pydantic 硬约束对话**：speaker 严格交替 validator+3-50 轮 |
| [NotebookLM2PPT](https://github.com/elliottzheng/NotebookLM2PPT) | 495 | 2026-02 | MIT | PDF 幻灯→PPT | UI 自动化+MinerU JSON 后处理的工程兜底链 |
| [personalized-podcast](https://github.com/zarazhangrui/personalized-podcast) | 423 | 2026-04 | 无 | Claude skill 播客 | **完整脚本模板**：JSON speaker 轮次+三段结构+口语化硬规则 |
| [easegen](https://github.com/taoofagi/easegen-front) | 260 | 2025-12 | MIT | 中文数字人课程 | PPT→逐页讲稿→数字人+SSML 细控→成片全中文链 |
| [classbuild](https://github.com/jtangen/classbuild) | 140 | 2026-06 | MIT | 循证整课生成器 | **五阶段+每章七产物+五条学习科学原则+置信度校准测验** |
| [kokoro](https://github.com/hexgrad/kokoro) | 8,763 | 2025-08 | Apache-2.0 | 82M 小模型 TTS | CPU 实时；中文音色少，兜底备选 |
| [PageLM](https://github.com/CaviraOSS/PageLM) | 1,962 | 2026-08 | ⚠️社区 | （同 L2） | 多形态编排参照 |

## L4 笔记复利层（14）

| 项目 | ★ | 活跃 | License | 定位 | 关键机制 |
|---|---|---|---|---|---|
| [siyuan](https://github.com/siyuan-note/siyuan) | 46,246 | 当天 | ⚠️AGPL | 块级双链笔记 | **每块稳定块 ID**+SQLite 查询+HTTP API-first |
| [logseq](https://github.com/logseq/logseq) | 44,854 | 2026-09 | ⚠️AGPL | 大纲本地笔记 | 文件即数据库；Datalog 查询图 |
| [claude-obsidian](https://github.com/AgriciDaniel/claude-obsidian) | 14,785 | 2026-08 | MIT | Claude 自组织二脑 | **来源→AI 读→原子笔记+自动 [[链接]]+归档**，产物纯 md |
| [Zettlr](https://github.com/Zettlr/Zettlr) | 13,484 | 2026-09 | GPL-3 | 学术写作编辑器 | Zotero citekey+citeproc 引用闭环+pandoc 导出 |
| [quartz](https://github.com/jackyzha0/quartz) | 13,201 | 2026-09 | MIT | 数字花园 SSG | **backlink/搜索/图视图全预建**；GitHub/CF Pages 零成本 |
| [obsidian-dataview](https://github.com/blacksmithgu/obsidian-dataview) | 9,330 | 2025-11 | MIT | 笔记 SQL 查询 | 行内字段 `key:: value` 轻量 schema+读书仪表盘 |
| [zotero-gpt](https://github.com/MuiseDestiny/zotero-gpt) | 7,389 | 2026-05 | ⚠️AGPL | Zotero 内嵌 AI | 元数据+选区+批注三段式注入；**标签即命令** |
| [obsidian-annotator](https://github.com/elias-sundqvist/obsidian-annotator) | 1,773 | 2024停更 | ⚠️AGPL | PDF/EPUB 标注 | 标注即笔记块；**EPUB CFI 定位**锚点思想 |
| [obsidian-digital-garden](https://github.com/oleeskild/obsidian-digital-garden) | 2,495 | 2026-09 | MIT | 勾选即发布 | **可见性由 frontmatter 决定**（dg-publish），不分叉文件 |
| [breadcrumbs](https://github.com/michaelpporter/breadcrumbs) | 820 | 2026-09 | MIT | 类型化层级链接 | 自定义关系边（up/down/next）存 frontmatter |
| [obsidian-book-search](https://github.com/anpigon/obsidian-book-search-plugin) | 713 | 2024-10 | MIT | 建书卡笔记 | frontmatter 模板变量规范 |
| [readwise-mcp](https://github.com/readwiseio/readwise-mcp) | 152 | 2026-03 | MIT | Readwise MCP | 阅读数据→MCP 官方最小范本 |
| [obsidian-readwise](https://github.com/readwiseio/obsidian-readwise) | 356 | 2026-05 | GPL-3 | 官方同步插件 | **一书一 md 三层结构**（书卡/摘录/用户区隔离）；last_seen 幂等 upsert |
| [emanote](https://github.com/srid/emanote) | 959 | 2026-07 | ⚠️非标准 | Pandoc 笔记 SSG | **缺失链接红色高亮=写作选题队列** |

## L5 Skill/记忆/图谱层（21）

| 项目 | ★ | 活跃 | License | 定位 | 关键机制 |
|---|---|---|---|---|---|
| [anthropics/skills](https://github.com/anthropics/skills) | 175,495 | 活跃 | 官方 | Agent Skills 官方仓 | 20 官方技能布局：SKILL.md+scripts/+references/+assets/ |
| [mem0](https://github.com/mem0ai/mem0) | 65,037 | 2026-09 | Apache-2.0 | 记忆层 | 抽取事实→打分→固化；知识点级记忆管理 |
| [book-to-skill](https://github.com/virgiliojr94/book-to-skill) | 29,553 | 2026-09 | **MIT** | 书→可安装 skill | **确定性提取器+762行规格**；sanitize 安全层；24-51× token 实测；**已克隆到 src/book-to-skill/** |
| [agentskills](https://github.com/agentskills/agentskills) | 25,191 | 活跃 | Apache+CC | 开放标准 | Claude Code/Copilot/Amp/Codex 共用 skill 规范（agentskills.io） |
| [notebooklm-py](https://github.com/teng-lin/notebooklm-py) | 19,239 | 2026-09 | — | 逆向 NotebookLM | Python/CLI/agent skill 三形态封装真 NotebookLM |
| [open-notebook](https://github.com/lfnovo/open-notebook) | 38,518 | 2026-09 | — | 私有 NotebookLM | **source→transform→artifact 三段式领域模型**；1-4 声部播客 |
| [LightRAG](https://github.com/HKUDS/LightRAG) | 39,534 | 2026-09 | MIT | 双层知识图谱 | 实体级+主题级双模式；**索引成本 GraphRAG 1/25** |
| [graphrag](https://github.com/microsoft/graphrag) | 35,924 | 2026-09 | MIT | 层次社区摘要图 | Leiden 社区检测+逐层摘要——"把厚书读薄"的算法化 |
| [cognee](https://github.com/topoteretes/cognee) | 30,612 | 2026-09 | — | agent 持久记忆 | 文档→图+向量混合记忆层，ECL 管线 |
| [Second-Me](https://github.com/mindverse/Second-Me) | 15,680 | 停更1年 | — | AI 分身 | 笔记+领域数据训练本地"领域自我" |
| [easy-dataset](https://github.com/ConardLi/easy-dataset) | 14,899 | 2026-05 | — | 微调数据工厂 | **书→QA对+评测集+Judge评分**生成-评测闭环 |
| [markmap](https://github.com/markmap/markmap) | 13,106 | 2026-06 | MIT | MD→思维导图 | "书→导图"输出端标准件 |
| [fsrs4anki](https://github.com/open-spaced-repetition/fsrs4anki) | 4,061 | 2026-08 | — | FSRS 调度算法 | FSRS-6，新用户默认 |
| [rahulnyk/knowledge_graph](https://github.com/rahulnyk/knowledge_graph) | 4,050 | 2026-08 | — | 概念图生成 | chunk→概念对→边聚合去重→剪枝最小实现 |
| [notebooklm-mcp](https://github.com/PleasePrompto/notebooklm-mcp) | 3,413 | 2026-09 | — | NotebookLM MCP | 知识库做成 MCP server 被 agent 查询 |
| [podcastfy](https://github.com/souzatharsis/podcastfy) | 6,538 | 2026-05 | — | 开源播客管线 | 文本→对话脚本→TTS；脚本中间产物可审校 |
| [qiaomu-anything-to-notebooklm](https://github.com/joeseesun/qiaomu-anything-to-notebooklm) | 5,982 | 2026-04 | — | 15+源→NotebookLM | 中文生态内容获取+上传+取回全自动 skill 编排 |
| [SurfSense](https://github.com/MODSetter/SurfSense) | 16,116 | 当天 | — | API/MCP NotebookLM | 实时网络源+MCP 暴露 |
| [tutor-skills](https://github.com/bevibing/tutor-skills) | 1,134 | 2026-02 | — | Obsidian 学习库 | 源文件→学习笔记+复习卡片 skill 化 |
| [ebook-to-mindmap](https://github.com/SSShooter/ebook-to-mindmap) | 1,313 | 2026-09 | — | EPUB/PDF→导图 | **逐章缓存+断点续跑+BYOK** 生产工程学 |
| [weread-omni](https://github.com/teng-lin/weread-omni) | 384 | 2026-09 | — | 微信读书 skill | **40 原子操作→skill/SDK/CLI 三形态** API 面设计 |

## L6 RAG 平台/阅读器（原始 29 中未归类者，9）

| 项目 | ★ | 定位 |
|---|---|---|
| [ragflow](https://github.com/infiniflow/ragflow) | 90,422 | DeepDoc 版面识别+表格结构化+ELIC 混合检索 |
| [anything-llm](https://github.com/Mintplex-Labs/anything-llm) | 65,863 | 本地多工作区聊天智能 |
| [koodo-reader](https://github.com/koodo-reader/koodo-reader) | 28,136 | AI 翻译/词典阅读器，划线多目的地同步 |
| [kotaemon](https://github.com/Cinnamon/kotaemon) | 25,746 | 混合全文+向量双检索，GraphRAG 模式 |
| [readest](https://github.com/readest/readest) | 24,223 | Rust 内核 AI 增强阅读器 |
| [QAnything](https://github.com/netease-youdao/QAnything) | 14,163 | 两段式检索（召回+精排） |
| [omnivore](https://github.com/omnivore-app/omnivore) | 16,234 | 已死：Readwise 级架构尸体（highlight 数据模型+resurface 机制） |
| [paper-qa](https://github.com/Future-House/paper-qa) | 9,186 | 高准确率逐句引用问答（agentic 检索+冲突解决） |
| [obsidian-weread-plugin](https://github.com/zhaohongxuan/obsidian-weread-plugin) | 2,243 | 微信读书元信息/划线/笔记同步 Obsidian |

## 死链存档（2）

- `bin123apple/BookGPT` — API 404 已删除（与书对话先祖；弱替代 theowenyoung/bookgpt 19★ 停更）
- `megadose/embedchain` — API 404（已并入 mem0 生态，mem0 在册）

---

## License 红线速查

| 可直接抄代码 | 只借思想（传染/自定义许可） |
|---|---|
| MIT/Apache/BSD：book-to-skill、docling、txtai、genanki、flashcards-obsidian、py-fsrs、ts-fsrs、anki-mcp、classbuild、notebookllama、personalized-podcast(无license慎)、MoneyPrinterTurbo、PPTAgent、CosyVoice、GPT-SoVITS、edge-tts(注意含GPL文件)、quartz、digital-garden、claude-obsidian、dataview、breadcrumbs、R2R、localGPT、LightRAG、graphrag、ankitects例外条款需细读 | ⚠️AGPL：onyx、BookRAG、khoj、siyuan、logseq、zotero-gpt、annotator、ChatTTS、ebooklib、PyMuPDF、AnkiGPT · ⚠️GPL：pandoc(思想+子进程隔离OK)、obsidian-readwise、Zettlr、Obsidian_to_Anki、epublifier · ⚠️自定义/NOASSERTION：MinerU、quivr、PageLM、emanote、anki-connect |
