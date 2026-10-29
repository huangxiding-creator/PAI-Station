# 百度网盘客户端 静态字符串普查汇总（STATIC_NETBASE）

日期: 2026-10-29 | 方法: `scripts/string_sweep.py`（python -I, ASCII+UTF-16LE ≥5字符, pefile 导入表, 未运行任何被分析二进制）
原始清单: `STATIC_STRINGS_RAW.md` | 机器摘要: `_digest.json`

## 0. 标的档案

| 二进制 | 大小 | 机器位 | 导入特征(网络相关) | 角色(静态判定) |
|---|---|---|---|---|
| netbase.dll | 12.4MB | x86 | WINHTTP + WS2_32 + CRYPT32 + ncrypt + IPHLPAPI | **Chromium Cronet 网络栈**(静态链 BoringSSL+protobuf+QUIC+gRPC+SQLite) |
| kernel_btsdk.dll | 4.4MB | x86 | WSOCK32 + WS2_32 + CRYPT32 + bcrypt | **BT/P2P 传输SDK**(libtorrent 系, PDB: `H:\baidu\netdisk\btsdk\lib\Release\btsdk.pdb`) |
| YunDls.dll | 2.3MB | x86 | WININET + WINTRUST + **updateagent.dll** + bcrypt | 下载引擎 + 插件/浏览器引擎热更新 |
| YunLogic.dll | 4.3MB | x86 | WININET + WINTRUST + WS2_32 | 业务逻辑+端点/配置层(端点金矿) |
| logonbd.dll | 4.4MB | x86 | WININET + WINHTTP + **WebView2Loader** + CRYPT32 | 登录(passport/wappass, WebView2 UI) |
| channelpcsdk.dll | 0.4MB | x86 | WINHTTP + WS2_32 + IPHLPAPI | 渠道 PCS 瘦客户端(BDUSS 引用2处) |
| cefbrowser.dll | 0.4MB | x86 | libcef(无自有网络栈) | CEF 壳 |
| minosagent.dll | 5.5MB | x86 | CRYPT32 + bcrypt + WLDAP32(内嵌 curl+SQLCipher) | 遥测/日志上报 agent + 本地加密库(SQLCipher) |
| bdpan.exe | 18.0MB | **x64** | 仅 kernel32.dll | **Go 单文件**官方开放平台 CLI(见§5) |

注: netbase.dll 与 kernel_btsdk.dll 文件时间戳 = 2026-10-29 18:06/18:07（当日被热更新替换），其余 = 2026-02-12。

## 1. 端点/域名常量总表

| 域名/端点 | 藏于 | 原文样例 |
|---|---|---|
| d.pcs.baidu.com | YunLogic, bdpan.exe | `pcs_root_path="http%3A%2F%2Fd.pcs.baidu.com%2F"` + https 变体; bdpan: `https://d.pcs.baidu.com`(PCS base URL) |
| c/c2/c3.pcs.baidu.com | YunLogic | 下载分片 shard 域 |
| pcs.baidu.com / *.pcs.baidu-int.com (c-pcs/d-pcs/c0-pcs/nest-pcs) | YunLogic | `;domain=c-pcs.baidu-int.com` 等 Cookie 域(**内网域进发布版**) |
| baidupcs.baidu-int.com / thumbnail*-baidupcs.baidu-int.com | YunLogic | 同上, 内网缩略图/PCS |
| issuecdn.baidupcs.com / cdn.baidupcs.com | YunLogic, YunDls | `issue/netdisk/pc-guanjia-plugin-update/BrowserEngine/BrowserEngine_1.cab`(热更cab) |
| passport.baidu.com | YunLogic, logonbd, bdpan | 登录/换票 |
| wappass.baidu.com (+rdtest/qatest 测试域) | logonbd | `wappass.baidu.com/static/appsapi/conf/winsdk.txt`、`win-conf.txt`(远程登录UI配置), `/wp/login/proxy`; **测试域 passport-rdtest/passport.qatest/wappass-rdtest/wappass.qatest 一并内置** |
| diskapi.baidu.com | YunLogic, minosagent | `rest/2.0/netdisk/log?method=set`、`rest/2.0/netdisk/timestamp?method=get` |
| update.pan.baidu.com | kernel_btsdk, YunDls, minosagent | `http://update.pan.baidu.com/statistics` |
| openapi.baidu.com | bdpan.exe | `https://openapi.baidu.com/oauth/2.0/token`(OAuth) |
| pan.baidu.com | bdpan.exe, YunLogic | union/spirit/launch、apaas share(见§5) |
| 180.76.76.200 | **netbase.dll** | `http://180.76.76.200/v4/resolve?account_id=171195&type=dual_stack&dn=%s&sign=%s&t=%s` = **百度 HTTPDNS**(账号171195, 签名+时间戳) → 解释 netbase 零明文域名 |
| nsclick.baidu.com | logonbd | `https://nsclick.baidu.com/v.gif?`(打点) |
| himg.bdimg.com / nd-static.bdstatic.com / staticsns.cdn.bcebos.com | logonbd / YunLogic | 头像/静态资源 |
| icode.baidu.com | bdpan.exe | Go 符号中的**内部源码路径**: `icode.baidu.com/baidu/netdisk/open-sdk-go/openxpanapi`、`nd-ai-bdpan/internal/secret.AppID` |
| aippt.baidu.com | bdpan.exe | AI PPT 集成 |
| 内部源码路径泄漏 | kernel_btsdk, YunDls | `H:\baidu\netdisk\btsdk\src\core\btsdk_torrent.cpp`、`h:\baidu\netdisk\pc-yunbrowser\...`、`Login\LoginProcessor\LoginProcessorBaiduPassport.cpp`(YunLogic RTTI) |

