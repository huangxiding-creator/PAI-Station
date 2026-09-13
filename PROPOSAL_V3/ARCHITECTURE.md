# ARCHITECTURE — PAI-Station V3（Phase 5 · 系统架构）

> 2026-09-13 ｜ 宪法 C5：实际约束下的最优解，裁决记录为 ADR ｜ 器官选型依据见 `RESEARCH_DOCKET/v3/RESEARCH_DIGEST.md`

## 1. 进程拓扑（全用户态，零服务零 UAC）

```
[Task Scheduler 登录触发(延迟30s,免UAC)]
        │ DETACHED 拉起
        ▼
┌─ pai-daemon（主控，无 UI）──────────────────────────────┐
│  调度器(事件环) + 任务引擎 + 记忆/画像/进化装配           │
│  Mutex 防双开 ｜ faulthandler 首行开启 ｜ run-ledger      │
│  IPC: \\.\pipe\pai-station (stdlib Listener+authkey)    │
└──┬──────────────┬────────────────┬─────────────────────┘
   │ named pipe    │ spawn+心跳文件  │ named pipe
   ▼              ▼                ▼
pai-tray（托盘    pai-sense（感知   pai-panel（pywebview
宿主，纯客户端，  worker：双路采集  面板，按需拉起，
可崩由 daemon     →VAD→唤醒/分流    确认UX+画像查看）
重拉）            →ASR→说话人）
[schtasks MINUTE 看护器]──判活铁律v3──死→taskkill /T /F→重拉→3轮告警
更新链: daemon 下载新版→原子换目录→自杀→看护器拉新（旧版保留一版可回退）
```

## 2. 模块映射（`src/paistation/` 增量，V2 模块全保留）

| V3 新增 | 职责 | 关键件 |
|---|---|---|
| `sense/audio.py` | 双路采集（mic=sounddevice / loopback=PyAudioWPatch）+WASAPI 静音保活 | 03 卷 F 类 |
| `sense/vad_gate.py` | silero-vad ONNX 守门（<1ms/块） | 03 卷 C 类 |
| `sense/wakeword.py` | sherpa-onnx KWS 拼音词表唤醒（三层防误触） | 03 卷 B 类 |
| `sense/asr.py` | SenseVoice-Small int8 常开转写（升级位 Fun-ASR-Nano GGUF）+CAM++ 归属 | 03 卷 A/D 类 |
| `sense/voice_events.py` | 转写+事件标签→统一事件流 schema | — |
| `sense/cloud/` | 云端感知连接器框架（FR15）：connector 协议（login_flow/test_session/collect 水位线增量）+注册表；登录态 DPAPI 加密存 session vault（永不入 GitHub 同步）；每源账号安全四件套（节流+冷却+日限额+熔断）+opt-in 可撤授权 | 用户指令 09-13；weread/feishu 登录态先例 |
| `proactive/taskcards.py` | 事件流→LLM 任务卡（责任人/动作/截止/证据指针/置信度） | 04 卷 L2 |
| `proactive/budget.py` | 时机/内容分离置信+每日打扰预算 | 04 卷 L3 |
| `proactive/confirm.py` | notify/question/review 三模式+Windows toast+晨报 digest | 04 卷 L4 |
| `memory/hybrid.py` | 混合检索路由：Everything(es.exe)→FTS5→sqlite-vec→ripgrep 兜底，RRF 融合 | 02 卷 |
| `memory/embeddings.py` | bge-m3 ONNX int8（夜间 Qwen3-Embedding 升级位）；水位线增量 | 02 卷 |
| `memory/layers.py` | L0/L1/L2 目录摘要按需加载+OKF .md 记忆文件读写 | 02 卷 |
| `execute/agent.py` | Agent 内核（Claude Agent SDK 经 gateway 接 GLM 链；subagent 隔离） | 09 卷 |
| `execute/deliver.py` | 成果落 `08 成果/`+回执+企微通知 | V2 复用 |
| `profile/model.py` | 五层画像+双时间线+四操作冲突消解 | 06 卷 |
| `profile/night.py` | 夜间整理（固化/遗忘/反思/图谱）1:00-6:00 窗口 | 06 卷 |
| `skills/forge.py` | skill-forge 五段流水线（案例→升格→验证→注册） | 07 卷 |
| `skills/effects.py` | 进化效果跟踪：激活技能的使用结果落 `effects.jsonl`，滚动成功率 vs 基线对比，下降→生成回滚建议任务卡（FR10b） | 用户指令 09-13 |
| `skills/sync.py` | GitHub 备份同步：进化产物 git 提交+推送到用户自配仓库，断网积压补推（FR14）；.gitignore 硬排除 secrets/authkey/事件流 | 用户指令 09-13 |
| `skills/seed.py` | 成果反推 skill 库（FR16）：扫描 08 成果/与云端文档→LLM 反推方法论→SKILL.md+scripts 候选（全自动；激活走晨报确认）；复用 V2 05 方法器官萃取先例 | 用户指令 09-13 |
| `skills/market.py` | skill 交易生态（FR17，接口预留）：技能包元数据 author/version/license/price+导入导出；V2 skills/market.py 为底座 | 用户指令 09-13 |
| `resident/daemon.py` | 主控 daemon（事件环+Mutex+心跳） | 05 卷 |
| `resident/tray.py` | 托盘宿主（pywin32）+pipe 客户端 | 05 卷 |
| `resident/watchdog.py` | 看护器（判活铁律 v3 移植+更新交接） | 05 卷 |
| `resident/ipc.py` | named pipe 协议（stdlib） | 05 卷 |
| `dist/` | Inno 脚本+uv 离线包+硬件分级+首启向导 | 08 卷 |

