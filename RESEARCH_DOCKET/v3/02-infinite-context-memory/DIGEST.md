# DIGEST — 环节2：无限上下文/记忆架构（PAI-Station V3）

> 调研日 2026-09-13。数据通道：GitHub REST API 实测（stars/license/pushed/release 均当日拉取）+ HN Algolia + gh readme 直读 + hf-mirror 模型卡 + claude-api skill 一手文档。WebSearch/webReader 配额当日耗尽（2026-09-26 恢复），已用 API 通道替代，所有 stars 为当日实测值。
> 去重基线：`RESEARCH_DOCKET/RESEARCH_DIGEST.md` + `github/_all.json`（V2 350 仓）。V2 已录项目仅记新进展。
> 明细：`_all.json`（47 项：A17/B8/C9/D9/E4，每项含 relevance/value_to_v3/freshness）。

---

## 一、全景表（47 项，五类）

### A. 记忆框架（17）

| 项目 | ★(实测) | 许可 | 一句话 | 对 V3 价值 |
|---|---|---|---|---|
| mem0 | 65,197 | Apache-2.0 | 记忆层 star 王；2026-09-09 连发 OpenClaw/opencode/pi-agent 集成版 | 抽象层可借，基准自宣勿信 |
| LightRAG | 39,593 | MIT | 最活跃图 RAG；v1.5.7(09-02)；PG 表存储；DOCX 智能分节 chunk | 增量图+中文 chunk 第一参考实现 |
| OpenViking | 36,848 | **AGPL-3.0** | viking:// 虚拟 FS + L0/L1/L2 三级按需加载；v0.4.19+Go SDK(09-10) | L0/L1/L2=按需加载模板；学设计不抄码 |
| MS GraphRAG | 35,955 | MIT | **README 官宣维护模式**，仅修 bug/CVE | 全量图构建路线被判死刑的证据 |
| Qdrant/Graphiti(Zep) | 30,836 | Apache-2.0 | 时间感知图谱：事实随时间留痕、增量更新免全图重算 | temporal 数据模型可搬进 SQLite |
| cognee | 30,655 | Apache-2.0 | ECL(抽取-认知-加载)管线；v1.5.4(09-04) | 管线分层思想 |
| supermemory | 29,645 | MIT | 自宣三榜 #1、95% Recall@15、**99.4% 上下文缩减** | 定义注入层 KPI：只注入 0.6% 最相关 |
| agentmemory | 28,380 | Apache-2.0 | coding agent 持久记忆，病毒式传播 | 证明赛道刚需 |
| TencentDB-Agent-Memory | 26,491 | MIT | 四类记忆资产(Chat/Skill/Wiki/CodeGraph)，OpenClaw/Hermes 适配 | 记忆 schema 参考 |
| hindsight | 23,529 | MIT | learn≠remember：retain/recall/**reflect** | reflect 环节纳入夜间整理任务 |
| memU | 14,403 | NOASSERTION* | 记忆=Wiki，核心逻辑仅 500 行 | 证明个人记忆不需大框架 |
| MemOS 2.0 | 11,300 | Apache-2.0 | 中国队(MemTensor)：MemCube；本地插件=SQLite+FTS5+向量混合；LoCoMo 88.83 | 与 V3 场景最贴，插件架构直接对标 |
| HippoRAG 2 | 4,000 | MIT | ICML'25：PPR 多跳联想，索引成本远低于 GraphRAG 系 | '散落关联文件'检索算法蓝本 |
| MIRIX | 3,441 | Apache-2.0 | 六类记忆+**屏幕观察**建记忆(需 Docker+PG) | 感知侧记忆管线同构 blueprint |
| nano-graphrag | 3,988 | MIT | <1000 行最小 GraphRAG，2026-01 后放缓 | 读懂图 RAG 最短路径 |
| Letta(+letta-code) | 24,715/3,211 | Apache-2.0 | **主体已转 TS**(letta-code)，Python 版归档 | 只借 memory blocks 思想 |
| A-Mem | 1,177 | MIT | Zettelkasten 自组织记忆，2025-12 停更 | 思想参考 |

### B. 本地 RAG 管线（8）

| 项目 | ★ | 许可 | 一句话 | 对 V3 价值 |
|---|---|---|---|---|
| RAGFlow | 90,587 | Apache-2.0 | v0.27.2；DeepDoc 深度解析；**硬依赖 Docker≥24+WSL 内核参数** | DeepDoc 中文解析思想+chunk 模板；服务栈不合便携 |
| AnythingLLM | 65,964 | MIT | v1.16.1；Windows 桌面安装包；**默认 LanceDB 嵌入式** | 桌面 RAG 形态完整参照，选型互证 |
| PrivateGPT | 57,503 | Apache-2.0 | 已转型为 Claude API 模式的本地 API 层 | 转型情报：RAG 框架让位 agent+记忆 |
| Cherry Studio | 51,733 | AGPL-3.0 | v2.0.14；知识库+笔记+OCR+TTS，中文第一客户端 | 中文 UX 黄金标准；学交互不抄壳 |
| LlamaIndex | 52,137 | MIT | v0.14.24；SummaryIndex/递归检索器 | 按需取件（目录摘要式加载的现成抽象） |
| Khoj | 37,292 | AGPL-3.0 | 第二大脑先行者，2026-08 起放缓 | 产品形态参照 |
| txtai | 12,946 | Apache-2.0 | 嵌入 DB=稀疏+稠密向量+图+关系，自带 MCP API | 单库混合索引轻量样本 |
| AutoRAG 2.0 | 5,068 | NOASSERTION* | 图书管理员 agent；**"Never migrate your data"**就地联邦检索 | 哲学与 V3 完全同频+竞品格局文档(2026-09) |

### C. 向量/索引库 + 嵌入模型（9）

| 项目 | ★ | 许可 | 一句话 | 对 V3 价值 |
|---|---|---|---|---|
| FAISS | 40,893 | MIT | 算法库(HNSW/IVF)，无元数据层，GPU 见长 | 无 GPU 笔记本无优势→不选 |
| Qdrant | 34,513 | Apache-2.0 | Rust 引擎；client 有嵌入式模式(local path) | 备选件 |
| Chroma | 29,288 | Apache-2.0 | pip 即用；发版放缓(上版 2026-05) | FTS 弱于 LanceDB→备选 |
| FlagEmbedding(bge-m3) | 12,153 | MIT | **dense+sparse+multi-vector 三合一、8K ctx、100+语言** | CPU 笔记本甜点；sparse 补中文分词短板 |
| LanceDB | 11,410 | Apache-2.0 | Rust 嵌入式：向量+FTS+SQL 一库、**零拷贝版本化** | C 类首选 |
| sqlite-vec | 8,102 | Apache-2.0 | 纯 C SQLite 扩展；**alpha、暴力扫无 ANN**、2026-05 后无发版 | 与 FTS5 同库=单 .db 全家桶；10 万 chunk 内够用 |
| Qwen3-Embedding | 2,029 | Apache-2.0 | 0.6B/4B/8B；0.6B 即 32K ctx、MRL 32-1024 维 | 夜间批量建高质量索引的换代候选 |
| gte-multilingual-base | 306M 模型 | Apache-2.0 | mGTE dense+sparse，C-MTEB 成绩在卡 | 备胎 |
| Milvus Lite | 462 | Apache-2.0 | 纯 Python 重写：LSM+Parquet+FAISS 段+**BM25 内建** | 验证单文件混合方向；生态薄 |

### D. Windows 文件检索基建（9）

| 项目 | ★/规模 | 许可 | 一句话 | 对 V3 价值 |
|---|---|---|---|---|
| ripgrep | 68,213 | Unlicense | rg.exe 原生 Windows，GB 级内容秒扫 | **零索引兜底通道**：消灭索引滞后 |
| Meilisearch | 59,272 | MIT | v1.53.2；内存型索引+**无 Windows 原生二进制** | 两硬伤→排除 |
| jieba(+SQLite FTS5) | 35,151 | MIT/PublicDomain | FTS5 BM25 内建；中文靠外挂分词 | 维持 V2 选型，升级见硬启示 2 |
| Typesense | 26,547 | GPL-3.0 | Linux 二进制，Windows 需 Docker | 排除 |
| Everything(voidtools) | 事实标准 | 专有免费 | NTFS USN 直读，百万文件名毫秒搜 | **D 类之王**，文件名层白嫖 |
| voidtools/ES(es.exe) | 277 | 源码公开* | 官方 CLI，agent 子进程直调 | file_search 工具最简实现 |
| Everything 生态 | sdk3 67★/mcp 19★/skill 4★ | 各异* | named-pipe IPC 封装+MCP 化现成；**Everything4py 全站 0 结果(未核实)** | Python 侧自封装即可 |
| Windows Search | OS 内建 | 专有 | 属性索引，覆盖与可控性差 | 降级通道 |
| Whoosh | 361 | BSD* | 2024-02 起休眠，reloaded fork 续命 | 排除 |

### E. 协同/标准（3）

| 项目 | 规模 | 一句话 | 对 V3 价值 |
|---|---|---|---|
| Anthropic memory tool(+/editing/compaction) | 官方 GA/Beta | memory_20250818：Claude 读写 **/memories 目录**，宿主自实现后端 | 注入层官方范式：V3=其后端+MCP 检索工具 |
| OKF v0.2(GoogleCloudPlatform) | 9,178★ | 知识=markdown+YAML 目录，git 可 diff；provenance/freshness 一等公民 | **最意外发现**：记忆直接落硬盘 .md 文件 |
| MCP-Memory(fellowgeek) | 212★ | OKF .md 目录 ∥ SQLite FTS5 双层，<20ms | V3 记忆层参考图纸 |

