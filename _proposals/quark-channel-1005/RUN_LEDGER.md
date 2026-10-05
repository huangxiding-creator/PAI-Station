# RUN_LEDGER — Arc M: 夸克网盘渠道整合 (1005)

> 用户令: 「请把夸克网盘的skill也集合到集整合到本项目中。作为咱们的调研的渠道之一。需要我扫码授权的时候，请把二维码打开，让我扫码授权。」

## 交付物

| 产物 | 位置 | 状态 |
|---|---|---|
| 第27渠道 quark_pan 包 | `ResearchFactory-Eng/EPC100/collectors/quark_pan/` | ✅ auth/client/ledger/cli/login_loop |
| 主链接线 + 完备门 + manifest 27 | `epc100_channels.py` + `channel_manifest.json` | ✅ compile OK, named 26→27 |
| 测试 9 条 (零真网) | `EPC100/tests/test_quark_pan.py` | ✅ 全套件 324 passed |
| 调研案卷 | 本目录 (Workflow 4角度30发现+audit live实证) | ✅ |

## 调研结论 (Workflow wf_8da6c9c9: 5 agent / 347k tokens / 172 tool uses)

**QR 三步 live 实证** (本机直测):
1. `GET uop.quark.cn/cas/ajax/getTokenForQrcodeLogin?client_id=532&v=1.2&request_id=<uuid>` → 2000000, token 在 `data.members.token`
2. 二维码内容 = `su.quark.cn/4_eMHBJ?token=..&client_id=532&ssb=weblogin..` → qrcode 库渲染 PNG
3. 轮询 `getServiceTicketByQrcodeToken` → 未扫 `50004001` / **过期 `50004002 Token Not Found`(181s 实锤)** / 确认后 service_ticket
4. `GET pan.quark.cn/account/info?st=..&lw=scan` → Set-Cookie `__pus/__puus` 家族

**协议底座三源互证**:
- Cp0204/quark-auto-save (3056★): 转存四步 sharepage/token→detail→save→task + file/sort + file/download; drive-pc(fr=pc)/drive-m(fr=android) 双 BASE
- lich0821/QuarkPan: 纯 HTTP 扫码参考实现 (社区事实标准, 被多仓 vendor)
- **命门**: 响应 Set-Cookie 刷新 `__puus`, 必须回写 cookie 池持久化 (QuarkPanTool/QAS/gopeed 三家同款)

**官方面**: open.quark.cn 实为小程序开发者平台 (CSDN 转述失真); 真官方账号面出口 = Agent Skill OAuth (open-api-drive.quark.cn, quarkclouddrive v1.0.22) — **登记二期工单 QUARK-1** (合规升级路径)

**架构**: 发现面 = pansou(第22渠道, Telegram 夸克索引渠道在册) + 账号面 = 本渠道。两层解耦。

## 安全纪律 (个人账号红线)

- 节流 1.5s 站间 / 冷却 15min (风控码触发) / 日限额 20 转存·日 (state 账落盘, 收紧免问放宽须批) / 熔断连败计数
- 凭据 `data/secrets/quark_pan.ini` (gitignore data/ 整树, 红线免疫); 值绝不打印 (只报字段名+长度)
- 账本腿零业务请求 (cookie 存在性判态); 直连不走代理 (只探测不动网)

## 扫码授权值守

- 单码 120s 有效 — 不在场必过期; `login_loop.py` 每轮自动续码+桌面弹出 (PowerShell Start-Process, 百度先例), 窗口 10min
- 桌面弹出 + 会话内嵌 PNG 双展示面 (用户令: 打开让我扫)

## 待办

- [ ] 扫码完成 → whoami 实证 + 转存/列目录首腿实测 → 回填本账
- [ ] QUARK-1 官方 OAuth 二期工单 (open-api-drive.quark.cn)
- [x] 签到保活腿 (1005 落地): `quark_pan/keepalive.py` + schtask `PAIStation-quark-keepalive` 日 09:23 (pythonw 零弹窗, 未授权态退出 0 自动哑跑, 授权后自动生效; 账本 `data/quark/keepalive_log.jsonl`)。原 conductor 工单改判: conductor 为一次性队列非常驻排程, 按持久执行宪法走 OS 级 schtasks
- 测试 11 条 (9+2 保活), 全套件 326 passed
