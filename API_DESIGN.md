# API_DESIGN — revenue-engine（缝合接口契约 v1）

> 自研面只有三个接口点 + EspoCRM 使用约定；全部开源件自身 API 以其官方文档为准。

## 1. 8440 注入口（REQ-005，FastAPI）

### POST /enqueue

```
Headers: X-Api-Key: <key>   # 环境变量 RE_ENQUEUE_KEY，泄露即轮换
Body:
{
  "group": "xxx@chatroom",        # 必填，目标群 wxid
  "text": "…",                    # 必填，发送内容
  "priority": 3,                  # 1=问答 2=推荐 3=推送（预算裁决序，REQ-005.AC3）
  "dedup_key": "<md5 前50字符>",   # 可选，同群同 key 幂等丢弃
  "source": "proactive|transformer|manual"  # 审计字段
}
Response:
  202 {"queued": true, "position": n}        # 入队成功
  429 {"reason": "per_chat_daily|global_daily|cooldown"}  # 安全网拒绝（不可绕过）
  401 {"reason": "bad key"}
  422 {"reason": "schema"}
```

- 鉴权失败计数：连续 10 次 401 → 告警（防爆破）
- 服务入口补进 main.py（现仅 selftest/run/monitor/both 四子命令）

## 2. 信号→Lead 契约（C1，transformer 输入 schema）

```json
{
  "wxid": "wxid_xxx",            // 归一化键优先级1
  "nickname": "张工",             // 归一化键优先级2（+群）
  "phone_hint": null,             // 归一化键优先级3（1v1 中获得时）
  "group": "水利总包交流群",
  "text": "我们在做XX水库项目，找EPC合作",
  "signal_type": "project|help|purchase|competitor",
  "score": 72,                    // REQ-014 评分
  "ts": "2026-10-14T09:00:00+08:00"
}
```

## 3. EspoCRM 使用约定

- 认证：`X-Api-Key` 头（CRM 内建用户，仅授权 Lead 实体）
- 建档：`POST /Lead`，字段映射：

| EspoCRM 字段 | 来源 |
|---|---|
| name | nickname（无则 wxid 尾 6 位） |
| emailAddress | phone_hint 有则入 description（非邮箱字段） |
| description | 追加式：[时间|群] 触发原文摘录 |
| source | group 名（自定义字段「来源群」） |
| 方案 | score（自定义字段「商机评分」，排序用，REQ-014.AC2） |
| accountName | signal_type |

- 去重：先 GET 查询（wxid/归一化键）→ 命中则 PATCH 追加 description + 来源群，未命中 POST（内置 duplicate check 兜底）
- 流转：Lead.status 自定义枚举：New → Nurturing(培育中) → Recommended(已推荐) → PrivateChat(私聊中) → Won(成交) / Lost（REQ-013 四级状态）

## 4. 企微告警 payload（webhook markdown 消息模板）

```
【商机告警|评分 78】
谁：张工（水利总包交流群）
需求：XX 水库 EPC 合作
建议：顾问级——24h 内人工跟进
源消息：<摘要 50 字>
```

## 5. acg-faka 订单回调 → 归因（C4）

- acg-faka 商品 SKU ↔ 研报 ID 映射表（配置文件，非代码）
- 回调（webhook/轮询二选一，部署时按插件实测定）提取：订单号/SKU/购买者标识/金额
- transformer 写回：源 Lead PATCH status=Won + description 追加订单号（前 10 单人工全量核对，REQ-017）

## 6. 全局日 20 插件接口点（LangBot 插件，~50 行）

- 挂载：LangBot 插件处理器（发送出口统一拦截位——实现前先做挂载点实验，见 REQ-010.AC3）
- 计数器：`data/global_daily_count_YYYYMMDD.json`（重启不清零）
- 语义：同一发送事件只计一次；被动回复计入不豁免；fixwin 是独立计数器
- 超限行为：丢弃 + console_notice，主动推送顺延次日（REQ-005.AC3 优先级）

## 7. scoring.md（评分公式，revenue-engine/docs/scoring.md）

score = 省份系数(w: 苏浙粤=1.2) × 行业系数(水利/EPC=1.3) × 规模系数(投资额分档) × 时间窗系数(在招标期=1.5)
阈值表（唯一来源）：告警 70 / 推荐触发 50；调参记录追加式留痕。
