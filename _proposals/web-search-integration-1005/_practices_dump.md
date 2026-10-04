### Aas-ee/open-webSearch | https://github.com/Aas-ee/open-webSearch
 - 免key引擎池+可配默认引擎与每引擎结果数, 检索渠道零成本冷启动可直接抄
 - MCP server/CLI/本地daemon三形态复用同一检索核, 脱离agent也能当命令行搜用
 - HTTP代理配置位显式建模, 墙内外受限资源场景按一等公民对待

### Crawlee | https://github.com/apify/crawlee
 - RequestQueue+AutoscaledPool 按CPU/内存自动伸缩并发, 长跑任务自稳定
 - CheerioCrawler/PlaywrightCrawler 同一爬虫类切换, 简单站走HTTP省资源重站才上浏览器
 - 内建代理轮换与会话管理, 反封锁不靠外部胶水

### DevDocs | https://github.com/freeCodeCamp/devdocs
 - 每源一抓取器: lib/docs/scrapers 下 226 个 Ruby scraper + filters 把异构文档站统一为 entries 索引清单——引擎适配层的文档版实现
 - 检索前移到浏览器: 预构建索引 + lunr.js 客户端检索 + service worker 离线缓存, 服务端查询成本近零
 - 文档版本化静态分发: 每文档独立元数据与索引文件, 可单独更新与失效缓存

### Docling | https://github.com/docling-project/docling
 - DocLayNet布局模型理解版面结构, 扫描件/复杂表格的抽取质量靠模型不靠规则
 - 统一DoclingDocument中间表示, 多格式进多格式出只维护一条解析链
 - 与LangChain/LlamaIndex一线框架官方集成, 入检索管道零胶水

### Firecrawl | https://github.com/firecrawl/firecrawl
 - search 端点把搜索与抓取合并为一次调用 (scrapeOptions 内联)，直接返回 markdown，省掉二次请求编排
 - Research 索引 (PubMed/bioRxiv/medRxiv/arXiv) 与 Developer 索引 (GitHub issues/PRs/README) 旁路通用网页，学术与代码检索精度高
 - AGPL 开源核心可完全自托管，云与内网双轨同一 API 契约

### GPT Researcher | https://github.com/assafelovic/gpt-researcher
 - planner→executor 双代理: 先产子问题清单, 逐题并行检索+抓取, 素材按用途分层写入 (背景/大纲/正文)
 - 每个结论句带溯源引用, 访问过的源先入 context 仓去重, 引用不靠模型记忆
 - 报告格式可插拔, 研究深度与并行度全是配置项, 便于嵌进工厂流水线

### Hister | https://github.com/asciimoo/hister
 - 单二进制零配置分发: 各平台单文件内置 web UI, brew/docker/nix 多通道安装, 本地起服务即用
 - 浏览器扩展边采边索引: 访问即收录, 免独立爬虫调度, 采集面与浏览行为天然同步
 - 原生 MCP 服务端: AI 助手/agent 可直接检索本地索引, 检索渠道即插即用

### Jina Reader (r.jina.ai / s.jina.ai) | https://github.com/jina-ai/reader
 - URL 前缀式 API 设计 (r.jina.ai/<任意 URL>)，无 SDK 无注册 curl 即用，集成成本趋零
 - 无 key 档与免费 key 档分层限流 (20 对 500 RPM)，试用无门槛同时防滥用
 - 抓取控制全走 HTTP 头 (X-Target-Selector/X-Remove-Selector/X-Timeout/X-Proxy-Url)，URL 保持可缓存

### Jina Reader (r.jina.ai) | https://github.com/jina-ai/reader
 - URL前缀即API (r.jina.ai/<url>), 无SDK无集成成本, agent一行fetch就能取数
 - 全部控制走HTTP header (x-target-selector/x-timeout/x-no-cache), 管道可无状态组合
 - x-max-tokens/x-token-budget 预算控制在服务端裁剪, 不会撑爆上下文

### Khoj | https://github.com/khoj-ai/khoj
 - 互联网检索与私有文档 RAG 双轨合一: 同一会话同时引用网页与个人知识库, 天然适合研究资料积累
 - agent 即配置(自定义知识/人设/模型/工具), 把检索能力封装成可分享可复用的角色
 - 一套自托管服务端多端复用(Obsidian/Emacs/WhatsApp/网页/桌面), 检索能力随端到人到

