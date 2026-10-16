# 研究报告生产全流程链条（端到端·E2E v1.0）

> **总纲：从用户需求中来，到用户需求中去。** 链条不是一个流水线，是一个
> 飞轮——第 1 段听需求，第 8 段回写需求，下一份报告的选题、定价、写法
> 由上一份的真实付费数据决定。每段有入口门/在役工具/出口门/实测数据，
> 全部工具已在本仓实测在役（BID26 全链首跑 2026-10-15→16 完成）。

```
        ┌──────────────────────────────────────────────────────────┐
        │                    S8 变现复盘（回写飞轮）                 │
        │   漏斗数据 → 选题权重/定价建议 → decision_ledger → S-1     │
        └──────────────────────────▲───────────────────────────────┘
                                   │ 付费数据反哺
S-1 需求雷达 → S1 调研采集 → S1.5 人工闸 → S2 撰写 → S3 排版 → S4 上架分发
（需求进来）    （三门硬门）   （用户批准）  （密度主判） （成书）  （小程序+秘塔+H5备位）
                                                                     │
                                                  S5 文章×3 → S6 视频×3 → S7 通知推送
                                                  （引流飞轮）  （H3≥1）    （触达收官）
```

---

## 段 0：S-1 需求雷达（从用户需求中来）

| 项 | 内容 |
|----|------|
| 入口 | 自有渠道信号：比地公告量/政策日历/公众号留言痛点/搜索热度 |
| 在役件 | `reforge_factory/superline/demand_radar.py` + `radar_scorecards.json` |
| 出口门 | 评分卡排序落账 + charter 体量显式有据（雷达建议×语料完备性双输入） |
| BID26 实测 | 合规/法务买家 × 2026 新规密集换版窗口 → 专题档 ¥698 |

## 段 1：S1 调研采集（三门硬门）

| 项 | 内容 |
|----|------|
| 在役件 | `ammo_pool` 池体系 + 收割件 12 常驻（localfiles/lark/anysearch/ima_public/djyanbao/zh_search_pro/govlist/court/gap/academic×3）+ `harvest_intake` 归阵器 + F1CrossIngest(30min) + rss_harvest(双日窗) + 军团夜窗 |
| 关键机制 | 问题树十维（`question_tree.py`）→ 挂树（`tree_backfill.py` 存量回填 / `tree_spread.py` 同维铺展）→ 判据（kws 随树扩容 + `judge_reland.py` 复判）|
| 完备性 | 五轴传感器（T 时间轴/B 十面/D 维度/P 深度/C 渠道）→ `cidx.py` 组装 CIdx；C 轴用户批准豁免制 `channel_waivers.json`（命中即替换，只升不逆）|
| 出口门 | `report_gate_check.py` 三门：T1≥1000万 ∧ 五轴全绿或豁免 ∧ 饱和≥80% EEI 双源 |
| BID26 实测 | T1 5,801万字/20,242件 · CIdx 0.8422 · 饱和 81% · 两天从 0.4138 起步 |

## 段 1.5：S1.5 成果详报 ⛔人工闸

用户明示批准（AskUserQuestion 实答/approve 原话落账 `pipeline_state.json`）才可开写。BID26：1016「批准豁免账号态渠道，立即开写」。

## 段 2：S2 撰写（密度主判）

| 项 | 内容 |
|----|------|
| 在役件 | `bid26_outline.py`（树→大纲）→ `bid26_bank.py`（章级弹药 bank 35源/章带 P 锚）→ 写手军团 Workflow（12 并行，密度门自检循环）→ 补锚军团（悬空数字清零）→ `bid26_sweep.py` 主编终扫（密度+锚点两段回源核验，零采信自报）+ `bid26_gate3.py` 融合章互引门 |
| 章型下限 | 精编3000/融合5000/原创4000（gates.json chapter_band）；篇幅上限=null（1015 去限令） |
| 附录 | `appendix_builder.py` 四件套（PRISMA/ACH/热图/存证戳，对齐 reledger 权威账）|
| BID26 实测 | 12 章 57,129 CJK 当日成稿 · sweep 12/12 · gate3 3/3 · 补锚 34+12 |

