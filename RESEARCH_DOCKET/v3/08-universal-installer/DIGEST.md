# 环节8 普适化一键安装器 — 调研摘要（DIGEST）

> 调研日 2026-09-13。数据来源：gh api（GitHub 权威元数据 + Release 资产实测体积）+ curl 官方文档逐页核实。WebSearch/webReader 当日限流（09-26 恢复），全部关键数字换用一等来源核实；查不到的明确标"未核实"。
> 配套明细：`_all.json`（40 项，每项真实 URL）。

---

## 0. 一句话结论

**推荐安装形态**：`Inno Setup 单 exe（约 120-200MB：pywebview 轻壳 + uv.exe 17MB + embeddable Python + 离线 wheels + 模型清单）→ per-user 安装免管理员 → 首启硬件探测自动分级（8GB/16GB/GPU 三档）后台静默拉模型 → 代码与数据分离（程序在 %LOCALAPPDATA%\Programs，数据在 %APPDATA%\PAI-Station）→ Velopack delta 增量自更新 → winget 主渠道对冲 SmartScreen。`

---

## 1. 全景表（40 项，按 A-G 分类）

### A. 成功先例解剖（本地 LLM 桌面产品怎么装的）

| # | 方案 | URL | 规模 | 许可 | 安装包实测 | 关键事实 |
|---|------|-----|------|------|-----------|---------|
| A1 | Ollama | github.com/ollama/ollama | 180.8k★ | MIT | **OllamaSetup.exe = 1.47 GiB**（v0.34.0 当日 Release 实测） | Inno Setup 制作（源码 app/ollama.iss 实锤）；per-user 装 %LOCALAPPDATA%\Programs\Ollama；无 key 首启；托盘 + localhost:11434；模型在 %USERPROFILE%\.ollama\models（OLLAMA_MODELS 可改，升级保留）；巨包原因=预捆全部 GPU 后端（CUDA/ROCm/Vulkan/MLX） |
| A2 | Jan | github.com/janhq/jan | 44.4k★ | AGPL 系+商用例外 | **setup.exe = 55 MB**（v0.8.4 实测） | Electron 壳先装，llama.cpp 引擎（cortex）**首启后置下载**；本地/云双模式 |
| A3 | AnythingLLM Desktop | github.com/Mintplex-Labs/anything-llm | 66.0k★ | MIT | **410.5 MB**（v1.16.1 实测；Arm64 版 521MB） | 桌面 RAG+Agent，首启向导"选大脑"（内置引擎 or API key） |
| A4 | Cherry Studio | github.com/CherryHQ/cherry-studio | 51.7k★ | AGPL-3.0 | **win-x64-setup = 284 MB**（v2.0.14 实测，另有 portable + CN 专版同体积） | BYO-key 多供应商；中文生态最强；非技术用户实际在用=普适性真人样本 |
| A5 | GPT4All | github.com/nomic-ai/gpt4all | 77.4k★ | MIT | **744.5 MB**（v3.10.0 实测） | Qt 原生壳 + 捆绑引擎；2025-05 起仓库冷却（维护风险样本） |
| A6 | LM Studio | lmstudio.ai | 闭源 | 专有 | 未核实（约 500MB 级） | 按硬件标"works on your device"推荐模型（E 类 UX 标杆）；站点 200 OK |
| A7 | Msty | msty.app | 闭源 | 专有 | 未核实 | 一体化本地+远程客户端（辅助参照） |

**A 类解剖结论**：装包体积排序 Jan 55MB < Cherry 284MB < AnythingLLM 391MB < GPT4All 710MB < **Ollama 1470MB**。体积差 27 倍的全部秘密就一条——**引擎是否捆绑**。Ollama 的 1.5GB 换来了"任何 GPU 机器零思考能跑"，V3 面向的恰是无 GPU 大多数，可以只捆 CPU 后端。

### B. Python 应用分发

