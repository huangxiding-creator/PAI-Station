# WBS — 水利安检卡（tracer-bear: 每任务出可验证产物, 依赖串行, 同波可并）

## Wave A（环境与底座）
- T1 WSL IDF v6.1 安装验证（build hello_world esp32s31）【跑中】
- T2 fork esp-mosaico-claw → mosaico-water-safety/firmware/（submodule 齐, 不动上游）
- T3 出厂固件原样 build 通过（bmgr esp_mosaico）→ 基线 bin

## Wave B（资产转换层, 与 A 并行）
- T4 转换器骨架 tools/lingzhu2claw/（IR+persona 解析 → 资产包生成, 幂等）
- T5 人设资产: identity.md/soul.md（3542字拆分映射）+ 开场白
- T6 router_rules.json（8意图规则, 确定性通道）
- T7 技能包×6: 知识问答/联网搜索/新闻/隐患扫描(降级版)/演示/反馈+台账
- T8 知识蒸馏: 10库 docx → knowledge/*.md（灵珠KB文档需先拉取; 拉不动则用已存docx源）

## Wave C（集成烧录, 依赖 A+B）
- T9 资产预烧进固件 → build → bin
- T10 用户插板 → 烧录 → 首次配网+DeepSeek key → 语音问答冒烟（M1 DoD）
- T11 24 意图对拍 + 30 知识题对拍（vs 灵珠版, 记录表）（M2/M3 DoD）
- T12 企微 webhook + 飞书台账实弹（M4 DoD）

## Wave D（增强, 可选/等硬件）
- T13 TTS(ESP-SR 中文) 集成（M6）
- T14 摄像头模块接线 拍照→vision（M5, 等购件）
- T15 P2 观澜 RAG 腿
- T16 收官: README/固件发布件/技能包/配置手册（M7）

任务明细与状态: .super-skill/tasks.json
