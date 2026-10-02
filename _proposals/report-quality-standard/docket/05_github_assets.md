# GitHub 可复用资产调研

> 为「企业 EPC 总承包业务深度研究报告」质量标准（10 万字级中文报告，标准将工程化落地为自动/半自动审计）盘点 GitHub 可直接借鉴资产。
> Star 数均为 2026-09-28 GitHub API 实测快照。按必查清单 12 类组织，共 47 条，连续编号。

## 一、思维模型清单 / mental-models 类

### 1. AdrienLemaire/awesome-mental-models
- URL: https://github.com/AdrienLemaire/awesome-mental-models
- Stars/规模: ⭐168；清单纯清单（数十条书目+条目链接）
- 核心要点: mental models / heuristics / intuition pumps 精选清单，含书目出处与 Anki 卡组外链。注意：必查清单提到的 `ggalmat/awesome-mental-models` 已 404（删除/改名），此库是现存最知名同名库。
- 我们能搬什么: 其「每条模型挂原始出处（书/论文）+ 关联资源链接」的条目 schema，作为我们判断层框架库 YAML 的 citation 字段规范。

### 2. machinarii/awesome-mental-models
- URL: https://github.com/machinarii/awesome-mental-models
- Stars/规模: ⭐4（新库）；249 个思维模型
- 核心要点: 249 模型 = 一份分类索引 `mental-models.md` + 每模型一个独立 md 文件（Overview / How to Use It / Example / Takeaway / Source 五段式），外加可自动调用的 Claude Code skill。
- 我们能搬什么: 「一模型一文件 + 五段固定结构 + 索引」的内容组织直接照抄为我们判断层框架库的文件协议；skill 化调用方式接入生产线。

### 3. WiseCharlie/mental-models
- URL: https://github.com/WiseCharlie/mental-models
- Stars/规模: ⭐11；按学科分目录（Accounting / Biology / Psychology…）
- 核心要点: 跨学科思维模型库，每个模型按学科目录归类，强调多学科交叉用于独立思考。
- 我们能搬什么: 「按学科→模型」两级分类树，映射成我们的框架库 taxonomy（工程/财务/组织行为/宏观各归其位）。

### 4. lukasz-madon/awesome-concepts
- URL: https://github.com/lukasz-madon/awesome-concepts
- Stars/规模: ⭐635；四大类清单
- 核心要点: Laws / Principles / Mental Models / Cognitive Biases 四合一 awesome 清单，条目多且带出处。
- 我们能搬什么: 「规律-原则-模型-偏误」四层概念分级法，作为报告判断层词汇表的分层维度。

### 5. tjboudreaux/cc-thinking-skills
- URL: https://github.com/tjboudreaux/cc-thinking-skills
- Stars/规模: ⭐1333；28 个思维技能
- 核心要点: 28 个「eval-informed」思维模型与批判性思维技能，写成可给 AI coding agent 用的技能文件，每个都经过评测打磨。
- 我们能搬什么: 「eval-informed」做法——框架不只收录、还要配套评测用例验证 AI 用框架比不用时产出更好，照此给我们每个引入的框架写验收测试。

### 6. notmattlucas/anki-mental-models
- URL: https://github.com/notmattlucas/anki-mental-models
- Stars/规模: ⭐3；Anki 卡组仓库
- 核心要点: 思维模型 Anki 闪卡库（Super Thinking 系书目的卡片化样本）；AdrienLemaire 库中还链接更多 mental-models Anki decks。
- 我们能搬什么: 「正面术语 / 反面定义+适用场景+反例」的卡片双面结构，作为审计问答对（框架识别测试题）的出题模板。

## 二、咨询报告 / 战略框架模板

