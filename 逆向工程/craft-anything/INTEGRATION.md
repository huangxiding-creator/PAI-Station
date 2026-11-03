# Craft Anything × AI-Station 超级逆向工具缝合实录（1103 战役）

> 用户令：下载 github.com/storytold/craft-anything，super-skill 深度研读，与站内超级逆向工具深度整合。
> 本文档 = 四链架构权威记录。源码深研报告见同目录 CRATES_DEEP_DIVE.md（ss-researcher 产物）。

## 1. Craft Anything 是什么（4029★，10-31 出生，v0.3.0）

纯 Rust「净室复刻引擎」：研究任意软件（程序/应用/包/固件/网页/游戏）→ AI agent 重建自己的版本 → 与原件对照校验 → 迭代收敛。
- **299 引擎工具/17 工具集**（core/native/web/js/dotnet/java/android/apple/firmware/pcap/db/game…），加 AI/setup 层共 315
- 自研反汇编（iced-x86 + yaxpeax-arm + eBPF/sBPF，无 capstone）+ 函数发现/CFG/xref/pseudo-C
- **18 外部引擎适配**（ghidra/adb/jadx/apktool/frida/gdb/lldb/mitmdump/binwalk/ilspy/tshark/rizin…），四级 locate（用户覆盖→托管仓→PATH→常见目录）
- **evidence 证据链**：全字段 SHA-256 规范 id（同一观察恒同 id、篡改可检）+ Confidence 三级 + provenance —— 与 REA 的证据纪律同构
- **Claude Code 一等公民**：它 spawn 我们的 `claude -p` 干构建活，把它自己的 MCP 喂给 claude；反向我们也把它的 MCP 挂进 Claude Code（双向 agent 网）
- 净室/深度双模（法律纪律内建）；`*.cany` 工程夹；egui GUI + CLI + wasm 全同引擎

## 2. 四链架构（1103 起，超级逆向工具 v2）

```
                    Claude Code 会话（总编排）
        ┌──────────┬──────────┬──────────┬──────────┐
   mcp__rea__*    mcp__reark__*  mcp__craft__*   (web 管线/复刻件)
   200+静态深钻    9 动态工具      315 全域工具
   ghidra/jadx    Frida/unicorn   净室复刻闭环
   apktool/adb    重打包/签名      Study→Build→Check→Ready
        └────── 共享 rea-tools 军械库（CA 经 config 桥认领 7 台引擎） ──────┘
```

| 链 | 入口 | 强项 | 分工 |
|---|---|---|---|
| A: REA | `mcp__rea__*`（rea-runtime） | jadx-mcp 反编译/浏览器观测/批量取证 | Android/JS 深钻 |
| B: ReArk | `mcp__reark__*`（reark/bin） | Frida 插桩/unicorn 仿真/重打包/复刻模式 | 动态运行时 |
| C: 军械 | rea-tools | ghidra/jdk21/adb/apktool/frida/mitmdump | 三方共享 |
| **D: Craft** | `mcp__craft__*`（craft-anything/bin/ca-mcp.cmd） | **315 工具全域 + 净室复刻自动闭环 + 固件/pcap/游戏文件/.NET** | 证据链调查 + 自动复刻 |

## 3. 部署账（1103）

- 本体：`E:\AI-Station\craft-anything\app\craft-anything-0.3.0-windows-x64-portable\`（官方 x64 portable，65.8MB；GUI+CLI 双 exe）
- 源码：`逆向工程\craft-anything\github\craft-anything\`（浅克隆）+ 深研报告 `CRATES_DEEP_DIVE.md`
- 配置：**portable 版配置在 exe 旁 `CraftAnythingData\config.toml`**（坑：%APPDATA% 的同名文件不被读，已留置备忘）
  - `deep_mode=true` + `[engines.ghidra]`→rea-tools + `[engines.tools]` 桥 7 台（ghidra/adb/apktool/java/chromium/frida/mitmdump 全 ok）
- MCP 注册：项目 `.mcp.json` → `craft` 服务端 = `craft-anything\bin\ca-mcp.cmd`（`mcp --deep --all-tools --project E:\AI-Station\craft-anything\projects\station.cany`）
- 技能：`craft-anything`（官方 skill 手装到 ~/.claude/skills，避 setup 乱写用户级配置）
- 实测：doctor healthy；wrapper 握手 proto 2025-06-18；**tools/list=315**

## 4. 使用心法

- **调查某软件怎么运作**（证据链）→ craft 工具（core_target_open 起）或直接用 craft-anything 技能
- **自动复刻**（站内复刻件纪律自动化）→ `craft-anything-cli rebuild <目标> "<要求>"`（它拉起我们的 claude 干构建）
- **纯静态深钻/批量** → REA；**动态插桩/脱壳** → ReArk；**多域杂烩目标**（固件/pcap/游戏包） → craft
- jadx CLI 站内没有（只有 mcp jar）→ Android 反编译走 REA 或 CA+Ghidra
- 大结果自带摘要+分页（core_evidence_browse）；Claude Code 客户端自动降 80KB 预算（CA 内建特判）

## 5. 升级/运维

- 新版：同法换 portable 包 + 迁 `CraftAnythingData\config.toml`；升级前 git commit 本目录档案
- `craft-anything-cli doctor` = 一键体检；`commands` = 工具清单
- rebuild 需本机 claude 已登录（我们的常驻环境天然满足）
