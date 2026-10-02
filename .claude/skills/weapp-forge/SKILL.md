---
name: weapp-forge
description: WeAppForge 小程序锻造厂——本机最强小程序开发工具链入口。当用户要开发/上传/测试/发布/变现微信小程序时使用。统一多项目注册表(data/projects.json) + forge.mjs 命令(lint/upload/preview/deliver) + WXML 上传闸门 + 模拟器自动化(devtools MCP) + 全生命周期方法论路由(wechat-miniprogram-builder) + Skyline 官方组件技能。触发词：小程序、上传、体验版、提审、开发者工具、weapp。
---

# WeAppForge — 小程序锻造厂工具链

> 融合自有机械（注册表/闸门/引擎/交付）+ 生态技能（方法论/Skyline/E2E/devtools MCP）+ 实战教训。

## 架构一览

```
方法论层   wechat-miniprogram-builder skill（8阶段：选题→备案→开发→变现→审核→推广→矩阵）
技能层     skyline-components/overview（官方渲染引擎）· weapp-devtools-e2e-best-practices · wechat-miniprogram-skill
操作层     wechat-devtools-mcp（模拟器点击/输入/截图/编译/上传）+ miniprogram-automator（pipeline 自动化）
机械层     work/forge.mjs（多项目统一入口）+ work/wxml_lint.mjs（上传闸门）+ pipeline/（旧七腿流水线）
服务层     services/qianwen-engine（FastAPI 0.0.0.0:8869：KB问答/配额/点赞/批评）+ data/projects.json
```

## 多项目注册表

`E:\AI-Station\WeAppForge\data\projects.json` — 项目唯一事实源（biaoxun/qianwen/zongbao 三项目在册）。
**铁律：appid 必须与密钥文件名逐字符 diff**（f48↔b48 一字符之差=「查无此appid」悬案，2026-09-28 教训）。
密钥只在 `E:/AI-Station/data/secrets/`（R7），代码/仓库零密钥。

## forge.mjs 命令（cwd=E:\AI-Station\WeAppForge）

```bash
node work/forge.mjs list                          # 在册项目一览
node work/forge.mjs lint biaoxun                  # WXML 闸门（{{方法调用}}类缺陷拦截）
node work/forge.mjs upload biaoxun 0.2.0 描述      # 闸门不过=拒传 → miniprogram-ci 上传
node work/forge.mjs preview biaoxun               # 预览二维码 PNG
node work/forge.mjs deliver biaoxun 0.2.0 描述     # lint→上传→二维码→推企微 一条龙
```

## 开发者工具自动化（E:\WeChatDevTools）

- CLI：`E:\WeChatDevTools\cli.bat`（islogin/open/auto/upload…）；前置=IDE 已启动+已扫码登录+**设置→安全设置→服务端口开启**（不开=一切 CLI_TIMEOUT）
- MCP：`wechat-devtools-mcp` 已注册 user 级（uvx wechat-devtools-mcp；env 已指 E:\WeChatDevTools\cli.bat）；IDE 2.x 另有内建 MCP `http://127.0.0.1:<port>/mcp`（47 原子工具）——开关项目/编译/预览/点击输入滚动/截图
- 模拟器 UI 自测：`cli.bat auto --project <path> --auto-port 9420` + node `miniprogram-automator.connect({wsEndpoint:'ws://localhost:9420'})` → 真机级点击/输入/断言（node_modules 已装 automator+simulate）
- 逻辑自测（无需 IDE）：引擎测试双闸 `QW_DEV_LOGIN=1 QW_FAKE_ASK=1`（dev-openid 映射+假答案不烧秘塔积分；**生产进程严禁带这两个 env**）

## 引擎（biaoxun/qianwen 共用）

`services/qianwen-engine`：POST /api/login /api/ask；GET /api/answer/{id} /api/quota /api/history；like/criticize。
配额=3免费/天+点赞赠1；账号安全四件套已焊（5s节流/90点日帽/4败熔断）。
秘塔主引擎=KB直连（curl_cffi chrome 指纹，网页积分池）；TLS WAF 见 metaso-tls-fingerprint-waf 记忆。

## 上传/发布检查单（每次 deliver 前过一遍）

- [ ] WXML 闸门 PASS（{{}} 内禁方法调用；未闭合绑定）
- [ ] appid 与密钥文件名逐字符一致
- [ ] BASE_URL 指向可达后端（同网 WiFi 用局域网 IP；生产换 HTTPS 域名+后台加白）
- [ ] Node≥22 加 `--no-experimental-webstorage`（forge.mjs 已内置）
- [ ] 主体合规：个人主体=广告变现路线（虚拟支付/微信支付不可用；AI类目难过审需企业资质）——变现路线定档前先问主体
- [ ] 密钥零入库（secrets/ 以外 grep 一遍）

## 阶段路由（接 wechat-miniprogram-builder）

| 用户所处阶段 | 动作 |
|---|---|
| 想法/选题 | 调 wechat-miniprogram-builder skill → references/02 |
| 开发 UI | skyline-components/overview + 本链 forge lint |
| 自测 | devtools MCP/automator 模拟器实操 + 引擎双闸逻辑测 |
| 上传体验 | forge deliver → 企微二维码交付 |
| 提审/被拒 | builder references/06 + release-checklist |
| 变现定档 | builder references/01（先确认主体资质红线） |
| 推广/矩阵 | builder references/07/08 |

## 底线（继承 builder 五条 + 本链增补）

平台规则以官方最新为准 · 不承诺收益 · 激活码模式禁用 · 个人主体无微信支付 · 密钥只进 secrets/ · **appid 逐字符 diff** · **WXML 无方法调用** · **生产进程无测试 env**。
