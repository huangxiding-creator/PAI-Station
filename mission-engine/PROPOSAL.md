# PROPOSAL: 自主派活引擎 MissionEngine v1.0 —「想法+资源=变现」永动工厂
> 一句话：讯飞耳机+微信群+七路信号 → 商机锻造（IdeaDig五阶段+Jev判断层）→ 企微审批闸（手机一键批）→ CC军团 super-skill 14相全自主执行（额度护盾保供永不断线）→ 发布/传播/收款四条变现轨 → run-ledger 复利进化。
- 日期：2026-10-23 ｜ 上游：用户语音想法（07任务/智谱额度监控及重置 讯飞转写 00:44-04:05）
- 调研底盘：站内350仓语料（2026-09-05收割）+ 今日123个外部仓库六轮检索 + HN定性 + zhipu-quota-guard 前作（10-23 12:08 已forge）
- 纪律：super-skill V4.1 Idea Factory（idea-intake→research→proposal-forge→审批闸），审批闸前零代码

## 1. 原想法 vs 引擎（每轴可证伪，非口号）
| # | 原想法 | 引擎方案 | 倍率轴与可证伪判据 |
|---|---|---|---|
| 1 | 定时识别讯飞耳机+微信群 | 七路信号雷达：viaim-cli耳机记录/文字直播 + rion-cli+微信情报库群聊/朋友圈 + 需求台账 + topic_signals_to_radar + 盲测退款评分回流 + 报告反馈飞轮 + IdeaDig任意信息源 | 信号源 2→8；判据：每周可锻造信号数实测（run-ledger） |
| 2 | 提出赚钱任务建议 | 商机锻造厂：IdeaDig五阶段（挖矿→锻造→对抗校验→评分→去重）+ EngOpp v3教训内建（NER字段强制合并/数据流断点根因）+ Jev判断层 + SCORECARD门 | 伪阳性率：对抗校验后人工否决率<30%为合格，超标回炉 |
| 3 | 调度CC完成全部开发 | CC军团执行：auto-company骨架（consensus.md接力棒+熔断+回滚）Windows移植 + Ralph循环家族模式 + super-skill 14相零交互 + planning-with-files崩溃恢复 | 人工触点：每任务>2次人工介入即不合格 |
| 4 | （未考虑额度断线） | Mission-1 智谱额度护盾（前作已forge，scorecard 0.845 proceed）：API直连监控+预测型决策+重置卡资产治理，MTTR 3.5h→0.08h（43.75×） | 上线后run-ledger实测MTTR中位数>0.5h回炉 |
| 5 | 完成开发/上线/发布/宣传 | 全链发布器：既役发布链（3公众号+3视频含H3+企微+微盘）+ OPE传播引擎M1 + guizang宣传片产线 | 每任务发布渠道触达数（全渠道铁律） |
| 6 | 「变现」（无机制） | 四条收款轨：acg-faka发卡（自动发货）+ EspoCRM线索中枢 + KB-FACTORY小程序 + 退款评分盲测回流 | 每任务变现金额实测记账（数字零造假） |
| 7 | （无记忆） | 复利飞轮：run-ledger + 决策账本 + 失败变约束（C0复利元则） | 同类错误复发率下降曲线 |

## 2. 调研结论（123仓，明细见 RESEARCH_LEDGER.md）
1. Ralph循环家族（ARIS 17934★/ralph-claude-code 9711★/continuous-claude 1387★）证明CC长任务自主已可行，护栏（熔断/回滚/额度等待）是标配
2. auto-company（198★,Claude Code Agent Teams,MIT）与你想法同构但实验级/macOS-only——移植Windows+生产化+接中国变现轨=全球空白
3. 额度监控赛道7件全是「只看不重置」（zhipu-token-monitor/glm-monitor/GLMQuotaMonitor/plan-watch/pulse-win/TokenMeter/LLMUsageBar），预测+治理+自动重置闭环市面无人做（zcode-switch 410★最接近，仅展示+定时领活动）
4. 个人助手四世代（OpenClaw 388933★/nanobot 47726★/openhuman 39436★/QwenPaw 34919★）无一整合「信号→锻造→执行→收款」赚钱闭环整机
5. HN实弹：「让CC自主投广告一个月」「2026 AI Agent能赚钱吗」——结论一致：可行但必须有人工审批闸+护栏，纯无人不可靠
6. 站内前作即零件：IdeaDig（信息源→开发就绪方案五阶段）+ EngOpp-Mining（28.7分钟112商机+审计教训）+ wxrpa/zbops/rion-cli/军团调度/发布链/OPE/KB-FACTORY 全部在役

