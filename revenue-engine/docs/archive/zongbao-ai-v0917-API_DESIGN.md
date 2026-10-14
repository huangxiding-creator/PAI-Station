# API_DESIGN — zongwen-ai-v0917（v0.9.17 增量 API 契约）

> 覆盖 v0.9.13 旧档。本轮唯一新端点：DELETE /api/answers/{aid}。

## DELETE /api/answers/{aid} — 软删本人咨询记录

| 项 | 契约 |
|---|---|
| 鉴权 | `Authorization: Bearer <token>`（缺失/无效 → **401**，同全站 _openid 门） |
| owner 门 | Bearer 解析 openid ≠ 行 openid → **404**（不暴露存在性，与 get_answer 同律） |
| 未知 aid | **404** |
| 成功 | **200** `{"deleted": true}`（幂等：已删仍 200，不报错） |
| 副作用 | 仅 `answers.deleted=1`；quota/pay_log/rewards/遥测**零变化** |
| 幂等性 | 重复 DELETE 同 aid → 200 同体（软删天然幂等） |

### 请求/响应示例

```
DELETE /api/answers/a-3kf9x2 HTTP/1.1
Authorization: Bearer eyJ...
→ 200 {"deleted": true}
→ 404 {"detail": "记录不存在"}     # 未知 aid 或非本人
→ 401 {"detail": "未登录或凭证过期"}  # 无/坏 Bearer（_openid 助手在役文案）
```

### store 层（软删原语）

`delete_answer(aid: str, openid: str) -> bool`：
`UPDATE answers SET deleted=1 WHERE id=? AND openid=?`（rowcount 0 = 非 owner/
不存在/已删 → 端点仍回 200 幂等语义由调用方判定：先 get 判 owner 再 UPDATE，
事务内完成）。

## 既有端点的行为变化（schema 不变，内容过滤）

| 端点 | 变化 |
|---|---|
| GET /api/history | items 不含 deleted 行（history WHERE 加 deleted=0） |
| GET /api/history（服务端计数） | export_unpaid_all 不含 deleted 行（history_all 同过滤） |
| GET /api/answer/{aid}（本人门） | deleted 行 → 404 |
| GET /api/answer/{aid}（观看者可见性门） | deleted 行 → 404 |

## 客户端封装（utils/api.js 新增）

`answerDelete(aid)` → `requestRaw('DELETE', '/api/answers/' + aid)`：
- 2xx → resolve（deleted:true）
- 404 → resolve({deleted:false, notFound:true})（非本人/不存在按幂等处理，
  前端照常移除该行——列表与服务端终将一致）

## 遥测事件（shape 门 [a-z0-9_]{1,40}，无需引擎改动）

`record_delete_tap`（点击删除钮）/ `record_delete_ok`（删除成功）——ver=0.9.18，
可在 /api/telemetry/recent 查得（X-Tel-Key 门）。