### 7. gcamilo/management-consulting
- URL: https://github.com/gcamilo/management-consulting
- Stars/规模: ⭐90；42 个框架，4100+ 行内容
- 核心要点: 管理咨询 skill：42 框架各含分步工作流、好坏输出示例、常见错误、失效条件；带输出契约、魔鬼代言人步骤、9 点质检清单与「何时不该用该框架」的反选择规则。
- 我们能搬什么: 三件直接搬——框架卡的固定字段（workflow/好例/坏例/常见错误/失效条件/反选择）、输出契约 + 9 点终检清单作为报告出厂 checklist 模板。

### 8. yoichiojima-2/consultant
- URL: https://github.com/yoichiojima-2/consultant
- Stars/规模: ⭐50；50+ 框架
- 核心要点: McKinsey / BCG / Bain / Accenture 在用 50+ 咨询框架，打包为 Claude Code 插件（按场景检索调用）。
- 我们能搬什么: 框架按咨询场景索引 + 插件化按需调用的方式，作为我们框架库的检索入口设计。

### 9. norahe0304-art/30x-mckinsey-research-deck
- URL: https://github.com/norahe0304-art/30x-mckinsey-research-deck
- Stars/规模: ⭐45；双 skill 包（研究生产线 + 排版引擎）
- 核心要点: 中文麦肯锡级市场研究生产线：联网研究 → Day-1 假设 → ghost deck 故事线 → 渲染 → 多 agent 对抗验证 → QC；主打「adversarially verified numbers」（每个数字被对抗式核验）与 15 套可执行方法论工作流。
- 我们能搬什么: 「数字必须经对抗核验才准出场」的 adversarial verification 关卡设计 + Day-1 假设先行的研究编排，直接映射我们证据饱和引擎的数字腿。

### 10. seulee26/mckinsey-pptx
- URL: https://github.com/seulee26/mckinsey-pptx
- Stars/规模: ⭐591；40 页 slide 模板
- 核心要点: 麦肯锡风 PPTX 生成器：40 个版式模板 + 按内容自动选版式的 subagent。
- 我们能搬什么: 「版式模板库 + 按内容自动选版」的机制，作为报告图表/版面模板自动匹配的参考实现。

### 11. sbussard/canvas-sketch
- URL: https://github.com/sbussard/canvas-sketch
- Stars/规模: ⭐251
- 核心要点: 浏览器里手绘 Business Model Canvas，画布分块结构化。
- 我们能搬什么: 一页纸框架的「分块画布」数据结构（每格一 JSON 字段），用于我们商业模式/竞对分析等一页纸模板的结构化存储而非自由文本。

## 三、研究报告 / 白皮书 / LaTeX 模板

### 12. Wandmalfarbe/pandoc-latex-template（Eisvogel）
- URL: https://github.com/Wandmalfarbe/pandoc-latex-template
- Stars/规模: ⭐7266；单模板（持续维护）
- 核心要点: Markdown→PDF/LaTeX 最流行的 pandoc 模板，封面/目录/页眉页脚/中文字体支持一应俱全，是 md 生产线排版的事实标准。
- 我们能搬什么: 直接用作我们 md→PDF 排版链的基模板，省掉自研 LaTeX 排版（我们已有 md2docx 链，此为 PDF 腿备选）。

### 13. quarto-dev/quarto-cli
- URL: https://github.com/quarto-dev/quarto-cli
- Stars/规模: ⭐6026；完整出版系统（活跃维护）
- 核心要点: 基于 Pandoc 的开源科学/技术出版系统：一份 markdown 源同时出 HTML/PDF/DOCX，自带交叉引用、参考文献、附录、Callout 等报告级结构语义。
- 我们能搬什么: 其「报告结构语义」（交叉引用/图表编号/文献表）的源码语法设计，作为我们 md 报告的中间表示规范；10 万字级报告的编号与引用机可直接复用。

### 14. noraj/OSCP-Exam-Report-Template-Markdown
- URL: https://github.com/noraj/OSCP-Exam-Report-Template-Markdown
- Stars/规模: ⭐4202；多套模板 + 自动构建
- 核心要点: 渗透测试报告的 markdown 模板：章节结构、证据引用格式全部模板强制，配 pandoc 一键构建 PDF——「报告结构合规由模板+CI 强制」的成熟范例。
- 我们能搬什么: 「结构合规靠模板与构建脚本强制」的工程思路：把我们的章节骨架/证据引用格式做成模板，缺节少引用直接构建失败。