### Marginalia Search | https://github.com/MarginaliaSearch/MarginaliaSearch
 - 白标双模式: 同一代码既跑公开搜索引擎, 也可换成自有数据(自爬或 side-load)的白标检索后端
 - 低硬件预算工程: 面向单机消费级 RAM/SSD 设计索引栈, 不依赖数据中心——小硬件跑大索引的路线证明
 - run/ 目录一键编排本地环境(setup.sh 拉补充模型数据+分进程部署), 自托管体验工程化

### MarkItDown | https://github.com/microsoft/markitdown
 - 所有格式统一契约输出Markdown, RAG入库只写一次解析逻辑
 - 插件式转换器注册(register_converter), 新格式扩展不动核心
 - CLI一行转换+streamlit图形界面, 非工程角色也能用

### Morphic | https://github.com/miurla/morphic
 - Docker Compose 内置 SearXNG, 免任何搜索 API key 即可起服务, 云源 (Tavily/Brave/Exa) 只作可切换 provider
 - 基于 Vercel AI SDK 的 RSC 流式生成 UI: 链接列表与答案并行流式渲染, 首屏即出检索结果
 - 追问用 embedding 相关性自动续链, 会话内检索记忆免重查

### Open Deep Research (dzhng) | https://github.com/dzhng/deep-research
 - breadth×depth 参数化递归: 每轮把新学到的 learnings 与下一步 directions 累积进提示词, 研究方向自我修正
 - 刻意把核心压在 500 行以内 — '最简可读实现'是设计目标本身, 极易 fork 改造
 - 检索与正文抽取服务分离(SERP 引擎出链+阅读器出干净正文), 两类供应商独立可换

### Open WebUI | https://github.com/open-webui/open-webui
 - 数十家检索商统一在一个 web search 抽象后, 搜索结果作为上下文注入对话流再由 LLM 归纳并给引用
 - 混合检索(BM25+向量)+可换重排器+full-context 三模式可配置, 同一管线兼顾精度与长文档
 - 存储层全可换(SQLite/PostgreSQL、9 种向量库、S3/GCS/Azure), 检索管线从单机到企业不改代码

### Openverse | https://github.com/WordPress/openverse
 - 采集-清洗-入索引-服务分层单仓: catalog(源适配采集)/ingestion_server(去重清洗)/indexer_worker(索引更新)/api(Django 服务)各司其职, docker-compose 本地全栈可起
 - 数据源适配器模式: 每个媒体源一个 provider adapter 统一摄入, 新源=新增一个适配器, 增量同步可调度
 - API 侧隐私与限流内建: 查询日志匿名化不留 IP, API 文档化, 便于第三方聚合接入

### Perplexica (已更名 Vane) | https://github.com/ItzCrazyKns/Vane
 - 把所有上游引擎藏在 SearXNG 单一元搜索层后, 引擎增删换血不动主代码且多数引擎免 API key
 - 三档搜索模式(Speed/Balanced/Quality)+来源类型(web/讨论区/学术)由独立查询 agent 路由, 按意图分发不同检索面
 - 本地 LLM(Ollama) 与云端模型可按需混搭, 同一管线从离线隐私场景平移到高质量云场景

### Playwright | https://github.com/microsoft/playwright
 - actionability自动等待(可见/可点/稳定才操作), 用等待替代sleep根治时序flake
 - page.route() 在浏览器层拦截/改写/mock请求, 反爬调试与数据截获一招通吃
 - trace viewer 录制DOM快照+网络+日志, 采集失败可离线回放定位

### Playwright MCP | https://github.com/microsoft/playwright-mcp
 - 用a11y树快照而非截图喂LLM, 同等信息量token省一个数量级
 - 工具按操作粒度细拆(navigate/click/snapshot), LLM按需调用不超载上下文
 - 默认隔离浏览器context, 每会话干净状态不串cookie

### STORM / Co-STORM (stanford-oval) | https://github.com/stanford-oval/storm
 - 把'提出好问题'工程化: 从相似主题已有文章提炼多视角引导提问, 再用模拟专家对话追问, 检索深度显著优于直接 prompt
 - 检索模块接口化(rm.py: YouRM/Bing/VectorRM 可换)+litellm 统一 LLM 层, 管线组件皆可替换
 - 大纲先行再成文: pre-writing 产出 outline+参考文献集, writing 逐节引用, 长文引用密度可控

### Scira (原 MiniPerplx) | https://github.com/zaidmukaddam/scira
 - serverless Redis(Upstash) 做限流层, 免运维扛公网流量 — 代理型搜索服务的标准解法
 - 答案内联引用逐条可点击回源, 引用即验证入口
 - agentic 规划先行: 问题先拆子任务再检索, 多源交叉核对后才合成答案

