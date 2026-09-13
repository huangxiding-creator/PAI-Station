# 环节5 · 24/7 Windows 常驻技术 — 调研摘要（DIGEST）

调研日期：2026-09-13 · 项数：45（全部收录 `_all.json`，每项真实 URL，GitHub 数据经 API 实测，网页经 curl 200 实测）
基线：本仓 EngOpp-Mining NJSupervisor 看护链（判活铁律 v3，四次事故迭代）已通读吸收。

---

## 一、全景表（按 A–G 分类）

### A. 常驻形态（托盘 / 服务 / 计划任务 / 启动项）

| 方案 | 形态 | 关键约束/事实 | 普通用户可装 | 相关性 |
|---|---|---|---|---|
| pystray (570★, LGPL-3.0) | 用户态托盘 | Python 3.13 菜单曾不显示（issue #188），钉 3.11/3.12 | ✅ | 4 |
| infi.systray (223★, BSD-3) | 用户态托盘 | 极简、Win 专用；2023-10 后停更 | ✅ | 3 |
| pywin32 (5603★) | 全能：原生 Shell_NotifyIcon 托盘 + NT 服务宿主 + Mutex + NamedPipe | 一包四用；服务宿主走 win32serviceutil | ✅（装服务需管理员） | 5 |
| NSSM (nssm.cc, GPL-3) | 任意 exe→NT 服务 | 崩溃自动重启+节流；2017 v2.24 后冻结 | ❌ 需管理员 | 4 |
| WinSW (14287★, MIT) | 任意 exe→服务（XML 配置） | Jenkins 标配；曾遭 Defender PUABundler 误报（issue #1083） | ❌ 需管理员 | 4 |
| Task Scheduler / schtasks | 系统机制 | 登录触发可延迟/免 UAC；MINUTE 周期看护；失败重试+历史审计 | ✅（每用户任务） | 5 |
| Registry Run 键 | 系统机制 | 最简自启但无延迟/重试；恶意软件持久化高发区，EDR 盯防 | ✅（HKCU） | 3 |
| **Session 0 隔离** | **架构约束** | 服务跑 Session 0 无桌面，"服务与桌面交互"已在 Win10 1803 删除 → **托盘必须用户态** | — | 5 |
| AlwaysUp（商业） | 服务管理器 | 证明"常驻+自愈+告警"付费市场存在 | 商业 | 2 |

### B. 同类产品怎么做的

| 产品 | 常驻设计（实证来源） | 对 V3 的启示 |
|---|---|---|
| **Ollama**（180761★，官方文档+repo app/ 目录实测） | **纯用户态**：Inno Setup（`app/ollama.iss`）免管理员装 `%LOCALAPPDATA%\Programs\Ollama`；托盘=WebView2（`wintray/`+`webview/`）；**自带 updater 与 logrotate**（更新包下载进 `%LOCALAPPDATA%\Ollama`，`app.log` 记 GUI）；无 Windows 服务；服务器场景才建议 `ollama serve`+服务工具 | 最贴近的产品级施工图 |
| **Everything**（voidtools FAQ 实测） | 双形态：托盘用户实例 + 可选 SYSTEM 服务替客户端做特权 NTFS/MFT 读取（标准用户**免 UAC**）；关掉重开靠 USN 日志补账不丢变更 | 特权工作交给可选服务、UI 永远用户态；"重启用日志补账"同构本仓断点续跑 |
| **Tailscale**（docs+changelog 实测） | tailscaled=SYSTEM 服务承载逻辑；托盘 GUI 无特权独立进程；**UI↔Service 走 named pipe**（官方 changelog 原文） | IPC 金标准：named pipe 无端口冲突/防火墙弹窗 |
| **Jan**（44445★，repo 实测 src-tauri/） | Tauri 桌面壳+本地模型服务 | 壳与服务分离；Rust 栈仅供参考 |
| **Goose**（54174★，repo 实测） | Rust 核心 `goose daemon`（会话服务器）+ `ui/desktop` Electron Forge（forge.config.ts 实证） | agent daemon 常驻+桌面壳只是客户端——与 V3 分野同构 |
| LM Studio（lmstudio.ai 200） | 闭源；托盘+`lms` CLI 后台 | 仅交互参照（docs 域本网络不可达，细节未核实） |
| Dropbox | 亿级用户常驻祖师爷；help.dropbox.com 本网络不可达 → **未核实**，不作技术依据 | 仅定位参照 |

### C. 音频/感知常开

