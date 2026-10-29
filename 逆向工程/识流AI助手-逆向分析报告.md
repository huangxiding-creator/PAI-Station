# 识流AI助手（shiflow-agent）逆向分析报告

| 项 | 值 |
|---|---|
| 标的 | 识流AI助手 Setup 2.0.3.exe |
| 体积 / SHA-256 | 133,890,115 B / `d696b7aed2e6037a907920162f7c8ca8bb2532f31bd74d52b464946d2ea15627` |
| 官网 | thiflow.com（产品定位：基于视觉模型的 AI 运营智能体） |
| 内部标识 | `shiflow-agent` v2.0.3，Electron 41.x，NSIS 安装器 |
| 支持平台 | Windows / macOS；目标应用：个人微信、企业微信、WhatsApp |
| 分析日期 | 2026-10-12 ~ 2026-10-14 |
| 分析方式 | 纯静态（未执行标的任何代码） |
| 解包产物 | `逆向工程/extracted/app64/`（926 文件，550 MB） |
| 证据存档 | `逆向工程/work/rea_evidence_thiflow.json`（805 MB，REA Evidence） |

**一句话结论**：识流不是协议破解，也不是注入 Hook，而是一套"截屏感知 → 云端视觉理解 → 拟人化物理输入"的纯 RPA 系统，配合云端任务编排，把微信桌面客户端当作机器人来"看"和"操作"。

---

## 1. 分析方法与复现步骤

全部步骤可复现，脚本存于 `逆向工程/work/`。

1. **识别**：REA `open_binary` / `inspect_artifact` 判定为 PE32 NSIS 安装器；特征扫描见 `Nullsoft`@67556、`NSIS`@67565，内嵌 7z 签名@202062。
2. **切载荷**：从偏移 202062 切出 7z（逻辑长度 133,292,150 B）。载荷使用 BCJ2 滤镜，py7zr 不支持，改用官方独立版 7zr 26.04 解压。
3. **解包 asar**：`resources/app.asar`（153 MB，26,710 项）手工解析目录——`node_modules` 26,706 项（187 MB）、`out/main/index.js`（93 KB，Electron 壳）、`out/preload/index.js`、`package.json`。
4. **定位业务主体**：真正的业务逻辑在 asar 之外的 `resources/biz/index.js`（2.5 MB 压缩单行 bundle）与 `resources/renderer/`，属热更新通道。
5. **REA 应用图**：`analyze_javascript_application` 完成（Evidence `ev_0ccb2e106b048517821b3066646f0cc083048df5622626096c3660f5ff6768a3`），结果超 MCP 10 MB 传输预算，全量经 `export_evidence_bundle` 落盘存档。
6. **关键词上下文挖掘**：对 biz bundle 与 renderer bundle 做偏移上下文提取（中文在 renderer 内为 `\uXXXX` 转义）。

---

## 2. 总体架构

```
+--------------------- 本地（用户 PC） ---------------------+
|  识流AI助手.exe (210MB, Electron 41)                       |
|  ├─ out/main/index.js      壳：窗口/热更/更新器/守护        |
|  ├─ biz/index.js           业务主体（可热更新）             |
|  │    ├─ 感知：desktopCapturer 截图 + 截图缓存             |
|  │    ├─ 决策接入：SSE / wss / REST（JWT）                 |
|  │    ├─ 编排：rxEngine + 定时任务 + reply_mode            |
|  │    └─ 审计：ReplayLogger（逐步 before/after JPEG）      |
|  ├─ renderer/               设置与看板 UI（React）          |
|  ├─ helper(-win)/           进程隔离 RobotJS HTTP 服务     |
|  └─ app.asar.unpacked/      原生模块                       |
|       @thiflow/robot  四种输入后端 + wyhkm.dll             |
|       koffi / serialport / active-win / node-window-mgr   |
+-------------------- 云端 api.shiflow.com ------------------+
|  /sees/*  智能体引擎(豆包模型)   /yolo/v2/best/detect      |
|  /coze/*  工作流   任务下发(wss)   配额/授权               |
+-----------------------------------------------------------+
          |
          v  操作对象（不注入、不读内存、不碰协议）
+-----------------------------------------------------------+
|  微信 / 企业微信 / WhatsApp 桌面客户端窗口（当作人类操作）   |
+-----------------------------------------------------------+
```

### 2.1 模块地图

| 模块 | 路径 | 职责 |
|---|---|---|
| 壳进程 | `out/main/index.js` | 窗口、热更、helper 拉起 |
| 业务包 | `resources/biz/index.js` | 感知/编排/执行/审计全部 |
| 渲染层 | `resources/renderer/` | 设置面板、目标窗口选择 |
| helper | `resources/helper*/main.js` | 隔离执行键鼠（RobotJS） |
| 输入库 | `@thiflow/robot/` | 硬件/驱动级输入后端 |
| 原生依赖 | `app.asar.unpacked/` | koffi、serialport 等 |

### 2.2 热更新机制

双通道更新：

- **业务热更（自研 HotUpdater）**：GET `oss…/update-server/latest.json`（清单含 `assets{name:{file,sha256}}`、`displayVersion`、`minShellVersion`、`forceUpdate`）。逐资产下载到内存并 sha256 校验，任一失败整体放弃（all-or-nothing 不落盘）；全过则写 `userData/<name>/` 并 `tar -xzf` 解压，重启后生效。`minShellVersion` 门槛阻止旧壳装载新业务。
- **整包更新**：electron-updater 走 `app-updater/default`，4 小时检查一次；命令行 `--auto-update-url=` 可覆盖 feed（测试后门）。

