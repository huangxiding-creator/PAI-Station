# NORTH STAR 盘型重算件（W2 · judge#1 修复 · 2026-10-30 深夜）

> **口径声明（数字零造假）**：本件从 northstar_hits.jsonl 原始行离线重算**能算的部分**；
> 盘级分布无法从原始行重算（行内无盘型/URL），照录 northstar_summary.json 的内存态权威值并标注。

## 一、从原始行可算（全部重算实测）

- 台账总行数：**548**（成功 392 + 错误重试 156）
- 命中总数（逐发 hits 求和，**未去重未分盘**）：3358
- 有命中发数（hits>0 的成功发）：233

| 源 | 发数 | 其中错误发 | 命中总数(hits 和) |
|---|---|---|---|
| tg_tgsearchers7 | 88 | 46 | 1254 |
| melost | 45 | 0 | 900 |
| panhunt | 48 | 5 | 430 |
| pansearch | 88 | 45 | 321 |
| hunhepan | 71 | 28 | 296 |
| mikuclub | 45 | 0 | 90 |
| bixin | 75 | 32 | 43 |
| naspt | 44 | 0 | 23 |
| miosou | 44 | 0 | 1 |

## 二、盘级分布（不可从原始行重算——照录权威值+口径）

| 盘 | 书数（去重/书口径） | 来源 |
|---|---|---|
| quark | 138 | northstar_summary.json（W1 内存态，非重算） |
| xunlei | 68 | northstar_summary.json（W1 内存态，非重算） |
| baidu | 45 | northstar_summary.json（W1 内存态，非重算） |
| uc | 15 | northstar_summary.json（W1 内存态，非重算） |
| aliyun | 34 | northstar_summary.json（W1 内存态，非重算） |
| 139 | 2 | northstar_summary.json（W1 内存态，非重算） |
| 189 | 1 | northstar_summary.json（W1 内存态，非重算） |
| 123 | 1 | northstar_summary.json（W1 内存态，非重算） |

**为何不可重算**：w1_northstar.py L52-57 只把 `[h.disk for h in hits]` 留在内存，
URL 与盘型均未落盘；jsonl 行的 `hits` 字段=该发命中数（不分盘）。
两口径本就不同（发级计数 vs 书级去重盘集合），不可互相换算。

## 三、病根修复（W2 生效）

1. `searchagg.py` 记账行新增 **disks** 字段（该发命中的盘型列表）——judge#1 修复；
2. `SearchLedger(hits_path=...)` 新增**命中 URL 归档位**（每命中一行 url/disk/light/source/kw）
   ——URL 永不再只留内存，后续北极星复跑可直接离线重算盘型分布；
3. 本件校验器：W1 行零 disks 字段=属实

## 四、一致性校验

- 行数 == summary.shots：PASS
- 错误行 156 == 548-392（BASELINE 口径对账）：PASS
- W1 行不含 disks 字段（病根实证）：PASS

## 五、结论

- 原始行可算面（发数/命中总数/逐源账）已全量重算如上；
- 盘级分布维持 W1 内存态权威值（quark138/xunlei68/baidu45/aliyun34/uc15/139:2/189:1/123:1）；
- 若需「原始行级盘型可重算」的正式复测，须另批搜索预算重跑北极星（W2 未动用搜索预算，遵循「别再搜索」令）。
