# 本地资产解剖 — ima-skill v1.1.10 官方 OpenAPI 面 (2026-09-26)

来源: C:/Users/91216/.claude/skills/ima-skill/ (用户级安装, 凭证双落位
IMA_OPENAPI_CLIENTID / IMA_OPENAPI_APIKEY, 密钥纪律: 只发 ima.qq.com)

## 端点全景 (knowledge-base 模块, POST https://ima.qq.com/openapi/wiki/v1/*)

| # | 端点 | 对本任务的含义 |
|---|---|---|
| 1 | create_media | 上传用, 渠道不需要 |
| 2 | add_knowledge | 写入用, 渠道不需要 |
| 3 | get_knowledge_base | **KB 元信息** (id→info) |
| 4 | get_knowledge_list | **浏览 KB 内容** (kb_id→条目列表) — 若对他人公开 KB 生效=渠道浏览腿 |
| 5 | search_knowledge | KB 内搜索 |
| 6 | **search_knowledge_base** | **知识库级搜索** (query/cursor/limit 1-20 → id/name/cover_url) — 官方「公开/共享 KB 检索」入口候选 |
| 7 | get_addable_knowledge_base_list | 本人可写列表, 渠道不需要 |
| 8 | check_file_name | 无关 |
| 9 | import_url | 写入用 |
| 10 | **get_media_info** | **原文访问** (media_id→url_info.url + headers) — 下载腿 (URL 型媒体直接给下载地址+鉴权头) |

## 关键数据结构
- SearchedKnowledgeBaseInfo: {id, name, cover_url} — 搜的是「库」不是「条目」
- URLInfo: {url, headers} — get_media_info 的返回 → 下载原文件
- SearchedKnowledgeInfo: {media_id, title, highlight_content} — KB 内搜索命中

## 判据级待实测 (渠道可行性的一锤定音项)
1. search_knowledge_base 搜「明显非本人建的库」(如 "EPC" "工程") 是否返回第三方公开 KB?
2. get_knowledge_list(第三方公开 kb_id) 是否返回条目列表? (公开语义=可读)
3. get_media_info(第三方公开条目 media_id) 是否返回可下载 url_info?
4. 限额/频控形态 (openapi 配额) — 渠道节流参数依据。

## 结论
官方 API 骨架完整覆盖「搜索公开 KB → 浏览条目 → 下载原文」三步;
差量全在「对他人公开 KB 是否生效」的实测 + 免 key 的匿名网页面 (web_scout 在查)。
