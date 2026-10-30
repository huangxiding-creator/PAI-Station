# PAN-HUNTER W0 源效度审计报告（2026-10-30）

> 出口硬门产物：实测活源数基线。覆盖叙事自此从「122 配方」改为「实测 N 活源」。
> 数字零造假：全部数字来自本日本机实测（JSONL 台账 analysis/source_audit_1030.jsonl 逐发可查）。
> 频控合规：单源并发=1、同源间隔≥2s 随机抖动、全源并发≤4、总发数见 §3。

## 1. 架构裁决：pansou 作配方库，不作运行时

**裁决**：克隆的 fish2018/pansou（MIT，engine/pansou/ 冻结副本，122 插件全量）只作**源配方库**摘录；
源中枢自建：Python 3.13 + curl_cffi（engine/sourcehub/），harvest_engine 适配器骨架风格。

**取舍证据链**（三独立证据，任一即足以定案）：

1. **运行时形态本机双缺**：README 部署形态仅两种——Go 1.18+ 源码编译 或 docker（ghcr.io/fish2018/pansou）。
   本机 go✗、docker✗；GitHub releases 为空数组（无预编译二进制，api.github.com 当日实查）。
   走运行时=先装整套 Go 工具链或 Docker Desktop（系统级变更，约百 MB 级），投入/回报倒挂。
2. **pansou 自身无 TLS 指纹伪装**：util/http_util.go = 裸 Go net/http + tls.Config{InsecureSkipTSVerify 选项}，
   全仓无 utls/ClientHello 定制。R2 反爬地形头号敌人=CF TLS 指纹墙（本日再证，见 §2），pansou 运行时
   对墙源与 curl 同样无解；curl_cffi impersonate 才是站内已证的过墙武器。**运行时买不来过墙能力。**
3. **配方→Python 翻译是机械活**：122 插件=122 个单文件 Go 配方（endpoint/参数/头/解析逐行可摘，
   本日已译 37 源零猜测）；站内 L2 已定 harvest_engine Python 骨架，源中枢同栈避免 Go/Python 双语言分裂。
   TG 腿（t.me/s/ 频道爬）与二级缓存均轻件，不值得为此背一个 Go 运行时。

**保留义务**（配方库路线的代价，如实记）：pansou 上游月度增量合并（宪法 L1 已定）；
插件内 Go 侧解析细节（如 clmao GBK 编码）在翻译时逐条核，不照抄盲跑。

## 2. HTTP 层定案（对照实验，scripts/http_layer_verdict.py）

同 URL 四象限对照（2026-10-30 本机，UA=Chrome131，impersonate=chrome124）：

| 源 | requests+直连 | requests+代理 | curl_cffi+直连 | curl_cffi+代理 | 结论 |
|---|---|---|---|---|---|
| yunso | ReadTimeout ✗ | **200** 44.7KB | **200** 44.8KB | **200** 44.8KB | **TLS 指纹墙**：requests 直连死、curl_cffi 直连活——curl_cffi 定案证据 |
| pansearch | ConnectionReset ✗ | **200** 33.5KB | SSLError reset ✗ | **200** 33.5KB | **路径墙**：直连双死、代理双活——代理腿必要性证据 |
| yiso | 403 CF oldie | 403 CF oldie | 403 CF oldie（chrome124/131/safari17_0 三指纹+http1 均试） | 403 | **CF 托管质询**：指纹免疫，需浏览器栈（DrissionPage，W1+/W3 腿） |
| haisou | RemoteDisconnected | — | h2 reset | h2 reset / v1 超时 | 三路全死=站死或硬墙，记死源 |
| funletu | — | 404（noVerify 后） | — | — | 站转型（R1 预警的 fireoa 变身实锤） |

**定案**：源中枢 HTTP 层=curl_cffi impersonate 直连优先 → 网络层失败单发代理重试（即用即弃）→
CF 托管质询源挂浏览器栈腿（W3）。requests 仅作对照，不入产线。

## 3. 全源审计（3 关键词 × 38 配方源，2026-10-30 实测）

关键词：民法典 / 水电站 施工组织 / 机器学习。跑批 204s，**149 发**（含代理重试与 TG 腿；频控三律全合规；
另本日 HTTP 层对照实验 ~35 发，全天合计 ~184 发，600 硬顶内）。逐发台账 source_audit_1030.jsonl。

