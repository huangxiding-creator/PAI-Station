# BASELINE — 本项目调研·搜集·分析现状栈（gap 分析对照基线）

> 2026-09-26 主 agent 实地核对（文件级验证，非凭记忆）。融合提案的对照面。

## 1. 方法论层（reforge_factory/，METHODOLOGY.md v2 · 135 行调研宪法）

七步循环 S1-S7 已落工程件：question_tree.py（假设树+EEI 51/课题+可证伪审查+先敌后友）、
ammo_pool.py（三态有效性+GRADE 分级+挂树+饱和门 coverage）、ach_arena.py（ACH 排除法对抗场）。

**设计完但未实施的三新件（总纲第三节，接线位已写明）**：
- 校准记分账本 calibration_ledger.jsonl（判断落概率+口径+截止+Brier 对账）——`find` 无文件
- 存档快照（valid 证据 sha256 快照防漂移）——无文件
- 红队轮 redteam.py（premortem+KAC 双检成稿门禁）——无文件
- 活体更新（LSR）——待排

全程纪律：77%写/10%搜、军团主腿+本地16渠道兜底、Jev 三铁律、账号四件套、只增不删。

## 2. 生产运行时（ResearchFactory-Eng/EPC100/）

7×24 双车道常驻（NB 锁北京 11-19 窗），部件：
- **conductor/channel_conductor.py（286 行）**：全渠道统一调度器——7min tick/资源互斥/heavy 窗/adopt 收编/完备门（17 源渠道逐条过账）/blacklist 闸（domain_blocklist.json 出队闸）
- **collectors/**：epc100_channels（渠道采集）、epc100_cnki（知网）、epc100_enrich（增补）
- **pipeline/epc100_postchain.py（589 行后置链）**：终稿→过程附录四件套（漏斗/矩阵/方法/快照）→brief+preface→交付版+排版源→Word 定稿（图嵌入+校验）→宣传三件（hook/points/html）→自复盘（盲评+画像卡+渠道 boost）
- **pipeline/epc100_profile_card.py**、sched/、runtime/、每日战报/
- 悬决：P5 delta 门（独立源 50→≥500）验收未结

## 3. 调研军团与弹药（memories + Auto_Manus/）

- Manus 军团 150 账号×300 积分/日，三用途铁律（调研规划/问题树/原始资料搜集整理），反编造门=URL 引用密度核验
- 弹药门槛：1000 万新增有效字才计数（ammo-gate-doctrine 三态执行器）
- 饱和引擎 R1'-R3' 落地（abd98eb）；E-OSCAR 情报引擎、C5 判定语言、行业时序面板（P4 收官 02c1e47）

## 4. 判断层

- Jev System One 契约层（typesafe）：三原语/confidence 三段路由/Noul 双阈值；taskcards+l2_slow 接线在役
- LayaForge（services/laya-server 8864）：契约≡typesafe 的平价判断引擎；P2 v2 三门全 PASS 热换在役（E1 88.3% 反超 Jev 16.5pp）；P1 位级引擎+双轨影子
- 金标准体系：localfiles 86 分（卷宗混合路由）；intent 219 行

## 5. 技能资产层

- `.claude/skills/`（项目级）：wwg-research-methods（万维钢 8 能力：五步法/观点检验/信源审计/证据权重…）、cangjie-skill（蒸馏元 skill）、渠道栈 skill 生态（qqmail/tencent-docs/ima/difyctl…）
- 全局：super-skill V4.1.16（Idea Factory/14 Phase/开发宪法）、metaso-search 等
- 06 技能/library/：上游 clone 仓（cangjie 等）+ distilled/ 蒸馏产线

## 6. 已知空白（融合提案的候选靶区，初步）

| # | 空白 | 现状证据 |
|---|---|---|
| W1 | **报告样式/写作质量规范**：postchain 有结构组装无样式门（语言/段落/图表位规则） | postchain.py 无 style spec 件 |
| W2 | **分级工作流**（light/medium/heavy 按题选档）：现在一杆子七步全流程 | METHODOLOGY 单轨 |
| W3 | **出版级图表**：研报图表能力未件化（E-OSCAR 面板≠成稿图表） | 无 chart template 件 |
| W4 | **PDF/文献结构化解析**：cnki 采集有，但通用 PDF→结构化文本（公式/表格）无 MinerU 级件 | collectors 仅渠道+cnki |
| W5 | **多 worker 调研编排契约**：军团是账号级并行，缺「协调者-worker 统一输出契约+覆盖率/失败项报告」模式 | conductor 管渠道不管研究分工 |
| W6 | **交付物验收门**：「docx 校验」是文件级，非「交付物可用性」级验收 | _verify_docx 仅验结构 |
| W7 | **论文/学术检索腿**：cnki 单渠道，无多学术 API 聚合（arxiv/pubmed/semantic scholar） | epc100_cnki 单点 |
| W8 | **选题简报 schema**：无结构化 topic-brief（字段化选题+校验） | — |
| W9 | 三新件未实施（校准/快照/红队）——**属本提案可顺手收口的内部债** | 见 §1 |

## 7. 红线约束（融合不得破）

付费模型只占免费原语位（免费优先铁律）｜domain_blocklist 出队闸｜账号安全四件套｜只增不删+Git 留痕｜
WeAIPO 免打扰｜提案批准前不实施（用户令）。