## 3. 核心数据契约（显式交接契约——缝合怪律二）

**事件流**（`%APPDATA%/PAI-Station/events/YYYY-MM-DD.jsonl`）：
```json
{"ts":"...","type":"voice.transcript|voice.wakeword|ambient.event|fs.change|screen.ocr|im.webhook|cron.tick|cloud.doc.change|cloud.file.list",
 "source":"mic|loopback|watcher|baidu-netdisk|weiyun|feishu-docs|...","text":"...","speaker":"me|other|unknown",
 "evidence":{"audio_hash":"...","segment_ms":[0,4200],"app":"...","watermark":"..."},"meta":{...}}
```
**云连接器协议**（FR15，`sense/cloud/connector.py`）：
```python
class CloudConnector:            # 注册即接入：name/scopes/登录/采集四件
    name: str                    # "feishu-docs"
    scopes: list[str]            # 申请的感知范围（文档/网盘文件/日历…）
    def login_flow(self) -> bool         # 扫码/粘贴 cookie；成功即存 session vault
    def test_session(self) -> bool       # 登录态体检（失效→生成"需重新登录"任务卡）
    def collect(self, since: str) -> tuple[list[Event], str]  # 水位线增量，返回新事件+新水位
# 框架强制：RateLimiter(节流+冷却+日限额+熔断)；session 用 DPAPI 加密；
# vault 目录在 GitHub 同步排除清单内；每源 opt-in 授权，撤销即静默。
```
**任务卡**（`07 任务/inbox/*.json`）：
```json
{"id":"...","task":"...","owner":"me","due":"...","confidence":0.0-1.0,
 "evidence_ptr":["events/2026-09-14.jsonl#ts..."],"mode":"notify|question|review",
 "status":"candidate|approved|rejected|deferred|done","created_by":"proactive"}
```
**记忆文件**（OKF 兼容子集，`%APPDATA%/PAI-Station/memories/*.md`）：
```markdown
---
type: fact|preference|skill|profile
confidence: 0.85
last_confirmed: 2026-09-14
valid_from: ... / invalid_at: null
evidence: [events/....jsonl#..., E:\...\file.md]
stale_after: 90d
---
正文（人可读可编辑；编辑回写 confidence=1.0）
```
**技能效果流**（`skills/<name>/effects.jsonl`，FR10b 回滚依据）：
```json
{"ts":"...","skill":"...","version":"v3","task_id":"...","outcome":"success|fail|degraded",
 "quality":0.0-1.0,"baseline":0.82,"note":"..."}
```
聚合规则：滚动 10 次成功率 < 基线-0.15 且样本 ≥5 → 生成"回滚建议"任务卡（mode=question），用户一键回滚=git checkout 上一 tag+基线重置。