### 15. xdanaux/moderncv
- URL: https://github.com/xdanaux/moderncv
- Stars/规模: ⭐1938；LaTeX class
- 核心要点: 老牌 LaTeX 简历 class（清单点名的 latex class 样本），展示「文档类型封装成 class/主题参数化」的经典做法。
- 我们能搬什么: 相关性中等——借鉴其「版式与内容分离、风格参数化」思想，报告样式（字体/字号/间距）做成可切换参数而非硬编码。

### 16. saboyle/latex-template-whitepaper-basic
- URL: https://github.com/saboyle/latex-template-whitepaper-basic
- Stars/规模: ⭐37；基础模板
- 核心要点: 研究/商业白皮书与讨论文档的基础 LaTeX 模板（封面、摘要、章节、参考）。
- 我们能搬什么: 白皮书的「摘要-正文-参考」最小合法结构清单，作为报告结构完备门的一档基线。

## 四、写作质量 linter（规则即代码）

### 17. vale-cli/vale（原 errata-ai/vale）
- URL: https://github.com/vale-cli/vale
- Stars/规模: ⭐6170；单二进制 + 风格包生态（活跃维护）
- 核心要点: 标记感知（markdown/html）的 prose linter：规则写成声明式 YAML style（existence/substitution/occurrence/scope 四类检查 + 严重度分级），CI 可跑，大量文档团队在用。
- 我们能搬什么: 整套「质量规则即声明式 YAML + 严重度分级 + CI 门禁」范式——我们的报告质量标准第一版就该照这个形态落地（规则文件独立于引擎，可版本化可评审）。

### 18. btford/write-good
- URL: https://github.com/btford/write-good
- Stars/规模: ⭐5092；npm 库（低维护）
- 核心要点: 朴素英文 prose linter：被动语态、滑词（so/very/really）、复杂句、陈词滥调等启发式检查，规则即正则/简单启发式数组。
- 我们能搬什么: 「坏味道词表」式规则的移植清单——把被动语态/滑词检测思路汉化成中文公文腔检测（「进行了」「有关」「一定程度」类模糊词表）。

### 19. amperser/proselint
- URL: https://github.com/amperser/proselint
- Stars/规模: ⭐4579；Python 库 + 上千条检查
- 核心要点: 源自经典写作指南（Strunk & White、Garner 等）的 prose 检查器，规则按主题模块化（拼写、冗余、陈词滥调、炒作词…）。
- 我们能搬什么: 「规则按写作指南章节模块化组织 + 每规则挂指南出处」的结构，我们的中文写作规范（阮一峰风格指南等）照此拆成可执行规则模块。

### 20. textlint/textlint
- URL: https://github.com/textlint/textlint
- Stars/规模: ⭐3194；引擎 + npm 规则生态（日语生态最成熟，活跃维护）
- 核心要点: 可插拔自然语言文本 linter：基于 AST（markdown/文本），规则即 npm 包，支持 preset 打包、自动修复（--fix）、过滤器，CI 集成完备——「写作规则引擎」工程化程度最高者。
- 我们能搬什么: 引擎直接用（中文规则可写）：preset 机制、fixable 标记（可自动修复 vs 仅告警）、AST 位置定位报错到行——我们报告审计器抄此交互设计。

### 21. textlint-ja/textlint-rule-preset-ai-writing
- URL: https://github.com/textlint-ja/textlint-rule-preset-ai-writing
- Stars/规模: ⭐1148；规则 preset（活跃维护）
- 核心要点: 检测「AI 味」日文写作模式并提示更自然表达的规则集——AI slop 检测在写作 linter 里的最大规模落地。
- 我们能搬什么: 其规则清单（空洞强调、万能连接词、模板化开场收尾等模式类目）逐条汉化，构成我们 10 万字报告的 AI 味检测第一版规则表。

