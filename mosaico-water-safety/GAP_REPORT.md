# GAP_REPORT — 灵珠能力 → esp-claw 映射缺口（2026-10-21）

按「灵珠85节点逐意图」扫描, 每缺口给出闭合方案。图运行时缺口=最大架构差异, 但有等价映射。

## G1. 图运行时（DAG 引擎）缺失 — 架构级, 有等价解
- 灵珠: 85节点/112边显式 DAG, 顺序编排
- esp-claw: 单 agent 循环(max 32 轮工具调用) + 事件路由 + 调度器, **无 DAG 引擎**
- **闭合**: ①确定性指令(扫描隐患/快速巡查/操作演示)→router_rules 前缀命中, 零 LLM 延迟 ②模糊意图→人设+技能目录由 LLM 路由(progressive disclosure, 与 Claude Code 同构) ③Mosaico 自家 ai_create 的 mode-enum 模式(会话首消息注入模式指令)为第三参考
- 残余风险: 逐节点等价≠逐节点复刻; 验收按「意图级行为对拍」而非节点级

## G2. 知识库检索(RAG) — 中, 需建后端腿
- 灵珠: dataset+topK10+rerank+minScore0.75
- esp-claw: 无向量检索; http_request 可调任意 API
- **闭合三选**: A. 板端静态FAQ蒸馏(1.6MB语料→精选md挂/fatfs, 零后端) B. 观澜ECS加 /api/rag(GLM栈已有) C. 第三方RAG API
- 建议: P1用A(快), P2升B(专业)

## G3. 语音播报(TTS) — 中, 净新增C开发
- 现状: 无TTS, 屏幕文字输出
- **闭合**: ESP-SR 中文 TTS(BSP 官方示例 esp-sr 中文TTS 已背书); 列为可选增强M6

## G4. 唤醒词 — 低(可接受降级)
- 现状: 按住AI键说话; 无常驻唤醒
- **闭合**: 接受按讲交互(产品上反而防误触); ESP-SR 唤醒词示例在, 列远期

## G5. 拍照→vision 接线 — 中, 依赖硬件
- 前置: 左槽摄像头模块 OV3640/SC101IOT **需另购**
- 软件: 摄像头服务已有(BSP相机+检测示例), ai_create 语音App未接相机; 需 C 侧接线(拍照→上传→vision LLM)或网页图像上传路(supports_vision 已验证)
- **闭合**: 摄像头到货前走「文字描述隐患」降级; 到货后 M5 接线

## G6. 企微 webhook — 低, 开箱
- http_request POST + allowlist 即成(固件字符串证实企微/QQ/Telegram/飞书原生集成)

## G7. 飞书台账 — 低, 开箱
- 固件内置飞书开放API(tenant_access_token→messages/files); 多维表格写入=http_request+allowlist

## G8. LLM 后端选型 — 决策项
- 工作流现用: Doubao-Seed-1.6-flash/2.0-pro + Deepseek-v4 + doubao vision
- esp-claw 原生: OpenAI兼容(含 DeepSeek/GLM/Qwen/Doubao 自定义base_url)+Anthropic
- 出厂默认: 免费 trial(device-chat)
- 建议: **DeepSeek 主**(工作流同源、esp-claw 预设、便宜) / GLM 备(观澜栈复用) / vision 用 supports_vision 兼容模型

## G9. ESP-IDF 6.2+S31 工具链 — 低但新
- S31 文档 PRELIMINARY, IDF 分支新; Windows 构建有不确定性 → 退路: 官方出厂固件已验证可跑, 我们在其源码上增量构建; 极端退路=出厂固件+Web配置+技能上传(纯配置路线, 零编译)

## G10. 灵珠版本漂移 — 提示项
- 空间有更新草稿 261015BK; 本项目按用户链接 260920A 冻结基线, 变更走重提取脚本(5分钟)

## 净新增工作量估计（批准后自主开发）
| 块 | 性质 | 量级 |
|---|---|---|
| G1 路由+技能包 | SKILL.md/rules 写作 | 中 |
| G2 RAG | P1静态蒸馏小, P2后端中 | 小→中 |
| G5 vision 接线 | C 编码(等硬件) | 中 |
| G3 TTS | C 集成(可选) | 中 |
| 固件构建+烧录 | 环境+验证 | 小 |
