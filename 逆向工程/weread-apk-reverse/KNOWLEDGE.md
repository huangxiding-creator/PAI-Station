# 微信读书 APK 深逆向知识库（1102 战役，随实测回写）

> 靶件：`逆向工程/逆向标的/微信读书.apk` = 官方最新版 **10.2.2.10167650**（sha256 `0d0838…a7b1e`；
> 官网下载件同版本同尺寸，内部条目 CRC 全同，仅容器字节异——渠道差异在签名块，不影响分析）。
> 目标（用户两令定焦）：**在不封号前提下大幅提高日下载量**（现状 web 管线 2 本/日）。

## 1. 架构定性

- Qt… 不，React Native + Hermes：39 个 `.hbc`（Hermes 字节码）业务包 + 原生阅读引擎（libmodpdfium/libmodft2/libhwTTS）+ OkHttp/Retrofit 网络层（Kotlin）
- 包名 com.tencent.weread，minSdk 24 / targetSdk 33，21,782 类
- 加密件：`libencrypt.so`（含 zip 密码派生 remap 表）、`libcishusafe.so`（防篡改）、libQBarMod（二维码）

## 2. 认证面（地面真值，10.2.2 实测反编译）

`com.tencent.weread.network.interceptor.LoginStateInterceptor.intercept()`：
- 登录态：**`accessToken` + `vid` 两个请求头**（accessToken=登录 skey）
- 未登录：`vid` 降级为 URL query 参数
- **无请求签名、无设备指纹头、无 nonce** —— OkHttp 默认 TLS 指纹 + 头即全部伪装成本

`WRRequestInterceptor$Companion.getRequestHeaders()` 公共头表：

| 头 | 值来源（smali 实证） | 复刻值 |
|---|---|---|
| appver | APP_VERSION（配置） | `10.2.2` |
| basever | versionName.versionCode | `10.2.2.10167650` |
| baseapi | `String.valueOf(Build.VERSION.SDK_INT)` | `34`（任意真实 API 级） |
| osver | Build.VERSION.RELEASE | `14` |
| channelId | ChannelConfig.getChannelId() | `12`（与渠道包对应） |
| User-Agent | `"WeRead/"+ver+" WRBrand/"+brand+" Dalvik/2.1.0 (…)"` | 按真机格式拼 |
| accessToken / vid | 登录态（见上） | web 登录 skey/vid |

Retrofit base：`i.weread.qq.com`（UrlFactory 实证）。

## 3. 整本下载协议（地面真值 + HuanMeng233/weread_downloader 交叉验证）

1. `GET i.weread.qq.com/book/info?bookId=&myzy=1&source=reading&teenmode=0`
   → version / chapterSize / lastChapterIdx / format / paid…
   章区间末 = chapterSize + lastChapterIdx − 1
2. `GET i.weread.qq.com/book/chapterdownload` @Query（10.2.2 smali 实证，与 7.5.0 件完全一致）：
   `bookId, chapters=0-N, pf=wechat_wx-2001-android-100-weread, pfkey, zoneId=1, bookVersion, bookType, quote, release=1, stopAutoPayWhenBNE=1, preload=2, preview=0, offline=0, giftPayingCard=0, enVersion, modernVersion, teenmode=0`
   → **整书一个 ZIP**（epub=章HTML+Styles；txt=章文本），`@Streaming`
3. 响应头 `encryptKey`（base64）→ AES-CBC 解出 zip 密码：
   - remap 表 `2d 50 56 d7 72 53 bf 22 fb 20`（**10.2.2 实证在 libencrypt.so 内**，算法与 Go 件一致）
   - key=vid 数位映射重复至 32B 取前 16B；iv=后 16B；解 encryptKey 前 16B，取可打印字符为密码
4. 状态语义：**401=登录失效；402=无整本下载权限**
5. PDF 书直链：`GET res.weread.qq.com/wrco/{pdfBookId}`（DownloadPdf 端点，免整链）

## 4. 检索面（app 域）

`/book/search`、`/store/search`、`/store/titlesearch`、`/topic/search`、`/cloudbooksearch/preheat`
（另有 web 域 `/api/store/search` 在役——站内既有管线已验证）
完整端点目录 201 个见 `evidence/endpoint_catalog.txt`。

## 5. 风险工程账（为什么这条路能安全放量）

- 真 app「下载全本」本就是高频合法行为（囤书离线读）；整书 1-2 请求 vs web 逐章 200+ 请求 = **请求量降约百倍**
- 社区件封号根因（我们逐项修复）：①伪装 7.5.0 旧版（→10.2.2 全指纹）②无节奏（→人类化批量会话）③无伴生行为（→可选 chapterInfos 预取）④一次性脚本特征（→稳定会话+保活心跳走 web 域）
- 站内账号安全宪法继续在役：只读、熔断、异常码即停、单设备单 profile、日限阶梯观察（10→20→30）
- **未决**：无限卡账号对 chapterdownload 的 402 边界（待登录后实测：3300229637 此前全本可读）

