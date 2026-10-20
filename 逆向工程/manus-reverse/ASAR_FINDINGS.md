# S1 桌面端 asar 静态逆向发现（Manus Desktop v1.4.1.0）

> 证据源: `app.asar` (89,031,286B, sha256 a6740099…) 解包 2946 文件
> + REA analyze_javascript_application (2285 relevant files / 5213 modules / 7.1M AST nodes)
> 解包产物: `asar_extracted/` | 本文档 = S1 源全量结论

## 一、桌面端架构定性

**Electron 壳 + Next.js 前端 + myComputer 设备桥**。核心智能全部在服务端——
桌面端无系统提示词、无 agent 逻辑（grep "You are Manus"/systemPrompt 零命中）。
桌面端的独有价值 = 三件：设备桥协议、完整前端事件/工具 schema、API 服务全图。

- `dist/` 主进程（未混淆, 可直读）: index.js / setupIPC.js / myComputer/* / trayManager / shortcutManager
- `frontend/out/` Next.js 静态导出 (与 manus.im 网页端同构)
- prod 后端: `wss://api.manus.im` (dev: `wss://vida.butterfly-effect.dev` — 蝴蝶效应)
- 协议: `manus://` deep-link（`manus://create-website?filePath=…`、token 登录接力）

## 二、myComputer 设备桥协议（桌面端独有架构）

```
桌面 → socket.io connect wss://api.manus.im/device
       auth: {token, deviceId, deviceName}
服务端 → device_config {configVersion, deviceId,
       sessions:[{sessionId, folderPath, sandboxWsUrl}], folders:[{path,name,allowCmd}]}
桌面   → device_status (心跳汇报: sessions/folders/terminalAvailable/appliedConfigVersion)
桌面   → device_request {action:"set_session", sessionId, folderPath, terminalEnabled}
每会话 → spawn sidecar 二进制: sidecar.exe --shared-folder <folder> --ws <sandboxWsUrl>
       (云沙箱 ↔ 本机文件夹 WebSocket 桥; 1.4.1 未随包分发 sidecar, bin/ 空)
```

要点: **云端沙箱直接挂载用户本机文件夹**（终端可选开关 allowCmd/terminalEnabled）；
断线即停全部 sidecar，重连按 configVersion 幂等重建（epoch 防并发）。

## 三、事件流 schema（前端渲染层实证，比已知 9 类多 12 类）

**事件类型全集（27）**:
agentRunning, chat, chatDelta, chatReplySources, contextTooLong,
contextTransferFlag, contextTransferResult, error, explanation, file,
fileOperationPromotion, fileUpload, knowledgeSuggested, message, planUpdate,
queueStatusChange(新), sandbox, sandboxLimitReached(新), sandboxUpdate,
skill(新), skillTag(新), statusUpdate, systemConflict(新), terminalUpdate,
toolUsed, userRetryUploadResult(新), userStop(新), userUploadFailed(新)
（live 实测另见: newPlanStep, cascadeTaskClock）

**toolUsed.tool 工具全集（前端分发器实证）**:
terminal, browser(含 browser_console_exec), search, search_scholar,
text_editor(documentType=webdev-debug→webdev_debug), media_viewer,
search_image, gmail(action=search/read), map_reduce
（live 实测另见: **mcp, agent** — Cascade 编排核心工具）
（存量语料另见: slides, suggestion）

**关键字段**:
- planUpdate: tasks[]{status: doing/todo/done/failed, title, startedAt}
- toolUsed: {tool, brief, description, message{action,param}, status, actionId, detail{…}}
- terminalUpdate: {shellId, output}
- toolUsed.detail.browser: {screenshot, toolName, url, consoleMessages, fromMyBrowser, isYtbVideo}
- chat: {sender: user/assistant, content, attachments[]}

## 四、API 服务全图（47 服务 300+ 方法，gRPC 风格 `/pkg.Service/Method`）

**报告链核心**:
- SessionService(22): getSession, getSessionV2, listSessions, updateSession, shareSession,
  getSessionFileUploadUrl, listSessionFileVersions, syncSessionFile, updateSessionFile,
  generateDocumentSuggestion, webPageScreenShotFullPage, favoriteSession, …
- SkillService(7): listSkills, downloadSkill, importSkill, uploadSkill, subscribeSkill, toggleSkill, deleteSkill
- KnowledgeService(9): createKnowledge, listKnowledge, updateKnowledge, listKnowledgeEvents, …
- ProjectSkillService(8) / ProjectService(16) / OrchestratorService.getSession / CanvasService

**周边**: ConnectorsService(11, 含 MCP: MCPConfig/SSEConfig/StdioConfig),
WebDevService(49, 部署/域名/数据库/存储), SubscriptionService(15),
SessionCollaborateService(7, 多人协作), UserApiProxyService.audioTranscription,
ImageService.oCR, AppOAuthService(Figma/GoogleDrive/OneDrive), SSOService(SCIM)…

**proto 包名**: session.v1 / skill.v1 / connectors.v1 / webdev.v1 / user.v1 / space.v1
**消息样例**: session.v1.AgentSession, session.v1.SessionNewMessageEvent,
skill.v1.ProjectSkillItem, google.protobuf.Timestamp

## 五、任务模式与产品机制（前端状态树实证）

- **agentTaskMode**: STANDARD / **HIGH_EFFORT**（高努力模式, 发送时选择）
- **taskMode**: 普通会话 / **cascade_lite**（Cascade 多作业编排, live 实证）
- 会话分享: `https://manus.im/share/<sessionId>`
- Skills 以 `/skillName` 斜杠标签插入 composer（skillTag: {skillName, skillId}）
- knowledgeSuggested: agent 回复前建议挂知识库资源
- MCP 连接器注册（企业 ConnectorEnterpriseRegistry / 团队策略 ConnectorTeamPolicy）

## 六、其他桌面能力

- presenter.html（演示模式）/ quick-ask（快捷提问窗, pre-warmed）
- 托盘/全局快捷键/自动更新(electron-updater, PrivateGitHubProvider)
- socket.io 双向: 主进程 socket.io + ws 8.18
- 依赖: lodash-es, sc-prepare-next(自家 Next 预热), electron-log

## 七、对复刻 skill 的直接启示

1. 复刻件不需要复刻 UI——事件流/工具/API 三 schema 即可完整描述能力面
2. cascade 编排（workflow/run + agent/parallel 原语）是报告生成的核心引擎（详见 live 捕获）
3. SkillService.downloadSkill 的 S3 签名直链 → 技能库全量原文可编程收割（已收割 40/40）
4. myComputer 设备桥 = 「云沙箱操作本地文件」模式，可借鉴为本地执行引擎的挂载设计
