# official_eco 渠道调研：微信官方小程序开发生态资产全景

- 渠道：`official_eco`（微信/腾讯官方 org、官方文档、官方插件、官方 MCP、云开发）
- 生成时间：2026-09-27T13:06:26Z
- 条目数：57（repo 37 / npm 7 / doc 7 / plugin 1 / news 1 / mcp 1 / degraded 3）
- 方法：`gh api orgs/wechat-miniprogram/repos --paginate`（80 仓全量）+ TencentCloudBase org 全量 + npm registry/downloads API 实测 + 官方文档页逐页抓取（curl 解析正文）。全部 URL 经本会话实际访问/检索验证。

## 一、核心结论速览

微信官方在 2026 年已经把「AI 生成/调度小程序」做成了**平台级协议**：小程序 AI 开发模式（小微 SubAgent）+ SKILL 规范（mcp.json+原子接口+原子组件+handoff 页）+ 官方评测门（四指标各≥60 分才被微信 AI 调用）。同时 DevTools 2.0+ 内建扩展面板与 MCP 市场（Ctrl+Shift+X → CodeBuddy → CloudBase MCP），官方仓库直接以 Agent Skills 形态发布知识包（skyline-skills、ai-mode-skills、cloudbase-skills）。「全流程工厂」的全部官方零件已齐：生成（规范+模板）、构建（miniprogram-ci）、编排（CLI/HTTP V2）、验证（automator+simulate+评测工具）、后端（CloudBase AI+AI-Toolkit）、发布（ci upload+密钥体系）。

## 二、GitHub 官方仓库（wechat-miniprogram org，80 仓全量实测）

### 2.1 AI 开发模式线（工厂最直接对标）

| 标题 | 类型 | stars/活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| ai-mode-skills | repo | 203★ / 2026-09-25 | wxa-skills-generate（源码→skills/ 分包）/ validate（V001~V021 静态规则+真机执行+渲染截图验证+就地修复）/ eval（端到端评测，升级中暂闭） | 官方「AI 可调度小程序」改造管线；工厂产物直接对齐该规范 | https://github.com/wechat-miniprogram/ai-mode-skills |
| ai-mode-demo（WeStoreCafe） | repo | 296★ / 2026-09-22 | 小微 AI Handoff 全链 demo：原子接口返回 handoff→卡片→接力页 wx.onAgentHandoff；适配四件套 | 「AI 操作 UI」官方协议范本；工厂模板的目标形态 | https://github.com/wechat-miniprogram/ai-mode-demo |

### 2.2 工具链/工程线

| 标题 | 类型 | stars/活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| miniprogram-ci-dist | repo | 新仓 / 2026-09-18 | miniprogram-ci 发布仓+changelog（2.1.47）；上传密钥+IP 白名单；第三方平台支持 | 「发布腿」权威来源与版本追迹 | https://github.com/wechat-miniprogram/miniprogram-ci-dist |
| miniprogram-simulate | repo | 536★ / 2026-08-31 | 组件单线程模拟渲染单测；jest/jsdom/karma | 组件级回归测试腿 | https://github.com/wechat-miniprogram/miniprogram-simulate |
| j-component | repo | 43★ / 2026-06-29 | simulate 底层 mock 组件框架 | 测试底座依赖 | https://github.com/wechat-miniprogram/j-component |
| api-typings | repo | 804★ / 2026-09-20 | 小程序 API TS 类型（npm 月下载 69.4 万） | TS 工厂链路必需 | https://github.com/wechat-miniprogram/api-typings |
| minigame-api-typings | repo | 162★ / 2026-08-28 | 小游戏 API TS 类型 | 游戏线补全 | https://github.com/wechat-miniprogram/minigame-api-typings |
| wx-server-sdk | repo | 新仓 / 2026-07-17 | 云函数 server SDK（npm 4.0.2，月下载 6.7 万） | 后端云函数生成目标 | https://github.com/wechat-miniprogram/wx-server-sdk |
| miniprogram-custom-component | repo | 199★ / 2026-09-17 | 官方组件脚手架/规范 | 组件工程起点模板 | https://github.com/wechat-miniprogram/miniprogram-custom-component |
| mpflow | repo | 66★ / 2026-09-17 | TypeScript 工程化构建（webpack 系） | 非 DevTools 主线，备选 | https://github.com/wechat-miniprogram/mpflow |
| miniprogram-compat | repo | 105★ / 2026-09-19 | JS 执行环境兼容信息数据仓 | 生成代码的兼容性判据数据源 | https://github.com/wechat-miniprogram/miniprogram-compat |
| wasmsplit-ci / wasmsplit-v2-ci | repo | 0★ / 2026-09-22 | wasm 拆分分包 CI | 重 wasm 游戏发布配套 | https://github.com/wechat-miniprogram/wasmsplit-v2-ci |
| ios-webkit-debug-proxy-rust | repo | 1★ / 2026-04-04 | iOS 真机调试代理（CRDP，Rust 重写） | 真机调试链底层 | https://github.com/wechat-miniprogram/ios-webkit-debug-proxy-rust |

