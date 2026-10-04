# RUN_LEDGER — 第22/23渠道双交付 (pansou + ChinaTextbook)

- **日期**: 2026-10-04
- **令源**: 用户两连令（Arc F: pansou 注册调研渠道 / Arc G: ChinaTextbook 整合调研渠道）
- **形态**: 渠道注册（github项目转技能+渠道双交付 doctrine, 1003 定型）
- **落点**: ResearchFactory-Eng `EPC100/collectors/pansou/` + `EPC100/collectors/chinatextbook/`，named_channels 21→23
- **编号收口**: 同日发现 zh-search-pro（夜班会话建成时自称第22但未入册）→ manifest 补录为第24条，22/23 维持 pansou/chinatextbook 注册时序（commit 9b149f5）

---

## 第22渠道 pansou (网盘聚合发现)

| 项 | 值 |
|---|---|
| 上游 | fish2018/pansou (Go, MIT, 14776★) |
| 部署 | 源码构建 `EPC100/services/pansou/pansou.exe` (Go1.25.14 静态 30MB, 本机 :8888 常驻) |
| 工具链坑 | go1.27 与 sonic v1.14 不兼容 (`GoMapIterator` undefined) → 降 1.25.14 全绿; GOPROXY=goproxy.cn; CGO_ENABLED=0 |
| 引擎 | TG 56频道 + 插件5白名单 (labi/zhizhen/shandian/duoduo/muou) |
| 风险线 | 白名单排除账号型/成人盗版/裸IP; 永不 refresh 绕缓存; AUTH_ENABLED+JWT; 30s/300/900s/10 节流四件套; 24h 词去重 |
| 定位 | 发现+链接留档, 不下载/不转存/不分发文件本体 |
| 实车判据 | health ok(56频道/5插件/状态ok) · 三体15命中(uc/aliyun/quark/baidu) · 15卡入册 · conductor J1072315270 heavy 窗入队 · 账本 run ✅ 五连过 |
| 契约修正 | `/api/health` 无信封直回(信封检测按 code 键有无分流) — 实车才暴露 |
| 稀疏事实 | 白名单5插件偏文娱密度: 工程词(工程总承包/考研)0命中为诚实空; 文娱词(三体)15命中 |
| 运行态隔离 | `EPC100/services/` 整目录 gitignore (exe/auth.env/pid/cache) |

## 第23渠道 chinatextbook (全套教材语料库)

| 项 | 值 |
|---|---|
| 上游 | TapXWorld/ChinaTextbook (82520★, 43.5GB, master 分支, License=None) |
| 目录 | `git/trees/master?recursive=1` 单调用全树(3112条/truncated:false), 网络败退 1004 离线种子 `tools/downloads/ctb_tree.json` |
| 规模 | 2087 册 (1905整书+182分卷组); 路径分类学 L1学段→L2学科→L3版本-出版社→L4年级 |
| 取书 | raw.githubusercontent ↔ gh-proxy.com 双梯(实测 200+Range); codeload 422 死路 |
| 分卷根治 | 官方 mergePDFs.go `sort.Strings` 字典序在 ≥10 卷组必坏(上游实存 pdf.11 组) → 整数后缀排序+纯字节拼接+%PDF魔数/字节和双校验 |
| 定位 | 存量语料引用(弹药门槛语义: 不计门槛, 成稿可引用); License=None → 小段引用+页码溯源, 不转存分发 |
| 实车判据 | api源刷目录2087册 · 高中∪数学693册 · 90KB答案卷字节精确落盘 · 2卷组48,068,561字节合并双验 · conductor net:ctb 入队+账本 run ✅ 五连过 |
| 带宽实态 | raw 直连 CN ≈105KB/s(48MB书7.6min) → 小书优先+limit 3+heavy 夜窗已内建 |
| P1 缓行 | 国家中小学智慧教育平台腿: s-file-1 JSON 匿名可达但 r1/r2/r3-ndr-private PDF 401, 需用户 ND_UC_AUTH(7d TTL)+X-ND-AUTH MAC 签名 — 等用户给凭据再启 |

## 接线与验证

- `epc100_channels.py` 主链两腿(try/except 隔离) + named set + coverage 完备门
- `channel_manifest.json` named 21→23 (pansou/chinatextbook 各一条)
- 单测 18+12=30 件新增; 全套 **271 passed** (10.1s)
- conductor: pansou→`api:pansou` / chinatextbook→`net:ctb`, 均 heavy 窗, 幂等入队
- 对抗性审查: 三维(correctness/security/ops)评审+逐条反驳验证 workflow (wf_13816ec8) — 结论见本档追加节

## 追加: 对抗性审查结论 (wf_13816ec8, 16 agent / 312 工具调用 / 83万 token)

三维评审 (correctness/security/ops) → 29 发现 → 逐条对抗验证 → **9 实锤 / 4 反驳**，9 处全修 (回归测试 9 件，271→279 全绿):

