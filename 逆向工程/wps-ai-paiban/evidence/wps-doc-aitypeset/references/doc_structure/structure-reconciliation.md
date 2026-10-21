# 多源结构识别与合并

## 工作流

```
1. 并行采集 A + B
2. 按 data-id join
3. 逐块当场裁决 → 写入或移出 formatList
4. 输出 formatList（+ splitHints 透传，若有）
```

### Step 1：并行采集

```text
A ← wps_toolcall_fmt("doc_element_recog", "{}")   // 见 references/doc_structure/doc-element-recog.md
B ← wps_read → wps.overview()（skeleton 引文供 join 与 Step 3 冲突核对，见 overview-format.md）
```

A 失败时：**不得阻塞**；以 skeleton 引文 + 下表 Role→tag 映射补写 `formatList`，样本不足处留空。
#### Role 列表

| role | 说明 | A 源常见 tag | 默认处理 |
|------|------|--------------|----------|
| `title` | 文档主标题 | `doc_title` | 套 title 样式 |
| `cover` | 封面区域段落 | `cover` | 不参与正文/标题美化；见 §封面特别说明 |
| `doc-id` | 文号/发文字号 | `doc_id` | 谨慎；常 skip 或轻度统一 |
| `addressees` | 主送对象 / 称呼语（汇报·讲话稿开场） | `addressees` | **顶格**；字体同正文；见 §称呼语特别说明 |
| `heading-1` | 一级标题 | `catalog_h1` | 套 h1 样式 |
| `heading-2` | 二级标题 | `catalog_h2` | 套 h2 样式 |
| `heading-3` | 三级标题 | `catalog_h3` | 套 h3 样式 |
| `chapter-title` | 章标题 | `chapter_title` | 套 heading 样式 |
| `section-title` | 节标题 | `section_title` | 套 heading 样式 |
| `appendix-title` | 附录标题 | `appendix_title` | 同 heading-1 或单独规范 |
| `ack-title` | 致谢标题 | `ack_title` | 套 heading 样式 |
| `ref-title` | 参考文献标题 | `ref_title` | 套 heading 样式 |
| `statement-title` | 声明标题 | `statement_title` | 套 heading 样式 |
| `body` | 正文 | `main_text` | 2em 缩进 + 正文字号 |
| `list-item` | 编号/项目列表项 | `numFormatList` 成员 | 统一列表缩进 |
| `blockquote` | 引用 | — | 缩进 + 可选浅灰 |
| `table-caption` | 表格标题 | `table_title` | 小号字 |
| `image-caption` | 图片标题 | `image_title` | 小号字 |
| `footer-like` | 落款、署名、日期 | `signature` | **右对齐**；首行与正文**大间距**；见 §落款特别说明 |

**B源识别的额外流程（不能省略）**
1. 封面识别，见 §封面特别说明
2. 称呼语识别（汇报类、讲话稿类），见 §称呼语特别说明
3. 落款识别，见 §落款特别说明

#### 封面特别说明

美化等流程依赖 `formatList.cover` 保护封面段落。当A源未识别到cover时，有必要在B源中增强一下封面段落的识别，以免封面区域被排乱。

**B 源独立识别封面的技巧**

- 封面只在文档的起始一二页
- 通常含有一个文档标题
- 标题后会有少量段落表明作者（人名、单位、机构等）、日期等文档信息
- 文档信息与标题间通常会夹杂一些空段、空格来保持排版美观
- 文档信息通常会居中

**典型的封面示例**：

```text
<p data-id="0-12">   "毕业论文"
<p data-id="13-45">  "某某大学某某学院"
<p data-id="46-78">  "计算机科学与技术专业"
<p data-id="79-83">（空）
<p data-id="83-95">  "学号：2021001"
<p data-id="96-110"> "姓名：张三"
<p data-id="111-130">"指导教师：李四"
<p data-id="131-144">（空）
<p data-id="141-168">"第一章 绪论"          ← bodyStartId（B2）
```

→ `formatList.cover`: `["1-12","13-45","46-78","79-95","96-110","111-130"]`

