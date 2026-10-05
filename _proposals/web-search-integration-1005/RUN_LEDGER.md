# RUN_LEDGER — Arc L: 网页搜索 skill/开源项目全网扫荡×最优做法整合 (1005)

> 用户令 (语音转写校正): 「使用全局最新 super-skill。搜索 GitHub 及网络上网页搜索的 skill 与开源项目, 调研收集不少于 100 个。选出最优秀的项目及其优秀做法, 全部整合进本项目调研收集渠道并注册。」

## 交付物一览

| 产物 | 位置 | 状态 |
|---|---|---|
| 第26渠道 search_library 注册表 (119项) | `ResearchFactory-Eng/EPC100/collectors/search_library/projects.py` | ✅ 生成+测试 |
| 打通测试器 (repo双腿/service真查/key_required只探文档面) | `ResearchFactory-Eng/EPC100/collectors/search_library/verify.py` | ✅ 含 gh-proxy api 镜像腿 |
| 账本腿 + conductor 入队 | `.../search_library/ledger.py` + `cli.py` + `__init__.py` | ✅ |
| 主链接线 (leg + 完备门具名集) | `EPC100/collectors/epc100_channels.py` | ✅ compile OK |
| 渠道注册 (26th named) | `EPC100/../channel_manifest.json` (named 25→26) | ✅ |
| 最优做法蒸馏 (用户令核心) | `_proposals/web-search-integration-1005/BEST_PRACTICES.md` | ✅ 七主题+SEARCH-1..5 工单 |
| 测试 15 条 (零真网) | `EPC100/tests/test_search_library.py` | ✅ 15/15 passed |

## 扫荡战役数字

- **8 角度 Workflow 并行扫荡** (super-skill Ultracode): 元搜索/自托管引擎、AI搜索研报管线、MCP检索服务器、CLI工具、抽取后腿、中文检索、清单策展、API wrapper
- raw **140** (125 扫荡 + 15 审计补收) → batch_dup 剔除 **28** (跨角度重复 + org 更名别名) → 候选 **111** + 本机在册 **8** = 注册表 **119**
- 审计嫌疑人 25 条对抗性裁决: dup 类跳过, 无真实死链/离题实锤 (audit 理由文本有复制错位, 按 ebook 案卷纪律对抗性采信)
- 低质观察名单 17 条: **留册不静默剔除** (Whooogle 等由 verify 轮 star 证据裁决)
- org 更名归一: mendableai/firecrawl→firecrawl/firecrawl, ItzCrazyKns/Perplexica→…/Vane (双键去重门继承 Arc K, path strip("/") 两侧修补)

## 注册表结构 (119 项)

| cat | 数 | 说明 |
|---|---|---|
| metasearch | 22 | SearXNG/Marginalia/Mwmbl/YaCy/searx_space 实例目录… |
| crawler | 18 | trafilatura/crawl4ai/Docling/MarkItDown/Jina Reader… |
| ai_search | 17 | STORM/GPT-Researcher/Vane/Scira/morphic/Open Deep Research… |
| key_required | 15 | 只探文档面, 永不触计费端点 (免费优先铁律) |
| cli_tool | 11 | ddgr/howdoi/bx/s/… |
| zh_search | 9 | 含中文引擎面 |
| mcp_server | 9 | 官方参考服务器/mcp-searxng/… |
| api_wrapper | 4 | ddgs 等 |
| awesome_list | 6 | 清单工程参照 |
| existing | 8 | 本机在册 (zh-search-pro/cli_serp/cli_fetcher/opencli/zh_search_pro/websearch/metaso/court) 零探针 |

- tier1 深验席 10 席全部免费无键: searxng/openverse/marginalia/mwmbl/searx_space/ddgs/jina_reader/trafilatura/howdoi/ddgr
- quality=high 项 ≥30 全部携带 practices 字段 (优秀做法随注册表机读化)

## 打通判据 (工具域版, 有别于 ebook 站点域)

- **repo**: api.github.com 元数据 (stars/lang/pushed_at) **+** archive.zip Range 0-1 PK 魔数 (直连→gh-proxy 镜像→codeload 三梯) → 双腿得 **verified**; 单腿 live
  - 本机 IP api.github.com 匿名 60/h 限额 → **gh-proxy.com 同样镜像 api 面** (实测 200), verify_github_repo 加 api 镜像腿
- **service**: 探活+标题; tier1 加发真实查询 (结果 JSON 落 `F:\ZBZK\downloads\searchlib\_verify_samples\`) → verified
- **key_required**: 只探文档/官网面 → registered
- **existing**: 零探针, 状态 existing (自家资产已实证)
- 网络: 直连→系统代理双梯, 站间 1.2s 节流, IDN punycode, 报告原子写+only_ids 增量合并

## 测试抓出的生产 bug (金标准价值)

1. `body[:1] == b"PK"` — 1 字节切片永不等 2 字节字面量 → 生产中所有 repo 会永远 live (修 [:2])
2. `_zip_range` 自建 opener 绕过 http_get 注入缝 → 测试真网泄漏 (修: 统一走 http_get)

## 工单 (BEST_PRACTICES.md 接线计划)

SEARCH-1 SearXNG 自托管 JSON 网关 · SEARCH-2 ref://短token+预算裁剪 · SEARCH-3 本地结果缓存 · SEARCH-4 CSS schema 解析器 · SEARCH-5 learnings→E-OSCAR。优先级排在渠道额度最大化令之后, 按 conductor 节奏排期。

## 验证轮 (终态)

- 轮1 (旧码, api 直连 60/h 限额): 46 verified / 47 live / 10 registered / 8 unreachable / 8 existing
- 轮2 (gh-proxy api 镜像腿新码, 104 repo 项增量重跑, 只_ids 合并): **88 verified / 5 live / 15 registered / 3 unreachable / 8 existing**
- 定点补测 3 项 (topics 页 ptype 修正 site / searx.space 服务面重试): 终态
  **88 verified / 7 live / 1 unreachable / 15 registered / 8 existing = 119**
- 镜像腿净转化: 42 项 live→verified; key_required 5 项文档面复测转 registered
- 唯一 unreachable: `searx_space__searx_space` (searx.space 站点 CN 侧不可达; 其实例目录功能由 github 仓腿 live 兜底)
- live 7 项全部可解释: gitlab/codeberg 锻造场 3 项 (repo 验证梯 github 专用→单腿 live 属设计) + topics 发现页 + searx-space 仓面 + jina_reader/openverse 单腿
- star top5 实拉: awesome-selfhosted 323.9k / firecrawl 188.6k / markitdown 188.4k / open-webui 153.9k / browser-use 117.1k
- 注册表修正一轮: `github.com/topics/search-engine` 误标 repo ptype (api.github.com/repos/topics/... 必 404) → 改 site 探活, gen 脚本重生成 (119 不变)
- 报告: `EPC100/data/search_verify/verify_report.json` (gitignore 内运行时态, 不入库)

## 纪律遵守

只探测不动网 / 免费优先 (计费端点零探) / 高风险域名 blocklist 出队闸照旧 / 只增不删 / commit 带 Co-Authored-By / 推送等用户明示令 (推必带百度备份)