## 3. 六器官缝合表（每器官全球最强件）
| 器官 | 选型 | License | 角色 |
|---|---|---|---|
| 引擎骨架 | nicepkg/auto-company 移植 | MIT | 永续循环+consensus接力棒+熔断回滚 |
| 长任务韧性 | OthmanAdi/planning-with-files 27595★ | 开源 | 崩溃恢复计划/per-turn重注入 |
| 编排监控 | hoangsonww/Claude-Code-Agent-Monitor 1106★ | 开源 | SQLite+React实时面板 |
| 额度护盾 | 站内 zhipu-quota-guard（W0已实测）+ ccusage 19138★ | 站内+MIT | 供血保障 |
| 信号腿 | viaim-cli + rion-cli + IdeaDig + EngOpp-Mining | 站内 | 七路信号 |
| 变现轨 | acg-faka 5804★ + EspoCRM 3486★ + OPE + 发布链 | MIT*/AGPL/站内 | 收款闭环 |

## 4. 执行波次（批准后全自主，super-skill 14相）
- W1 引擎骨架：auto-company移植Windows+consensus+claude -p循环+护盾接线（1天）
- W2 额度护盾落地：重置端点三路侦察（GET-only探/zcode-proxy源码/控制台抓包DrissionPage+REA，禁盲POST）→守护上线
- W3 信号腿接线：viaim+微信情报+台账→统一信号队列（复用topic_signals_to_radar桥）
- W4 锻造厂：IdeaDig管线接入+Jev+SCORECARD→提案自动生成→企微审批闸
- W5 变现轨：acg-faka/EspoCRM/OPE/发布链四轨接线
- W6 首个端到端任务实战 + P9 QA + 发布复盘
## 5. 红线（全部继承在役铁律）
账号安全/密钥永不进仓(secrets/+gitignore)/只增不删/删除仅凭明示/Chrome守门/DrissionPage默认Playwright备用/数字零造假/代理用完即关/高峰期(工作日14-18)避大Token相位/让路仅国外网环节/推送冻结(push需明示)
## 6. 北极星（全部run-ledger可证伪）
- 想法→上线周期：基线人工数天 → 目标≤24h/任务
- 商机锻造：≥3提案/周，人工否决率<30%
- 护盾MTTR≤0.5h；重置卡零作废
- 变现：每任务实测入账记账，不达标如实呈报
## 7. 审批闸 ✋
批准 = W1-W6全自主执行；修改 = 按批注改后重启闸；否决 = 归档不删
## 补记（2026-10-23午后）
Mission-1（智谱额度护盾）用户已于10-23上午批准，前作已推进至Phase 4/5（REQUIREMENTS/ARCHITECTURE成文，scripts/w0_recon.py+w2_capture.py、secrets/在位）——引擎审批仅针对 W1骨架/W3信号/W4锻造/W5变现/W6首战 的增量与总装。批准后引擎首战即接手护盾W2落地。
## 8. 信号源扩展总线（用户 10-23 追加令：需求原始来源必须可扩展）
- **铁则**：信号源一律插件化。引擎核心只认统一契约（SignalBus），不认任何具体来源；§1的"七路"仅为v1内置件，源数量无上限
- **插件契约**：每个源 = 一个 adapter（discover → normalize → emit `Signal{source_type, payload, evidence, jtbd_tags, ts, confidence}`）+ 30行契约测试模板（复用 IdeaDig 信息源适配器模式）；接入=新增adapter文件+注册一行，零核心改动（开闭原则）
- **扩展成本目标（可证伪）**：新源接入≤1小时/源；run-ledger实测第三源起计时，超标回炉
- **未来候选（天然插件位）**：邮件(qqmail-cli) / 飞书(lark-im) / QQ / 抖音·知乎评论 / 招标网(EngOpp已有管线) / RSS时间流(905源) / GitHub Issues / 客户工单 / 任何API或网页（IdeaDig任意信息源能力兜底：给URL就能挖）
- **同构先例**：quota-guard ADR2 双站 provider 抽象（站内已验证的扩展模式）——同一思想从provider推广到全信号层
## 审批记录 ✅
- 2026-10-23 12:2x 用户批复「批准」——W1-W6 全自主执行授权生效，追加令（信号源可扩展总线§8）同批
- 生效范围：引擎总装与W1/W3-W6增量；Mission-1护盾按上午单独批准继续推进
- 交接约定：重活在全功能CC会话开跑（本受限会话已铺W1底盘+vendor骨架+账本种子）
