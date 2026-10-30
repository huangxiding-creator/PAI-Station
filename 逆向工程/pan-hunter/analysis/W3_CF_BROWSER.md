# W3 CF 浏览器栈腿台账（2026-10-30 夜 · DrissionPage 4.1.1.4）

> 任务：5 质询源过墙后抓搜索 API 形态（明文 API→curl_cffi 配方化；纯页面→SPA 采集要点）。
> 纪律执行：headless 优先+离屏兜底、auto_port 临时 profile（不碰 9222/9336/9438）、
> 只这 5 站、用完即 quit。Chrome 守门：脚本前后 47→54，甄别后 54 全为站在役自动化
> （9222/9336/9438/autopub×3/mp_qr），**本腿浏览器零残留**。
> 发数：17/40（浏览器导航 12 + curl 复放 5）。证据 JSON：analysis/w3_cf_browser.json。

## 一、总裁决表

| 源 | 首页过墙 | 搜索端点 | 定性（W3 终判） |
|---|---|---|---|
| yiso | ✓（title=yiso.fun） | ✗ API「Attention Required」CF 403 页（浏览器内仍质询，XHR 自重试 3 次） | **端点级 CF 设防**：首页过墙≠API 过墙；api/search 路径单独质询，不可配方化 |
| aipanso | ✓ | ✗ SPA 壳无数据（/search 自回环 5 次，无独立 JSON XHR） | **SPA 采集要点**：数据由 /search?page&k&p 端点自回（无独立 API）；端点质询未过=壳循环；需 turnstile 交互清理后才有数据 |
| kkmao | ✓ 但 title=**Farewell** | ✗ /?s=「Just a moment…」 | **疑关站**（首页即告别页）+搜索路径质询；判源死/转型，并入死源观察名单 |
| ting77 | ✓（headless 崩→离屏成；title=影视资源论坛） | ✗「Just a moment…」+ **reCAPTCHA**（google recaptcha api2 实捕） | **交互型 turnstile+reCAPTCHA 双墙**：零交互自动化不可过；离屏窗可开首页（标题/广告 cookie 实捕：__gads/_ga 族） |
| pan666 | ✓（但 302→member.php 登录页） | ✗ 520 Web server is returning an error（curl 复放同 520） | **站变形实锤**：Flarum→Discuz（member.php?mod=logging）；API 520=源站故障/下线；判死源/转型 |

## 二、结论

1. **配方化 0/5**：五源均未取得 cf_clearance（质询为 turnstile 交互型，非 JS 自动清理型）；
   curl_cffi 复放 4 超时+1 HTTP 520，全败如实。
2. **首页 vs 端点双层墙**：5/5 首页浏览器可开，0/5 搜索端点可过——CF 对 API/搜索路径单独设防，
   「浏览器过首页→导出 cookie→curl 复放」路径对 turnstile 交互墙**不成立**（无 clearance 可导）。
3. **源名单修正（W0 审计更新）**：CF 质询 5 源重定性=
   死/转型 2（kkmao 疑关站、pan666 转 Discuz+520）+ 交互墙 3（yiso/aipanso/ting77，需
   人机交互清理，超出零凭据免登录自动化口径，维持墙源不进产线）。
4. 副产物：ting77 离屏窗实测可稳定开首页（广告/统计 cookie 实捕），若未来人工辅助腿
   （用户点头即过 turnstile）可复用 scripts/w3_cf_browser.py 离屏模式。

## 三、复放记录（w3_cf_ledger.jsonl 逐发）

- yiso replay: Timeout（直连 15s）；aipanso replay: Timeout；kkmao replay: Timeout；
  ting77 replay: Timeout；pan666 replay: **HTTP 520** len=7322（CF 错误页）。
