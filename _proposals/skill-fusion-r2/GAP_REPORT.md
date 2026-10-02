# GAP_REPORT — 技能融合差距矩阵（skill-fusion-r2）

> 2026-09-26 ｜ research-orchestrator 阶段产出 ｜ 对照基线 = `RESEARCH_DOCKET/BASELINE.md`
> 证据来源：qoder-9 / museai-hatch / genli 三份深读卷宗（已全量入脑）；8 组池深读代理在途（ARIS 41 / K-Dense 29 / nat-acad 16 / knowwork 20 / deer-fire 15 / mkt-rigor 27 / T2×2 轻扫 72），返回后并入 §3 与 §4。
> 判据：每条差距必须绑定「现状证据 + 补位机制出处 + 落点部件」三件，不写无出处的愿望。

## 0. 一页结论

现有体系的重心在**输入侧**（渠道完备门/弹药门槛/饱和引擎/军团产能/判断层），三份卷宗一致指向同一结论：**输出侧（成稿→审计→交付）几乎整段空白**，且这一段恰是所有被研究对象里工程化最深的公共地带。融合主轴 = 「输入侧工厂 × 输出侧工作台」缝合，辅以状态语义纪律（诚实默认值/状态机禁留空/三态正交）横贯全链。

九个已知空白（W1-W9）全部有外部补位来源；另发现 **10 个基线未登记的新差距**（W10-W19），其中 W10 输出侧审计腿为最高优先（qoder thesis-audit 单技能即可成腿）。

## 1. 体系强项（融合不得破坏，且证明无需外求）

| 能力位 | 现有资产 | 最强证据 |
|---|---|---|
| 渠道编排 | conductor 286 行全渠道调度+完备门+黑名单闸 | genli 只有静态源清单、museai 无渠道概念——无人可比 |
| 弹药纪律 | 1000 万字门槛+GRADE+三态执行器 | 弹药门槛语义五连定调 |
| 调研深度 | 饱和引擎（字数门∧饱和门+ACH 对抗场） | 外部无一仓有等价物 |
| 产能 | Manus 军团 750 任务/日 + EPC100 双车道 | genli 自述"单研究员工作台" |
| 语义判断 | Jev typesafe + LayaForge 平价引擎（E1 88.3%） | 外部仅 genli 有"批判三去向"单点 |

## 2. W1-W9 差距矩阵（外部补位全部有源）

| # | 空白 | 现状证据 | 补位来源（卷宗·技能·机制） | 落点部件 |
|---|---|---|---|---|
| W1 | 报告样式门 | postchain.py 无 style spec 件 | genli·analyst-research·report_style_spec（六级字号/禁 h3/FT 五原则/12 项 grep 红线表/文风三件/三态措辞「据X·市场估计约·可能」） | 后置链新增 style_gate |
| W2 | 分级工作流 | METHODOLOGY 单轨七步 | genli·MODE_REGISTRY（light/medium/heavy 参数单一事实源+升档路径+5 步传播协议+步骤级 diff） | METHODOLOGY 分档 + EPC100 任务卡档位字段 |
| W3 | 出版级图表 | 无 chart template 件 | genli·chart_template.py 541 行（FIG_W=6.69 字号锁/三产物 PDF+JPG+_clean.jpg/FT 调色板/legend 图像居中）+ qoder·image-gen（Critic→一次自动修订闭环/五轴质量/null 默认分）+ museai·charts.md（superlative 一律 argmax/headline 交付前再推导/缺口不插值） | 后置链图表腿 chart_forge |
| W4 | PDF/文献结构化解析 | collectors 仅渠道+cnki | genli·local-vault（pymupdf4llm 主路→PyMuPDF 纯文本兜底→MinerU 云 OCR 三级链 + frontmatter 检索字段 abstract/auto_tags/synonyms/key_data + 图片 ascii 改名/md5 去重） | EPC100 enrich 腿 + 弹药池前置解析 |
| W5 | 多 worker 编排契约 | conductor 管渠道不管研究分工 | museai·wide-research（5 字段 manager 输入契约含 worker_prompt_template + 6 字段输出契约含 success_count/total + 7 运行规则：一目标一 manager/失败只重试一次/覆盖率强制入用户报告） | 军团任务卡 schema + 主题级扇出原语 |
| W6 | 交付物可用性验收门 | _verify_docx 仅验结构（文件级） | museai·artifacts/testing（三段式：机器渲染门非零退出挡→新鲜眼读渲染产物→占位符扫描；三次熔断上报；failures/advisories 两级；「Never return a link while a gate fails」）+ genli·防缩水（outline 即合同+`pdfinfo|grep Pages` 计数地板+贴证据纪律「口头全清不算」） | 后置链交付门 deliver_gate |
| W7 | 学术检索聚合 | cnki 单点 | qoder·paper-search（字段归一化映射表+失败响应矩阵 401/403/429/HTML+引用审计表五态处置）+ 池内待并入（K-Dense paper-lookup 18 学术 API / ARIS semantic-scholar+openalex / nature-academic-search） | EPC100 学术腿 scholar_hub |
| W8 | 选题简报 schema | 无 | genli·topic-brief（dataclass 链 Briefing→Section→Item→SourceRef + **event_date 落窗校验** + after:/before: 强制时间过滤 + 撰写后自检 checklist 12 项 + fix_quotes 状态机） | 选题卡 topic_card schema |
| W9 | 三新件未实施 | calibration/snapshot/redteam 无文件 | 无外部源可抄（自家设计自家债）——但 museai·magic-moment 指纹绑定审阅 + genli·time-lock 快照表 + qoder·批判三去向可作实施参照 | reforge_factory 三新件 |

