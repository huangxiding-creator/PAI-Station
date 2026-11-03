# craft-anything 13-crate 深度解剖

仓库: github.com/storytold/craft-anything（本地: E:\AI-Station\逆向工程\craft-anything\github\craft-anything）
实测 (gh api 2026-11-03): 4029 stars / 655 forks / 127 open issues / pushed 2026-11-02，license 双许可 MIT OR Apache-2.0（GitHub 主显 Apache-2.0）。定位: 指向任意软件（网站/桌面/手机/游戏/文件），检查取证，AI 编码代理仿建，与原版对比校验，迭代。100% Rust、unsafe_code = forbid（workspace Cargo.toml:66-67）。

## 1. 13 crates 总览（职责 + 关键公开类型 + 实测规模）

| crate | 职责（Cargo.toml description + lib.rs 实读） | 关键公开项 | 规模 |
|---|---|---|---|
| evidence | 一切工具的统一返回类型: 证据记录/规范id/置信度/未知项/错误契约 | Evidence, EvidenceBuilder, Confidence{Observed,Derived,Inferred}, Authority, Subject, Environment, Coverage, Location, Unknown, ToolError, ErrorCode, is_evidence_id | 4文件 895行 |
| formats | 纯独立文件格式解析器（零workspace依赖/零IO/任意输入不panic） | 68个pub mod: elf/pe/macho/dex/dotnet/il2cpp/java_class/wasm/evm/go/dart/pyc/plist/codesign/authenticode/asar/arsc/apk_sign/har/pcap/sqlite/unity系列/unreal系列/godot_pck/solana/sourcemap 等 | 77文件 41,616行 |
| disasm | 自研原生引擎: 解码/函数发现/控制流/交叉引用/pseudo-C | decode::decode, Mode{X16,X32,A32,T32,A64}, Image, Program::analyze, Function, Block, Xref, pseudo, dataflow, sbpf | 8文件 5,598行 |
| js | JS/Electron/web bundle 静态分析（oxc 纯Rust解析，深嵌套降级为token扫描） | 见 crates/js/src/lib.rs:1-7 | 14文件 5,297行 |
| analysis | 把已解析目标转成证据的分析器 | 16 mod: native, js_app, js_compare, js_inventory, js_ledger, js_projection, js_trace, java_decompile, function_match, standin, web_har, web_scripts | 15文件 9,404行 |
| platform | 原生平台服务: 受管进程/抓取/沙箱/引擎仓库 | process（进程组/Job Object 超时杀）, capture, serve, standin_server, which, window, fs, cancel, sync | 10文件 5,020行 |
| engines | 可选外部引擎适配器（Ghidra/adb/Chromium/Frida/JADX等），Clean room 全不需要 | ENGINES 表, locate（用户覆写→托管store→PATH→标准安装位）, Install{Manual,Pinned,Guided}, Pin(URL+SHA-256) | 20文件 8,391行 |
| engine | 核心引擎: session/项目/工具注册表（所有界面统一分发）/设置/任务 | Engine::call, Registry, Session, ToolSpec, Toolset, Effects, Consent, CallOptions, clean_room, inbox, journal, project | 86文件 53,045行 |
| ai | AI 后端 + 代理循环 + crew | AiHub, Conversation, AgentEvent, BackendKind{Anthropic,Openai,Openrouter,OpenaiCompatible,AgentCli}, cli_agents/, rebuild/ | 49文件 18,445行 |
| mcp | MCP 服务器（自实现 JSON-RPC，零SDK依赖） | serve_stdio, serve, Server, ServerOptions::from_env, PROTOCOL_VERSIONS, prompts::PROMPTS | 3文件 1,282行 |
| setup | 接入编码代理客户端: 检测/规划/合并配置(保注释)/备份/回滚/doctor/卸载 | Host::current() + clients.rs 21个宿主 add(...) 注册 | 9文件 2,359行 |
| ui-egui | egui 界面: Simple(小白)/Advanced(全工台) 双模式 | CraftApp（apps/craft-anything/src/main.rs 装配）; UI线程永不阻塞, worker线程+每帧排空channel | 33文件 14,412行 |
| testkit | 测试助手 + 合成样本构建器 | 同一手写汇编程序包进各容器(exe/elf/macho/apk等), 含测试内 RSA/p256 真签名 | 18文件 8,324行 |

