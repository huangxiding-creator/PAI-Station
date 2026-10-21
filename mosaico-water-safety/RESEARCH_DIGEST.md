# RESEARCH_DIGEST — 水利安全AI助手 → ESP-Mosaico 复刻（2026-10-21）

九渠道研究收敛。全部关键事实带来源；未证实处显式标注。

## 一、复刻对象实测全貌（灵珠平台, 只读提取于 2026-10-21）

### 智能体 bot 7695017028100292608「水利安全AI助手」
- 定位: 「扫描水利工程施工现场，赋能施工和管理人员更好地发现安全隐患，并给出专业的防范措施建议」
- 人设 prompt **3542 字符**（完整提取: RESEARCH_DOCKET/lingzhu_extract/persona_full.md）: 注册安全工程师(水利方向)+计算机视觉+水利水电安全生产管理专家混合体; 指令路由「查找危险源→DangerSource / 识别隐患→SafetyHazard / 通知整改→Send*→飞书多维表+企微」
- 模型参数: model_id=162, temp=0.3, top_p=0.7, max_tokens=4096, 短期记忆 81 轮
- 开场白: 「我是水利安全AI助手，可以为您扫描安全隐患、解答安全问题、播报安全新闻」+三条语音指令引导
- 绑定: workflow_info_list=[DangerSource], plugin=[], knowledge=4个判定清单知识库引用

### 主工作流 7687555664029155328「MainSafecon_SL260920A」(2026-09-20版)
- **85 节点 / 112 边**, flow_mode=3 对话流, status=2 已发布（与用户链接一致 ✓）
- 架构: 开始→意图识别(8类)→并行分支
  - 知识问答: 生成检索提问→知识库检索→整理→格式转换→输出+企微
  - 秘塔搜索兜底: 答案无效→深入研究→秘塔AI搜索→整理→输出+企微
  - 新闻播报: 抓取应急管理部官网+中国安全生产网→判断有新闻→整理→强制格式化→输出+企微
  - 隐患扫描: 启动相机→拍照→vision描述隐患→批处理(分析/存档/台账)→复核→处理→输出+企微同步
  - 快速巡查: 变量赋值→拍照→(同vision链)
  - 演示模式: 拍照-演示→播报×3
  - 设定项目名: 问答→变量赋值×3
  - 意见反馈: 构建会话记录→写入飞书用户反馈台账
- 注: 空间中存在更新草稿 MainSafecon_SL261015BK (7696834363203256320, 未发布); 本提案以用户链接的 260920A 为基准

### 子工作流（全部已提取 canvas）
| 工作流 | 节点 | 职责 |
|---|---|---|
| DangerSource 7575072363142709248 | 6 | 查找危险源(六项机制危险源辨识) |
| SafetyHazard 7576866274064465920 | 7 | 识别隐患(重大事故隐患清单比对) |
| SendDangerSource 7576851327515361280 | 9 | 危险源结果推送(飞书+企微) |
| SendSafetyHazard 7577365081428590592 | 9 | 隐患整改通知(飞书多维表+企微) |

### 知识库资产（空间 10 库, 有效语料 ≈1.6MB docx）
水利安全知识问答库(3文件308KB) / 手册图谱(5文件498KB) / 重大事故隐患判定标准(104KB) / 安全隐患量化判定规则 / 水利稽察知识问答(662KB) / LS法·LEC法对照表系列×9 / 水利水电工程B表C表危险源清单系列×8 / 04水利事故隐患+06水利危险源知识库
→ 全量下沉淀 <5MB, **可完整塞进板载 16MB NOR 或 128MB NAND**

### 平台机制
- 灵珠=Coze 内核; 28 个逆向 API 端点在案（Linzhu-Auto linzhu/ 包）, 提取管线复跑成功
- 提取脚本: mosaico-water-safety/scripts/extract_lingzhu*.py（只读, 端口9340, 会话新鲜）

## 二、ESP-Mosaico 板（官方 UG V1.2 + 数据手册 v0.5 PRELIMINARY）