| # | 方案 | URL | 规模 | 许可 | 判定 |
|---|------|-----|------|------|------|
| B1 | **Python embeddable** | docs.python.org/3/using/windows.html | 官方 | PSF | **重大发现：full installer 与 py launcher 自 3.14 起双双 deprecated**（文档原文当日核实）。官方把"装 Python"这条路关了，embeddable/nuget 是正解。V3 内嵌解释器，用户机零 Python |
| B2 | **uv standalone** | github.com/astral-sh/uv | 89.8k★ | Apache-2.0 | **win-x64 zip 实测 16.8MB 单 exe**；`uv python install` 管解释器 + `uv sync --offline` 离线复原依赖（缓存文档核实）。B 类首选 |
| B3 | PyInstaller | github.com/pyinstaller/pyinstaller | 13.1k★ | GPL+特例 | 冻包路线：丢运行时装包能力（与技能进化冲突）、杀软误报高（未核实比例）。仅局部用 |
| B4 | Nuitka | github.com/Nuitka/Nuitka | 15.1k★ | AGPL+商用 | 真编译，构建链重、torch 系适配难。不选 |
| B5 | Briefcase | github.com/beeware/briefcase | 3.3k★ | BSD-3 | Python→原生包脚手架，可参考其打包元数据组织 |
| B6 | pynsist | github.com/takluyver/pynsist | 991★ | MIT 系 | "声明式配置内嵌 Python+wheels 产 NSIS 安装器"，与 V3 思路同构的最小实现，配置范式可抄 |
| B7 | WinPython | github.com/winpython/winpython | 2.3k★ | MIT | 便携发行版老前辈："零注册表零环境变量"原则成立，但 GB 级偏科 |
| B8 | PyOxidizer | github.com/indygreg/PyOxidizer | 6.2k★ | MIT | **停摆 21 个月**（last push 2024-12-24，API 核实）。警示：押个人明星项目=押人，押官方/Astral=押机构 |

### C. GUI 壳选型

| # | 方案 | URL | 规模 | 许可 | 体积/内存 | 判定 |
|---|------|-----|------|------|----------|------|
| C1 | **pywebview** | github.com/r0x0r/pywebview | 6.0k★ | BSD-3 | README 核实："freeze 后**不捆绑任何 GUI 工具包或 web 渲染器**，保持 exe 小"；Win 上 WinForms 窗体 + WebView2 渲染 | **V3 首选**：与 Python 后端同语言同进程，体积增量≈0 |
| C2 | Tauri v2 | github.com/tauri-apps/tauri | 111.0k★ | Apache-2.0 | 系统 WebView2 渲染，空应用数 MB 级（未核实精确值）；Rust 后端 | 次选（要更新器/托盘/自启全套基建时）；sidecar 拉起 Python |
| C3 | Electron | github.com/electron/electron | 123.0k★ | MIT | 空应用约 100-200MB、每窗百 MB 内存（未核实）；文档核实 appData=%APPDATA% | 生态最大（A 类六成在用）但与 8GB 低配目标冲突 |
| C4 | WinUI 3 | github.com/microsoft/microsoft-ui-xaml | 8.4k★ | MIT | 最轻最原生 | 仅 Windows + 无 Python 桥。不选 |
| C5 | Flutter Desktop | github.com/flutter/flutter | 178.9k★ | BSD-3 | 数十 MB 自绘引擎 | 与 Python 无协同。不选 |
| C6 | WebView2 Runtime | learn.microsoft.com/en-us/microsoft-edge/webview2/ | 微软官方 | 免费分发 | Win10/11 绝大多数预装；有官方 bootstrapper 可离线补装 | C1/C2 的唯一系统前提，安装器需探测+内置补装器 |
| C7 | localhost+浏览器（SillyTavern 范式） | github.com/SillyTavern/SillyTavern | 33.3k★ | AGPL-3.0 | 壳成本=0 | "不做壳"也被验证成立；V3 留作极低配降级模式 |

