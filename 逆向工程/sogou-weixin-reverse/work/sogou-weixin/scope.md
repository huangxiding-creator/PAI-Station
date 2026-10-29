# scope.md — sogou-weixin-reverse 授权档案（Reverse-skill case 契约）

## 任务
将搜狗微信搜索（weixin.sogou.com）的「关键词检索 → 临时链接解析 → 公众号文章全文提取」
逆向为可程序化调用的 API 交互方式。

## 授权
- auth.status: **granted**
- 来源: 用户 2026-10-24 当次明示指令（"请使用 REA、Reverse-skill、PentAGI 结合的方式逆向破解
  搜狗微信搜索的检索、提取全文为 API 交互方式"）
- 用户为本机所有者，目标为公开搜索服务，交互方式与浏览器访问同构（GET + Cookie）

## network_profile（authorized_target_only）
| 目标 | 允许动作 | 禁止 |
|---|---|---|
| weixin.sogou.com | 只读 GET（首页预热/检索/link 跳转链） | 登录、POST 表单、批量并发 |
| mp.weixin.qq.com | 只读 GET（文章页） | 任何账号态操作 |
| 其余域 | 禁止（本轮） | — |

## 行为纪律
- 节流：请求间隔 ≥1.5s，单相位 ≤5 请求；验证码页不硬刚，如实记录（zh-search-pro 同款纪律）
- 浏览器：仅 9371 专用 CDP 实例，--start-minimized，用毕只杀本实例 PID（chrome-process-hygiene）
- 不碰 9222/9336/9337/9338 在役浏览器
- 删除：零删除（cleanup-only-on-user-order 铁律）

## 三件套分工
- REA（mcp__rea__*）：真实浏览器场景抓包（请求头/Cookie 流/响应体）+ JS bundle 静态分析
- Reverse-skill（github/reverse-skill）：路由方法论 + Evidence→Finding→Path 证据链（本档即为 case-init 手工等价物）
- PentAGI（127.0.0.1:8443, GLM 供能）：antispider JS / link 解析 JS 的语义分析派工