**关键事实**：安装包内的 biz/renderer **从不被复制到 userData**——热缓存副本只能由 OSS 下载产生。判定规则：热版本 displayVersion > 壳版本且热缓存两文件存在才用热缓存，否则删除热缓存并清浏览器缓存目录。审计运行态必须检查 `userData/biz`。

---

## 3. 感知层（怎么"看"）

### 3.1 截图管线

- `takeWeChatScreenshot` / `captureWechatWindow`：Electron `desktopCapturer.getSources({types:["screen"]})` 按窗口 bounds × scaleFactor 裁剪，不整屏截取。
- **刻意不前置聚焦**：`focusWeChatWindow` 已改为 no-op，日志原文"忽略对 X 的前台拉起调用，避免触发截屏风控"——产品明确知晓并规避微信的截屏类风控。
- 截图缓存键：`revision-displayId-scaleFactor-bounds-cropHash`，会话内有失效代数（screenshotCacheGeneration）。
- 窗口识别：按进程窗口 owner 名匹配 `["微信","WeChat"]` / `["企业微信"]` / `["WhatsApp"]`，多窗口时再按标题 `Weixin` 等精确化。

### 3.2 布局检测（服务端 YOLO）

- 客户端 `detectYoloBestLayout` 将截图 POST 至 `/layout/detect`（上游 `/yolo/v2/best/detect`），云端跑 YOLO 返回 UI 元素边界框。
- 返回结构解析为 `parseYoloBestObservation`：`searchBar`、`chatEntrance`、`inputArea`、`conversationArea`、`dialogues`（会话列表红点）、`messages`。
- 布局结果带帧一致性校验（sourceFrameId/frameId），防止截图与检测结果错位。

### 3.3 视觉理解（豆包模型，服务端）

| 模型 | 用途 |
|---|---|
| `doubao/doubao-seed-2-0-lite-260428` | OCR、界面校验（SEARCH/DEFAULT_VISION_MODEL） |
| `doubao/doubao-seed-1-6-251015` | 文本生成、流式回复内容 |

- 调用通道：`/sees/chat/completions`（SSE），FormData 携带 `image_base64/question/prompt/is_chat/model`，JWT 鉴权，前端配额闸门（`quotaStatus==="blocked"` 即抛 `QuotaExceededError` 并向 UI 推 `count_limit`）。
- **OCR 即视觉模型**：`extractTextFromImage` 的提问是"提取首行文字"——本地无 OCR 引擎。
- **0/1 严格校验闭环**：关键动作后截图追问，要求模型只回数字。例：搜索激活校验（"只有当左上角搜索输入框已经获得焦点…返回1；否则0"）；聊天标题后验（"只有主标题完整等于目标名称时返回1…忽略群成员数"）。回答非 0/1 判失败。
- OCR 预检 `performOcrPrecheck`：先读标题区文字与目标模糊匹配，减少无效点击。

---

## 4. 决策层与云端 API

### 4.1 端点清单（biz bundle 静态提取，全部实测自代码）

**鉴权与账号**（`Authorization: JWT <token>`，非标准 scheme）：

| 端点 | 用途 |
|---|---|
| POST `/shiflow/v1/login` | 账号密码登录 |
| POST `/v1/register` `/v1/phone_code` `/v1/phone_login` | 注册/手机号登录 |
| POST `/v1/qrcode`（source:agent） | 申请扫码 ticket |
| POST `/v1/qrcode/login` | nonce 轮询换 token |
| GET `/v1/third/oauth?code=` | Google OAuth 兑换 |
| GET `/v1/accounts/settings` | 余额/订阅/权益快照 |
| POST `/v1/pay`；GET `/v1/pay/{id}/status` | 支付下单与轮询 |

扫码二维码图床借用微信官方 `mp.weixin.qq.com/cgi-bin/showqrcode`，但 ticket 由识流后端签发。设备指纹 `device_id = sha256("shiflow-device-v1\0" + MachineGuid)`，附加于全部 shiflow 域请求与 WS URL，服务端以此做单设备踢号（code 40001，`/yolo`、`/tools` 豁免）与 PPE 粘性路由。

**智能体与对话**：

| 端点 | 用途 |
|---|---|
| `/sees/tasks` CRUD + `/sees/default_agent` | 智能体任务管理 |
| `/sees/dialog/sessions*` | 会话/消息/绑定任务 |
| POST `/sees/dialog/sessions/{id}/messages/stream` | Agentic SSE 对话 |
| POST `/sees/dialog/sessions/{id}/confirm/stream` | 敏感操作二次确认 |
| GET `/v1/sees/settings`（30s 轮询） | agent_type 同步 |

**视觉/检测服务**：

| 端点 | 用途 |
|---|---|
| POST `/v1/layout/detect` | YOLO 布局（15s 超时） |
| POST `/v1/messages/detect` | 消息区识别 |
| POST `/v1/unread/detect` | 会话红点坐标（2.5s） |
| POST `/v1/observe/detect` | 观察模式 |
| POST `/v1/sees/grounding/resolve` | 截图内坐标定位 |
| POST `/v1/sees/chat/completions` | 豆包视觉 SSE（FormData） |
| POST `/v2|v3/sees/speed` | 主聊天 SSE（token 在 body） |

`/sees/speed` 的请求体直接携带整屏截图 dataURL、`enable_knowledge_base`（深思模式开）、`agent_type`、目标窗口信息——**客户端不做任何本地对话逻辑，截图即请求**。

