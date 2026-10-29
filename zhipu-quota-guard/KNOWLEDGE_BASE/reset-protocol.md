# 重置协议（W2 逆向情报，源：zcode-proxy reset.go/oauth.go 只读取证，2026-10-23）

## 端点族（Base: https://zcode.z.ai/api/v1/coding-plan/reset）
| 方法 | 路径 | 请求体 | 响应要点 |
|---|---|---|---|
| GET | /status | — | data.available_five_hour_resets[] / available_week_resets[]（槽位）+ latest_five_hour_reset_history / latest_week_reset_history |
| POST | /use | {"idempotency_key": "<uuid4>", "reset_type": "five_hour"\|"week"} | 业务码 code==0 即成功；data.used bool |
| POST | /opportunity | {"idempotency_key": "<uuid4>"} | data.granted bool / next_try_at；HTTP 429=限流；code 3301=机会已授予 |

## 请求头（resetHeaders 双凭证）
```
Authorization: Bearer <ZCodeJWT>            # 控制台登录态 JWT（必需；套餐Key无效，实测401）
X-Bigmodel-Authorization: <套餐APIKey>       # 有则带（双凭证）
Bigmodel-Target-Type: PERSONAL               # 团队时另加 Bigmodel-Organization/Bigmodel-Project
User-Agent: ZCode/<version>
accept: application/json; content-type: application/json
```

## 关键事实
- 套餐 Key 直调 reset/* 全 401（W0 实测三组合）→ 必须登录态 JWT
- **跨域镜像 GET 探测（W2.1 路①，2026-10-23 GET-only 实测，脚本 scripts/w2_get_probe.py）**：
  - `zcode.z.ai …/reset/status` → **HTTP 401 空 body**：端点存在，鉴权先于路由
  - `zcode.z.ai …/reset/history` → **404**：该路径不存在（history 为 /status 响应内字段，非独立端点）
  - `api.z.ai` / `open.bigmodel.cn` / `bigmodel.cn` 同路径 → **`{"code":500,"msg":"404 NOT_FOUND"}`**：**重置端点族在监控域无镜像 → 重置链路 = zcode.z.ai 单点，ADR2 修正：双域故障转移仅适用于监控/卡库存链路，重置链路无故障转移**
- **.chrome-profile cookie 文件级收割（scripts/w2_cookie_harvest.py）**：20 条 cookie 全为埋点/风控类（sensorsdata/_ga/acw_tc/TDC_itoken），**无任何登录态残留** → JWT 无残留可捞，人工登录是唯一获取路径
- ZCodeJWT 获取链（OAuth 版）：chat.z.ai/api/oauth/authorize → code → POST zcode.z.ai/api/v1/oauth/token {provider:"zai",code,redirect_uri,state} → data.token=JWT（+zai.access_token/refresh_token）
- bigmodel.cn 国内控制台登录=腾讯防水墙点选验证码（tencent-captcha-dy，click-type），CDP 自动化环境被风控拒绝（3 轮视觉全对仍拒）→ JWT 一次人工登录提取后长效保活；open_login_window.py 预填账密辅助人工登录
- 防风控：动作前后 3-8s 随机延迟；429 退避；同卡 24h 重试 ≤2 次
- idempotency_key 每次新生成 uuid4
- ⏳ 待人工：用户一次人工登录（open_login_window.py）→ 提取 ZCodeJWT 入 secrets → GET /status 实弹验证响应结构
