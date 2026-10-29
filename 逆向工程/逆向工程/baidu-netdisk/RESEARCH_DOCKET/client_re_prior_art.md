# 百度网盘 Windows 客户端逆向 — 公开先例与协议情报 (Prior Art Docket)

- 调研日期: 2026-10-29 | 研究员: Super-Skill Researcher
- 标的: 客户端 8.2.5 (%APPDATA%\baidu\BaiduNetdisk; CEF 架构 libcef.dll 113MB; kernel.dll 43MB 热更新; netbase.dll/kernel_btsdk.dll/YunDls.dll/logonbd.dll/minosagent.dll/Bull140U.dll; module/KernelCom|BrowserEngine|AiEngine; users/<hash>/ProxySetting.ini)
- 可信度标注: 【官方】/【多方印证】≥2独立来源/【孤证】单来源/【未证实】推断或摘要级
- 检索范围: WebSearch(中英)、GitHub(gh api 代码级)、吾爱破解、看雪、CSDN、博客园、greasyfork、alistgo 官方文档

## 0. 结论速览
1. 8.x 客户端内部件零公开先例: "KernelCom"/"netbase.dll"/"Bull140U"/"minosagent" 中英检索全部零命中(逐一确认)。kernel.dll 公开资料止步于 2016-2018「替换DLL满速」孤证。逆向 8.x 内部件属首开,无现成轮子。
2. 协议层公开资料丰富(网页端/开放平台线): BDUSS、xpan/pcs 端点、netdisk UA、sign 三件套算法、precreate 秒传、d.pcs 直链,全有可复用开源实现(Apache-2.0/MIT 居多)。
3. 风控是头号风险: UA 维度检测实锤(#84/#534)、黑名单码 31119/31329 官方承认、PanDownload 作者 2020 被抓(虎嗅)。
4. 抓包可行性: CEF 腿高(系统代理大概率直通); kernel 传输腿是否 cert pinning 无任何公开情报。

## 1. 客户端 8.x 架构公开分析(问题1)
| 事实 | 可信度 | 来源 | 日期 |
|---|---|---|---|
| 无 kernel.dll 热更新机制、KernelCom IPC(管道/端口/protobuf)公开分析 | 检索确认空窗 | 本档 Checkpoint 3/6: 三个专有名中英检索零命中 | 2026-10-29 |
| 2016-2018 存在「替换 kernel.dll 满速」手法,现失效 | 孤证 | https://zhidao.baidu.com/question/2056140764699087627.html | 不明 |
| 52pojie 有客户端 7.0.5.9「云存储服务客户端」改造帖(未读全文) | 孤证 | https://www.52pojie.cn/thread-1290331-1-1.html | 2019 |
| macOS 破解插件(8890★)证明 mac 版可注入;手法为 hook 请求伪造会员标识 | 多方印证 | https://github.com/CodeTips/BaiduNetdiskPlugin-macOS (MIT, push 2020-10, 已死) | 2020 |
| 客户端 P2P「用户激励计划」默认占用户 1MB/s 上行做 PCDN | 多方印证 | https://m.huxiu.com/article/352513.html | 2020-04 |
| 客户端 P2P 为私有加密协议,只交换文件块索引 | 孤证 | https://www.zhihu.com/question/267412872 | 2018 |
| 2024 后官方免费加速=客户端 设置→传输→「优化速率」 | 多方印证(52pojie共识) | https://www.52pojie.cn/thread-1900706-1-1.html 摘要 | 2024 |

结论: 问题1 无公开先例只能自采; CEF 壳层可借 Chromium 通用知识; kernel 层需 IDA 自行分析。

## 2. 协议层(问题2: 凭据/域名/端点/头/签名/TLS)
### 2.1 凭据形态
- 网页/第三方线凭据 = BDUSS cookie(+uid); BaiduPCS-Go 扫码/BDUSS 登录 2025-09 仍可用(IPv6 环境除外)。【多方印证】 https://github.com/qjfoidnh/BaiduPCS-Go
- 官方开放平台线 = OAuth2 access_token/refresh_token, scope=basic,netdisk, 授权码模式。【官方】 https://pan.baidu.com/union/ + https://alistgo.com/zh/guide/drivers/baidu.html
- AList 文档明文内置公开 client_id/secret(且换过一轮)。【官方(第三方文档)】同上
- PC 客户端 8.x 自身凭据形态(独立token? passport接口?) 【无公开情报,未证实】推测仍属 BDUSS/ST 家族(同域 cookie 体系),待 mitmproxy 实证。

### 2.2 域名与端点
| 端点 | 用途 | 可信度 | 来源/状态 |
|---|---|---|---|
| pan.baidu.com/rest/2.0/xpan/* (file?method=list; multiupload precreate/superfile2; user) | 现行文件管理/上传 | 官方 | pan.baidu.com/union/doc; 文件列表 slug 3kpg0s9r7、预上传 nksg0sat9【未证实:slug来自搜索摘要,站内JS渲染需直访】 |
| pcs.baidu.com/rest/2.0/pcs/{object} | 旧 PCS API | 官方(老) | BaiduPCS-Go docs/overview.md 仓库镜像; 2018-2021 时代,可能过时 |
| d.baidupcs.com / d.pcs.baidu.com | 下载直链/上传兜底域名 | 多方印证 | BaiduPCS-Go baidupcs.go + AList 文档(d.pcs 为动态上传兜底) |
| openapi.baidu.com/oauth/2.0/* | OAuth 换 token | 官方 | AList 文档; CSDN 122732070 |
| tieba.baidu.com | BDUSS 有效性探测(issue 报错佐证) | 孤证 | BaiduPCS-Go issues |

### 2.3 请求头/参数/签名
- PC UA 格式: netdisk;{版本};PC;PC-Windows;{WinVer};WindowsBaiduYunGuanJia; 公开样本止于 6.9.x。【多方印证】 cnblogs /p/7067966(2017,4.6.2) + 52pojie thread-1205609(2020,6.9.5.1) + wzfou.com(5.6.2)。7.x/8.x UA 无公开样本,需自抓。
- 现行有效安卓仿客户端 UA: netdisk;P2SP;3.0.0.8;netdisk;11.12.3;ANG-AN00;android-android;10.0;JSbridge4.4.0;jointBridge;1.1.0; 【源码实证】qjfoidnh/BaiduPCS-Go baidupcs/baidupcs.go NetdiskUA 常量
- UA 是风控维度: Chrome UA 被弹无 loginstate 登录页,netdisk UA 放行;百度周期性封旧 UA。【多方印证】BaiduPCS-Go transfer.go 注释(issue #534) + https://github.com/acgotaku/BaiduExporter/issues/84
- clienttype: web 路线=0, 转存路线=1(PCS 时代语义)。【源码实证】BaiduPCS-Go prepare.go/transfer.go
- bd-Log-Id 头: 【无公开情报】BaiduPCS-Go 无此头,中文圈未见分析,需抓包自采。
- sign2 算法 = RC4 型 KSA/PRGA 异或流, Sign2(sign3, sign1), sign3/sign1 取自分享页 HTML; 仓库带测试向量。【源码实证】baidupcs/netdisksign/sign2.go + internal/panhome/sign.go
- ShareSURLInfoSign = md5("{shareID}_sharesurlinfo!@#") 十六进制,盐公开。【源码实证】share_sign.go
- locatedownload 签名 = {Time,Rand,DevUID}, DevUID=大写md5(bduss)+"|0"。【源码实证】locatedownloadsign.go + devuid.go
- TLS cert pinning(PC 客户端): 【无公开情报】; 移动向通用绕过件: https://github.com/CYRUS-STUDIO/frida-ssl-pinning-bypass (不直接适用 Windows)

## 3. 上传/秒传协议(问题3)
- 上传三步: precreate(path/size/block_list) → superfile2 分片 PUT → create 合并; return_type=2 即秒传。【多方印证】官方 union 文档 + CSDN 116405218 + BaiduPCS-Go 源码
- 指纹三元组: 整文件MD5 + slice-md5(前256KB MD5) + size; 秒传链接格式 md5#slice-md5#size#filename。【多方印证】CSDN gitblog 系列(00702/00030, 2025-2026 口径一致) + 各 rapidupload 脚本
- block_list = 每 4MB 分片 MD5 的 JSON 数组。【多方印证】BaiduPCS-Go / pengw0048/BaiduOldDriver(2017,无许可证,端点可能过时)
- 单分片 30 秒必须传完; 上传并发 1-32; 自定义分片大小仅会员。【官方(经AList)】alistgo.com/zh/guide/drivers/baidu.html
- 动态上传域名缓存约1小时,兜底 d.pcs.baidu.com; 禁止空文件; uploadid 失效需重建会话。【官方(经AList)】同上
- 接口曾变更致秒传显示失败。【孤证】BaiduPCS-Go issue #292

## 4. 下载引擎(问题4)
- 客户端下载 = dlink(d.pcs/d.baidupcs)直链 + UA 校验 + 会员分级限速; AList 佐证: >20MB 文件必须带 UA,改 UA 仅对 SVIP 提速有效。【多方印证】BaiduPCS-Go + AList 文档
- AList Crack(非官方)下载接口已死: 文档原话「非官方接口已无法使用」;官方接口非会员慢。【官方(第三方文档)】alistgo.com/zh/guide/drivers/baidu.html
- P2P/PCDN: 用户激励计划默认占上行 1MB/s(2020曝光后收敛为「优化速率」选项); P2P 私有加密协议。【多方印证】虎嗅 352513 / 知乎 267412872 / 52pojie
- libtorrent: 【我方一手事实】安装目录存在 libtorrent_license.txt → 客户端捆绑 libtorrent-rasterbar(BSD-3-Clause/BSL-1.0)极可能用于 BT 离线下载/PCDN 数据面; 公开网络将 libtorrent 与百度网盘挂钩的先例=零(检索确认)。
- UA 中 P2SP 标识暗示 HTTP+P2P 混合源下载。【推断/孤证级】UA 字面

## 5. 反逆向情报(问题5)
- Bull140U.dll / minosagent.dll 公开网络零信息(无论坛/恶意库/论文)。【检索确认空窗】2026-10-29 英文检索零命中
- kernel.dll 热更新 → 静态补丁易被覆盖; 历史「替换kernel.dll」手法失效或与此有关。【我方一手事实+孤证】本地目录 + zhidao 2056140764699087627
- 风控错误码 31119/31329 = "hit black userlist, hit illeage dlna"(黑名单,官方承认是限制非bug)。【官方(经AList)】alistgo.com/zh/guide/drivers/baidu.html
- 风控触发面: 周期性封旧UA / 高并发下载(社区建议渐进并发) / 非客户端UA弹登录页。【多方印证】BaiduExporter #84 + CSDN gitblog_00345 + BaiduPCS-Go #534
- 法律先例: PanDownload 作者 2020 被捕; 亿寻/速盘等第三方不限速工具陆续死亡。【多方印证】虎嗅 352513 + 52pojie thread-1055417
- 壳/混淆具体形态: 【无公开情报】

## 6. 可复用工具清单(问题6, 按契合度)
| # | 项目 | 许可 | 星 | 活跃至 | 契合度 | 采纳模式 | 取什么 |
|---|---|---|---|---|---|---|---|
| 1 | qjfoidnh/BaiduPCS-Go | Apache-2.0 | 5851 | 2026-09 | 90% | 复用 | 端点常量、NetdiskUA、netdisksign 三件套(带测试向量)、并发/限速经验 |
| 2 | baidu-netdisk/bdpan-storage(官方 Skill) | Apache-2.0 | 310 | 2026-10 | 85% | 复用 | 官方授权上传/下载/转存/分享合法全流程,适配 Claude Code/Manus |
| 3 | baidu-netdisk/mcp(官方) | MIT | 154 | 2025-09 | 80% | 复用 | 官方 MCP 协议封装 |
| 4 | AList/OpenList 百度驱动 | AGPL-3.0 | 4万+级(AList本体) | 持续 | 75% | pattern only(AGPL禁闭源收纳) | 现行风控码表、动态上传域名、UA pan.baidu.com 要求、分片30s时限 |
| 5 | yuantuo666/baiduwp-php | MIT | 6335 | 2024-04 | 75% | 复用 | 分享链接→dlink 全链(网页API线); baiduErrno 错误码表 |
| 6 | XhstormR/BaiduNetdisk-WAP | GPL-3.0 | 236 | 2026-10 | 60% | pattern only | WAP 端点 2026 现状 |
| 7 | jsyzchen/pan | MIT | 99 | 2024-03 | 65% | 复用 | 官方开放平台 Go SDK |
| 8 | CodeTips/BaiduNetdiskPlugin-macOS | MIT | 8890 | 2020-10(死) | 40% | pattern only | mac 客户端注入点位思路 |
| 9 | pengw0048/BaiduOldDriver | 无许可 | 262 | 2017 | 20% | pattern only | 早期私有API形态(端点大概率死) |
| 10 | greasyfork 484953 下载助手 | 页内脚本 | - | 2024+ | 50% | pattern only | 网页端 bdstoken/client_id 授权流程 |
未发现: 8.x 客户端专属 Frida 脚本、HAR 抓包仓、kernel.dll 逆向笔记(全空窗)。通用件: CYRUS-STUDIO/frida-ssl-pinning-bypass(Android向)、mitmproxy/Charles。

## 7. 时效性(问题7)
| 资产 | 时代 | 判断 |
|---|---|---|
| pcs.baidu.com/rest/2.0/pcs/* | 2018-2021 | 可能过时,新代码走 xpan |
| netdisk;6.9.x PC UA 样本 | 2017-2022 | 版本陈旧+封旧UA史,需自抓 8.2.5 UA |
| BaiduOldDriver 端点 | 2017 | 大概率死 |
| AList Crack 下载接口 | ≤2024 | 官方文档自认已死 |
| xpan/开放平台/官方 Skill | 2024-2026 | 现行有效 |
| BaiduPCS-Go sign 系 | 维护至 2026-09 | 现行有效(有测试向量可回归) |
| 31119/31329 风控码 | 2024-2025 文档 | 现行有效 |

## 8. 需自采清单(公开情报空窗→逆向工作项)
1. 8.2.5 真实 UA / clienttype / bd-Log-Id / 凭据形态(mitmproxy 首抓)
2. KernelCom IPC 机制(命名管道?端口?) — 零先例
3. netbase.dll/kernel_btsdk.dll 是否 cert pinning — 零先例
4. Bull140U.dll 壳类型识别(PE分析) — 零先例
5. kernel.dll 热更新触发路径与签名校验 — 零先例
6. P2P 数据面协议 — 仅 2018 孤证「私有加密」

## 附A: Working Notes(检查点审计轨)
- Ck1: qjfoidnh 活跃 fork/Homebrew收录/UA可配置; CSDN 2026直链文(摘要); zhidao 替换kernel.dll孤证; kernel.dll 无公开深逆向
- Ck2: 官方 baidu-netdisk org 实锤(bdpan-storage+mcp); yuantuo666 家族; CodeTips mac插件; XhstormR WAP 活跃; 秒传机制多方印证
- Ck3: bdpan-storage README 全读(npx/OAuth/适配Claude Code); 52pojie 各不限速方案=模拟客户端拿直链; KernelCom/netbase/Bull140U 零命中
- Ck4: NetdiskUA 原文; #534 Chrome UA 被弹; netdisksign 包存在; 52pojie 1256000 死链(楼主被屏蔽); greasyfork 484953 OAuth 流程
- Ck5: sign2.go 全文(RC4型)+panhome 调用; share/locatedownload/devuid 三件套; PC UA 多方印证最高6.9.x; YouthMember=油猴脚本降权; xpan 文档 slug 线索
- Ck6: AList 文档全量事实(UA/风控码/分片时限/动态域名/内置client_id/Crack已死); clienttype 0/1; bd-Log-Id 无实现; libtorrent 与百度零公开挂钩(仅本地一手证据); Bull140U/minosagent 零命中

## 附B: 主要来源
https://github.com/qjfoidnh/BaiduPCS-Go | https://github.com/baidu-netdisk/bdpan-storage | https://github.com/baidu-netdisk/mcp | https://alistgo.com/zh/guide/drivers/baidu.html | https://github.com/yuantuo666/baiduwp-php | https://github.com/XhstormR/BaiduNetdisk-WAP | https://github.com/CodeTips/BaiduNetdiskPlugin-macOS | https://github.com/pengw0048/BaiduOldDriver | https://github.com/acgotaku/BaiduExporter/issues/84 | https://m.huxiu.com/article/352513.html | https://www.zhihu.com/question/267412872 | 52pojie: 985351/1122921/740378/1055417/1205609/1900706 | cnblogs yizhenfeng168/p/7067966 | greasyfork 484953 | CSDN 116405218/122732070/gitblog系列
