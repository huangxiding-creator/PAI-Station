# BEST_PRACTICES — 最优网页搜索项目×优秀做法蒸馏 (1005 Arc L)

来源: 8 角度扫荡 125 raw (high 质量项 practices 全量) + 审计实证。
本文件 = 用户令「选出最优秀的项目, 包括它们的优秀做法」的蒸馏交付物;
接线计划见文末 (对接 zh-search-pro/cli_serp/cli_fetcher 在册栈)。

## 一、引擎适配层与统一检索网关 (最强主题)

| 项目 | 优秀做法 | 一句话可抄点 |
|---|---|---|
| **SearXNG** (37.9k★) | 引擎即插件 (一个 Python 类+YAML 条目); settings.yml `search.formats` 显式开 JSON → 一发 GET/POST 即统一检索网关; 内置 baidu/sogou/360search/quark 中文引擎; limiter bot 检测+逐引擎健康降级 | **自托管 JSON 网关 = 免 key 全引擎统一面**; 坏一引擎不拖全局 |
| **ddgs** (3k★, duckduckgo_search 换代) | `backend` 参数多后端自动轮换+显式后备顺序; text()/news()/images() 跨后端统一字段; 一包四形态 (库/CLI/FastAPI/MCP) | **单上游被封秒切不断供**; 统一签名换引擎零改码 |
| **howdoi** | `-e` 引擎热切换 (google/bing/ddg/stackoverflow); 本地答案缓存重复问题不发请求 | 反爬时改一个参数即恢复供给; 缓存天然降配额 |
| **Perplexica/Vane** (37k★) | 所有上游引擎藏在 SearXNG 单层后, 换/加引擎只改 SearXNG 配置不改主代码; 查询先 LLM 改写再路由; 结果先本地 embedding 重排再喂 LLM, 引用 URL 随答案返回 | **检索后端只抽象到元搜索一层**; 改写→路由→重排三段管线 |
| **YaCy** | 全部能力走 HTTP API (yacysearch.json), 上层聚合器把一个 peer 当普通上游引擎接入 | P2P 联邦索引 (DHT 分片), intranet 零依赖部署 |
| **open-webSearch MCP** | 免 key 引擎池+每引擎结果数可配; HTTP 代理配置位一等公民 | 零成本冷启动的检索池设计 |

## 二、预算/节流/上下文控制 (MCP 世代新功课)

- **bx (brave CLI)**: `context` 一次调用替代 搜索→抓取→抽取 三步, 输出按 token 预算裁剪——为 RAG 上下文成本设计的接口
- **brave-search-mcp v2**: 图片结果剥离 base64 只留 URL, 响应体积与上下文消耗骤降 (省 token 教科书)
- **duckduckgo-mcp-server**: 超长结果 URL 折叠为 `ref://` 短 token, 抓取工具回链 token——搜索型 MCP 省上下文巧招
- **crawl4ai**: ContentFilter (Pruning/BM25) 喂 LLM 前压缩页面; CacheMode 显式缓存策略
- **trafilatura**: `--precision/--recall` 显式换挡 (入库求全/正文求精); 多算法 fallback 零 token
- **ddgr**: omniprompt 按需翻页 (交互模型本身=节流器); `--json` 隐含非交互 (人机双场景一工具)
- **Scrapy**: AutoThrottle 按响应延迟自动调并发; RFPDupeFilter 请求指纹去重

## 三、研究管线与引用溯源 (研报工厂直接相关)

- **GPT Researcher** (29.9k★): planner→executor 双代理 (子问题清单→逐题并行检索); 访问过的源先入 context 仓去重, 引用不靠模型记忆; 深度/并行度全配置项
- **STORM** (31.5k★): 「提出好问题」工程化——相似主题已有文章提炼多视角引导提问+模拟专家对话追问; 大纲先行 (pre-writing 产 outline+文献集) 再逐节引用成文
- **Open Deep Research**: breadth×depth 参数化递归; learnings+directions 逐轮累积进提示词 (方向自修正); **核心刻意压在 500 行内** (最简可读实现是设计目标)
- **Scira**: 答案内联引用逐条可点击回源 (引用即验证入口); agentic 规划先行多源交叉核对
- **morphic**: 搜索结果唯一 URL 化, 长答案可分享可断点恢复; Compose 内置 SearXNG **免任何搜索 key 起跑**
- **Khoj**: 互联网检索与私有文档 RAG 双轨合一 (同一会话引用网页+个人库)

