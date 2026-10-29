# 百度网盘客户端 8.2.5 静态防护·热更新·IPC·凭据形态报告

战役：百度网盘客户端逆向 / 腿：防护与IPC
日期：2026-10-29 | 客户端根：`C:\Users\91216\AppData\Roaming\baidu\BaiduNetdisk\`（8.2.5，运行中，已登录）
方法：pefile 节熵/节表/导入导出 + 字符串扫描（脚本 `analysis\scripts\`，产物 `analysis\*.json`）。全部只读，未执行任何目标代码。

---

## A. 反逆向识别（壳判定表）

| 二进制 | 大小 | 位数/构建 | 关键节(名/熵) | 最大熵 | 壳判定 |
|---|---|---|---|---|---|
| **Bull140U.dll** | 3.34MB | x86 / 2025-09-17 | `.text` 6.59 / `.rdata` 6.28 / **`.vmp0` 611KB 熵 7.007** | 7.007 | **VMProtect（部分保护）** |
| **BaiduNetdisk.exe** | 8.3MB | x86 / 2026-02-06 | **`.vmp0` 1.5MB 熵 7.739** / `.rsrc` 7.34(压缩皮肤,正常) | 7.739 | **VMProtect（主EXE加壳）** |
| kernel.dll | 45.1MB | x86 / 2026-09-22 | `.text` 6.46 / `.rdata` 5.49 / `.rsrc` 22.8MB 6.95(嵌入资源) | 6.945 | **无壳** |
| kernel_btsdk.dll | 4.4MB | x86 / 2024-12-25 | `.text` 6.63 / `.reloc` 6.65 | 6.647 | **无壳** |
| netbase.dll | 12.5MB | x86 / 2025-12-07 | `.text` 6.69 / **`.rdata` 7.351** / `malloc_h` / `prot` | 7.351 | **无壳（熵阈值误报）** |
| kernel_o.dll | 43.9MB | x86 / 2026-04-28 | 同 kernel.dll 形态 | 6.942 | 无壳（旧 kernel 备份） |
| kernelUpdate.exe | 6.7MB | x86 / 2026-08-28 | 标准MSVC | 6.601 | 无壳 |
| updateagent.dll | 3.9MB | x86 / 2025-08-11 | 标准MSVC | 6.296 | 无壳 |
| YunDb / minosagent / Basement.dll | 1.6/5.5/2.4MB | x86 | 标准MSVC | <6.7 | 无壳 |

**Bull140U.dll 身份**：不是壳本身——是**百度自研 "BULL" C++ 基础框架库**（通用数据/缓冲/数组/XML 封装，505 个可读导出：`CGeneralArrayWrapper@BULL`、`CXMLFSWrapper@BULL` 等），被主程序/YunDb/Basement 依赖，导入 minosagent.dll（百度日志代理）。其自身**部分代码经 VMProtect 保护**（`.vmp0` 节 + `.vmp` 字符串）。排除 Themida/Enigma/ASPack/UPX（无对应节名与导入特征）；kernel.dll/netbase.dll 中的 "Enigma"/"MPRESS" 字符串为 40MB+ 体积内的偶发子串，判定误报。

**netbase.dll 熵误报说明**：276 个导出全为 `Cronet_*`（Chromium 网络栈，curl 生态），`.rdata` 7.351 来自 Chromium 压缩数据表；导出表完整可读、节名标准、导入 ntdll/dbghelp/ncrypt → 非壳。**kernel.dll = P2SP 下载引擎**（18 导出：`create_p2sp_task`/`control_task`/`yunp2p_init`/`load_btsdk`/`add_rapid_upload_file`/`GetHandleVerifier`→Chromium 血统）。kernel_btsdk.dll = BitTorrent SDK（18 个 `btsdk_*`）。

**反调试盘点**：
- 弱信号（静态 CRT 常见，全部二进制均有）：`IsDebuggerPresent`/`GetTickCount`/`QueryPerformanceCounter`/`RaiseException` 导入。
- 强信号：**BaiduNetdisk.exe** 含 `NtQueryInformationProcess`/`NtQuerySystemInformation`/`NtQueryObject`/`NtClose` 字符串（反调试/反句柄嗅探）；**kernel.dll / kernel_o.dll** 含 `NtQueryInformationProcess`/`NtQuerySystemInformation` 字符串（未入导入表，运行时动态解析概率高）。
- 未见 TLS 回调反调试、未见 CheckRemoteDebuggerPresent 导入。

---

## B. 热更新链路

**链路图：触发 → 检查 → 下载 → 校验 → 替换**

```
BaiduNetdisk.exe (主程序, 导入 updateagent.dll)
 └─ updateagent.dll  update_agent_* API ── 触发检查
     ├─ 版本检查:  http://update.pan.baidu.com/autoupdate      (kernelUpdate.exe 内嵌端点)
     │             https://pan.baidu.com/api/getsyscfg?         (系统配置)
     │             https://update.pan.baidu.com/statistics      (上报)
     │             HTTPDNS: http://%h%/v4/resolve?account_id=171195&tag=&sign=&t=
     ├─ 下载 CDN:  https://pkg-ant.baidu.com/issue/netdisk/p2p-pc/kernel/kernel.3020242.gz
     │             https://wppkg.baidupcs.com/issue/netdisk/p2p-pc/kernelUpdate/KernelUpdate.30205.gz
     │             (另: panup.pcs.baidu.com / sdata.baidupcs.com)
     ├─ 校验(双重):
     │   ① 文件级 MD5 元数据比对 + 差分补丁 —— updateagent.dll 字符串实证:
     │      "MoveFileCommand pre_condition file[%s] md5[%s] diff from md5[%s] in file meta"
     │      "PatchFile [%s]+[%s]->[%s], MD5:%s"
     │   ② Authenticode —— kernelUpdate.exe 导入 WINTRUST.dll + WinVerifyTrust 串实证
     └─ 替换: kernelUpdate.exe 落地替换 kernel 系 DLL
         实证时间线(今日): 18:06:06 kernel_btsdk.dll → 18:06:09 kernel.dll(+kernelupdate.json) → 18:07:21 netbase.dll
         旧 kernel 保留为 kernel_o.dll; 主程序整包更新走 AutoUpdate\Download\MainApp\upgrade_7500131_7510132.cab (7.50.13.1→7.51.13.2)
