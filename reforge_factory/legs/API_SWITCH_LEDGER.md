# API_SWITCH_LEDGER — 逆向复刻件 API 优先切换台账 (1024 用户令)

> 令: 全渠道尽量避免浏览器自动化 — **API 优先、浏览器降级兜底**。
> 模式: 每处浏览器腿先调复刻件 (importlib 原文件加载, **复刻件本身零修改**);
> 复刻件抛错 (墙/配额/网错/依赖缺) → 降级原浏览器路径, 日志打印 fallback 原因。
> **原浏览器路径全部原样保留** (降级兜底铁律, 未删任何浏览器代码)。
> 记账: API 路径成功 → `ammo_pool/<campaign>/channel_invocations.jsonl` 追加一行
> (`tool` 字段带 `api_replica:` 前缀, 只增不改不删)。
> 冒烟纪律: 每改一处实测一次真实查询 (词面: 海外EPC / 海外工程 EPC), 数字零造假。

## 切换矩阵 (今日 6 复刻件 × 实测冒烟, 全部 2026-10-24)

| 渠道 | 复刻件 | 接入点 (文件:行) | 冒烟结果 (实测) | 降级条件 (fallback 触发) |
|---|---|---|---|---|
| wenku (百度文库, kb_harvest 渠道) | 逆向工程/wenku-search-reverse/replica/wenku_full_api.py | reforge_factory/legs/wenku_harvest.py:31 (harvest_api) + :118 (harvest 编排) | ✅ 「海外EPC」API 直出 **2 件全文 (2638字, type3 全覆盖)**, 零浏览器 (08:39 台账行) | 复刻件抛墙 (403/WAF)/零全文 (`full_n=0`) → harvest_browser (DrissionPage 原路径) |
| djyanbao (洞见研报) | 逆向工程/djyanbao-reverse/replica/djyanbao_api.py | reforge_factory/harvest_djyanbao.py:314 (run_api) + :421 (run 编排: API 优先) | ✅ 「海外工程 EPC」10 卡片 → 门后 **落 1 件 AI 摘要面 md** (另 7 件 <300 字如实跳, 2 件类型跳), 零浏览器零登录 (08:45 台账行) | DjAuthError/DjRateLimited(429)/网错/零卡片/全部过不了 300 字门 → DrissionPage 密码/扫码原路径 |
| sougo (搜狗微信) | 逆向工程/sogou-weixin-reverse/replica/sogou_weixin_api.py | .claude/skills/zh-search-pro/scripts/search.py:153 (_sogou_weixin_api_first) + :197 (search_engine 分派) | ✅ 「海外EPC」**3 条 mp.weixin 真链** (含公众号名+发布日期, /link 壳已解析), 零浏览器 (08:46 台账行) | SogouBlockedError (antispider)/网错/零命中 → 原 curl_cffi SERP 解析路径 (保留) |
| metaso (秘塔, metaso_free 渠道) | 逆向工程/metaso-reverse/replica/metaso_api.py | ResearchFactory-Eng/…/channels/metaso_free_channel.py:442 (_api_search) + :530 (collect L0 分支, 浏览器懒启) | ✅ 「海外EPC 工程风险」**answer 796 字 + 14 条来源引用**, 零浏览器 (08:47 台账行) | SSE 429/流中断/空回/warmup 失败 → DrissionPage 页内 fetch→L3 UI 抓包原三级链路 (保留) |
| cnki (知网) | 逆向工程/cnki-reverse/replica/cnki_api.py | ResearchFactory-Eng/…/channels/cnki_channel.py:33 (_api_collect) + :118 (collect L0 分支) | ✅ 「海外EPC」**15 条题录** (题名/期刊/年期/作者/关键词 + top3 免费面摘要), 零浏览器零 PaperDown (08:49 台账行; 首跑遇站点瞬时超时, 复跑即绿) | CnkiBlockedError(403)/网超时/零题录 → PaperDown cnki_pipeline 原管线 (保留) |
| website (商会官网 chinca.org, deep_crawl 渠道) | 逆向工程/chinca-reverse/replica/chinca_api.py (需 node 在 PATH, 本机 v25.2.1) | ResearchFactory-Eng/…/channels/deep_crawl_channel.py:238 (_chinca_api_get) + :300 (_fetch_html L0 分支) | ✅ 真实公示文 **27281B html** (acw_sc__v2 挑战 Node vm 求解 1 次即过, `browser_launched: False` 全程零浏览器) (08:50 台账行; 首跑用了不存在的文章 ID 得 1620B 壳页, 如实留账) | GateError(求解不进)/SolverError(node 缺)/网错 → httpx → DrissionPage 原两级回退 (保留) |

