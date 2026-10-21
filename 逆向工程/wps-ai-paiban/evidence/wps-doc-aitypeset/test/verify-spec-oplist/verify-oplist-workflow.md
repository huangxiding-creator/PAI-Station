# Op List 格式参数验证工作流

本文档指导 Cursor Agent 验证 AI 生成的 oplist 中每条格式操作的 pPr/rPr（或旧形态 params）是否与要求原文一致。

## 适用范围

**只测一件事**：oplist 里每个样式 op 的段落级格式参数，是否忠实反映了要求原文中对应要素的格式描述。

| strict 路径 | 要求原文来源 | spec 输入模式 |
|-------------|-------------|--------------|
| strict + 规范文件 | `preprocess_export_content` 导出的 FormatContent txt | `format-content` |
| strict（用户录入格式要求） | 用户录入原文（可存为 txt 供脚本读取） | `user-entered` |

支持三种 oplist 形态：

| 形态 | 标识 | 参数来源 | role 解析 |
|------|------|---------|----------|
| **strict-props**（当前标准） | `batch_set_paragraph_props` | 直接从 `rules[].pPr` / `rules[].rPr` | `source.tag` → `TAG_TO_ROLE` |
| **import-batch**（过渡，仍兼容） | `import_element_styles` + `batch_apply_paragraph_style` | import 规则中的 pPr/rPr | `tag` + `style_name` 分流 |
| **legacy** | `setParaStyle` / `setRunStyle` | `params` 字段 | block `role` |

**不测**：

- 要素认定是否正确（tag 在文档中是否命中正确段落）
- 规范覆盖完整性（有没有遗漏）
- 应用后的实际效果（须另用 wps_read 抽样）

## 设计原则

**以 verify role 为主键，反向从要求原文里捞格式描述**——不要求原文里每条都归属某个 role。

### strict-props role 解析（`summarize_oplist.py`）

1. 读 `batch_set_paragraph_props` 每条 rule 的 `source.tag`
2. `resolve_verify_role(tag)` → verify role（**一 tag 一 role**，无 `style_name` 分流）
3. 同 tag 多条 rule 先合并 `pPr`/`rPr`，再转 flat params
4. 用 `ROLE_SPEC_MATCHERS`（format-content）或 `USER_SCOPE_TO_ROLE`（user-entered）反向检索要求原文

`TAG_TO_ROLE` 与引擎 `KFormatTags` 对齐，示例：

| source.tag | verify role |
|------------|-------------|
| `catalog_title` | `toc-title` |
| `ref_title` / `ref_list` | `ref-title` / `ref-content` |
| `ack_title` / `ack_content` | `ack-title` / `ack-body` |
| `abs_keywords` / `abs_keywords_en` | `keywords` / `keywords-en` |
| `abs_title_en` / `abs_content_en` | `abstract-en-title` / `abstract-en-body` |
| `catalog_h1` | `heading-1`（仅正文章节标题，非目录/参考文献/致谢标题） |

完整映射见 `summarize_oplist.py` 内 `TAG_TO_ROLE`。

| 要求原文类型 | 处理方式 |
|-------------|----------|
| 段落样式模板（字体/字号/行距/段前后…） | 按 verify role 检索后，参与 params 比对 |
| 版式/空行/上标/引用标注 | 列入「其他规范标注」，不参与 params 比对 |
| 封面/页码/公式排版 | 列入「其他规范标注」或「页面级要求」 |
| run 级局部格式（如「关键词」三字加粗） | `MANUAL`；oplist 通常记入 `manualIssues`，无对应 params |

关联文档：

- 正向绑 tag：`references/strict_rules/spec-tag-binding.md`
- 自然语言 → pPr/rPr：`references/strict_rules/spec-unit-conversion.md`
- §直出 oplist（共用）：`references/strict_rules/spec-txt-to-oplist.md`
- op 契约：`references/tools/atomic-ops/batch-set-paragraph-props.md`
- strict 全流程：`references/path-strict-rule.md`

## 输入

| 文件 | 说明 |
|------|------|
| oplist JSON | AI 生成的完整 op list；`meta.specFormat` 标识来源路径 |
| spec txt | FormatContent 规范 txt，或用户录入要求原文 txt |

`meta.specFormat` 取值：

| 值 | 含义 |
|----|------|
| `format-content-txt` / `plain-spec-txt` | 规范文件 strict |
| `user-entered-format-requirements` | 用户录入 strict |

脚本亦会按 spec 内容自动检测：含 `--- 气泡标注 ---` 或 `[气泡M→段K]` → `format-content`；否则 → `user-entered`。

## 工作流程

### Step 1：运行数据压缩脚本

```powershell
python test/verify-spec-oplist/summarize_oplist.py "<oplist.json路径>" "<spec.txt路径>" -o "test/verify-spec-oplist/comparison.md"
```

脚本行为：

- 自动检测 oplist 形态（`strict-props` / `import-batch` / `legacy`）与 spec 输入模式
- **strict-props**：合并同 tag 的 `pPr`/`rPr` → flat params；按 `TAG_TO_ROLE` 分组
- **import-batch**（过渡）：import pPr/rPr → flat params；`resolve_verify_role(tag, style_name)` 分组
- **legacy**：按 block role 去重 params 模板
- **format-content**：对每个 verify role，用 `ROLE_SPEC_MATCHERS` 反向检索气泡
- **user-entered**：按 scope 关键词（`USER_SCOPE_TO_ROLE`）将每行要求绑到 verify role
- 自动标注 **无中生有**（oplist 有、检索结果未写明的 params 字段）
- 输出 Markdown 对照文件

### Step 2：逐 role 审读对照表