## 3. 新发现差距 W10-W19（基线未登记）

| # | 差距 | 是什么 | 出处 | 优先级 |
|---|---|---|---|---|
| W10 | **输出侧审计腿** | 成稿后先建「审计分母」（枚举每个数字/事实/预测/因果断言/引用为对象账本）→覆盖矩阵九态（pass 必须绑定已完成的验证动作，禁留空）→复算四级阶梯 L0 表内一致性→L1 公式代入→L2 公开数据最小复算→L3 完整复现（禁跳级）→报告只是工作产物的衍生物 | qoder·thesis-audit（九技能第一名） | **P0** |
| W11 | 交付物正则验收器 | 结构契约机器验收：必备章节表/每条批注八字段/禁语表（我觉得/感觉/大概）/--strict 模式 exit 1 进管线门 | qoder·validate_audit_report.py | P0 |
| W12 | 诚实默认值工程化 | 无凭证写 blocker.json 不伪造、质量分默认 null、无引用只能标「无证据初稿」、缺字段填 null「不要用推测值补齐」——每个判断字段都有「未判定」态且禁止伪造 | qoder 全 9 技能公共模式 | P0 |
| W13 | 技能间结构化交接合同 | JSON 契约替代自由文本：进 `{research_question, candidate_docs, exclude, questions_to_answer}` / 出 `{references_count, answer_status 五态, evidence_used, claims_need_fulltext_check, retrieval_limits}` | qoder·deep-research↔paper-search | P1 |
| W14 | 验证成本分级 | 一切检查先便宜确定性后昂贵语义，且「不能未经低级直接跳高级」写成硬规则 | qoder 复算阶梯+图检三级+基线四级 | P1 |
| W15 | 研报版本 lineage | 每版记录父版+preserve_constraints/allowed_changes/disallowed_changes+依据证据 ID；派生链单向（PDF→Word→公众号只从冻结母本抄，反向改动须回终审重冻结） | qoder·image-gen run 系谱 + genli·10a-10d 派生链 | P1 |
| W16 | 三态正交分离 | 论点态（proposed/selected/rejected）×证据态（unchecked/estimated/verified+来源+取回时间）×来源态（found/failed/not_found）不塌缩成一个状态；「not found ≠ 不存在」「死链=源失败不当反证」 | museai·travel-planning | P1 |
| W17 | 时态维度 | 证据卡加 tense 列（offered/planned/ongoing/completed）——「拟建/在建/投产」混淆是工程研报典型事故；作者自写 fact sheet 不算独立证据 | museai·magic-moment | P1 |
| W18 | 证据量阈值→措辞强度 | 50+/30+/15+/<15 四档决定允许的结论强度，<阈值禁下强结论只能写「初步迹象+limitation」 | qoder·scispark | P1 |
| W19 | 结论边界三段式+错配表 | 「本结论在[渠道集合/时间窗/口径]下成立，尚不支持[外推]，下一步需[补证]」+错配表（增速≠竞争力/订单≠市占率/样本内≠预测/accuracy≠因果） | qoder·baseline-builder | P1 |

## 4. 横贯纪律（跨源共性，属「不改代码也要改行为」的融合层）

1. **贴证据纪律**（genli :1146）：一切自检门输出必须贴最近一次实际命令输出的数字，口头「全清」不算——直接补强完备门/饱和门/Jev 门的表现形式。
2. **机器管可计算项、人管审美项**（genli §四「AI 不做视觉检查」× qoder 确定性/AI 分界两栏表）：门做成 CI 可跑脚本而非 prompt 约定（genli 自己没做到的，我们用 conductor tick/gate_ckpt 形态补上）。
3. **排队≠执行≠送达**（museai self_improvement.md）：推送回执三态区分，接到企微/微信推送场景。
4. **调度表不是运行证明，运行史才是**（museai scheduling-and-watching.md）：schtasks 死通道教训的外部同构佐证。
5. **进度事件协议统一 JSONL**（qoder 七技能公共模式）：ts+elapsed_ms+event+payload，长任务节点化透明。
6. **复盘三段式强制三选一**（genli §11）：踩坑/处理/已沉淀｜未沉淀+原因｜下次再观察——接 SuperSkillWeekly 蒸馏环。
7. **传播协议**（genli MODE_REGISTRY 5 步）：参数改动按固定顺序传播 N 个文件——防漂移的制度化（其自仓漂移三处实锤是反面教材：协议正确≠协议被遵守，须配机械检查）。
8. **先图后文**（genli「钻石级洞察」）：口径错误在画图时暴露，图表是数据口径的试金石——七步方法论「生产」步前插图表先行子步。

