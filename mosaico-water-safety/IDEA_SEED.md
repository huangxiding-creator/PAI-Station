# IDEA_SEED — 水利安全AI助手 → ESP-Mosaico 开发板复刻

日期: 2026-10-21 | 阶段: Idea Factory / idea-intake | 状态: 待研究证实

## 原始想法（用户口述，2026-10-21）

> 我购买了乐鑫的 mosaico 开发板，希望把灵珠平台上的水利安全AI助手智能体及其工作流的能力复刻到这个开发板上。
> 官方建议是采用 esp-claw 框架进行开发。请你使用 Super-Skill 最新版本，不要跳过任意一个步骤，全面深刻理解上述资料和我的想法，提出能将水利安全AI助手智能体的功能烧录到乐鑫 mosaico 开发板上的提案。提案经我批准后，由你自主开发实施。

## 输入材料清单

| 材料 | 位置 | 状态 |
|---|---|---|
| 水利安全AI助手智能体 (bot) | https://agent-develop.rokid.com/space/7569942055279919104/bot/7695017028100292608 | 待提取定义 |
| 水利安全AI助手工作流 (workflow) | https://agent-develop.rokid.com/work_flow?space_id=7569942055279919104&workflow_id=7687555664029155328&bot_id=7695017028100292608 | 待提取定义（记忆线索: 灵珠85节点） |
| 灵珠自动化项目（既有底座） | E:\AI-Station\Linzhu-Auto | 探查中（含 linzhu/ 包、API 测试、工作流优化器） |
| 灵珠→Dify 前期侦察 | E:\AI-Station\Linzhu2Dify | 探查中 |
| 灵珠平台账号 | 14756787852（凭据不入 git，存放于 gitignored 文件） | 待登录提取 |
| esp-claw 官方教程 | https://esp-claw.com/zh-cn/tutorial/ | 研究中 |
| Mosaico 产品官网 | https://mosaico.espressif.com/zh/ | 研究中 |
| ESP-Mosaico 官方文档 | https://docs.espressif.com/projects/esp-dev-kits/zh_CN/latest/esp32s31/esp-mosaico/index.html | 研究中 |
| ESP-Mosaico 软件资源 | github.com/esp-mosaico | 研究中 |
| 关联项目: 观澜后台（水利安全AI眼镜数据后台） | http://47.120.43.20:8090/console/ · E:\AI-Station\leqi-dashboard | 已上线（同生态，非本任务依赖） |

## 模糊度评分: 3/10（低）→ Hybrid Clarification Gate 不触发，自主推进

意图清晰：以「能力复刻」为目标，把灵珠上的智能体+工作流移植到 Mosaico 板上运行。
技术未知项（esp-claw 能力边界、板上芯片规格、灵珠导出形态）全部可由研究回答，不需用户澄清。

### 留到提案中由用户裁决的开放选项（非阻塞）
1. **LLM 后端**: 板端调用哪家大模型（智谱 GLM / ROKID 同源 / OpenAI 兼容自选）——esp-claw 支持面决定选项
2. **复刻深度**: 全量工作流（85 节点）vs 核心问答+关键流程（分级实现）
3. **交互形态**: 语音对话为主（板载麦克风/扬声器）vs 触屏会话 vs 两者兼备

## 初步理解（待研究证实/证伪）

- 灵珠 = ROKID 的智能体开发平台（云端编排: 人设+知识库+工具+工作流 DAG）
- 「复刻」的现实路径大概率 = 提取智能体定义（人设 prompt/知识/技能）+ 工作流拓扑（节点/连线/参数）→ 映射为 esp-claw 的 agent 配置与工具/技能声明 → 烧录固件 → 板子经 Wi-Fi 调用云端 LLM API 完成推理
- 已知生态位: 该智能体属于「水利安全AI眼镜」产品生态（观澜后台同源），板上复刻版可作为眼镜之外的独立语音入口

## 硬约束（项目纪律）

- 删除只认用户明示指令；密钥/账号凭据永不入 git
- Chrome 进程守门（自清+计数检查+TaskStop 同步杀）；不碰 9222/9336/9337 端口浏览器
- 推送冻结: 本地 commit 可，push 需用户明示
- 数字零造假: 研究事实必须带来源链接，未证实即标 UNVERIFIED
