# scope.md — djyanbao-reverse 授权档案（复刻 sogou-weixin-reverse 契约）

## 任务
将洞见研报（www.djyanbao.com）的「关键词检索 → 报告卡片列表 → 详情/摘要提取」
逆向为纯 HTTP API 客户端，替代 persistent-profile 浏览器采集。

## 授权
- auth.status: **granted**
- 来源: 用户 2026-10-24 当次明示指令（1024 全渠道 API 化令: 把「洞见研报(djyanbao.com)」
  逆向破解为纯 HTTP API 客户端）
- VIP 账号在册至 2027-01，登录态走合法凭据（profile 会话导出），不破解付费墙
- 现状基线: 本战役浏览器版已实收 13 件卡片（staging/djyanbao/records.jsonl），
  免费面给摘要+图表数据

## network_profile（authorized_target_only）
| 目标 | 允许动作 | 禁止 |
|---|---|---|
| www.djyanbao.com | 只读 GET（搜索页/列表 API/详情 API/图表数据 API）+ 合法登录态请求 | 破解付费墙、批量并发、写操作 |
| 其余域 | 禁止（本轮） | — |

## 行为纪律
- 节流：请求间隔 ≥2s；拒载/风控页不硬刚，如实记录
- 浏览器：仅抓包用（离屏/最小化），抓完即清（chrome-process-hygiene）；
  不碰 9222/9336/9337/9338 在役浏览器
- 删除：零删除（cleanup-only-on-user-order 铁律）；无 push
- 密钥/登录态文件不进仓（.gitignore 覆盖 state 文件）
- 数字零造假：贯通率/字段数以实测为准

## 三件套分工
- REA（mcp__rea__*）：搜索页/详情页 XHR 实弹抓包（端点/参数/Cookie 依赖/响应体）
- 现有资产: reforge_factory/harvest_djyanbao.py（浏览器版）+ 旧版端点线索
  /report/search?sort=publish_at&order=DESC（djyanbao_drission.py）
- 复刻件: replica/djyanbao_api.py（curl_cffi + cookie jar，5 次独立会话实测贯通）
