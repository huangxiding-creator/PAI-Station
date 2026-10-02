# PROPOSAL: EPC100 研究工厂 Fusion R2 —— 输出侧工作台 × 输入侧补强（243 技能深读融合）

> 把全世界 243 个顶级技能里「成稿→审计→验收→交付」的工程纪律，缝进本项目世界级的输入侧工厂（conductor/弹药/饱和/军团/判断层），一次补齐 W1-W22 全部已知空白。

## The 10× claim (falsifiable)
- **Best differentiation axis**: 成稿→交付链**断言级机器验收覆盖率**——现状 0%（postchain 只做文件级结构校验与逐字节排版回归），提案后 ≈100%（每条数字/事实/预测/因果断言/引用都进审计分母账本，六值 verdict 收口）
- **Multiplier**: **10×**（保守记法，实为 0→1 跳变）vs 现有 postchain（TenX verdict: tenx_qualified）
- **Evidence**: `PATTERN_BOOK.md` P1-P14（6+5+4 源收敛模式）+ `GAP_REPORT.md` §2/§3/§7（每空白绑定出处）+ `RESEARCH_DOCKET/pool/*.md`（8 份深读报告原件）

## Problem & persona
- **Persona**: 本项目 7×24 工程研报工厂（EPC100 双车道+Manus 军团 750 任务/日+conductor 17+ 渠道）——无人值守产线
- **Pain**: 产线越强，输出侧越裸奔——研报数字无源可溯不拦、排版后改动无感知、占位符可出厂、审计靠模型自觉。**evidenced by** GAP_REPORT §0「输出侧几乎整段空白」+ 243 技能深读的公共发现：外部高质量仓的工程深度恰好全在输出侧（ARIS verifier 7 步/rigorpilot CI 80 绿/kdense 双账本）
- **Frequency**: 每一份研报交付都过这条链；EPC100 百强榜逐家产出 = 每天多次

## Existing landscape (from research, 243 skills / 18 repos)
| Solution | Maturity | 关键资产 | Gap it leaves |
|---|---|---|---|
| ARIS (41 技能) | 88/100 | 六值 verdict 契约+STALE 重哈希+64 测试 | 无输入侧工厂；绑 Codex MCP；无中文源 |
| rigorpilot (9) | 85/100 | result_match 三态+runtime 证据目录+plan fingerprint | DL 复现场景；~2500 行框架过重 |
| K-Dense (29) | 78/100 | 双 CSV 账本+行内绑定+liteparse+EDA 四层 | market-research 语义需换轨 |
| genli (4) | 72/100 | MODE_REGISTRY+样式 spec+chart 模板 | macOS 栈/零测试/单研究员定位 |
| museai-hatch / qoder-9 / deer-flow / nature-skills / knowwork / marketingskills / riekelt / firecrawl / wshobson | 45-75 | 逐件见池报告 | 各自单点强、无一同时具备输入侧工厂 |

Landscape: median maturity ≈52，mature ≥3，derived feasibility 0.88。**缝合价值正来自碎片化：输出侧最深件分散在至少 5 个互不相识的仓。**

## Why this wins (differentiators)
1. **两边都有**——外部有输出侧纪律无产能工厂，我们有产能工厂无输出侧纪律；融合体在深读范围内无对手 — PATTERN_BOOK §0
2. **制度+执行器成对交付**（P5 铁律）——原仓普遍纸面件病（museai 门脚本全缺/kdense 7 件无脚本绕门/genli 零测试），我们每个制度都落 CI 可跑脚本（gate_ckpt/tick 形态已验证） — GAP_REPORT §5 第 6 条
3. **免费合规栈**——学术腿 arxiv+OpenAlex 零 key、PDF 解析 liteparse 本地离线、评审后端走国产免费表；付费绑定件只抄模式不抄服务 — PATTERN_BOOK §4/§5

## Blue-ocean / red-ocean judgment
**Blue ocean**。输入侧调度+产能是红海里我们的独占领地；输出侧验收工程在外部是散落红海零件；「工厂×工作台」缝合位无人占。

## 实施方案（三阶段 11 包 + 4 直装件）