| # | 级 | 位 | 实锤 | 修法 |
|---|---|---|---|---|
| 1 | high | ctb/fetch | safe_name 只取 basename: **310/1905 整书跨版本同名** (数学一年级上册×7 版社), 同批下载静默互踩——报告 3 册实际盘上 1 册还可能引错版本 | 分类学前缀 (学段_学科_版本_年级_书名) + path 短哈希后缀, Windows 非法字符清洗 |
| 2 | med | pansou/discover | 坏档 (截断 JSON) → `_load` 吞 ValueError 回空骨架 → 下次写盘**静默清空全部链接卡** (只增不删不变韧) | 坏档改名 `.bad` 隔离+抛错拒回写; 同修 chinatextbook/catalog |
| 3 | med | ctb/cli | throttle 只接 pace 没接 record_ok/failure → **日限/熔断/冷却全部空转** | record_ok/record_failure 接通 + CircuitOpen/DailyLimit 捕获→blocked |
| 4 | med | pansou/discover | 整轮全败 (failed=4, queried=0) 被记成 empty「真实空」 | failed 计数 + status_from_report: 全败=error |
| 5 | med | pansou/service | ensure_auth 只认 USER → 缺 JWT_SECRET 半档走通 → 空密钥落上游默认=**可预测时间戳密钥** | 三件套 (USER+PASS+JWT_SECRET) 齐全才认档 |
| 6 | med | ctb/fetch | safe_name 不洗 Windows 分隔符/绝对名, 上游树路径可越出 out_dir | 并入 #1 清洗 |
| 7 | high | pansou/service | stop_service 盲 taskkill /T /F 陈 pid → **重启后 pid 复用误杀无辜进程树** | tasklist 验身 (pid 活着且映像=pansou.exe 才杀) |
| 8 | med | pansou/service | start 无锁 → check-then-act 双起服竞态 | O_EXCL start.lock (站内 CIM 同款范式), finally 释放 |
| 9 | med | 两边 | 非原子 write_text: 崩在半写=坏档, 叠加 #2 即数据丢失链 | tmp+os.replace 原子写全落位 |

反驳 4 件 (不修): conductor topic 注入 (内部数据非对抗面)、SAFE_PLUGINS 运行时核验 (启动 env 已控)、cmd_fetch 不接熔断 (修 #3 后才可达, 已随修)、分卷断点续传 (v1 重跑可接受, 3s 节流在)。

**另预修 1 件**: fetch_blob timeout 180→600s (raw 直连 CN 105KB/s 实测 47MB 卷需 450s)。

修后实车复烟: 279 全绿 + 停 (pid 验身 taskkill) → 起 (56 频道/5 插件/auth/ok) 周期正常, 目录 15 卡完好。

## 第25渠道 ebook_library (电子书渠道族: 两篇文章111站纳册+打通) — 1004

用户令弧线 (1004 当天三段演化): ①「文章提到的电子书渠道都纳入」→ ②「资源都下载下来」→ **③终版三连令「不是现在下载, 要去测试把渠道打通; 搞通之后注册」**。落位语义 = 打通+注册, 不批量下载。

| 维 | 事实 |
|---|---|
| 来源 | 公众号「弗专书馆」两篇 (原文+URL抽取存证 `ebook_sources/`): a1 GitHub高赞书库14条 + a2 免费电子书网站101条, 编号101全验证, 去重后 **111 渠道实体** |
| 注册表 | `EPC100/collectors/ebook_library/sites.py` 唯一事实源: 7分类 (official 10/public_domain 6/open_repo 14/aggregator 15/portal 38/login_required 4/piracy_suspect 24) + 三态 status (enabled/registered/disabled) |
| 打通判据 | tier1 深度打通 (14 bulk 源): 目录/清单 API 实拉 + codeload-Range/OPDS/CSV 取数路径实证 + 单样本落地 (最强真判据, `_verify_samples/`); 其余探活+首页语义; 已有专渠道 (ebook-treasure/weread/smartedu) 站活即 verified |
| 风险线 | 盗版嫌疑 24 站禁触不发一包 (高风险规避 9-23 令); 无争议 4 域名 (zxcs.info/sobooks.cc/oceanofpdf.com/flibusta.is) 入 `domain_blocklist.json` — conductor 出队闸全渠道即生效 |
| 网络纪律 | 直连→系统代理双梯 (只探测不动网); 全匿名单发 1.2s 节流; IDN (烟海.中国) 直接试错如实记 |
| 接线 | epc100_channels.py 主链腿 (try/except 隔离) + named set + manifest named 24→25 通道 (site_endpoints +111=1352) + conductor `net:ebooks` (window=any, 白天令) |
| 测试 | `test_ebook_library.py` 18 件: 注册表完整性/盗版永不下载/blocklist一致性/CSV状态机/tier1四验证器(fake网)/盗版零探针/账本腿(fake conductor); 全树 **297 passed** |
| wave2 待打通 | taiwanebook API / 书格+国图古籍策略 / kanripo 选择性 / ideahub 82分卷外链结构 / forgottenbooks 抽样 |