### 2.3 UI/组件/体验线

| 标题 | 类型 | stars/活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| miniprogram-demo | repo | 7243★ / 2026-09-25 | 组件/API/云开发官方示例全集 | 生成代码对齐官方用法的基准语料 | https://github.com/wechat-miniprogram/miniprogram-demo |
| weui-miniprogram | repo | 2429★ / 2026-09-19 | WeUI 组件库（TS，扩展库引入） | UI 底座 | https://github.com/wechat-miniprogram/weui-miniprogram |
| weui-wxss（Tencent org） | repo | 15277★ / 2026-09-25 | WeUI 基础样式库（wxss 源码） | UI 底座（可复制改造） | https://github.com/Tencent/weui-wxss |
| computed | repo | 696★ / 2026-09-02 | 组件 computed/watch 扩展 | 模板内置官方件 | https://github.com/wechat-miniprogram/computed |
| recycle-view | repo | 641★ / 2026-08-17 | 长列表回收渲染 | 性能模板件 | https://github.com/wechat-miniprogram/recycle-view |
| threejs-miniprogram | repo | 799★ / 2026-09-25 | Three.js 官方适配 | 3D 场景件 | https://github.com/wechat-miniprogram/threejs-miniprogram |
| lottie-miniprogram | repo | 432★ / 2026-09-18 | Lottie 官方适配 | 动画交付件 | https://github.com/wechat-miniprogram/lottie-miniprogram |
| mobx-miniprogram-bindings | repo | 249★ / 2026-09-16 | MobX 官方构建版+绑定库 | 状态管理件 | https://github.com/wechat-miniprogram/mobx-miniprogram-bindings |
| miniprogram-i18n | repo | 142★ / 2026-05-27 | 官方 i18n 方案 | 多语言产物件 | https://github.com/wechat-miniprogram/miniprogram-i18n |
| miniprogram-gesture | repo | 45★ / 2026-03-15 | 官方手势库 | 交互件 | https://github.com/wechat-miniprogram/miniprogram-gesture |
| miniprogram-elder-transform | repo | 47★ / 2026-08-19 | 适老化自动适配 | 合规改造腿 | https://github.com/wechat-miniprogram/miniprogram-elder-transform |
| miniprogram-offline-demo | repo | 13★ / 2025-07-05 | 弱网/离线官方 demo | 弱网参考 | https://github.com/wechat-miniprogram/miniprogram-offline-demo |
| miniprogram-api-promise | repo | 62★ / 2026-08-02 | wx API promise 化 | 模板工具件 | https://github.com/wechat-miniprogram/miniprogram-api-promise |

### 2.4 渲染引擎新栈线（Skyline/glass-easel）

| 标题 | 类型 | stars/活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| glass-easel | repo | 332★ / 2026-09-26 | 多后端组件框架（TS）；analyzer（Rust LSP）/devtools/i18n/chaining-api-polyfill 配套 | 新框架底座+官方 LSP（工厂 IDE 层可接） | https://github.com/wechat-miniprogram/glass-easel |
| float-pigment | repo | 17★ / 2026-08-25 | Skyline CSS/布局引擎（Rust） | 官方 CSS 能力来源（无官方 Tailwind 集成） | https://github.com/wechat-miniprogram/float-pigment |
| skyline-skills | repo | 55★ / 2026-09-15 | 7 个 Skyline Agent Skills，npx skills add 一键装 | 官方 Agent Skills 先例；工厂直接复用 | https://github.com/wechat-miniprogram/skyline-skills |
| skylint | repo | 83★ / 2026-06-18 | Skyline 迁移检查 | WebView→Skyline 改造腿 | https://github.com/wechat-miniprogram/skylint |
| awesome-skyline | repo | 198★ / 2026-09-03 | Skyline 资源合集 | 迁移知识面 | https://github.com/wechat-miniprogram/awesome-skyline |

### 2.5 多端/小游戏线

