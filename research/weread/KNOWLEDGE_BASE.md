# Phase 3 · 微信读书逆向知识库（PIPELINE_MAP 性质，随实测更新）

> 来源：社区开源项目实证（touchFish/lbq110/HuanMeng233/obsidian-plugin）+ 本地 Tencent-WeChatReading 官方技能。
> ⚠️ 本文档是逆向期的**权威链路地图**，每次实测发现偏差必须回写（RE-Factory 证据链文化）。

## 1. 登录协议（web 扫码，免浏览器可复现）

```
POST https://weread.qq.com/web/login/getuid      (body: {} , Content-Type: application/json)
  → {"uid": "..."}                                # 二维码 uid，有效期短
QR 内容 = https://weread.qq.com/web/confirm?pf=2&uid=<uid>   # 生成二维码图片供微信扫
POST https://weread.qq.com/web/login/getinfo     (body: {"uid": "<uid>"})  # 长轮询 ~60s
  → {"skey": "...", "vid": ..., "redirect_uri": ..., "code": ...}
落地 cookie: wr_skey=<skey>; wr_vid=<vid>; wr_pf=2（另有 wr_localvid / wr_rt）
```

- 本项目登录形态：**DrissionPage 打开 weread.qq.com 页面内嵌二维码，用户扫一次**；cookie 从浏览器提取（省去本地生成二维码的依赖，且登录流量与真人完全一致）。
- `wr_skey` 有效期约 30 天；任意页面访问响应的 `Set-Cookie` 可续期。
- 登录失效统一信号：响应 JSON `errCode: -2012`。

## 2. Web API 端点清单（cookie 认证）

通用 Header：
```
Cookie: wr_skey=...; wr_vid=...;
User-Agent: <真实 Chrome UA>
Referer: https://weread.qq.com/
Accept: application/json
```

| 端点 | 方法 | 签名 | 用途 |
|------|------|------|------|
| `/web/book/search?keyword=&maxIdx=&count=&chapterIdx=&synckey=0&scene=19` | GET | 无 | **关键词搜索**（bookId/标题/作者/简介/封面） |
| `/web/book/info?bookId=` | GET | 无 | 书籍详情：`format`(epub/pdf/txt)、`maxFreeChapter`、`paid`、`totalWords`、作者/封面元数据 |
| `/web/book/chapterInfos` | POST `{"bookIds":[...]}` | 无 | 章节目录（章节树：chapterUid/标题/level/页数） |
| `/web/book/getProgress?bookId=` | GET | 无 | 阅读进度 |
| `/web/book/publicinfos` | POST `{"bookIds":[...]}` | 无 | 免登录批量元数据 |
| `/web/user` | GET | 无 | 用户信息（**cookie 有效性检验端点**） |
| `/web/book/chapter/e_0` `e_1` `e_2` `e_3` | POST | **有** | epub/pdf 章节正文分片：e_0+e_1+e_3 拼 HTML，e_2 为 CSS |
| `/web/book/chapter/t_0` `t_1` | POST | **有** | txt 章节正文 |
| `/web/book/read` | POST | 有 | 上报阅读（**本项目永不调用**——写操作高危） |

## 3. 章节正文签名算法（touchFish wereadSign.ts 完整还原，待移植 Python）

POST body 字段：
```
b  = calcHash(bookId)          # 书 hash
c  = calcHash(chapterUid)      # 章 hash
e: ["epub"] / ["txt"]          # 格式标记（实测确认）
pc = calcHash(prevChapterUid 等页状态串)
ps = calcHash(页状态串)
r  = <随机数>
ct = <毫秒时间戳>
s  = sign(排序拼接串)
appId = "wb" + UA 各段长度%10 拼接 + "h" + BKDR(ua) 截 16 位
```

**calcHash(data)**：
1. `m = md5(data)`；取 `m` 的**前 3 个字符**；
2. 类型标记：data 纯数字 → `"3"` + 每 9 位一组转 hex；否则 `"4"` + 逐字符 charCode 转 hex；
3. 再拼 `"2" + m 的末 2 位` + 长度信息。

**sign(str)**（对 key 排序后的 `k=v&` 拼接串）：
```
n1 = n2 = 0x15051505
从串尾 i=len-1 向头遍历:
    n1 ^= charCode(i) << ((len - i) % 30)
    n2 ^= charCode(i-1) << (i % 30)        # i>0
    n1 &= 0x7fffffff; n2 &= 0x7fffffff
s = (n1 + n2).toString(16)
```

**BKDR hash(ua)**：`hash = hash*131 + charCode`（32 位截断），取 hex 前 16 位。

> ⚠️ 移植后必须与 TS 版做**同输入同输出**向量对拍（单测金标准）。

## 4. 正文解混淆算法（touchFish wereadDecrypt.ts）

响应文本结构：`md5(body).toUpperCase()（32位）+ body`
1. `chk()`：前 32 位 md5 校验，剥离；
2. 解混淆 dH/dS/dT：取 body **尾部 ≤4 字符**按 2 进制展开 → `parseInt(x,4)` 解出"交换位置表" → **倒序成对交换** body 字符；
3. base64 解码 → **HTML/CSS 原文**。

epub 书：`e_0 + e_1 + e_3` 拼正文 HTML，`e_2` 为样式；txt 书：`t_0 + t_1`。