1. **内部一致性**：同 role 下 params 不一致 → `INTERNAL_INCONSISTENCY`
2. **要求已写字段**：逐参数比对 → `MATCH` 或 `MISMATCH`（换算见 `spec-unit-conversion.md`）
3. **无中生有字段**：要求未写、oplist 却有的 params → 标 `无中生有`
4. **role 总判定**：
   - 要求已写字段全部正确，且无 MISMATCH → 该 role 为 `MATCH`
   - 存在要求已写字段错误 → `MISMATCH`
   - 仅有局部加粗/空行等非 params 项 → 另记 `MANUAL`

> `op reason 示例` 来自 oplist 的 `reason` 字段，**不是要求原文**，不得作为比对依据。

### Step 3：输出验证报告

## 判定标准

### 字号换算表

| 规范表述 | 等价 params 值 |
|----------|---------------|
| 三号 | 16pt |
| 四号 | 14pt |
| 小四 | 12pt |
| 五号 | 10.5pt |

（完整表见 `references/strict_rules/spec-unit-conversion.md`）

### 字段名等价

| AI params 字段 | 等价于 |
|----------------|--------|
| `marginTop` | `spaceBefore` / 段前 |
| `marginBottom` | `spaceAfter` / 段后 |

### 行距

| 规范表述 | 可接受 params |
|----------|--------------|
| 固定值 N 磅 / 行距 N 磅 | `lineHeight: N` |
| 单倍行距 | `1` 或 `1.0` |

### 对齐

| 规范表述 | params |
|----------|--------|
| 居中 | `center` |
| 两端对齐 | `justify` |
| 顶左 / 左对齐 | `left` |

### MATCH

要求检索结果中**已写明**的字段，oplist 值与要求一致（含上述等价换算）。

### MISMATCH

要求**已写明**的字段，oplist 值与要求不一致。

### 无中生有

oplist 的 params 里出现了某字段，但**该 role 检索到的要求原文中未写明**对应属性。

- 典型：`textAlign: left` 但要求只写宋体小四、行距20磅，未提对齐
- strict-props 下这是核心验收点：只应写出规范点名的属性，**不应**用默认值补齐未写字段
- **不算 MATCH**（不能因「合理默认」视为通过）
- **不算 MISMATCH**（要求并未要求另一种值）
- 在报告逐字段表中单独一列标 `无中生有`

脚本通过 `PARAM_SPEC_HINTS` 做关键词检测；间接引用（如「与中文摘要内容一致」→ `textIndent`）见 `SPEC_INFERRED_FIELDS`。

### MANUAL

1. 要求局部加粗但 oplist 无对应 run 级操作（v1 通常记入 `changeSummary.manualIssues`）
2. 上标/下标、空行数量、页面级设置
3. 非格式属性（字数、逗号分隔等）

## 报告格式

```markdown
## 概览
- oplist 形态: strict-props / import-batch / legacy
- spec 输入模式: format-content / user-entered
- MATCH: N | MISMATCH: N | 无中生有: N 个 role 涉及 | MANUAL: N

## 逐 Role 判定
### [role名]
| 参数 | 规范要求 | AI 值 | 结果 |
| fontSize | 小四=12pt | 12pt | MATCH |
| textAlign | （未写明） | left | 无中生有 |

## 无中生有清单
| role | 字段 | AI 值 | 说明 |
```

## strict-props 与旧形态的差异（审读时注意）

| 项 | import-batch（旧） | strict-props（新） |
|----|-------------------|-------------------|
| 参数所在位置 | `import_element_styles.element_style_rules[]` | `batch_set_paragraph_props.rules[].pPr/rPr` |
| role 分流 | 靠 `style_name`（同 tag 多义） | 靠独立 `source.tag` |
| 未点名属性 | 挂样式时易被默认补齐 → 难用「无中生有」检出 | 不应出现在 oplist；若出现即缺陷 |
| 对照表展示 | tag + target + style_name | tag + `batch_set_paragraph_props` |

## 与 path-strict-rule.md 校验对齐（人工追加项）

脚本自动覆盖 `path-strict-rule.md` **§strict 编排顺序与硬约束** S2（只写声明字段）的子集：报告「无中生有」列。其余 **§校验** 条目脚本不自动检测，须 Agent 对照 `references/path-strict-rule.md` **§校验** 人工确认：

| §校验 条目 | 脚本 | Agent 动作 |
|-----------|------|-----------|
| 每条格式要求已映射到 tag / toc level / 页级 op，或记入 `changeSummary.skipped` / `manualIssues` | 不测覆盖完整性 | 核对 skipped/manualIssues 与未映射要求 |
| `rules[].source` 仅含 `{ "tag": "..." }`，禁止填 scope `type` | 不测 | 抽查 rules[].source 结构 |
| （仅规范文件）changeSummary 可回溯规范气泡 ref | 不测 | 核对 manualIssues/skipped 含气泡 ref |
| changeSummary 已按 `references/beauty/op-list-summary.md` 生成 | 不测 | 核对摘要格式与字段 |
| `path-strict-rule.md` §strict 编排顺序与硬约束 已满足 | 部分（S2→无中生有） | S1 禁止 import+batch_apply 及 delta 型 op；S3 tag ∈ formatList；S4 rule 非空；S5 无 pStyle；S6 页级/目录走 setup op |

**路径差异**（§校验 共用条目之外的执行差异）：

| 项 | strict + 规范文件 | strict（用户录入格式要求） |
|----|------------------|---------------------------|
| 要求原文 | FormatContent txt（`meta.specFormat`: `format-content-txt`） | 用户录入原文（`user-entered-format-requirements`） |
| changeSummary 回溯 | 规范气泡 ref | 录入原文行 |
| 目录条目 | scope → toc level → `setup_toc_styles` | 同左 |
| 页级要求 | `setup_page_setup` / `setup_header_footer` | 同左（若用户提出） |