### 3.1 逐源判定表（括号=实测命中条目数；完整表见 analysis/audit_section3.md）

| 判定 | 源（关键词命中） |
|---|---|
| **活源 LIVE*（9）** | melost(20/20/20) · mikuclub(96/96/96) · panhunt(12/0/44) · hunhepan(10/10/10) · naspt(2/0/3) · pansearch(2/壳/4) · tg_tgsearchers7(3/0/0) · bixin(1/1/1) · miosou(SSE 1/壳/1) |
| 活而零命中（9） | yunso · zhaozy · susuifa · ouge · leso · quark4k · quarksoo · lingjisp · clmao（200 活站，该三词无货或结果 JS 渲染，配方待 L2 深挖） |
| SPA 壳（4） | haitunsou · xuebapan · yuneu · panyq（200 但首响应无数据/门票模板已变） |
| CF 质询墙（5） | aipanso · kkmao · pan666 · ting77 · miaosou（指纹免疫，待 W3 浏览器栈腿） |
| 行为反爬（2） | sousou · sopanya |
| 死源（9） | haisou · jikepan · squark · upyunso · sdso · erxiaopan · panta · meitizy · funletu（404 站变） |

### 3.2 基线汇总（数字零造假）

- verdict 行分布：LIVE_JSON 13 · LIVE_HTML 6 · LIVE_SSE 2 · ALIVE_EMPTY 31 · ALIVE_SHELL 12 · CF_CHALLENGE 12 · ANTICRAWL 6 · DEAD 24（106 行=34 源×3 词+4 墙源×1 词）
- **实测活源 = 9 / 38 配方源；LIVE 总命中条目 = 453（3 关键词合计）**
- 直连被墙、代理可救 = 9 源：tg_tgsearchers7 · yunso · hunhepan · pansearch · bixin · susuifa · ouge · xuebapan（+zhaozy 部分）——20 源触发代理重试，9 源由此通路
- r2 A 级 3 直调源全部复证 LIVE ✓；GAP A12 未核批 7 源全部本日核毕；GAP A13 复测批全部定性
- melost 响应结构已变（search_result→list，total=1549）；aipanso/pan666/kkmao/ting77 自早间探针后已被 CF 升级为质询（同日漂移实证）

### 3.3 覆盖叙事口径（出口硬门兑现）

旧口径「122 配方」废止。新口径：**38 配方源实测 9 活源 + 9 活而零命中源（L2 深挖池）+ 5 CF 质询源（W3 浏览器栈转正池）**；
TG 腿=t.me/s/ 代理通道（默认频道 tgsearchers7 实测 3 命中）。122 插件中其余 ~84 个影视站插件不在泛盘检索
口径，W1 起按需增译。doctor 命令直接复用 core.run_audit 管线（本审计即健康轮 v0）。

### 3.4 与调研预期的对账

- r2 A 级（naspt/melost/panhunt）：复证 LIVE ✓
- r2 B 级「000 需代理复测」批（GAP A13）：yunso/pansearch=代理通；haisou/jikepan=死；funletu=404 站变
- GAP A12（ting77/quarksoo/lingjisp/meitizy/leso/miosou）：ting77=CF 墙、quarksoo/lingjisp/leso=活零命中、meitizy=死、miosou=SSE 活源（Anubis 门未拦）
- 意外收获：hunhepan/miosou/bixin/mikuclub 四源超调研预期直接转正活源

## 4. 遗留与移交

1. aria2 缺位（deferred）：W1 下载层先 parfive 2.3.1 顶，aria2 RPC 伴生进程 W1 再装（磁力/ed2k 腿依赖它）
2. CF 质询 5 源 + 行为反爬 2 源：W3 DrissionPage 浏览器栈腿（站内默认栈）
3. 活而零命中 9 源：多为结果 JS 渲染或需站内二次 API，W1-L2 逐源深挖（yunso 已见 44KB 数据在 JS 层）
4. pansou 上游月度增量合并义务（宪法 L1）：首次合并排 W1 末
5. 本日漂移实证两例（melost 结构变、aipanso CF 升级）→ 健康轮周期建议 ≤7 天