| 标题 | 类型 | stars/活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| minigame-unity-webgl-transform | repo | 3351★ / 2026-08-28 | Unity→小游戏官方转换器 | 「代码转换工厂」官方范本 | https://github.com/wechat-miniprogram/minigame-unity-webgl-transform |
| minigame-tuanjie-transform-sdk | repo | 188★ / 2026-09-25 | 团结引擎转换 SDK | 引擎线扩展 | https://github.com/wechat-miniprogram/minigame-tuanjie-transform-sdk |
| minigame-canvas-engine | repo | 312★ / 2026-09-25 | 轻量 canvas2d 引擎（开放数据域） | 小游戏 UI 引擎 | https://github.com/wechat-miniprogram/minigame-canvas-engine |
| kbone 模板族 | repo | 353★ 等 / 2026-09-14 | Vue/React/Preact 多端同构 | Web 框架复用路线（弱活跃） | https://github.com/wechat-miniprogram/kbone-template-vue |
| minigame-playable | repo | 33★ / 2026-08-19 | 试玩广告（playable）件 | 买量场景件 | https://github.com/wechat-miniprogram/minigame-playable |
| minigame-demo | repo | 188★ / 2026-09-24 | 小游戏官方示例 | 游戏线基准语料 | https://github.com/wechat-miniprogram/minigame-demo |
| xr-frame-cli | repo | 50★ / 2024-07-23 | XR-Frame 工具 | XR 线（低活跃） | https://github.com/wechat-miniprogram/xr-frame-cli |

## 三、TencentCloudBase org（云开发官方，AI 后端线）

| 标题 | 类型 | stars/活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| CloudBase-AI-Toolkit | repo | 1126★ / 2026-09-27 | Plugin+Skills+MCP 三层；43+ MCP tools（数据库/函数/存储/部署/callCloudApi 57 服务白名单） | 工厂后端腿直接复用（org 第一仓） | https://github.com/TencentCloudBase/CloudBase-AI-Toolkit |
| cloudbase-agent-ui | repo | 96★ / 2026-09-18 | 小程序/React AI 对话组件 | AI 对话 UI 官方件 | https://github.com/TencentCloudBase/cloudbase-agent-ui |
| skills + cloudbase-skills | repo | 77★/34★ / 2026-09-24 | 官方 Agent Skills（npx skills add tencentcloudbase/cloudbase-skills） | 官方文档推荐的 Skill 分发 | https://github.com/TencentCloudBase/skills |
| awesome-miniprogram-skills | repo | 40★ / 2026-09-25 | AI 开发模式 Skills 示例集合（待办/存储/支付/AI） | 工厂 SKILL 模板库 | https://github.com/TencentCloudBase/awesome-miniprogram-skills |
| mp-skills | repo | 9★ / 2026-08-28 | npx mp-skills：创建 AI 小程序/改造存量+内置评测校验 | AI 开发模式官方脚手架 | https://github.com/TencentCloudBase/mp-skills |
| OpenVibeCoding + OpenAgentKernel | repo | 180★/25★ / 2026-09-26 | vibecoding 模板+服务端 agent 内核（会话持久化/沙箱/HITL/记忆） | 官方「AI 生成全栈应用」两腿 | https://github.com/TencentCloudBase/OpenVibeCoding |
| cloudbase-plugin | repo | 2★ / 2026-09-24 | Open Plugin Spec（MCP Server+Agent Skills 合一分发） | 分发形态新标准 | https://github.com/TencentCloudBase/cloudbase-plugin |

## 四、npm 包（registry + downloads 实测）

