# strict 直出 oplist 指南

## 硬前提

`source.tag` 只能来自 `structureProfile.formatList` 已有键，禁止臆造 tag。

---

## 入口 A：用户录入拆条

> 用户录入格式要求路径专用（输入 = 用户消息中的自然语言格式要求）

读用户录入的格式要求，拆成独立条目，每条含 **scope**（要素名）和 **格式描述**（自然语言）：

| 用户表述示例 | scope | 格式描述 |
|-------------|-------|---------|
| 正文宋体小四，首行缩进2字符 | 正文 | 宋体小四，首行缩进2字符 |
| 一级标题黑体三号居中 | 一级标题 | 黑体三号居中 |
| 参考文献标题黑体三号 | 参考文献（标题） | 黑体三号 |

一句含多个要素时先拆为单 scope 条目（如「正文和标题都用宋体」→ 正文 + 标题各一条）。一条用户要求对应一个绑定结果（`source.tag` 或目录条目的 toc level）。拆条完成后执行 §直出 oplist（共用）。

---

## 入口 B：FormatContent txt 抽取

> strict + 规范文件路径专用（输入 = `preprocess_export_content` 导出的 FormatContent txt）

### FormatContent 形态

规范 txt 由 `preprocess_export_content` 导出，含以下标记：

| 标记 | 含义 |
|------|------|
| `==[页码：N]开始/结束==` | 规范**范例文档**的页码边界（非待排版文档） |
| `[段N]` | 规范范例文档里的段落编号 |
| `--- 气泡标注 ---` | 气泡区块起始 |
| `[气泡M→段K]` | 气泡 M 指向规范范例的段 K |
| `[气泡M]`（无→） | 脚注/页面级浮动批注 |

#### 示例片段（北方工业大学硕士论文 · bubble 标注类型）

```text
==[页码：6]开始==
[段66] 论文题目（中文）
[段67] 摘  要
[段68] 论文的摘要，是对论文研究内容的高度概括……
[段73] 关键词：学位论文，论文格式，规范化，模板

--- 气泡标注 ---
[气泡18→段66] 论文题目（中文）： 黑体三号加粗居中，单倍行距，段前24磅，段后18磅
[气泡1→段67] 摘要：中间空两格，黑体三号加粗居中，行距固定值40磅，段前12磅，段后24磅
[气泡2→段68] 内容：宋体小四号字，行距20磅，段前段后0磅，首行缩进2个汉字符……
[气泡3→段73] 宋体小四号字，行距20磅，段前段后0磅，词与词间用逗号隔开，"关键词"三字加粗
[气泡4] 页脚只要页码，中英文摘要用罗马大写数字标记。从正文开始使用阿拉伯数字标记页码。
==[页码：6]结束==
```

### 标注类型与抽取

同一份 FormatContent **可能混合多种标注类型**；混合时逐条按来源标记 dialect。单条判定优先级：

1. 存在 `--- 气泡标注 ---` → **A bubble**（该页以此为主）
2. 分节叙述格式（如「（3）正文」）且无气泡 → **B section-narrative**
3. 段内括注（如 `（黑体，三号字）`）且无上述标记 → **C inline-annotation**

| dialect | 特征 | 典型来源 | 覆盖 |
|---------|------|----------|------|
| **A bubble** | `[气泡M→段K]` 给出格式要求 | 北方工业大学硕士论文 | 完整保证解析与绑 tag |
| **B section-narrative** | 「一、二、（1）（2）」分节，段内含格式描述 | 国家开放大学本科论文 | 最小规则，不保证全部场景 |
| **C inline-annotation** | 内容与格式同段，括号括注 | 会议纪要 | 最小规则，不保证全部场景 |

**A 抽取**：遍历 `--- 气泡标注 ---`；`[气泡M→段K]` → scope（冒号前）+ 格式描述（冒号后）+ 气泡 ref；`[气泡M]` 无 `→` → 仅格式描述（后续管道见 §直出 oplist（共用））。

**B/C 抽取**：拆条为 scope + 格式描述（C 含行内括注）；B 未命中绑表 → `changeSummary.skipped`。拆条完成后执行 §直出 oplist（共用）。

---

## 直出 oplist（共用）