### P0 输出侧三件（主战场直击，先建后拆）
| 包 | 内容 | 抄自 | 落点 |
|---|---|---|---|
| **A 审计腿** `epc100_audit/` | 审计分母账本（数字/企业事实/预测/因果断言/引用五类对象枚举）→ claims_ledger+source_ledger 双 CSV + 行内 `[claim:Cxx][evidence:Sxx]` 绑定 → 复算阶梯 L0 表内互查→L1 公式代入→L2 弹药池复算（禁跳级）→ 六值 verdict（PASS/WARN/FAIL/NOT_APPLICABLE/BLOCKED/ERROR，NOT_APPLICABLE≠SKIP）→ validate_report.py 正则验收器（必备章节/禁语表/批注字段，--strict exit 1）→ 生成与裁决分离（审计腿只见标准+对象哈希不见生成过程） | kdense 双账本+qoder thesis-audit+ARIS assurance+P2 五源收敛 | EPC100 后置链成稿后、排版前 |
| **B 交付门** `deliver_gate.py` | 三段式：机器渲染门（docx→PDF→逐页图+占位符扫描 TODO/lorem/待补充）→ 新鲜眼读渲染产物 → STALE 重哈希（验收记录绑定内容哈希，排版后任何改动=审计作废须重审）+ result_match 三态（matched 须期望+容差）+ 三次熔断上报；门不过不发企微交付通知 | museai 三段式+anthropics 渲染闭环（只借做法）+ARIS STALE+rigorpilot result_match | 后置链出口 |
| **C 样式门** `style_gate.py` | report_style_spec（六级字号/禁 h3/FT 五原则/12 项 grep 红线）+ 物理量门（页边距/图占比/字号下限测量化+closed fix vocabulary）+ 16 项交付检查表 + 因果词表 lint（「将导致/有望拉动」须挂 claim ID）+ 稳定 Slot ID 差距表 | genli+ARIS paper-poster-html+riekelt+kdense 因果 lint | 后置链排版腿 |

### P1 输入侧补强四件
| 包 | 内容 | 抄自 |
|---|---|---|
| **E scholar_hub** | arxiv_search.py 直装+OpenAlex 腿（均免费零 key）+ T1/T2/T3 源分层+三层验证级联（arXiv→CrossRef→S2）+ fetcher/测试成对+D2 零贡献源=ERROR 接完备门 | deer-flow+nat-acad+aris（中文层用自有 cnki） |
| **F topic_card** | 数据需求表六字段（指标/类型/信源/关键词/P0-P2/时间窗——Search Keywords 直通 conductor 出队）+ campaign 七字段+想法硬门 + Eliminated ideas 带死因 + anti-claims（本文不证明 X）+ novelty 最近邻差分防重复选题 | deer-fire consulting-analysis+rigorpilot+aris |
| **I pdf 解析腿** | liteparse 主腿（per-token bbox 本地免费）+ pymupdf4llm 三级链 + pdfplumber 表格腿 + 定位三态+source_map 稳定块 ID | kdense+genli+t2b pdf |
| **J 渠道账本语义升级** | 渠道状态六态（查无≠不可用≠静默缺席）+ documented/adapted/inferred 溯源 + 四轴证据标注（Match quality×Authority 等）+ 多源数字冲突调和协议 + 信源层级→GRADE 判据表 | kdense folklore+rigorpilot+aris web-debug-search+deer-fire attribution |

### P2 编排与债四件
| 包 | 内容 | 抄自 |
|---|---|---|
| **D MODE_REGISTRY** | 快报/标准/深度三档量化参数表（页数×图表数×渠道数×硬停点）单一真相源+5 步传播协议+档间升级路径；「跑多久」一问定档 | genli+firecrawl+ARIS 双轴 |
| **G W9 三新件** | 红队=DA 让步阈值协议（1-5 反驳评分+让步率>50% 自检+frame-lock）+强制异见者+分歧地图+预注册证伪判据；快照=raw/<slug>/<date>/ 只建不覆写+证据 sha256；校准=Brier 对账+weight_sensitivity 排序不稳性+FNR/FPR 金集+Sign-off append-only | ARS+marketing-council+parallel-debugging+mkt-rigor+ARS reviewer calibration |
| **H 军团契约** | 任务卡加 plan fingerprint（下发带指纹 fail-closed）+回收五件套（claims+sources+quality notes+uncertainty+answer_status 五态）+断点状态 JSON 24h staleness+done≠accepted 须 verdict_id+verdict 类任务禁定时器重入+untrusted content 判定 | wide-research+marketing-monday+rigorpilot+aris+t2b 四仓收敛 |
| **K 红线执法件** | 密钥正则 pre-commit 拦截层+domain_blocklist 下沉工具调用层 exit-2 硬拦+metaso 批量禁用 enforcement+军团产物 content-originated action 判定 | aris overleaf hook+block-no-verify+knowwork 谓词 |

