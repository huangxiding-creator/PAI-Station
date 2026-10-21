
> **【加载标识】** 本路径一旦加载，回答正文最开头必须先输出一行：`✅ 进入 strict 规范排版流程`。

# 按规范 strict 排版

按用户提供的**附件规范**或**格式要求**逐条匹配排版，**只改规范要求的格式**，不做美化兜底（见 `references/path-beauty-rule.md`）（路径 F）。

## 额外的文件目录, 每个文件后附有功能说明，按需加载，不要一次性全部加载

```
wps-doc-aitypeset/
│
├── references/
│   ├── doc_structure/                    ← 文档结构识别（A/B 源）
│   │   ├── doc-element-recog.md          → doc_element_recog 结构识别（A 源）
│   │   └── structure-reconciliation.md   → 双源结构识别与冲突 reconcile
│   │
│   ├── strict_rules/                     ← 严格模式（strict）执行细则
│   │   ├── spec-txt-to-oplist.md         → 直出 oplist 生产流水线（规范/用户共用）
│   │   ├── spec-tag-binding.md           → scope→tag 绑定表
│   │   ├── spec-unit-conversion.md       → 自然语言→pPr/rPr 换算表
│   │
│   └── tools/                            ← 工具能力说明
│       ├── overview-format.md            → overview 输出解析（B 源）
│       ├── wps_read_usage.md             → wps_read 工具用法
│       ├── wps-toolcall-fmt.md            → wps_toolcall_fmt 通用 op（含 ai_typeset）
│       ├── wps-toolcall-oplist.md        → oplist 写回相关 wps_toolcall_fmt op
│       ├── wps-toolcall-strict-spec.md   → strict 规范文档专用 wps_toolcall_fmt op
│       └── atomic-ops.md                 → 编排 oplist 的原子 Op 能力说明；编辑 oplist 之前必须先阅读
└── test/                                 ← 验证脚本（开发/测试用，执行时不加载）
    └── verify-spec-oplist/
        ├── summarize_oplist.py           → oplist 摘要脚本
        └── verify-oplist-workflow.md     → Op List 格式参数验证工作流
```

## 工作流

### 子路径选择

先判定子路径，再按对应 checklist 逐步执行至写回。

| 子路径 | 触发条件 | checklist |
|--------|---------|-----------|
| **strict（用户录入格式要求）** | 用户录入格式要求，且**无**规范附件（doc/docx/wps/wpt/dot/dotx） | §strict（用户录入格式要求） |
| **strict + 规范文件** | 用户提供了规范附件 | §strict + 规范文件 |

### strict（用户录入格式要求）

```
- [ ] 1. 确认 §子路径选择 → 本 checklist
- [ ] 2. structure-reconciliation.md 工作流 Step 1–4（须遵守 §约束规则）
- [ ] 3. 加载 `spec-txt-to-oplist.md`（§入口 A：用户录入拆条 + §直出 oplist（共用））→ 直出 oplist（编排顺序与约束见本文 §strict 编排顺序与硬约束）
- [ ] 4. §校验
- [ ] 5. §写回 session
```

### strict + 规范文件

**禁止**在 classify_desc_document 完成之前执行结构识别。

```
- [ ] 1. 确认 §子路径选择 → 本 checklist
- [ ] 2. classify_desc_document（wps-toolcall-strict-spec.md §2）
        - doc_type=format_spec 且 code===0 → 继续 3
        - doc_type=model_essay → 继续 4 后 **STOP**（禁止继续 oplist 流程）
        - code!==0 → 告知用户分类失败，终止
- [ ] 3. preprocess_export_content 导出 FormatContent txt（须 code===0，wps-toolcall-strict-spec.md §3）
- [ ] 4. （仅 model_essay）ai_typeset(mode=rule, rule_file=<规范文件绝对路径>, rule_mode=model_essay)（wps-toolcall-fmt.md §4.3）
- [ ] 5. **并行**：FormatContent txt（步骤 3）+ structure-reconciliation.md 工作流 Step 1–4（须遵守 §约束规则）
- [ ] 6. 加载 `spec-txt-to-oplist.md`（§入口 B：FormatContent txt 抽取 + §直出 oplist（共用））→ 直出 oplist（编排顺序与约束见本文 §strict 编排顺序与硬约束）
- [ ] 7. §校验
- [ ] 8. §写回 session
```

## strict 编排顺序与硬约束

### 编排顺序

按需选取；段落格式**只用** `batch_set_paragraph_props`，**禁止** `import_element_styles` + `batch_apply_paragraph_style` 及 delta 型段落 op。