对拆条产出的每条 **scope + 格式描述**（规范路径含 `para_text`、气泡 ref），按序执行下列管道。配套文件**按需加载**（产出 oplist 前须已读 `path-strict-rule.md` §strict 编排顺序与硬约束）：

> scope 为空的条目（如浮动气泡）跳过步骤 1，直接从步骤 2 按格式描述特征区分路由。

| 步骤 | 文档 | 职责 |
|------|------|------|
| 1 绑 tag | `spec-tag-binding.md` | 谁：`source.tag` 或 toc level |
| 2 区分格式要求 | 本节 §区分格式要求 | 进哪种 op |
| 3 填参数 | `spec-unit-conversion.md` 对应章节 | 值：JSON 字段 |
| 4 聚合与冲突 | 本节 §聚合与冲突 | 合并同 tag / 同 level |
| 5 产出 oplist | 本节 §产出 oplist；`path-strict-rule.md` §strict 编排顺序与硬约束 | op 结构与顺序 |

### 绑 tag

查 `spec-tag-binding.md`（输入/输出/排除见该文件 §使用方式）。`source.tag` 非 `—` 但 ∉ `formatList` → `changeSummary.skipped`；§排除规则命中 → 不绑 tag，跳过填参。

### 区分格式要求

| 格式描述特征 | 路由结果 | 填参章节（`spec-unit-conversion.md`） |
|-------------|---------|--------------------------------------|
| 段落格式（字体/字号/行距/缩进/对齐/段前后/整段加粗） | `batch_set_paragraph_props` | 字号～大纲级别、§完整换算示例 |
| 目录标题（`catalog_title`） | `batch_set_paragraph_props` | 字号～大纲级别、§完整换算示例 |
| 页边距 | `setup_page_setup` | §页面边距 |
| 页眉/页脚/页码 | `setup_header_footer` | §页眉页脚页码 |
| 目录 1/2/3 条目（toc level） | `setup_toc_styles` | §目录样式 |
| 版式说明（「空N行」「前后分别间隔」） | 不绑 tag | 不查 |
| 局部字符属性（局部加粗/上标/下标等） | 静默跳过 | 不查；同条描述中可换算的段落/字符属性仍按上表处理 |
| 内容要求（字数、逗号分隔等） | `changeSummary.manualIssues` | 不查 |

### 填参数

按上表「填参章节」列查 `spec-unit-conversion.md` 对应章节；为「不查」则跳过。遵守该文件开篇规则（含「未写不填」）。

### 聚合与冲突

#### 聚合规则

- 同 `source.tag` 的多条要求：**合并**为一条 `batch_set_paragraph_props` rule（`pPr`/`rPr` 字段级合并，冲突后覆盖）
- 同 **toc level** 的多条目录条目要求：**合并**为 `setup_toc_styles.tocStyle.levels[]` 中同一 `level` 项的 pPr/rPr
- 同 `source.tag` 互斥格式要求且无法拆条 → `changeSummary.manualIssues`（不强行字段合并）
- 同 tag + 同 data_ids 集合的多条 rule 在引擎侧也会合并（规划侧宜先合并）
- 默认省略 `data_ids`（各要素独立 tag）
- **禁止** `import_element_styles` + `batch_apply_paragraph_style`

#### 冲突解决

同一 `source.tag` 被多条格式要求覆盖时：

##### 来源优先级（高 → 低，仅规范文件路径 / 含 dialect 时）

1. **bubble** 气泡直接指向的段
2. **section-narrative** 分节描述
3. **inline-annotation** 行内括注

用户录入路径仅有单一来源；同 tag / 同 level 多条按**后覆盖前**。

##### 相同来源内

- 后出现的条目覆盖前面的（同 CSS cascade 逻辑）
- 更具体的 scope 优先于宽泛 scope

##### 冲突解决规则

- 同一 param 被两条规则设为不同值 → **取优先级高者**（用户录入：后覆盖前）
- 不同 param → **合并**
- 冲突无法判定 → 该 param 不出 op，记 `changeSummary.skipped`

### 产出 oplist

#### ops 模板

典型 oplist 聚合为 **1~6 条 op**，禁止逐条要求各产一条 op：