**合并后净化（与其他 tag）**

凡已写入 `formatList.cover` 的 data-id，**必须从**下列 tag 数组中**剔除**（若存在）：

`doc_title`、`doc_title_en`、`general_doc_title`、`catalog_h1`～`catalog_h9`、`main_text`、`chapter_title`、`section_title`、`doc_id`、`signature`、`emphasized_title`、`addressees`

**冲突取舍**：段落同时被 A 标为 `main_text` / `doc_title` 且落入 `formatList.cover` → **以 `cover` 为准**（改 tag 归属，不双写）。

#### 称呼语特别说明

汇报稿、发言稿、讲话稿等文档正文开端，常有 **称呼语**（如 `尊敬的各位领导：`）。A 源常漏标或并入 `main_text`，须在 B 源 skeleton 中增强识别。

紧接称呼语的 **问候语**（如 `大家好！`）版式与正文相同，**不**单独建 tag，保留在 `main_text` 中按正文处理。

**B 源独立识别称呼语的技巧**

- **位置**：标题（`doc_title`）或封面结束之后、**第一篇实质性正文之前**（首个带 `2ch` 首行缩进的长段或首个 `catalog_h1` 之前）
- **文档类型信号**：标题/引文含「汇报」「发言」「讲话」「致辞」等；或正文结构呈讲话稿形态（开场短段 + 缩进正文）
- **称呼语**（写入 `formatList.addressees`）：
  - 引文较短（通常 ≤40 字），**以全角冒号 `：`** 结尾
  - 常见开头：`尊敬` / `各位` / `敬爱的` / `同志们` 等称谓组合
  - 示例：`尊敬的各位领导：`、`各位代表：`、`同志们：`
- **问候语**（如 `大家好！`）：**不写入** `formatList` 独立键；紧接称呼语的下一段保留为 `main_text`
- **合并一段**（如 `尊敬的各位领导： 大家好！`）：整体写入 `addressees`
- **排除**：已归入 `cover` / `doc_title` / `catalog_h*` 的段落；正文中间的非开篇称呼句式**不**标为 addressees

**典型示例**：

```text
<p data-id="0-45">   "2024年度工作汇报"
<p data-id="46-78"> "尊敬的各位领导："
<p data-id="79-95"> "大家好！"
<p data-id="96-200">"　　本年度我们……"
```

→ `formatList.addressees`: `["46-78"]`  
→ `formatList.main_text`: `["79-95", "96-200", ...]`（含问候语段）

**合并后净化（与其他 tag）**

已写入 `formatList.addressees` 的 data-id，**必须从** `main_text` 数组中**剔除**（若存在）。

凡已写入 `formatList.addressees` 的 data-id，**不得**出现在 `catalog_h1`～`catalog_h9` 中。

**冲突取舍**：A 标为 `main_text`、B 识别为开篇 `addressees` 且满足上文位置与形态 → **以 B 为准**（改 tag 归属，不双写）。

**版式要求**

| 项 | 要求 |
|----|------|
| 首行缩进 | **顶格**（`ind.firstLine: "0pt"` 或 `"0ch"`） |
| 字体 | 与 **正文** 相同（同 `rFonts.eastAsia`、同 `sz`；**不加粗**） |
| 对齐 | `pPr.jc: start`（左对齐顶格） |
| 段距 | 与正文 baseline 一致，或略紧；**禁止**套用标题段前距 |

**美化落地**

称呼语须挂**独立样式名**（段级顶格 + 正文字体），**禁止**直接套 `main_text`（正文含 `2ch` 首行缩进）。`import_element_styles` 写入 `addressees` 要素（`pPr` 同正文但 `ind.firstLine: "0pt"`，`rPr` 与 body 一致）；`batch_apply_paragraph_style` 的 `source.tag` 为 `addressees`。详见 `beauty-default.yaml` → `roles.addressees`、`full-beauty.md`。

#### 落款特别说明

**B 源独立识别落款的技巧**

- 落款通常在文档末尾
- 通常含署名单位、姓名、日期等信息
- 落款段落通常**右对齐**

