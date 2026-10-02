# 秘塔 search-api 契约实证 docket（2026-09-28 主控实测）

> 来源：playground 页面（登录态）+ dashboard 数据接口页内 fetch + curl 实测。
> 红线：key 明文只在 data/secrets/（R7），本文件引用路径不引用值。

## 1. 账户事实（实证）

- 登录账号 15838272889（userName=总包之声，uid 67c5bd8df6f09a0550659053, id 4109117）
- **工程行业大脑专题在本账户**：topicId `8673582927558737920`（my-info.notes.recentlyUsedTopics 实证）
- **本账户唯一 API key = "Default"（id 1149479，createdAt 2025-12-16，lastUse=null 从未用过）**，值已存 `data/secrets/metaso_api_key_default.txt`
- **用户交底的 mk-B69D… key 不在本账户 key 列表里**（幽灵/跨账户 key）：认证层通过（假 key→401 对比实证），业务层一律 5000；其 `/api/v1/usage`=5287（属另一账户的用量）
- **积分双池制（关键架构事实）**：网页端每日免费积分（todayFreePoint=100/天）≠ **API 积分（metasoApiCredit=0，从未充值）**。API 调用被 0 积分拦截时返回 `{"code":5000,"message":"系统内部错误"}`（烂错误设计，秒拒 0.3-2s，不进模型）
- `GET /api/v1/usage`（Bearer）返回裸数字：真 key→100（疑网页池），幽灵 key→5287

## 2. 积分定价（dashboard 充值弹窗实证）

| 档 | 价格 | QPM | 折算 |
|---|---|---|---|
| 1,000 点 | ¥10.8 | 200 | ¥0.0108/点 |
| 10,000 点 | ¥99（8.9折） | 200 | ¥0.0099/点 |
| 100,000 点 | ¥960（8.3折） | 1000 | ¥0.0096/点 |
| 500,000 点 | ¥4500 | 2000 | ¥0.009/点 |

- 有效期一年；优先扣会员每日积分；不可用于 H3 视频生成

## 3. 每次调用积分成本（/api/dashboard/credit-label 实证）

| 接口类型 | 积分/次 | 按基准价成本 |
|---|---|---|
| **全网-问答** | **1** | **¥0.0108** |
| 文库-问答 | 7 | ¥0.0756 |
| 学术-问答 | 6 | ¥0.0648 |
| 视频-问答 | 4 | ¥0.0432 |
| 播客-问答 | 5 | ¥0.054 |
| 全网-搜索 | 11 | ¥0.1188 |
| 文库-搜索 | 17 | |
| 学术-搜索 | 16 | |
| 图片-搜索 | 13 | |
| 视频-搜索 | 14 | |
| 播客-搜索 | 15 | |
| 读取网页 | 20 | ¥0.216 |

**→ 1元付费解锁 vs 全网-问答 1 点成本 = COGS 1.08%，毛利 ~98%（Android 抽 1% 后）；即使文库问答 7 点也仅 7.6% COGS。H4 毛利假设=证实。**

## 4. 现行 API 契约（playground 自动生成 curl，2026-09-28）

问答（chat）：
```
POST https://metaso.cn/api/v1/chat/completions
Authorization: Bearer <key>
Content-Type: application/json
{"model":"fast","stream":true,"messages":[{"role":"user","content":"…"}]}
```
- 表单参数：q 查询 / scope 搜索范围(默认网页) / model 模型(极速=fast) / format(chat_completions) / stream / 精简原文匹配
- 旧 skill 文档的 legacy `{"q":…}` 裸格式与旧 scope 枚举（document/scholar/…）**已漂移**；messages 格式为现行

搜索：
```
POST https://metaso.cn/api/v1/search
{"q":"…","scope":"webpage","includeSummary":false,"size":"10","includeRawContent":false,"conciseSnippet":false}
```
（size 是字符串；新增 includeSummary/includeRawContent/conciseSnippet）

抓取网页：POST /api/v1/… （读取网页，format=Markdown，20点/次）

- 另支持 MCP 协议（modelscope: metasota/metaso-search）

## 5. 决定性架构事实

1. **search-api 无法定向工程大脑专题/知识库**：计费标签全集=全网/文库/学术/图片/视频/播客×搜索/问答，无任何「专题/知识库」项 → API 只答公网源，**不带用户私有知识库**。工程大脑只在网页产品（cookie 会话）里可用。
2. **API 积分须充值才能用**（当前 0）：最小档 ¥10.8=1000 点=1000 次全网问答。**充值是用户决策项**。
3. 由 1+2 推论：若产品灵魂=工程大脑私域知识，则（a）metaso API 位置=「带公网出处的外援腿」而非主引擎；（b）主引擎候选=自有语料（13 本书+We-AIPO/EPC100 语料本地都在）+免费模型（GLM-4.7-Flash 免费/laya P1）自建 RAG——零单次成本、无漂移、可私有化。

## 6. UNKNOWN（充值后可解）

- 图片输入（messages.content 多模态数组）是否支持——截图咨询若走秘塔须先验证；备选=云开发 AI+ 视觉（voice_ocr 渠道已备好）
- 响应时延/长度实测（5000 拦截下无法测）
- ds-r1/深度模型计费是否同 1 点
- 幽灵 key mk-B69D 归属账户（用户可能有第二个秘塔账号，建议用户自查）
