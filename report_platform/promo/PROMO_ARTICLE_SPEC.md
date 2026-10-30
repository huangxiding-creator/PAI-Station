# PROMO_ARTICLE_SPEC — 研究报告公众号宣传文生成规格（任务书）

> 本文 = 每份报告 S5 宣传文（3 篇）的生成任务书口径。惯例部分按在役实证归纳（1025 三篇
> 手写 md + push_result.json 为基线）；**增补节**为 1027 用户令新规，对未来报告宣传文生成
> 任务逐条生效。

## 一、产出物（每份报告 3 篇）

- 每号一篇：总包之声 / 总包说 / 工程行业大脑，落 `report_platform/promo/<日期>_<号位代号>_<sku钩子>.md`
  （如 `2026-10-25_gchyd_overseas_qipan.md`；gchyd=工程行业大脑、zbshuo=总包说、zbzs=总包之声）
- 正文 ~2000 字以上（promo_guard 门⑤ ≥2000 字；We-AIPO 3000→2000 过审先例），
  数字一律对齐成书实况（总装实测字数/章数/页数/价格，数字零造假）
- 文末**二维码位**：`{{QRCODE}}` 占位（push_article.py 渲染时注入归因二维码）→ **1027 起改海报位，见增补节**

## 二、标题规范（promo-title-format-rule 铁律 + 实役惯例）

- 总包之声 launch 款：`发布| 《研究报告全名称》`
- 另两篇为内容钩子款（如 `电力EPC出海先选对国：一张三国棋盘的读法`），标题 ≤64 字节（guard 门⑦）
- digest 取 md 第 2 行（blockquote 导语行），非空（guard 门④）

## 三、推送链（在役件，不改）

`push_article.py --account <号> --sku <SKU>`：render_md_to_wechat_html（中式水墨主题）→
promo_guard 七门守门（标题去重/SKU 7天冷却/日帽2-2-1/digest/字数/HTML≤18000/查重）→
上传封面+归因二维码 → push_draft 入草稿箱 → promo_ledger.jsonl 过账 →
`<md名>_push_result.json` 落档。发表权统一归 autopub（单写者红线）。

## 四、增补节：文末海报位（2026-10-27 用户令）

**未来报告的宣传文生成任务书必含一条**：

> 文末二维码位 → 嵌 `<SKU>.png` 海报图，上传为公众号素材插入。

操作细则（拉取/质量/发布前换图/存量口径）以 **`promo/promo_poster_rule.md`** 为唯一权威：
1. S4 上架后 `poster_fetch.py --sku <SKU>` 拉海报（引擎端点 `/api/report/<SKU>/poster`）；
2. md 仍保留 `{{QRCODE}}` 占位推草稿箱（归因分桶不破）；
3. autopub 发布前在草稿箱编辑器换图：二维码 → 海报（居中约 70% 宽），海报内嵌小程序码直达报告详情页；
4. 生效范围：第 10 份起新报告全面生效；已发布文不回改（公众号平台图片不可替换）。
