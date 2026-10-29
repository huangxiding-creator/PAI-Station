# promo_poster_rule — 宣传文海报位规则（1027 用户令）

> **令源（2026-10-27 用户令）**：公众号研究报告宣传文中的二维码位，**替换为**报告上架
> 总包AI顾问小程序后的**研究报告宣传海报**。本文 = 该规则的唯一权威规格件，挂进发布链
> runbook（`_proposals/flagship-paid-report-1007/work/REPORT_PIPELINE.md` 固定发布协议 S5 项；
> `PIPELINE_E2E.md` 段5 同步挂钩）。

## 一、生效范围（存量处置口径，1027 定案）

| 对象 | 处置 |
|---|---|
| 第10份起所有新报告（3 篇/份） | **全面生效**：文末二维码位 → 嵌 `<SKU>.png` 海报图 |
| 第9份第三篇（工程行业大脑·草稿箱待发 acct07） | **即刻生效**：稿面已改嵌海报图说明，发布时上传海报素材替换二维码 |
| 第9份已发布两篇（总包之声 launch / 总包说 zichan） | **不回改**：公众号已发布文仅支持少量文字修改，**图片不可替换**（平台限制）；海报标准自第10份起全面生效 |

## 二、海报资产链（实测 2026-10-27）

**引擎端点**：`GET https://ai.epcschool.top/api/report/<SKU>/poster` → JSON `{b64: <PNG base64>}`
（小程序端 `utils/api.js#reportPoster(sku)` 同源在用——研报转化海报）。

**拉取件**：`promo/poster_fetch.py`

```
python -X utf8 promo/poster_fetch.py --sku <SKU>
# 落盘 promo/posters/<SKU>.png；实测打印 尺寸/字节/模式；台账追加 posters/poster_fetch_ledger.jsonl
# 重跑幂等：已有产物先转 .bak（只增不删纪律）
```

**双 SKU 实检账（1027 实测，数字零造假——全部为实测值）**：

| SKU | HTTP | 尺寸(px) | 模式 | 字节 | b64字符数 |
|---|---|---|---|---|---|
| OVERSEAS-2026 | 200 | 750x1798 | RGB | 268,128 | 357,504 |
| SCHED-2026 | 200 | 750x1876 | RGB | 272,728 | 363,640 |

**质量实检结论（视觉实测）**：两张均为引擎 Pillow 合成的**设计版海报卡**（非纯文字卡）——
品牌报头（总包AI顾问 / 日期 / SHT 01·RESEARCH）、深蓝主标题、字数/章数大字卖点、
章节目录区、收口 CTA 卡**内嵌真·微信小程序码**（微信绿角标、中心头像，扫码直达报告详情页）、
米黄底+橙色强调的杂志风边框。无截断/错位/乱码，竖版 750px 宽适合公众号正文图（width:70% 居中）。
**如实说明**：海报**无价格字段**（价格仍在正文文字里，如「全本定价¥698」）；SCHED-2026 目录区
列前12章+「完整目录在小程序内」收口（引擎侧生成口径）。

**小程序码现成生成件排查（如实报）**：`微信小程序/zongbao-ai` 下**无独立小程序码生成件**
（tools/force_qr.py 是 MP 控制台登录二维码探测件，非 wxacode 生成）。海报内嵌小程序码由
**引擎侧生成**（ai.epcschool.top，与小程序 answer 页分享海报同源），故本地无需另备生成件，
PIL 增强合成**不需要**（海报质量已达发布标准）。

## 三、S5 操作规程（未来每份报告，3 篇同规）

1. **S4 上架收官后**：`python -X utf8 promo/poster_fetch.py --sku <SKU>` 拉海报落
   `promo/posters/<SKU>.png`（引擎须已上云含该 SKU）。
2. **写稿**：宣传文 md 照常手写（惯例见 `PROMO_ARTICLE_SPEC.md`），文末保留 `{{QRCODE}}`
   占位（push_article 渲染/守门兼容）。
3. **推草稿箱**：`push_article.py --account <号> --sku <SKU>` 照常（归因二维码先行注入，
   保 promo_ledger 分号归因分桶不破）。
4. **发布前换图（本规则核心步）**：autopub 窗口前，在公众号草稿箱编辑器——
   ① 把 `promo/posters/<SKU>.png` 上传为素材；② 文末原二维码图及「长按识别 · 总包智库报告平台
   （试读免费）」说明行**替换**为海报图（居中，宽度约 70%）；③ 可保留一行小字
   「长按识别海报中小程序码 · 免费试读」。draft 编辑器支持换图（草稿态可编辑；已发布文不可，
   见第一节存量口径）。
5. **零造假**：海报为引擎产物，不本地改数；尺寸/字节以 poster_fetch 实测输出为准。

## 四、不改驱动（1027 用户令明示）

`huashu_film.py` / `push_article.py` 等驱动器**不改**；海报位经 md 任务书口径 +
本规则件 + 发布链 runbook 挂钩落地。若未来要自动化「推箱即嵌海报」，另立提案过批后再动代码。

## 五、挂钩位（runbook 追加账，1027）

- `_proposals/flagship-paid-report-1007/work/REPORT_PIPELINE.md` 固定发布协议 S5 项下追加海报位新规行
- `_proposals/flagship-paid-report-1007/work/PIPELINE_E2E.md` 段5 表追加「海报位」行
- 本目录 `PROMO_ARTICLE_SPEC.md` 增补节「文末海报位（1027 用户令）」

## 附：产物与台账

- 海报件：`promo/posters/<SKU>.png`（1027 已落 OVERSEAS-2026 / SCHED-2026 两张实检）
- 拉取台账：`promo/posters/poster_fetch_ledger.jsonl`（只追加）