| 方案 | 事实 | 相关性 |
|---|---|---|
| PyAudioWPatch (241★，维护中，预编译 wheels) | PyAudio/PortAudio 补丁版，WASAPI loopback 采"扬声器声"；按 `[Loopback]` 设备名筛端点，官方示例开箱即用 | 5 |
| SetThreadExecutionState（MS docs） | `ES_CONTINUOUS\|ES_SYSTEM_REQUIRED` 持续防睡；无 CONTINUOUS 只重置一次计时器；ES_AWAYMODE 假睡仍跑 | 5 |
| wakepy (260★, MIT) | `with keep.awake()` 上下文式防休眠（Win 底层即上者），防"忘了释放" | 4 |
| powercfg（MS docs） | `/setacvalueindex /setdcvalueindex` 细控合盖/睡眠，交直流分开 → 电池模式降频入口 | 3 |
| powersetting API 家族 | PowerRegisterForEffectivePowerModeNotifications 检测省电模式（单函数页 404，索引页 200） | 3 |

### D. 看护/自愈

| 方案 | 事实 | 相关性 |
|---|---|---|
| **NJSupervisor 看护链（本仓基线）** | 判活铁律 v3=进程存在∧mtime<1500s∧尾行进展证据；`--leg` 身份标记；DETACHED 拉起；taskkill /T /F 清僵尸；PAUSE 旗标；3 轮失败升级告警；收工判定**先于**进程检查 | 5 |
| supervisor（9112★） | 官方不支持 Windows（SO 高票）——Windows 上需 schtasks+锁拼装其 autorestart 语义 | 3 |
| 命名 Mutex 单实例 | CreateMutex+ERROR_ALREADY_EXISTS；进程崩 OS 自动释放句柄（优于 PID 文件）；pywin32/ctypes 可实现（tendo 仅剩 PyPI） | 4 |
| faulthandler（stdlib） | 崩溃自动留 Python 回溯，daemon 启动第一行开 | 4 |
| WER LocalDumps（MS docs） | 注册表按应用名配 DumpFolder/DumpType，原生崩溃自动落 .dmp | 4 |
| py-spy (15494★) | 不停进程 dump 挂起栈——判活 v3"进程在但不写日志"终极诊断 | 4 |
| ProcDump（Sysinternals） | `procdump -e` 异常即抓 dump，外置取证腿 | 3 |
| taskkill /T /F（MS docs） | Windows 的 kill -9 --tree；Playwright 子树必须 /T 否则孤儿浏览器堆积 | 4 |

### E. 绿色便携分发

| 方案 | 事实 | 相关性 |
|---|---|---|
| Python embeddable（官方 zip ~10MB） | 改 `._pth`+get-pip+离线 wheels（pip download → --no-index --find-links）全离线部署；不碰注册表 | 5 |
| python-build-standalone (4420★, MPL-2.0) | Astral 可再分发 Python（uv 默认源），比 embeddable 更完整 | 4 |
| uv (89759★, Apache-2.0) | Rust 单 exe 管解释器+依赖+离线缓存；自带自更新 | 5 |
| PyInstaller (13094★) | 冻结 exe；**Defender 误报著名问题**（官方 FAQ+issue #6754）；mitigation：onedir+最新版+自编译 bootloader+代码签名 | 4 |
| Nuitka (15127★, AGPL-3.0) | 真·编译为 C，误报更低；AGPL 兼容性需商务确认 | 3 |
| WinPython (2280★) | 整包便携发行对照项，体量过大 | 2 |
| Szorc 2018 长文 | 自造单 exe 打包器之路前人已趟并弃坑（PyOxidizer）→ 用成熟链 | 2 |

### F. 自动更新

| 方案 | 事实 | 相关性 |
|---|---|---|
| **Velopack** (2326★, MIT，活跃) | Squirrel.Windows 官方继任：零配置、**差分更新**、签名链、语言无关、Squirrel 自动迁移 | 5 |
| Squirrel.Windows (7980★) | 事实停更（2024-07），官方指路 Velopack；曾服务 Teams/Slack/Discord | 3 |
| electron-builder/updater (14660★) | 差分更新+灰度通道思想跨栈可借鉴 | 3 |
| Tauri updater 插件 | 若壳上 Tauri（参照 Jan）则更新器白捡 | 3 |
| winget (26417★) | 免费 manifest 进亿级用户面；但应用自动更新仍需自带 | 4 |
| Scoop (24654★) | **用户态零 UAC**，manifest=一个 JSON，自建 bucket 极易——与绿色便携最合拍 | 4 |
| Chocolatey | 企业市场/Intune 集成；个人产品靠后 | 3 |
| Inno Setup（jrsoftware） | per-user 免管理员安装+注册卸载项；**Ollama 同款**（ollama.iss 实证） | 4 |
| NSIS | Inno 备胎，曲线更陡 | 3 |

### G. 日志与可观测

