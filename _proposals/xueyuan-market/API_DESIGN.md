# API_DESIGN — 总包学园·研报商城（Phase 5 接口契约）

> 生成：2026-09-28，Super-Skill Phase 5。上游：ARCHITECTURE.md（同日落盘）/REQUIREMENTS.md（FR/NFR 编号为唯一索引）/SCHEMAS.md（表结构）/CONTEXT.md（统一语言）。
> 契约基线：qianwen-engine 生产实核（app.py 路由/Bearer/幂等/pay_sign/503）+zongbao utils/pay.ts 降级实样。**虚拟支付回调/查单/refund_order 的官方字段未公开部分一律标 TBD（开通后实测），不编造微信 API 字段**（依据 KNOWLEDGE_BASE/virtual_pay.md）。
> 金额一律分（price_fen/goodsPrice，如 49800）；env：0=正式 1=沙箱；时间 ISO-8601（UTC+8）。

---

## 一、通例

- **Base URL**：开发/体验版 `http://47.120.43.20:8871/api/v1`（开发者工具关「校验合法域名」）；提审生产 `https://{备案域名}/api/v1`（nginx 反代→127.0.0.1:8871，域名 **TBD 用户定**）。健康探针 `GET /health`（前缀外，无鉴权，FR-P0-10）。
- **鉴权**：`Authorization: Bearer {token}`。token 由 `POST /auth/login` 换发（HMAC-SHA256 载荷签名，{openid,exp}，30 天有效，qianwen wechat.py 同款）。无/错/过期→401；**401 后前端静默 wx.login 重登换发并重试一次**（qianwen 惯例）；session_key 仅服务端留存，永不下发。
- **错误体**（全端点统一，对 qianwen 默认 {detail} 的唯一刻意改良——前端降级矩阵需要稳定机器码）：

```json
{ "code": "PAY_NOT_CONFIGURED", "message": "虚拟支付尚未开通" }
```

- **幂等语义**：outTradeNo 为支付域幂等键——同 outTradeNo 重复回调/重放恒 200 同果（不重复发货，NFR-13）；已解锁再发起支付→409；其余端点自然幂等（GET）或以唯一约束拒绝重复（点赞/批评→429/400）。
- **分页**：`?page=1&page_size=20`（page_size 上限 50）；响应统一 `{items, total, page, page_size}`。
- **限速**（引擎侧按 uid 滑窗，阈值=config.py 配置项）：付费章拉取默认 60 次/分钟（超→429 RATE_LIMITED+企微告警，NFR-05）；search 30 次/分；download 10 次/日。
- **状态码速查**：400 参数/规则拒绝｜401 未登录或过期｜403 有登录无权益（NOT_ENTITLED）｜404 不存在｜409 冲突（已解锁/已发起）｜423 熔断（FUSE_OPEN）｜429 限速或频次上限｜502 微信侧失败｜503 支付未配置（降级）。

## 二、端点契约

### P0 可卖闭环（全量）

#### P0-1 POST /auth/login
- 鉴权：无｜幂等：否（code 微信侧一次性）｜来源：FR-P0-05
- 请求：`{"code": "wx.login 回调 code"}`
- 响应 200：`{"token": "...", "uid": "uXk29f", "expires_in": 2592000, "pay_configured": true}`（pay_configured 供前端预判灰置）
- 错误：400 INVALID_CODE｜502 WX_LOGIN_FAILED（code2session 失败透传 errcode 不透传 secret）
- 说明：openid→uid 短 ID 映射入库（users 表）；session_key 落库仅服务端用；测试双闸 XY_DEV_LOGIN=1 时 code 直映射 dev openid。