## 6. 实测时间线（1102）

- 17:38 web `/web/book/info` → errCode **-2012**（登录态 10-25 存档已失效）→ 起扫码登录（b7ztp37ag）+ 企微通知已发
- 17:36 用户新扫码 → web skey 新鲜；**app 域 book/info 仍 401/-2012**（accessToken 头与 Cookie 形态双测均拒）
  → **token 分离实锤**：i.weread.qq.com 只认 app 自有 accessToken；HuanMeng 路线 2024-08 已被官方掐死
  （GitHub issue「一直提示登录超时」2024-08 实锤，工具 2023-12 弃更）
- app 登录协议：`account/model/WRLoginService` — `login`/@POST /login @JSONField(code,deviceId,pf,timestamp,random,signature…)
  = wx OAuth code + 签名兑换；`refreshToken` 续期；guest/guestLogin 游客通道。纯 HTTP 复刻成本高 → 弃
- **路线决策（用户拍板）**：雷电9模拟器跑真 app（流量100%真app，封号检测无从谈起）→ UIA 驱动「下载全本」→ adb 拉件 → 本地解密
- 18:00 雷电9 装于 `F:\leidian\LDPlayer9`（用户手装，安装器静默参数不被接受）；adb=emulator-5554；官方APK `adb install -r` Success
- 18:04 app 登录页 → 隐私协议弹窗（同意并继续@[1280,1208]）→ 登录方式：微 信 登 录[918-1014] / **微信扫码登录[1046-1142]** / 直接试用
  → 点「微信扫码登录」出二维码（evidence/emu_screen4.png）→ **等用户手机扫码**（唯一必要可见环节）
- deeplink：`weread://` scheme（LaunchExternalSchema，exported singleTask）+ https weread.qq.com；实测路由待登录后验
- 驱动件：`replica/ldapp_driver.py`（dump/shot/tap/tap-text/deeplink/pull/launch）
- 转换件：`replica/wrapp_zip.py`（zip→book.json/md，站内 schema 同构：chapterUid/html/images/level/text/title）
- 用户令追加：**避免频繁弹窗**（popup-minimize-discipline 记忆已立档）

## 6b. 登录后待办

1. deeplink 实测：`weread://web/bookDetail?bookId=3300229637` 是否直达详情页
2. 详情页按钮面：加入书架/下载全本(或缓存/离线) 的文本+坐标 → 驱动流程定型
3. 单本全流程实走：下载 → `adb shell find /sdcard/Android/data/com.tencent.weread -name "*.zip"` 定位落盘
4. 拉件 → wrapp_zip 转换 → 与 web 管线产物对拍验收（章数/字数/空文）
5. 节奏引擎：25-90s 人类化抖动 + 会话批量（模拟晚间囤书）+ 异常截图熔断

## 6c. 封存与一键续跑协议（1102 用户暂离，等回座扫码）

**当前态**（封存时点）：雷电9 运行中（F:\leidian\LDPlayer9, adb=emulator-5554, 网络22ms已验）；
微信读书 10.2.2 已装；LoginActivity 微信扫码页；**隐私协议已同意**（持久）；二维码会过期——回来后**先刷新再扫**。

**用户回座后三步**（agent 执行，用户只做扫码一个动作）：
1. `replica/ldapp_driver.py focus` 确认 app 状态；若在登录页 → `shot qr` 看码；若显示已失效 → `tap 780 770` 刷新
2. 置前模拟器窗（PowerShell AppActivate dnplayer）+ 挂自动护航（协议弹窗自动点同 意 + 防抖登录识别，脚本在
   git log 2f8b3ea85 消息与 bhz9nipjj 任务命令里，可直接复用 ldapp_batch.py 的 dump/tap 工具重写 5 行）
3. 用户手机微信扫码→允许 → 护航报 LOGIN_CONFIRMED → 直接进 §6b 待办 1

**续跑口令**：用户说「我回来了/扫了/继续weread」皆触发上述三步。

## 7. 工件位

- 探针：`replica/wrapp_probe.py`（两发只读，凭据零打印）
- 证据：`evidence/`（endpoint_catalog.txt / probe_*.json|zip）
- 反汇编：`apktool_out/`（全量 smali）；解包：`extracted/`
- 巨人件：`github/weread_downloader`（Go 协议蓝本）、`github/touchFish`（web 签名蓝本）
- 既有产线：`scripts/weread_*.py` + `research/weread/`（web 路线全套账）
