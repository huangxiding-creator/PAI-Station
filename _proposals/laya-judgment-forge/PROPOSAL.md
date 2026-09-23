# 提案：Project LayaForge —— 本地判断引擎全面替换 Jev 并深度融合 AI 工作站

版本 v1.0 · 2026-09-23 · 状态：**待批准**
前置研究：RESEARCH_DIGEST.md（全景）/ GAP_REPORT.md（缺口与风险）

---

## 0. 一句话与 10× 判据（可证伪）

**把判断层从「按量付费远程 API」换成「本机免费 50ms 可微调引擎」，用项目自有中文标注数据炼成比 Jev 更懂本项目的裁决者，并解锁 Jev 时代不经济的全量判断规模。**

| 维度 | 现状(Jev) | 目标(laya) | 判据 |
|---|---|---|---|
| 边际成本 | $0.0001/次 | **$0** | 服务账本实测 |
| 延迟 p50 | 1.3s | **≤60ms**（已实测批 6.5ms/问） | traj 对比 |
| 断网/隐私 | 依赖外网+数据出境 | **本机闭环** | 拔线冒烟 |
| 中文准确率 | Jev 官方自认 CJK 低精度坑 | **zh dept ≥85%**（微调后金标准实测；零样本基线 72.2%） | 金标准回归 |
| score 原语 | 不可训 | **精确命中 ≥70%**（零样本基线 33.3%） | 同上 |
| churn 原语 | 不可训 | **≥85%**（基线 69.4%） | 同上 |
| 判断吞吐密度 | ~百次/日（成本约束） | **万次/日可行**（全量核验位解锁） | 新位接线账本 |

## 1. 为什么是现在、为什么是 laya（巨人肩膀实证）

1. **应答逐字段同构**：laya `system_one` 与 typesafe API 返回结构全等（choice/probabilities/confidence/noul/score）——替换是引擎置换而非接口改造，8 个业务接线点零改动。
2. **官方微调配方在库**：`notebooks/laya_finetune_typed_decisions_2xT4_kaggle.ipynb` 给全 proper_reward 损失+梯度检查点+LBFGS 温度拟合——score/churn/中文强化不是从零发明。
3. **本机评测已过隔离关**（09-23 REPORT.md）：延迟/显存/置信分离全部落在可生产区间；模糊置信 0.097 vs 正常 0.702 的分离质量是门控回退的好底子。
4. **免费模型优先铁律的自然终点**：Jev 只该占免费做不到的语义位；现在免费的 laya 能占住这个位，Jev 语义位本身也可让贤。
5. **项目自有标注弹药已成规模**：E1-E3+金标准+fixtures ~400 决策对，周管线持续增产——中文微调的数据护城河别处拿不到。

## 2. 架构：六层缝合（世界最好零件 × 显式交接契约 × 整机跑通）

```
┌─ 业务层（零改动）─────────────────────────────┐
│ PAI 常驻/意图L2/jev_screen/信源筛/RF三腿/SK-CLI  │  8 接线位
├─ 中央阀门（改一处）───────────────────────────┤
│ JudgmentClient: engine=laya|typesafe            │  fail-soft/熔断/开关/traj 全保留
├─ L3 金标准平价门（换引擎不降质的证明）──────────┤
├─ L1 laya-server 常驻服务 ── L2 ────────────────┤
│ 127.0.0.1 HTTP，preload 检查点常热，USE_TF=0    │  官方 laya 引擎
│ /v1/systemone 契约 ≡ typesafe API              │
├─ L4 中文深度微调（官方配方+自有数据+温度校准）───┤
├─ L5 研究工厂独占位（免费+50ms 解锁的规模能力）───┤
└─ L6 运维：watchdog 自启/VRAM 纪律/晚间训练/周报 ┘
```

### L1 · laya-server 常驻服务（新零件）