#### P0-2 GET /catalog
- 鉴权：无（免登录可逛）｜幂等：是｜来源：FR-P0-02/NFR-01/NFR-02
- 请求：`?tab=hot|new`（默认 hot；`praise` 好评榜在评分数据上线前**不可见**——服务端对 P0 请求该 tab 返回空+`praise_visible:false`）`&province=江苏&owner_type=&industry=&page=&page_size=`
- 响应 200：`{"items": [{"id","title","summary","price_fen":49800,"province","owner_type","industry","chapter_count","trial_chapters":2,"tags":["水网","江苏"],"published_at","cover"}], "total","page","page_size","praise_visible": false}`
- 错误：无特有（非法 tab→400 INVALID_PARAM）
- 说明：三筛选项各自单独与组合均出正确子集（验收判据）；首屏双源=包内 catalog.json 秒开+本接口增量刷新（NFR-02 ≤2s）；P95<500ms（NFR-01）。

#### P0-3 GET /search?q=
- 鉴权：无｜幂等：是｜来源：FR-P0-02/R-10/NFR-01｜详见 §三 FTS5 契约
- 响应 200：`{"layer_used": "L1"|"L2"|"L3"|"like"|"none", "items": [...同 catalog 条目], "hot_words": ["江苏水网","商机清单"], "fallback_hint": false}`
- 说明：三层降级逐层放宽；零命中→`layer_used:"none"`+`fallback_hint:true`→前端降级提示+榜单补位。

#### P0-4 GET /reports/{id}
- 鉴权：可选（带 Bearer→个性化 owned/收藏态；不带→游客视图）｜幂等：是｜来源：FR-P0-03
- 响应 200：

```json
{
  "id": "js-shuiwang-2026", "title": "...", "summary": "...", "price_fen": 49800,
  "anchor_price_fen": 188800, "anchor_copy": "同等深度 1/4 价格",
  "chapter_count": 19, "trial_chapters": 2, "trial_pages": 20,
  "province": "江苏", "owner_type": "水利", "industry": "水网工程", "tags": [...], "published_at": "...",
  "owned": false, "favorited": false,
  "decision_card": {
    "read_pages": 20, "remaining_chapters": 17, "remaining_pages": 280,
    "locked_conclusions": [{"title": "第十一章 时间窗口与行动节奏", "blurred": true}, "...共 N 条..."],
    "toc": [{"id": "ch01", "title": "...", "is_trial": 1}, "..."]
  },
  "preview_triad": {
    "related":       [{"id","title","why": "同省/同业主/同行业"}],
    "readers_also":  [{"id","title"}],
    "rank_badge":    "阅读榜 #3"
  },
  "refund_policy_url": "/pages/agreement/index#refund",
  "disclosure": {"no_reason_refund": false, "invoice_entry": true}
}
```

- 错误：404 REPORT_NOT_FOUND｜说明：预览三件套构成以本契约定稿（REQUIREMENTS FR-P0-03 注）；三维关联推荐=结构化字段精确匹配（不用 AI）；模糊预览仅标题级，不含正文片段。

#### P0-5 GET /reports/{id}/chapters
- 鉴权：可选｜幂等：是｜来源：FR-P0-04/FR-P0-07
- 请求：`?with_content=trial|all`（默认 trial；**权益判定在服务端**——客户端不得自证权益，with_content=all 仅表示「请求含付费正文」，未购仍裁剪）
- 响应 200（未购）：

```json
{"report_id": "...", "trial_chapters": 2, "chapters": [
  {"id": "ch01", "title": "...", "idx": 1, "is_trial": 1, "html": "<h1>...</h1>"},
  {"id": "ch03", "title": "...", "idx": 3, "is_trial": 0, "pages": 18}
]}
```

- 响应 200（已购）：付费章同构但含 `"html": "正文"`；阅读行为落 read_log（P1 建表，P0 先内存/日志态过渡）。
- 错误：404；说明：未购响应的付费章**无 html 字段**（字段缺席而非空串，反编译与抓包双审计判据）；包内 chapters.json 为构建产物，本接口为真源。

#### P0-6 POST /reports/{id}/chapters/{chapter_id}
- 鉴权：Bearer｜幂等：是｜来源：FR-P0-07/NFR-05
- 响应 200：`{"chapter_id": "ch05", "html": "...", "is_trial": 0}`（试读章同端点亦可取，免登录判定在服务端——试读章允许无 Bearer）
- 错误：401｜403 NOT_ENTITLED（**响应体不含 html 字段**）｜404｜429 RATE_LIMITED（60 次/分阈值+企微告警）
- 说明：本端点是防泄漏主闸与限流主落点（链路②/ARCHITECTURE A3）。

