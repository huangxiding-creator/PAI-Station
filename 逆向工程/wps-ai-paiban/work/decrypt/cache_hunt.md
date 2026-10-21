# WPS AI排版(kwpsaitypeset) 解密模板磁盘猎取 — cache_hunt

- 日期: 2026-10-21 | 方式: 只读扫描(py -3 stdlib + rg)，未执行任何WPS二进制，未删除任何文件
- 范围: C:\Users\91216\AppData\Local\Kingsoft 全域 + C:\Users\91216\AppData\Roaming\kingsoft 全域
- 扫描量: 遍历文件 139055，探魔数(头8字节) 32904，读取错误 0

## verdict: dead-end（对目标 kwpsaitypeset 加密模板；另收获一族明文在线模板缓存，见 D 节）

## A. 标记 225f8didjBaA 散布位置（rg -l -a，共 44 处，全部在 kwpsaitypeset 插件树内）

| # | 路径 | 大小 | 头8字节(hex) | 格式 |
|---|------|------|--------------|------|
| 1 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\publictemplates\desc_base_template | 99136 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 2 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\thesis\standard\nationalstandard | 39084 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 3 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\official | 35008 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 4 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\general | 39488 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 5 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\contract | 52376 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 6 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 7 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\thesis | 36184 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 8 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\official | 35224 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 9 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\general | 37272 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 10 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\contract | 52376 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 11 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 12 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\publictemplates\desc_base_template | 99136 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 13 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\thesis\standard\nationalstandard | 39084 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 14 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\official | 35008 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 15 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\general | 39488 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 16 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\contract | 52376 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 17 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\presettemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 18 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\thesis | 36184 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 19 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\official | 35224 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 20 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\general | 37272 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 21 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\contract | 52376 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 22 | C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28505\office6\addons\kwpsaitypeset\mui\zh_CN\customtemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 23 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\publictemplates\desc_base_template | 99136 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 24 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\presettemplates\thesis\standard\nationalstandard | 39084 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 25 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\presettemplates\official | 35008 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 26 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\presettemplates\general | 39488 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 27 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\presettemplates\contract | 45760 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 28 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\presettemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 29 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\customtemplates\thesis | 36184 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 30 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\customtemplates\official | 35224 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 31 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\customtemplates\general | 37272 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 32 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\customtemplates\contract | 52376 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 33 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12509\mui\zh_CN\customtemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 34 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\publictemplates\desc_base_template | 99136 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 35 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\presettemplates\thesis\standard\nationalstandard | 39084 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 36 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\presettemplates\official | 35008 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 37 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\presettemplates\general | 39488 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 38 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\presettemplates\contract | 45760 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 39 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\presettemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 40 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\customtemplates\thesis | 36184 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 41 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\customtemplates\official | 35224 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 42 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\customtemplates\general | 37272 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 43 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\customtemplates\contract | 52376 | 3232356638646964 | 自定义加密容器(ASCII头) |
| 44 | C:\Users\91216\AppData\Roaming\kingsoft\wps\addons\pool\win-i386\kwpsaitypeset_3.1.0.12275\mui\zh_CN\customtemplates\bid | 55980 | 3232356638646964 | 自定义加密容器(ASCII头) |

44 个容器头8字节全部 = 3232356638646964（ASCII "225f8did"）。同一容器按版本散布 4 处：
Local Kingsoft WPS Office 12.1.0.28802 与 12.1.0.28505 的 office6\addons\kwpsaitypeset，以及 Roaming wps\addons\pool\win-i386 下 kwpsaitypeset_3.1.0.12509 与 3.1.0.12275。

## B. 容器内部探测：无任何明文残段