### Scrapy | https://github.com/scrapy/scrapy
 - AutoThrottle 按响应延迟自动调节并发, 不用手调速率
 - RFPDupeFilter 请求指纹去重, 广度爬取不重复拉同一URL
 - 下载中间件+Item Pipeline分层, 取数/清洗/落盘解耦可插拔

### SearXNG | https://github.com/searxng/searxng
 - JSON 输出必须在 settings.yml 的 search.formats 白名单显式开启，默认只出 HTML 防公共实例被脚本打死，自托管改一行即开
 - 内置 botdetection 限流器 (limiter.toml) 与逐引擎健康降级，坏一个引擎不拖垮全局
 - docker 一行起服务，engines 声明式逐个开关，取数面按需裁剪

### Stagehand | https://github.com/browserbase/stagehand
 - act/extract/observe三原语把'操作/抽取/探测'显式分层, agent行为可预测
 - action命中缓存后直接重放, 相同操作零LLM调用
 - extract 用 zod schema 约束输出, 抽取结果直接类型安全入管道

### Vane (原 Perplexica) | https://github.com/ItzCrazyKns/Vane
 - docker compose 把 SearXNG (开 JSON API) 直接捆进栈，一次部署同时获得元搜索底座+AI 问答引擎两件套
 - 独立 --mode api 把整套 AI 搜索当纯程序化 API 服务跑，不强迫走聊天 UI
 - Ollama 本地 LLM+本地 embedding 重排可选，全链路可零 key 零费落地

### Vane (原Perplexica) | https://github.com/ItzCrazyKns/Vane
 - 检索后端只抽象到SearXNG一层，换/加引擎(百度/360/搜狗)只改SearXNG配置不改本仓代码
 - 查询先LLM改写再路由到配置的custom web/custom embedded引擎，引擎与嵌入模型按查询类型在设置里绑定
 - 检索结果先过本地embedding相似度重排再喂LLM生成带引用答案，引用URL随答案返回

### WechatSogou | https://github.com/chyroc/WechatSogou
 - 把验证码重试次数/代理做成WechatSogouAPI构造参数，反爬细节对调用方透明可调
 - README先写死平台数据边界(临时链接须有效期内落盘/每号仅最近10条群发)再讲用法，预期管理范式可直接抄
 - 返回dict列表+py2/py3双兼容+PyPI直装，接口零学习成本

### YaCy | https://github.com/yacy/yacy_search_server
 - DHT 式索引分片: 每个 peer 只持有一部分倒排索引(RWI), 查询路由到持份 peer 联邦聚合——联邦搜索在 P2P 层的原生实现
 - 内嵌 Solr 全文索引: 单 JVM 自带爬虫/索引/检索/管理界面, 零外部依赖即可 intranet 部署
 - 全部能力走 HTTP API(yacysearch.json 等), 上层聚合器可把一个 YaCy peer 当普通上游引擎接入

### awesome-selfhosted (search engines 分类) | https://github.com/awesome-selfhosted/awesome-selfhosted
 - 收录门禁机器可查: CONTRIBUTING 写死仅收 OSI 许可+活跃维护项目, bot 定期开 PR 剔除死链与停滞条目
 - 数据与展示分离: 每个分类自动生成独立 tags 页, 按渠道面垂直下钻, 清单本体保持单文件可 diff
 - 每条目固定字段 (许可证/语言/星数徽章/演示链接), 清单可被程序化解析直接进渠道注册表

