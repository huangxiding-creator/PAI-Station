# FEASIBILITY_REPORT — zongbao-ai-v0917（分享全量启用 + 咨询记录删除）

## 结论：可行（CC-FPS = 0.92，绿灯 ≥0.7）

两项改动均落在既有同构先例与既有迁移机制上，零新基建、零新依赖。

## 地面真值（2026-10-13 实测代码勘察）

### 令① 全页面分享

- **灰按钮根因确证**：微信平台机制——页面未声明 `onShareAppMessage` → 「转发给朋友」
  灰；未声明 `onShareTimeline` → 「分享到朋友圈」灰。与后端无关。
- **页面清单（10 页）与现状**：

| 页面 | onShareAppMessage | onShareTimeline |
|---|---|---|
| answer | ✅ 已有（过审先例） | ❌ |
| report | ✅ 已有（过审先例） | ❌ |
| research | ✅ 已有 | ❌ |
| zhiku | ✅ 已有 | ❌ |
| ask / home / my / pot / invoice / legal | ❌（6 页缺失） | ❌ |

- **朋友圈首启风险**：onShareTimeline 需要「单页模式」自洽（query 携参页面在无登录态
  冷启动时的降级）；answer/report 详情页已有深链自洽先例（s=r 深链 0.9.15 过审）。

### 令② 咨询记录删除

- 客户端：my 页 `items` ← `GET /api/history`（store.history，20 条截断）；行=`hist-item`
  bindtap=onItem。
- 引擎：**无删除端点**；answers 表无 deleted 列。
- **列迁移机制已在役**：store.py `_upgrade("answers", _ANSWER_UPGRADES)` 逐列 ALTER
  平滑升级（sqlite/mysql 双方言、duplicate column 吞掉）——加 `deleted` 列零风险。
- 需同步三处可见性：`history`/`history_all`（我的列表与导出计数）、`get_answer_visible`
  （观看者门）+ `get_answer`（本人门）——deleted 行一律 404。
- 财务安全：pay_log / rewards / telemetry 均独立于 answers 展示层——软删不动账。

## CC-FPS 评分

| 维度 | 分 | 依据 |
|---|---|---|
| 技术可行性 | 0.95 | 全部同构先例 + 既有迁移机制 |
| 合规可行性 | 0.9 | 分享文案沿用过审形态；删除不碰诱导红线；隐私面只减不增 |
| 资源 | 0.95 | 单会话可完成；无新采购 |
| 时间 | 0.9 | 三线门禁+上云+提审机械全部在役 |
| 风险可控性 | 0.85 | 朋友圈首启为唯一新能力面（见 RISK_REGISTER R1） |
| **CC-FPS** | **0.92** | ≥0.7 绿灯 |

## 依赖与顺序

引擎先行（删除端点+软删列上云 TCB）→ 客户端（分享 handler 铺满 + 删除交互）→
三线门禁 → robot 上传 → 提审。0.9.16 尚在审核中——**新版本 0.9.17 提审不撤旧审**
（微信允许队列中追加新版本提审，0.9.16 若先过审可先发布，互不阻塞）。