## 摸底结论 (无需改码的两处, 如实记录)

| 目标点 | 摸底结论 |
|---|---|
| kb_factory production_bridge (kb_factory/harvest_engine/production_bridge.py) | **已是纯 API, 无浏览器腿可切**: wenku 站走 WenkuMetaAdapter (syncmrecall 免登录, 与复刻件同端点族); book118 = 桥内唯一浏览器腿 (SafeLine 渲染, **今日无对应复刻件**, 留待逆向); doc88 = 选品端点未定 (NotImplementedError 如实跳过)。零改动。 |
| E:/AI-Station/微信小程序/zongbao-ai/tools/wenku_harvest.py | **不存在** (tools/ 目录 42 件全列, 无 wenku*/harvest* 件) — 任务书所记路径与现状不符, 未杜撰接入, 如实留案。 |

## 共用件

- **reforge_factory/legs/api_replica_bridge.py**: 复刻件登记表 + importlib 加载器
  (含 sys.modules 注册坑修复 / metaso 依赖预检 / SystemExit 防穿透) +
  `append_invocation()` 台账追加器 (寻址: 显式参数 > env `RF_API_INVOCATION_LEDGER`
  > ammo_pool/<campaign>/)。渠道腿 (无 campaign 上下文) 走 env 门控, 缺省零副作用。
- **台账实况**: ammo_pool/EPC-OVERSEAS/channel_invocations.jsonl 今日新增 7 行
  api_replica (6 渠道 + 1 条 chinca 首跑壳页如实行)。

## 冒烟遗留 (如实)

- corpus/wenku_harvest/api_20261024_083927/ + wenku_000/001.md: wenku 冒烟
  `--no-ingest` 留件 (未入池, 遵守「不动弹药池数据」红线; 未删, 删除只认用户令)。
- data/harvest/djyanbao/EPC-OVERSEAS/: 首跑「海外EPC」10 卡片全被面词门跳 →
  触发了一次真实浏览器降级 (离屏窗口, PLAN 跑 6 查询落 2 件 djyanbao:vip;
  profile 会话已复效, 1015 登录 blocker 实测解除)。已修补: `--queries` 现同样
  约束浏览器降级面。文件均为 staging (data/harvest), 不在池内, 未删。
- 意外发现 (利好): harvest_djyanbao 浏览器路径今日实测「已登录 (profile 会话
  复用)」且正常落件 — 1015 改版 blocker 已自然解除, 降级兜底链路是活的。

## 1026 增补: warehouse 数仓渠道 (P1-4 ETL 数仓, 世界顶级差距#3修复)

| 渠道 | 数据链 | 接入点 | 冒烟结果 (实测) | 说明 |
|---|---|---|---|---|
| warehouse (本地 ETL 数仓) | akshare 免费接口 → ETL → `data/warehouse/price_finance.db` (SQLite 四表: stock_financials / commodity_prices / macro_series / company_registry) | `data/warehouse/etl.py` (建仓+首轮ETL+verify) + `reforge_factory/legs/warehouse_leg.py` (查询→散文md→ingest engine=warehouse cred=research, 支持 --tree 挂树) | ✅ 首轮 ETL 实测行数见 `data/warehouse/etl_log.jsonl`; 冒烟「中国建筑近5年营收序列」实测行入 EPC-JIAGE (台账行 channel=warehouse) | 零浏览器零密钥 (免费宪法); 数字零造假 — 全部 akshare/SQLite 实测; 混凝土日线 akshare 免费面无序列=如实缺口不伪造 |

数据源 (全免费, akshare 1.19.3 @ E:/AI-Station/.venv): 央企财务
stock_financial_abstract(同花顺)+stock_zygc_em 海外收入(东财, 半年报频率);
材料价格 futures_main_sina 主力日线(新浪)+futures_spot_price_daily 现货月采样
(生意社100ppi)+macro_china_construction_price_index 建材指数(东财);
宏观 macro_china_ppi/macro_china_gdzctz(东财)+macro_china_nbs_nation
固投建安/建筑业总产值(国家统计局)。
渠道登记: channel_matrix.py CHANNEL_ALIASES 增 `warehouse: [warehouse, 数仓, 价格财务数仓]`
(1026); akshare 注册表键见 SURVEY_ALIASES (登记≠接线, 本条=接线完成)。

