# M7 总纲 — 全网最全信号源 + 顶级理解层（意图识别）

批准：用户 2026-09-15（「按照你的建议开工」+「全网最全信号源」+「三参照全部抄过来」+「七层方法论栈全部借鉴」+「一定要实现顶级的理解」）
调研底座：第 11 路卷宗（RESEARCH_DOCKET/v3/11-intent-recognition/，71 项）

## 北极星

**蓝海在理解，不在录制。** 信号源最全是入场券（对标 screenpipe/ActivityWatch/MIRIX/银甲虫全矩阵），
护城河在理解层（活动→意图的识别质量）。验收以「理解准确率」论英雄，不以信号数量论英雄。

## 一、信号源矩阵（M7a：全网最全）

| # | 信号源 | 现状 | M7 动作 | 对标 |
|---|--------|------|---------|------|
| 1 | 麦克风+回环音频→VAD→ASR | ✅ M1 pipeline | 不动 | screenpipe |
| 2 | 屏幕截图+黑名单+滚动缓冲 | ✅ screen.py | 不动 | Recall/Windrecorder |
| 3 | 屏幕视觉结构化（GLM-4V） | ✅ vision.py | 不动（升级位 OmniParser） | MIRIX |
| 4 | 文件系统 watcher+夜间增量 | ✅ fs_watcher/incremental | 不动 | 银甲虫（仅桌面，我们更宽） |
| 5 | 云文档（飞书连接器） | ✅ M2.6 | 不动 | — |
| 6 | 微信纯视觉 | ✅ wechat_vision | 不动 | — |
| 7 | **前台窗口焦点流** | 半成品（fgwindow 原语无消费方） | **新增 window_watcher：轮询去重→window.focus 事件（含 attention）** | ActivityWatch/银甲虫 |
| 8 | **AFK 在场流** | 半成品（presence 只给深读让路） | **新增 afk 事件化：presence.afk start/end** | ActivityWatch |
| 9 | **剪贴板流** | 空（1 行占位） | **新增 clipboard watcher：类型分类+密码形状脱敏+签名去重** | 银甲虫（我们加脱敏红线） |
| 10 | **浏览器 URL** | ❌ | **新增 browser_url：Chrome/Edge History SQLite 只读副本反查（银甲虫招）+标题直取域名** | ActivityWatch 扩展（我们免装扩展） |
| 11 | **进程快照** | ❌ | **新增 process_snapshot：周期 top-N** | UFO/OS-Copilot |
| 12 | **会话事件** | ❌ | **新增 session_events：锁屏/解锁/恢复探测** | ActivityWatch |
| 13 | **网络状态** | ❌ | **新增 net_state：SSID/在线（netsh，CREATE_NO_WINDOW）** | 场景上下文 |
| 14 | 媒体会话（在听什么） | ❌ | 升级位（SMTC 需 winrt，重依赖后置） | — |
| 15 | UIA 无障碍树 | ❌ | 升级位（OmniParser 纯视觉替代优先） | UFO/UI-TARS |

纪律：纯逻辑核心+薄壳注入缝（EventFilter/BatchTimer 模式）；失败静默缺席不崩；时钟可注入；
节流防风暴；项目外只读；浏览器历史只读副本；剪贴板密码形状丢弃（docstring 红线）。

## 二、七层理解栈（M7b/M7c）+ 三参照抄法

| 层 | 落位 | 抄自 | 要点 |
|----|------|------|------|
| L0 事件流分段 | `intent/segmenter.py` | 银甲虫 task-blocks 全套规则 | gap>5min / AFK 边界双向 / 硬类别切换 / 6-10 样本投票 / 任务-资源绑定（时间窗挂文件+剪贴板=TaskTracer 廉价实现） |
| L1 快通道 | `intent/l1_fast.py` | 银甲虫 classifier 8 类级联 + xvfeng Top-k 召回 | 规则级联（固定置信度）→ 嵌入最近邻召回 top-k 意图（升级位 bge-m3/微调小模型） |
| L2 慢通道 | `intent/l2_slow.py` | 银甲虫 ollama prompt 移植 → LlmGateway | 段摘要+可见文本（文档/域名/标题/视觉 ≤4000）→ JSON{activity,project,category,summary,evidence≤3,confidence,next_action}；UItron 三档复杂度路由 |
| 拒识门 | `intent/reject_gate.py` | xvfeng 双层+拒识 | 拒识先行（无效/低置信→irrelevant 零打扰）；失败安全默认=不触发；指标基线：拒识率 90%+（xvfeng BERT-tiny 实证可达） |
| 时序记忆 | `intent/intent_memory.py` | MIRIX 六类↔profile 五层 + graphiti bi-temporal | 意图→ProfileModel 双时间线；项目工作流记忆（AWM 抽象工作流升级位） |
| 纠正飞轮 | `intent/flywheel.py` | OpenCUA 状态-动作对 | 晨报确认/修正→(segment, gold_intent) 样本库→ICL 检索增强（先于微调，SummAct +21.9% 实证） |
| 感知升级件 | tiers 挂钩 | OmniParser→UI-TARS | 视觉通道结构化解析即插；低配本地 OCR 兜底存在性已证（dsh-grounding） |

## 三、里程碑拆分

- **M7a 信号源补全**（本回合）：EventStream 类型扩展 + window_watcher + afk + clipboard + browser_url + process_snapshot + session_events + net_state，全 TDD
- **M7b 意图最小闭环**：segmenter → l1_fast → reject_gate（纯本地零 LLM）
- **M7c 理解深化**：l2_slow（LlmGateway）+ intent_memory（profile 对接）+ flywheel（晨报修正回流）+ 意图版金标准集（MIntRec 标注规范；含拒识样本）

## 四、验收（顶级理解的量化）

1. 全量回归零破坏（现行 1036 passed 基线）
2. M7a：每个新信号源纯逻辑测试全绿 + 薄壳缺席不崩
3. M7b：会议/编码/调研/闲聊四场景金标段——分类准确 ≥90%（Lincan 实证可达线）、拒识零误报
4. M7c：意图版金标准 ≥30 条（含 ≥8 条拒识样本）；L2 输出 schema 合规 100%；晨报修正回流可断点续跑
5. 台账逐项留痕；_recon/refs/ 参照仓库不入库（unlicensed/外部代码只读参照，借鉴架构不抄代码——银甲虫无 LICENSE，xvfeng Apache-2.0 可借鉴需注明）