## 5. 明令不抄清单（安全与质量红线）

- qoder·world-threads：凭证随技能包分发（bind key `tlos_*` 入库）——安全反例，永不安装
- giiisp 系商业接口依赖本身（抄其归一化/回退/卫生模式，不抄其服务）
- genli macOS 平台假设（Songti SC/xelatex 栈/mlx-whisper/sync.command）——移植须换 Windows 字体链并实测
- genli 时间预算数字（15min/1h/2-3h 系后期压缩口径且无 CHANGELOG 记录，与 heavy 实战 days-weeks 矛盾）——接线时预算另测
- museai 产品口味立法（sentence case everywhere/无 slide furniture）——审美不是工程真理
- 各仓纸面设计件（museai artifacts 门脚本在快照中缺失、genli 零测试全靠 prompt 约定）——**抄制度必须配执行器**，这是与原仓最大的差异点也是我们的护城河位

## 6. 池组回收（已收官）

8 组池代理全部返回（2026-09-26）：ARIS 41 / K-Dense 29 / nat-acad 16 / knowwork 20 / deer-fire 15 / mkt-rigor 27 / T2×2 轻扫 72，报告原件在 `RESEARCH_DOCKET/pool/*.md`。深读总量 243 项（原卷宗 23 + T1 148 + T2 72），净汲取 ≥232，满足用户「不少于 200 个」令。跨源合成见 **PATTERN_BOOK.md**（十四条横贯模式 + 多仓收敛清单 + 明令不抄汇总 + 采购/移植分账）。

## 7. 池组终局覆盖升级（v2 增补）

§2 矩阵的池组强化（主力补位者，详见 PATTERN_BOOK §2）：
- **W1** ←ARIS paper-poster-html 物理量门+closed fix vocabulary；paper-plan 稳定 Slot ID；riekelt 16 项交付检查表
- **W2** ←ARIS effort×assurance 双轴；firecrawl 一问定档量化预算；kdense EDA 四层能力矩阵（渠道侧）
- **W3** ←kdense scientific-visualization provenance 侧车；ARIS figure-spec spec/渲染分离+STRICT 逐元素评审；deer-flow 26 图型路由
- **W4** ←kdense **liteparse**（per-token bbox，Apache-2.0 本地免费）主腿 + t2b pdf（pdfplumber 表格腿，A 级）
- **W5** ←七源契约族拼图（wide-research+In/Out/Handoff/Gate 四元组+并发决策表+plan fingerprint fail-closed+断点 24h 门+done≠accepted+军团回包五件套）
- **W6** ←ARIS assurance 六值 verdict+STALE 重哈希（verify_paper_audits.sh 实测蓝本）+ rigorpilot result_match 三态 + anthropics docx 渲染成图闭环（做法可借脚本禁拷）
- **W7** ←deer-flow arxiv_search.py（MIT 免费直装）+ nat-acad OpenAlex 腿（stdlib 免费零 key）+ T1/T2/T3 分层 + fetcher/测试成对纪律
- **W8** ←deer-fire consulting-analysis 数据需求表六字段（直通 conductor 出队）+ rigorpilot campaign 七字段+想法硬门 + aris IDEA_REPORT Eliminated 带死因 + anti-claims
- **W9** ←三腿全部从「自家设计自家债」升级为「有成品件」：红队=DA 让步阈值协议+kill-argument+强制异见者+预注册证伪判据；快照=raw/<slug>/<date>/ 只建不覆写三范式；校准=weight_sensitivity+FNR/FPR 金集+Sign-off append-only

**池组新增差距 W20-W22**：

| # | 差距 | 是什么 | 出处 | 优先级 |
|---|---|---|---|---|
| W20 | 扩标数据集泄漏审计 | 跨 split 精确重复=硬门（同句同进 train 与 held-out 即拦）——laya v2/v3 扩标质检直接可用 | t2a·hypogenic audit_dataset（pinned 数据集实测抓 3 组泄漏） | P1 |
| W21 | per-hunk 增量审计路由 | 第 N 轮改稿只对改动 hunk 按内容类型（正文/引用/数值）路由重审，审计成本随轮次不随篇幅涨 | aris·overleaf-sync | P2 |
| W22 | staging adapter 审计复用 | 构造合成目录让既有审计腿原样跑在新体裁（宣传三件/公众号稿）上，免为新体裁重写审计器；降级标签制 | aris·paper-talk | P2 |
