---
name: muse-goals
description: Use when the user wants to set a goal in a life area (career, health, money, relationships, interests, productivity, or something else), record a commitment toward a goal, or check in on and follow up progress on an existing goal; the category-based goal workflow ported from Meta Muse.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/goals/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**：本技能移植自微信文章《Meta Muse的68个Skills全貌曝光》所披露的
> MuseAI-Skills 仓库（win4r/MuseAI-Skills @ `38bbb45a2c5a0f70de975f6387385770b9ad8aac`，
> 非官方快照）中的 `opt/hatch/skills/goals/SKILL.md` 及其 `creation/`、`guides/` 附属文件。
> 上游原件完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/goals/`
> （vendored 原件，本机可直接阅读）。本版为**本地适配移植版**：方法论（领域划分、
> 承诺记录、跟进节奏）完全保留；凡依赖 Muse 运行时的机制与路径，均改为参考式表述
> 并逐条标注【Muse 环境专用】。

## 本环境适配

上游依赖 Muse 运行时（Muse VM、hatch 工具链、Goals Tab 注入机制、连接器 OAuth）。
逐条对照如下：

| 上游依赖 | 本地映射 / 参考方式 |
|---|---|
| `user_goal.create` / `user_goal.get` / `user_goal.update` / `user_goal.create_entry`（目标记录的增查改与进度条目）【Muse 环境专用】 | 本地无此工具。映射为 Markdown 目标台账：建议 `E:/AI-Station/goals/<goal-slug>/GOAL.md`（Read/Write/Edit 维护，目录使用时创建）；进度以日期条目追加，替代 `create_entry` |
| `/opt/hatch/skills/goals/` 指导文件路径【Muse 环境专用】 | vendored 原件目录 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/goals/`：`creation/<category>.md` 七份、`guides/<category>/scaffold.md` 七份均在位，按需 Read |
| Goals Tab 创建回合自动注入 creation contract（该领域完整创建指南+安全节）【Muse 环境专用】 | Claude Code 无注入机制。**任何**创建目标的回合都视为"无 contract"路径：自行读对应 `creation/<category>.md`（vendored 原件） |
| `muse.create_options` 选项 widget（`embed_token`）【Muse 环境专用】 | 本地无 widget。改为在回复正文中以普通文字列出至多三个具体选项 |
| `muse.edit` 追加 `~/MEMORY.md`、读取 `~/memory/personalization.md`【Muse 环境专用】 | 映射为 Claude Code auto-memory：`C:/Users/91216/.claude/projects/e--AI-Station/memory/MEMORY.md`（Read/Edit 维护）；会话内上下文与 CLAUDE.md 先查 |
| `workspace/goals/<goal-slug>/GOAL.md`（Muse VM 工作区路径）【Muse 环境专用】 | 同上演示的本地 goals 台账（`E:/AI-Station/goals/<goal-slug>/GOAL.md`），写入足够上下文供后续回合接续 |
| 连接器数据源（calendar、email、docs、tasks 等 OAuth 数据）【Muse 环境专用】 | 本地按已接入渠道参考（lark-calendar、qqmail-cli、tencent-docs 等），读私人/工作数据前必须征得用户许可；未接入的数据源不得虚构，缺源即诚实空 |

# Goals guidance assets

以下为上游正文移植，结构忠实保留；会误导本机执行的指令已改为参考式并标注。

Your role is to help the user create and accomplish their goals.

You should be aware how the user is making progress, how the goal changes over
time, or if there are other goals that might conflict with this goal. If a goal
has a timeframe and it ends, check whether the goal is done or should be
extended. Upon completion of a goal, consider whether it deserves reflection.

Record the commitments the user makes toward this goal. Use relevant
information the user has shared or authorized you to access to understand
their progress. Follow the user's stated preferences for support and check-ins.
Ask about progress when the available information leaves something unclear
that would change how you help.

The `/opt/hatch/skills/goals/` directory（【Muse 环境专用】→ 本地读 vendored 原件目录，
见「本环境适配」表）holds guidance for creating goals and helping users make
progress on them. Create, read, and update goals with `user_goal.create`,
`user_goal.get`, `user_goal.update`（【Muse 环境专用】→ 本地以 Markdown 目标台账代替，
见「本环境适配」表）. Upstream says guidance reaches a turn two ways.

## How guidance reaches a turn

**Path 1 — Goals-tab injection【Muse 环境专用，本地不适用，仅存参考】**：上游在
Goals Tab 创建回合由运行时注入该领域的完整 creation contract；注入期间不再读
`/opt/hatch/skills/goals/` 下任何文件，若目标实际属于另一领域，才改读
`creation/<category>.md`。Claude Code 无此注入机制，本地一律走 Path 2。

**Path 2 — 自行读文件（本地唯一路径）**：goal-creation turn 不在 Goals Tab 发起、
或回合在帮助既有目标时，上游要求自行读下列文件——本地照此执行。

To create a goal when no goal-creation contract is in context, read one file
before intake: `creation/<category>.md`（vendored 原件）. That one file holds the
whole creation guide for its category: the workflow, the first conversation,
and the setup that follows the created record. Choose the life area the new
goal belongs to from the `category` values `user_goal.create` accepts【Muse 环境
专用 → 本地沿用同一七分类目录：career / health / interests / money / productivity /
relationships，无合适者用 something_else】. When no life area fits, read
`creation/something_else.md`.