**合并后净化**

已写入 `formatList.signature` 的 data-id **必须从** `main_text` 数组中剔除。与 A 源冲突时 **以 `signature` 为准**。

**版式要求**

| 项 | 要求 |
|----|------|
| 对齐 | `pPr.jc: end`（右对齐） |
| 与正文间距 | 落款**首段**段前 **≥24pt**（约 2 行正文空白）；落款内部各行段前宜 **0pt**（紧凑排列） |
| 缩进 | **禁止**正文 `2ch` 首行缩进 |

美化落地：`footer-like-lead` + `footer-like`；`batch_apply` 时首段 `scope` 为 `start/end` 均 `{ "type":"signature","index":1 }`，其余 `start` 为 `index:2` 且**不写** `end`（见 `full-beauty.md`、`atomic-ops.md` §scope）。

---

### Step 2：块对齐

join 规则（按优先级）：

1. **字符串完全相等**：A `formatList` 中的 id 与 B skeleton 的 `data-id` 相同
2. **startGcp 相同**：`id.split('-')[0]` 一致（轻微 end 边界差异）

**禁止**用 text/order 建映射表。`splitHints` **不参与**合并，但 `open_typeset_session` 须原样透传 A 源返回值。

### Step 3：逐块裁决并写入 formatList

- 以 **A 源 `formatList` 为骨架**（tag → data-id[]），对每个 data-id 当场应用下列规则，**直接改写入库**，不另建中间态、不记录 conflicts：
- 表格、object内的段落不要采纳进入formatList

| 情形 | 动作 |
|------|------|
| A + B role 一致 | 保留原 tag |
| A 有 tag、B 缺失或无法分类 | 保留 A tag |
| B 有 role、A 缺失 | 按 B role 映射到对应 tag 后写入 |
| A 与 B 冲突 | 按下表 **当场取舍**，必要时 **改 tag 或剔除** |

**冲突取舍**（按优先级，命中即停）：
- 其中一个为标题，另一个为正文 → 满足如下条件为标题：
  1. 比较短(40字符以内)，内容具有总结意义，而不是几个无意义的数字、字母、符号拼凑而成
  2. 标题不能是个光杆，后续段落要么是正文，要么是下一级标题
  3. A源中 `numFormatList`列表项如果是连续的几个段落，它们就不会认定为标题。这也符合上一条的定义

- A 标为 `main_text`、B 识别为开篇 `addressees` 且符合 §称呼语特别说明 → **以 B 为准**，改 tag 并自 `main_text` 剔除

- 如果以上规则都无法判断  → 以A源为准

### Step 4：输出

**唯一必须产出的合并结果**：`formatList`（结构与 A 源一致，内容为裁决后结果）。

```json
{
  "formatList": {
    "main_text": ["17-164", "189-338"],
    "catalog_h1": ["305-318"]
  }
}
```

**可选透传**（仅 `open_typeset_session` 需要，不参与规整度判定）：

- `splitHints`：A 源原样透传，禁止修改或丢弃

## formatList 构建规则

1. **tag 键以 A 源为准**；data-id 来自 A，裁决后可改 tag 归属或剔除
2. **未写入 formatList 的 data-id** = 不参与后续样式 op（等同 unknown / skipped）
3. **表格内段落**不得出现在 `catalog_h*` / `main_text` 等（见 Step 3 规则 7）
4. `open_typeset_session` 的 `recog_result` **必须**使用合并后的 `formatList` + 原始 `splitHints`，禁止直接用未合并的 A 源

## 禁止

- 禁止只看 doc_element_recog 或只看 overview 其一就下 op
- 禁止在无法判定的块上猜测 tag 并写入 formatList
- 禁止用 text/order 建立 paraId ↔ data-id 映射
- 禁止修改或丢弃 `splitHints`

## 参考

- `references/doc_structure/doc-element-recog.md` — 引擎识别 JSON
- `references/tools/overview-format.md` — overview 与 data-id
- `references/beauty/beauty-default.yaml` — 称呼语默认样式（顶格 + 正文字体）
