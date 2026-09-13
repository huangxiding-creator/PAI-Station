# WBS — PAI-Station V3（Phase 6 · 一周任务分解）

> 2026-09-13 ｜ tracer-bullet 垂直切片：每个里程碑端到端可跑，而非水平分层堆砌
> 执行纪律：C8 全自主不跳步 ｜ TDD ｜ 小提交 ｜ run-ledger 记账 ｜ 红线全程

## M1 常驻骨架+语音感知（Day 1-2）

| # | 任务 | 产出 | 测试 |
|---|---|---|---|
| 1.1 | resident/ipc.py named pipe 协议 | 请求-响应 JSON+authkey | 往返延迟+坏包 |
| 1.2 | resident/daemon.py 事件环 | Mutex+心跳文件+faulthandler+事件调度 | 双开拒绝/心跳过期 |
| 1.3 | resident/watchdog.py 看护器 | 判活铁律 v3 移植+PAUSE+更新交接 | 杀进程自愈（真进程） |
| 1.4 | sense/audio.py 双路采集 | mic+loopback+静音保活 | 采集 10s 出 PCM |
| 1.5 | sense/vad_gate.py | silero-vad ONNX | 语音/静音分段 |
| 1.6 | sense/asr.py | SenseVoice int8+模型管理器（下载/缓存/降级） | 中文样本 CER 抽检 |
| 1.7 | sense/voice_events.py→事件流 | jsonl 落盘+schema 校验 | 端到端：说话→事件 |
| 1.8 | resident/tray.py 托盘 | pywin32 托盘+pipe 客户端+暂停菜单 | 托盘操作生效 |

## M2 无限上下文（Day 2-3）

| # | 任务 | 产出 |
|---|---|---|
| 2.1 | memory/embeddings.py | bge-m3 ONNX int8 推理+水位线增量 |
| 2.2 | memory/hybrid.py | 四路检索+RRF 融合+token 预算 |
| 2.3 | Everything 接入 | es.exe 子进程封装+降级路径 |
| 2.4 | memory/layers.py | L0/L1/L2 摘要生成+按需加载 |
| 2.5 | 检索注入接线 | agent 上下文包装配（金标准问答集 20 条） |
| 2.6 | sense/cloud/ 连接器框架 | connector 协议+注册表+session vault（DPAPI）+RateLimiter 四件套+水位线增量（FR15）；首个示例连接器=飞书文档（复用 channels/feishu 登录态经验） |

## M3 任务发现+确认（Day 3-4）

| # | 任务 | 产出 |
|---|---|---|
| 3.1 | proactive/taskcards.py | LLM 任务卡抽取+证据指针 |
| 3.2 | proactive/budget.py | 置信分档+打扰预算 |
| 3.3 | proactive/confirm.py | 三模式+toast+晨报 digest |
| 3.4 | 语音→待办金标测试 | 会议样本→晨报含正确待办 |

## M4 执行闭环（Day 4-5）

| # | 任务 | 产出 |
|---|---|---|
| 4.1 | execute/agent.py | 多供应商网关+子代理执行+断点 |
| 4.2 | execute/deliver.py | 成果落 08+回执+企微 |
| 4.3 | 端到端 E2E | 语音"调研 Z"→确认→次日交付（模拟时钟） |

## M5 用户建模（Day 5-6）

| # | 任务 | 产出 |
|---|---|---|
| 5.1 | profile/model.py | 五层画像+双时间线+四操作 |
| 5.2 | profile/night.py | 夜间整理窗口任务 |
| 5.3 | Obsidian 镜像 | 画像镜像可编辑+回写 |

## M6 打包+进化 v0（Day 6-7）

| # | 任务 | 产出 |
|---|---|---|
| 6.1 | dist/ 硬件分级 | 探测器+三档配置映射 |
| 6.2 | dist/ 首启向导 | 3 步（档位/大脑/授权） |
| 6.3 | Inno+uv 打包 | 单 exe+离线 wheels+后置模型下载 |
| 6.4 | skills/forge.py 案例层+版本化 | 信号→案例条目（升格闸留位，永不自批）；技能库 git 化：升格=commit+tag，回滚=checkout（FR10b） |
| 6.5 | skills/effects.py 效果跟踪 | 使用结果 effects.jsonl→滚动成功率 vs 基线→回滚建议任务卡→一键回滚+基线重置 |
| 6.6 | skills/sync.py GitHub 备份 | 用户自配仓库 git 推送（FR14）；.gitignore 硬排除 secrets/authkey/事件流；断网积压补推 |
| 6.7 | skills/seed.py 成果反推 | 扫描 08 成果/→LLM 反推→SKILL.md 候选（全自动，激活走晨报确认，FR16） |
| 6.8 | skills/market.py 接口预留 | 技能包 author/version/license/price 元数据+导入导出（FR17 市场闭环后置） |
| 6.9 | 干净环境验收 | 虚拟机/新用户目录双击跑通 M1-M4 |

## 横切（全程）

run-ledger 记账 ｜ 每模块单测（≥80%）｜ git 小提交（feat/test/fix）｜ 每日心跳自检（cron :23 已建）｜ Phase 9 QA 扫尾+Phase 10 Ralph 瓶颈轮+Phase 12 进化复盘
