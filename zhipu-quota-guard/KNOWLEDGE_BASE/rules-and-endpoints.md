# KNOWLEDGE_BASE — GLM Coding Plan 规则与端点（2026-10-23 三源交叉实证）

## 官方规则（docs.bigmodel.cn / docs.z.ai，两站同构）
- **5h 窗=动态刷新**：额度在「消耗后 5 小时」归还（滚动式），非固定钟点；周积分自下单 7 天一周期
- 档位积分（5h/周）：Lite 2,000/10,000；Pro 12,000/60,000；Max 28,000/140,000
- 积分公式（GLM-5.3）：（输入Token×6.9 + 缓存命中×1.7 + 输出×24）/10000；Flash 系数 2.3/0.56/8
- **高峰**：周一至五 14:00-18:00 UTC+8；V3 现行=高峰 1x/非高峰 0.5x（差2倍）；「3倍」=V2 老版（仅老套餐）
- **额度重置卡**：5h卡/周卡两种；周卡使用时 5h 额度同步回满且不耗 5h 重置次数；**用后周期从使用时刻重算**；每卡独立有效期；活动发放非套餐标配
- 用量页：bigmodel `www.bigmodel.cn/coding-plan/personal/usage`；z.ai `z.ai/manage-apikey/subscription`
- 2026-10-16 起 Key 分家：**套餐 Key ≠ 标准 API Key**（监控端点必须用套餐 Key）
- 双站账号分离（z.ai 美元/api.z.ai 域；bigmodel 人民币/open.bigmodel.cn 域），无互通文档

## 端点契约（未文档化，社区在役验证）
### 额度查询（监控主链路，Bearer 套餐Key）
```
GET https://api.z.ai/api/monitor/usage/quota/limit        # z.ai
GET https://open.bigmodel.cn/api/monitor/usage/quota/limit # bigmodel 镜像
→ {limits:[{type:"TOKENS_LIMIT", percentage, currentValue, usage, remaining, nextResetTime},
           {type:"TIME_LIMIT", ...}]}   # TOKENS_LIMIT=5h窗, TIME_LIMIT=MCP月度
```
来源：opencode-glm-quota(MIT, scripts/query-usage.mjs)、zai-coding-plan-dashboard、lichong-a monitor docs/api-contract.md

### 时序用量
```
GET /api/monitor/usage/model-usage?startTime=&endTime=   # x_time/modelCallCount/tokensUsage
GET /api/monitor/usage/tool-usage?...
```

### 重置卡库存（z.ai 已验证）
```
GET /api/biz/customer-package-reset/list?targetType=PERSONAL
→ fiveHourResets / weekResets（数量+最近过期时间+customerId）
```
来源：LogicIncZo/zai-usage（README: four undocumented Z.ai endpoints）；bigmodel 对应路径待 W0 验证

### 重置动作
**全网无公开实现**（zcode-proxy 无许可证仅 pattern：reset/status·use·opportunity·history/read 端点族）→ W2 DrissionPage 登录态抓包「使用」按钮

### 其他
- OAuth：chat.z.ai/api/oauth/authorize|userinfo；bigmodel.cn/login（zcodeReverseEngineering, Apache-2.0）
- 日账单（z.ai）：/api/platform-charge-zai/bill/day?customerId=&billingPeriod=&pageNum=
- 网关行为：无鉴权一律 {"code":1001}（鉴权先于路由）

## 本机事实
- CC 实走 `https://api.z.ai/api/anthropic` + glm-5.3[1M]（~/.claude/settings.json）
- 本地遥测：~/.claude/projects/**/*.jsonl 含 usage（input/cache_read/output tokens）
