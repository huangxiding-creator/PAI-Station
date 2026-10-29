# scope.md — metaso-kb-reverse 授权档案（复刻 sogou-weixin-reverse / metaso-reverse 结构契约）

## 任务
将秘塔(metaso.cn)「工程行业大脑」知识库专题（subject-v2 管理页）的
**检索文件 + 下载文件**功能逆向为纯 HTTP API 客户端（curl_cffi，零浏览器）。
目标专题: https://metaso.cn/subject-v2/8673582927558737920/manage

## 授权
- auth.status: **granted**
- 来源: 用户 2026-10-24 当次明示专项令（本任务全文）+ metaso-reverse 同日全渠道API化逆向令
- 用户=该专题管理员/创建者（自建自管专题，自有账号自有数据，登录凭据由用户明示提供）
- 同域先例: ../metaso-reverse/（匿名chat面已破，meta-token预热链/UA/cookie面直接复用）

## network_profile（authorized_target_only）
| 目标 | 允许动作 | 禁止 |
|---|---|---|
| metaso.cn | 登录（手机号+密码，用户提供凭据）+ 本专题 subject-v2 的文件列表/检索/详情/下载端点 | 他人公开专题、批量并发、写操作 |
| 文件CDN域（下载直链所落域） | 只读 GET 下载用户专题文件 | — |
| 其余域 | 禁止（本轮） | — |

## 凭据纪律（用户专项令）
- 凭据只住 `E:/AI-Station/data/secrets/metaso_kb.secret`（目录经 git check-ignore 实证: .gitignore:34 `data/`）
- 一切脚本从此文件读；会话输出/commit/报告一律掩码（158****2899 / Ohw****@7）
- 登录态(cookie/JWT)持久化同目录 `metaso_kb_state.json`（同 gitignored）

## 行为纪律
- 若密码登录不存在（仅验证码登录）→ 如实定性停下报告，不代收验证码
- 下载保守: 样例 ≤3 个文件；不做整库大批量下载
- 浏览器: 仅 REA 自launch临时profile（headless）实弹侦察，抓完即清 headless 实例；不碰 9222/9336/9337/9338/9551 在役端口；不杀用户24个在役 chrome 进程
- 删除: 零删除（cleanup-only-on-user-order 铁律）
- 密钥/登录态零进仓；本地 commit 仅代码与规约（secret 排除）；无 push

## 交付三件套
- captures/: REA 抓包实录 + 关键词检索清单
- replica/metaso_kb_api.py: 登录态持久化+检索+下载三段，CLI与import双用
- 逆向报告.md: 登录/检索/下载三层 API 规约 + 5次独立会话贯通验收

## 后续接入（coordinator 1024 追加令）
破解完成后接入调研渠道体系（同当当先例）: reforge_factory/completeness/channel_matrix.py 加条目
(engine=metaso_kb) + legs/api_replica_bridge.py 登记第8件 + legs/metaso_kb_leg.py 采集腿 +
channel_invocations.jsonl 记账 + EPC-OVERSEAS 验证命中计入。
