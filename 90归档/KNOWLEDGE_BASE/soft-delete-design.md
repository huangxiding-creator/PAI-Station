# 咨询记录软删设计（v0917 定案）

## 原则：用户视角消失 ≠ 物理抹账

answers 行身后挂财务/审计链：pay_log（订单核销）、rewards（赠次记账，aid 引用）、
遥测。**软删（deleted=1）只动展示与可见性，物理表零删除。**

## 可见性门（store.py，T-010 实现后定稿：五门）

| 函数 | 改法 | 理由 |
|---|---|---|
| `history(openid)` | WHERE 加 `AND deleted=0` | 我的页列表 |
| `history_all(openid)` | 同上 | 批量导出计数（MEDIUM-5 口径） |
| `get_answer(aid, openid)` | 本人取行加过滤（`include_deleted=True` 内部参数仅供端点幂等判定，缺省行为不变） | 已删=404 |
| `get_answer_visible(aid, openid)` | 观看者门（经 get_answer 继承过滤） | 已删对观看者=404 |
| `pot_list()` | JOIN WHERE 加 `AND a.deleted=0`（T-009 judge 抓出的幽灵泄漏：软删后锅圈仍出预览，T-010 修复+回归测试） | 公共锅圈不陈列已删 |

**裁定记录**：`public_stats()` 的咨询总数聚合计软删行（不随删递减）=有意保留（审计口径，
非内容泄漏，REQ 未覆盖）；财务路径（refund/pay_log/share_on/share_off）一律不过滤。
**pending 行可删**（judge P5 探针边缘）：额度在提问时已扣，在途删除=用户显式弃单，
完成态写入永久不可见行、无复活无腐化——行为保留不设闸（my 页列表本就只展示
history 返回行）。

- 列迁移：`_ANSWER_UPGRADES` 追加 `("deleted INTEGER DEFAULT 0", "deleted INT DEFAULT 0")`
  （sqlite/mysql 双方言，duplicate column 吞掉幂等）+ 两处 CREATE TABLE 定义同步 +
  scripts/mysql_schema.sql 同步（部署手册两处同改的既定纪律）。
- 锅圈 curator 行 openid=pot-curator，用户 token 永不等于 → owner 门天然不可达。

## 端点契约

`DELETE /api/answers/{aid}`：Bearer 鉴权 → owner 门（openid≠行主 → 404，不暴露存在性）
→ 置 deleted=1（幂等：已删仍 200）→ 返回 {deleted: true}。**不动** quota/pay_log/rewards。

## 客户端（my 页）

- 行内删除入口（hist-item 右侧删除钮）→ qw-pop 自绘确认（「删除后不可恢复」固定
  文案，规避原生 modal 4 字按钮限）→ 乐观移除 items → 失败回滚+toast。
- 遥测：record_delete_tap / record_delete_ok（白名单事件名加腿）。
- 删除后列表空态自然切换（既有 wx:elif 链零改动）。