| 标题 | 类型 | 活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| miniprogram-ci | npm | 2.1.47 / 2026-09-18 / 7.2 万月载 | 上传/预览/构建 npm/云函数部署/多端构建/sourcemap | 发布腿核心 | https://www.npmjs.com/package/miniprogram-ci |
| miniprogram-automator | npm | 0.12.1（2023-11 后未更）/ 5.9 万月载 | launch/connect/页面栈/元素/mockWxMethod/evaluate/screenshot | 自动化验证腿（GitHub 仓已下架，npm 在役） | https://www.npmjs.com/package/miniprogram-automator |
| miniprogram-simulate | npm | 1.6.2 / 2026-06-29 / 7.8 万月载 | 组件单测 | 测试腿 | https://www.npmjs.com/package/miniprogram-simulate |
| miniprogram-api-typings | npm | 5.2.3 / 2026-08-07 / 69.4 万月载 | TS 类型 | TS 链路必需 | https://www.npmjs.com/package/miniprogram-api-typings |
| wx-server-sdk | npm | 4.0.2 / 2026-07-17 / 6.7 万月载 | 云函数 server SDK | 后端件 | https://www.npmjs.com/package/wx-server-sdk |
| @cloudbase/node-sdk | npm | 9.0 万月载 | CloudBase Node SDK | 后端件 | https://www.npmjs.com/package/@cloudbase/node-sdk |
| @cloudbase/js-sdk | npm | 3.10.1 / 2026-09-23 / 5.9 万月载 | Web/小程序侧 SDK；AI 入口 wx.cloud.extend.AI | AI 接入件 | https://www.npmjs.com/package/@cloudbase/js-sdk |
| @cloudbase/mcp | npm | 1.0.0-beta.30 / 2026-09-09 | 云函数 2.0 上跑 MCP Server（StreamableHTTP+鉴权） | 工厂产 MCP 后端的框架 | https://www.npmjs.com/package/@cloudbase/mcp |
| wechat-miniprogram-mcp（社区） | npm | 0.2.0 / 2026-06-04 / 52 月载 | control_*（11 工具）+auto_*（18 工具）封装官方双 API | 非官方；工具清单=官方 API 能力完整映射 | https://www.npmjs.com/package/wechat-miniprogram-mcp |

## 五、官方文档（逐页抓取实证）