## 2. 深挖①: crates/mcp — MCP 服务器（crates/mcp/src/lib.rs，3文件1282行）

- 传输: 仅 stdio（换行分隔 JSON-RPC 2.0）。lib.rs:101 serve_stdio(engine, opts)；泛型 serve(reader,writer) 供测试。无 HTTP/SSE。协议版本 2025-06-18 / 2025-03-26 / 2024-11-05（lib.rs:33），不支持 batch（-32600）。零 MCP SDK 依赖（Cargo.toml 仅 serde/serde_json/log + 3个内部crate）。
- 启动: craft-anything-cli mcp [--all-tools] [--inbox 目录]（apps/craft-anything-cli/src/main.rs 的 Command::Mcp）。环境变量 CRAFT_ANYTHING_MCP_ALL_TOOLS=1 与 CRAFT_ANYTHING_MCP_MAX_RESPONSE_BYTES（下限64KB）。
- 工具来源: 本 crate 不定义工具，全部转发 Engine::call（Caller::Mcp）。默认只列 core 工具集 + 两个元工具:
  - list_toolsets（无参数）: 列 17 个工具集及各自工具数与启用状态;
  - enable_toolset {toolset: id 或 "all"}: 激活后发 notifications/tools/list_changed（lib.rs:356-365）。
  - 引擎工具 299 个（docs/tools.md 生成清单），17 工具集: core 34 / native 55 / apple 14 / formats 36 / managed 8 / android 14 / java 6 / adb 24 / browser 22 / javascript 11 / runtime 14 / frida 9 / application 17 / database 1 / projects 19 / setup 9 / build 6。README 称 314 = 299 引擎工具 + AI/setup 层（rebuild_*/assets_key_*/setup_*）。工具 id 即 MCP 工具名（snake_case），CLI 用 kebab-case（engine/src/tool.rs:268-281 ToolSpec）。
- 方法面: initialize（协商版本+按客户端名降预算）/ ping / tools/list / prompts/list / prompts/get / resources/list / resources/read / resources/templates/list / completion/complete / logging/setLevel; 通知: cancelled / initialized / roots/list_changed。
- Resources: evidence://<id>（证据记录 JSON）与 investigation://brief|plan|hypotheses|findings|handoff|state。
- Prompts 六个（crates/mcp/src/prompts.rs，带参数补全）: core_feature_explain, app_graphs_compare, app_rebuild_claim_check, native_crash_explain, core_unknowns_review, runtime_run_plan。
- 可直接借鉴的工程细节:
  - Claude Code 专项: initialize 时客户端名以 claude-code 开头，响应预算自动降到 80KB（CLAUDE_CODE_RESPONSE_BYTES, lib.rs:39-42，注释点名 MAX_MCP_OUTPUT_TOKENS 约25k token）;
  - 超预算结果摘要优先折叠: 全量留档，返回 summary + evidence://<id> 指针 + continue_with: core_evidence_browse（lib.rs:546-570）;
  - 目标内容防注入: 工具声明 Effects::CARRIES_TARGET_CONTENT 时响应加 _meta.provenance.from_target=true 并附加提示文本（lib.rs:527-541）;
  - 同意门: 跑代码/动设备的工具默认 consent_required，可走 app inbox 等人批30分钟（lib.rs:489-497）或 --allow-run; 进度通知100ms节流 + 取消令牌齐备。

## 3. 深挖②: crates/disasm — 自研反汇编引擎