```
batch_set_paragraph_props
→ setup_page_setup（可选）
→ setup_header_footer（可选）
→ setup_toc_styles（可选）
→ insert_table_of_contents / update_table_of_contents（可选）
```

各 op 字段契约见 `references/tools/atomic-ops/` 下对应文档；单位见 `atomic-ops.md §单位约定`。

### 硬约束

| # | 约束 | 说明 |
|---|------|------|
| S1 | **段落格式 op** | 只用 `batch_set_paragraph_props`；禁止 `import_element_styles`、`batch_apply_paragraph_style`、`batch_set_paragraph_indent`、`batch_set_spacing`、`batch_set_span_style` 拼 strict 段落格式 |
| S2 | **只写声明字段** | 每条 rule 的 pPr/rPr 仅含要求原文写明的字段；未写字段不得出现 |
| S3 | **tag 存在性** | `source.tag` ∈ 当前 `formatList`；默认省略 `data_ids` |
| S4 | **rule 非空** | 每条 rule 的 pPr/rPr 至少一个非空 |
| S5 | **不改 pStyle** | 本 op 不写 `pPr.pStyle`；不指望清除未声明的局部字符属性 |
| S6 | **页级/目录** | 页边距/页眉页脚/目录条目仍用 setup op（见 `strict_rules/spec-unit-conversion.md`） |
| S7 | **单次提交** | 全部 op 合入一个 `oplist` 数组，**一次** `oplist_exec` 提交；**禁止**拆分为多次调用 |
| S8 | **目录 tocPr 路径** | oplist 内 `insert_table_of_contents` / `update_table_of_contents` / `delete_table_of_contents`：`tocPr` 须写在 **`action.action.format.tocPr`**；一层 `action.format.tocPr` **不生效** |

契约详见 `atomic-ops/batch-set-paragraph-props.md`；绑 tag 见 `strict_rules/spec-tag-binding.md`。

**常见误用**：

- ❌ `insert_table_of_contents` / `update_table_of_contents` / `delete_table_of_contents` 在 oplist 内写一层 `action.format.tocPr` — 须嵌套 `action.action.format.tocPr`（见 S8）
- ❌ 页眉页脚写了 `text`/`pageNumber` 却省略 `mode` — 默认 `"skip"` 不写入，写入须 `"mode": "set"`
- ❌ 用 `update_table_of_contents` 改 `tabLeader` 等样式却 `updateScope:"all"` — 改样式须 `updateScope:"first"`

## 校验

- [ ] 每条**可自动处理**的格式要求已映射到 tag / toc level / 页级 op，或记入 `changeSummary.skipped`；局部字符属性静默跳过，不入 `changeSummary`、摘要不提
- [ ] `rules[].source` 仅含 `{ "tag": "..." }`，禁止填 scope `type`（如 `heading1`）
- [ ] （仅规范文件）changeSummary 可回溯规范气泡 ref
- [ ] changeSummary 已按 `references/beauty/op-list-summary.md` 生成
- [ ] §strict 编排顺序与硬约束 已满足

## 写回 session

§校验 全部通过后：

1. 输出 op list JSON + 变更摘要（Markdown 表格，`status: planned`）
2. `open_typeset_session` → `oplist_exec` → `close_typeset_session`（`wps-toolcall-oplist.md` §3）
3. 成功后将 `status` 更新为 `applied`，汇报 `applied` / `failed` 条数

## 约束规则

- 禁止未校验、未输出摘要即调用 `oplist_exec`
- 禁止 normalizeStructure、detectDocType（若仅为结构调参）
- 禁止任何用户未要求的格式处理
- 禁止用块级 confidence 筛选/阻止 op 生成（low confidence 仅记入 `changeSummary.skipped`）
- 禁止对 object 节点直接操作
- 禁止产出 requirementList、normalizedRules 或任何中间态 JSON
- **strict + 规范文件额外**：禁止将 `[段N]` 用作待排版文档 `target.dataId`；禁止用范例页码硬编码绑 tag；禁止逐气泡各产一条 op（须聚合）
- 禁止使用附件名称或内容检索模板（附件仅作规范依据）
- 禁止加载已废弃的 `spec-binding-tables.md`（权威绑表为 `spec-tag-binding.md`）

## 与 ai_typeset 的边界

本路径默认走结构识别 → op list 规划 → `oplist_exec` 写回。`classify_desc_document` 判定为范文（`model_essay`）时改走 `ai_typeset(rule_mode=model_essay)`（§strict + 规范文件 步骤 4）。四品类走 `path-tradition-spec-rule.md`，两者互斥。