To help with an existing goal, follow the shared guidance above and read
`guides/<category>/scaffold.md`（vendored 原件）, which holds the guidance for
helping with goals in that category over time. Do not read any file under
`creation/` for a goal that already exists. Those files choreograph the first
conversation about a goal, and running that choreography again restarts intake
on a goal the user is already working on.

Confirm the category with `user_goal.get`【Muse 环境专用 → 本地读目标台账
GOAL.md 中记录的 category 字段】. When the goal has no category, use the shared
guidance in this skill without reading a category scaffold.

## Creation workflow skeleton（七份 creation 文件共享骨架）

以下浓缩自 `creation/career.md`（其余六份同骨架、领域细节不同，完整版见 vendored
原件 `creation/<category>.md`）：

- **The flow.** Three phases in order: understand the goal, create one stored
  record, then offer support. Skip intake and create the goal immediately when
  the opening message already names what the user wants and how they will know
  they reached it. Do not create a stored goal or write durable goal state
  during intake. Skipping intake does not skip the guide's "## Safety" section.
- **First response.** When the opening message leaves something to learn, send
  a short natural response that asks one useful intake question, then stop. Do
  not announce an interview. Take no reads, probes, or data pulls before that
  first response or between intake questions. Do not say a goal is created or
  saved before the record exists.
- **Question discipline (every turn).** Ask one user-facing question when a
  missing detail would change the goal or how you help. Do not add a question
  to a turn that needs no answer. A bounded choice uses the options widget【Muse
  环境专用 → 本地以普通文字列选项】with at most three concrete options and no
  catchall labels such as "Other" or "Not sure". Data-connection questions are
  the one exception: two or three real connector options plus a final "Not
  now", at most four options. Ask openly when options would not reduce the
  user's effort.
- **Intake.** Before asking anything, use what your context already contains
  without opening anything: memory files【Muse 环境专用 → 本地 auto-memory 与会话
  上下文】, the user's existing goals, and connected data. Do not re-ask a
  constraint the user already gave. By the end of intake, know the goal in the
  user's own words and the facts you need to advise safely. Ask why it matters
  or what they tried before only when the answer would change how you help.
  Durable facts beyond this goal go under a `## Facts` heading in memory【Muse
  环境专用 → 本地用 Edit 追加进 auto-memory MEMORY.md】. Do not probe how ready
  or confident the user feels.
- **Create.** When the picture is clear, or the user asks you to save, create
  the goal exactly once, yourself, and verify it【Muse 环境专用 → 本地写入
  GOAL.md 台账后复读校验】. Title the goal in the user's own language, write a
  one-line `current_state`, and describe the goal in two or three natural
  sentences. Keep progress in the goal's dated entries. Keep labeled fragments
  such as "Focus:" and agent phrasing such as "I'll" out of the stored fields.
  When the stored title or description does not use the user's own words,
  correct it before you tell the user the goal is saved. When the user already
  has an active goal covering the same objective, update that goal instead of
  creating a second one. Before the turn ends, add setup notes to the goal
  file: the user's constraints (timing, location, schedule, confidentiality,
  other boundaries), the facts learned in intake, and the current shape of the
  plan — enough for a later turn to pick the goal up.
- **First milestone.** After the record is saved, propose a small first
  milestone and offer concrete work you can do with the tools and access
  available. Recommend the most useful next step. For exploration or
  maintenance, suggest a useful next step without forcing a measurable target.
  A saved goal with no set plan is a fine outcome. Offer reminders or
  scheduled check-ins only when they address a real need, and ask for
  confirmation before setting them up【Muse 环境专用 → 本地如需定时提醒可提议
  schtasks/CronCreate，仍须先确认】.
- **Data Sources.** Each category file maps its signal sources (career 例：
  calendar 会议负载、email 招聘信号、job postings 市场需求、docs 简历工件、tasks
  项目上下文；各领域不同，完整版见 vendored 原件）。Work/personal data is
  sensitive: ask the user's permission before reading private context, and
  before sending any outbound message【Muse 环境专用 → 本地按已接入渠道，未接入
  即诚实空】.
- **Safety.** Scaffolds support planning, skill growth, structure, and
  reflection; they do not guarantee outcomes or provide legal, medical, or
  employment-rights advice. Do not recommend deception, contract breach,
  discrimination, harassment, retaliation, or unsafe action. For immigration,
  legal, medical-leave, harassment, discrimination, or termination issues,
  route to qualified professionals or trusted institutional channels.

## Ongoing support（guides/&lt;category&gt;/scaffold.md）

七份 scaffold（career / health / interests / money / productivity /
relationships / something_else，各 4-32 行）是各领域长期支持要点，共通规则：

- Ground the support in what the user actually needs to do day-to-day.
- Research the relevant field when current requirements or industry practices
  would change the advice.
- Relevant context is permission-gated: ask before reading private or work
  data, ask before any outbound message.

配合本文件开头的 shared guidance（进度跟踪、目标冲突检查、时限到期判断 done 或
extend、完成后 reflection、承诺记录、按用户偏好跟进）即构成跟进节奏。各领域
scaffold 完整版见 vendored 原件。

## Category routing summary

- 创建目标（无 contract）→ 先读 vendored `creation/<category>.md` 再 intake；
  七分类 career / health / interests / money / productivity / relationships，
  无合适者 something_else。
- 帮助既有目标 → 读 vendored `guides/<category>/scaffold.md`；绝不重跑 creation
  intake；无 category 则只用本文件 shared guidance。
- 目标台账（本地）：`E:/AI-Station/goals/<goal-slug>/GOAL.md`，字段含 title、
  description（用户原话）、current_state、category、约束、intake 事实、计划形状、
  日期进度条目。
