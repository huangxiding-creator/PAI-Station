# ReArk v1.2.0 × AI-Station 逆向能力深度整合（1102 战役实录）

> 用户令（2026-11-02）：下载 https://github.com/lkimuk/ReArk/releases/tag/v1.2.0 并与本站逆向能力深度整合。
> 本文档是整合的权威记录：安装证据、三链架构、配置件位置、冒烟实录、运维手册。

## 1. 安装账

| 项 | 值 |
|---|---|
| 安装器 | `dl/ReArk-1.2.0-windows-x64-setup.exe`（232,221,672 B） |
| sha256 | `78f00292c8e2af574161f123dc8e7963c11e16966ad34c00463f052c44773a7b`（与官方 digest 逐字一致） |
| 方式 | Inno Setup 静默装：`/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR=E:\AI-Station\reark\app /LOG=...install.log` |
| 为什么不解包审计 | innoextract 1.9 只认 Inno ≤6.0.5，此件为新 setup loader（"Unexpected setup loader revision: 2"）；已入 rea-tools\innoextract 备用 |
| 安装位 | `E:\AI-Station\reark\app\`（遵守「禁装 C 盘」纪律） |
| 技术栈 | Qt6/QML 原生（非 Electron），自带 capstone.dll / unicorn.dll / dwarf.dll / reark_frida_bridge.dll(68MB) / openssl / ffmpeg |

## 2. 三链整合架构

```
             ┌────────────── Claude Code 会话 ──────────────┐
             │                                              │
      mcp__rea__* (200+ 静态工具)              mcp__reark__* (9 工具,按靶)
             │                                              │
   REA v6.5.0 (ghidra/jadx/apktool/adb/pwn)     reark-mcp.exe --target <file>
             │                                              │
             └────── 共享 rea-tools 军械库 ──────┐           │
                                                │           │
                     ReArk GUI (动态: Frida/unicorn/内存dump/重打包/签名/复刻模式)
                                │ mcp_rea_list_tools / mcp_rea_call（内置 REA 桥）
                                └────────→ REA MCP server（经 mcp.json 自动发现）
```

- **链 A**（Claude→ReArk）：项目 `.mcp.json` 注册 `reark` 服务端 → 包装器 `E:\AI-Station\reark\bin\reark-mcp-current.cmd` 读 `E:\AI-Station\reark\target.txt`（首行=当前靶）→ `reark-mcp.exe --target`。换靶=改 target.txt+重连 MCP。
- **链 B**（ReArk GUI→REA）：ReArk 二进制内嵌字串实证——自动发现 `claude_desktop_config.json` / Cursor / `.vscode` / `.continue` 的 mcpServers，且有原生 agent 工具 `mcp_rea_list_tools`、`mcp_rea_call`。已把 REA（全 7 环境变量）写入 `%APPDATA%\Claude\claude_desktop_config.json`；显式本在 `E:\AI-Station\reark\mcp.json`（GUI 设置的 MCP 配置路径可指它）。
- **链 C**（共享军械）：rea-tools 的 ghidra_12.1.4/jdk-21/jadx-mcp/apktool/adb/pwntools/7zip(26.04)/innoextract(1.9) 同时服务两侧。

## 3. reark-mcp 9 工具（stdio，protocolVersion 2024-11-05 实测）

| 工具 | 用途 |
|---|---|
| reark_status | 服务端+靶状态（ready/sha256） |
| reark_summarize_package | 格式+17 轴能力矩阵（header/sections/imports/exports/relocations/resources/debug/strings/disasm/functions/CFG/xrefs/authenticode…），provider=hyle.package_analyzer |
| reark_list_files | 靶内已分析文件/构件清单（APK 内嵌 ELF/IPA 内嵌 Mach-O 递归） |
| reark_read_disassembly | 指定构件反汇编（capstone） |
| reark_read_source | 源码/文本构件读取（如恢复出的 JS） |
| reark_read_package_bytes | 有界字节证据（≤1MB/次） |
| reark_search_loaded_content | 已载内容全文检索 |
| reark_session_status / reark_cancel_session | 会话状态/取消 |

## 4. 冒烟实录（1102，全绿）

1. **直连**：`reark-mcp --target z.dll` → initialize + tools/list + tools/call 全通；summarize 返回 PE + `coverage: complete`。
2. **包装器链**：`cmd /c reark-mcp-current.cmd`（读 target.txt）→ reark_status `ready:true`，target 路径与 sha256 正确。
3. **配置件**：`claude_desktop_config.json` 与 `E:\AI-Station\reark\mcp.json` 均 ConvertFrom-Json 校验合法。
4. reark-mcp 版本串：`reark-mcp 1.2.0 (Wuwe 1.0.0)`。

## 5. 与站内既有逆向资产的分工

| 场景 | 首选 | 理由 |
|---|---|---|
| 快速判断格式/加壳/签名（首诊） | reark-mcp | 秒级，百余种壳识别 |
| 深度反编译/伪代码/批量取证 | REA | ghidra/jadx 级深度，200+ 工具 |
| Android 动态行为/脱壳 | ReArk GUI | Frida 桥+内存转储 |
| 重打包/签名/验签 | ReArk GUI | 有界修改+签名档位管理 |
| 自研件防破解体检 | ReArk 复刻模式 | 破解/篡改风险全面检测 |
| 安装器解包 | rea-tools\7zip / innoextract | Inno 新版例外见 §1 |

既有成果区（逆向工程/*）全部可作 ReArk 靶件：复制/引用到 target.txt 即入链。
站内 skill：`.claude/skills/reark/SKILL.md`（触发词/三链/playbook/红线）。

## 6. 升级与卸载

- 升级：新 release 同法静默装（/DIR 覆盖）；装前 `git add 逆向工程/reark E:/AI-Station/reark` 配置件（mcp.json/target.txt/bin）。
- 卸载：`app\unins000.exe`——**须用户明示令**（清理铁律）。
- GUI 设置位：注册表 `HKCU\Software\ReArk\ReArk`；Agent 会话：`%LOCALAPPDATA%\ReArk\ReArk\agent\conversations.sqlite3`。