## 2. UA / clienttype / appid 常量（原文摘录）

- **UA 模板(YunLogic)**: `netdisk;%s;PC;PC-Windows;%s;WindowsBaiduYunGuanJia` → 即 `netdisk;<ver>;PC;PC-Windows;<channel>;WindowsBaiduYunGuanJia`
- **UA(BT 引擎 kernel_btsdk)**: `netdisk;BT;` 片段; UPnP: `User-Agent: Windows, UPnP/1.1, MiniUPnPc/2.0`; 伪装客户端串 `BitSpirit {:d}`
- **UA(bdpan.exe)**: `BaiduPanGoSDK/1.0`、`bdpan/%s (%s/%s)`
- **UA(logonbd)**: `User-Agent: ie; windowsSdk`
- **clienttype**: YunDls `?clienttype=%d&devuid=%s&channel=%s&version=%s&id=%s&vip=%d`; kernel_btsdk `?ver=1&clienttype=`; YunLogic `clienttype=%u&channel=%s&version=%s&devuid=%s`; minosagent `%s%sclienttype=%d&vip=%d&devuid=%s&version=%s`
- **appid**: YunLogic `pcs_appid="250528"`、`pass_appid="1"`、`dls_appid="1"`; YunDls `&pluginclient=8&current=%s&querytime=0&plugin_appid=%u`
- **凭据**: BDUSS/STOKEN 明文键名遍布 YunLogic/YunDls/logonbd/channelpcsdk; **YunDls 以 MFC CArchive 持久化**: `bsBDUSSW`、`bsDlsTokenWW`、`0TbsStoken`; bdstoken 走 `rest/2.0/dss/online?method=report&appid=%s&bdstoken=%s`

## 3. 秒传/分片上传常量

- **superfile 路径**: bdpan `rest/2.0/pcs/superfile2`(+`Pcssuperfile2` API 型); YunLogic 配置开关 `upload_using_superfile3_count_v2` / `upload_using_superfile3_count` / `upload_using_superfile3_percent` → **superfile3 已灰度**
- **precreate**: bdpan `Xpanfileprecreate` + `baidupan: Precreate block_list must not be empty`; JSON 标签 `json:"block_list"` / `json:"block_list,omitempty"` / `json:"md5"`
- **分片**: `baidupan: SliceUpload uploadid mus...`、`scene: compute block md5: %w`(分片md5计算)、`Multipart upload: %s %s field=%s file=%s size=%d`; superfile2 请求含 `Partseq` 参数(`ApiPcssuperfile2Request.Partseq`)
- 未发现明文 block size 常量(4MB/16MB/32MB 数值型不在字符串层, 需反汇编/动态腿确认)

## 4. 网络栈与 cert pinning 判定