| 标题 | 类型 | 活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| 命令行 CLI V2 | doc | 2026-09 抓取 | login/preview/upload/build-npm/auto(--auto-port)/auto-replay/cache/open/close/quit/reset-fileutils/cloud 全集 | 工具链编排腿 | https://developers.weixin.qq.com/miniprogram/dev/devtools/cli.html |
| HTTP V2 | doc | 2026-09 抓取 | /v2/* 全端点（含 cloud/env/functions 管理） | 纯 HTTP 编排，免 CLI 依赖 | https://developers.weixin.qq.com/miniprogram/dev/devtools/http.html |
| 自动化 quick-start | doc | 2026-09 抓取 | automator 全 API（页面/元素/mock/evaluate/截图/真机 connect） | 验证腿文档 | https://developers.weixin.qq.com/miniprogram/dev/devtools/auto/quick-start.html |
| AI 开发模式评测指南 | doc | 2026-09 抓取 | 四指标各≥60 才被微信 AI 调用；Intent≥50/复杂≥30%/实体≥5；基础库 3.16.2+ | AI 产物官方质量门判据 | https://developers.weixin.qq.com/miniprogram/dev/ai/evaluation-guide.html |
| 使用 Skill/MCP 辅助开发 | doc | 2026-09 抓取 | DevTools 2.0+ Ctrl+Shift+X→CodeBuddy→MCP 市场装 CloudBase MCP；npx skills add cloudbase-skills | 官方 MCP 分发渠道实锤 | https://developers.weixin.qq.com/minigame/dev/wxcloud/guide/development-assistant.html |
| Skyline 介绍 | doc | 2026-09 抓取 | 渲染线程独立/无 JSBridge/Worklet 动画/兼容旧代码 | 性能档渲染底座文档 | https://developers.weixin.qq.com/miniprogram/dev/framework/runtime/skyline/introduction.html |
| CloudBase AI 简介 | doc | 2026-09 抓取 | DeepSeek/混元直调；LangChain/LangGraph/CrewAI；Agent UI；10 亿 Token 成长计划 | AI 后端默认底座 | https://docs.cloudbase.net/ai/introduce |

## 六、插件与动态

| 标题 | 类型 | 活跃 | 关键能力 | 对工厂的价值 | URL |
|---|---|---|---|---|---|
| WechatSI 同声传译插件 | plugin | v0.3.5（wx069ba97219f66d99） | 流式语音识别/文本翻译/语音合成；官方参考实现 Face2FaceTranslator（908★） | 语音交互官方件（配额以后台为准） | https://mp.weixin.qq.com/wxopen/pluginbasicprofile?action=intro&appid=wx069ba97219f66d99 |
| Face2FaceTranslator | repo | 908★ | WechatSI 全功能官方开源小程序 | 插件用法权威代码 | https://github.com/Tencent/Face2FaceTranslator |
| 基础库 3.16 线 | news | 2026-05/09 | 3.16.1 社区公告；3.16.2 支持 AI 编译模式 | 目标基础库版本判据 | https://developers.weixin.qq.com/community/develop/mixflow |
| DevTools MCP 生态位 | mcp | 2026-09 检索 | 扩展面板+MCP 市场为官方渠道；自动化/控制 MCP 均社区封装 | 工厂 MCP 选型依据 | https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html |

## 七、Degraded 记录（诚实标注）

| 情况 | 说明 |
|---|---|
| GitHub 仓库下架 | wechat-miniprogram org 的 miniprogram-ci / miniprogram-automator / minitest 仓库 404（ci 迁 miniprogram-ci-dist；automator 仅存 npm；minitest 全网无踪、文档 404、npm 名被第三方占用） |
| 文档路径失效 | framework/release.html（基础库日志）、platform-ability/voice.html（同传旧页）、ai/introduction.html（AI 总入口）均 404；现行入口已在正文标注 |
| DevTools 版本号 | download.html 为 SPA 动态渲染，程序化抓取只得壳文档，未取得当前稳定版号（已证：DevTools 2.0+ 支持扩展面板） |
| WechatSI 可达性 | 2026-05 社区有「插件管理搜不到同传插件」反馈帖；配额明细需 mp 后台登录后查看，本次未取得 |

## 八、全流程工厂可用的官方能力底座清单

按工厂流水线环节映射（全部为官方资产，可直接组合成 7×24 无人产线）：

1. **需求/规划腿**：官方 SKILL 规范（ai-mode-demo 的 mcp.json+_meta.ui.pagePath+handoff 四件套）= 工厂产出的目标契约；mp-skills（npx mp-skills）与 ai-mode-skills（generate/validate/eval）= 官方改造管线，可直接嵌入工厂生成-校验循环。
2. **代码生成腿**：miniprogram-demo（7243★ 官方示例全集）+ weui-miniprogram/weui-wxss（UI）+ computed/recycle-view/mobx-bindings/i18n（官方增强件）+ api-typings（TS 类型，69.4 万月载）= 生成语料与类型安全底座；Skyline 线（skyline-skills 7 个 Agent Skills + skylint + float-pigment）= 性能档生成知识包。
3. **构建腿**：miniprogram-ci（2.1.47，上传/预览/构建 npm/云函数部署/多端 APK/iOS）+ DevTools CLI V2（cli.bat/cli 全命令）/ HTTP V2（/v2/* 纯 HTTP 编排，含 cleancache、cloud functions deploy）。
4. **验证腿**：miniprogram-automator（页面栈/元素操作/mockWxMethod/evaluate/screenshot，模拟器+真机）+ miniprogram-simulate（组件单测，jest 集成）+ 官方 AI 评测工具（四指标各≥60、Intent≥50、复杂用例≥30%）= 三层质量门。
5. **AI 运行时腿**：CloudBase AI（wx.cloud.extend.AI 调 DeepSeek/混元；LangChain/LangGraph/CrewAI Agent；Agent UI 组件；小程序成长计划 10 亿 Token 免费）+ WechatSI 插件（语音识别/翻译/合成，Face2FaceTranslator 为范本）。
6. **后端/部署腿**：CloudBase-AI-Toolkit（1126★，43+ MCP tools：数据库/函数/存储/部署）+ @cloudbase/mcp（云函数 2.0 MCP 框架）+ wx-server-sdk/@cloudbase/node-sdk + 云托管/静态托管模板（cloudrun-* 模板族）。
7. **Agent 接入腿**：DevTools 2.0+ 扩展面板 MCP 市场（CodeBuddy→CloudBase MCP）+ 官方 Agent Skills 三处实锤（skyline-skills/cloudbase-skills/ai-mode-skills）——工厂的 agent 可用同一分发形态交付知识包。
8. **发布/运营腿**：miniprogram-ci upload（密钥+IP 白名单体系，支持第三方平台代开发）+ auto-preview（推送真机即时预览）+ 基础库 3.16.2+（AI 编译模式门槛）。

**关键判据**：官方评测指南的四指标门（服务交付/交互体验/场景覆盖/性能质量各≥60）可直接充当工厂产线的出厂合格判据；SKILL 数量 1~5 个/个、Intent≥50、复杂用例≥30%、实体类型≥5 为可量化验收线。

**风险提示**：① miniprogram-automator npm 已 28 个月未发版（仍 5.9 万月载），自动化腿需锁版本+社区 @weapp-vite 替代预案；② minitest 线已实质性停摆；③ Tailwind 无官方集成（社区 weapp-tailwindcss 为事实标准，非官方资产）；④ AI 开发模式仍处内测（AppID 需申请，评测工具升级中）；⑤ 部分官方文档 URL 易变，引用以本清单「现行入口」为准。