**Coze / 企微 / 运营**：

| 端点 | 用途 |
|---|---|
| `/coze/v1/add_workflow` 等 5 个 | Coze 工作流代理 |
| POST `/wework/third/bind_secret` | 绑定企业自建应用 secret |
| POST `/wework/external_contact/qrcode` | 企微客服码+奖励 |
| `/sees/proactive/plans|reports` | 主动触达计划/报告 |
| `/sees/user_profiles*` `/sees/chat_records*` | 画像与聊天记录（可导出 xlsx） |
| POST `/tools/trace/log` | 审计轨迹上传（含前后拼接图） |

**任务推送**：`wss://api.shiflow.com/ws/shiflow/tasks?device_id=…`——连接即发 `{msg_type:"task_init", token}`，20s "ping"/"pong" 文本心跳，5s 重连间隔，30s 连接超时。

### 4.2 编排模型

云端是决策主体：智能体（sees）+ Coze 工作流定义行为，wss 下发任务；本地只负责"把手脚放进微信窗口"。配额在云端计量，客户端在每次补全前检查 `quotaStatus`。

---

## 5. 执行层（怎么"动"）

### 5.1 输入后端（优先级：Windows）

| 后端 | 形态 | 关键参数 |
|---|---|---|
| wyhkm.dll | 驱动级键鼠（koffi FFI） | 标准版/精简版（wyhr）×32/64 位 |
| AtomS3U | M5Stack 单片机，串口 | 115200 baud |
| CH9329 | 沁恒 USB HID 芯片，串口 | 9600 baud，带 ACK |
| NanoKVM | Sipeed KVM 设备，串口 | 57600 baud |
| RobotJS helper | 软件级，进程隔离 | localhost HTTP + token |

- 共同参数：容差 2px、单步 ≤25px、步进延迟 8–20ms、移动超时 1500ms、停滞阈值 5 步。
- **硬件后端的意义**：输入来自真实 USB HID 设备，操作系统与应用层均无法与真人输入区分——这是对抗微信客户端自动化检测的核心投入。
- wyhkm FFI 接口（节选）：`HKMSearchDevice/HKMOpen/HKMMoveTo/HKMMoveR/HKMLeftClick/HKMMouseWheel/HKMKeyPress/HKMOutputString/HKMSetKeyInterval(最小,最大)`——按键间隔本身可设随机区间。

### 5.2 文本输入与剪贴板流

`safeTypeString` 流程：备份剪贴板 → 写入文本 → 等 100ms → Ctrl+V → 等 200ms → 恢复原剪贴板。发送前后另有 200–300/300–500ms 随机延迟。LLM 流式回复通过 `stream_macro_keyboard` 动作**边生成边"宏输入"**，模拟真人逐段打字。

### 5.3 helper 进程隔离（现役版为 `resources/helper/main.js`）

启动链（Windows）：

1. 动态空闲端口（listen 0 取 port）+ 每次启动随机 32 位 hex token。
2. `userData/helper_temp/sh_<hex4>/` 下把自身 exe 复制为 **`sys_task_<hex4>.exe`**（进程名伪装成系统任务），并复制 icudtl.dat 等三个运行时文件。
3. `cmd.exe /c start "" /B sys_task_*.exe helper/main.js --port --token --ppid --helper-dir`，注入 `ELECTRON_RUN_AS_NODE=1`，windowsHide。
4. 主进程 ping 重试 30 × 500ms；失败用原 exe 再起一次。
5. 看门狗：每 **3000ms** `process.kill(ppid, 0)` 探活，父死自杀。

HTTP API（仅 127.0.0.1，仅 POST，token 在 JSON body 比对，错则 403）：原子动作 9 个（moveMouse/mouseClick/keyTap/keyToggle/typeString/scrollMouse/mouseToggle/getMousePos/ping）+ 复合动作 5 个（`typeStringTypewriter` 整段一次 HTTP 内逐字、`humanMoveTo` 贝塞尔、`humanClick`、`doubleClick`、`humanScroll`）。断连即取消：客户端 abort 时打字机中途停止并返回 `charactersTyped`。

`helper-win/main.js`（默认端口 58582、Bearer 头鉴权、2s 看门狗）在 biz 中**零引用**，属早期遗留件但仍随包分发——审计/攻击面清单应记入。另一个重要隔离事实：Windows 主进程 `rawRobot=null`，**主进程完全不加载 robotjs**，全部输入经 helper 或外部硬件。

### 5.4 输入协议细节（可直接照抄复用的参数）

- **CH9329 帧**：`[0x57,0xAB,0x00,CMD,LEN,payload…,SUM]`，SUM=前 5+LEN 字节累加和 &0xFF。命令码：0x01 GET_INFO（应答 0x81）、0x02 键盘（0x02→0x82 成功/0xC2 错误）、0x04 绝对鼠标、0x05 相对鼠标。
- **相对鼠标 payload**：`[0x01,buttons,dx,dy,wheel]`（left=1/right=2/middle=4，±127 补码）。绝对鼠标：`[0x02,buttons,xL,xH,yL,yH,wheel]`，12 位 HID 坐标 `round(x*4096/W)` 小端。
- **键盘报文**：8 字节 boot 协议 `[modifier,0,k1..k6]`；修饰键 ctrl=0x01/shift=0x02/alt=0x04/cmd=0x08；keyTap=报文+50ms+全零报文。
- **AtomS3U 行协议**（115200，`\n` 结尾）：`PING/MOVE dx dy/CLICK btn holdMs/KEY mask k1..k6/KEYTAP mask key holdMs/RELEASE_KEYS`，应答 `OK …`/`ERR …`；自适应步进 easing=dist/90px 线性减速，HID→逻辑像素增益 EMA 自校准（0.35 平滑）。
- **wyhkm 驱动**：`HKMSetKeyInterval(min,max)` 把按键间隔随机化下沉进 DLL；`HKMOutputString(wchar*)` 整串中文直传由 DLL 分解为 HID；moveTo 三级降级（绝对→设分辨率重试→读光标相对兜底）。