### 22. textlint-ja/textlint-rule-preset-ja-technical-writing
- URL: https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing
- Stars/规模: ⭐557；规则 preset（活跃维护）
- 核心要点: 日语技术文档写作 preset：句长上限、一词多义、弱化表达、标点规范等可自动修复的规则集——「技术写作规范全量 linter 化」的样板。
- 我们能搬什么: 句长阈值、术语一致、命令式规范这几类「可确定性修复」的规则族划分方式，直接平移到中文技术/研究报告 preset。

### 23. darkyzhou/textlint-rule-preset-zh-technical-writing
- URL: https://github.com/darkyzhou/textlint-rule-preset-zh-technical-writing
- Stars/规模: ⭐11；中文规则 preset（低频维护）
- 核心要点: 现成的中文技术文档 textlint preset：多类规则、多数带 autofix——中文写作 linter 规则的稀有存量。
- 我们能搬什么: 作为我们中文报告 preset 的起点 fork：在其规则上补「研究报告专属」规则（数据出处强制、图表引用强制）。

### 24. berelevant-ai/slopless
- URL: https://github.com/berelevant-ai/slopless
- Stars/规模: ⭐327；确定性规则 + CLI（新，活跃）
- 核心要点: 用确定性 textlint 规则（非 LLM 判定）抓英文 markdown 的 AI slop 套话——「确定性规则抓 AI 味」路线的代表。
- 我们能搬什么: 「确定性规则优先于 LLM 判定」的分层审计思路：先跑便宜的确定性检测，LLM 只判剩余语义问题——直接定为我们审计器的分层架构。

### 25. tbhb/vale-ai-tells
- URL: https://github.com/tbhb/vale-ai-tells
- Stars/规模: ⭐111；Vale 风格包（新，活跃）
- 核心要点: 抓 AI 套话（"In today's rapidly evolving landscape…" 一类）的 Vale style 包，YAML 声明式，可并入任何 Vale 管线。
- 我们能搬什么: 其 YAML 规则写法作模板，把中文 AI 套话（「随着…的不断发展」「综上所述」「值得注意的是」滥用）做成同名 style 包。

## 五、awesome-writing / 学术写作清单

### 26. Leey21/awesome-ai-research-writing
- URL: https://github.com/Leey21/awesome-ai-research-writing
- Stars/规模: ⭐34446；prompt 模板库 + agent skills（中文，活跃）
- 核心要点: 调研 MSRA/字节 Seed/上海 AI Lab 研究员与清北中科大硕博的一线写作 prompt 模板与 agent skills，中文生态最大的学术 AI 写作资源库。
- 我们能搬什么: 其润色/翻译/审稿类 prompt 模板与 skills 目录，筛选后接入我们成稿润色与审稿腿（中文原生，几乎零适配）。

### 27. writing-resources/awesome-scientific-writing
- URL: https://github.com/writing-resources/awesome-scientific-writing
- Stars/规模: ⭐1007；清单纯清单（持续更新）
- 核心要点: 「超越 LaTeX」的科学写作工具/演示/资源大全（markdown 工具链、协作、出版、检查器分类齐全）。
- 我们能搬什么: 其工具分类法（写作/检查/发布/协作）作为我们工具选型时的供应商长名单与查漏清单。

### 28. BolajiAyodeji/awesome-technical-writing
- URL: https://github.com/BolajiAyodeji/awesome-technical-writing
- Stars/规模: ⭐2310；清单（文章/书/视频/工具/播客）
- 核心要点: 技术写作资源大全，含风格指南、文档即代码（docs-as-code）实践与工具条目。
- 我们能搬什么: docs-as-code 实践条目（CI 文档检查、风格指南落地案例）作为我们「报告即代码」路线的外部经验库。

