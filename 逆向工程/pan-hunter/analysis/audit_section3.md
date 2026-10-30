### 3.1 逐源判定表（关键词=民法典 / 水电站 施工组织 / 机器学习；括号=实测命中条目数）

| 源 | 民法典 | 水电站施工组织 | 机器学习 | 判定 |
|---|---|---|---|---|
| naspt | LIVE_JSON(2) | ALIVE_EMPTY | LIVE_JSON(3) | 活源 |
| melost | LIVE_JSON(20) | LIVE_JSON(20) | LIVE_JSON(20) | 活源 |
| panhunt | LIVE_JSON(12) | ALIVE_EMPTY | LIVE_JSON(44) | 活源 |
| haisou | DEAD | - | - | 死源 |
| sdso | DEAD | DEAD | DEAD | 死源 |
| sousou | ANTICRAWL | ANTICRAWL | ANTICRAWL | 行为反爬 |
| funletu | DEAD | - | - | 死源 |
| tg_tgsearchers7 | LIVE_HTML(3) | ALIVE_EMPTY | ALIVE_EMPTY | 活源 |
| miaosou | CF_CHALLENGE | - | - | CF 质询墙（待浏览器栈） |
| jikepan | DEAD | DEAD | DEAD | 死源 |
| yunso | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| sopanya | ANTICRAWL | ANTICRAWL | ANTICRAWL | 行为反爬 |
| hunhepan | LIVE_JSON(10) | LIVE_JSON(10) | LIVE_JSON(10) | 活源 |
| ting77 | CF_CHALLENGE | CF_CHALLENGE | CF_CHALLENGE | CF 质询墙（待浏览器栈） |
| quarksoo | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| aipanso | CF_CHALLENGE | CF_CHALLENGE | ALIVE_EMPTY | CF 质询墙（待浏览器栈） |
| panyq | ALIVE_SHELL | - | - | SPA 壳（引擎不可用） |
| yuneu | ALIVE_SHELL | ALIVE_SHELL | ALIVE_SHELL | SPA 壳（引擎不可用） |
| squark | DEAD | DEAD | DEAD | 死源 |
| upyunso | DEAD | DEAD | DEAD | 死源 |
| pansearch | LIVE_HTML(2) | ALIVE_SHELL | LIVE_HTML(4) | 活源 |
| haitunsou | ALIVE_SHELL | ALIVE_SHELL | ALIVE_SHELL | SPA 壳（引擎不可用） |
| erxiaopan | DEAD | DEAD | DEAD | 死源 |
| xuebapan | ALIVE_SHELL | ALIVE_SHELL | ALIVE_SHELL | SPA 壳（引擎不可用） |
| susuifa | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| zhaozy | DEAD | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| panta | DEAD | DEAD | DEAD | 死源 |
| kkmao | CF_CHALLENGE | CF_CHALLENGE | CF_CHALLENGE | CF 质询墙（待浏览器栈） |
| pan666 | CF_CHALLENGE | CF_CHALLENGE | CF_CHALLENGE | CF 质询墙（待浏览器栈） |
| ouge | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| mikuclub | LIVE_JSON(96) | LIVE_JSON(96) | LIVE_JSON(96) | 活源 |
| leso | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| quark4k | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| bixin | LIVE_HTML(1) | LIVE_HTML(1) | LIVE_HTML(1) | 活源 |
| lingjisp | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| miosou | LIVE_SSE(1) | ALIVE_SHELL | LIVE_SSE(1) | 活源 |
| clmao | ALIVE_EMPTY | ALIVE_EMPTY | ALIVE_EMPTY | 活而零命中（配方或形态待深挖） |
| meitizy | DEAD | DEAD | DEAD | 死源 |

### 3.2 基线汇总

- 对外请求（发）≈ 149（含代理重试；硬顶 600，频控三律全合规）
- verdict 分布：{'LIVE_JSON': 13, 'ALIVE_EMPTY': 31, 'DEAD': 24, 'ANTICRAWL': 6, 'LIVE_HTML': 6, 'CF_CHALLENGE': 12, 'ALIVE_SHELL': 12, 'LIVE_SSE': 2}
- **实测活源（LIVE*）= 9 / 38 配方源**：['bixin', 'hunhepan', 'melost', 'mikuclub', 'miosou', 'naspt', 'panhunt', 'pansearch', 'tg_tgsearchers7']
- 活而零命中 = 9：['clmao', 'leso', 'lingjisp', 'ouge', 'quark4k', 'quarksoo', 'susuifa', 'yunso', 'zhaozy']
- SPA 壳 = 4：['haitunsou', 'panyq', 'xuebapan', 'yuneu']
- CF 质询墙 = 5：['aipanso', 'kkmao', 'miaosou', 'pan666', 'ting77']
- 行为反爬 = 2：['sopanya', 'sousou']
- 死源 = 9：['erxiaopan', 'funletu', 'haisou', 'jikepan', 'meitizy', 'panta', 'sdso', 'squark', 'upyunso']
- LIVE 总命中条目 = 453（3 关键词合计）

### 3.3 覆盖叙事口径（出口硬门兑现）

旧口径「122 配方」废止。新口径：**37 配方源实测 N 活源**（上表 LIVE* 数）+ TG 腿（t.me/s/ 直连被墙、
代理可用）+ CF 质询源 3 个待 W3 浏览器栈腿转正。122 插件中其余 ~85 个影视站插件不在泛盘检索口径内，
W1 起按需增译。doctor 命令沿用本审计管线（core.run_audit 即健康轮内核）。

### 3.4 与调研预期的对账

- r2 A 级 3 直调源：全部复证 LIVE（naspt/melost/panhunt）✓
- r2 B 级「000 需代理复测」批（GAP A13）：yunso/pansearch 代理+直连形态已定（§2）；haisou/jikepan 判死；funletu 404 站变
- GAP A12 未核批（ting77/quarksoo/lingjisp/meitizy/leso/miosou）：本审计逐源已核，判定见 3.1 表
- melost 响应结构已变（search_result→list），配方表以本日实测为准