---

## 6. 拟人化与风控对策工程

| 对策 | 实现 | 数值 |
|---|---|---|
| 随机点击 | 按住时长/间隔 | 60–120ms / 30–70ms |
| 安全落点 | bbox 内偏内侧随机点 | 按元素类型定比例 |
| 拟人滚动 | 分步滚动（调用侧 3–8 步） | 生成器默认 8–20 步 |
| 随机延迟 | 动作间 | 200–300 / 300–500ms |
| 不前台聚焦 | focusWeChatWindow 置空 | 规避截屏风控 |
| 红点导航 | YOLO 找会话红点逐个点击 | 失败重试并记日志 |
| 画面 diff | pixelmatch 前后对比 | diffPercentage 阈值判定 |
| 行动-验证 | 0/1 视觉后验 | 严格单字符回复 |
| 会话审计 | ReplayLogger | 每步 before/after JPEG |
| OCR 预检 | 标题区先匹配再点击 | 减少无效动作 |
| 输入设备生命周期 | 外部 HID 探测/回收 | 800/700/1000ms |
| 截图节流 | 同参截图 100ms 缓存；空闲轮询 5s/拍 | 截屏频率本身是风控变量 |
| 红点随机落点 | 红点 bbox 内随机点 | 防"每次点几何中心"特征 |
| 剪贴板短占用 | 写前备份/回读校验/粘后即恢复 | 防侧信道感知 |
| 未读检测重试 | 2.5s 超时 × 最多 4 次 | 间隔 1s 抖动 |

补充事实：`focusWeChatWindow` 是全文件唯一出现"风控"字样之处——前台拉起被整体删除，改为纯被动窗口探测（先看当前激活窗是否匹配，再遍历窗口列表，全程不改变前台焦点）。pixelmatch 封装阈值：单像素 0.1、差异占比 >0.2% 判变化，用于"chatMain 无 diff 则不上传 YOLO"，进一步压低请求频率。ReplayLogger 审计默认关闭（`replay_enabled=false`）：会话上限 5 个、每会话 200 事件、JPEG 质量 60，含 17 种事件类型。OCR 预检能力存在但当前两个业务调用点默认关闭（`enableOcrPrecheck:!1`）。

**评价**：这套工程明确以"被检测概率最小化"为目标设计，等价于一套反检测作战条令——产品的账号安全承诺建立在持续对抗微信风控之上。

### 6.1 拟人算法公式（helper 源码级，可直接复刻）

**贝塞尔鼠标轨迹** `generateBezierPath`：

- 步数 `clamp(floor(dist/40)+floor(rand*3), 5, 15)`；
- 控制点（每分量独立随机）：`C1 = S + d·U(0,0.5) + U(-0.5,0.5)·dist·0.2`，`C2 = S + d·(0.5+U(0,0.5)) + U(-0.5,0.5)·dist·0.2`；
- 时间轴二次 easeInOut（`t<0.5 ? 2t² : 1-(-2t+2)²/2`）后取三次贝塞尔样点；
- 每点抖动 ±0.75px（两轴独立），轨迹终点强制精确落位（抖动不污染点击目标）。

**不规则延迟** `generateIrregularDelay`：Box-Muller 正态 `N(base, σ=0.4·base)`；10% 概率长停顿 `×(2+U(0,3))`（下限 10ms，模拟"看内容"）；5% 概率加速 `×0.3`；其余 `max(5, normal)`。

**拟人滚动** `generateScrollSequence`：步数 `clamp(floor(|d|/10)+floor(rand*5), 8, 20)`；步长方差随进度递增（0.3→0.7）；Fisher-Yates 打乱顺序；30% 概率每步鼠标 ±1px 微移；15% 概率附加 50–150ms 停顿；滚轮方向/像素比由用户校准并持久化。

**打字机** `typeStringWithDelay`：按 Unicode 码点分段（中文整字、emoji 代理对完整，但 ZWJ 序列会被拆散——已知瑕疵）；每字符 35–55ms 均匀延迟；`\n` 发 Shift+Enter（微信软换行防误发）；客户端断连即刻中止；无退格/纠错模拟。超时预算 `max(5000, n·(55+10)+5000)`。

**剪贴板粘贴主通道**（Windows 发文本实际路径）：预读剪贴板 → U(200,300)ms → 写入+读回校验 → U(300,500)ms → Ctrl+V → U(300,500)ms（硬件模式 U(800,1200)）→ 恢复剪贴板 → U(300,500)ms。

---

## 7. 本地引擎与任务编排

### 7.1 RxEngine 状态机（七相位）

`STOPPED → STARTING → {CAPTURING_CURRENT_CHAT | POLLING} ⇄ SWITCHING_UNREAD → RESPONSE_ACTIVE → EXECUTING → 回 POLLING`

