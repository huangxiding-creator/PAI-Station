# 内容产线批处理上架报告（T-P0-02 批处理循环 + T-P0-03 PDF 压缩腿 + T-P0-18 前半 catalog 口径）

- **执行日期**：2026-09-28
- **产线代码**：`WeAppForge/pipeline/batch_up.py`（批处理编排，母本 `content_pipeline.py` 零改动旁挂复用）+ `pipeline/pdf_compress.py`（压缩腿）+ `pipeline/batch_meta.py`（38+2 元数据表）
- **产物布局**：`projects/zongbao/content/reports/{slug}/chapters.json`（付费章空壳）+ `content/catalog.json` + `E:\AI-Station\data\xueyuan\pdfs\{slug}\{read,print,trial}.pdf`（ARCHITECTURE §六 ECS 静态区本地镜像）

---

## 一、清单与去重决策（40 → 38）

源目录 `E:\AI-Station\EngOpp-Mining\reports\` 排除 `~$` 临时后实数 **40 份** docx（与 COPYRIGHT_AUDIT.md 一致）。

### 1.1 双版本去重决策表（审计 §四-1 实锤对的处置）

| 省 | 落选（跳过） | 入选（保留） | 择优依据 |
|---|---|---|---|
| 江苏 | 江苏省水网工程商机研究_总包创研院_1788885508.docx | 江苏省水网工程商机研究_总包创研院_**1788892913**.docx（slug=js-shuiwang-2026） | 两版 19 章 / 658,423 字 / 7 图 MD5 **完全一致**（本任务实测 mammoth 全文比对复核），择时间戳更新版 |
| 西藏 | 西藏自治区水利工程商机研究_总包创研院_1786853555.docx | 西藏自治区水利工程商机研究_总包创研院_**1786853659**.docx（slug=xz-shuili-2026） | 两版 21 章 / 62,823 字 / 7 图 MD5 **完全一致**，择时间戳更新版 |

注：西藏 1786827950（17 章/60,738 字/0 图）与上对内容不同，**独立保留**；新疆 4 份时间戳版本章数/字数各异（15-19 章），均为独立商品，不做去重。

去重后上架清单 **38 份**（河南 14 / 湖北 15 / 新疆 4 / 江苏 1 / 浙江 1 / 甘肃 1 / 西藏 2，加总 38）。全量清单见 `data/xueyuan/manifest.json`。

### 1.2 40 份形态普查（mammoth 实测，决定切章器设计；数据源 data/xueyuan/scan_cache.json）

| 形态 | 份数 | 特征 | 切章策略 |
|---|---|---|---|
| h1/h2 章节型 | 14 | 省级商机研究报告（新疆×4/江苏×2/浙江/甘肃/西藏×3/湖北×2，8-21 章，13.7K-658K 字）+河南完整版（2 章） | 母本 h1→h2 切章+噪声过滤（试点语义零漂移） |
| **无标题单块型** | 26 | 城市局短报 23 份 + 汇总 3 份（原切章=1 章「全文」，2.1K-32K 字）；正文章节标题全部是 `<p><strong>一、…</strong></p>` 编号加粗段（50-153 段/份，无任何 h 标签） | **批处理新增 strong 编号段梯级**（`一、`/`（一）`/`1.`/`第X部分` 前缀；短小节归并前章零丢失；前导块并入首章；覆盖率<50% 回退单块） |

strong 梯级真实文件离线实测（不写产物）：荆门 18 章/覆盖率 100%/试读 14.7%；三门峡 13 章/100%/22.2%；henan_all 15 章/100%/22.6%；湖北省水利厅 9 章/100%/19.1%——四份全部内容零丢失，章标题即「第一部分 商机项目清单」「一、招标采购商机…」等产品级 TOC。

---

## 二、关键工程决策（实测驱动）

1. **试读章数自适应（trialChapterCount 记实际值，默认 2）**：固定 2 章对 658K 字的江苏报告试读占比仅 0.6%，必挂 15%-25% 验收带（REQUIREMENTS FR-P0-01/R-06）。批处理按「前 N 章字符占比落入 [15%,25%]、N 从 2 起、必须保留 ≥1 付费章」自适应选取；无解时取最贴近带者并在 --verify 中如实报越带。catalog 字段 `trialChapterCount` 记实际值。
2. **PDF 50MB 真因=Edge 标签结构树，非图片**：试点 full.pdf 48.5MB 解剖——全部流内容仅 5.33MB（图片 0.32MB/字体 5 个共享 xref），但 PDF 内含 **34.5 万个间接对象**（/StructTreeRoot 无障碍标签树），对象开销 ≈42MB。摘除 StructTreeRoot/MarkInfo + garbage=3 回收后 **48.5→5.82MB / 3 秒 / 1290 页与文本逐页完好**。图片重采样（read 110dpi / print 150dpi + JPEG q80）在此之上再收紧。代价：交付件失去无障碍标签树（商城交付件可接受）。
3. **双 PDF 产物口径**：旧试点 `{id}-trial.pdf`/`{id}-full.pdf` → 新静态区 `{slug}/read.pdf`（阅读版 110dpi）/`print.pdf`（打印版 150dpi）/`trial.pdf`（试读版，保留兼容）。均 ≤10MB（NFR-03，`--max-mb` 配置项，超限自动降档 85dpi/q65 重压）。
4. **catalog 口径修正**：price 一律 **49800 分**（试点遗留 990 已覆写）；补 `province`/`industry`/`ownerType`/`trialChapterCount`。元数据推断纪律：文件名直推（水利局/厅/水务局→业主类型「政府水利部门」；城市→省份映射表；正文含水利/水务→行业「水利工程」），推不出留空并在本报告 §五记「待补」，不编造。
5. **常驻增量语义（RUN_LEDGER #16）**：无 `--force` 时已产出且校验通过的 slug（chapters.json 付费空壳 + 三 PDF + build_meta 齐）直接跳过，**新 docx 落盘即自动纳管**；catalog 合并不改写已有条目的 slug/publishedAt（除非 --force）——同一条命令既是全量批处理也是日常增量上架。

---

## 三、试点重跑 + 3 份冒烟实测（全部实跑贴数）

### 3.1 试点 js-shuiwang-2026 重跑（含压缩腿）

**断言 1 — chapters.json 结构不变（对重跑前基准快照逐项比对）**：

| 断言项 | 结果 |
|---|---|
| 章数 19 / 字段集 {id,title,html} | **一致** |
| 全部 19 个 id、章标题 | **逐项一致** |
| 前 2 章 html 与试点基准 | **逐字节一致**（同源 docx 复现性实证） |
| 付费章 html 恒空 | **17 个非试读章全部 `""`** ✓ |
| 切章梯级 | h1（与试点同路径，strong 梯级未触发） |

**断言 2 — 压缩腿（NFR-03 ≤10MB）**：

| 产物 | 压前 | 压后 | 页数 | 双解析器可开 |
|---|---|---|---|---|
| print.pdf（150dpi/JPEG q80） | full 49.07MB | **5.47MB** | 1290→1290 不变 | pypdf+pymupdf ✓ |
| read.pdf（110dpi/JPEG q80） | 同上 | **5.44MB**（6 图重采样） | 1290→1290 不变 | pypdf+pymupdf ✓ |
| trial.pdf（去结构树轻压缩） | 3.44MB | **1.57MB** | 147→147 不变 | ✓ |

首页文本抽样完好（「第一章 研究概述与方法论｜1.1 研究背景与目标…」），无降档 fallback 触发。

**断言 3 — catalog 口径**：price 990→**49800** ✓；新增 `trialChapterCount:17 / province:"江苏" / industry:"水利工程" / ownerType:""`（省级报告业主混合，留空待补）；`publishedAt: 2026-09-27` 保留（常驻稳定语义）✓。

**试读章数说明（重要产品决策）**：江苏报告末两章为 ~60 万字附录巨章（商机清单数据本体），章粒度下试读占比最高只能到 9.1%（17/19 章，59,683/658,423 字），**无法进入 15%-25% 带**——批处理按「最贴近带」原则取 17 章，--verify 如实记越带（见 §五-1）。若必须入带需章内截断（破坏章完整性，未实现）。

### 3.2 省级含图报告 ×3 冒烟（zj-shuili-2026 / gs-shuili-2026 / xz-shuili-2026）

| slug | 章/试读章 | 试读占比 | 页数 | full 压前→read/print/trial（MB） | 图片重采样 | 降档 |
|---|---|---|---|---|---|---|
| zj-shuili-2026（浙江 21 章 173,898 字） | 21 / 11 | **16.2%** 入带 | 386 | 13.54 → **2.55 / 2.58 / 1.07** | read 6 图@110dpi, print 2 图@150dpi | 无 |
| gs-shuili-2026（甘肃 21 章 242,807 字） | 21 / 14 | **15.6%** 入带 | 548 | 19.90 → **3.09 / 3.11 / 1.28** | 同上 | 无 |
| xz-shuili-2026（西藏 21 章 62,823 字） | 21 / 5 | **15.4%** 入带 | 132 | 4.09 → **1.56 / 1.57 / 0.62** | 同上 | 无 |

三份均 h1 梯级、双解析器可开、页数压前后一致、付费章空壳，冒烟全绿。

### 3.3 --verify 验收断言实测输出（4 份已产出范围）

```
$ python batch_up.py --verify --only js-shuiwang-2026,zj-shuili-2026,gs-shuili-2026,xz-shuili-2026
[verify] 上架清单 38 条 / catalog 4 条
  [warn] catalog 条数 4 ≠ 清单 38（未全量产出前属预期，不判 FAIL）