（* = 许可未核实/识别异常，详见 `_all.json` freshness 字段）

---

## 二、推荐架构（文字版分层图）

**总纲：硬盘即记忆 = 索引不搬迁数据、检索按需加载、注入只给目录摘要。零服务、零 GPU、绿色便携、Windows 原生。**

```
┌─ L4 注入层（Injection）────────────────────────────────────────┐
│ 模型：Claude/GitHub Models/GLM-4-Flash API（零成本链不变）       │
│ • Claude 路径：memory_20250818 —— V3 实现 /memories 后端        │
│   （记忆目录=硬盘真实文件夹，OKF .md+frontmatter 格式）          │
│ • 检索工具走 MCP：file_search / read_chunk / recall_memory      │
│ • 三级注入（仿 OpenViking L0/L1/L2）：                          │
│   L0 目录一句话摘要 → L1 概览 → L2 全文，agent 决定读多深       │
│ • token 预算：单轮检索包 8-32K；prompt caching 固定前缀          │
│   （缓存命中 90% 折扣）；长会话用 context-editing 清旧工具结果   │
│   + compaction(compact-2026-01-12) 服务端压缩                  │
├─ L3 检索层（Retrieval）────────────────────────────────────────┤
│ 混合检索三通道 + 路由：                                         │
│ ① 文件名/路径 → Everything(es.exe)——毫秒级，零成本             │
│ ② 内容关键词 → SQLite FTS5 BM25(+jieba/bge-m3 sparse 权重)     │
│ ③ 语义/联想 → 向量 TopK(bge-m3 dense)                          │
│ 融合：RRF(倒数排序融合) → 可选 bge-reranker 精排 Top5-20       │
│ 兜底：未索引/新文件 → ripgrep 实时全文扫（消灭索引滞后）        │
│ 联想多跳：借鉴 HippoRAG2 PPR——记忆图上找"与此人此事相关的一切" │
├─ L2 嵌入层（Embedding）────────────────────────────────────────┤
│ 主力：bge-m3（ONNX int8 量化，CPU 实时；8K ctx 少切分；        │
│       sparse 输出兼作中文词权重）                               │
│ 夜间升级：Qwen3-Embedding-0.6B（32K ctx、MRL 存 256 维省 4x）  │
│ 增量：USN Journal/mtime 水位线 → 只嵌入变化 chunk；            │
│       首晚只嵌"热区"(桌面/文档/活跃项目)，长尾按访问懒嵌入     │
├─ L1 索引层（Index）────────────────────────────────────────────┤
│ SQLite 单文件全家桶（绿色便携核心）：                           │
│   FTS5 全文表 + sqlite-vec 向量表(1024 维) + 元数据表          │
│   ——一个 .db 拷走即迁移；事务保证增量一致性                    │
│ 文件名层：Everything 常驻实例(es.exe/IPC)——不自建              │
│ 记忆层：OKF 格式 .md 文件 + FTS5 索引（人可读/git 可版本化）   │
│ 哲学：数据永不搬迁入中央库（AutoRAG"Never migrate"），         │
│       chunk 化发生在读取侧而非入库侧                            │
└────────────────────────────────────────────────────────────────┘
```