```

**清单文件** `AutoUpdate\kernelupdate.json`（明文 JSON，390B，随更新刷新）：
`KUInfo`=kernel.dll 版本 3.0.20.242 + md5 + gz 地址；`kueinfo`=kernelUpdate.exe 3.0.20.5 + md5 + 地址；`version`=3.0.20.242。
**MD5 语义实证**：现役 kernel.dll 内嵌版本串=3.0.20.242 与清单一致，但 on-disk MD5(998eca6f…) ≠ 清单 MD5(22270e1d…) → **清单 MD5 校验的是 .gz 传输载荷**（下载完整性门），非解压后 DLL；解压后走 updateagent 的 file-meta MD5 + WinVerifyTrust。

**VersionInfo / VersionInfo2**（各192B）：加密二进制（非明文版本文件），与个人配置同套自定义加密。AutoUpdate\config.ini 为空占位。

---

## C. 进程间通信（IPC）

**TCP 本地监听（netstat -ano -p tcp × 9个百度系进程）**：
| 监听 | 进程 | 说明 |
|---|---|---|
| **127.0.0.1:10000** | YunDetectService.exe (PID 21152) | 唯一本地监听口（云检测服务） |

主进程 BaiduNetdisk.exe(39168) 与 BrowserEngine 全部 6 个子进程（baidunetdiskhost×2 + BaiduNetdiskUnite×4）**零 TCP 监听** → 客户端 IPC 不走本地 TCP。

**命名管道**（`\\.\pipe\` 枚举 + 二进制内字符串双重印证）：
| 管道 | 归属 | 协议形态 |
|---|---|---|
| `baidunetdisk.baidunetdisk.39168.0.117249880`（活管道） | 主进程(39168)；宿主代码在 BaiduNetdiskHost.exe（`\\.\pipe\baidunetdisk.` 前缀拼接） | 自定义二进制消息（U16 错误串 "outgoing message, pipe error: %d" / "readfile, pipe error: %d" → 长度前缀帧 + ReadFile/WriteFile） |
| `\\.\pipe\edge_compute_process` | KernelCom.dll（另含 `BaiduNetdiskDownloader.exe` 辅助进程名） | 待运行期抓取 |
| `\\.\pipe\mojo.%lu.%lu.%I64u`、`crashpad_%lu_`、`chrome.sync.*` | BrowserEngine（baidunetdiskhost.exe / BaiduNetdiskUnite.exe，Chromium 内核） | Chromium mojo IPC |
| `3374bd49…` / `bd9cb6f7…`（32hex） | 未能归属（疑 crashpad/mojo 随机名） | — |

**模块目录清单与协议形态**：
- `module\KernelCom\`：仅 KernelCom.dll（2.3MB）。形态 = **HTTP/JSON REST**（静态链 curl + OpenSSL 1.0.2r/2019）：`https://pan.baidu.com/rest/2.0/bifrost?ver=1`、`/rest/2.0/bifrost/agent?method=conf&sign_version=2`（bifrost=百度客户端桥接配置服务）。含 BDUSS/STOKEN/Cookie 字符串引用（cookie 引擎在 curl）。非 protobuf。
- `module\BrowserEngine\`：完整浏览器进程树。`resources\app.asar + core.asar` + `module\asar\`（Electron 式资源包）；BaiduNetdiskUnite.exe 内嵌 **Node.js（undici fetch 源码串实证）+ Chromium mojo** → 混合内核；`users\99af0537…\` 下全是 SQLite 缓存库（filecache/upload/transmission 等，3GB 级）。
- kernelUpdate.exe / kernel.dll：protobuf×240（下载引擎遥测用）。
- 其余 module\：AiEngine(onnxruntime+DirectML)、ImageViewer(Qt)、SpeechSDK(libcurl+openssl)、VastPlayer( DirectX)。

---

## D. 本地凭据形态（只记位置/格式/字段名，值零记录）

**users\a4aa449c024a858ffbe49cc71af639ec\ 清单**：BaiduYunCacheFileV0.db(924MB,SQLite)、BaiduYunGuanjia.db(3.9MB,SQLite)、BaiduYunMBoxV0.db、BaiduYunPt2Pt.db、cloudpic.db(65MB)、picvector.db、btConfig\dht.dat —— **全部为缓存/任务库，无凭据表**（Guanjia 表结构实证：upload_file/download_file/backup_file/version，0 行）。

**凭据地图**（全部候选存储均加密；「值」列=明文值发现情况）：
| 文件 | 大小 | 格式判定 | 字段命中 | 值 |
|---|---|---|---|---|
| users\localdata.dat | 4.0KB | 自定义加密容器，头 `07 53 69 AE A1 DD 79 DB` | 无明文字段 | 无明文值 |
| users\176794861914179577F4.dat | 3.6KB | 同头同格式（疑似登录态首选位） | 无明文字段 | 无明文值 |
| users\BaiduNetdiskData.dat | 3.3KB | 加密（头 `1f c0 6b a2`） | 无 | 无 |
| users\BaiduNetdiskAppData.dat | 1.1KB | 加密（头 `f9 ee 29 a2`） | 无 | 无 |
| users\temp2.data | 3.7KB | UTF-16 Base64 密文 | 无 | 无 |
| AppSettingApp.dat（根） | 80KB | UTF-16 混淆文本 | 无 | 无 |
| BrowserEngine…\PersonalSetting.xml | 241KB | 加密（伪 xml，尾带 Base64+MD5 签名块） | 无 | 无 |
| BrowserEngine…\XepConfig.dat | 3.5KB | 加密（头 `rRqITJSb`） | 无 | 无 |
| BrowserEngine…\BaiduNetdiskModuleList.db | — | 伪 SQLite（实为加密） | 无 | 无 |
| BDUSS / STOKEN / Cookie 字符串 | — | 仅存在于 **KernelCom.dll 与 kernelUpdate.exe 代码内**（curl cookie 引擎 + 登录处理），不在任何落盘明文 | 字段名级 | — |

（掩码规则：本次扫描未发现任何明文凭据值，故无值可掩——所有命中均为代码内字段名引用。）

**判定——CLI 复刻取凭据最小代价路径**：
1. **本地解密 = 高难度**。所有登录态/配置存储均为 BULL 容器自定义加密（多种头部并存，密钥在 Bull140U/KernelCom 代码内，疑似机器绑定）；SQLite 系无凭据。
2. **最小代价路径 = 浏览器登录收割**：浏览器登录 pan.baidu.com 后收 `BDUSS`/`STOKEN` cookie（或走 passport 扫码登录 API 换取），配合 KernelCom 同款 bifrost REST 端点（`pan.baidu.com/rest/2.0/bifrost?ver=1`）+ kernel.dll P2SP 引擎参数形态。结论：**本地拿不到可用凭据，须登录收割腿供据**。

---

## 附：证据产物
- `analysis\pe_scan.json` — 11 个 PE 的节表/熵/导入/导出/反调试全量
- `analysis\str_scan_update.json` — KernelCom/updateagent/kernelUpdate 端点与校验串
- `analysis\cred_scan_users.json` / `cred_scan_settings.json` — 凭据字段扫描（全 name-only）
- `analysis\db_probe.json` — SQLite 表结构实证
- `analysis\tmp\` — 只读探查用的 DB 副本（Guanjia/Device，未删）
- 脚本：`analysis\scripts\pe_scan.py` / `str_scan.py` / `pipe_probe.py` / `db_probe.py` / `ver_probe.py`