#### P0-7 POST /reports/{id}/favorite ／ DELETE /reports/{id}/favorite
- 鉴权：Bearer｜幂等：是（重复 POST/DELETE 均幂等 200）｜来源：FR-P0-09
- 响应 200：`{"favorited": true|false}`；错误：401/404。收藏态以服务端为准（favorites 增补表，ARCHITECTURE §六）。

#### P0-8 POST /pay/sign
- 鉴权：Bearer｜幂等：同 (user,report) 复用最新 pending 订单同 outTradeNo｜来源：FR-P0-06/NFR-10
- 请求：`{"report_id": "js-shuiwang-2026"}`
- 响应 200（字段与 qianwen-engine pay_sign 在役实样逐项对齐）：

```json
{
  "mode": "short_series_goods",
  "sign_data": "<JSON 字符串，客户端原样透传，逐字节绑定签名>",
  "pay_sig": "<HMAC-SHA256(appsecret, \"requestVirtualPayment&\"+sign_data)>",
  "signature": "<HMAC-SHA256(session_key, \"VirtualPayment&\"+sign_data)>",
  "out_trade_no": "js-shuiwang-2026_1759012345",
  "price_fen": 49800
}
```

- sign_data 内部字段（服务端组装）：`offerId`/`buyQuantity:1`/`env:0|1`/`currencyType:"CNY"`/`productId:"xy_report_unlock"`/`goodsPrice:49800`/`outTradeNo:{reportId}_{ts}`（合法字符 [0-9A-Za-z_-|*@]、8-32 位、不以下划线开头）/`attach:sha256(openid)[:16]`/`mode:"short_series_goods"`。
- 错误：401（含 session_key 失效→AUTH_EXPIRED 静默重登重试）｜404 REPORT_NOT_FOUND｜**409 ALREADY_ENTITLED**（已解锁再购同报告）｜**503 降级契约（精确字段）**：

```json
{ "code": "PAY_NOT_CONFIGURED", "message": "虚拟支付尚未开通", "degrade": "pay_gray" }
```

触发条件=virtual_pay_xueyuan.secret 缺失或 offer_id/product_id 为空（含摘除 secret 重启复测，NFR-10）；前端据 code 灰置支付入口，试读/收藏/搜索不受影响；GET /health 仍 200（健康与支付配置解耦）；回填 secret→重启→立即恢复（WFR #45 同款）。

#### P0-9 POST /pay/callback
- 鉴权：无 Bearer（微信服务端推送；**验签方式与应答体格式 TBD——开通后以官方推送实测为准，不编造**）｜幂等：**是（重复回调恒 200 同果）**｜来源：FR-P0-06/NFR-13
- 请求体：微信虚拟支付支付结果通知（**字段名 TBD 实测**；以 outTradeNo 为幂等键核对）
- 响应：官方要求的成功应答（**TBD 实测**）；重复/乱序到达不重复发放权益。
- 副作用（每回调）：orders.raw_notify 落回调原文快照→status pending→paid+wx_order_sn→**首次**发放 entitlements(source=purchase, order_id=outTradeNo)；重复→仅幂等 200。harness D 场景回放断言（验收判据 4）。

#### P0-10 GET /pay/status
- 鉴权：Bearer｜幂等：是｜来源：FR-P0-06
- 请求：`?out_trade_no=...`
- 响应 200：`{"out_trade_no": "...", "report_id": "...", "status": "pending"|"paid"|"failed", "entitlement_granted": true}`
- 说明：前端支付成功回调后轮询本接口确认发货（回调未达时引擎以官方**查单接口**主动核对——接口名与字段 **TBD 开通后实测**）；限 1s 间隔轮询。