对全部 44 个容器整文件搜索 PK\x03\x04、D0CF11E0、EOCD(PK\x05\x06)、[Content_Types]：全部 -1（不存在于任何偏移）。
容器体为 base64 字符集 ASCII（含 + /），示例头 96 字节：
`225f8didjBaAxnQox7Y55v5H69kqm5yjL3GEUpIcJASGX0U91C7+Axo2/28RqU6HNB/QBddyuMMqmCXOFWyuJbZcj5abDh6v`
=> 前 11 字符疑似 magic/盐，其后为整体加密(疑 AES)再 base64 的负载，无嵌入 zip/OLE，磁盘侧无法零成本剥离。

## C. 解密副本扫描（PK/OLE 魔数）

- aitypeset 相关目录树下命中：**0**（kwpsaitypeset/kwpsaitypesetassisant/kdocer* 全树无任何 PK 或 OLE 文件；44 个模板文件本身即上述加密容器）
- 全域魔数命中 232 个，构成：
  1. 安装自带明文模板（office6\mui\zh_CN\templates 下 newfile.*/Normal.dotm/presentationdesigns/*.potx/coverpage、kwpsstyleset wpspreset0*.dotx、knewdocs blanktemplate、watermark *.doc、utility\diffbase *_bk）— 明文属正常，非 AI 排版模板
  2. office6\backup 下 8 个 *.wps（PK 魔数）— 用户文档自动备份，非模板
  3. **明文在线模板缓存（见 D）**
  4. 杂项：docerFonts ~{20016995}_1773025876224.kdtmp(PK,字体包)、kdocercommon webres download.zip(PK)、personalofflinecache 222324059.wpscache(OLE,3584B)
- 19-20 位纯数字文件名：**0 个**。实际 id 命名方案：konlinecover=8位数字目录、wpschangetemplate=32位hex文件名、时间戳=13位epoch后缀(.docx_1752190983683/.kdtmp)、wpscache=9位数字

## D. 明文在线模板缓存（docer 在线库，非 kwpsaitypeset 预置集，但证实"WPS 下载模板落盘为明文"）

根: C:\Users\91216\AppData\Roaming\kingsoft\office6\templates\download（27 个 8 位 id 目录，33 个明文 docx）

| id | 文件 | 大小 |
|----|------|------|
| 20051430 | 宣传画册8.docx | 299655 |
| 20107023 | 法律合同23.doc | 245248 |
| 20209494 | 薄荷绿晶莹质感企业年终总结.doc | 1213570 |
| 20228165 | 蓝色粒子公司年终总结.doc | 497394 |
| 20336589 | 科技研发白皮书1.docx | 86321 |
| 20336589 | 科技研发白皮书1.docx_1747020760960.kdtmp | 0 |
| 20336589 | 科技研发白皮书1.docx_1747020777292.kdtmp | 0 |
| 20336589 | 科技研发白皮书1.docx_1747020783330.kdtmp | 0 |
| 20336590 | 大数据科研白皮书.docx | 96878 |
| 20336590 | 大数据科研白皮书.docx_1746519567936 | 96878 |
| 20358288 | 学习总结汇报2.docx | 227641 |
| 20358289 | 学习总结汇报1.docx | 238614 |
| 20559095 | 简约灰色投标书.docx_1747020781513.kdtmp | 0 |
| 20559207 | 黑绿简约商务风教育宣传封面.docx | 2215078 |
| 20559222 | 黄色简约商务个人作品封面.docx | 2172705 |
| 20559222 | 黄色简约商务个人作品封面.docx_1752190352533.kdtmp | 81294 |
| 20559222 | 黄色简约商务个人作品封面.docx_1752190354913.kdtmp | 0 |
| 20559222 | 黄色简约商务个人作品封面.docx_1752190360194.kdtmp | 0 |
| 20559222 | 黄色简约商务个人作品封面.docx_1752190361394.kdtmp | 0 |
| 20559222 | 黄色简约商务个人作品封面.docx_1752190362976.kdtmp | 0 |
| 20559222 | 黄色简约商务个人作品封面.docx_1752190983683 | 2172705 |
| 20559233 | 简约科技风工作汇报封面.docx | 2225794 |
| 20559355 | 深色简约商务风投标书封面.docx_1752190316171 | 2160649 |
| 20559435 | 深蓝色商务封面.docx.docx | 6864557 |
| 20559454 | 棕色极简封面.docx.docx | 2776943 |
| 20559458 | 绿色极简封面.docx.docx | 2834783 |
| 20559459 | 绿色线条极简封面.docx.docx | 2923458 |
| 20559460 | 蓝色线条封面.docx.docx | 2826177 |
| 20559462 | 蓝色边框极简封面.docx.docx | 3338047 |
| 20559463 | 简约灯泡封面.docx.docx | 57425 |
| 20559466 | 中国风水墨山水封面.docx.docx | 859203 |
| 20559468 | 淡雅群山封面.docx.docx | 1683724 |
| 20559473 | 蓝色商务封面.docx.docx | 1843388 |

同族: wpschangetemplate\wpschangetemplate\{10093,8785fe2b...}.dotx（PK 明文）。
这些是稻壳(docer)在线模板下载缓存——AI 排版(kwpsaitypeset)的 presettemplates/customtemplates(论文/公文/合同/标书) 不在其中。

## E. kwpsaitypeset 相关目录（含 docer 系，共 86 个）

- 插件本体: ...office6\addons\kwpsaitypeset、kwpsaitypesetassisant（Local 28802/28505 两版本）+ Roaming wps\addons\pool\win-i386\kwpsaitypeset_{3.1.0.12509,3.1.0.12275}、kwpsaitypesetassisant_{3.1.0.10545,3.1.0.11876}
- AI 技能入口: ...addons\kcoworkdockpanel\service\skills\wps-doc-aitypeset、wps-select-docer-template（28802 版）
- docer 资源系: kdocercore/kdocerpage/kdocerresource/kdocerresumeassist 等及 templates\download、previewHover 下的缓存目录（完整清单见 cache_hunt.json: aitypeset_related_dirs）

## F. 已复制样本（out3\，只增不删，均为明文 OOXML，zipfile 验证含 word/document.xml）

- E:/AI-Station/逆向工程/wps-ai-paiban/work/decrypt/out3\konlinecover_20051430_exemplar.docx (299655 bytes) — konlinecover/wpschangetemplate 在线模板明文缓存样本
- E:/AI-Station/逆向工程/wps-ai-paiban/work/decrypt/out3\wpschangetemplate_10093_54375ff7.dotx (176223 bytes) — konlinecover/wpschangetemplate 在线模板明文缓存样本
- E:/AI-Station/逆向工程/wps-ai-paiban/work/decrypt/out3\konlinecover_20559222_epochrename_1752190983683 (2172705 bytes) — konlinecover/wpschangetemplate 在线模板明文缓存样本

## G. 结论与下一步

1. kwpsaitypeset 模板磁盘侧无解密缓存：加密容器仅存于插件树（44 份=11 模板 x 4 版本散布），运行时解密只发生在内存，落盘无痕。
2. 容器无嵌入 zip/OLE，剥离必须走解密（对 11 字符前缀后的 base64 体做算法分析/密钥提取）。
3. 可行替代路线: a) 运行时内存转储(WPS 进程加载模板后抓 wps 内存中 PK 流); b) 抓包 docer 模板下载接口(在线模板明文落盘行为已由 konlinecover 证实); c) 审计 kcoworkdockpanel\service\skills 下 wps-doc-aitypeset 技能 JS(纯文本，可能含模板应用链路); d) 对容器体做密钥嗅探: rg 已知 "225f8didjBaA" 前缀与 base64 体做熵/分段分析。
4. 数据文件: cache_hunt.json(全量232命中+86目录+44容器)、container_probe.json(容器逐字节探测)、marker_paths.txt(rg原始输出)、report_data.json。
