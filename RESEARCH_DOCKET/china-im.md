# 频道：中国 IM 接入（用户新增核心需求）

## 结论速览
**飞书/钉钉/企业微信官方机器人全部支持 WebSocket 长连接，PC 桌面客户端无需公网 IP/域名/内网穿透即可双向对话** —— 这是 PAI-Station 桌面形态对中国场景的决定性架构优势。

| 平台 | 长连接方案 | 凭证 | 官方 SDK | 交互能力 |
|------|-----------|------|---------|---------|
| 飞书 | SDK 内置长连接事件回调（lark-oapi ws client） | App ID + App Secret | lark-oapi（Python） | 单聊/群聊@、卡片消息、主动推送 |
| 钉钉 | Stream Mode（dingtalk-stream，WebSocket） | Client ID + Client Secret | dingtalk-stream（Python） | 单聊/群聊、卡片、主动推送 |
| 企业微信 | 自建应用回调 + aibot_subscribe WebSocket；群机器人 Webhook | BotID/Secret 或 corpid+secret | requests 直调即可 | 主动推送、发文件图片、私聊互动（比群机器人 Webhook 功能全，推荐自建应用） |
| 个人微信 | ⚠️ 无官方 API。Hook（wcferry，注入 DLL，封号率>80%）/ iPad 协议（Gewechat，中风险）/ wechaty（老化） | — | — | **本项目策略：只读=纯视觉（截图+VLM），交互=引导用户用企微/飞书/钉钉通道** |

## 关键事实
- 企业微信群机器人 Webhook：用户已提供（用于里程碑通知），单向推送即可用
- 企微自建应用可推送文件/图片/私聊互动 —— "文件传输助手"角色的完美替代（比 PC 微信文件传输助手更稳定、合规）
- OpenClaw 已有社区教程接入微信/钉钉/飞书/QQ（zhuanlan.zhihu.com/p/2013706717012186762），但属第三方桥接、非一等公民、且需自建服务器 —— PAI-Station 将四通道做进桌面客户端本体
- 封号风暴后共识：个人微信自动化只能"只读+低频+本地视觉"，绝不注入进程

## 对架构的直接影响
频道层设计为可插拔 ChannelProvider：feishu_ws / dingtalk_stream / wecom_app / wecom_webhook / desktop_gui /（可选）wechat_vision_readonly