- **POLLING 轮询节拍**：常规 tick 5s，instant tick 300–700ms 随机；每 tick 红点导航查未读。
- **RESPONSE_ACTIVE 看门狗**：25s（可配 5–120s）未收到新流式块即"断气超时"，强制回收退回 POLLING。
- **状态迁移守卫**：STOPPED 禁止"复活"；EXECUTING 中禁止跳相位（延迟补执行）；workflow 与 phase 双向钳制。
- **六作用域取消体系**（engine/task/schedule/polling/response/stream）：每作用域 AbortController + runId 代际，队列代际失效令旧任务全部作废；三层中断包装贯穿全链。
- 动作队列：串行履带（concatMap），单 action 异常不宕机，异常仅丢弃当前任务。

### 7.2 任务类型与动作词汇

- **定时任务**（云端 wss 下发）：`chat_type`（group/personal）+ `target_name` + `actions[]`；执行时 searchUserRPA 切换对话 → 逐条执行 → 回报 `/sees/task_logs/{id}/status`。
- **立即发送**（send_task_now）、**简单任务**（simple_task）、**主动触达**（proactive plans/reports）。
- `GENERIC_RUNTIME_ACTIONS` 白名单 13 个：keyboard、stream_macro_keyboard、thinking、text_prompt、simple_task、stop-reply、qps-limit、receivemessage 等；`vision_prompt`（视觉校验）、`weixin_favorites`（收藏流程）、`image`（发图）、`mini_program`（**代码在但"功能待实现"**）。
- **通用 IM 模式**：目标窗口识别扩展到小红书/抖音(tiktok)/Boss直聘/千牛——产品野心不限于微信；该模式下白名单外的动作被过滤，且不支持搜索指定联系人。
- `reply_mode` 两态：`auto`（自动物理输入）与 `assist`（辅助模式——只比对聊天区差异，不自动打字，人点发送）。
- `qps-limit` 动作：服务端限流信号 → 最多重试 10 次 × 10s。

### 7.3 Skill Server

127.0.0.1:12680（回退 12681），`/skill/start|pause|status`，CORS `*`，1024 字节上限；外部进程可经本机 HTTP 触发引擎启停（渲染层确认后执行）。

---

## 8. IPC 通道与 UI

### 8.1 IPC 面（共 171 个 handle）

| 分组 | 数量 | 代表通道 |
|---|---:|---|
| 登录与账号绑定 | 14 | REQUEST_LOGIN_QRCODE |
| 支付与积分 | 4 | REQUEST_PAY |
| 任务/Coze/文件 | 13 | RUN_COZE_WORKFLOW |
| Agentic 对话工作台 | 8 | AGENTIC_STREAM_CHAT |
| 企微对接与权益 | 7 | BIND_WEWORK_SECRET |
| 画像/记录/导出 | 7 | EXPORT_CHAT_RECORDS |
| RPA 引擎控制 | 8 | START_SCREENSHOT |
| 回放审计 Replay | 5 | GET_REPLAY_TIMELINE |
| 输入设备后端 | 11 | SET_INPUT_BACKEND |
| 目标窗口选择 | 11+4 推送 | TARGET_WINDOW_SELECTION_* |
| 视觉诊断（Test 页） | 7 | TEST_SEARCH_USER_RPA |
| 窗口/系统杂项 | 25+ | OPEN_SETTINGS_WINDOW |

**安全要点**：preload 暴露 `electron.{invoke,on,send}` **无通道白名单**——渲染层一旦被注入即可调用全部 171 个 handle（含 BIND_WEWORK_SECRET、SWITCH_API_ENVIRONMENT）。

### 8.2 UI 地图

- 一套 `index.html` 多 hash 复用出全部功能窗（主窗/设置/权限引导/快速引导）；目标窗选择是第二个 HTML（每屏一个全屏透明覆盖窗）。
- 主窗路由：/login、/wechat-qr、/chat（启动引擎页）、/tasks、/knowledge、/proactive、/account、/profile、/test；设置窗另有 /user-profiles、/chat-history、/reports、/replay 等页。
- 主渲染包为 `index-BOtWbpYn.js`（4.97MB）；`index-B2gIEWvw.js`（1.5MB）实为 markdown 高亮懒加载块，非页面代码（前期判断修正）。
- Windows 窗口枚举：utilityProcess + koffi 加载 user32/dwmapi（EnumWindows/cloaked/透明窗过滤），作为目标窗选择的数据源。

---

## 9. 本地安全态势（风险点按严重度排序）

| # | 风险 | 事实 |
|---|---|---|
| R1 | 凭据明文 | JWT/google_token 明文存 electron-store（从未启用 encryptionKey），GET_TOKEN IPC 任意渲染代码可读 |
| R2 | 更新链无端到端完整性 | generic provider 无签名；热更 manifest 无签名；tar 经 execSync 字符串拼接（注入面）；userData 代码加载零校验；Electron fuse 关闭；`--auto-update-url` 可顶替 feed——OSS 桶失陷 = 全量客户端 RCE |
| R3 | 本地未鉴权控制面 | SkillServer 127.0.0.1:12680 CORS `*` 且零鉴权，任意网页/进程可启停 RPA 引擎（drive-by） |
| R4 | helper 鉴权弱 | token 经命令行传递（进程枚举可窃）；helper-win 空 token 免鉴权分支；sys_task_* 伪装进程名会触发 EDR 启发式 |
| R5 | 二进制全部未签名 | 主程序与 wyhkm/wyhr.dll 均 NotSigned，DLL 无加载校验，同权限替换即注入 |
| R6 | IPC 无白名单 | 148+ 频道全暴露给渲染层，sandbox:false 放大 XSS 后果 |
| R7 | 强设备指纹 | MachineGuid 衍生 device_id 伴随全部 API/WSS（含 admin 公开端点），可被服务端定向 |
| R8 | 强制采集面 | 定时任务发送时 forced-scope 强制上传 before/after 截图（绕过用户关闭态）；本地 replay/click-debug/screenshots 目录留存聊天明文截图 |