### D. 分发渠道

| # | 渠道 | URL | 规模 | 关键事实 |
|---|------|-----|------|---------|
| D1 | **winget** | github.com/microsoft/winget-cli（清单库 microsoft/winget-pkgs 11.1k★） | 26.4k★，Win10 1809+ 内置 | `winget install paistation`；提交=向 winget-pkgs 发 YAML 清单 PR，新发布者验域名所有权；微软源信誉可对冲 SmartScreen |
| D2 | Scoop | github.com/ScoopInstaller/Scoop | 24.7k★ | 用户级免管理员，受众偏开发者。顺手覆盖 |
| D3 | Chocolatey | github.com/chocolatey/choco | 11.5k★ | 企业 IT 场景。个人用户价值低 |
| D4 | GitHub Releases | docs.github.com/.../about-releases | 开源桌面 AI 事实标准 | 本调研全部体积数据即经此渠道实测；国内需镜像加速 |
| D5 | **Azure Artifact Signing**（原 Trusted Signing） | learn.microsoft.com/en-us/azure/trusted-signing/overview | 微软官方 | 文档核实：Basic/Premium SKU + identity validation + certificate profile；社区口径约 $9.99/月（现价未核实）。个人开发者签名最低成本正规路径 |
| D6 | SmartScreen/MOTW | learn.microsoft.com/.../microsoft-defender-smartscreen/ | Windows 内置 | 无签名新 exe 首启弹"已保护你的电脑"；信誉随量/时间累积。V3 分发最大现实摩擦 |

### E. 安装向导设计

| # | 范式 | URL | 要点 |
|---|------|-----|------|
| E1 | Open WebUI 首启 | docs.openwebui.com | 首用户即管理员；连供应商给逐字段表单+测试连接按钮。三层引导：本地零配置→云 key 表单→高级映射 |
| E2 | Claude Code onboarding | docs.claude.com/en/docs/claude-code/overview | ≤3 步纪律：主题→目录信任→OAuth，每步一句人话+默认项。V3"自动建模授权"抄信任确认 |
| E3 | 设备自动检测→模型策略 | lmstudio.ai/ | LM Studio"适合你的机器"徽章 / Ollama 启动探测 GPU 后端。V3 标准动作：探测→映射分级表→静默预下载，用户只确认不选择 |
| E4 | Windows 麦克风隐私引导 | support.microsoft.com/en-us/windows/827c1bf1-b2a4-93e5-3d5b-470b7dd2ee42 | 桌面应用首次用麦克风系统弹全局授权；用户曾全局关闭时必须引导到 设置>隐私和安全性>麦克风。语音环节前置卡点，向导需检测+带图指引 |

### F. 数据与更新

| # | 方案 | URL | 规模 | 要点 |
|---|------|-----|------|------|
| F1 | **%APPDATA% 代码/数据分离约定** | learn.microsoft.com（Electron 官方文档核实 appData=%APPDATA%） | Windows 事实标准 | 程序 %LOCALAPPDATA%\Programs（免管理员）、数据 %APPDATA%\<App>、模型 %USERPROFILE%\.app；Ollama 即此结构（iss 注释实锤升级保留用户 OLLAMA_MODELS）。卸载删程序留数据，升级换目录不动数据=绿色升级 |
| F2 | electron-builder | github.com/electron-userland/electron-builder | 14.7k★ | 选 Electron 则更新随包解决；其差分更新参数是自建更新的参照系 |
| F3 | **Velopack** | github.com/velopack/velopack | 2.3k★ | README 核实：零配置一条命令产安装器+**delta 增量包**+自更新 portable；Rust；**语言无关（C#/C++/JS/Rust"and more"，Python 经 CLI 接入）**；自动从 Squirrel 迁移 |
| F4 | Tauri updater 插件 | github.com/tauri-apps/plugins-workspace | 1.8k★ | v2 官方更新器，签名清单+差分，静态 JSON 即更新源；清单格式可抄 |
| F5 | **Inno Setup** | jrsoftware.org/isdl.php | Ollama 官方采用（其 build_windows.ps1 引用实锤） | 免费工业标准；.iss 脚本产单 exe：per-user、多语言、升级保留配置。"升级保留用户 env"写法直接抄 ollama.iss |
| F6 | PyUpdater（反面） | github.com/pyinstaller/pyupdater | **仓库 404**（当日核实） | PyInstaller 生态更新器岗位空缺。Python 侧别找现成更新器，用 F3/F4 包住 |
| F7 | NetSparkle | github.com/NetSparkleUpdater/NetSparkle | 829★ | appcast 清单格式第三种范本（备胎） |