**直装件（免费+红线合规，装机前过 SkillSpector 门）**：① deer-flow `arxiv_search.py`（MIT）② nature-skills OpenAlex 腿（Apache-2.0）③ K-Dense `liteparse`（Apache-2.0 工具）④ ARIS 国产免费评审后端表（表值照录、实现按本仓密钥纪律重造）。

**排期原则**：P0 先行（3-5 个工作段），P1/P2 各 4-6 个工作段；全部挂 conductor tick/夜窗既有节奏，不新增常驻进程。每包交付=制度文档+执行器脚本+单测（P5 铁律），不整体安装任何外部框架。

### Out of scope (v1)
- W21 per-hunk 增量审计路由、W22 staging adapter（登记债，P0 审计腿跑顺后再上）
- 任何付费 API 接入（firecrawl/composio/giiisp/Codex MCP 系——只抄模式）
- ARIS/rigorpilot 框架整体安装（择机制不引框架）

## Monetization
内部能力升级，无定价（positioning: internal）。间接变现 = EPC100 付费研报交付质量与口碑 + WeAIPO 漏斗成色。BUSINESS_MODEL.md 不适用。

## Scorecard（脚本实跑：research/scorecard_input.json → scorecard.py）
| Dim | Score |
|---|---|
| feasibility | 0.88 |
| user value | 0.92 |
| monetization | 0.62（内部项目诚实压低，weakest_dim） |
| tenx | 0.85 |
| **weighted** | **0.833 — proceed**（≥0.72 门） |

## 验收判据（falsifiable，逐阶段）
- **P0**：① 任取一份已交付研报，audit 腿建出分母账本且每对象有 verdict（无留空，NOT_APPLICABLE 落盘留痕）；② 人为在排版环节改一个数字，STALE 重哈希必须拦截；③ 人为埋「待补充」占位符，交付门必须 exit 1；④ 样式门在既有成稿上跑出首批 Slot ID 差距表
- **P1**：⑤ scholar_hub 三免费腿各回一次真实查询且有 fetcher/测试成对；⑥ topic_card 的 Search Keywords 列直接生成 conductor 任务且可追回；⑦ 一份付费墙 PDF 走 liteparse 腿出结构化 JSON
- **P2**：⑧ 红队腿在一份成稿上产出让步率数值+分歧地图；⑨ 快照目录 raw/<slug>/<date>/ 落位且二次采集可 diff；⑩ 密钥正则 hook 拦截一次演练性提交
- **全链**：⑪ 上述门全部接进后置链/tick 后，连续 5 份研报无人值守交付全 PASS 且可审计回溯

## Assumptions to confirm at gate
- docx→PDF 渲染链在本机可用（soffice 或既有宣传链渲染器；不可用则 B 包降级为 md 级渲染门，不阻塞 A/C）
- liteparse Windows 轮子在位（Apache-2.0 工具；若无 Windows 轮子则 W4 主腿退 pymupdf4llm 链，liteparse 转 WSL/服务器腿）
- SkillSpector 安装收尾（在途重试）后作为 4 直装件的装机扫描门；若仍失败，凭据正则扫描兜底先行

## Risk register (top 3)
1. **审计腿误报轰炸**（研报数字全拦死，产出停摆）→ 分级放行：L0 全拦、L1/L2 WARN 不阻断+首月只出 advisory 报表观察误报率，校准后再升 FAIL 档
2. **Windows 排版渲染链环境坑**（soffice 缺失/字体漂移）→ 降级路径显式设计（md 级渲染门）；字体链用已验证的 md2docx 配置
3. **移植规模过大烂尾** → P0/P1/P2 分段硬交付+每包独立可用（任一包单独立即可产价值）；strict 遵循「不整体安装框架」边界

## 批准后的自主实施
按用户令「提案经我批准后由你自主开发实施」：批准即进入 Phase 0-11（架构→WBS→自主开发→Ralph Loop→复盘），全程零打扰、每阶段 run ledger 留痕、推送按既有纪律（GitHub 两仓+百度 bundle 备份）。