- 无 capstone。x86 16/32/64 用 iced-x86 1.21，ARM A32/T32/A64 用 yaxpeax-arm 0.5（decode.rs:1-2，workspace Cargo.toml:58-60），统一解码成架构无关 Insn; Mode 枚举 = X16/X32/X64/A32/T32/A64。
- 另有 eBPF / Solana sBPF 清洁室解码器（sbpf.rs:1-12，8字节定长 ISA + Solana 扩展 + 版本差异标注）。WASM 走 wasmparser/wasmprinter（formats 层）。
- Program::analyze（lib.rs:3-8）: 函数发现（入口/符号/导出/容器函数表/调用目标/代码指针/序言扫描），基本块划分 + 跳转表恢复，交叉引用/字符串引用/调用图。pseudo 把单函数提升为 pseudo-C; dataflow 建寄存器 def-use 图; arity 推断函数元数。全程有界、可取消、任意敌意输入不 panic（Control trait）。

## 4. 深挖③: engines（复数）vs engine（单数）

- crates/engines = 外部工具适配层。ENGINES const 表（table.rs:326-410）共 18 项: ghidra（Guided 引导安装）、adb、jadx、apktool、chromium（含 Chrome/Edge/Brave 多可执行名）、frida、gdb、lldb、mitmdump、binwalk、unblob、ilspy、java、tshark、objdump、rizin、rtl433、vineflower。Install 三型: Manual / Pinned（版本化 URL+SHA-256 下载校验）/ Guided（Ghidra+Java）; locate 四级查找: 用户覆写、托管store、PATH、标准安装目录。子模块: ghidra/（client+protocol，analyzeHeadless RPC）、cdp.rs（Chrome DevTools 协议）、adb、frida、jadx、rizin、cutter、gdb、game.rs、assets/fal.rs、mcp_client.rs（外部 MCP 服务代理）、wasm_plugin.rs（feature 门）。定位 = 第二意见与 Deep 模式增强，Clean room 模式零外部依赖。
- crates/engine = 中枢。桌面UI/CLI/MCP/内置AI 全部走 Engine::call(tool_id, params, opts)（engine/src/lib.rs:1-5）: 查可用性与同意、执行、记录证据、panic 转错误。Registry 装载 299 工具（tools/ 目录60个文件按域分组），支持运行时工具（插件与外部 MCP 代理，RuntimeTool，注册表校验 id 形如 ^[a-z0-9_]{1,64}$）。研究/构建/校验不是三个引擎，而是同一工具面 + clean_room.rs（浅/深模式工具白名单门）+ project.rs（Study, Build, Check, Ready 项目状态机; 工程夹 *.cany 内含 craft.json / capture/ / app/ / checks/ / investigation.cany / inbox/）+ self_test.rs（构建结果自检）。MIN_TOOLS=271 的下限测试防工具数倒退（tool_list.rs:10）。

## 5. 深挖④: crates/evidence — 证据链数据模型（crates/evidence/src/lib.rs）

- Evidence 结构（lib.rs:198-229）字段: id（ev_ + 64位hex）/ subject（kind: native,electron,apk,managed,website,capture,device + sha256 + name）/ operation（产出工具名）/ params / result / summary（人读一两句，不入id）/ confidence（Observed=直接读到字节头与抓包; Derived=确定性计算如CFG调用图; Inferred=启发式命名或模型猜测; 另有面向小白的 plain_label: Seen it / Worked it out / Best guess）/ authority（original-files, our-run, earlier-record, outside-service, reasoning）/ environment（clean_room 布尔 + engine 名(builtin/ghidra/jadx/adb/cdp等) + engine_version + host + language_id 如 RISCV:LE:64:RV64GC）/ limitations（稳定码如 stripped_binary, indirect_calls_unresolved）/ coverage（complete/partial + examined/total + next_offset 分页数学）/ locations（address, file_offset, url, class, method…）/ links（派生自哪些证据id）/ carries_target_content（防注入标记，不入id）。
- 来源记录方式（核心机制）: id = 除 id/summary/carries_target_content/subject.name 外全部字段的规范 JSON（键排序）SHA-256。同一观察恒同一 id; Evidence::verify() 重算比对即可检篡改（测试见 lib.rs:397-419: 改 result 一个数字即 verify 失败）; 显示字段改动不改 id。EvidenceBuilder 流式构建; Unknown 把未决问题+验证方式当一等公民; 会话 ledger 支持导出/导入（core_evidence_export / core_evidence_import 工具）。