### G. 硬件基线

| # | 证据 | URL | 实测/官方数据 |
|---|------|-----|--------------|
| G1 | whisper.cpp CPU ASR | github.com/ggml-org/whisper.cpp（README 原文当日核实） | tiny 75MiB/**273MB RAM**；base 142MiB/**388MB**；small 466MiB/**852MB**；medium 1.5GiB/2.1GB；large 2.9GiB/3.9GB。8GB 机器跑 base.en 毫无压力 |
| G2 | llama.cpp CPU LLM | github.com/ggml-org/llama.cpp | CPU 跑 Q4 的事实引擎（A 类产品公共底座）；7B-Q4_K_M 权重约 4.4GB、加上下文约 6GB RAM（推算口径）；社区口径笔记本 CPU 约 3-10 tok/s（**未核实**，无官方 bench 表） |
| G3 | Ollama 官方模型内存档 | ollama.com/library（当日逐页核实） | **qwen3:4b：下载 2.5GB、官方标注 requires 4GB RAM**；llama3.2:3b：2.0GB；llama3.1:8b：4.9GB（70B=43GB；405B=243GB）；8B 档 RAM 标注未逐字捕获（通行 8GB，未核实） |
| G4 | LM Studio 硬件徽章 | lmstudio.ai/lmms | 按硬件过滤模型目录的产品化样板 |

---

## 2. 推荐安装形态（V3 蓝图）

### 2.1 安装包结构

```
PAI-Station-Setup.exe                ← Inno Setup 单文件，目标 120-200MB（对比：Ollama 1470MB / Jan 55MB）
├─ app\                              → 安装到 %LOCALAPPDATA%\Programs\PAI-Station（per-user，免 UAC）
│  ├─ PAIStation.exe                 ← pywebview 壳（WinForms+WebView2，体积增量≈0）
│  ├─ uv\uv.exe                      ← 16.8MB 单文件（实测）
│  ├─ python\                        ← embeddable CPython（约 15MB，uv 托管）
│  ├─ wheels\                        ← 全量依赖 wheels 离线缓存（torch CPU 版等大头）
│  ├─ web\                           ← 前端静态资源
│  ├─ engines\                       ← 仅 CPU 推理后端（llama.cpp CPU、whisper.cpp）
│  │   （GPU 后端不捆！首启检测到 N卡 后按需下载 vllama/cuda 包，学 Jan 引擎后置）
│  └─ vpkg\                          ← Velopack 更新钩子
├─ WebView2Bootstrapper.exe          ← 极老 Win10 补 WebView2（绝大多数机器跳过）
└─ 卸载：删 app 目录 + 问一句"是否同时删除个人数据"
数据（全部在安装目录之外）：
├─ %APPDATA%\PAI-Station\            ← 配置、用户模型（自动建模产物）、记忆库
└─ %USERPROFILE%\.paistation\models\ ← 大模型文件（GB 级，永不随升级重下）
```

### 2.2 依赖策略

1. **零系统依赖**：不装 Python（官方 3.14 起 full installer 已废弃，官方反对）、不配环境变量、不写注册表（除卸载项）、不装 VS 任何东西。
2. **uv 离线复原**：安装器自带 wheels → 首启 `uv sync --offline` 建环境（断网可装）；联网后技能商店新依赖走 uv 缓存增量装——**保留可扩展性是冻包(PyInstaller)给不了的**。
3. **引擎后置**：只捆 CPU 后端；GPU 包、模型全部首启后按检测结果下载（Jan 55MB 验证过的路径）。

### 2.3 GUI 壳选择

**pywebview 首选，Tauri 次选，Electron 不选。** 理由链：工作站核心是 Python 进程（建模/采集/进化），pywebview 与其同语言同进程、freeze 后零渲染器负担（README 原文）；Tauri 适合"前端为主+Python sidecar"的团队且自带 updater；Electron 100-200MB 常驻与 8GB 目标机冲突。极低配降级：无壳 localhost+默认浏览器（SillyTavern 范式，已验证用户可接受）。

### 2.4 首启向导流程（≤3 步见价值）

```
双击安装（无 UAC 弹窗，进度条约 40 秒）
   ↓
[启动] 硬件探测（无声，2 秒）：RAM / VRAM / AVX2 / WebView2 / 麦克风权限
   ↓
Step 1 「这是你的电脑档位」  → 自动选定 L1/L2/L3（见 2.5 分级表），一句话+【开始】
                              （后台静默：uv sync --offline + 下载对应档模型，托盘进度）
Step 2 「大脑怎么来」        → 默认本地模型（零配置）；可选贴云 API key（Open WebUI 式
                              表单+【测试连接】按钮）；可跳过（先逛逛）
Step 3 「让我了解你」        → 自动建模授权（Claude Code 式信任确认）：
                              "我会在本机读你授权的资料来学习你的偏好，数据不出这台电脑"
                              【好，开始】/【以后再说】
   ↓
[桌面] 主界面可用；模型下载完在托盘气泡"你的本地大脑已就绪"
麦克风权限若被全局关闭 → 语音功能首用时弹带截图的一步指引（设置>隐私>麦克风）
```

### 2.5 硬件分级表（G 类数据合成）

| 档位 | 硬件 | LLM | ASR | 嵌入 | 运行时预算 |
|------|------|-----|-----|------|-----------|
| **L1 极限档** | 8GB RAM / 无独显 | qwen3:4b-Q4（2.5GB，官方 4GB RAM） | whisper base.en（142MiB/388MB） | 小嵌入（<500MB） | llama.cpp CPU + int4，上下文压 2k，ASR 用完即卸载内存 |
| **L2 标准档** | 16GB RAM / 无独显 | llama3.1:8b 级-Q4（4.9GB） | whisper small（466MiB/852MB） | 标准嵌入 | LLM 常驻约 6GB，ASR 按需，浏览器壳换 Edge 降内存 |
| **L3 入门 GPU** | 6-8GB VRAM（3050/4050 级） | 7-8B-Q4 全量 GPU offload | whisper small GPU | 同上 | GPU 推理，CPU 让给建模管线 |
| **L4 高档** | 16GB+ VRAM | 14B-Q4 / 8B-Q8 | whisper large-v3 | 大嵌入 | 不设上限 |

未核实项：CPU tokens/s 无官方表（社区口径 3-10 tok/s）；L1 档 8GB 同时跑 ASR+LLM 需串行调度——**低配模式的本质是内存调度器**，不是砍功能。

---

## 3. Top5 缝合推荐

1. **Ollama**（A1+F1）——抄走安装形态灵魂：Inno Setup、per-user、无 key 首启、代码/数据分离、升级保留用户配置（ollama.iss 现成写法）；但反其 1.47GB 巨包而行之（CPU 极小核+按需 GPU 包）。
2. **uv**（B2）——17MB 单 exe 托管 Python 与全部依赖，`--offline` 缓存复原实现"离线可装+日后可扩展"，直接消灭"要求用户装 Python"（官方 3.14 已废弃 full installer，此路本就关死）。
3. **Velopack**（F3）——Python 生态更新器已死档（PyUpdater 404），用这个语言无关的 delta 更新框架补上自更新+增量包，用户每次升级只下增量。
4. **Inno Setup**（F5）——安装层本体：免费、Ollama 同款、可 CI 脚本化，"卸载问是否留数据"的向导直接支持"卸载干净+数据自主"。
5. **Cherry Studio**（A4+E1）——非技术用户普适性的真人验证场：BYO-key 多供应商中文向导逐屏抄，把"云 key 可选、本地默认"的三层引导本地化。

（C 类壳选 pywebview / 渠道选 winget 属形态决策，不计入缝合名单但见 2.3/风险节。）

## 4. 三条硬启示

1. **体积的秘密只有一个变量：引擎捆不捆。** Jan 55MB 与 Ollama 1470MB 差 27 倍，差的全是预置的 GPU 运行时和引擎。V3 用户 90% 无独显——只捆 CPU 后端即可把首装压到 200MB 内，GPU 包变成"检测到 N 卡后帮你下载的可选增强"。Ollama 的教训不是"别捆"，是"为所有机器捆所有东西"；V3 的版本是"为我这台机器下载我需要的"。
2. **2026 年"让用户装 Python"已是官方反对项。** docs.python.org 现行文档：full installer 与 py launcher 自 3.14 起 deprecated。这把 B 类选择的犹豫一刀切断：embeddable+uv 是官方路线，PyInstaller/Nuitka 冻包是应急路线；同时 PyOxidizer 停摆 21 个月警告：底座必须押机构化维护（Python 官方、Astral、微软），不押个人英雄。
3. **自动更新必须借隔壁生态的轮子。** PyUpdater 仓库 404 消失，Python 桌面生态没有活着的更新器。Velopack（Rust、语言无关、delta）与 Tauri updater 证明这件事在跨语言域已解决——V3 不自研更新协议，用 vpk 命令包住 exe，把工程预算留给"自动建模"这个护城河。

## 5. 风险

| 风险 | 事实与对策 |
|------|-----------|
| **SmartScreen 拦截**（无签名新 exe 首启弹"已保护你的电脑"） | 机制见 learn.microsoft.com Defender SmartScreen 文档（核实 200 OK）。对策按性价比排序：①首发即提交 winget（微软源信誉旁路）；②官网放 sha256+引导文案"更多信息→仍要运行"；③首月积极引导用户装，下载量本身就是信誉积累。 |
| **Defender/杀软误报** | PyInstaller 冻包误报率尤其高（未核实精确比例，社区共识）；uv+embeddable 明文件布局比单 exe 冻包温和得多；提交微软误报申诉（officialfalse positive 页）作为运维 SOP。 |
| **代码签名成本** | Azure Artifact Signing Basic 社区口径约 $9.99/月（现价未核实，文档核实的是 SKU 结构：Basic/Premium + identity validation）——比传统 OV 证书（约 $200+/年）低一个量级，且密钥不落地；个体户 Certum OSS 证书社区口径约 €69-90/年（未核实，官网当日抓取失败）。策略：冷启动期无签名靠 winget，有现金流即上 Artifact Signing。 |
| **WebView2 缺失** | Win10 老机器可能无 WebView2 → 安装器内置官方 bootstrapper，联网补装；断网老机器属 L1 降级（localhost+浏览器模式）。 |
| **维护活性风险** | GPT4All（77k★）2025-05 起停摆、PyOxidizer 停更、PyUpdater 删除——V3 每引入一个依赖记录"若它死了怎么办"一行（本 docket 已为 B/F 类标注）。 |
| **国内下载链路** | GitHub Releases 直链国内不稳 → 模型默认源用镜像（hf-mirror 级）+ 断点续传；uv 缓存与 wheels 全离线兜底"装完即离线可用"。 |

---

*本文件与 `_all.json` 为环节8全部落盘物；未改动其他目录，未 git commit。*