| 方案 | 事实 | 相关性 |
|---|---|---|
| stdlib logging.handlers | RotatingFileHandler 轮转 + QueueHandler/QueueListener 落盘移出业务线程 | 5 |
| loguru (24104★, MIT) | rotation/retention/compression 一行；enqueue=True 内置多进程安全队列 | 4 |
| structlog (4949★) | 结构化键值/JSON 行——run-ledger 的事件表达 | 3 |
| Ollama 式 app.log+logrotate | 常驻 app 单一可发现日志文件（用户支持成本极低） | 4 |
| multiprocessing.connection（stdlib） | Listener 原生支持 Windows **命名管道路径**+HMAC authkey（docs grep×7 实证）——IPC 零依赖 | 4 |

---

## 二、推荐常驻架构（进程拓扑 + IPC）

**一句话**：全用户态四进程 —— 「主 daemon（无 UI，登录触发拉起）+ 托盘宿主（pywin32/pystray，纯客户端）+ 感知 worker（PyAudioWPatch，按需拉起）+ schtasks MINUTE 看护器（判活铁律 v3 兜底）」，daemon↔托盘用标准库 named pipe（`multiprocessing.connection.Listener` + authkey，Tailscale 同款拓扑的 Python 直译），跨重启任务交接用文件队列/run-ledger。

```
[Task Scheduler 登录触发, 免UAC, 延迟30s]
        │ 拉起(DETACHED)
        ▼
┌─ 主 daemon（python，无GUI，命名Mutex防双开）────────────┐
│  调度器 + 任务引擎 + 更新器(Velopack/下载换启)           │
│  日志: RotatingFileHandler+QueueListener / run-ledger   │
│  IPC: \\.\pipe\pai-station (stdlib Listener, HMAC)      │
└──┬───────────────┬───────────────────────────┬─────────┘
   │ named pipe     │ spawn+心跳文件             │ named pipe/localhost
   ▼               ▼                           ▼
托盘宿主          感知 worker×N                (可选)浏览器UI
(pywin32/pystray, (PyAudioWPatch loopback,
 纯客户端可崩可重) 采集窗内 wakepy 防睡,电池模式降采样)

[schtasks /SC MINUTE /MO 5 看护器]──判活: 进程∃ ∧ 心跳mtime新鲜 ∧ 尾行证据
   └─ 死→taskkill /T /F 清僵尸→分离式重拉→3轮失败升级告警→PAUSE旗标可停
   └─ 更新交接复用此链: daemon下载新版→原子换目录→自杀→看护器拉新
```

分工理由：
- **主 daemon 无 UI**：UI 是崩溃头号来源，托盘宿主可随时崩由 daemon 拉起（反向：daemon 死由看护器拉）——互为双保险但责任面清晰。
- **感知 worker 独立进程**：WASAPI/原生扩展崩溃只损失音频腿不连坐 daemon；采集窗内才 hold SetThreadExecutionState。
- **看护器是唯一系统级依赖**：每用户 schtasks 任务，普通用户可自建（本仓已验证），无服务无管理员。

**IPC 选型结论**：named pipe（stdlib 支持+authkey+无端口占用+无防火墙弹窗）> localhost HTTP（仅浏览器 UI 需要）> 文件队列（仅跨重启交接，不做实时）。

**关键评估对照**：普通用户可装性=Ollama 式 per-user Inno/绿色 zip 全免管理员 ✅；开机到可用=登录触发+常驻预热的 daemon（托盘秒连 pipe）✅；内存基线=daemon~50-80MB（embeddable+按需 import）+托盘~20MB ✅；崩溃恢复 RTO=看护器 5 分钟轮询+进程消失即判死（判活 v3 零等待分支）✅；卸载干净度=全文件在单目录+Inno 卸载项+每用户 schtasks 一并注销 ✅。

---

## 三、Top5 缝合推荐

1. **Ollama Windows 三件套**（docs.ollama.com/windows + repo app/ 施工图）——产品形态直接对标：per-user 安装+WebView2/pywin32 托盘+自带更新与 logrotate。
2. **Tailscale 服务/GUI 分离 + named pipe IPC**（tailscaled docs+changelog）——进程拓扑与 IPC 通道的权威范本。
3. **NJSupervisor 判活铁律 v3**（本仓基线）——看护器内核：三重判活+身份标记+分离拉起+升级告警，直接继承。
4. **PyAudioWPatch**（WASAPI loopback）——感知常开的唯一音频底座，预编译 wheels 开箱即用。
5. **Velopack**（Squirrel 继任，MIT 活跃）——自动更新外购件：差分更新+签名+安装器一套齐活，不重造 Squirrel。