### brave/brave-search-mcp-server | https://github.com/brave/brave-search-mcp-server
 - v1→v2 把图片搜索结果的 base64 数据剥离只留URL, 显著降低响应体积与上下文消耗——搜索MCP省token的教科书案例
 - 每工具独立 input/output schema 文件(src/tools/*/schemas), 输出契约代码化可回归测试
 - web/local/image/video/news 按结果类型分工具+细粒度参数(country/safesearch/offset), 单工具响应保持小而精

### browser-use | https://github.com/browser-use/browser-use
 - DOM快照只给可交互元素建索引再喂LLM, 页面信息按需供给控token
 - 多tab+会话/cookie管理内建, 登录态采集不用自己持久化
 - 自定义动作注册, 站点级高频操作沉淀为确定性函数减少LLM步数

### bx (brave-search-cli) | https://github.com/brave/brave-search-cli
 - bx context 用一次 API 调用替代 搜索→抓取→正文抽取 三步, 且输出按 token 预算裁剪, 直接为 RAG 上下文成本设计
 - 零依赖单二进制 + JSON 进出 + answers 子命令 JSONL 流式返回, agent 与脚本接入零胶水
 - web 子命令单独承载 site: 等搜索操作符, 与面向喂模型的 context 路径分层, 接口职责清晰

### crawl4ai | https://github.com/unclecode/crawl4ai
 - JsonCssExtractionStrategy 用CSS选择器schema直接抽JSON, 结构化抽取零LLM成本
 - CacheMode 显式缓存策略(BYPASS/本地/Redis), 重复抓取不重跑
 - Pruning/BM25 ContentFilter 在喂LLM前压缩页面, 控token预算

### ddgr | https://github.com/jarun/ddgr
 - omniprompt REPL 翻页按需拉取(按 n 才取下一页), 交互模型本身就是节流器
 - --json 自动切换非交互模式(implies --np), 同一工具同时服务人机交互与脚本取数两个场景
 - -p/--proxy 显式代理参数与 https_proxy 环境变量双通道, 出口 IP 管理开箱即用

### ddgs (duckduckgo_search 换代版) | https://github.com/deedy5/ddgs
 - 垂直方法(text()/news()/images())跨后端返回统一字段字典，上层换引擎零改码
 - 一包多形态: pip extras切换库/CLI/API服务/MCP服务四种交付
 - 代理优先: CLI与服务层内建全局socks5/http代理参数, 反封禁是一等公民设计

### ddgs (duckduckgo_search 继任) | https://github.com/deedy5/ddgs
 - backend 参数默认 auto 在多个搜索服务间自动轮换, 也可逗号显式指定后备顺序, 单上游被封不断供
 - 一个核心库铺四种取数面(CLI/python API/自托管 FastAPI 带 Swagger/MCP stdio), 按场景选面接入不必重复封装
 - 代理(http/https/socks5)与 timeout 作为库级一等参数逐调用可覆盖, 与 max_results/region/timelimit 组成细粒度配额闸

### ddgs (duckduckgo_search 继任者) | https://github.com/deedy5/ddgs
 - 多后端自动轮换聚合，backend 参数可显式指定单引擎，单引擎封禁时不改代码秒切
 - 同一个包内置 CLI(JSON 输出)、FastAPI 服务、MCP 服务三种暴露形态，脚本/HTTP/agent 三类调用方零胶水接入
 - 生成器 API 逐条产出结果+内建限速重试原语，长批量任务内存与节奏天然可控

### ddgs (原 duckduckgo_search) | https://github.com/deedy5/ddgs
 - 四面统一签名 (region/safesearch/timelimit), pip 单依赖零配置即用
 - 同一核心多部署面: 库/CLI/`ddgs[api]` FastAPI/`ddgs[mcp]` MCP server, 直接接进 agent 栈
 - backend 参数在多个搜索后端间切换并自动降级, 规避单引擎限流

### edoardottt/awesome-hacker-search-engines | https://github.com/edoardottt/awesome-hacker-search-engines
 - 按'情报对象/攻击面'而非字母序切分类, 每条目强制一行用途注释, 定位即查即用
 - 链接与格式经 awesome-lint/CI 持续校验, 五年保持月度更新节奏 (最近 2026-10-01)

### exa-labs/exa-mcp-server | https://github.com/exa-labs/exa-mcp-server
 - hosted-first 策略: 托管MCP为主+各客户端一键安装徽章, 接入摩擦降到一条URL
 - 把多跳 deep research 下沉为 server 端 agent 工具, 免去客户端编排多步检索链
 - 工具集可配置裁剪, 适配不同客户端的工具槽位预算

### felladrin/awesome-ai-web-search | https://github.com/felladrin/awesome-ai-web-search
 - 以'初始提交时间线'组织并链到每个项目的首个 commit SHA, AI 搜索产品演化谱系可追溯
 - 每条目附可直接点开的 Demo (多为 HF Space), 试用成本接近零
 - 开头显式声明三类用例分面 (摘要式搜索/函数调用联网/agent 报告生成), 读者按场景裁剪

### firecrawl | https://github.com/mendableai/firecrawl
 - 先 /v1/map 拿站点URL清单再选择性 /v1/scrape, 两段式避免盲爬全站
 - onlyMainContent 抽取开关只留正文, 天然适配LLM输入
 - 开源docker核+托管API同SDK, 起步用托管、规模化自托管零迁移

### firecrawl/firecrawl-mcp-server | https://github.com/firecrawl/firecrawl-mcp-server
 - 工具面分级供给: 全量26/免key 3/搜索专用8 三种profile, 精确适配客户端工具数上限
 - firecrawl_search 可挂 scrapeOptions 在同一次调用融合 SERP 结果与正文抓取, 省一跳往返
 - env开关裁剪反馈类工具+免key免费层(rate-limited), 拉新与生产两档清晰

### howdoi | https://github.com/gleitz/howdoi
 - 引擎抽象可插拔: -e 在 google/bing/duckduckgo/stackoverflow 间热切换, 单引擎反爬时改一个参数即恢复供给
 - -j 输出原始 JSON、-p 选第 N 条答案、-n 控制条数, 输出面专为 shell 管道设计
 - 本地答案缓存配 -C 一键清除, 重复问题不发请求, 天然降低上游配额消耗与封禁概率

### ihor-sokoliuk/mcp-searxng | https://github.com/ihor-sokoliuk/mcp-searxng
 - npx/Docker/HTTP 三种接线recipe按部署场景文档化, 同一server覆盖本地/容器/远程全形态
 - 显式信任模型: 要求用户自建或可信实例且开启JSON输出, server不代装元搜索引擎, 职责边界干净
 - OpenSSF Scorecard/Best Practices 徽章+MCP Registry 收录, 把供应链可信度做成工程指标

### modelcontextprotocol/servers (官方参考服务器, 含 fetch) | https://github.com/modelcontextprotocol/servers
 - 参考实现统一走 npx/uvx 单命令分发, 零克隆安装已是 MCP server 分发事实标准
 - 把依赖第三方凭据的参考实现拆去 servers-archived, 主仓只留无外部API依赖的核心集, 信任与维护负担最小化
 - fetch server 内置 SSRF 防护+重定向/超时控制, 是抓取型 MCP 工具的标准安全基线

### morphic | https://github.com/miurla/morphic
 - 生成式 UI: 服务端流式输出 JSON spec(带 schema 校验), 前端按 spec 渲染 React 组件而非纯 markdown, 引用与组件共生
 - 检索商抽象层: Tavily/SearXNG/Brave/Exa 用环境变量即插即换
 - 搜索结果唯一 URL 化(可恢复流), 长答案可分享、可断点恢复

### nickclyde/duckduckgo-mcp-server | https://github.com/nickclyde/duckduckgo-mcp-server
 - 超长结果URL折叠为 ref:// 短token、内容抓取工具直接回链token, 搜索型MCP省上下文窗口的巧招
 - 搜索与抓取双链路都内置rate-limit保护, 免key抓取的防封基线
 - uvx单命令分发+PyPI常驻包, Python系MCP分发范本

### perplexityai/modelcontextprotocol | https://github.com/perplexityai/modelcontextprotocol
 - 远程MCP与本地npm包同源双轨, 客户端是否支持remote server两头都兜住
 - 答案型检索(搜索+推理+引用一体)作为工具面, 与SERP罗列型server形成互补取数面
 - 超时显式环境变量化且默认放宽到5分钟, 长研究任务不被客户端默认值掐表

### punkpeye/awesome-mcp-servers | https://github.com/punkpeye/awesome-mcp-servers
 - 功能分区策展(检索类单独成节)+每条目标注实现语言与本地/远程部署属性, 可直接当选型横评底表
 - 与glama.ai等registry评分徽章联动, 收录项可跳转第三方交叉验证活跃度

### s | https://github.com/zquestz/s
 - 引擎注册表以 provider/tag 双维组织并支持部分名模糊展开, 一条命令可命中一类引擎(如 tech-news 标签全体)
 - --list-providers/--list-tags 配 -j 输出 JSON, 引擎清单本身可机读、可版本化, 便于自动生成渠道矩阵
 - 四 shell 补全脚本一条命令生成 + config.yml 与 shell 别名两层个性化, 覆盖高频查询的零输入成本

### tavily-ai/tavily-mcp | https://github.com/tavily-ai/tavily-mcp
 - 远程MCP支持 DEFAULT_PARAMETERS 头(JSON)注入全局默认参数(search_depth/max_results/include_images), 一次配置全工具生效
 - search/extract/map/crawl 四工具正交拆分, agent可按浅检索/深抓取分层选择调用
 - 远程+本地npm同源双形态, 兼顾免安装体验与自托管审计需求

### trafilatura | https://github.com/adbar/trafilatura
 - 多算法fallback链抽主内容, 不依赖LLM零token成本, 质量不达标自动换引擎
 - --precision/--recall 显式换挡: 检索入库求全、正文抽取求精
 - CLI原生 --parallel 多进程批处理, 落盘语料批量清洗一条命令