- **位置**：`E:\AI-Station\services\laya-server\`（独立 venv；评测沙箱 `_quarantine/laya-eval` 留作证据不动）
- **契约**：`POST /v1/systemone {state, model, questions} → {answers, usage}` 与 typesafe 端点**逐字节同构**；另加 `/healthz`（含 VRAM/检查点/uptime）
- **形态**：pythonw 无窗常驻 + 单实例闸（pidfile 存 winpid，MSYS 坑）+ 计划任务自启 + watchdog（抄 EPC100/conductor 成熟配方）
- **环境**：`USE_TF=0`（用户坑一）+ `HF_HUB_OFFLINE=1` + `preload=True` 双检查点常热（用户坑二：否则每次重建 7.4-10.3s）；首版只装 **multilingual**（zh/en 全覆盖，VRAM 1603MB；english 检查点待 VRAM 余量评估后可选）
- **熔断/限流**：并发帽+队列；GPU 异常自动降 CPU 模式（慢但活）
- **审计**：traj 落盘同 JudgmentClient 格式（state 只 hash、答案只数值摘要）

### L2 · JudgmentClient 引擎置换（中央阀门）

- `config/jev.ini` 增 `[jev] engine = laya | typesafe`（默认 laya；typesafe 一键切回=回滚保险）
- laya 引擎=调本地服务（urllib 零依赖，同现有 transport 抽象）；`PAI_JEV` env 开关语义原样保留
- jev_ask.py CLI 增 `--engine`（默认自动探测本地服务，缺席回退 typesafe）
- **缝合契约**：上游 DoD=laya-server /healthz 绿+平价门过；下游准入=JudgmentClient.ask 返回结构与 typesafe 逐字段相等（合同测试固化）

### L3 · 金标准平价门（C12，换引擎必须先证不降质）

- E1-E3 重放（283 行）+ 金标准100 + fixtures36 在 laya 上全量跑
- **门**：各位分离度 ≥ Jev 实测记录（S2 正0.62-0.91/负0.03-0.12；S3 正0.80-0.95/负0.02-0.24；E3 具体 0.94/0.08；E2 召回1.00/误报0.00）
- 不过门的位：保持该位 typesafe（渐进替换），其余位照切——**绝不带病硬上**
- 产出：`parity_report.json`（逐位 before/after，run-ledger 纪律）

### L4 · 中文深度微调（用户追加令 · 官方配方单卡适配）

- **数据工厂**（`services/laya-server/training/`）：
  - 存量转换：E1-E3+金标准+fixtures → notebook cell-6 训练格式（ids/markers/target/qtype/label）
  - 扩标：免费模型（GLM flash，免费模型优先铁律）半自动标注项目内中文语料（简报/工单/材料/研报段落/渠道产出）→ 人工抽检 10% → 目标 **1k→3k 决策对**（分两期）
  - 低温漂移：温度在 **held-out** 拟合（#186 教训）
- **训练**：官方 DDP 配方单卡适配（RTX 3000 6GB）：gradient checkpointing 照开+micro-batch 降至 2-4+**fp32 全程**（#185 头 300× 尺度，不擅自 AMP）+4 epochs；晚间窗执行（长任务纪律）
- **回归门**：微调前后同一 benchmark（fixtures+金标准+E1-E3 重放）——zh dept 72.2→≥85、score 33.3→≥70、churn 69.4→≥85、refund 80.6→≥88；**过门才换服务挂载的检查点**，不过门保留零样本版
- 已知坑入册：乱码高置信穿透（0.9914）→ 服务端加确定性前置过滤（可打印字符占比/长度闸——免费优先，代码位）

### L5 · 研究工厂独占位（主战场：工程研报生产，逐位验收）

| 位 | 用能 | 原语 | 验收 |
|---|---|---|---|
| E1 证据全量核验 | 饱和引擎 ACH 对抗场从抽样→**全量**（每主张×每证据） | noul | 抽样集一致性≥90%后放开 |
| E2 章节质量门 | NB 门卫扩展：章节证据密度/主张-证据对齐 | noul+score | 人工盲评30章对齐 |
| E3 渠道完备门 | board 收官前逐渠道「已尽调」判定 | noul | 与完备门账本对照 |
| E4 信源质量分 | 渠道调度出队前信源打分（微调后开） | score | 金标准信源集秩相关 |
| E5 考卷泄漏全量扫 | P0 泄漏检测 chunk 级→全库 | noul | 已根治集零回归 |
| E6 Manus 军团分诊 | 750 任务/日结果 relevance 路由 | choice | 抽检 100 条准确率 |
| E7 每日简报筛选 | signal_stream 事件重要性 | noul | 人工周抽检 |
| E8 采集实时过滤 | opencli/website 收割只留相关 | choice | 存储量降+召回抽检 |

全部 fail-soft：缺席=原行为，绝不反噬主链。

### L6 · 运维与复利

- VRAM 纪律：常驻 ≤2GB；训练晚间；与 NB/manus 白天共存监控一周出账
- 周度循环（挂 SuperSkillWeekly）：新标注数据→增量微调→金标准回归→过门热换检查点→企微周报（大白话）
- traj 周报：调用量/延迟分布/熔断次数/门控率

## 3. 分期与缝合契约（每期 DoD → 下期准入）

| 期 | 内容 | DoD（验收判据） | 工期估 |
|---|---|---|---|
| **P0 服务化+平价门** | laya-server 落地+JudgmentClient 引擎位+E1-E3/金标准重放 | /healthz 绿+平价报告出炉（逐位 before/after）+合同测试过 | 1 个工作日 |
| **P1 八位渐进替换** | 过门位切 laya，traj 双轨对比一周 | 双轨报告：延迟/准确不降，成本归零 | 2-3 天（含观察） |
| **P2 中文微调 v1** | 数据工厂 1k+单卡训练+温度校准+回归门 | zh≥85/score≥70/churn≥85（金标准实测） | 晚间×3-4 晚 |
| **P3 研究工厂八新位** | E1-E8 逐位接线（E4 待微调后） | 每位独立验收账本 | 3-5 天 |
| **P4 复利循环** | 周度再训+热换+周报 | 首轮全自动跑通留档 | 1 天+持续 |

## 4. 十问扫描（新能力→产品，任鑫第100课）

1. 谁用？——工作站全部运行时（8 现有位+8 新位）2. 何痛？——付费/慢/英文偏见/断网死 3. 何证？——本机评测报告+金标准 4. 护城河？——自有中文标注数据+周度复利 5. 边际成本？——电费 6. 失败模式？——fail-soft 回原路径 7. 回滚？——ini engine=typesafe 一键 8. 规模上限？——6.5ms/问≈单卡日千万级 9. 数据回流？——traj+验证回流训练（C0）10. 明日更值钱？——是（数据复利，模型可换）

## 5. 红线重申

只增不删（Jev 保留）/ 问句钉死 / 确定性检查归代码 / 凭据不入 git / 不弹窗 / 晚间长任务 / 高风险域名黑名单 / 账号安全四件套。

## 6. P0 实施结果（2026-09-23 落档）

**基础设施全通，零样本质量不过门 → P2 微调=关键路径（与提案预判一致）。**

| 件 | 状态 | 证据 |
|---|---|---|
| laya-server 常驻 | ✅ | 127.0.0.1:8864，multilingual 检查点，冷加载 28.4s，VRAM 1308-1588MB，HF_HUB_OFFLINE 零网络 |
| 契约 ≡ typesafe | ✅ | `system_one` 信封已拆（{model,answers,usage}→answers）；E2 冒烟经 JudgmentClient 全链取回 noul |
| JudgmentClient 引擎位 | ✅ | `engine=laya\|typesafe`（env PAI_JEV_ENGINE > jev.ini > 默认 typesafe）；laya 免 key；TestEngine 7 项+全套回归 100% 绿 |
| 平价门 | ✅ | parity_gate.py 重放 E1(162)+E2(24)+E3(100)，Jev 基线从 tmp 原始逐题记录重算（零记忆漂移）；parity/parity_report.json 落档 |
| 看护+自启 | ✅ | schtasks LayaServerKeepalive 10min；杀→35s 无窗复活实测；pid 落档 |

**平价门终判（容差 5pp；E3 双门=捕获+分离度≥0.1 防恒真探测器）**：

| E | Jev | laya 零样本 | 判 |
|---|---|---|---|
| E1 意图 choice acc | 71.7%（conf 对0.92/错0.70） | **8.0%**（坍缩：147/162 全选 idle；conf 倒挂 0.79/0.88） | HOLD |
| E2 任务 noul recall@0.5 | 1.00 / fp 0.00 | **0.00 / 0.00**（任务句 0.01，判别缺失） | HOLD |
| E3 命中 noul 捕获+分离 | 3/5，sep 0.52 | 5/5 但 **sep 0.0**（miss 行也 0.88-0.99，恒真倾向） | HOLD |

**读法**：延迟 51ms（25×）/$0/断网可用的底座已就位；三 HOLD 证明「不设门直接切=生产事故」（意图路由会全坍 idle、任务提取清零）——门挡住了它。8 位全部维持 typesafe，待 P2 微调 zh≥85 后重过门。E3 捕获 5/5 是真信号（语义等价命中敏感性在），缺的是负例校准——微调负样本正是补这个。

## 7. P2 扩标腿（2026-09-23 落档，GLM 免费链）

**v1 若不过门，数据是主抓手 → 引导式生成扩标 338 → 1k+（免费模型铁律：GLM flash 免费链，$0）。**

| 件 | 状态 | 说明 |
|---|---|---|
| augment_label.py | ✅ | 引导式生成（标签=生成条件，非模型自判——规避循环标注）；批量 8 样本/调用降成本；断点续跑（key 去重追加式） |
| E1aug 391 | ✅ | 十类意图补平（fixture 162 不均 project36→unknown6 → 补至各类 ~55-60；system 类生成难仅 29）；冒烟 79s 80 样本 + 全量 ~8min |
| E2aug 216 | ✅ | todo/chatter 108/108 均衡（工程会议口语域） |
| E3 腿 | ⏸ 等GPU空窗 | 正例=库内事实生成后过真实 hybrid_route 检索词面命中才收；幻觉负例=库外事实词面反查不中才收（诚实过滤与 v1 同口径）；embedder 占卡，训练期间禁跑 |
| build_dataset --v2 | ✅ | aug 样本同构 pair 零转换并入；train_items_v2.pt/heldout_items_v2.pt |
| train.py LAYA_DS_SUFFIX | ✅ | `_v2` 后缀数据集→checkpoint-ft-v1_v2，v1 路径零改动 |
| gate_ckpt.py | ✅ | night_run 步骤 4-7 独立重放：热换→回归门→保守收口（训练被暂停后检查点已落盘时，免重训一门定去留，~30min） |

**v1 训练被 14:45 让路暂停时的恢复路径**：滚动存档每个 epoch 覆写 → 暂停丢的只是未完 epoch → `gate_ckpt.py` 直接验收 epoch-3 检查点（全 PASS 留役，否则回官方）→ 只有门不过才用 v2 数据重训。