## 4. ADR（裁决记录）

| # | 裁决 | 备选与否决理由 |
|---|---|---|
| ADR-1 | 纯用户态，不装 Windows 服务 | 服务需 UAC+Session 0 无桌面；Ollama 18 万星实证零服务可行（05 卷） |
| ADR-2 | IPC=stdlib named pipe | localhost 有防火墙弹窗；文件队列不做实时（05 卷 Tailscale 拓扑） |
| ADR-3 | SQLite 单文件（FTS5+sqlite-vec）混合索引 | LanceDB 作 A/B 备胎（schema 抽象层隔离）；Meilisearch/Typesense 无 Windows 原生二进制（02 卷） |
| ADR-4 | 多供应商 LLM 网关，GLM 免费链主 | OpenClaw 被封杀实证单供应商=定时炸弹（09 卷）；`CLAUDE_CODE_GATEWAY_*` 官方变量 |
| ADR-5 | SenseVoice-Small int8 常开，Fun-ASR-Nano 为升级位 | 同机 whisper.cpp 中文差 2.7 倍；llama.cpp runtime v0.2.6 尚年轻锁版本+留 sherpa 退路（03 卷） |
| ADR-6 | OKF 兼容子集做记忆文件格式 | 押中 Google/Anthropic 双线收敛的"记忆即文件"标准（02 卷）；schema 留 version 字段可迁移 |
| ADR-7 | skill-forge 两阶升格+eval-first 三闸 | 无考卷的自进化=腐化技能库（07 卷 DGM/Hermes 实证）；hooks 宿主强制人审 |
| ADR-8 | uv+embeddable+Inno 分发，引擎后置下载 | Python 3.14 起 full installer 官方废弃；Jan 55MB vs Ollama 1.47GB=引擎捆不捆是唯一变量（08 卷） |
| ADR-9 | AGPL/NOASSERTION 件一律"学设计不抄码" | OpenViking/Cherry Studio/Khoj 等（02 卷风险 1） |
| ADR-10 | 技能库本体=git 仓库（`%APPDATA%/PAI-Station/skills/.git`）：每次升格=commit+tag，回滚=checkout 历史版本；远端=用户自配 GitHub 私有仓（FR10b/FR14） | 版本化/回滚/异地备份三需求一次满足；无 git 则退化仅本地 commit 不推 |

## 5. 降级矩阵（附录 P 底线：服务不因单件故障停摆）

| 故障 | 降级 | 依据 |
|---|---|---|
| LLM 全链失败 | 任务卡退规则模板（正则抽动词+截止），不阻塞感知与入库 | V2 runtime 已有同构 |
| ASR 模型缺失 | 感知退 VAD+事件标签（无声学转写），打字/文件通道不受损 | — |
| Everything 未装 | 文件名层退 FTS5+rg | 02 卷风险 5 |
| 向量扩展缺失 | 检索退纯 BM25（sqlite-vec 可选依赖） | — |
| 托盘崩溃 | daemon 重拉；确认 UX 退 Windows toast | — |
| daemon 崩溃 | 看护器 5 分钟内重拉，事件流断点续写 | 判活铁律 v3 |

## 6. Phase 5b 组件接口

- `sense/asr.py::transcribe(pcm16k) -> {text, lang, events[]}`；`sense/vad_gate.py::feed(block) -> Speech|Silence`
- `memory/hybrid.py::retrieve(query, k=20, budget_tokens=32768) -> [Hit{path, layer, score, snippet}]`
- `proactive/taskcards.py::extract(events) -> [TaskCard]`；`confirm.py::present(card) -> Decision`
- `execute/agent.py::run(taskcard, context_pack) -> Deliverable{paths[], report_md}`（唯一写 `08 成果/` 的通道）
- `resident/ipc.py`：请求-响应 JSON（`ping/status/events.pause/tasks.list/tasks.decide/shell.open`）
