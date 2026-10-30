# W4 终验 QA 台账（2026-10-30 深夜 · 全命令面活测）

> 预算铁门：≤40 发 + 1 下载件 ≤50MB。实耗 **40 发整 / 1 件 21.8MB**，踩线不超。
> 零凭据零删除零 git；一切数字出 ledger/JSONL 实测行计。

## 一、命令面结果表

| 命令 | 输入 | 结果 | 发数 | RC |
|---|---|---|---|---|
| search（全 9 源） | 民法典 | 命中 44（去重，22s）；盘型 quark40/baidu2/aliyun2/xunlei1；交付层 0（该词无绿盘链，如实） | **12**（含 3 代理重试；逐发 analysis/search_ledger.jsonl） | 0 |
| search（--source 限 4 源 --json） | 水电站 施工组织 | 命中 21 JSON 面过（disks quark15/xunlei5/aliyun1） | **5** | 0 |
| discover（绿链=路由拒收） | drive.uc.cn/s/bc44626af1384 | 「非五盘发现层链接」正确拒收 | 0 | 2 |
| discover（黄链·死链判死） | pan.quark.cn/s/9acf52b87ed5 | dead:失效 code=41031 分享者封禁（W2 时还活——链接半衰期现场实证） | 1 | 0 |
| discover（黄链·死链判死） | pan.quark.cn/s/6820e128aee1 | dead:失效 41031 | 1 | 0 |
| discover（黄链·活链列表） | pan.quark.cn/s/10df00dde0d3 | **ok/存活/100 项全名全尺寸**（千锋 Python 教程，001 105.16M…） | 3 | 0 |
| download（绿盘真件复现） | lanzoui.com/b073dnr7g → w1_downloads/w4qa/ | 50 项列表→选中 21.8MB→直链→落盘 **22,888,747B sha1=21708B6CFA73D8EEE242BA12469F73BC202A453E（与 W1 门件逐位一致）**；审计行自动落 download_audit.jsonl | 5（链内步骤计：filemoreajax+文件页+ajaxm+el=2+CDN；adapter 无记账器口径=HTTP 请求数） | 0 |
| gates | — | W1_GREEN_GATES.md 全文出（5/10 绿台账） | 0 | 0 |
| doctor | — | 盘矩阵 10（灯全对）+发现层 5+插件 2 全 off（凭据在位不加载） | 0 | 0 |
| health_round | 默认探针词 | **活源 6/9**：melost20/naspt6/pansearch55/tg22/bixin1/miosou4 LIVE；mikuclub ALIVE_EMPTY；panhunt HTTP_0↓（当日漂移）；hunhepan 429 限速 → analysis/health_rounds/20261030_204307.json | 13 | 0 |
| MCP 自测（scripts/mcp_selftest.py） | spawn 子进程 stdio | 4/4 PASS：initialize→serverInfo+capabilities.tools / tools/list→三工具齐 / **tools/call doctor→disks=10 discovery=5 plugins=2 isError=False** / 未知方法→-32601；子进程退出码 0 | 0 | 0 |

## 二、预算账

| 腿 | 发数 |
|---|---|
| search 词1（9 源） | 12 |
| search 词2（4 源限源） | 5 |
| discover 黄×3 链（1死+1死+1活） | 5 |
| download lanzou 链 | 5 |
| health_round | 13 |
| discover 绿链路由/gates/doctor/MCP 自测 | 0 |
| **合计** | **40 ≤ 40** ✓ |

下载件 1 件 21.8MB ≤ 50MB ✓（新目录 w1_downloads/w4qa/，未覆写任何 W1 门件）。

## 三、法务落件验证

- **审计位**：analysis/download_audit.jsonl 首行实测=
  `{"ts":"2026-10-30T20:41:34","url":"…b073dnr7g","disk":"lanzou","file":"qBittorrentEE_v5.2.4.10_x64_便携版.zip","bytes":22888747,"sha1":"21708B6C…","purpose":"research","out":"w1_downloads\\w4qa\\…"}`——七字段全落。
- **README 免责与边界**：六条（公开分享面/不含付费墙破解/收割物仅调研语料不进付费交付物/不建公开索引/凭据零托管/数字以台账为准）已上线。
- **插件态**：doctor 实测两插件全 off、凭据只显存在性；MCP doctor 同口径。

## 四、如实记录（不粉饰）

1. search 两词交付层均 0 条绿盘链——绿盘稀缺（北极星 7.5%）的生态事实，命令如实分栏不造数。
2. 夸克语料前 2 链已死（41031）——W2 至 W4 间隔一夜即漂移，链接半衰期与源半衰期（判例4）互证。
3. panhunt 本轮 HTTP_0↓（上轮 LIVE）——源名单按 6/9 最新口径，下轮健康轮复核。
4. health_round.py 首行 SyntaxWarning（W3 遗留 docstring 转义，纯外观不影响运行，未动 W3 原件）。
