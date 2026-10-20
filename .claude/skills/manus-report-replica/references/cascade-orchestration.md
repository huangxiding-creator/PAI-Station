# Cascade 编排全参数（Live 实测捕获 · 2026-10-21）

> 源: live/9DCD48BZUH8msRx6TPCfxC 事件流 toolUsed(mcp) detail 原文
> 这是 Manus 生成复杂研究报告的核心引擎，逐字实证。

## 一、workflow/run 原语（manus-workflow MCP 服务）

```javascript
// 确定性 JS 编排脚本: 无 IO, 禁 Math.random/Date.now
// 断点重放: journal 记录已完成 agent 调用, 重启只补跑未完成件
agent(prompt, {brief, schema, input_files, sandbox, effort_level})
  // brief ≤120字: 用户语言的具体子任务标题(任务板展示), 禁 "agent 3"/"任务N" 泛称
parallel(brief, factory, {schema})
  // brief ≤80字: 组名(组头展示); factory 返回 agent promises; schema 组默认+可覆写
log(message)  // 进度记录
```

**fan-out 判据（官方原文转译）**:
- ✅ ≥5 个**各自需要独立研究/浏览/判断**的条目（"research as many X as possible"
  / 全行业枚举 / 多源普查）→ 每条一个子代理并行
- ❌ 短名单、一个问题的多个侧面、几次搜索能完的事 → 不开编排
- ❌ 同一确定性命令跑多输入（参数批）→ 单脚本有界并发，不开子代理

## 二、12 章分解范式（水利水电 EPC 风险管理实测）

专业域通用骨架 = 理论框架 → 环境扫描 → 全周期识别 → 分域展开×7 → 方法评价案例：

| # | 章 | focus 方向 |
|---|---|---|
| 1 | EPC概念、制度边界与风险管理理论 | 界定+法规+国际范式(FIDIC/PMBOK)→理论框架 |
| 2 | 市场、政策与监管环境 | 投资格局+政策环境;只用可核验官方统计 |
| 3 | 全生命周期风险识别、分类与传导 | 立项→运维全链清单+RBS+传导机制 |
| 4 | 前期策划、勘察设计与可研风险 | 前置条件/设计深度/变更影响 |
| 5 | 招标采购、合同条件、计价与索赔 | 总价调价/暂估价/索赔争议;法规+示范文本 |
| 6 | 设计管理、技术接口与工程变更 | 设计施工一体化治理/BIM/接口/审查 |
| 7 | 施工组织、进度、质量与安全生产 | 场景化(导流/围堰/隧洞/大坝/机电)+事故统计 |
| 8 | 生态环境、移民安置与社会稳定 | 环评水保/移民/社区/劳工/舆情 |
| 9 | 地质水文、极端天气与自然灾害 | 洪旱震滑+气候变化;权威数据规范 |
| 10 | 融资、投资、汇率与项目经济 | 资金/现金流/价格波动/境内外区分 |
| 11 | 分包供应链、设备物资与数字化安全 | 联合体/长周期设备/追溯/工控/数字孪生 |
| 12 | 风险评价、预警、应急治理与案例 | 概率-影响/AHP/蒙特卡洛/挣值/案例 |

## 三、子代理契约模板（逐字实证骨架）

```javascript
const chapters = [ {n, title, focus}, ... ];  // 上表分解
const schema = JSON.stringify({type:'object',properties:{
  chapter:{type:'integer'}, title:{type:'string'}, path:{type:'string'},
  summary:{type:'string'}, char_count:{type:'integer'},
  sources:{type:'array',items:{type:'string'}}, status:{type:'string'}
}, required:['chapter','title','path','summary','char_count','sources','status']});
const results = await parallel('N章独立研究与写作', () => chapters.map(c => agent(
  `你是〈领域〉研究专家。请独立完成第${c.n}章《${c.title}》。研究重点：${c.focus}

硬性要求：
1. 简体中文，章节正文不少于4500字符，≥6个一级以下小节、≥2个Markdown表格；
   每个正文段落不少于150汉字，避免碎片化短句。
