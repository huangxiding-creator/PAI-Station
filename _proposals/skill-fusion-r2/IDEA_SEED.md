# IDEA_SEED — skill-fusion-r2（外部技能融合升级调研能力）

> Super-Skill V4.1.16 Idea Factory · idea-intake 产出 ｜ 2026-09-26
> 歧义评分：**2/10（低）**——源已枚举 11 项、目标明确、交付物=提案。按 Hybrid Clarification Gate 低分档**自主推进，不提问**，弱字段留审批闸确认。

## 原始想法（用户原话摘要）

> 使用全局安装的 Super-Skill 最新版本，全面深度学习研究如下 11 个 skill 源（9 个 qoder.com.cn 市场技能 + 2 个 GitHub 仓），
> 围绕本项目当前主战场——**工程研究报告的需求**，把这些 skill 的优秀做法全部汲取过来进行充分深度的融合，
> 更新升级本项目的**调研、搜集、分析**等能力。不跳过任何一个步骤，给出深度学习后的融合提升提案。
> **提案经用户批准后由我自主开发实施。**

## 显式假设（弱字段，留审批闸确认）

- **主战场定义** = EPC100 研究工厂生态（百强榜逐家工程研报 7×24 生产 + ResearchFactory 方法论栈：
  METHODOLOGY.md v2 七步循环 / 全渠道调度器 conductor / 饱和引擎（字数门∧饱和门+ACH）/ 弹药门槛 /
  Manus 军团 / Jev+LayaForge 判断层 / 渠道 CLI 化 166 站）——升级对象是这套既有体系的「调研·搜集·分析」环节，不是另起炉灶。
- **融合形态** = 优秀做法萃取后以「技能卡/工作流补丁/脚本件」形式并入既有体系（含 06 技能 蒸馏产线与 .claude/skills），
  不整包照搬、不引入与现有判断层冲突的第二套机制。
- **边界** = 付费资源纪律不破（免费优先）；渠道红线（domain_blocklist/账号安全四件套）不破；11 源只读学习，仓库归档在 `_proposals/skill-fusion-r2/research/`。

## 11 源清单（2026-09-26 全部取回到位）

### qoder.com.cn 市场 ×9（API 直取 detail + 整包 zip，unpack/ 解包完成）

| # | skill | 中文名 | category_v2 | 装机量 |
|---|---|---|---|---|
| Q1 | find-science-skills | 科学技能查找 | Agent Evolution | 23 |
| Q2 | giiisp-paper-search-apis | 论文检索 | Productivity | 74 |
| Q3 | sci-employee-deep-research | 深度研究 | Knowledge | 26 |
| Q4 | scispark | 科学假设生成 | Knowledge | 11 |
| Q5 | research-baseline-builder | 科学数据处理 | Database & Analytics | 19 |
| Q6 | 学术写作 | 学术写作 | Content Creation | 2 |
| Q7 | giiisp-scientific-image-generation | 科研绘图 | Knowledge | 92 |
| Q8 | thesis-audit-reviewer | 论文审查 | Knowledge | 27 |
| Q9 | world-threads-entry | 世界线程入口 | Other | 2 |

### GitHub ×2（clone 到位，`research/vendor/`）

| # | 仓 | 规模 | 初判 |
|---|---|---|---|
| G1 | genli-ai/market-research-skills | 3 技能：analyst-research（MODE_REGISTRY+light/medium/heavy 工作流+报告样式规范+Quarto+图表模板）/ local-vault（MinerU PDF 解析+sync）/ topic-brief（schema+renderer） | **与工程研报最直接对口** |
| G2 | win4r/MuseAI-Skills | 68 独立技能（hatch 运行时快照）；自带中文分析报告点名 wide-research/skill-creator/artifacts-testing/goals/forget/travel-planning/magic-moment 为重点研究对象 | 重点=多 worker 调研编排/交付物验收/技能编写法 |

## 交付物

1. `RESEARCH_DOCKET/` 深度学习卷宗（逐源机制萃取 ≥20 单元）
2. `GAP_REPORT.md` 对照本项目现状栈的差距矩阵
3. `PROPOSAL.md` + `SCORECARD.json`（十倍增量声明可证伪）→ **✋ 审批闸，批准后才实施**