**一句话架构**：Everything 秒搜文件名 + SQLite 单文件（FTS5+sqlite-vec）混合内容检索 + bge-m3 CPU 嵌入 + L0/L1/L2 目录摘要按需加载 + Claude memory tool 注入——硬盘即记忆，零服务零 GPU 绿色便携。

---

## 三、Top 5 缝合推荐

1. **Everything SDK + es.exe**（D）——文件名层直接白嫖 Windows 二十年最稳基建，agent 的 `file_search` 工具 10 行代码落地；MCP 封装样例现成（elis132/everything-mcp）。
2. **SQLite 单文件库（FTS5 BM25 + sqlite-vec 向量）**（C+D）——一个 .db 承载全文+向量+元数据，绿色便携/拷走即迁/事务增量；与 LanceDB 做 A/B（后者版本化更强、依赖更重）。`MCP-Memory`（OKF+FTS5 双层）是现成参考图纸。
3. **bge-m3 嵌入**（C）——CPU 可跑 + 8K 上下文 + dense/sparse 双输出一石三鸟（向量、中文词权重、免额外分词精度依赖）；夜间用 Qwen3-Embedding-0.6B 重建高质量索引。
4. **LightRAG + MemOS 的增量与 chunk 策略**（A）——LightRAG v1.5.5 的 DOCX Smart Heading 智能分节、graph-first 延迟向量索引、免全图重建增量；MemOS 本地插件的 SQLite+FTS5+向量混合与 L1/L2/L3 技能进化。取策略自实现，不引框架。
5. **Anthropic memory tool + OKF v0.2 格式**（E）——注入层官方协同范式（/memories 目录由 V3 实现后端）× Google Cloud 记忆文件标准（.md+frontmatter、provenance/freshness 一等公民）：记忆=硬盘上人类可读可 git 版本化的文件，天然契合"硬盘即记忆"且押中标准化窗口。