[verify] 已产出 4 份；占比越带 1 份 ['js-shuiwang-2026: 9.1%']；空壳抽验 ['gs-shuili-2026', 'js-shuiwang-2026', 'xz-shuili-2026'] 全零命中
[verify] PASS（EXIT=0）
```

断言覆盖：catalog 条目字段/price=49800 ✓、试读占比带（越带记 WARN 列表）✓、付费章 html 恒空 ✓、包内付费章 40 字指纹零命中（抽 3 份解包 grep）✓、read/print ≤10MB + pypdf 独立解析器可打开 ✓。

**幂等/增量实证**：复跑 `--only` 4 份 → `{"built": 0, "skipped": 4, "failed": 0}`（全部跳过）；`--limit 2 --dry-run` → 正确列出下一批待产出 2 份。

---

## 四、全量批处理命令（主会话触发；预计 40-70 分钟，Edge 渲染为主要耗时）

```
cd /e/AI-Station/WeAppForge/pipeline && PYTHONIOENCODING=utf-8 "C:/Users/91216/AppData/Local/Programs/Python/Python311/python.exe" batch_up.py && PYTHONIOENCODING=utf-8 "C:/Users/91216/AppData/Local/Programs/Python/Python311/python.exe" batch_up.py --verify
```

（一行=批处理+紧跟全量验收断言；已产出的 js/zj/gs/xz 四份自动跳过，实际新产 34 份。）

**日常增量用法（RUN_LEDGER #16 常驻出货口径）**：新研报 docx 落盘 `E:\AI-Station\EngOpp-Mining\reports\` 后，跑同一条命令 `python batch_up.py` 即自动纳管上架（SLUG 表外新文件走 infer_meta 兜底：auto-md5 slug+文件名推断省份/业主，推不出留空记待补）；已上架条目 slug/publishedAt 不改写。全量重跑口径：`python batch_up.py --force`。

---

## 五、已知问题与待补

1. **js-shuiwang-2026 试读占比 9.1% 越带（章粒度极限）**：末两章为 ~60 万字附录巨章（商机清单数据本体，占全文 91%），前 17 章累计仍 <15%；入带须章内截断（破坏章完整性，未实现）。--verify 记 WARN 不判 FAIL。荆门类文件可能出现 14.7% 贴线值，同理。
2. **ownerType 待补 15 份**：省级商机研究/汇总/完整版（业主混合无法从文件名直推）——henan-huizong、henan-juewa-wanban、hubei-huizong×2、hubei-shuili×2、xj-shuili×4、js-shuiwang、zj-shuili、gs-shuili、xz-shuili×2。其余 23 份城市局/厅=「政府水利部门」（文件名直推）。
3. **交付 PDF 无无障碍标签树**（去 StructTreeRoot 是 42MB 大头的根治手段）；文本层完整可检索可复制，无障碍场景如需再议。
4. **旧试点产物保留未动**：WeAppForge/data/pdfs/js-shuiwang-2026-{trial,full}.pdf（48.5MB 原件）作为压缩前证据留存；新静态区=data/xueyuan/pdfs/（ECS 镜像源）。
5. **城市局短报是薄商品**：湖北省水利厅全文仅 2,120 字（9 章）等 6 份 <5K 字文件，¥498 定价与内容量不匹配的风险留给运营判断（数据如实上架，不拦不造）。
6. trial.pdf 仅去结构树不做图片重采样（试读版保 150dpi 原清，实测最大 1.57MB，远低于阈值）。
7. 行业字段 38 份全部直推得「水利工程」（文件名/正文含水利/水务）；无一份需留空。
8. **全量 38 份跑毕后试读占比越带 5 份（--verify WARN 不判 FAIL）**：hubei-huizong-20260807 33.3%、hubei-shuili-1786519550 27.5%（首章过重的两份，超上界）；yichang 14.9%、jingmen 14.7%（贴 15% 下线差 0.1-0.3pp）；js-shuiwang-2026 9.1%（§五-1 附录巨章结构性极限）。其余 33 份全部入带。

---

## 六、chapters_full 付费正文全集产腿 + catalog tags（B 线转工单#1，2026-09-28 追加）

**契约**：`data/xueyuan/content/reports/<slug>/chapters_full.json` = `[{title, html, id}]` 全部章带正文（服务端付费下发真源；与包内 chapters.json 同切章/同键序，slug 对齐）。形状对齐 B 线试点站位件。

**改动 diff 概要**（母本 content_pipeline.py 核心逻辑零触碰）：
- 新增 `pipeline/chapters_full.py`（62 行）：`make_tags`（标题/省份/行业聚合 3-5 tag，推不出留空）/`full_payload`/`write_full`/`packed_match`（补产章与包内 id/标题序列一致性闸）
- `batch_up.py`（394 行，≤400）：+import；build_one 两处挂钩（写 chapters_full 复用已算好章数据零重解析 + catalog entry 增 tags）；+`backfill_one`（已 built slug 补产：mammoth 重解析→split_ex 同逻辑→一致性闸→落盘→catalog/build_meta 补 tags，全程不碰 Edge/PDF）；CLI +`--chapters-only`（与 `--only/--limit/--force` 组合，幂等跳过已有 chapters_full）

**回填命令（一行，已实跑）**：
```
cd /e/AI-Station/WeAppForge/pipeline && PYTHONIOENCODING=utf-8 "C:/Users/91216/AppData/Local/Programs/Python/Python311/python.exe" batch_up.py --chapters-only
```
实测：38 份 **2.5 分钟**（预估 5-10 分钟，城市件小更快）；tally `{"backfilled": 37, "skipped-existing": 1}`（1=B 线站位件，已按 `--force` 单独补产覆盖为产线产物）。

**抽验实数（含试点 3 份）**：js-shuiwang-2026 19 章/3.79MB、gs-shuili-2026 21 章/1.74MB、jingmen-shuiliju-2026 18 章/0.13MB——三章 id 对齐 ✓/标题对齐 ✓/全章 html 非空 ✓。与 B 线站位件比对：19 章**逐章 dict 相等**（字节差仅 JSON 格式化：站位件紧凑单行 vs 产线 indent=1，内容零差异）。

**catalog tags 终态**：38/38 有 tags（15 份 3 个 + 23 份 4 个，0 份留空）；样例 js=`["江苏","水利工程","商机研究","水网工程"]`、三门峡=`["三门峡","河南","水利工程","商机研究"]`。构建路径（新报告）与补产路径（存量）均自动携带。