## 段 3：S3 排版成书

`bid26_merge.py`（12章+前言装配）→ `tools/report_to_docx.py`（封面/点线目录/页码/中文字体）→ Word COM → PDF。
BID26 实测：docx 130KB + PDF 1.4MB/80 页，文本层可检索。

## 段 4：S4 上架分发（三面）

| 通道 | 在役件 | 状态 |
|------|--------|------|
| **总包AI顾问小程序（正道）** | `tools/mp_list_report.py` 固化链：内容同步→CloudBase auth 刷新→manager-node cloudrun FULL 部署→`/api/reports` 轮询验证；vpay 价档复用零新建 | ✅ BID26-2026 ¥698 sellable 四腿实证 |
| **秘塔工程行业大脑（知识分发）** | `tools/metaso_brain_upload.py`（复刻 We-AIPO 生产法：其 profile+cookie 认证 PUT，不带 meta-token） | ✅ 成书 md errCode=0 入库 |
| H5 旧站（备位） | `build_site.py`+`deploy_ecs.py --site-only`；1008 关停令在役，仅文件暂存 | ⏸️ 待用户令 |

## 段 5：S5 宣传文章（≥3，协议下限）

| 项 | 内容 |
|----|------|
| 在役件 | `promo/push_article.py`（三号草稿箱/发布）+ `promo_guard.py` 九门 + `gen_qr_accounts.py` 溯源二维码 |
| 号位 | 总包之声 / 总包说 / 工程行业大脑 |
| BID26 | ①总包之声已发（1015 预制「2026年招投标新规齐爆」ok=true media_id 在档）②③本链补发（总包说版+工程行业大脑版，数字对齐成书实况）|
| 纪律 | 数字与成书一致（ promo 数字须复核——1015 预制文为预估数，后续文按 57,129/80页 实况）|

## 段 6：S6 宣传视频（≥3，H3≥1）

| 项 | 内容 |
|----|------|
| 在役件 | `promo/artmotion_factory.py`（竖屏卡）+ `gen_cover.py` + `video_upload.py`/`video_verify.py` + `gen_h3_bid26.py`（H3 已预生成）+ `video_daily.py` 日更队列 |
| 号位 | 总包说视频号 |
| 纪律 | qa 门+独立审片+列表命中验证；日帽幂等闸在役 |

## 段 7：S7 通知与推送

`notify_wecom.py` 企微通知（上架+文章+视频全链接）+ PDF 推送企微 → `RUN_LEDGER` 回填。

## 段 8：S8 变现复盘（到用户需求中去）

`funnel_query.py` 漏斗仪表盘（per-SKU×渠道：visit→试读→点购→支付）→ 周报北极星（对标 6.6% 基准）→ **回写**：选题评分权重+定价建议 → `decision_ledger.jsonl` 落账 → 喂 S-1（下一份从真实付费数据中来）。

---

## 执行驱动（固化）

`tools/report_full_chain.py`（本链可执行版）：per-report 状态机
`[{sku, stage, ts, evidence}]`，逐段调上述在役件，断点续跑；段间门不过
即停并报告。**闭环铁律：S8 数据不落账，S-1 不开下一份**——保证「到用
户需求中去」不是口号而是硬门。

## 全链首跑战报（BID26，2026-10-15→16）

采集两日 CIdx 0.4138→0.8422 → 三门 GO → 12 章当日成书 80 页 → 小程序
¥698 上架四腿实证 → 秘塔工程大脑入库 → 文章①已发，②③+视频×3+企微
通知本链续跑。**首单（G5）待实付——首单落地即 S8 飞轮第一齿。**
