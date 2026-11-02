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
- app 域 book/info → 401（与 -2012 同因，token 陈旧非协议分离——待新登录态复测）
- 待复测清单：①book/info 200 ②chapterdownload chapters=0-1 权限语义 ③encryptKey→zip 解密 ④enVersion=7.5.0 兼容性 ⑤/book/search 形态

## 7. 工件位

- 探针：`replica/wrapp_probe.py`（两发只读，凭据零打印）
- 证据：`evidence/`（endpoint_catalog.txt / probe_*.json|zip）
- 反汇编：`apktool_out/`（全量 smali）；解包：`extracted/`
- 巨人件：`github/weread_downloader`（Go 协议蓝本）、`github/touchFish`（web 签名蓝本）
- 既有产线：`scripts/weread_*.py` + `research/weread/`（web 路线全套账）