#### P0-11 GET /reports/{id}/download?type=read|print
- 鉴权：Bearer+权益｜幂等：是（可重复下载）｜来源：FR-P0-08/NFR-03/NFR-06
- 响应 200：`application/pdf` 流式下发（Content-Disposition 内联文件名；TTFB<2s；引擎内存占用不随文件大小增长——分块流式）；水印=购者昵称+订单尾号（与 pay_log 比对可溯源）。
- 错误：401｜403 NOT_ENTITLED（未购下载被拒）｜404｜429（10 次/日）。P2 前转赠额度锁定为 0（无 transfer 语义）。

#### P0-12 GET /me
- 鉴权：Bearer｜幂等：是｜来源：FR-P0-09
- 响应 200：

```json
{
  "uid": "uXk29f", "nickname": "",
  "entitlements": [{"report_id": "...", "source": "purchase|gift|voucher|invite|compensate", "granted_at": "...", "expires_at": ""}],
  "favorites": [{"report_id": "...", "favorited_at": "..."}],
  "vouchers_balance_fen": 0,
  "refund_count_month": 0, "refund_monthly_limit": 2
}
```

- 说明：支付成功后 entitlements 即时出现（回调腿保证，验收判据 4）；P1 扩展字段向后兼容追加。

### P1 可传闭环（全量）

#### P1-1 POST /reports/{id}/like → 赠报告
- 鉴权：Bearer｜幂等：当日第二次→429｜来源：FR-P1-01/NFR-09
- 请求：`{}`（点赞对象=路径报告；与分享行为完全解耦——任何分享事件不产生得赠）
- 响应 200（当日首次）：`{"granted": true, "granted_report_id": "...", "gift_rule": "每日限 1 份·必得·附条件赠送"}`
- 错误：429 GIFT_DAILY_LIMIT（「明日再来」）｜404。落 gift_grants（UNIQUE(user_id,grant_date)）+entitlements(source=gift)。

#### P1-2 POST /reports/{id}/criticize（四层闸·同步返回 pre_gate）
- 鉴权：Bearer｜幂等：每报告每用户 1 次（UNIQUE 约束）｜来源：FR-P1-02/03
- 请求：`{"content": "批评原文 50-300 字", "order_id": "可选·指定退款订单，缺省取最新已付订单"}`
- 响应 200（预筛通过，评分异步）：

```json
{"criticism_id": "cXk29f", "stage": "pre_gate_passed",
 "anchor_score": 0.72, "similarity_score": 0.11,
 "scoring": "async", "poll": "/api/v1/criticisms/cXk29f"}
```

- 错误（同步拒绝，均不进评分）：403 NOT_PURCHASED（无该报告已付订单）｜400 NO_READ_RECORD（层①无真实阅读行为）｜400 CRITICISM_DUP（每报告 1 次）｜429 REFUND_MONTHLY_LIMIT（当月已 2 次成功退款）｜400 LENGTH_INVALID（≠50-300 字）｜400 ANCHOR_ZERO（模板化话术，锚定分=0 直接不给退）｜409 SIMILARITY_HIGH（与历史批评超阈值——**不自动拒**，转人工队列，`stage:"manual_pending"`）。
- 判断层（异步免费模型，付费模型调用数=0）：三维分+依据落 criticisms.llm_scores/final_score。

#### P1-3 GET /criticisms/{id}
- 鉴权：Bearer（仅作者）｜幂等：是｜来源：FR-P1-04/05
- 响应 200：

```json
{"id": "...", "status": "scored|approved|rejected|manual_pending|closed",
 "llm_scores": {"sincerity": 78, "authenticity": 82, "constructiveness": 70,
                "rationale": "「第 9 章投资规模与实际招标节奏不符」↔ 第九章 投资规模与资金流向分析"},
 "final_score": 76.7, "refund_tier": "tier76",
 "refund": {"refund_id": "...", "method": "auto|manual|voucher", "amount_fen": 38200, "status": "initiated|settled|failed"}}
```

- 错误：401/404/403。

