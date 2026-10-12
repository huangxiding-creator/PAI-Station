# 研报生产线章程（REPORT_PIPELINE）— 1012 用户五令固化

> **用户令链（2026-10-12，五连）**：①继续生产工程总承包研究报告；②所有渠道全部动员全面深度调研；
> ③调研搜集资料总字数必须达到才能撰写；④六段一线（调研→撰写→排版→上架→宣传文章→宣传视频）整体安排；
> ⑤调研达标后详细汇报调研成果，**用户批准后才可以写报告**。

## 产线六段（每段有入口门与出口门，状态机驱动）

| 段 | 内容 | 出口门（硬判据） | 在役实件 |
|----|------|------------------|----------|
| **S1 调研采集** | 全渠道动员（16+1）：RSS 常年收割 / 跨战役收割 / 搜狗微信 / 秘塔 / zh-search-pro 多引擎 / 军团窗口 / 公开网搜 / 池内相关存量跨切 | **字数门**：T1≥300万 ∧ T1+T2≥3000万（collection_gate 同口径） | ammo_pool + collection_gate + F1CrossIngest(30min) + rss_harvest(07:37/19:37) + 军团窗口 + 搜索 Workflow |
| **S1.5 成果详报 ⛔人工闸** | 调研成果详细汇报：总量分层账/渠道完备门/分层成色/覆盖面树/已知瑕疵 | **用户明示批准**（approve 落账，如 1011「批准开写」先例） | collection_gate report + QUALITY_DOSSIER |
| **S2 撰写** | 三态成书法（精编/融合/原创）：抽取 bank→写手并行→机器验收 | m2_gate 字数带 + m2_gate2 锚点数字门 + gate3 互引门 + 主编独立复验零采信自报 | work/m2 全套（extract/gate/gate2/gate3/sweep）+ writer Workflow |
| **S3 排版** | docx + PDF 成书 | front_gate/G1 结算（按书规模缩放） | tools/report_to_docx + build_docx + build_pdf（Word COM） |
| **S4 上架** | 目录转正 + 引擎上云 + 价档挂接 | 生产四腿实测（目录/详情/试读/门禁）+ 海报 v3 自动生成 | update_report_json 模式 + qw_tcb_prep + update_envparams + 既有 vpay 档（¥498/598/698/1999/10000——**新报告复用价档，零新道具**） |
| **S5 宣传文章** | 引流文 → 公众号草稿箱 → autopub 窗口 | promo_guard 九门全过 + draft/get 双验 | push_article（总包之声/总包说/工程行业大脑三号） |
| **S6 宣传视频** | 竖屏卡渲染 → 世界级封面 → 视频号发布 → 只读复核 | qa 门 + 独立审片 + 列表命中验证 | artmotion_factory + gen_cover + video_upload(注意:Playwright栈随CPOPC消失待重建) + video_verify |

## 状态机

- 每产品一行状态：`work/pipeline_state.json` → `[{sku, stage, ts, notes}]`
- 推进规则：段出口门全绿才进下段；**S1.5 只认用户原话**（approve --note 落账）
- 红线继承：数字零造假 / 账本回填 / 密钥不进仓 / 推送冻结令在役（本地 commit 可以）

## 在产产品（首批）

1. **EPC-BID26《工程总承包招投标合规指南·2026 版》**（价档 ¥698 专题档）
   - 底料：A 级存量 176K（《工程总承包招投标合规工作指南》）+ 池内 bidding/policy/hbba/standards 引擎存量 + 全渠道新采
   - 差异面：合规/法务买家（蓝皮书零重叠）；2026 新规时效性
2. **EPC-TRAIN《企业 EPC 培训市场深度洞察》**（价档 ¥598，候位）
   - 底料：A 级存量 391K；买家面=培训机构/企业大学（独一份）

## 全渠道动员清单（S1 开火序）

本机常驻：F1CrossIngest(30min 增量) / rss-harvest(双日窗) / 军团夜窗(Auto_Manus epc49_* 系)
本会话即时：池内跨切（存量相关件入战役池）+ 搜索 Workflow 多引擎扇出（WebSearch/zh-search-pro 语法）
待网络窗：搜狗微信批量 / 秘塔专题 / opencli 夜航