| 二进制 | TLS/网络栈 | Pinning 判定 |
|---|---|---|
| netbase.dll | Cronet(Chromium)+BoringSSL 静态链, QUIC(`QUIC key expansion`)+gRPC(`components\grpc_support\bidirectional_stream.cc`)+protobuf; HTTPDNS 180.76.76.200 | **能力在/启用待验证**: `Cronet_PublicKeyPins_*` 全套 API + `StaticKeyPinningEnforcement` 已编译入; 未见明文 pin 值(可能运行时下发) |
| kernel_btsdk.dll | 原生 socket(WSOCK32/WS2_32) + **OpenSSL 1.1.0 25 Aug 2016**(严重过老) | 无自证 pinning; `X509_verify_cert` 为 OpenSSL 自带 |
| YunDls.dll | WinINet + WinTRUST + **OpenSSL 1.1.1s(2022-11)** 双栈 | 无 pinning 线索; 靠系统信任链 |
| YunLogic.dll | WinINet | 无 pinning 线索; 但有**模块签名校验**: `Verify sign error[0x%x]`、`Verify sign publisher error real[%s] target[%s]`、`sign_key`(验的是插件签名非 TLS) |
| logonbd.dll | WinINet+WinHTTP, WebView2 登录UI | 无 pinning; ` public key hash: sha256//%s` 为证书打印格式串 |
| minosagent.dll | 内嵌 curl+OpenSSL 1.1.1s + SQLCipher(本地库加密) | 无 pinning |
| cacert.pem | — | **= curl/Mozilla 根证书束**(147 张, 快照 2021-04-13, 头部自述 "Bundle of CA Root Certificates / Certificate data from Mozilla"), **非百度自签/非私有CA** → 无中间人自有 CA 迹象 |

## 5. bdpan.exe 官方端点面（Go, x64, kernel32-only）

- 运行时证据: `runtime.newosproc`、goroutine、http2 Framer、`GODEBUG`、cobra(`COBRA_ACTIVE_HELP`, flags 解析) → **Go + cobra CLI**; 非Node
- SDK 血统: Go 符号直指 `icode.baidu.com/baidu/netdisk/open-sdk-go/openxpanapi`(官方开放平台Go SDK) + `nd-ai-bdpan/internal/secret.AppID`(内部AppID密钥模块)
- 端点清单:
  - `https://openapi.baidu.com/oauth/2.0/token` (OAuth2 换token; 凭据=access_token/refresh_token JSON, **不走BDUSS**)
  - `https://d.pcs.baidu.com` + `/rest/2.0/pcs/superfile2` (分片上传)
  - `xpan/file?method=filemanager&opera=rename` 等 xpan 家族; 方法集: `Xpanfilelist/listall/search/create/doclist/imagelist/precreate/nasuinfo`
  - `https://pan.baidu.com/union/spirit/launch?` (联盟拉起)
  - `https://pan.baidu.com/apaas/1.0/share/verify?product=netdisk&appid=%s&access_token=%s&short_url=%s` 与 `.../share/transfer?...` (分享校验/转存)
  - `update_check.json`(自更新检查), 环境变量 `BDPAN_CONFIG_PATH`
  - 字样 `mcpserver` → 内置 MCP server 能力(需动态腿确认暴露面)
- 错误文案佐证全量上传协议在壳内: `upload precreate: %w`、`upload slice: %w`、`baidupan: invalid PCS base URL:`、`baidupan: marshal block_list: %w`

## 6. 热更新线索

- YunDls.dll **直接导入 updateagent.dll**; 目录内有 AutoUpdate/; `issuecdn.baidupcs.com/issue/netdisk/pc-guanjia-plugin-update/BrowserEngine/BrowserEngine_1.cab` = 插件(浏览器引擎)热更 CAB 链
- netbase.dll/kernel_btsdk.dll 落盘时间戳 = 今日(10-29 18:06-18:07), 即当日热更替换实证; 服务器侧: `update.pan.baidu.com(/statistics)`
- netbase.dll 内 `components/download/...`、`download_service`(Cronet 组件名, 非百度端点); bdpan `update_check.json`
- YunDls 字符串 `BAIDU_NETDISK_BROWSERENGINE_SDK`、`BaiduNetdiskUnite.exe`、`BaiduNetdiskModuleList.db` → 模块级热更清单库

## 7. 下一步建议（交接动态腿）

1. netbase.dll 的 Cronet pinning 是否启用 → 抓 `Cronet_PublicKeyPins_AddPins`/`enable_public_key_pinning` 调用点(Ghidra xrefs)
2. HTTPDNS sign 算法(180.76.76.200, account_id=171195): 定位 `sign=%s` 格式串 xref → 摘要算法(通常 md5(dn+key+t))
3. bdpan.exe `mcpserver` 与 `secret.AppID` 符号展开(Go 符号表全在, 可直接 `go symbol` 还原函数名)
4. kernel_btsdk OpenSSL 1.1.0(2016) = 降级/已知CVE面, P2P 链路可作为绕 TLS 校验观察窗
5. YunDls MFC 归档里的 BDUSS/Stoken 落盘文件定位(`bsBDUSSW` 魔数全盘搜)