---

## 四、3 条硬启示

1. **增量索引是生死线，全量图构建已死**：MS GraphRAG 官宣维护模式 = 全图重建范式出局；硬盘文件每天变化，任何"重建才能更新"的索引都撑不住。对策：水位线增量（mtime/USN）+ sqlite-vec 式追加 + ripgrep 兜底未索引区 + chunk 懒加载（读取侧切分）。sqlite-vec 无 ANN 的暴力扫在 10 万 chunk 内反是优点：免建索引、免重平衡、插入零成本。
2. **中文嵌入=模型即分词器**：别再纠结 jieba 精度——bge-m3 的 sparse 输出天然产出中文词权重，与 FTS5 BM25 做双路召回+RRF 融合，是 2026 中文混合检索最佳实践（bge-m3 官方卡即推荐此管线）；Qwen3-Embedding 的 MRL 降维（1024→256）可再省 4 倍索引体积，0.6B 档 CPU 夜间可跑完百万级 chunk。
3. **注入层的 KPI 是"少注入"而非"多上下文"**：100 万 token 窗口的正确用法——supermemory 实测 99.4% 上下文缩减仍达 95% Recall@15；OpenViking 用 L0/L1/L2 三级摘要让 agent 先看目录再决定读哪个文件。V3 每轮注入 8-32K"检索包"+prompt caching 固定前缀 + context-editing 清理旧工具结果，成本与质量双赢。