### 29. zLanqing/codex-claude-academic-skills
- URL: https://github.com/zLanqing/codex-claude-academic-skills
- Stars/规模: ⭐4373；3 个学术 skill（中文）
- 核心要点: 面向科研人员的完整工作流 skills：文献阅读报告、学术 PPT/Word 文档生成（office-academic-skill）、科学计算，中文学术产出格式现成。
- 我们能搬什么: 其学术报告/Word/PPT 生成 skill 的格式规范与排版细节（中文脚注/图表编号习惯），并入我们成稿排版链。

## 六、ACH / 红队 / 批判性思维工具

### 30. Burton/Analysis-of-Competing-Hypotheses
- URL: https://github.com/Burton/Analysis-of-Competing-Hypotheses
- Stars/规模: ⭐110；经典工具（2012 年后停更，方法论不变）
- 核心要点: CIA Heuer ACH 方法的开源平台：假设×证据矩阵、一致性/不一致性逐格打分、证伪优先——ACH 的标准软件形态参考。
- 我们能搬什么: 「假设×证据矩阵 + 每格一致/不一致标注 + 最弱假设出局」的数据模型，直接结构化我们的 ACH 对抗腿（我们已有 ACH 假设对抗，此为矩阵化补全）。

### 31. promptfoo/promptfoo
- URL: https://github.com/promptfoo/promptfoo
- Stars/规模: ⭐25529；完整评测/红队平台（活跃维护）
- 核心要点: LLM prompt/agent/RAG 评测 + 红队（注入、越权、事实性断言断言式校验）一体的开源平台，配置即评测用例，CI 可跑。
- 我们能搬什么: 其「断言(assertions)即 YAML 测试用例 + 红队策略库」的形态，作为我们报告审计用例库与对抗评审（红队腿）的 harness 选型。

## 七、证据 / 事实核查 / claim 抽取

### 32. filtir/awesome-AI-fact-checking
- URL: https://github.com/filtir/awesome-AI-fact-checking
- Stars/规模: ⭐14；论文清单（另同门 jiahuigeng/awesome-hallucination-fact-checking-in-NLG ⭐7）
- 核心要点: AI 生成内容自动事实核查论文合集（含 claim 抽取、证据检索、可验证性判定三个子方向）。
- 我们能搬什么: 按其综述脉络（claim 抽取→证据检索→判定）搭我们数字/事实核验腿的技术路线图，直接引其高引论文的方法。

### 33. Babelscape/FENICE
- URL: https://github.com/Babelscape/FENICE
- Stars/规模: ⭐31；研究代码 + 数据集（EMNLP 2022）
- 核心要点: 摘要事实性评估：先从文本抽取原子 claim，再用 NLI 逐条对齐源文档判定——「claim 级事实性评分」的代表方法。
- 我们能搬什么: 「报告拆原子 claim → 逐条对证据源做 NLI 判定 → 汇总事实性分」的流水线设计，作为我们成稿抽检的确定性打分器原型。

### 34. utaresearch/claimbuster-spotter
- URL: https://github.com/utaresearch/claimbuster-spotter
- Stars/规模: ⭐85；研究代码（UT Arlington，ClaimBuster 团队）
- 核心要点: ClaimBuster 系（check-worthy claim 检测经典工作）的对抗训练 transformer 版：自动识别「值得核查的事实断言」并打分。
- 我们能搬什么: 「先判断哪句值得核查（check-worthiness 打分）再派核查资源」的两段式设计，用于我们 10 万字报告的抽查采样器（优先核查高分断言）。

## 八、中文写作质量工具

### 35. ruanyf/document-style-guide
- URL: https://github.com/ruanyf/document-style-guide
- Stars/规模: ⭐12948；中文写作规范（结构清晰，中频维护）
- 核心要点: 阮一峰《中文技术文档写作规范》：标题层级、段落、数值/标点/中英混排、名词统一全都有明确可执行条款——中文写作规范事实标准。
- 我们能搬什么: 逐条转译成机器可查规则（标题层级合规、标点全半角、中英间空格、数值单位规范），作为中文报告 linter 规则库的第一批种子条款。