#### P1-4 POST /refund/apply
- 鉴权：Bearer｜幂等：同一 criticism 重复申请→409｜来源：FR-P1-05/06
- 请求：`{"criticism_id": "..."}`（评分路径；客诉路径 `{"order_id":"...","reason":"..."}` 可无 criticism_id）
- 响应 200：`{"refund_id": "...", "platform": "android|ios", "tier": "tier76", "method": "auto|manual|voucher", "amount_fen": 38200, "status": "initiated", "ios_track": null|"引导苹果通道文案"}`
- 错误：404｜409 REFUND_DUP｜**423 FUSE_OPEN**（熔断停新发起：单报告退款率>25% 或全站周退款额>营收 15%；提示「复核中」，流程中的退款不中断）。
- 双轨语义：Android=refund_order 自动原路退（自动退仅 ≤50% 档；更高档或黑名单特征→method=manual）；iOS=等额书券补偿（vouchers source=ios_refund）+苹果通道引导。按比例部分退款的参数级语义 **TBD 开通后实测**，实测不通→全额退+差额书券兜底。

#### P1-5 POST /refund/callback（与支付回调独立路径）
- 鉴权：微信服务端（**验签 TBD 实测**）｜幂等：是｜来源：FR-P1-05/NFR-13
- 说明：退款结果通知（KNOWLEDGE_BASE 记回调事件名 `xpay_refund_notify`，载荷字段 **TBD 实测**）→refunds.status initiated→notify_received→settled/failed+wx_refund_sn；180 天内退款手续费返还校验；重复通知恒 200 同果。

#### P1-6 GET /poster/{report_id}
- 鉴权：Bearer｜幂等：是（同 (user,report,version) 复用缓存图）｜来源：FR-P1-07
- 响应 200：`{"poster_url": "/posters/pXk29f.png", "width": 1080, "height": 1440, "scene_code": "r=Ab3xK9&i=U8mQ2z", "poster_version": "v1"}`
- 说明：服务端 PIL 合成（封面+最狠 1 数据大字+1 句结论+品牌条+码右下规范位+「长按识别 免费读前 20 页」）；码从预生成池取（批量生成期 getUnlimited 实时调用量=0）；scene ≤32 可见字符、不支持 %，溢出走短码 `s=Xk29fA`（poster_code 映射还原）；分享事件另由 P1-8 落 share_event。

#### P1-7 POST /invite/scan
- 鉴权：可选（匿名仅落 scan_visit；登录才可建邀请关系）｜幂等：invite_relation 首触 UNIQUE(invitee_uid,report_id) 先到先记｜来源：FR-P1-08/09
- 请求：`{"scene": "r=Ab3xK9&i=U8mQ2z", "entry_page": "pages/reader/reader"}`
- 响应 200：`{"report_id": "...", "inviter_uid": "u8mQ2z", "degraded": false}`
- 说明：scene 解析失败/短码映射查不到→`degraded:true`+邀请人置空，**免费内容兜底优先于归因**（归因降级不报错）。

#### P1-8 GET /invite/relations
- 鉴权：Bearer｜幂等：是｜来源：FR-P1-08/09
- 响应 200：`{"invited": [{"invitee_uid": "...", "status": "scanned|registered|unlocked|paid", "ts": "..."}], "progress": {"new_users": 2, "required": 2, "unlocked": true}, "voucher_earned_fen": 5000}`

#### P1-9 POST /team ／ POST /team/{team_id}/join
- 鉴权：Bearer｜幂等：重复入队→409｜来源：FR-P1-10
- 请求：`{"report_id": "..."}`（创建）/`{}`（加入）
- 响应 200：`{"team_id": "tXk29f", "report_id": "...", "leader_uid": "...", "size": 2, "capacity": 3, "total_price_fen": 99800, "status": "open|full"}`
- 满 3 人→全队各发 entitlements(source=invite)；未满员资金处置规则页公示后才上线（NFR-09 合规清单）。
- 错误：404｜409 TEAM_FULL/TEAM_DUP。
- **TBD**：组队三人分摊与单道具 49800 分定价的匹配（是否需第二道具/一单多人）待虚拟支付后台实测；兜底两案=①队长单笔 99800 道具+队员免费入队（与 FR「各自付款」不一致须 RUN_LEDGER 变更）②座位差 1 分拆档。定案前本端点不进回归集。