```
1. batch_set_paragraph_props   — 按 formatList tag 写段落/字符属性（`pPr`/`rPr`）
2. setup_page_setup            — 可选，页边距/纸张
3. setup_header_footer         — 可选，页眉/页脚/页码
4. setup_toc_styles            — 可选，目录条目样式
5. insert_table_of_contents / update_table_of_contents — 可选
```

op 顺序见 `path-strict-rule.md` §strict 编排顺序与硬约束。各 op 字段契约见 `references/tools/atomic-ops/` 下对应文档。

#### oplist 顶层结构

本节结束时须产出完整 oplist，交付物 = **JSON + 文字摘要**（`status: planned`），缺一不可。顶层字段：`mode`、`status`、`meta`、`structureProfile`、`ops`、`unsupportedRequirements`、`changeSummary`。

**静默跳过**：当前版本不支持的局部字符属性（局部加粗、上标、下标等）**不入** `ops`、`changeSummary`、`unsupportedRequirements`，**文字摘要亦不得提及**。

#### structureProfile

将 `structure-reconciliation.md` Step 4 产出装入 oplist 顶层 `structureProfile`。**非**合并中间态；**无** `blocks` / `conflicts` 数组（A/B 分歧在 Step 3 **当场裁决**后写入 `formatList`）。

| 字段 | 必须 | 说明 |
|------|------|------|
| `formatList` | 是 | 合并后 tag → data-id[]；与 `open_typeset_session` 的 `recog_result.formatList` **同一对象** |
| `splitHints` | 否 | A 源原样透传（若有） |
| `engineRecog` | 否 | A 源失败或 `code !== 0` 时填 `"unavailable"` |
| `skipped` | 否 | 合并时未写入 `formatList` 的 data-id 及原因（表格内段落、object 内段落等） |

`structureProfile.skipped`（合并剔除）与 `changeSummary.skipped`（绑 tag / 要求映射失败）职责不同，勿混用。

#### meta 与顶层字段

| 字段 | 用户录入 | 规范文件 |
|------|---------|---------|
| `meta.specFormat` | `"user-entered-format-requirements"` | `"format-content-txt"` |
| `meta.specPath` | 省略 | 规范文件绝对路径 |
| `unsupportedRequirements` | 原子能力仍无法表达的页级/版式要求（应尽量少用） | 同左 |
| `changeSummary.skipped` | formatList 无 tag 或绑表无法匹配 | 同左 |
| `changeSummary.manualIssues` | 内容要求等非格式项 | 同左；规范路径须可回溯气泡 ref；**禁止**写入局部字符属性 |

changeSummary 格式细则见 `references/beauty/op-list-summary.md`。

#### 完整 oplist 示例

两条入口共用本节产出逻辑，`structureProfile`、`ops`、`changeSummary` 等形态相同；仅 `meta` 与 `changeSummary.manualIssues` 按上表分路径填写。下例取**规范文件**路径（含 `meta.specPath`、可回溯气泡 ref）：

```json
{
  "mode": "strict",
  "status": "planned",
  "meta": { "specFormat": "format-content-txt", "specPath": "..." },
  "structureProfile": {
    "formatList": { "abs_content": ["68-72"], "catalog_h1": ["305-318"] },
    "skipped": []
  },
  "ops": [
    {
      "scope": {},
      "action": {
        "type": "batch_set_paragraph_props",
        "format_rule": {
          "apply_in_table": false,
          "rules": [
            {
              "source": { "tag": "abs_content" },
              "pPr": { "spacing": { "line": "20pt" }, "ind": { "firstLine": "2ch" } },
              "rPr": { "sz": 12, "rFonts": { "eastAsia": "宋体" } }
            }
          ]
        }
      }
    },
    {
      "scope": {},
      "action": {
        "type": "setup_toc_styles",
        "format_rule": {
          "tocStyle": {
            "levels": [
              {
                "level": 1,
                "pPr": { "ind": { "firstLine": "0pt" } },
                "rPr": { "sz": 12, "rFonts": { "eastAsia": "宋体" } }
              }
            ]
          }
        }
      }
    }
  ],
  "unsupportedRequirements": [],
  "changeSummary": {
    "scope": "全文",
    "issues": [],
    "changes": [],
    "skipped": [],
    "manualIssues": [],
    "stats": {}
  }
}
```