## 6. apps/ — 三个应用

| app | 形态 | 要点 |
|---|---|---|
| craft-anything | 桌面 GUI（eframe/egui 0.36, wgpu+accesskit+persistence） | main.rs 装配: Settings::load，Session::new，plugins::install，Engine::shared_with(session, ai层+setup层工具, 插件)，AiHub，CraftApp; 命令行给路径即开为首个目标; Windows 隐藏控制台，窗口失败也留 desktop.log |
| craft-anything-cli | CLI（clap derive + ctrlc） | 子命令: mcp / setup / doctor / uninstall / commands / capabilities / triage 路径 / report（Markdown或HTML调查报告）/ rebuild（headless 仿建，支持 --rounds/--continue-in/--project-folder）/ chat; 全局 --allow-run --deep --clean-room --project 工程夹; 每个工具同时是子命令 |
| craft-anything-web | 浏览器页（trunk + wasm，WebGPU/WebGL2 回退，?webgl 强制） | 仅 wasm 安全 crate（evidence/formats/analysis）: 拖文件进页面即 triage 识别（ELF/PE/Mach-O/DOS 同桌面版话术），文件不出浏览器; cargo xtask wasm 构建，dist/web |

## 7. 构建/运行

- Rust 1.97 或更新（workspace Cargo.toml:9 rust-version=1.97; README:186 注明「某依赖需要; rustup update」），edition 2024, resolver 3, profile.dev 带优化, release 用 thin LTO + codegen-units=1。
- Windows 直接 cargo build --release; Debian/Ubuntu 桌面版需 libxkbcommon-dev libwayland-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libgtk-3-dev（README:190）。
- 运行: cargo run --release -p craft-anything（桌面）; cargo install --path apps/craft-anything-cli（装出 craft-anything-cli）; craft-anything-cli doctor（体检安装/编码代理/引擎/AI）。注意: 构建重建功能需本机有已登录的编码代理（README:202）。
- 预编译 release 有（README:248-279）: Windows x64/arm64/x86 的 msi 安装包 + portable.zip（代码签名），macOS universal dmg 与 cli zip（签名+公证），SHA256SUMS.txt 校验清单; v0.2.0 起 CLI 已并入 app 包。另有 xtask 工具链（cargo xtask tools 生成 docs/tools.md、cargo xtask wasm）、packaging/、deny.toml（cargo-deny）与 about.toml+about.hbs（cargo-about 许可合规）。
- 项目自评: early alpha; 已能用 = 桌面双模式 + CLI + MCP + 以 Claude Code 为主力构建代理的 Study, Build, Check, Refine 工作流。

## 8. 可移植结论（对本站的启示）

1. 单一 Evidence 返回类型 + SHA-256 内容寻址 id（evidence crate 仅895行，MIT/Apache 双许可，可直接 reuse）——与本站 rea 工具的 _meta.provenance 体系同构。
2. MCP 服务器无需官方 SDK: 1282 行手写 stdio JSON-RPC 即覆盖 tools/prompts/resources/completion/progress/cancel; Claude Code 80KB 预算特判 + 超限摘要折叠 + carries_target_content 防注入标记，都是实战级细节。
3. 工具注册表单点分发（Engine::call + 17 Toolset 分组 + list_toolsets/enable_toolset 渐进披露）解决 300+ 工具撑爆 agent 上下文的问题; 工具三面一体（MCP 工具名 = CLI 子命令 kebab-case = 内置AI 可调用工具）。
4. iced-x86 + yaxpeax-arm 证明纯 Rust 反汇编可摆脱 capstone 绑定; Ghidra 降级为可选增强（analyzeHeadless 协议在 engines/src/ghidra/protocol.rs，可复用其接入法）。
5. setup crate 展示了 MCP 注册到 21 个代理客户端（claude_code/claude_desktop/codex/cursor/windsurf/vscode/opencode/qwen_code/hermes/grok_build/devin/commandcode/omp/pi/kimi_code/workbuddy/dsh/trae/copilot_cli/gemini 等, crates/setup/src/clients.rs）的配置合并+备份+回滚+doctor 通用流程。
