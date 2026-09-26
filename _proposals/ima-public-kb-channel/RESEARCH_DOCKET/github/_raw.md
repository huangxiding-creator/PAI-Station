# GitHub 调研 — ima 生态 35 个真实相关项目 (2026-09-26)

查询族: ima 知识库 / ima.copilot / ima.qq.com / ima export 知识库 / 腾讯 ima 笔记 /
ima knowledge base export / ima backup tencent (+阵亡侦察兵 14 查询 207 原始条目,
去噪后 54, 其中真实 ima 生态 35)。零命中死胡同: 无 (各查询均有命中, 英文面
"ima knowledge base export" 命中多为 image 噪声)。

## A. 下载/导出簇 (渠道直接对标, 6 个)
| 仓库 | ★ | 定位 | 可复用点 |
|---|---|---|---|
| delphuy/ima-downloader | 39 | 分享链接→递归下载全库 GUI 工具 | **匿名端点 `POST /cgi-bin/knowledge_share_get/get_share_info` {share_id,limit,cursor,folder_id}** (无需登录); 分类并行+类内串行; 增量=扫目录跳过已存; jump_url→extract_download_url |
| y869177843/ima-kb-downloader | 2 | Claude Skill 形态 KB 下载器 | **web token 通道逆向文档**: x-ima-cookie→IMA-UID/IMA-TOKEN/REFRESH-TOKEN; `auth_login/refresh`; `knowledge_tab_reader/get_knowledge_base_home_page`(limit50+cursor)+`get_knowledge`→**jump_url 服务端签名直链(q-sign-algorithm=sha1&q-ak…, ~4h 有效)**; 首页列表项 jump_url 为空须逐条 get_knowledge; **必须关代理直连**; wechatarticle_ 前缀 jump_url=HTML正文; 笔记/链接=chrome:// 非http协议存 .link.txt; COS get_upload_credential 对已有文件下载 403 勿用 |
| duanyanyan123/IMA- (codebuddy plugin) | 0 | 一键导出全库+断点续传 | 实测注记: OpenAPI 静态密钥直连曾被拒 errcode 200002 (skill auth failed) — 须走 MCP 通道; fetch_media_content 只回文本提取不给原文件 |
| van14shu/ima-download | 5 | ima 知识库下载 | 待深读 (仅 README) |
| hifengzy/ima-sync | 3 | IMA KB+笔记→Markdown | TS 实现 (manifest/versions) |
| tllovesxs/wandao | 1183 | 多平台 KB 导入导出 (含 ima) | ima 导入导出适配器 |

## B. MCP/CLI 服务簇 (8 个)
| 仓库 | ★ | 定位 | 可复用点 |
|---|---|---|---|
| highkay/tencent-ima-copilot-mcp | 126 | ima copilot MCP | 生态最大 MCP |
| hdsz25/tencent_ima_mcp | 14 | cgi-bin 通道 MCP (F12 token) | 认证获取工艺 (IMA-UID/TOKEN/REFRESH 从 x-ima-cookie); 全文搜索/标签/网页提取端点族 |
| xuewolai/ima-mcp-server | 5 | 官方 API MCP | search/browse/read/add |
| duhanjun/ima-mcp | 4 | stdio+http 双模 MCP | 官方 API 封装 |
| wangjianghu/ima-note-mcp | 7 | 笔记 MCP | 读通道 |
| Aimer779/ima-note-cli | 13 | 笔记 CLI | search/browse/read/create |
| lesterppo/hermes-ima-cli | 0 | token-efficient CLI | agent-native 设计 |
| qqpp13465/ima-mcp-server | 4 | 自建智能体外接 | - |

## C. 同步/导入簇 (9 个)
obsidian-ima.copilot-sync(12) / obsidian-ima-plugin(5) / CmZhangxin/obsidian-ima-sync(5) /
peanuthull77/ima-importer(1, obsidian←ima) / ima-zotero-sync(10) / zotero-ima-sync(5) /
file-sync-monitor(10) / ZOORO-NEW/qianjin-ima-sync(2, 官方 OpenAPI 上传) /
wechat 系: gzh-to-ima-skill(13) / we2ima(6) / wechat-favorites-to-ima(3) / wechat-mp-collector(5)

## D. 应用/检索簇 (7 个)
legal-weekly-briefing(7, 法律库入库IMA做RAG) / etf-selector-web(3) / onclaw-dev/dsh-ima-copilot(1,
**点名官方公开库检索只有标题关键词**) / ABccgh/dsh-ima-kb(0, cross-KB) / kangxiaobai-kzj/ima-kb-assistant(1,
共享知识库场景) / hzblkm/ima-mcp-marketplace(2) / 132doris/ima.copilot-database(0)

## 关键结论
1. **≥20 达标**: 真实相关 35 个 (A6+B8+C12+D7+N个微信系)。
2. 三条独立通道被社区先后打通: 官方 OpenAPI / 匿名 share_id cgi / web-token cgi。
3. 无人把「搜索公开 KB 生态」做成渠道 (onclaw 点名官方只有标题检索——但我们实测
   search_knowledge_base 可搜到公开订阅库, 信息差在我们手里)。
4. 增量/断点/并发/文件类型分派 (wechatarticle HTML / chrome:// 链接 / COS 403 勿用)
   全有前人踩坑记录, 直接吸收。