正面事实：客户端不持有任何模型厂商密钥（全经其后端中转，唯一内嵌凭证是 Google OAuth client_id，属公开标识）；登录态清理（logout/踢线）做得干净；`115.190.168.210:8888` 仅为 DNS 化前的测试后端遗留映射，不参与新请求。

---

## 10. 功能面清单与能力边界

**已具备**：个人微信/企业微信/WhatsApp 自动化；定时任务（群/私聊）+ 立即发送 + 简单任务 + 主动触达（proactive）；自动回复（auto）与辅助模式（assist，只看不打字）；智能体与 Coze 工作流编排；搜索定位联系人/群；收藏流程；发图；用户画像与聊天记录导出；输入后端自动探测与降级（robotjs↔四种硬件）；回放审计；通用 IM 模式（小红书/抖音/Boss直聘/千牛白名单受限动作）。

**半成品**：`mini_program` 动作已挂载但日志"功能待实现"。

**明确不具备**（全树检索零命中）：朋友圈发布、点赞、评论；加好友自动化。

---

## 11. 合规性评估（对其用户）

1. 个人微信自动化属腾讯明令禁止的外挂行为，账号封禁风险由用户承担；产品的"安全性"来自反检测工程而非合规。
2. 聊天数据（截图/文字/记录）全量过其云端，企业使用需评估商业秘密与个人信息合规。
3. 群内自动化发言对群成员构成非告知的机器行为，存在社交信任与法规（如互联网信息服务算法推荐管理规定项下的标识义务）边缘问题。

---

## 12. 对自研系统的复用指南

### 12.1 可直接复用（合法轮子）

| 资产 | 来源 | 说明 |
|---|---|---|
| robotjs fork | github/shiflow2023/robotjs | 软件输入层 |
| koffi / serialport | npm | FFI 与串口 |
| active-win 等 | npm | 窗口管理 |
| pixelmatch / opencv-js | npm | 画面 diff 与模板匹配 |
| CH9329/AtomS3U 协议 | 芯片公开手册 | 协议参数照抄其实现数值 |

### 12.2 借鉴重写（知识复用）

拟人随机化参数表；截图-校验闭环模式；红点导航；行动审计（ReplayLogger 思想）；进程隔离 helper 模式；布局检测的元素词汇表。

### 12.3 禁止照搬

`biz/index.js`（UNLICENSED 商业代码）；`wyhkm.dll`（第三方商业驱动）；其云端服务与豆包模型通道（属其付费服务）。

---

## 附录 A. 文件地图

```
extracted/app64/
├─ 识流AI助手.exe              Electron 41 主程序(210MB)
├─ resources/
│  ├─ app.asar                 壳代码 + node_modules
│  ├─ biz/index.js             业务主体(2.5MB, 热更新)
│  ├─ renderer/                React UI(热更新)
│  ├─ helper/ helper-win/      进程隔离 RobotJS 服务
│  ├─ app-update.yml           OSS 更新地址
│  └─ app.asar.unpacked/node_modules/
│     ├─ @thiflow/robot/       四种输入后端 + wyhkm.dll
│     └─ koffi serialport active-win node-window-manager
└─ (标准 Electron 运行时)
```

## 附录 B. 证据链

- 安装器 SHA-256：`d696b7ae…5627`；7z 载荷偏移 202062，逻辑长 133,292,150 B。
- app.asar SHA-256：`bccc11620ea7b52ff5340fa75785205211182503a7b0071aaaba78574504f38c`。
- REA Evidence：`ev_0ccb2e10…6768a3`（JS 应用图）；全量包 `work/rea_evidence_thiflow.json`（805 MB）。
- 关键锚点（biz/index.js 字节偏移）：YOLO 常量 2197685；豆包模型 2162206；定时任务切换 2447145；SSE 封装 2164634。
- 分析脚本：`work/scan_installer.py`、`carve_and_extract.py`、`asar_list.py`、`ctx_extract*.py`、`exe_scan.py`、`uia_probe_weixin.py`。
- 深挖工作底稿：`work/deepdive_batch1.txt`（协议/拟人算法/壳/API 清单）、`work/deepdive_batch2.txt`（引擎状态机/IPC 与 UI 地图）、`work/deepdive_batch3.txt`（风控对策/安全态势）——8 个领域共 170+ 条发现，本报告第 4–9 章的逐条证据（含 biz/index.js 精确字节偏移）均出于此。

## 附录 C. 本机实测补充（2026-10-12）

微信 4.x（Weixin.exe，窗口类 `Qt51514QWindowIcon`）UIA 树为空（仅顶层窗口、零子节点）——**UIA 直读路线在微信 4.x 上不可用**，这解释了识流全面转向视觉方案的产品选择。

## 附录 D. wyhkm.dll native 层深挖（2026-10-14，Ghidra 12.1.4）

> 上次分析止步于 JS 调用面（wyhkm-dll.js 33 个 koffi 绑定）。本节用 Ghidra 对 `标准版/64位模块/wyhkm.dll`（337,408 B，SHA-256 `7a1e8cf9…28c60f`，分析副本 `work/wyhkm64.dll`）补齐 native 层。1169 过程 / 580 字符串。

