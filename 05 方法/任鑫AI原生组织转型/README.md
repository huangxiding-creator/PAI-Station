# 任鑫《AI 原生组织转型》——模型萃取库

> 上游：[ai-alchemy-lab/ai-native-org-transformation](https://github.com/ai-alchemy-lab/ai-native-org-transformation)
> （任鑫/Mars · AI 炼金术 · 2026，课程全文五讲 + 研究库 18 份）
> 本地镜像：`external/ai-native-org-transformation/`（git pull 同步，**不入库**，见下方许可纪律）
> 萃取基线：上游 commit `7a4cbb6`（2026-08-24）｜同步工具：`tools/sync_external.py`

## 这门课一句话

**不是转组织来用好 AI，而是用 AI 来替代组织。** AI 提效停在任务层，公司却不快——因为瓶颈在协调层（对齐、推进、闭环）。把这三件事交给 AI，再用三个动作（修路、点火、分圈）落地。

## 萃取文件索引

| 文件 | 内容 |
|---|---|
| [01-核心模型.md](01-核心模型.md) | 三层模型／对齐／推进四件套／双闭环／三个落地动作——全部子框架与案例 |
| [02-理论谱系与术语.md](02-理论谱系与术语.md) | 瓶颈搬家谱系（Grove→Goldratt→贝恩沙漏→约束层）＋术语引进包＋未核实纪律 |
| [03-反方与边界.md](03-反方与边界.md) | 类比三陷阱／失败基准率／J 曲线／因果纠偏——课程自带的学术诚实层 |
| [04-落地参谋模式.md](04-落地参谋模式.md) | 「课程库→AI 参谋」提示词工程模式——研究交付物的可复用形态 |

## 与 PAI-Station 的对照（纳入本项目）

PAI-Station 本身就是这门课模型的一次实践，器官对照：

| 课程概念 | PAI-Station 对应 |
|---|---|
| 唯一事实源（N²→N） | 器官 `_state.json` + `04 智库` 唯一语料源；跨器官只走 R14 凭证不口头转述 |
| 推进四件套 | `07 任务` + runtime 主循环（AI 分配/传导，人处理例外与判断） |
| 检查（四层机制） | 测试门禁（610+ 用例）＋ M9.5b「只用卡片不新增事实」＋ C14 禁造数据 |
| 闭环（能力+市场） | `11 进化` 每周提案（R15 永不自批）＋ `10 反馈` 市场外裁判 |
| 沉淀 = skill 化 | 全局 skill（github-push 等）＋ memory 体系＝「做成过一次就欠自己一句变成 skill」 |
| 修路（MCP/CLI/口径） | tools/*.py 全 CLI 化；本 README 即给 AI 读的接口说明 |
| 反方与边界 | 08 成果 acceptance.json 诚实记 before→after（42 分不过就不过） |

## 许可纪律（CC BY-NC-ND 4.0）

- 课程原文：署名-非商用-禁止改编。**原文全量只留本地镜像（gitignored），永不推送本仓库**；镜像仅供本地检索引用。
- 本目录是**原创萃取**（模型重述＋短引＋出处标注），属「注明出处的引用」，可入库。
- 商用（FDE 全案引用课程框架等）需联系「AI 炼金术」获授权；商店 manifest 只写模型名与出处，不放原文。

## 同步工作流（保持后续更新）

```bash
python tools/sync_external.py            # git pull + 与基线 diff 摘要
# 若有更新：按 diff 重读变动文件 → 增补对应萃取文件 → 更新本 README 基线 commit
# → 重新签发 R14 凭证（kind=method_distilled）
```