- **ESP32-S31NRV16**: RISC-V 双核 320MHz, 16MB 片内 PSRAM, 512KB SRAM; Wi-Fi6 + BT5.4 + Thread/Zigbee
- 16MB NOR(程序) + **128MB NAND(资源)**; 2.16" 480×480 AMOLED 触摸屏; 单麦克风+功放; BMI270
- **摄像头非板载**: 磁吸左槽模块 OV3640/SC101IOT（需另购才有 vision 隐患扫描）
- 出厂固件 esp-mosaico-claw v0.5.0 (2026-10-16) = **ESP-Claw 应用**, Apache-2.0, 源码已克隆本地
- 工具链: ESP-IDF 6.2+ (`idf.py --preview set-target esp32s31`), `idf.py bmgr -c ./boards -b esp_mosaico`; USB CDC 自动烧录
- esp-claw.com 在线烧录页 **无 Mosaico 选项**（S31 仅 korvo1）→ 必须源码自建; 用户已下载的 korvo1 合并固件=**参考件, 不可烧 Mosaico**

## 三、ESP-Claw 框架（源码级核验, espressif/esp-claw 2273★ Apache-2.0）

### 已内建（≈80% 目标能力, 零开发即用）
| 能力 | 机制 | 对应灵珠能力 |
|---|---|---|
| 人设 | /fatfs/memory/identity.md + soul.md + user.md; **构建期预烧**: 改 fatfs_image/system/.recovery/ 后 rebuild 即部署 | 3542字人设 |
| 记忆 | memory_records.jsonl 自动学习 + MEMORY.md; 短期会话 | 81轮记忆 |
| 技能 | skills/<id>/SKILL.md(frontmatter+Lua可选); activate_skill 渐进加载 | 工作流分支 |
| 意图路由 | router_rules.json: 前缀/精确匹配→call_cap/run_agent/run_script/send_message; LLM 可运行时自改规则 | 8类意图识别 |
| HTTP 工具 | http_request 能力(GET/POST/…, NVS allowlist) | 新闻抓取/企微webhook/飞书API |
| 联网搜索 | cap_web_search(博查/Brave/Tavily) | 秘塔AI搜索替代 |
| LLM | OpenAI 兼容(OpenAI/DeepSeek/Qwen/GLM/Doubao)+Anthropic+custom; NVS 配 key | Doubao/DeepSeek 节点 |
| 视觉 | supports_vision 图像上传(网页聊天路已验证) | 拍照隐患识别 |
| IM | 飞书(内置 tenant_access_token 流)/QQ/Telegram/微信 | 飞书台账+企微推送 |
| MCP | client(LAN 发现)+server | 扩展位 |
| 定时 | cap_scheduler(cron) | 周期任务 |
| Web 控制台 | Wi-Fi/LLM/IM/allowlist 全图形配置 | — |
| 中文 | zh 默认, NotoSansSC 字体内置, ASR zh | 全中文交互 |

### 需净新增工（框架没有的）
1. **TTS 语音播报**: 两仓库均无 TTS（屏幕文字为默认输出）——BSP 有 ESP-SR 中文 TTS 示例可引
2. **常驻唤醒词**: 无（现为按住说话）——ESP-SR 唤醒词示例在 BSP
3. **拍照→vision-LLM 接线**: 摄像头服务在, 但语音 App 不含相机输入; 需 C 侧接线或走网页图像上传
4. **8意图→RAG 胶水**: SKILL.md 编写 + allowlist 配置（写作非编码）
5. Mosaico 出厂试用 LLM/ASR: `device-chat`/`device-asr` @ mosaico-asr.espressif.com.cn（eFuse HMAC 鉴权, 免费出厂默认）

### 音频管线现状
- ASR 两源: ①出厂 trial（免费, wss://mosaico-asr.espressif.com.cn/v1/asr/realtime）②阿里 fun-asr-realtime（BYO key）; 中文默认
- 交互: 按住 AI 键说话(20ms帧→80ms WebSocket→VAD断句)

## 四、商业模式锚点（观澜生态同构）

眼镜(硬件自购)+观澜后台(免费)+数据服务(变现) 已定——Mosaico 板载版=**第三硬件入口**, 同一智能体多端覆盖; 后续可复用观澜 GLM 栈做 RAG 后端。

## 五、结论

**零件世界级且免费合法（Apache-2.0）, 缝合点清晰, 无技术死角; 80% 能力开箱即用, 20% 为写作型胶水+可选增强。** 建议进入提案forge。