### D1. 厂商与形态
- 版本资源（lang 0804/2052）：CompanyName **WuYa**；FileDescription **WYJSHZ模块(X64)**（五爷键鼠盒子）；Copyright 2020-2025 **无涯**；版本 **5.7.1.0**。
- **ATL/COM ActiveX DLL**（`CHKM` coclass、`LIBID_wyhkmLib`、`IHKM` dispatch、连接点事件）——面向易语言/VB 生态的原生 SDK，识流经 koffi 直接绑定导出函数。
- 比 JS 绑定多出的导出：`HKMSearchDevice2`、`HKMCheckPressedKeys`（读真实键盘按下状态，GetAsyncKeyState 实现）。

### D2. 硬件通信机制（核心）
- **导入表无 setupapi/hid/cfgmgr32**——不走 SetupAPI/HID 枚举。
- 路线：`QueryDosDeviceW` 枚举 COM 口 → `CreateFileW` 打开 `\.\COMx` → `WriteFile` 发命令 / `ReadFile` 收响应 / `DeviceIoControl` 控制 → **串口直连 USB 键鼠硬件盒**（CH9329 类协议板或五爷自有盒子，VID/PID 过滤 + `HKM_IGNORE_VID_PID=0x10000` 通配）。
- 设备管理：全局设备表 + 临界区串行化；`HKMOpen` 先查缓存命中，未命中真开串口；**deviceId = 名字槽位(低8位) | 设备实例(<<8)**，0xFFFFFFFF=FAIL。
- 结论：**OS 层面输入来自真实 USB HID 硬件**，SendInput/mouse_event 痕迹为零——这是其风控壁垒的本质，与上次结论互证。

### D3. 授权保护层（新发现）
- `.rsrc` 内 `MCR` 资源（id 201，22,677 B）= **内嵌的 CheckZoom2_64.exe**。
- 运行时（`FUN_180001e20`）：取自身 DLL 目录 → 从 MCR 资源释放 `CheckZoom2_64.exe` → `CreateProcessW` 启动 + 匿名管道 → **20 秒超时读回机器指纹授权码** → 校验后才可用。
- 指纹算法藏在独立 exe 进程里（DLL 静态分析看不到），防止内存补丁绕过——商业 SDK 按机器码授权的标准防护。识流要么持有正版授权，要么随包破解。
- 附带导入：`IsDebuggerPresent`（CRT 常规）、`GetLogicalDrives`/`GetProcessTimes`（指纹素材）。

### D4. 附带能力（导入表佐证）
- `GetPhysicalCursorPos`（物理光标，DPI 感知）+ `EnumDisplayMonitors/EnumDisplaySettingsW`（多显示器）——HKMSetAbsMouseScrnRes/HKMGetCursorPos2 的底座。
- 自带剪贴板全套（Open/Empty/SetClipboardData）——输入粘贴可不经 JS 层。
- REGISTRY 自注册资源（id 101/106）——COM 组件 DllRegisterServer 用的 .rgs。

### D5. 对自研的启示（更新）
- wxrpa 当前软输入（SendInput 系）与 wyhkm 硬件路线的差距=**OS 输入源可信度**；若后续需要对抗强风控，采购五爷盒子/CH9329 板（百元级）+ 本节协议结论即可接入，无需依赖识流代码。
- 授权机制说明该 SDK 为**买断/年费商业件**，识流的执行层成本结构里有这块授权费。

### D6. CheckZoom2_64.exe 深挖（MCR 容器解包 + 授权挑战协议，2026-10-14 续）

**解包方法**（可复现）：MCR 容器格式 = `magic"MR" | ver 1 | total | rsvd | entry_count | 条目表{bit长度, 输出大小, CRC32}`；数据位流 22,645B @offset 0x20 → 用 ctypes 加载 wyhkm.dll 调其内部解包函数（基址+0x1C550）原厂解出 **cz2_extracted.exe**（41,984B，MZ ✓，CRC 0x5405DCBB 通过，SHA-256 `556011fb…0fbe3250`，产物在 `work/cz2_extracted.exe`）。VS2010 编译，静态 CRT。

**它不是指纹采集器，是「挑战-响应式环境检测器」**：
- 启动即查 `STARTF_USESTDHANDLES`——**只认父进程管道启动**（wyhkm.dll CreateProcessW+匿名管道，20s 超时），双击直接退出：防独立分析/白嫖。
- 请求 12B `{ROL7累加校验和, len, type}` 从 stdin 读入，校验过才分发；响应经 stdout 回传、同样 ROL7 哈希封口。
- **type 1/2/3**：`GetDeviceCaps(LOGPIXELSX)` 读 DPI + `EnumDisplayMonitors` 枚举显示器几何（每屏 36B：分辨率/位置）+（type1）`SetProcessDPIAware` 前后双读——**检测 DPI 虚拟化与显示器拓扑**：VM/RDP/多开器的显示器环境与授权物理机不同，授权绑定硬件环境。
- **type 0x10**：FUN_1400016c0（另一环境探针）。
- **type 0x20**：注册窗口类 + `CreateWindowExW` + 进入 `GetMessageW` 消息循环**常驻**——CheckZoom 名字的来源：持续监听窗口/显示事件（防会议/屏幕共享期间模拟输入）。
- 导入面刻意最小（无注册表/无 WMI/无卷序列号），检测全靠 GUI 子系统 API——比常规硬件指纹更难用 hook 欺骗（检测代码在独立进程，DLL 内存补丁无效）。

