# RUN_LEDGER — ima 公开知识库渠道 (0926 批准全量实施)

## Idea Factory 链
| 段 | 产出 | 状态 |
|---|---|---|
| idea-intake | IDEA_SEED.md (歧义 3/10 直通) | ✅ |
| research-orchestrator | RESEARCH_DOCKET/ 三腿: local_api + github(35项目) + web_eco(22条) | ✅ |
| gap | GAP_REPORT.md G1-G7 (含判据级实测 8 条) | ✅ |
| proposal-forge | PROPOSAL.md + SCORECARD.json (0.818 proceed) | ✅ |
| ✋ Approval Gate | 用户 0926: 「批准，全量实施」(P0+P1) | ✅ |

## 实施 (TDD: 测先行, 19/19 green)

### 件清单 `EPC100/collectors/ima_public/`
| 件 | 职责 | 抄自 |
|---|---|---|
| throttle.py | 四件套: 3s/req + 日限300 + 冷却300s + 熔断5连败; 假钟可注入; state 可序列化 | 账号安全纪律 |
| client.py | ImaOpenApi 三 header 鉴权; ProxyHandler({}) 直连; 凭证 env→~/.config/ima; code!=0 → ImaApiError | ima-skill ima_api.cjs 协议复刻 |
| share_link.py | 64hex shareId 抽取; SSR 页解析 (容 <!-- --> 注释+万单位+remix 转义层 memberCount); 400→死链卡留档 | web_eco 实测 |
| discover.py | 同义词扇出 (EPC 7 词实测固化); KBCard; 快照只增不删 alive 只恶化; 字段级富化合并 | onclaw 缺陷→差量 |
| harvest.py | BFS folder 下钻 (media_id 原样传 folder_id, 实测); media_type=1 真件; is_end 分页终止; get_media_info 签名直链+X-IMA-* 头; 断点=逐文件 state; chrome:///wechatarticle_ 留痕不耗配额 | delphuy+y869 工艺 |
| ledger.py | leg_ima_public 快照过账 + conductor add_job(resource=api:ima, window=heavy); status_from_report 六态映射 | epc100_channels 模式 |
| cli.py | discover/share/harvest 三命令; 脚本直跑+包双模式 | — |

### 接线
- channel_manifest.json: named_channels 20→21 (+ima_public)
- epc100_channels.py: named set +ima_public; 主链挂 leg_ima_public (腿隔离 try)
- conductor: resource="api:ima" 互斥位, heavy 窗

### 实测踩坑 (判据实车过程)
1. **kb_id 是 44 字符 base64** (`OnP258fipqzt…UPQ=`), CLI 显示截断致我误传 12 位 →
   invalid knowledge_base_id 220004; 收割必须从快照选库或传完整 id
2. **get_knowledge_list 回包**: 条目在 `knowledge_list` (非 info_list);
   folder 条目 media_id 带 `folder_` 前缀且下钻传 media_id 原样 (剥前缀=文件夹不存在 222000);
   分页终止信号 = `is_end` 字段 (next_cursor 有值也可能 is_end)
3. **真件条目不带 url**: url 从 get_media_info 取 (res-skb 签名直链+5 X-IMA-* 头)
4. **SSR 数字带 `<!-- -->` 注释** + 「万」单位; gap 正则须 `[^>]*` 防 .*? 回溯吞段
   (实锤: 692 被焊接到「个内容」)
5. **media_type 语义**: 99=folder, 1=pdf 真件
6. GBK: scorecard 输出须 -X utf8; MSYS cp 双重 EPC100 路径坑 (parents[3] 而非 parent³+拼)

## 判据验收 (全部实车, 2026-09-26)
| # | 判据 | 结果 |
|---|---|---|
| ① | discover('水利') ≥3 库含 >500 条 | ✅ **22 库**, >500 条者 9+ (7155/3552/3552/2293/2169/1661/1256/908/896/862) |
| ② | harvest ≥20 文件断点可续 | ✅ 首轮 25 件; 重跑 `下 25 跳 25 败 0` (state done 全跳过+增量收新, 零重复); 目录树缓存 complete 后重跑免枚举 |
| ③ | 渠道账本 ima_public 行过账 | ✅ run/命中计数 + conductor 1 job 落账 (resource=api:ima, heavy 窗) |
| ④ | 日限额熔断实车触发 | ✅ daily_limit=5 实车 16s 撞限 → stopped_reason=daily_limit → 六态 rate_limited |
| ⑤ | EPC 扇出 ≥2 工程库 + 试收 ≥10 入弹药池 | ✅ **6 工程库** (工程建设政策规范标准库 25745 条/招标投标采购库 4249/总承包电子书库 152…) + 收割 **50 文件**入弹药池 (PMBOK 8th 双语/EPC 工程价款管理系列, 超额 5 倍) |
| P1 | share 腿 SSR 免登录 | ✅ IPO 问询库真实 hash → `10000条 692人订阅` (万单位/订阅数/死链判定全对); 残缺 hash → [死链] 留档 |

## 测试
19/19 green (throttle 4 + client 4 + share_link 3[含真实 SSR 证据页] +
discover 3 + harvest 4 + ledger 1); EPC100 全量 112 passed +
2 既有失败 (test_factory_sched 时钟依赖, 与本渠道无关, 0926 周六)