---

## 五、风险清单

| # | 风险 | 等级 | 对策 |
|---|---|---|---|
| 1 | **许可雷**：OpenViking AGPL-3.0、Cherry Studio/Khoj/MIRIX AGPL、Typesense GPL-3.0、memU/AutoRAG NOASSERTION | 高 | 一律"学设计不抄码"；商用前复核 LICENSE 文件 |
| 2 | **Windows 便携雷**：Meilisearch/Typesense 无原生 Windows 二进制；RAGFlow 需 Docker≥24+WSL 内核参数；MIRIX 需 Docker+PostgreSQL | 高 | 全部排除出 V3 底座；坚持 SQLite/rg/Everything 原生件 |
| 3 | **单点维护者**：sqlite-vec(asg017) alpha 且 2026-05 后无发版、nano-graphrag/Whoosh/A-Mem 休眠 | 中 | sqlite-vec 与 LanceDB 保持可互换（向量表 schema 抽象层隔离） |
| 4 | **基准互殴**：mem0 vs Zep LoCoMo 口水仗、MemOS/supermemory 各自宣称 #1、各家 LLM-as-judge 口径不一 | 中 | 用自建中文职场评测集裁决（20 条真实"找文件/忆旧事"任务） |
| 5 | **Everything 闭源依赖**：专有免费软件+单一供应商(voidtools)；非 NTFS 卷(U 盘 exFAT)支持有限 | 中 | es.exe 结果缓存降级路径；FAT/exFAT 卷回退 rg+FTS5 |
| 6 | **首建成本**：全盘百万 chunk × CPU bge-m3 ≈ 数天电费 | 中 | 热区优先+懒嵌入+夜间长跑（复用"长跑任务晚间执行"惯例，断点续跑） |
| 7 | **记忆膨胀与遗忘**：OKF 文件目录无限增长、过期记忆误导 | 低 | 沿用 OKF v0.2 的 freshness/stale_after 字段+MemOS 式"创建/合并/跳过"三决策+hindsight 式 reflect 夜间整理 |
| 8 | **标准分裂**：OKF/Universal Memory Protocol/各家 memory format 并存 | 低 | 采用 OKF 兼容子集起步，schema 留 version 字段可迁移 |

---

## 六、趋势速记（2026-09 观察）

- **记忆即文件**成 HN 共识：calpaterson《Agent memory as a file format》(191 分, 08-31) → okf-agent-memory(80 分, 09-05) → MCP-Memory(70 分, 08-13) 三连热帖。
- **coding agent 记忆**是 2026 最热赛道：mem0 发 OpenClaw/opencode/pi 集成版、agentmemory/beads(Steve Yegge)/context-mode/akitaonrails ai-memory 扎堆。
- **框架大迁移**：Letta 主体转 TypeScript；PrivateGPT 转型 API 层；AutoRAG 2.0 转 librarian agent；MS GraphRAG 维护模式——"记忆框架"在收敛为"agent harness 里的一个目录"。
- **中国力量**：MemOS(上海 MemTensor)、TencentDB-Agent-Memory、Cherry Studio、LightRAG(HKUDS)、OpenViking(字节) 五路并进，中文场景不再是英文框架的附庸。