**完整授权链**：wyhkm.dll 调用时 → MCR 资源释放 CheckZoom2_64.exe（已存在则跳过）→ 管道发挑战 → exe 用显示器/DPI/窗口环境应答 → DLL 校验响应 → 授权通过才允许硬件输入。三层防破解：独立进程算法 + 管道挑战协议 + 环境绑定。

### D7. 授权挑战器全链路闭环（2026-10-14 深挖续）

**探针全表**（CheckZoom2_64.exe，挑战 type → 行为）：
| type | 行为 | 检测目的 |
|---|---|---|
| 1 | `GetDeviceCaps(LOGPIXELSX)` + `EnumDisplayMonitors`(36B/屏) + `SetProcessDpiAware` 前后双读 DPI | DPI 虚拟化检测 |
| 2 | 同上，改用 `SetProcessDpiAwareness(2)`（PER_MONITOR） | 每显示器 DPI 真值 |
| 3 | `FUN_1400012d0` 显示器配置枚举 + DPI | 显示器拓扑基线 |
| 0x10 | `SetProcessDpiAwareness(1)` 后轻量枚举（16B/屏） | 快速显示器清单 |
| 0x20 | 注册 `MessageWindowClass` + **message-only 隐藏窗口**（parent=HWND_MESSAGE，不可枚举）+ 常驻消息循环 | 环境哨兵（见下） |

**初始化门槛（FUN_140001000）**：`ntdll!RtlGetNtVersionNumbers` 取版本，**< Win8（0x0602FFFF）直接拒跑**；Win8+ 才 `LoadLibrary("shcore")` 解析 `Get/SetProcessDpiAwareness` + `GetDpiForMonitor` 三件套。

**哨兵窗口 WndProc（自定义消息协议，魔数 0x361D9E72）**：
- `0xAAC8` + 魔数 → 返回 **`GetPhysicalCursorPos` 物理光标坐标**——物理光标不随 SendInput/SetCursorPos 软模拟移动：wyhkm.dll 据此**鉴别真假硬件输入**（检测宿主是否有其他软件模拟器在抢输入流）
- `0xAAC1` + 魔数 → 带口令销毁窗口（优雅下线）
- **修正早前结论**：CheckZoom 之「Zoom」= DPI 缩放（zoom）而非 Zoom 会议——整套探针全是显示器/DPI/物理输入环境检测，无任何会议软件检测。

**DLL 侧对称实现（wyhkm.dll）**：
- `FUN_18001cea0` 挑战生成 = ROL7 哈希镜像（同一 8 行算法双侧对称，静态挑战无 nonce）
- `FUN_18001ce50` 响应校验 = ROL7 自洽校验（防篡改/截断）；**内容真伪由上层与注册表授权基线比对**（ADVAPI32 导入面）

**综合定性**：五爷授权 = 显示器拓扑 + DPI 真值 + 物理光标三重环境绑定，算法双进程对称 + 管道私有 + message-only 隐藏服务窗。设计目标=防虚拟机挂机、防多开、防软件模拟器伪装、防单侧内存补丁。对识流：其硬件输入通道在非授权显示器环境/检测到软模拟时会被 SDK 自锁。

## 附录 D. wyhr.dll（精简版）与 wyhkm.dll（标准版）差异对比（2026-10-14）

| 维度 | wyhkm.dll 标准版 | wyhr.dll 精简版 |
|---|---|---|
| 体积 | 337,408 B | 175,616 B |
| 导出函数 | 81 | 73 |
| COM 注册 | ✓（DllRegisterServer 等 5 个） | ✗ |
| HKMGetError | ✓ | ✗ |
| HKMCheckPressedKeys | ✓ | ✗ |
| HKMSetDevDescInfo | ✓ | ✗ |
| 核心输入（键/鼠/轮/LED） | ✓ | ✓ 完全相同 |
| CheckZoom2 授权容器 | ✓（MCR 嵌入） | 待验证（体积差可能来自此） |

精简版定位：不需要 COM 注册的轻量部署场景（如 Electron direct load 而非 COM 调用）。

## 附录 E. AI 提示词分布分析（2026-10-14）

**核心发现：AI 对话的大脑全在服务端，客户端只是一个"手"。**

| 层 | 位置 | 提示词内容 |
|---|---|---|
| 感知校验 | 客户端本地 | 视觉模型 0/1 严格判定（搜索激活/标题匹配） |
| OCR | 客户端→服务端 | question="提取首行文字"（豆包视觉） |
| 视觉检查 | 服务端下发→客户端执行 | vision_prompt 动作，默认模板含条件判断逻辑 |
| **对话生成** | **纯服务端** | `/sees/speed` 收截图→SSE 返回 text_prompt 动作（JSON {user, system}）|
| 意图分类 | 服务端 | 客户端无本地意图逻辑 |
| 提示词模板库 | 服务端 API | GET `/prompt/records?language=cn`（需 JWT） |

客户端 `parsePromptData()` 仅做 JSON→{user, system} 拆分后透传给 `sendStreamingPromptMessage()`——实际的 prompt 工程、人设管理、上下文构造全在云端。

**对自研的启示**：识流的 prompt 工程壁垒在服务端（客户端逆向拿不到），但其架构（截图→云端决策→动作序列下发→客户端执行）可以完整复刻，配自有 LLM 网关即可。