## 四、抽取层 (检索的后腿)

- **trafilatura**: fallback 链抽主内容; CLI 原生 --parallel 批处理
- **crawl4ai JsonCssExtractionStrategy**: CSS 选择器 schema 直抽 JSON, 结构化零 LLM 成本
- **Docling**: DocLayNet 布局模型理解版面 (扫描件/复杂表格靠模型不靠规则); 统一 DoclingDocument 中间表示
- **MarkItDown**: 所有格式统一契约出 Markdown (RAG 入库只写一次解析逻辑); 插件式转换器注册
- **Firecrawl** (188.6k★): search 端点内联 scrapeOptions 一次调用出 markdown; `/v1/map` 先拿站点清单再选择性抓 (两段式防盲爬); onlyMainContent 开关
- **Jina Reader**: URL 前缀即 API (r.jina.ai/<url>), 全部控制走 HTTP header, 无 key 档与免费 key 档分层限流

## 五、分发与形态工程

- **MCP 分发事实标准**: npx/uvx 单命令零克隆 (modelcontextprotocol/servers); 远程+本地同源双轨 (perplexity/tavily)
- **ddgs**: pip extras 切四种交付形态 (库/CLI/API/MCP)
- **Hister**: 单二进制零配置+浏览器扩展边采边索引+原生 MCP 服务端
- **Marginalia**: 低硬件预算工程 (单机消费级 RAM/SSD 跑大索引); 白标双模式 (公开引擎/自有数据后端)

## 六、安全与信任基线

- **MCP fetch server**: SSRF 防护+重定向/超时控制 = 抓取型工具标准安全基线
- **mcp-searxng**: 显式信任模型 (要求自建/可信实例+开 JSON, 不代装引擎); OpenSSF Scorecard 徽章把供应链可信度做成工程指标
- **openverse**: 查询日志匿名化不留 IP; 采集-清洗-索引-服务分层单仓
- **WechatSogou**: README 先写死平台数据边界 (临时链接须有效期内落盘/每号仅最近10条) 再讲用法——预期管理范式

## 七、清单/注册表工程 (我们正在做的事)

- **awesome-selfhosted**: 收录门禁机器可查 (OSI 许可+活跃维护, bot 定期剔除死链); 每条目固定字段可程序化解析直接进渠道注册表
- **s (zquestz)**: `--list-providers -j` 引擎清单本身机读可版本化 → 自动生成渠道矩阵
- **awesome-hacker-search-engines**: 按「情报对象」而非字母序分类, 每条强制一行用途注释

---

## 接线计划 (整合进在册栈 — 用户令「整合到本项目的调研收集渠道」)

| # | 做法 | 落位 | 状态 |
|---|---|---|---|
| 1 | SearXNG 自托管 JSON 网关 (中文引擎原生) | 注册表 metasearch tier1 (searx_space 公共实例已探); **自托管工单** SEARCH-1 (docker 一行起, formats 开 json) | 本次注册+探活 |
| 2 | ddgs backend 轮换/统一签名 | 注册表 api_wrapper tier1 (pip 面 pypi 实证); cli_serp 引擎层借鉴 backend 参数化 | 本次注册+pypi 实证 |
| 3 | ref:// 短 token + token 预算裁剪 | cli_serp 输出面增强工单 SEARCH-2 (长 URL 折叠+预算裁剪进 zh-search-pro --json) | 工单 |
| 4 | 本地结果缓存 (howdoi 式) | zh-search-pro 缓存层工单 SEARCH-3 (重复词不发请求, 天然护配额) | 工单 |
| 5 | JsonCssExtractionStrategy (CSS schema 零 LLM 抽取) | cli_serp 解析器降级链升级工单 SEARCH-4 (bs4 选择器 schema 化) | 工单 |
| 6 | GPT Researcher/STORM 管线做法 | RQS 研报质量标准对照: 引用密度/大纲先行已有; **learnings 逐轮累积**进 E-OSCAR 情报引擎工单 SEARCH-5 | 工单 |
| 7 | trafilatura/MarkItDown/Docling 统一抽取 | 注册表 crawler tier1 (trafilatura pypi 实证); 正文抽取腿正名 | 本次注册 |
| 8 | Jina Reader 免 key 前缀 API | 注册表 crawler tier1 (r.jina.ai 实查样本落盘) | 本次注册+实查 |

工单 SEARCH-1..5 已登记, 优先级排在渠道额度最大化 (1004 四连令) 之后、按 conductor 节奏排期。