### 36. huacnlee/autocorrect
- URL: https://github.com/huacnlee/autocorrect
- Stars/规模: ⭐1642；Rust linter/formatter（活跃维护）
- 核心要点: CJK 中英混排纠错器：自动加中英间空格、修标点/重复用词，Rust 实现、可作 CLI/lib/CI，中文技术圈广泛使用。
- 我们能搬什么: 直接进生产线当格式守门员（format 腿），并借鉴其规则-测试对（每规则带 golden 用例）的工程规范。

### 37. zhlint-project/zhlint
- URL: https://github.com/zhlint-project/zhlint
- Stars/规模: ⭐1014；中文 lint 工具（活跃维护）
- 核心要点: 专攻中文文案标点/空格规范（含引号、顿号、省略号等中文特有规则）的 linter，规则来自中文文案排版指北。
- 我们能搬什么: 其中文标点规则集与「同一文本多规范冲突时的优先级配置」设计，并入我们 preset 的标点规则族。

### 38. textstat/textstat
- URL: https://github.com/textstat/textstat
- Stars/规模: ⭐1384；Python 可读性计算库（公式注册表式架构）
- 核心要点: 段落/句子/音节统计 + Flesch 等 10+ 可读性公式，公式以注册表形式可扩展——但公式基本面向英文。
- 我们能搬什么: 其「可读性公式注册表」架构照搬，注册中文可读性公式（基于 HanLP 分词的句长/虚词密度/成语密度），形成中文版 textstat 内核。

### 39. hankcs/HanLP
- URL: https://github.com/hankcs/HanLP
- Stars/规模: ⭐36508；中文 NLP 工具箱（活跃维护）
- 核心要点: 中文分词/词性/命名实体/依存句法/关键词/自动摘要全栈 NLP，工业级、Python/Java 双栈。
- 我们能搬什么: 当中文文本统计底座：分词供句长与术语密度统计，NER 供「公司/项目/人名前后一致性」审计，关键词抽取供章节-标题对齐检查。

### 40. hiDaDeng/cnsenti
- URL: https://github.com/hiDaDeng/cnsenti
- Stars/规模: ⭐590；中文情感分析库（停更但可复用）
- 核心要点: 中文文本情绪与正负情感分析（多词表方法，轻量无模型依赖）。
- 我们能搬什么: 报告语气审计底座之一：扫描成稿中过度主观/渲染性段落（研报应中性克制），超阈值段落标记人工复核。

### 41. notnotype/llmlint
- URL: https://github.com/notnotype/llmlint
- Stars/规模: ⭐10；规则+LLM 双段 linter（新）
- 核心要点: 专为 LLM 生成中文文本设计的 linter：确定性规则定位 AI 写作痕迹，再由模型判定修复——中文 AI 味检测的直接先行者。
- 我们能搬什么: 「规则定位 + LLM 判定修复」的双段管线与其中文 AI 味规则表，直接并入我们 AI 味审计腿。

### 42. haodehaode378/text-encoding-guard
- URL: https://github.com/haodehaode378/text-encoding-guard
- Stars/规模: ⭐45；GitHub Action + Claude hook（新）
- 核心要点: 检测并修复 AI 编码助手造成的中文乱码（mojibake），支持 CI 与 hook 两种挂法。
- 我们能搬什么: 直接挂进生产线当编码守门员（我们环境 GBK 坑多），其「hook+CI 双挂法」模式用于其余审计器的部署形态。

## 九、rubric / 评分量表

### 43. paper-instruments/rubric
- URL: https://github.com/paper-instruments/rubric
- Stars/规模: ⭐75；Python 库（PyPI `rubric`，新）
- 核心要点: LLM 加权 rubric 评估库：评分量表声明式定义（维度/权重/等级描述），LLM 按表打分——rubric 即配置。
- 我们能搬什么: 其加权 rubric 的 schema 直接作为我们报告评分量表（内容/证据/逻辑/表达四维加权）的定义格式，评分代码不用自研。