#### P1-10 GET /me/vouchers ／ POST /vouchers/redeem
- 鉴权：Bearer｜幂等：核销以 vouchers.used_order_id 唯一｜来源：FR-P1-11
- GET 响应 200：`{"balance_fen": 54800, "ledger": [{"id","amount_fen","source":"invite|criticism_thanks|ios_refund|campaign","source_ref","status":"active|used|expired","created_at"}]}`
- POST 请求：`{"report_id": "..."}`→响应：`{"redeemed": true, "deducted_fen": 49800, "report_id": "..."}`；错误：400 BALANCE_INSUFFICIENT。
- 书券=非卖品（1 券=1 元=100 分），**无任何提现/转卖出口接口**；49800 分可兑换任一报告（entitlements source=voucher）。

### P2 占位（仅立桩，不实现）

| 端点桩 | 用途 | 来源 |
|---|---|---|
| POST /ai/ask、GET /ai/answer/{id} | AI 伴读（复用总包 AI 顾问 KB 直连链路换 appid；开关降级不伤 P0/P1） | FR-P2-01 |
| POST /subscriptions、GET /subscriptions | 关注省份/主题上新订阅消息 | FR-P2-02 |
| GET /search/purchased?q= | 已购库内全文检索+书签/笔记/划线 | FR-P2-03 |
| POST /reports/{id}/transfer | 水印版转赠 1 次（P2 前锁定为 0） | FR-P2-04 |
| GET /lander/{report_id} | 每报告独立网页落地页（H5 载体） | FR-P2-05 |

## 三、FTS5 检索契约（P0-3 详情）

- **索引结构**：`CREATE VIRTUAL TABLE reports_fts USING fts5(title_toks, summary_toks, chapter_titles_toks, keyword_toks, content='')`——四列均为 **jieba 预分词空格连接列**（入库钩子：content_pipeline 进库时 `fts.rebuild_report(report_id)` 同步重建；默认 tokenizer 不适配 CJK，R-10）。
- **三层降级**（逐层放宽，前层 0 命中才降）：

| 层 | 命中域 | FTS5 列 | layer_used |
|---|---|---|---|
| L1 | 标题/摘要 | title_toks+summary_toks | "L1" |
| L2 | 章节标题 | chapter_titles_toks | "L2" |
| L3 | 商机关键词（tags+章节商机实体，EPC100 产线标注） | keyword_toks | "L3" |
| 兜底 | LIKE 全扫 | reports/chapters `LIKE '%q%'`（40-200 份全扫 P95<500ms 可行） | "like" |
| 无命中 | — | — | "none"+fallback_hint:true |

- **查询管线**：q→jieba 切词→FTS5 OR MATCH（当前层）→0 命中→下一层→仍 0→LIKE→仍 0→none；响应 `layer_used` 为降级标记，前端据此展示「在章节标题中搜索“江苏”」类提示与榜单补位。
- **热词联想**：hot_words 取 tags 频次 Top N（免登录，无个性化）；q 前缀联想走内存缓存。
- **纪律**：检索不做向量/语义（REQUIREMENTS 4.2：40-200 份规模 FTS5 绰绰有余，上向量=P2 后再评估的优化项）。

## 四、对账（pay_log 三腿）

pay_log 语义由 **orders 表承载**（CONTEXT 统一语言：raw_notify 存回调原文；SCHEMAS §5）——不再单建 pay_log 表（qianwen 的独立 pay_log 表在 xueyuan 收敛进 orders，对账口径不变）。

