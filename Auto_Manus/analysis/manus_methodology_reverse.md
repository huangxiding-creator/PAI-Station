# Manus 能力逆向解刨·第一辑

> 材料源：账号#1 历史会话 11 条（73MB 消息流）+ 试点会话全事件流 + SKILL.md 原始文件 + DOM 执行叙事样本。
> 解剖日期：2026-09-22。目的：把 Manus 的工程化能力汲取进 AI-Station。

## 一、执行架构（九类事件流，getSessionV2 实测）

| 事件 | 作用 | 逆向要点 |
|---|---|---|
| chat | 用户/agent 消息 | agent 回复=短叙事+计划宣告，不啰嗦 |
| planUpdate/newPlanStep | **计划树** | tasks[]{status: doing/todo/done, title}——与 TodoWrite 同构 |
| statusUpdate | 过程叙事 | brief=「Manus 正在工作」（高频心跳） |
| toolUsed | 工具调用全记录 | brief(意图)+description(操作)+message(参数)+status |
| sandboxUpdate | 云电脑沙箱 | vncUrl/webRTCUrl——真 Linux 沙箱执行 |
| fileOperationPromotion | 文件交付+追加建议 | 交付后主动建议「做成网站分享？」 |
| contextTransferFlag/Result | **跨会话上下文交接** | 旧会话上下文+文件全量继承续跑 |
| cascadeTaskClock | 任务时钟 | 计时/计费粒度到 ms |

## 二、核心工作循环（长任务实况）

```
接任务 → 复述理解+宣告计划 → 读 todo.md（沙箱内自管理任务清单）
→ 循环 { 选一步 doing → search/browser/text_editor 执行 → 增量编辑单文件 → 里程碑计数("当前295,715字符") }
→ 六项✅质量自检清单 → 成果交付叙事（概览/结构/特色）→ fileOperationPromotion 追加建议
```

关键工程手法：
1. **todo.md 文件制**：任务清单落沙箱文件，跨上下文不丢（比内存 TodoWrite 更耐久）
2. **单文件增量编辑**：反复读写同一 report.md，从不开新版本文件（避免版本分裂）
3. **工具三件套谱系**：text_editor(34) > browser(23) > search(21) > terminal(1)——编辑器为主轴
4. **搜索查询带限定词**：「江苏省EPC总承包市场规模 **历史数据 来源**」——查询词自带来源要求
5. **自适应换源**：统计局安全提示→换间接报告路径；穷尽不了就估算+交叉验证并明示
6. **里程碑数字驱动**：字符数计数贯穿全程（144,106→295,715），进度可量化
7. **六项✅交付自检**：结构完整/字数达标/格式规范/内容去重/无待补充/格式生成——对表初始要求逐项核
8. **contextTransfer 断点续跑**：积分烧完/上下文过长→新会话继承全部文件继续（用户侧只打「继续」）

## 三、技能系统（SKILL.md 原始文件逆向）

**格式与 Anthropic Skills 完全同构**：frontmatter(name/description) + When to Use + Best Practices。可直接互译移植。

### deep-research 技能八条军规（全文要点）
- 深度研究时**升级搜索与分析强度**
- **假设零先验知识**，从定义和背景搜起
- 先宽查询后精确查询（宽检索>精检索起步）
- **MUST 打开并阅读多个来源 URL**（不许只看搜索摘要——摘要常不完整）
- 用新发现的事实生成后续搜索，滚动修正研究方向
- **MUST 边发现边存文件**（防信息丢失）
- **NEVER 把中间笔记当最终成果交付**；MUST 重写为信息密集且可读的最终文档
- 并行处理：≥5 个同类独立子项时用 agent 工具并行
- 写终稿时 MUST 同时遵循 technical-writing 技能

### 用户驱动手法（历史会话实况）
- 硬性要求清单式 prompt：结构枚举+字数下限+格式禁令+自动决策授权（"故障自行修正，无需人工确认"）
- 迭代靠 contextTransfer：同课题多会话族（分析→报告→机会→指南→开发指南五层递进）

## 四、积分经济与故障形态

- 轻任务 research_plan 实耗 55 积分（300/日，北京 08:00 刷新）
- 故障三态：积分不足（可续）→ 沙盒暂停（须重置）→ 内部错误（再次尝试）
- 中断任务「继续」两字即续——上下文全在沙箱文件里

## 五、可移植清单（→ AI-Station 接入点）

| Manus 能力 | 本项目接入点 |
|---|---|
| deep-research 八条军规 | research_studio/E-OSCAR 检索腿的军规层（尤其中间笔记禁交付+边发现边落盘） |
| todo.md 文件制任务管理 | EPC100 产线断点续跑已有同构（state.json），补「任务清单即文件」的跨会话耐久性 |
| 六项✅交付自检 | 研报成稿链后置质检清单（对表初始要求逐项核） |
| 里程碑计数叙事 | 长任务心跳报告的量化格式 |
| contextTransfer 式续跑 | manus_cli dispatch 链（Manus 腿自带的续跑能力，直接用） |
| 硬性要求清单 prompt | build_prompt 三模板已同构，可加「自动决策授权」段 |
| SKILL.md 同构格式 | 双向移植通道：本会话已拿到 deep-research/technical-writing 原文 |

## 六、待深挖（后续辑）

- 145 账号全量语料（晚间采集后）：按课题族聚合，统计规划模式分布
- technical-writing SKILL 全文（试点下载的第二个 SKILL.md contentLength 空，需重取）
- 47 端点中 knowledge/space/connectors 的能力面（用户解禁后）