（第 6 人：uv/embeddable 二选一作绿色运行时底座——追求极小依赖选 embeddable+离线 wheels，追求可管理性选 uv 单 exe。）

---

## 四、3 条硬启示

1. **服务 vs 用户态是产品级抉择，不是技术偏好**：Session 0 隔离（1803 后连交互检测都删了）决定托盘永远进不了服务；Ollama/Everything 的答案是"默认全用户态免管理员，服务只作为可选增强（Everything 替标准用户读 MFT）"。V3 主链路**不装任何服务**——普通用户可装性、卸载干净度、UAC 零提示全由此赢。
2. **判活只信三重判据，进程名永远不可信**：本仓四次事故（同名互顶→尾行骗过→启动即崩→收工误重拉）迭代出的"进程存在∧心跳新鲜∧尾行证据+身份标记"，比任何开源 watchdog 的默认配置都强；采纳任何看护方案（NSSM/WinSW/schtasks）都必须先过这道强度，而非反过来。schtasks 是普通用户唯一免管理员的系统级看护通道。
3. **更新交接与崩溃自愈同构，一条链两用**：daemon 下载新版→原子换目录→主动退出→看护器拉起新版——"更新"就是一次受控崩溃，复用看护链即得回滚（旧目录保留一版，新版起不来看护器/用户可一键回退）；这正是 Ollama（更新包进 %LOCALAPPDATA%\Ollama 换启）与 Velopack 的共同本质，不需要为更新单独造永生进程。

---

## 五、风险清单

| 风险 | 事实/出处 | 缓解 |
|---|---|---|
| **Defender 误报**（最高频） | PyInstaller onefile 最重（官方 issue #6754）；WinSW 亦中招（issue #1083 PUABundler） | 首选"embeddable/uv+脚本目录"免冻结路线；必须 exe 则 onedir+自编译 bootloader+EV 代码签名；首发即向 MS 提交误报申诉 |
| UAC/权限墙 | 装服务(NSSM/WinSW/pywin32 service)必弹 UAC；HKLM Run 需管理员 | 全链路 per-user：Inno per-user/HKCU/每用户 schtasks 任务 |
| 睡眠策略 | Modern Standby 机器合盖即断网断 CPU；ES_CONTINUOUS 用法错(漏 CONTINUOUS/忘释放)致整夜假活或永不睡 | 采集窗内 wakepy 上下文式 hold；电池模式降采样+拉长心跳；文档明示用户"合盖=离线"边界 |
| 端口占用/防火墙弹窗 | localhost 监听可能触发 Defender 防火墙询问 | 默认 named pipe（无弹窗）；浏览器 UI 才可选 localhost |
| schtasks 注册坑 | 本仓教训：XML/`/TR` 中 `\n` 转义损坏 Arguments 致任务静默失败 | 注册器统一走 `subprocess+参数列表`；装后立即 `/Run` 自检+回读 `schtasks /Query /XML` 校验 |
| Python 运行时漂移 | pystray 在 3.13 菜单不显示（issue #188）；embeddable 无 tk | 产品自带运行时（embeddable/uv 管理的 python-build-standalone）钉死版本，永不依赖系统 Python |
| 看护链自身误杀 | 本仓"0300 误杀"：慢页撞穿 600s 判死线被外部看护器杀 | 阈值按任务最坏吞吐定（稳态 1500s）+ 内部硬退兜底（os._exit）+ PAUSE 旗标人工熔断 |
| 单实例死锁/双开 | PID 文件残留导致永不启动；看护器与用户手点双开互踩 | 命名 Mutex（崩溃自动释放）为主+PID 为辅；看护器重拉前必杀旧进程（taskkill /T /F） |
| NSSM/WinSW 停更或误报连带 | NSSM 2017 冻结；WinSW 曾报 PUABundler | 主链路不依赖二者；仅服务器版高级选项并随包分发改名 exe |
| 卸载残留 | 服务/驱动/HKLM 残留是差评源 | 全部状态集中单目录+每用户注册点（Inno 卸载时逐一注销 schtasks 任务与 HKCU Run） |

---

### 附：未核实项（诚实标注）
- Dropbox 桌面常驻细节与 help.dropbox.com 页面：本网络 curl 000 不可达——未核实，仅作定位参照。
- LM Studio docs.lmstudio.ai：本网络不可达（000），主站 200 可达；后台模式细节未核实。
- PyOxidizer「弃维护」状态：公知印象，单页未核实（其教训经 Szorc 2018 博客佐证，URL 已验）。
- WER LocalDumps 对 python.exe 具体键值示例：MS 文档已验（LocalDumps\[应用名]\DumpFolder/DumpType 存在），未在本机实测。