## 全渠道生产调度器 channels_dispatcher (1026 生产接线令 — S1 采集段标准入口)

> 令: 生产中使用起来 — **全部点亮渠道自动进每一份报告的 S1 采集产线, 取代手工编波**。
> 本件=编排层只建新件, 产线既有件零改动 (腿/芯/桥/池全原样调用; 腿全 API 零浏览器)。

- **件**: `reforge_factory/channels_dispatcher.py` (纯 stdlib) | **台账**: `reforge_factory/dispatch_ledger.jsonl` (phase=skip/run/summary, 只增不改)
- **CLI**: `py -X utf8 reforge_factory/channels_dispatcher.py --campaign <池> [--eeis Q1-E1,Q2-E3 | --kws 词1,词2] [--tags 标准,数据集] [--max-concurrent 4] [--rows 8] [--only 渠道1,渠道2] [--dry-run] [--force-rerun] [--list-health] [--include-shaped]`
- **路由**: question_tree EEI (缺省=未饱和 EEI) → channels_hint/dim/stance → 域标签 (标准定额/项目数据/学术专利/新闻舆情/工商招投标/数据集/通用网研) → 渠道 fit 标签 (api_replica_bridge.HTTP_ENGINES tags, 权威源 channels_survey_2026/MASTER_REGISTRY) 匹配 → 每渠道任务 `py -X utf8 legs/<engine>_leg.py --campaign X --queries <该域词>` (dangdang/metaso_kb/last30days 特殊 CLI 适配) → **进程池并发 ≤N** (每任务=1 腿子进程, 线程只等待) → 逐腿收 stdout 终态 JSON (hits/ingested/chars) + exit + dur
- **健康表** (内嵌, 证据逐条在案): 骨架=腿件 batch1025 标记动态读 (63 条) | 墙=WALLS 14 条 (冒烟矩阵台账 ammo_pool/<池>/channel_invocations.jsonl 1025 23:55–00:06 全腿冒烟波 60 行的 HTTP 终态: reddit 403×2/ddgs 403/marginalia×2+searx_space 000/gdelt×2+S2×3 429/unpaywall+reliefweb 410/gdacs 406/prozorro 404/ddgr CLI缺件) | 词面不匹配=QUERY_SHAPES 9 条 (事件流/目录/序列ID 端点不吃自然语言词, 派词=假调用, 如实跳过) → **墙与骨架自动跳过, 台账记 skipped+原因**; `--list-health` 一键全览
- **幂等**: campaign+渠道+查询 sha1 qhash 去重 (跑过的跳过, `--force-rerun` 破); ingest 并发安全走 ammo_pool 跨进程池锁 (1004 根治件)

### 首战实测 (1026 11:19–11:36, EPC-JIAGE, Q6-E3/Q18-E3/Q26-E3 三未饱和 EEI × 9 词, 并发 3)

- 渠道全集 **137** → 活 **51** | 墙 14 / 骨架 63 / 词面不匹配 9 | fit 标签路由后实派 **43 腿** (94 跳过全记账: 骨架63+墙14+词面9+fit不匹配8)
- 43 腿全 exit0 (42 主波 + last30days 外科重跑: 首跑 `--rows` 形参不兼容实测修) | hits **318** | 入池 **5 件 25,289 字** (bing_news_rss 3,601/datacite 12,386/nist 3,089/zenodo 3,701/wikipedia_api 2,512)
- 前一轮被中断波 (TaskStop 只杀壳, py.exe 孤儿续跑到 16 腿) 另实入池 11 件 23,765 字 (dangdang×7/datacite/google_news_rss×2/internet_archive) — 两波合计**新 pending 16 件 49,054 字**
- `judge --limit 1000`: **有效 12 件 47,817 字入门槛账** (67,211,643 → 67,259,460) | 废弃 4 件 1,237 字 (dangdang×3 substance<300 + internet_archive off_topic) | 留审 29=前腿断点文件缺失 (既有在案, 非本波)
- 数字零造假: hits/ingested/chars 全从腿 stdout 终态 JSON 实收; 零命中/失败腿如实记录 (如 27 腿零命中=中文规范词面在英文数据集 API 的如实回零)

**下一份报告产线的 S1 采集段标准入口 = 本调度器。**