### 44. AI9Stars/LLM-Rubrics-Survey
- URL: https://github.com/AI9Stars/LLM-Rubrics-Survey
- Stars/规模: ⭐70；综述仓库（2026，新）
- 核心要点: LLM 评测中 rubric 全景综述：rubric 构造、校准、与偏好评测对比、失败模式——论文级系统梳理。
- 我们能搬什么: 按其综述校准我们的量表（等级锚点描述法、评分者一致性检验），避免自创量表踩已知坑。

### 45. imlrz/DeepResearch-Bench-II
- URL: https://github.com/imlrz/DeepResearch-Bench-II
- Stars/规模: ⭐92；基准数据集 + 评测器（2026，活跃）
- 核心要点: 从专家级真实报告提取 rubric 来评测深度研究 agent 的基准（含 HF 数据集与官方评测器）——「专家报告→rubric→自动评分」完整链条的现成实现。
- 我们能搬什么: 其「从顶级专家报告反推评分 rubric」的构造流程照搬：拿顶级 EPC 行研报告反推我们的评分维度与锚点，评测 prompt 设计亦可参考。

## 十、数据可视化规范

### 46. ft-interactive/visual-vocabulary
- URL: https://github.com/ft-interactive/visual-vocabulary
- Stars/规模: ⭐347；~60 种图型样例
- 核心要点: 金融时报数据团队的「图表词汇表」：按数据关系（分布/相关/时间/占比…）给出每种图的适用场景与反例，新闻级图表选型事实标准。
- 我们能搬什么: 图型选型表转成「数据关系→合法图型」映射规则，接入我们图表自动审（错图型直接打回），并作设计师画图对照库。

### 47. bbc/bbplot
- URL: https://github.com/bbc/bbplot
- Stars/规模: ⭐1641；R 包（BBC 数据团队出品）
- 核心要点: BBC 新闻数据团队 ggplot2 出图规范包：统一主题、字体、配色、坐标轴样式与导出流程——媒体级图表风格代码化范本。
- 我们能搬什么: 「图表风格主题包 + 一键出图导出」做法平移到我们 Python 栈（matplotlib 主题包），保证 10 万字报告全部图表风格一致。

## 综合判断

1. **最值得直接引入的是「规则即代码」引擎范式**：vale（声明式 YAML 规则+严重度+CI 门禁）与 textlint（插件 preset+fixable+AST 定位）双范式都成熟，我们的报告质量标准第一版就按「规则文件与引擎分离、可版本化评审」形态落地。
2. **中文规则库不必从零写**：autocorrect（格式）+ zhlint（标点）+ darkyzhou 中文 preset（技术写作）三件套打底，ruanyf/document-style-guide 逐条转译成种子规则，再补「研究报告专属」规则（数据出处强制、图表引用强制、AI 味检测）。
3. **AI 味检测已有四路先行**（preset-ai-writing ⭐1148 / slopless / vale-ai-tells / llmlint），且共识是「确定性规则优先、LLM 只判语义残余」——直接定为我们审计器分层架构。
4. **模型/框架清单做成结构化库**：machinarii「一模型一文件五段式 + 索引」+ WiseCharlie 学科分类树 + gcamilo「好例/坏例/失效条件/反选择」字段，三合一即我们判断层框架库协议；cc-thinking-skills 的 eval-informed 做法要求每个框架带验收测试。
5. **评分量表用现成 schema**：paper-instruments/rubric 的加权 rubric 定义格式 + DeepResearch-Bench-II「专家报告反推 rubric」的构造法，量表代码与构造流程都无需自研。
6. **结构合规靠模板+构建强制**（OSCP 模板范式），**事实核验走 claim 抽取→证据对齐**（FENICE 流水线），**抽查采样用 check-worthiness 打分**（ClaimBuster），三段拼成证据审计腿。
7. 需要警惕：多个新 Claude-skill 类仓库（30x-mckinsey、management-consulting 等）star 低、可能短命——只搬其方法论结构与规则设计，不做运行时依赖。
