# wenku PC 客户端 (3.4.3) API 面静态猎杀笔记 — W3

日期: 2026-10-21 | 方法: 纯静态（asar 定向抽取 + 字符串/调用点挖掘），未运行抽出物、未联网、未登录
样本: wenku-Setup-3.4.3.exe → nsis_out/blk108_110844922.bin (app.asar) → `E:\AI-Station\kb_rev\asar_files\`（84 件，SHA256 全验通过）

> 本客户端 = 魔改 wexond 浏览器（webpack id `wenku_pc`），文库功能几乎全靠内嵌 web 页；**自有 API 面极小**（4 个 CGI + sula + 升级 + 一批页面 URL）。
> 全部偏移为 `asar_files\` 下对应文件的字节偏移（bundle 为压缩单行，无行号可言）。

## 0. 工具修正（影响 W1/W2 结论，必读）

- **asar data_start = 8 + json_len**（4B pickle size + 4B json_len + json；本档 json_len%4==0 无 pad）。
  旧 `asar_extract.py` 用 `16 + json_len` → **恒偏 8 字节**。此前抽出的 package.json 首尾错位（`{"nam` 丢失、尾部混入下个文件头 8 字节）——内容结论（main=build/main.bundle.js 等）仍成立，但字节不可信。
- 本任务 `asar_pull_targets.py` 已修正并对每件做头内 SHA256 校验（sha_bad=0）。

## 1. 端点总表（12 组）

基座：`currentUrl()` = https://wenku.baidu.com（main@929063, module 14019）。主进程 HTTP 层 = module 97246（axios, timeout 10s, withCredentials, transformRequest 支持 form/json）+ `httpRequest({base,path,data,method})`（main@986144）。

| # | ⭐ | method | 端点 | 参数 | 证据(文件@偏移) | 置信 |
|---|---|--------|------|------|-----------------|------|
| EP01 | ⭐ | GET | `wenku.baidu.com/user/interface/getuserinfo` | 无显式参（Cookie鉴权）; 响应 `{data:{userInfo:{isLogin..}}}` | main@1067146 (SERVICE_API.USERINFO) + fetchUserInfo@1065477 | 高 |
| EP02 | ⭐ | GET | `wenku.baidu.com/customer/interface/vipinfo` | 同上; 响应 `{data:{vipInfo}}` | main@1067282 + 合并@1065701 | 高 |
| EP03 | | GET | `wenku.baidu.com/user/interface/sendconvertevent` | event(默认'13')/url(trackPath)/bdvid | main@1067431 + sendLaunchParams@1054556 + IPC `WK_SEND_TF_LOG`@1005506 | 中高 |
| EP04 | ⭐ | POST | `wenku.baidu.com/gsula/sula/syncmrecall` | body `{requests:[{sceneID:n}]}`, JSON, wkAxios | main@990574 (module 88655 getSulaData 原文) + IPC `sula-params`→`get-sula-data`@963897 | 高 |
| EP05 | | GET | `wenku.baidu.com/cashier/interfacev2/getqrpaycode` | 客户端改写: 删`action`加`ext_third_fr=pc_client_win_{ch}_{ver}` | main@1070856 (webRequest拦截) | 高 |
| EP06 | | (POST?) | `wenku.baidu.com/ndcashier/api/maketradeasync` | 同上注入 | main@1070980 | 高(改写)/中(method) |
| EP07 | | GET | `wkctj.baidu.com/click.gif \| /pv.gif` | channelNum 默认 newClient2024 | main@1070700 | 高 |
| EP08 | ⭐ | GET页 | `wenku.baidu.com/view/{docId}` | 客户端追加 `hasOpen=true&wkpc_client_channel={ch}`; 深链协议 `wkpcclient://wenku.baidu.com/reader?docId=` | main@1071100区 + getDocIdFromUrl(module 58811)@1068400区 | 高 |
| EP09 | | GET | `edu-wenku.bdimg.com/v1/pcclient/upgrade` | win/mac 同址; electron-updater generic | main@1135624 (module 1942) + autoUpdater@996779 | 中(feed 在 asar 外) |
| EP10 | ⭐ | GET页 | `wenku.baidu.com/ndcore/browse/aiunion` | `actTab=chat`/`fr=pcclient|options_search_1/2/6/7`/`landType=ppt|writing|image|contract` | app@11317–12283 + defaulttab@7890–8724 | 高 |
| EP11 | | GET页 | `wenku.baidu.com/ndcore/browse/database?tab=download&t={ts}&recentdoctab=` | 下载库页 | downloads.bundle@20555 | 高 |
| EP12 | | GET页 | 登录/VIP中心/收银台/帮助/画布等 14 个页面 URL（见 JSON EP12 全列） | cashier_code=pcClent_2024_* | main@1128850–1131100 (module 97861 env→URL 表) + main@929063 | 高 |

**⭐ 检索/元数据靶心判读**：
- `syncmrecall`（EP04）是客户端唯一直连的**结构化数据**接口（推荐召回，返回文档元数据），免费层首选直连候选——但要带 passport Cookie。
- 客户端侧"搜索"= aiunion AI 页落地（EP10，landType 分流）+ 新标签搜索框直接跳 `www.baidu.com/s?wd=`（defaulttab@18375，IPC `load-h5-url`）。**真正的文档检索 XHR 在 web 前端 JS（wenku.baidu.com 页面）里，不在本客户端包** → 交给 W4 抓包腿。
- EP01/EP02 的 userInfo/vipInfo 含 doc 元数据无关，但为鉴权态探针。

## 2. 鉴权流（三件套定位）

1. **登录**：纯网页登录。`LoginURL = https://wenku.baidu.com/pcClientLogin/login.html`（main@929740, module 14019）。客户端无任何账号/密码/加密代码。
2. **登录态判定** `verifyLogin()`（main@1063240 区域）：读 `session.defaultSession.cookies({url:"https://passport.baidu.com"})`，校验四 cookie：`BDUSS / BDUSS_BFESS / BAIDUID / BAIDUID_BFESS`；只余 `*_BFESS` 变体时做修复（删 BFESS 留原值）。`getBdUid()` 取 BAIDUID。
3. **请求鉴权**（main@985000, module 97246 axios 拦截器）：惰性拼接 passport.baidu.com 全量 cookie 为 `Cookie: name=value; name=value;` 头，注入每个主进程请求；`resetCookie()` 在登录态变化时清缓存。
4. **device-id**：node-machine-id 1.1.12（module 61572@698984）：Windows 走 `REG QUERY HKLM\SOFTWARE\Microsoft\Cryptography /v MachineGuid` → sha256；`getDeviceInfo()`（module 54348@1059600）产出 {platform, hostname, cpu, mac, sysVer, appVer, deviceId, ip, sessionId=`YYYYMMDDHHmmss-{uuid前13}`}，IPC handle `get-device-info`。
5. **加密假设证伪**：`node-rsa / speakeasy / spy-client` 仅出现在内嵌 package.json 依赖清单（main@2011858），main.bundle **零 import 零调用**（setPublicKey/totp 0 hits）→ 之前"登录=node-rsa+speakeasy"的推断不成立，高置信。
6. **彩蛋（quirk）**：`setLoginCookies()` 把 passport cookies 复制到 `baidu-int.com` 域（url=`http://fedev_yg01.wk.wenku.baidu-int.com/`，有效期 1h，main@1064500 区域）——内网联调残留，等于把 BDUSS 泄给 baidu-int 域。logout 遍历删 baidu.com/baidu-int.com 全部 cookie。

## 3. 下载流初判（只定位）

- 客户端只有**通用 Electron 下载管理**：session `will-download` + IPC `download-pause/resume/cancel/remove/open-when-done`（main@1023825 区域）；记录 nedb `userData/storage/downloads.db`；状态机 `DOWNLOAD_FILE_STATUS`（module 63734@931274）。
- 文档导出/下载权限（VIP 门禁）全在 web 页 server-side；客户端仅拿 EP02 vipinfo 做展示，导出文件落地由 will-download 承接。**无 download/export/getfile 直连 CGI**。
- 下载库页 EP11；下载管理 UI = build/downloads*.bundle.js（本地记录渲染，无网络面）。

## 4. 内部 IPC 面（79 通道，供动态腿参考）

要点：`get-user-info`(handle)、`get-device-info`(handle)、`sula-params`→`get-sula-data`、`WK_SEND_TF_LOG`、`update-check/update-download/install-update`、`logout-refresh-tabs`、`load-h5-url`、`get-win32-install-Info`。全表见 `scan_out/`（或按需再跑 ipc 枚举脚本）。内部页协议 `wkpcclient://`（module 57799@931595）。

## 5. 环境切换

`currentUrl(env)`：ONLINE/RD/QA 全指向 https://wenku.baidu.com（main@929063）；module 97861（main@1128850）里 rd/qa 才切 `fedev_*.wenku.baidu-int.com` 内网 host。渠道位：`channelNum` 默认 `newClient2024`，TF 渠道白名单 `WKPCBDCPCWIN202501/WKPCBDCPCMAC202501`（main@1054556 区域）。

## 6. 最意外发现

1. node-rsa/speakeasy 声明未用——登录纯 web cookie，无客户端加密。
2. 旧抽取器恒偏 8 字节（见 §0），W1/W2 的字节级结论需用本任务脚本重抽。
3. sula `syncmrecall` 是唯一结构化元数据直连接口，藏在主进程 IPC `sula-params` 后面。
4. BDUSS 被复制到 baidu-int.com 域（联调残留）。

## 7. 落盘清单

- `E:\AI-Station\kb_rev\api_notes.md`（本文）
- `E:\AI-Station\kb_rev\api_endpoints.json`（机读端点表）
- `E:\AI-Station\kb_rev\asar_files\`（84 件靶标，SHA256 全验）：build/{main,auth,96,62,193,486,downloads-dialog,downloads,bookmarks,search,update,app,menu,defaulttab,view-preload}.bundle.js + @baidu/orion-request 整包(47件) + orion-aitrack src(14件) + node-machine-id(2件)
- `E:\AI-Station\kb_rev\scan_out\`：urls.tsv(157) / paths.tsv(30) / ctx_hits.txt(2201 关键词上下文块)
- 工具（本 worker worktree 内）: asar_pull_targets.py / asar_verify_base.py / scan_endpoints.py / dump_ctx.py

## 8. 对 W4 的建议

1. 抓包腿直接打 aiunion 页内检索 XHR（客户端不含）；先登录拿 BDUSS（pcClientLogin 页或 passport 通道），复用 §2 的 cookie 注入格式。
2. syncmrecall 可先用无登录态试打（withCookies:false）看是否匿名放行——免费层试探点。
3. asar 重抽一律用 `data_start=8+json_len` + SHA256 校验。
