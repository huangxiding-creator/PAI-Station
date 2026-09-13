# V3 环节4 DIGEST — 主动任务发现与 agent loop 触发（全景调研）

> 调研日期 2026-09-13 · 39 项（A 感知 9 / B 会议 6 / C 挖掘 5 / D 触发 9 / E 前沿 10）
> 方法：WebSearch 前半程 + （配额耗尽后）GitHub API / arXiv 页面 / 官网 curl 直抓亲核；去重基线 = V2 docket（screenpipe/OpenRecall/Windrecorder/UFO² 不重复展开）
> 每项明细见同目录 `_all.json`（name/url/type/stars/license/maturity/relevance/what/value_to_v3/freshness）

---

## 一、全景表

### A. 常驻感知型产品

| 项目 | 形态 | 关键事实（2025-2026） | 触发 | 与 PAI 的关系 |
|---|---|---|---|---|
| [screenpipe](https://github.com/screenpipe/screenpipe) | 开源，21,546★，YC S26 | 定位收敛"local-first AI memory **for humans and agents**"——客户从人变成 agent；当日仍在 push | 事件(帧/音频) | **感知层缝合首选**，Windows 支持 |
| [Rewind.ai](https://rewind.ai/what-happened-to-rewind/) | 已死 | 2024 改名 Limitless → 2025-12-05 Meta 收购 → 12-19 永久关停，EU/UK 用户仅 14 天迁移期；2026 域名被无关 AI 工具站接管 | — | 死亡样本：云端全量记忆=收购即蒸发 |
| [Limitless](https://www.limitless.ai/) | 停售 | Pendant 被动录音→会前简报+会后摘要，评测称"安静替换了一堆笔记工具"；澳媒质疑全天录音法律边界 | 被动捕获 | 确认 UX 样本（汇总式不打断）+ 硬件路线风险样本 |
| [Microsoft Recall](https://blogs.windows.com/windowsexperience/2024/09/27/update-on-recall-security-and-privacy-architecture/) | OS 级 | 2024"privacy nightmare"（明文 SQLite）→撤回重做→opt-in + Windows Hello + 本地加密 + 隐私过滤；2025 Kaspersky 复测认可 | 定时快照 | **隐私设计教训库**，Windows 本地形态合规底线全套可抄 |
| [Click to Do](https://support.microsoft.com/en-us/windows/privacy-and-control-over-your-recall-experience) | OS 级 | Recall 快照→就地识别可操作对象→建议动作（URL 未亲核） | 快照事件 | OS 原生"感知→建议动作"范式 |
| [Omi](https://omi.me/) | 开源+硬件 | 官网原话"captures your screen and conversations, **creates tasks, reminders and advice**"，设备端运行，三端 | 事件(屏/声) | **与 PAI 最同构的现成开源品**：感知→任务全链已跑通 |
| [Bee](https://bee.computer/) | $49.99 挂件 | "sits quietly in the background"→Suggested to-dos / Patterns / Daily memories，全走汇总不打断 | 被动+日汇总 | "被动摘要+主动例外"UX 最佳商业样本 |
| [Apple Intelligence](https://www.apple.com/newsroom/2026/06/apple-intelligence-brings-powerful-ai-capabilities-into-everyday-experiences/) | OS 级 | "aware of your information without collecting it"；主动信息进**通知流**而非对话；2026-06 Siri 大改+独立 app | 系统事件 | 通知式主动的 OS 级范式 |
| [Gemini 2.0+/Agentspace](https://blog.google/technology/google-deepmind/google-gemini-ai-thinking-updates-march-2025/) | 平台 | "takes initiative and figures out the steps"；消费级落地慢于营销（2025 共识） | 混合 | 巨头定义的 proactive=先感知+先推计划+后要确认 |

### B. 会议→行动项

| 项目 | 行动项机制 | 关键差异点 |
|---|---|---|
| [Otter.ai](https://otter.ai/) | 纪要内嵌 action items 块 | 英文头部；字段形态=动词短语+会议锚点 |
| [Fireflies.ai](https://fireflies.ai/) | action items→**自动流转 CRM/Slack** | TODO 不停在纪要里，直连执行通道（90-95% 准确率实测） |
| [Granola](https://www.granola.ai/) | 会后 **Next Steps：责任人+动作+截止**（"Rob: scope template by Tuesday"） | **无 bot 本机音频**；会前自动 Brief；Mac/Win/iOS/Watch |
| [Circleback](https://circleback.ai/) | action items 自动 captured+assigned+organized | 分配到人产品化先例；100+ 语言 |
| [飞书妙记](https://www.feishu.cn/product/minutes) | 官网定位即"会议纪要与**待办总结**" | 与飞书任务/多维表原生打通；本地已有 lark-minutes 操作技能 |
| [讯飞听见](https://www.iflyrec.com/) | "实时提炼重点、待办与会议纪要"，98% 准确率 | **支持私有化部署**——中文 ASR 合规底座候选 |

### C. 任务/流程挖掘

| 项目 | 机制 | 对 PAI 的价值 |
|---|---|---|
| [Celonis Task Mining](https://www.celonis.com/platform/process-mining/) | 桌面采集器（点击/键击/复制粘贴+OCR）→任务聚簇→自动化机会（企业级，专页今日超时部分未核实） | "UI 交互流→重复任务→建议自动化"方法论，个人版可对标 |
| [ProAgentBench](https://arxiv.org/abs/2602.04482)（2026-02） | 28k 事件/500h **真实**会话；主动协助=timing+content 两层；真实数据碾压合成（burstiness B=0.787） | 置信度模型学术地基：时机/内容分模型、别用合成数据训打扰决策 |
| [FingerTip 20K](https://arxiv.org/abs/2507.21071)（清华, ICLR 2026） | 20K 真实移动 UI 会话→学习惯→预测协助点 | 把触屏事件换成 Windows UIA/输入事件即可迁移 |
| [AppAgent-Pro](https://arxiv.org/abs/2508.18689)（CIKM 2025） | 多域 GUI 流→意图推断→主动出手 | 桌面 GUI 主动协助的工程化论文参照 |
| conversational commitment detection | 具体论文今日未核实（Semantic Scholar 不通）；CommitmentBank 是事实承诺非任务承诺；最近亲=[ProactiveEval](https://arxiv.org/abs/2508.20973)（对话意图推断统一评价） | "对话抽承诺"先靠 LLM 提示词，等基准成熟再模型化 |

### D. Agent 触发/调度模式

| 项目 | 触发机制 | 关键事实 |
|---|---|---|
| [OpenClaw](https://github.com/openclaw/openclaw) | **消息驱动 + cron/heartbeat**，389,532★（2026-09-13 实测，半年从十万级暴涨） | 24/7 gateway 收发 IM 即确认；162 扩展；通道协议 L2 档已有（借件不借架） |
| [LangChain agent-inbox + ambient agents](https://www.langchain.com/blog/introducing-ambient-agents) | **事件流**（邮件/消息/文件/webhook/heartbeat） | MIT 开源 inbox UI（1,088★）；三模式 HITL：**notify / question / review** |
| [ChatGPT Scheduled Tasks](https://help.openai.com/en/articles/10291617-tasks-in-chatgpt) | cron（一次性/循环）+事件 | 天花板证明：无工具循环的 cron+LLM 只是定时 newsletter |
| [Claude Managed Agents/后台 agent](https://www.the-ai-corner.com/p/claude-managed-agents-guide-2026) | 平台托管+**需要输入时才召回** | 2026-04 公测（第三方信源）；interrupt-driven 确认的平台级实现 |
| [Kimi 定时任务+Claw](https://www.kimi.com/) | cron 入口级 + agent 产品线 | 中国头部已把"定时任务"做成导航一级入口——用户教育成本低 |
| [Motion](https://www.usemotion.com/) | 日历事件 | 确认后的任务要**自动排进日程**（占住时间段）而非再发通知 |
| [Reclaim.ai](https://reclaim.ai/) | 日历事件 | 反直觉：最好主动日历做**时间防御**（habits/focus/buffer）不做提醒轰炸 |
| [cron-ai-daily](https://github.com/IsMShmily/cron-ai-daily) | crontab+Web | 1★ 小工具；原 cron-ai 大牌已不可寻——cron+LLM 独立产品太薄活不成，只配做内部触发器 |
| [Skylight](https://www.skylight.app/)（排除） | — | 实测重定向 TeamViewer（AR 工人指导产品），非个人 nudge；记录以免后人再查 |

### E. 研究前沿（2025-2026 主动式 agent）

| 论文/资源 | 会议 | 一句话 |
|---|---|---|
| [ProactiveAgent + ProactiveBench](https://arxiv.org/abs/2410.12361)（thunlp） | ICLR 2025 | 奠基：事件流→预测用户下一指令→提前准备；PARE 模拟活跃用户做训练环境 |
| [ProAgentBench](https://arxiv.org/abs/2602.04482) | 2026-02 | 真实工作流 28k 事件；timing+content 分层；真实>合成 |
| [ContextAgent](https://arxiv.org/abs/2505.14668) | NeurIPS 2025 | 首个多传感上下文感知主动 agent（桌面版=屏/声/文件/IM 融合） |
| [Need Help?](https://arxiv.org/abs/2410.04596) | CHI 2025 | 用户研究：介入时机错误比不介入更糟；默认沉默+卡住才出手 |
| [StreamReady](https://openaccess.thecvf.com/content/CVPR2026/html/Azad_StreamReady_Learning_What_to_Answer_and_When_in_Long_Streaming_CVPR_2026_paper.html) | CVPR 2026 | 流证据"够了才出手"：premature/delayed 双显式惩罚 |
| [KnowU-Bench](https://arxiv.org/abs/2604.08455) | 2026-04 | 最接近"主动+个性化+**consent-aware**"助手的基准 |
| [ProactiveEval](https://arxiv.org/abs/2508.20973) | ACL 2026 | 主动对话统一评价（何时发起/说什么） |
| [PPP-Agent](https://arxiv.org/abs/2511.02208) | COLM 2026 | 个性化做成可训练目标（用批准/拒绝日志训出手策略） |
| [Mirai](https://arxiv.org/abs/2502.02370) | CHI EA 2025 | 可穿戴"内心声音"式情境 nudge：最低注意力成本送达 |
| [AgentFold](https://arxiv.org/abs/2510.24699) | ICLR 2026 | 长跑 agent 的主动上下文折叠（24/7 loop 不爆窗） |
| [awesome-proactive-agent](https://github.com/LowEntropyAI/awesome-proactive-agent) | 资源库 | 105KB 研究地图+benchmark 矩阵；PAI 后续研究雷达直接订阅此库 |

---

## 二、推荐任务发现管线（五级选型）

**信号源 → 候选任务抽取 → 置信度/打扰预算 → 确认 UX → 执行派发**

```
┌─ L1 信号源（混合触发：事件为主，定时兜底）──────────────────────┐
│ 屏幕快照+OCR   ← screenpipe 管线（本地、可过滤 app 黑名单，Recall 过滤清单）│
│ 音频/会议      ← Granola 式无 bot 本机采集；ASR 走讯飞私有化或本地 whisper │
│ 文件变化       ← watchdog 监听工作目录（下载/桌面/项目目录三类优先）        │
│ IM/邮件 webhook ← OpenClaw gateway 通道协议（WS 长连+webhook 双模式）      │
│ cron 心跳      ← 低频兜底巡检（每小时/每日 digest 生成），OpenClaw heartbeat │
└──────────────────────────────────────────────────────┘
        ↓ 全部本地落盘为统一事件流（保留 bursty 结构——ProAgentBench 教训）
┌─ L2 候选任务抽取 ────────────────────────────────────────┐
│ 每信号轻抽取 → LLM 结构化：{任务, 责任人, 截止, 证据指针(哪屏/哪句/哪个文件)} │
│ 行动项字段形态抄 Granola（责任人+动作+时限）；对话承诺暂用提示词工程（C 类结论）│
└──────────────────────────────────────────────────────┘
        ↓
┌─ L3 置信度 / 打扰预算（分水岭）────────────────────────────┐
│ 时机与内容分模型（ProAgentBench）；证据累积够了才出手（StreamReady 双惩罚）  │
│ 置信度三档：silent-log（进日汇总）/ ask（即时问一句）/ execute-candidate    │
│ 打扰预算硬上限：即时通知 ≤N 次/天，超限一律并入日 digest（Need Help? 依据）  │
│ 同意信号学习：用户总批/总拒的行动类型降级/升级（KnowU-Bench / PPP-Agent）    │
└──────────────────────────────────────────────────────┘
        ↓
┌─ L4 确认 UX（notify / question / review 三模式）────────────────┐
│ LangChain 三分类为最小完备集；载体=Windows 系统通知→点击展开→一键 批准/否决/改期 │
│ 默认汇总式不打断：每日晨报 digest（Bee/Granola/ChatGPT tasks 同款节奏）     │
│ 每张任务卡带证据指针可回溯（哪场会议/哪屏/哪个文件 diff）              │
└──────────────────────────────────────────────────────┘
        ↓ 确认后入 agent inbox
┌─ L5 执行派发 ──────────────────────────────────────────┐
│ inbox 队列 → 派发 agent loop（Claude Code/自建），长任务后台跑+需要输入才召回 │
│ （Claude Managed Agents 同构）；上下文折叠防 24/7 溢出（AgentFold）        │
│ 完成回写通知+自动占日历时段（Motion/Reclaim：占时间而非发通知）           │
└──────────────────────────────────────────────────────┘
```

一句话：**多信号事件流本地落盘 → LLM 抽带证据指针的任务卡 → 时机/内容分离的置信度+每日打扰预算 → 三模式确认（默认晨报汇总、例外即时） → agent inbox 派发后台执行、需要输入才召回、完成占日历。**

---

## 三、确认 UX 最佳实践汇总（竞品提炼）

1. **三档干预模式是最小完备集**（LangChain）：notify（我看到了但你处理）/ question（问一句解锁）/ review（草稿已备待批）——不要发明第四档。
2. **默认汇总、例外即时**（Bee "sits quietly" / Granola 会后一次性 Next Steps / ChatGPT tasks 完成才通知）：主动性产品的主流收敛形态是"日 digest + 少量即时"，不是实时弹窗。
3. **打扰预算硬上限**（Need Help? 研究依据）：介入时机错误比不介入更糟；设每日即时通知上限，超限合并进 digest；用户停顿/卡住才是出手信号。
4. **证据指针可回溯**（Granola 会议锚点 / Recall 快照时间轴）：每条任务建议必须能一键跳回"它在哪看到的"，这是信任的来源也是误报排查入口。
5. **行动卡字段**：责任人+动词+截止+上下文段（Granola/Circleback 共识）；即使个人用 owner 恒为自己，字段保留——为将来委派 agent 留位。
6. **opt-in + 本地处理 + 随时暂停 + 隐私过滤**（Recall 用一年争议换来的底线）：默认关闭、首次启用明示清单、密码/隐私窗口自动排除、生物认证解锁快照库、一键暂停采集。
7. **渐进自主**（PPP-Agent/KnowU-Bench 逻辑）：新任务类型先 notify 数周→用户总批准后升为 question→再升为 review 自动执行——用同意日志换自主权，不一步到位。
8. **执行完成也走"占时间"而非"发通知"**（Motion/Reclaim）：确认后的任务自动排进日历时段；完成通知能合并就合并。
9. **nudge 文案要短如"内心声音"**（Mirai）：一句话建议 > 表单式确认；点开才见详情。

---

## 四、Top 5 缝合推荐

| # | 项目 | 缝合层 | 理由与动作 |
|---|---|---|---|
| 1 | **screenpipe** | L1 感知 | 本地屏幕/音频管线+Windows 原生支持+插件生态；直接以库/进程形态嵌入，省掉自研 OCR/ASR 管线；注意其 license 为自定义（NOASSERTION），商用前读条款 |
| 2 | **OpenClaw** | L5 执行派发+L1 webhook 通道 | 389k★、消息驱动+cron/heartbeat、162 通道扩展；沿用 V2 结论"借件不借架"：借通道协议（WS+webhook 双模式、durable ingress）与 heartbeat 抽象，feishu 扩展细节见本地 L2 档 |
| 3 | **LangChain agent-inbox + ambient agents** | L4 确认 UX | MIT 可 fork 的现成 inbox UI + notify/question/review 三模式参考实现（email assistant）；Windows 本地包 Electron/Tauri 壳即可成 PAI 的确认面板 |
| 4 | **Omi** | L1→L2 全链对照 | 唯一开源且已跑通"屏幕+对话→tasks/reminders/advice"的完整产品；设备端推理路线与 PAI 隐私立场一致；其任务结构化输出可作 L2 的对照测试集 |
| 5 | **ProAgentBench + FingerTip 20K** | L3 置信度方法与数据 | 真实事件流基准（28k 事件/500h、20K UI 会话）：timing/content 分层建模、真实数据训练、burstiness 保留——直接指导 PAI 的打扰决策器设计与评测集构造 |

---

## 五、三条硬启示

1. **云端全量记忆必死于收购，本地开源才能常驻**：Rewind→Limitless 被 Meta 收购后 14 天内用户失能、域名次年易主；同期 screenpipe 以"local-first, memory for agents"进 YC S26 且 21.5k★ 活跃。PAI 的记忆层必须本地优先+开源组件+随时可全量导出，否则一次收购/断网=数字失忆。
2. **技术上能做 ≠ 默认该做**：Recall 用一年争议换来 opt-in/生物认证/本地加密/隐私过滤四件套；Limitless 在澳被报"the law is the limit"（全天录音法律边界）。常驻感知的信任设计不是合规附加题，是产品本体——Day 1 就要默认关闭+过滤器清单+一键暂停。
3. **主动性的瓶颈不是感知而是"时机"**：ProAgentBench（真实数据）、Need Help?（用户研究）、StreamReady（流证据）三条线共同证明——分对"何时打扰"比多发现任务更重要，且时机模型必须用真实用户事件流训练（合成数据会系统性高估能力）。PAI 应把"介入时机"做成一等公民指标，而不是任务抽取准确率的附属。

---

## 六、风险

- **隐私/合规**：常驻截屏+录音在中国办公环境（会议有他人在场）有法律与礼仪双重风险；密码框/隐私窗口/指定 app 黑名单过滤必须 Day 1 内置；录音场景建议默认"仅本机会议音频"白名单而非全环境录音。
- **误报疲劳**：通知过载会让用户一周内关掉一切（Bee/通知类产品通病）；打扰预算+汇总优先是生死线，宁可漏报进日志也不超限弹窗。
- **断供/收购**：Limitless 用户 14 天失能是前例；缝合选型优先 MIT/Apache 且社区活跃（agent-inbox✓、omi✓），screenpipe 的自定义 license 与 OpenClaw 的 NOASSERTION 需法务过目后再深度绑定。
- **成本**：24/7 感知→LLM 调用费用线性膨胀；分层架构（本地小模型/规则做过滤与聚簇，云端 LLM 只处理候选任务卡）是必选项，参考 Omi 的设备端推理路线。
- **调研局限**：WebSearch/webReader 配额中途耗尽，Semantic Scholar/Wikipedia 网络不通——conversational commitment detection 具体论文与 Click to Do 专页未核实；Claude Managed Agents 细节来自第三方媒体。已如实标注于 _all.json，建议 9-26 配额恢复后补查。
