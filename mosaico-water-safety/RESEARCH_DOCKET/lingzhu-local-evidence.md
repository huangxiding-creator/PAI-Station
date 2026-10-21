# RESEARCH_DOCKET — 灵珠侧本地证据（Channel: 本地资产考古）

日期: 2026-10-21 | 全部为本地实测事实，来源路径已附

## D1. 灵珠平台本质 = 扣子(Coze)内核

- 来源: E:\AI-Station\Linzhu2Dify\src\coze_node_types.json（首行自述「灵珠(基于扣子)工作流节点 type 编码…来源:平台 node_template_list + 侦察 MainSafecon_SL」）
- 43 种节点类型，含完整 Dify 映射表（开始/结束/大模型/意图识别/代码/选择器/知识库检索/插件/HTTP/循环/批处理/变量赋值…）
- 工作流编辑器 API: `workflow_api/canvas`（GET/POST，canvas 数据在 `data.workflow`）、`workflow_api/apiDetail?pluginID=…`
- 推论: 「灵珠工作流复刻」≈「Coze 工作流移植」，业界已有大量 Coze→X 转换先例（本仓 Linzhu2Dify 已实现 Coze IR→Dify DSL）

## D2. 旧版水利安全工作流已全量提取（2026-07-17 快照）

- 来源: E:\AI-Station\Linzhu2Dify\output\MainSafecon_SL\workflow_ir.json（875KB, 81节点/107边）
- **注意**: 该快照 workflow_id=7642187284619460608 ≠ 用户本次链接的 7687555664029155328（新版本，需重新采集）
- desc=「水利工程施工安全生产管理核心对话工作流」, flow_mode=3
- 节点构成: 输出26 / 代码13 / 大模型9 / 选择器9 / 变量赋值6 / HTTP 4 / 插件3 / 问答3 / 拍照2 / 开始1 / 结束1 / 意图识别1 / 知识库检索1 / 文本处理1 / 批处理1
- 模型面: Doubao-Seed-1.6-flash×7, Doubao-Seed-2.0-pro×4, Deepseek-v4-flash×1, doubao-seed-1-6-vision×1（平台侧模型）
- 意图识别: 8 类路由（扫描隐患/播报新闻/知识问答/设置项目/操作演示/快速巡查/意见反馈/其它），含严格边界规则 prompt
- 知识库: dataset_id=7642337592909758464, topK=10, rerank=true, minScore=0.75
- HTTP 节点: 抓取应急管理部官网 https://www.mem.gov.cn/xw/ + 3×企业微信 webhook 推送
- 眼镜特有: 拍照节点×2（图像隐患识别链路, vision 模型）→ 板端复刻需摄像头或降级
- 9 个 LLM 节点全部含中文 system prompt（366~1741 字符），可完整迁移

## D3. 采集管线可直接复用（改 workflow_id 即可）

- 来源: E:\AI-Station\Linzhu2Dify\src\collector.py + scripts\collect_main.py
- 机制: DrissionPage 常驻浏览器（.chrome_profile 持登录态）→ 打开工作流编辑页 → 监听 workflow_api/canvas → coze_parser 解析为 IR（875KB JSON, 含每节点 raw）
- 全程只读, 不触发保存/删除
- **纪律冲突（必须处理）**: browser.py 硬编码 FIXED_PORT=9222，与「WeAIPO 9222 浏览器免打扰」铁律冲突 → 复跑时改独立端口(计划 9340)+独立 profile，用后按 Chrome 进程守门纪律杀干净
- 登录: 账密在 Linzhu2Dify/config.json（gitignored ✓ 已验证 .gitignore:98），7月会话可能过期，需重登（密码登录流程已有 recon_step1_login.py 先例）

## D3b. 旧工作流意图路由骨架（IR edges 实测, 深度3）

```
开始 → 意图识别(8类) →
  ├─ 知识问答   → 专业搜索和知识库 → 生成知识库检索提问 → 知识库检索 → 整理答案 → 输出/发企微
  ├─ 播报新闻   → 抓取应急管理部官网 + 中国安全生产网 + 获取日期范围 → 整理新闻 → 输出/发企微
  ├─ 设置项目名 → 问答设定 → 变量赋值×3
  ├─ 操作演示   → 变量赋值:演示模式
  ├─ 快速巡查   → 变量赋值 → 拍照 → vision 隐患识别
  ├─ 全面排查   → 启动相机 → 拍照 → vision 隐患识别（含复核节点）
  ├─ 其它问题   → 回应用户其它问题 → 输出到眼镜
  └─ 意见反馈   → 构建会话记录 → 写入飞书用户反馈意见台账
```
架构定性: **意图路由型对话助手** — 知识RAG + 定向网页抓取 + 会话状态变量 + 摄像头vision + 双集成(企微webhook/飞书台账)。
对板端映射的含义: 图运行时并非必须，核心= 人设system prompt + 意图路由 + 5类工具(检索/抓取/相机/通知/台账)，天然贴合 agent-loop 框架（待 esp-claw 研究证实）。

## D3c. 浏览器基线预检（2026-10-21）

- chrome.exe = 43（>30 预警线, 常驻生态在役）→ 灵珠采集须最小足迹: 独立端口 9340 + 独立profile + 单标签 + 用毕 taskkill 进程树
- 9222 未监听但铁律仍有效(WeAIPO 免打扰); 9336 = mp 控制台在监听, 勿碰

## D4. bot（智能体本体）定义尚无提取件

- 用户链接 bot_id=7695017028100292608 的人设/开场白/绑定知识库/插件/发布配置 → 需在采集时监听 bot 编辑页 API 补齐
- Linzhu-Auto 项目或有 API 封装（探查中, 见 D5）

## D5. 关联资产（同生态，非依赖）

- 观澜后台（水利安全AI眼镜数据后台）: http://47.120.43.20:8090/console/ · E:\AI-Station\leqi-dashboard（记忆: leqi-guanlan-dashboard）
- 商业模式已定: 硬件自购 + 智能体免费 + 数据服务变现 → Mosaico 板载版可纳入同一商业版图（眼镜之外的第二硬件入口）
