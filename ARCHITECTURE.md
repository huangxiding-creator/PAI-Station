# ARCHITECTURE — zongbao-ai-v0917（0.9.17 增量架构）

> 本文件=本轮增量架构记录（覆盖 v0.9.13 旧档）。权威设计细则：
> [KNOWLEDGE_BASE/share-semantics.md](KNOWLEDGE_BASE/share-semantics.md) ·
> [KNOWLEDGE_BASE/soft-delete-design.md](KNOWLEDGE_BASE/soft-delete-design.md)

## 系统拓扑（不变量）

```
微信客户端（10 页，原生 WXML）
  │  https ai.epcschool.top（downloadFile/request 合法域名）
  ▼
FastAPI 引擎（TCB 云托管 qianwen-engine，MySQL，部署号递增）
  ├─ store.py（_SCHEMA 双方言 + _ANSWER_UPGRADES 逐列 ALTER 迁移）
  └─ app.py（端点；_openid(request) Bearer 鉴权门）
外围机械：upload_qianwen.mjs（robot 轮转）/ submit_review_09xx（六段向导）/
QianwenReviewWatch（住哨，绝不自动发布）
```

## 变更面与 ADR

### ADR-1 分享全量启用=纯客户端静态层（零架构影响）

- 10 页补 `onShareAppMessage`（4 页已有同构先例，6 页新增）+ 全量
  `onShareTimeline`（0→10，首次启用朋友圈能力）。
- **拒绝项**：集中式 mixin/behavior 注入统一 handler——微信平台按页面注册，分散
  handler 是平台事实标准；集中注入收益小且偏离原生调试体验。
- query 政策：内容自洽页携最小参数（report?sku= / answer?id=）；其余页不携。
  单页模式（1154）无登录态 → 既有 fail-open 骨架（quotaError 态 v0.9.1 在役）。

### ADR-2 删除=软删（deleted=1），非物删、非前端隐藏

- **拒绝物理 DELETE**：pay_log 订单核销、rewards 赠次记账以 aid 外键引用，物删
  断审计链（发票口径、退款核查受损）。
- **拒绝仅前端隐藏**：多端不一致（换设备重现）+ 批量导出金额口径
  （history_all 服务端权威，MEDIUM-5 在案）仍会计入。
- 可见性门四改点（history / history_all / get_answer / get_answer_visible）
  见 [soft-delete-design.md](KNOWLEDGE_BASE/soft-delete-design.md)。

### ADR-3 列迁移走 _ANSWER_UPGRADES（拒绝影子表）

- **拒绝 answers_deleted 影子表**：四条查询全部要 LEFT JOIN/UNION 排除影子行，
  复杂度与遗漏面远大于一列 ALTER；_ANSWER_UPGRADES 机制在役（INT DEFAULT 0，
  InnoDB 秒级，duplicate column 吞掉幂等）。
- 四点同步纪律：store.py 两处 CREATE TABLE（新库直建对）+ _ANSWER_UPGRADES
  （旧库平滑）+ scripts/mysql_schema.sql（部署手册镜像）。

### ADR-4 删除确认=qw-pop 自绘（拒绝原生 modal / ActionSheet）

- 原生 wx.showModal 真机按钮 ≤4 字静默死（v0.9.6 根因战在案）；ActionSheet 同
  受限。qw-pop 系统全站在役，确认弹窗文案「删除后不可恢复」。

## 缝合契约（组件交接）

| 上游 → 下游 | 上游 DoD | 下游入口条件 |
|---|---|---|
| 引擎删除端点 → my 页交互 | DELETE 200/404/401 语义定案+pytest 绿 | api.js answerDelete(aid) 封装就位 |
| store 软删 → 各读腿 | 四可见性门过滤 pytest 绿 | history 响应 schema 不变（deleted 行天然缺席，客户端零解析改动） |
| 分享 handler → 提审 | BOOT-SIM 逐页锚+诱导词扫荡绿 | 六段向导 fill 前人工核 dump |
| deleted 列 → TCB 部署 | 本地 sqlite 全测绿 | qw_tcb_prep→mn_client deploy→三板斧 |

## 风险架构呼应

R1（单页模式）/R2（诱导红线）/R5（history_all 漏滤）分别由 REQ-003 e2e、REQ-002.AC3
扫荡锚、REQ-004.AC3 pytest 承接；R7（在审冲突）由 REQ-008.AC3 提审前置检查承接。
