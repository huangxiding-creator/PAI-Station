# W3.5 百度文库检索 XHR 无登录试采 — capture 报告

日期: 2026-10-21 | 执行: ss-worker W3.5 | 铁律遵守: 无登录/不读secret.ini/仅检索GET-POST/不下载/间隔>=3s/总请求<=30/桌面Chrome UA/响应原样落盘

## 0. 结论(一句话)

**免登录元数据钥匙孔存在且已实测打通**: `POST https://wenku.baidu.com/gsula/sula/syncmrecall` (JSON body, sceneID=PCSearch) 返回结构化文档元数据列表, 无需任何 Cookie/登录态, 裸 urllib 直连 HTTP 200 + JSON。

## 1. 成功请求配方 (Layer 2 静态定位 + 裸HTTP重放)

- URL: `https://wenku.baidu.com/gsula/sula/syncmrecall`
- Method: POST
- Headers:
  - User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36
  - Content-Type: application/json;charset=utf-8
  - Accept: application/json, text/plain, */*
  - Referer: https://wenku.baidu.com/search?word=<urlencoded关键词>  (实测带不带Referer未单独消融, 建议保留)
  - Origin: https://wenku.baidu.com
- Body (通用文档道, 即 web 前端 XP 变体):
```json
{"requests":[{"sceneID":"PCSearch","params":{"word":"项目管理","pn":1,"noCacheMembershipCard":true}}]}
```
- Body 变体 (电子书道, h3 变体, fd=11): params 追加 `"fd":11,"fdResource":"11"` -> 返回 PCSearchBookWithCover 书卡(total 少)
- 可并列多 scene: `{"sceneID":"PCSearchRec","params":{"word":...,"pn":1}}` (本次未返回, 非必需)

## 2. 响应 JSON 结构

```
status.code=0 / status.msg=success / status.sLogid
data.items.PCSearch.result.items[]   # 文档卡数组(每页实测 12 条)
  .sceneID=.PCSearch  .component.id=PCSearchBookWithCover(书道)/通用doc卡
  .ctjParams.*   # 埋点参数(含 sulaQuery 回显)
  .data          # 文档元数据(见字段清单)
data.items.PCSearch.result.extra     # {total: 命中总数, word: 回显, isFilterWord, sampleId}
```

## 3. 元数据字段清单 (.data 内, 通用道实测 17 字段)

| 字段 | 含义 | 例 |
|---|---|---|
| docID | 文档唯一ID | aaae4fccf4ec4afe04a1b0717fd5360cba1a8dba |
| url | 详情页 | https://wenku.baidu.com/view/{docID}.html |
| title | 标题(含em高亮标记,需strip) | 项目管理名词解释 |
| content | 摘要/正文片段(含em标记) | 通过运用特定的知识、技能... |
| fileType | 格式码 | 4(通用文档道)/16(电子书道,带cover大图); 经典码表1=doc 2=pdf 3=ppt 4=xls 5=txt 7=epub(未逐一核验) |
| pageNum | 页数 | 5 / 20 / 32 |
| createTime | 发布时间戳 | 1699056278 |
| qualityScore | 质量分 | 3.7 |
| sellType | 售卖/权益标记 | 2 (语义未核验, 即商业化标记, 最近似vip字段) |
| downloadCount / viewCount | 下载/浏览数 | 0 / 180 |
| copyable / isShowDownloadBtn / authorVerify | 权限布尔 | true |
| tagList / authorInfo | 标签/作者(公开昵称) | dict |
| cover | 封面图URL | wkimg.bdimg.com/img/... |
| (无) | 文件字节数size | 无该字段, 如实记 |
| extra.total | 总命中数 | 117238 (项目管理) / 64773 (水利工程EPC) |

## 4. 各层尝试记录 (递进战术)

| 层 | 尝试 | 结果 |
|---|---|---|
| L1 裸HTTP页面 | GET /search?word=项目管理 (UA/带cookie/全浏览器头三次) | 均 HTTP 200 + 205~219KB Vue SPA 壳(pcUnionClient), pageData.wkQuery 恒空, 关键词在HTML中出现 0 次 => 纯客户端渲染, 页面HTML无结果数据; 无验证码 |
| L2 旧API | GET /gsearch/search/pc/search?query= | 200 但 GB2312 错误页「百度文库--您的访问出错了」=> 旧路死 |
| L2 静态猎杀 | 拉 index/view-home/HomeV2/searchbox/services/view-ai-union* 共8个 wkstatic CDN bundle | view-ai-union-43dd7041 内发现 /gsearch/search/{newallsearch,zscard,scenerecognition,genflowsearch} + 决定性证据: PCSearch 场景由 p()=POST /gsula/sula/syncmrecall 承载 (module 37069: y=XP变体/m=h3变体/f=newallsearch) |
| L2 重放 | POST syncmrecall (上述配方) | **200 + JSON, 免登录成功**; 通用道 12 条/页 + total; 书道(fd:11) 2 条书卡 |
| L3 无头浏览器 | REA+Edge headless 开 /search?word= | 文档请求即 HTTP 403 -> seccaptcha subid=pc_search_bfe 验证码墙(passport cap/init, BiocCaptcha), 搜索 XHR 从未发出 |
| L3 可见浏览器 | 同上 headless=false | 同样 403 + 验证码 => CDP 自动化特征被识别, 与 headless 无关 |

## 5. 限制与频控迹象

- 结果数: 每次调用返回 12 条(实测, 未找到 rn 参数控制); 翻页用 pn; total 只在 extra
- 免登录可行, 未用任何 Cookie(BAIDUID 亦未带); 无登录态依赖
- 频控迹象: 连续快速请求后 wenku.baidu.com 首页一度 403(约第7次请求时), syncmrecall 本身未见限制; 建议 >=3~4s 间隔
- 无头/CDP 浏览器会被 BFE 即时 403+验证码(subid=pc_search_bfe), 裸 urllib+桌面UA 反而放行
- sellType 语义(是否=VIP)与 fileType 码表未逐一核验; 无文件字节数字段

## 6. 文件清单

- capture.md (本文件)
- search_api.py (可复用最小检索函数, 已实测)
- sample_syncmrecall_pcsearch.json (书道 fd=11 原始响应)
- sample_pcsearch_xp_general.json (通用道 原始响应, 项目管理, 12条+total=117238)
- sample_pcsearch_keyword2.json (通用道, 水利工程EPC, 12条+total=64773)
- l1_search.html / l1_search_withjar.html / l1_search_fullhdr.html (SPA壳证据)
- l2_gsearch_pc.json (旧API错误页证据) / l2_*.js (8个bundle静态证据)
- l3_browser_capture.json / l3_browser_visible.json (两次浏览器403+验证码证据)

## 7. 请求账本

wenku.baidu.com 主域共 13 次(L1x3搜索+L2旧API+home/search x4+syncmrecall x3+search_api验证x2), CDN(wkstatic) 8 次, REA浏览器整页加载 2 次; 全程 <=30, 间隔>=3s。

## 8. 下一步建议

- W4 抓包腿可直接复用本配方(浏览器内 XHR 同为 syncmrecall, 无需逆向签名)
- 需要更多结果时研究 pn 翻页深度上限与 PCSearchRec 场景; sellType->VIP 语义核验留待登录态任务