2. 事实/法规/统计/案例必须来自可公开访问且可靠的来源，优先：政府部门、
   人大/国务院、国家标准、行业部委、统计局、最高法、国际组织、业主官方报告；
   ≥8个来源，关键事实多渠道交叉验证。
3. 正文句后编号引用[1][2]，章末"## 本章参考资料"按"[1]: URL "标题""列出；
   不得编造网址/数据/案例/标准编号；无法核实的资料不写入。
4. 解释分析逻辑、因果链、管理机制、适用边界与判断依据；以可审计的论证、
   假设、公式、评价矩阵和证据说明替代（不披露隐藏思维过程）。
5. 与其他章节错开：只围绕本章主题，跨章内容仅作接口说明不重复定义；
   不得出现"待补充""TODO""占位"。
6. 完整章节写入 /绝对路径/chapters/NN.md，首行"# 第N章 标题"。
   完成后返回结构化结果。`,
  {brief:`撰写第${c.n}章：${c.title}`, sandbox:'shared',
   effort_level:'standard', schema}
)), {schema});
```

## 四、主代理行为序（事件流实测）

```
1. 读内部规范 ×3 (研究报告规范/办公文档规范/结构规范 — 沙箱 skills 文件)
2. mcp server.list (盘点可用服务: manus-tools/manus-device/handoff/
   manus-tasks/slides/triggers/workflow)
3. mcp tool.search workflow (查 run 工具用法)
4. terminal 查目录 → 建项目目录
5. 宣告分解 ("拆分为12个章节研究单元,每单元独立完成子问题、来源查证并撰写")
6. mcp tool.call workflow/run (上节编排脚本)
7. toolUsed(agent) 等待全部完成 (status=argumentsFinished)
8. [子代理各自: 搜→读→写→返回 schema]
9. cascadeJobDelivered 事件逐章到达
10. 合并 → 结构文件 → 终稿 → 质检 → 交付 (fileOperationPromotion)
```

## 五、Claude Code 等价映射

| Manus | Claude Code |
|---|---|
| workflow/run parallel() | Agent 工具并行波次 (一波3-6个) |
| agent({brief,schema}) | 子代理 prompt 开头给角色+硬条款, 结尾要求返回 JSON 摘要 |
| journal 重放 | reports/<课题>/state.json 章节状态台账 |
| sandbox 文件系统 | 仓库内 reports/<课题>/ 目录 |
| effort_level | 子代理 effort 参数 / 模型选择 |
| cascadeJobDelivered | 子代理完成通知收集 |

## 六、workflow-composer 权威契约（沙箱技能原文提炼）

**触发门槛**: 每条目都需非平凡独立推理/研究/浏览才算数——条数本身不够。
先自问「这能否写成单脚本循环？」能=写脚本有界并发，不开子代理。
- 5+ 独立可比条目 → 用编排；**10+ → 必 fan-out**
- 禁用: 短名单/一问题多侧面/几次搜索能完/天然串行紧耦合/同命令多参数

**分解契约**:
1. **一物一 agent**——绝不把多条目捆进一个子代理
2. **父代理不做事条研究**——只编排（Bad: 父先研究再分发）
3. 每个子代理一个清晰有界主题 + 完全自含 prompt
4. 可比条目共享同一结构化输出 schema（组级 {schema}）
5. parallel 组保序 → 输出映射回输入
6. 单条失败不弃全局——收集成功件+记录失败件

**Map/Collect/Reduce 契约**（终稿需跨条综合时）:
- Map: 每条一 agent（parallel 组）→ Collect: 留成功+记失败 →
  Reduce: **恰好一个** reducer agent 综合全部结构化结果 →
  Return: reducer 输出+文件路径；父只确认文件存在并交付，不重研究

**MCP 并发契约**: 有状态任务并行用 sandbox:'isolated'；产文件代理给
确定性独立输出路径；parent-only 操作留父层；工具缺失=报告阻塞，
**绝不伪造完成/挪用他件产物**。
