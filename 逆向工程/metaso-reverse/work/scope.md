# scope.md — metaso-reverse 授权档案（Reverse-skill case 契约，复刻 sogou-weixin-reverse 结构）

## 任务
将秘塔AI搜索（metaso.cn）的「关键词 → chat式AI综述 + 来源清单（全网/学术双scope）」
逆向为纯 HTTP API 客户端（requests/curl_cffi，零浏览器），替代 DrissionPage 9551 浏览器采集腿。

## 授权
- auth.status: **granted**
- 来源: 用户 2026-10-24 当次明示指令「全渠道API化逆向」令（本任务=其中metaso分项）
- 用户为本机所有者；目标为公开搜索服务，匿名免登录面（本战役采集腿已实证可用）
- 交互方式与浏览器访问同构（GET/POST + Cookie）

## network_profile（authorized_target_only）
| 目标 | 允许动作 | 禁止 |
|---|---|---|
| metaso.cn | 只读优先：GET/POST 检索与答案流端点（chat 同构） | 登录、付费墙破解、批量并发 |
| 其余域 | 禁止（本轮） | — |

## 行为纪律
- 已知墙如实记录: 开放API POST /api/v1/search 要key(errCode:2005) → 走匿名面，不破key墙
- 节流: 请求间隔 ≥5s（AI生成本身耗时），单相位 ≤6 请求
- 浏览器: 仅 REA 自launch临时实例（headless，比 --start-minimized 更严），抓完即清；不碰 9222/9336/9337/9338/9551 在役端口
- 删除: 零删除（cleanup-only-on-user-order 铁律）
- 密钥不进仓; 无 git push

## 三件套分工
- REA（mcp__rea__*）: capture_browser_scenario 抓 chat 搜索真实 XHR/Fetch（请求头/体/响应流）
- PentAGI（可选）: 复杂签名 JS 派工 GLM 分析（未遇强签名则不用）
- replica/metaso_api.py: 纯HTTP复刻件，5次独立会话贯通验收