## 5. 正文反爬形态（fallback 路线知识）

- 网页正文不走 DOM 文本，直接 **Canvas 绘制**（同一 Canvas 同时画当前页+下一页）；插图是 DOM `<img class="wr_readerImage">`。
- 无字体反爬（非猫眼式 font 映射）。
- Canvas Hook 法：注入 JS 包装 `CanvasRenderingContext2D.fillText` 截获 (字符, x, y) → 按 y 分行 x 排序重建文本（lbq110 双页 y 坐标拆分法）。本项目仅作签名失效时的预留 fallback。

## 6. 风控红线（账号安全宪法，违者熔断）

1. **自动化浏览器检测真实存在**：命中即上报 vid+设备指纹 → 封号（weread-spy issue #44 多人实锤）。→ 浏览器仅登录用，且带 `--disable-blink-features=AutomationControlled`；提取走纯 API。
2. 高危排序：整书下载(chapterdownload) > 自动阅读刷时长 > 高频章节直调 > 笔记同步。→ 本项目只做"低频章节直调"，间隔人类化。
3. `wr_skey` 30 天；多端并发登录互踢。→ 单 profile 单设备。
4. 权限边界：无限卡=在线读全书 ≠ 可下载；`maxFreeChapter` 外非会员不可读；部分书限 App 阅读（web 无解，属正常 partial）。
5. 官方 Skill API（i.weread.qq.com/api/agent/gateway，`Authorization: Bearer wrk-xxx`）只读合规无正文——元数据层备用，本项目主线不用（避免 Key 管理）。

## 7. 与本地官方技能的关系

`C:\Users\91216\.claude\skills\Tencent-WeChatReading\`（V1.0.4）覆盖搜索/详情/目录/笔记/统计（官方 Gateway）。
本渠道需要**正文**，官方无此能力 → 走 web API 逆向路线；若未来官方开放正文接口，优先切换。

## 8. 实测勘误表（Phase 11 真机验证回写）

> 背景：2026-09-10 真机验证时发现微信读书 web 已重构为 **wrweb-next（Nuxt）**，
> API 面大面积迁移。以下均为抓包实证（scripts/weread_listen.py 可复现侦察）。

| 日期 | 端点/算法 | 实测结论 | 状态 |
|------|----------|---------|------|
| 2026-09-10 | `/web/user` | **已死**：登录态也恒返 `errCode:-2003 参数格式错误`（errMsg 有误导性，勿当参数问题排查）。登录检查改用 `/api/user/config`（登录返回 `accountsets`） | ✅ 已改 |
| 2026-09-10 | `/web/book/search` | **已死（404）**。新端点 `GET /api/store/search?keyword=`，无签名，返回 `results[].books[].bookInfo`（按 电子书/有声书 分组） | ✅ 已改 |
| 2026-09-10 | `/web/book/info` | **仍活**，字段不变（format/paid/maxFreeChapter/totalWords/cover） | ✅ 不变 |
| 2026-09-10 | `/web/book/chapterInfos` | **仍活**，但响应形态 `data[].chapters[]` → `data[].updated[]`（字段 chapterUid/title/level/wordCount/files 不变） | ✅ 已改 |
| 2026-09-10 | `/web/book/chapter/e_*` `t_*` | **仍活，响应混淆格式不变**（md5 头 32 位 + 交换还原 + base64；e_0+e_1+e_3 拼接后整体解密） | ✅ 不变 |
| 2026-09-10 | 签名 payload | `ps`/`pc` **不再是固定魔串**：为请求构造瞬间的连续时间戳哈希，实测 `ps=calcHash(ct-3)`、`pc=calcHash(ct-1)`；**新增字段 `sc:0` 并纳入签名**。离线复算抓包 `s` 逐字节一致（tests/test_weread_client.py） | ✅ 已改 |
| 2026-09-10 | 签名算法本体 | 双累加器异或滚动**完全未变**，黄金向量依然全部通过 | ✅ 不变 |
| 2026-09-10 | `r`/`ct`/`st` | 实测 `r=1637²`（randint(0,9999)² 确认）、`ct` 秒级、`st` 同旧 | ✅ 不变 |
| 2026-09-10 | 会员阅读权 | **`paid=0`+`maxFreeChapter=7` 不代表只能读 7 章**：无限卡会员全本可读。extract_book 以一次探测请求判定（免费范围外首章可读 → 全本），不可读才回落免费范围 | ✅ 已改 |
| 2026-09-10 | UA 一致性 | cookie 签发浏览器为 Chrome/152；客户端 UA 应与登录浏览器同源（降低指纹摩擦），默认 UA 已升级 | ✅ 已改 |
| 2026-09-10 | reader 路由 | 阅读器 URL `/web/reader/{hex}`，其中 hex = `calcHash(数字bookId)`（如 24276056→551323f071726c58551fe37）；`/web/bookDetail/{id}` 已 404 | 📖 记录 |
| 2026-09-10 | `/web/login/renewal` | 未实测（本次登录态新鲜）；保留原实现，下次续期时验证 | ⚠️ 待验 |

**协议漂移应对模式**（可复用方法论）：写死端点的客户端必配**流量侦察工具**
（scripts/weread_listen.py：附着登录浏览器 → 真实交互 → 抓 `/api/*` 新契约），
端点死亡时 30 分钟内可完成再逆向。
