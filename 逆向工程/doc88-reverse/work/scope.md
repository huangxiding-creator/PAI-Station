# doc88-reverse 授权与边界（选品端点定名战役）

日期: 2026-10-24 | 战役: doc88 搜索选品面纯 HTTP 化（段1 search 端点未定 → 定名）

## 授权依据

- 用户 1024 全渠道 API 化令（任务书明引；kb_factory production_bridge 报
  NotImplementedError「doc88 段1 search 选品端点未定（首页 JS 动态无直链）」——
  本战役就是把这个端点定下来）。
- 既有 DOC88_SPEC（07 任务/自动建库Agent/engine/SPECS/DOC88_SPEC.md）§5 活探针
  只探了首页/info/ebt 资产，未探搜索面——§5 表第 1 行明示「选品需搜索页/API 另议」。
- 段2/3/4（info 配置发现/ebt 收割/SWF→PDF）已由 adapters/doc88.py T24/T27/T32/T36
  全量落地，本战役只补段1（选品）+ 免费文字层定性。

## 目标

1. 定下 doc88 搜索选品端点（免登录/公开面），拿到题录（标题/p_code/格式/页数/日期）；
2. 定性免费文字层：intropath（get_intro）可提取的摘要文字；
3. 复刻件 `replica/doc88_api.py`（纯 HTTP 零浏览器零CDP）；
4. 验收 = 5 次独立会话「国际工程 EPC」类查询各拿到题录 + 免费文字。

## 打法（已实证）

- 首页 45147B → `static.doc88.com/resources/js/search.js?v=2.50`（21343B，jQuery 直读，
  无混淆无 bundle 打包——**§5「首页 JS 动态无直链」的「另议」答案是：列表确实是 JS
  动态加载，但接口不是隐藏的，search.js 明文携带全部端点**）：
  - 主搜索: `GET /search/post.do?from=1&f=0&h=1&pageRange=0&pageNum=&format=&p={page}&q={kw}&sDate=&eDate=&ct=0` → HTML 片段（结果列表，jQuery `$("#result_content").html(msg)`）
  - 联想: `GET /search/suggest.do?q={kw}` → JSON `[{title}]`
  - 相关词: `GET /search/rk.do?q={kw}&ct=0` → JSON `{kwSb}`
  - **免费文字层**: `GET /doc.php?act=get_intro&p={intropath}` → 摘要正文 HTML
    （intropath 从结果条目属性取，如 `/2017/05/05/6562828517966.xml.gz`）；
  - tag 页跳转形态: `/tag/{kw}`（web）/`/ltag/`（client=3）/`/ctag/`/`/dtag/`。
- 首发实证（2026-10-24，3 发，零登录零 cookie）：
  - post.do「国际工程 EPC」p=1 → 200/17049B，题录 9 条（约 12,179,090 篇命中）；
  - suggest.do → 200/854B JSON 9 条联想；
  - get_intro → 200/726B 真摘要文字（EPC 项目管理正文段）。

## 边界（红线）

1. **不破付费墙**：只取免登录公开面（搜索题录 + intropath 摘要文字 + 既有 ebt 免费预览
   管线）；付费下载/VIP 文档不碰（p_download 判定/登录墙如实挂账，属段2/3 既有件）。
2. **只读**：全部 GET 查询；不写不传不改；不删任何本地文件。
3. **节流**：搜索腿间隔 ≥3s（对齐 wenku-search-reverse 战役口径）；intro 腿 ≥0.5s。
4. **零登录零 cookie**：全链免登录，不读任何 secret 文件；密钥不进仓。
5. **数字零造假**：贯通率/条数/字数/请求账全实测落账。
6. **无 push**：本地 commit 只加本目录 `逆向工程/doc88-reverse/`。
7. **不删文件**（1012/1015 铁律）：全程只增不删。

## 已知墙（预期管理）

- WAF「网络环境安全验证」（DOC88_SPEC §3）：JA3/行为指纹——本战役 curl 默认栈 +
  浏览器 UA + 首页 Referer 实测放行；命中则如实报墙不硬闯。
- intropath 少数条目缺省（无摘要件）→ 如实 None，不造假。
- 预览整本=图片型 SWF（既有段3 ebt 管线管），文字型免费面就是 get_intro 摘要层。