| 腿 | 触发 | 动作 | 判据 |
|---|---|---|---|
| ① 回调腿 | /pay/callback、/refund/callback | 每笔原文落 raw_notify+状态机推进（pending→paid→refunded/refund_partial） | 重复回调幂等 200 不重发放（harness D 场景回放） |
| ② 查单腿 | /pay/status 对 pending 订单+每日巡检 | 以官方查单接口主动核对（**接口名/字段 TBD 开通后实测**） | 回调丢失≤1 巡检周期自愈 |
| ③ 日对账腿 | 每日 09:30 定时 | orders 汇总 vs 官方账单逐单核对→企微退款率日报（含熔断字段+iOS 占比） | 日报金额=orders 汇总 **diff=0**（NFR-12/13）；异常当日追加告警 |

- 沙箱单（env=1）不进营收对账；orders.env 与支付请求 env 严格同源。
- refunds 表汇总 refund_state（none/partial/full）回写 orders；书券发放（vouchers）与退款双轨在日报同版面可查（发放/余额/来源明细三条一致）。

## 五、前端对接速查（featureFlags 降级矩阵）

| 开关/信号 | 前端行为 | 引擎行为 | 依据 |
|---|---|---|---|
| `virtualPay:false`（本地开关） | 支付入口灰置+文案「支付通道开通中，敬请期待。试读章节持续免费开放。」不抛错（pay.ts L28 在役实样） | —（不触网） | NFR-10 |
| 503 `PAY_NOT_CONFIGURED`（服务端） | 同上灰置（据 code 分支） | secret 缺失/offerId 空 | NFR-10/验收判据 3 |
| 两层叠加 | 任一层触发即灰置；`pay_configured:false`（login 回包）可预判 | 回填 secret→重启→恢复 | WFR #43/#45 同款 |
| `cloud:false` | AI 伴读页显示「建设中」降级页 | /ai/* 为 P2 桩 | FR-P2-01 |
| `voiceInput:false` | 语音输入按钮隐藏 | — | config/index.ts 实样 |
| `trialChapterCount:2` | 试读边界按配置渲染 | 服务端裁剪为准，冲突**服务端赢** | engine_conventions §3b |
| 引擎不可达/全线 5xx | 「服务维护」提示+试读缓存页可读（包内 chapters.json） | systemd Restart=always 拉起 | R-07/NFR-11 |
| 401 任意端点 | 静默 wx.login→/auth/login 换发→原请求重试一次 | token 30 天 | qianwen 惯例 |
| 429 RATE_LIMITED（付费章） | 「操作过快」toast | 计数+企微告警 | NFR-05 |

对接三原则：①错误一律按 `code` 分支（message 仅展示）；②支付链前端只透传不组装——sign_data/pay_sig/signature 三值由 /pay/sign 供给、逐字节透传（签名与该字符串绑定）；③本地权益缓存（zongbao store 惯例）只是支付成功回调的先行动作，**云端发货为准**。

---

## 附：FR→端点覆盖索引（28 条全账）

FR-P0-01→content_pipeline 进库（ARCHITECTURE §一/§六）+P0-2/P0-5 数据源｜FR-P0-02→P0-2/P0-3+§三｜FR-P0-03→P0-4｜FR-P0-04→P0-5（试读免登录）｜FR-P0-05→P0-1｜FR-P0-06→P0-8/P0-9/P0-10+503 契约｜FR-P0-07→P0-5/P0-6｜FR-P0-08→P0-11｜FR-P0-09→P0-7/P0-12｜FR-P0-10→/health+ARCHITECTURE §七｜FR-P1-01→P1-1｜FR-P1-02→P1-2（层①）｜FR-P1-03→P1-2（层②预筛）｜FR-P1-04→P1-2/P1-3（判断层）｜FR-P1-05→P1-3/P1-4（映射+双轨）｜FR-P1-06→P1-4（423 FUSE_OPEN）｜FR-P1-07→P1-6｜FR-P1-08→P1-7/P1-8｜FR-P1-09→P1-8｜FR-P1-10→P1-9（TBD 拆分案）｜FR-P1-11→P1-10｜FR-P1-12→EPC100 回流（链路④-8）+P0-12 扩展｜FR-P2-01~06→P2 占位表。