## 1027 S3 出书链固化 — WPS 复刻排版入产线（用户令：从 WPS 逆向破解的专业排版进入生产链条）
- 新件 `reforge_factory/s3_book_chain.py`（16,843B，只增不删）：`--campaign/--chapters-dir/--title/--out-dir` 参数化一键链 ①合并②docx③**aipaiban 排版硬门**④PDF⑤幂等质检⑥产物清单；**排版失败=return 3 链中断、PDF 只从排版版 docx 出**（1022 宪法「合并完成必须排版·无绕行」条款代码化）；蓝本=第9份 `work/m2/overseas/s3_out_chain.py`（既有件零改动），腿件复用 `tools/report_to_docx.py` + `逆向工程/wps-ai-paiban/replica/aipaiban.py`（零云端）
- 排版轨（产线研报预设，同 `work/m2/report_paiban.py` 调用面）：`--preset beauty --toc on --page-numbers on --h1-break on --table-style three_line`
- 冒烟实测（campaign=EPC-OVERSEAS-SMOKE，第9份章源重放，出物隔离 `_backup_tmp/s3_book_smoke_1027`，正式件零接触）：合并 906,505B CJK=250,451（删元数据 2,092 字·逐章恰删 1 尾注+2 行说明块·幂等复跑零漂移）且 **sha256=0b5af12e495707fb 与第9份正式 REPORT_FULL.md 比特一致**；docx 449,528B / 排版版 455,016B+summary 1,213B / PDF 3,344,002B（三件与正式件同字节大小，OOXML/PDF 时间戳致 sha 不同——如实记）；PDF **Word 统计 341 页 = pypdf 实测 341 页**（第9份=341页）；排版 dry-run 复跑=incremental PASS；全链 PASS 65s
- 台账：`reforge_factory/s3_book_chain_ledger.jsonl`（只增不改）+ 每run `s3_run_manifest.json`；README 生产链条节已同步登记（S3 出书标准入口行）
- **S3 出书标准入口 = s3_book_chain.py（含 WPS 复刻排版硬门）。**

## 1030 增补: bdn 百度网盘检索下载渠道 (用户令: bdn CLI 接入调研渠道体系)

| 渠道 | 数据链 | 接入点 | 冒烟结果 (实测) | 说明 |
|---|---|---|---|---|
| bdn (百度网盘检索下载) | 自有 SVIP8 账号面 BDUSS 直连 (`bdn` CLI, 零遥测): xpan 全盘 search → 三层价值判定 (扩展名首选 .pdf/.docx/.xlsx/.md/.txt +100 / 次选 .doc 族 +40; 文件名×campaign tiers T1+60/T2+25/查询词+10; 尺寸门 8KB–200MB) → download (dlink 多线程+md5 校验+断点续传) 落 staging → ingest | `reforge_factory/legs/bdn_leg.py` (search→judge_entry 判值→download→staging/files→ingest engine=bdn cred=research, url=bdpan://<远端路径> 稳定去重) + 桥 `api_replica_bridge.py CLI_ENGINES["bdn"]` + 渠道册 `channel_manifest.json` named_channels (36 位, id=bdn) + `channel_matrix.py CHANNEL_ALIASES` (fit=数据集+工商招投标+通用网研) + 调度器 `channels_dispatcher.py` EXTRA_TAGS/build_cmd (下载预算收紧 3 件×100MB) | ✅ EPC-TOP50「工程总承包」: search 100 命中 (可下载面 93) → 判分 230 头部 3 件 PDF 全下载成功 (BIM 水利总承包应用 2.93MB / 集成计价模式 2.10MB / 风险控制 1.57MB, pypdf 抽文真期刊全文) + 命中面简报 → 入池 4 件 23,723 字 → judge **4/4 有效 0 废弃** → 门槛账 60,948,716→60,972,439 (+23,723), T1 直接层 183,789→207,512 (41→45 件), 信源域 162→163; by_engine[bdn]=23,723; C 轴 bdn 点亮 (channels_hit 8→9, miss_not_invoked 清空 green=true) | 铁律: 只 search/download (子命令白名单代码化), **不转存/不分享/不删**; 下载物一律落 `staging/bdn/<ts>/` 再入池; 凭据走 bdn 默认 `data/secrets/bdn_credentials.json` (gitignored, 密钥零进仓); 数字零造假 (hits/字数全 CLI 实收) |

.bak 三件先行: `channel_matrix.py.bak_1030_pre_bdn` /
`api_replica_bridge.py.bak_1030_pre_bdn` / `channel_manifest.json.bak_1030_pre_bdn`
(+ `channels_dispatcher.py.bak_1030_pre_bdn`)。腿件 --num 兼容 --rows 别名,
下载预算 --download-limit 全程总口径 (跨查询远端路径去重)。
