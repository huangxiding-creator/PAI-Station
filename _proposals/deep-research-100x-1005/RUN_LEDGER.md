# RUN_LEDGER — Arc O: 深度调研 skill/项目 ≥100 扫荡蒸馏融合 (1005)

## 进度时间线

| 时间 | 事件 |
|---|---|
| 1005 午 | 令1 anysearch 整合 → **第28渠道落地** (live verify 2 results/剩额8; 337 passed; RF-Eng 1dbfc6d 已推+百度5/5) |
| 1005 午 | 令2/令4 扫荡: Workflow wf_766f76f5 (8角度24agents/314 tool uses/12min) → **272 raw / 208 unique** (≥100 硬门✓), top16 实证审计: 11 excellent/4 good/1 mediocre |
| 1005 午 | 令3 report-helper 克隆+首读 (关卡制流水线/体裁路由/引用规则/gotchas 沉淀, 2224行) |
| 1005 午 | 第二波 Workflow wf_c23838d5: 20顶级源深度蒸馏+8条high级对抗审计 (跑中) |
| 1005 午 | **report-helper 融合 F1-F6 全落位**: F5 lint_rules +18 条禁套话 (11→29, 负例7中) / F1 rqs_v3 两新门 V3-CITE+V3-QUANT (九门→十一门, 33 passed) / F2-F4 METHODOLOGY.md 第四节 (范围对齐六栏卡/单一来源强制补搜/公司定量四件) / F6 reforge_factory/factory_gotchas.md 开账 (G-001~G-004); EPC100 全量 345 passed |
| 1005 午 | **推送+备份**: RF-Eng 41ec85f (rqs 两门+lint 纳管) / AI-Station 2f85a5a (案卷+METHODOLOGY 第四节+gotchas); ls-remote==HEAD 双验 ✓; 百度 5/5 (两增量 bundle) |
| 1005 午 | **第二波蒸馏收官**: 28 agents/824 tools/220万tok/22min → 20源 187优点 (82h/84m/21l) + 8审计lane (3处修正: DeerFlow回执形态改写/prompt缓存降级/last30days实体接地禁硬门); 判级 8 must_fuse/12 worth_fusing |
| 1005 午 | **三件套落盘**: BEST_PRACTICES (66条主题化) / GAP_REPORT (十缺口, 强在骨架弱在防自欺最后一公里) / FUSION_PLAN (FT-1~15+审计台账) |
| 1005 午 | **P0 实施**: FT-1 lib/untrusted.py (围栏+defang, anysearch extract 出口实弹接线✓) + FT-2 collectors/net_hygiene.py (坏主机连坐/TTL 6h); 测试 +12, EPC100 全量 **357 passed** |
| 1005 晚 | **P1 九件全实施** (用户令「下一批的活全部开始完成」): Workflow 6 并行军团 (FT-4/5/6/9/10/11) + 主线串行 FT-3/7/8 (同文件 rqs_v3_gates.py 十一门→**十四门**: +V3-RCPT 回执门/V3-FRESH 六域新鲜度/V3-QUOTE 引文对撞); FT-3 实弹接线 anysearch verify 腿; FT-9 接线 SuperSkillWeekly stage_s1 (zh-search-pro 实弹 5 MEDIUM 零 HIGH); 三域测试 EPC100 **405**/reforge 16/tools 7 全绿 |
| 1005 晚 | **对抗审计轮**: 5 维 38 agent → **33 confirmed 0 rejected** (三高危: FT-4 生产空转-ingest 不落 text_head/skill_scan 缓存 fail-open-同字节 README 与 SKILL.md 互吞/fusion 地板量纲失衡-40 碾压 0.164) + 修复军团 5 组并行; 教训=测试全绿≠接线真活, 跨文件契约要集成测试锚 |

## 第一波关键发现 (sweep1_result.json, 208 池)

- 榜首梯队: mattpocock/research skill (skills.sh 60万装机) / Agent-Reach 91k★ / Scrapling 85.7k★ / DeerFlow 83.4k★ (23个SKILL.md) / crawl4ai 84.8k★ / career-ops 73.5k★ / last30days 63.5k★ / scientific-agent-skills 47.6k★ (80科研DB API) / find-skills 33k★ (370万装) / gpt-researcher 30k★
- 形态分布: claude_skill 与 cli_tool 为主力, mcp_server 次之
- 与既有 search_library(119项注册表) 关系: 互补不重复——那边是网页搜索项目, 这边聚焦 skill 形态+深度研究编排

## 渠道 28 (anysearch) 交付明细

- `ResearchFactory-Eng/EPC100/collectors/anysearch/` client/ledger/cli/__init__
- 限额头自适应 (x-ratelimit-remaining<=1 睡到 reset 封顶70s) + 6s步进 + 日限200 + 429冷却 + 熔断
- batch=每query各占1限额单位 (上游CLI源码实证)
- manifest named 27→28; 主链腿+完备门; 测试11条; **升级工单 ANYSEARCH-1** (注册key提额)

## 待办

- [ ] 第二波蒸馏结果 → BEST_PRACTICES.md + GAP_REPORT.md + FUSION_PLAN.md
- [ ] report-helper 优点融合落位 (关卡制/体裁路由/审核清单/gotchas)
- [ ] 融合实施+测试+推送
- [ ] 208池正式注册表落盘 (_registry.json)
- [ ] 工单 ANYSEARCH-1 (key 注册)
