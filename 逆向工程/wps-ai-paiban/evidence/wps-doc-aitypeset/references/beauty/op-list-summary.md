# Op List 摘要规范

> **beauty 路径默认不读本文件**。本文档供 **strict**、块数 >20、用户追问明细、或需完整 JSON `changeSummary` 时展开。

输出 op list 时，**必须同时给出变更摘要**。摘要回答「**发现了什么问题、改什么、改哪里、什么不动**」，而不是复述 beauty-default 模板。
## 正面原则

| 原则 | 说明 |
|------|------|
| **先问题、后方案** | 先写发现的问题，再写 op 如何解决 |
| **现状 → 改后** | 每条变更类型写 delta，不只写目标样式 |
| **可定位** | 带文档位置：章节名、条款首句、data-id |
| **区分变更类型** | 样式 / 结构 / 跳过 分开，不混在 role 计数里 |
| **跳过说原因** | 每个 skipped 块说明为何不动 |

## 文字摘要模板（必填）

```markdown
## 变更摘要

**状态**：`planned`（写回前）/ `applied`（写回后）
**模式**：beauty-full | beauty-incremental | strict
**范围**：全文 | 第 X 章 | …

### 发现的问题
- （问题 1，如：正文字号 14pt/15pt/12pt 混用，共 17 处）
- （问题 2，如：5 处连续空段）
- …

### 将要执行的变更（`planned`）/ 已执行的变更（`applied`）

| 变更类型 | 处数 | 现状 → 改后 | 示例位置 |
|----------|------|-------------|----------|
| 字号统一 | 17 | 14pt/15pt 混用 → 12pt | 「第一条…」正文（data-id 409-474） |
| 首行缩进 | 3 | 段首全角空格 → textIndent 2em | 第二条正文 |
| 对齐 | 2 | 居中 → 两端对齐 | 正文误居中段 |
| 删除空段 | 5 | 空段 → 删除 | 第三、四条之间 |

### 按文档位置（可选，块数少时必填）

- **合同标题**（2 处）：原 16pt 左对齐 → 18pt 黑体居中
- **第一条 总则** 正文（3 段）：字号/缩进统一，见上表
- **签署区**（2 处）：原左对齐 → 右对齐

### 不改动（N 块）

| data-id | 原因 |
|---------|------|
| 120-125 | 疑似表格碎片，无法安全分类 |
| 30-32 | unknown，confidence=low |

### 统计

- 操作总数：52（样式 47 / 结构 5）
- 跳过：7
- 冲突 reconcile：0
```

## JSON 字段 `changeSummary`

与 op list 同文件输出：

```json
{
  "mode": "beauty-full",
  "status": "planned",
  "ops": [],
  "changeSummary": {
    "scope": "全文",
    "issues": [
      "正文字号 14pt/15pt/12pt 混用（17 处）",
      "5 处连续空段"
    ],
    "changes": [
      {
        "type": "fontSize_unify",
        "count": 17,
        "from": "14pt/15pt 混用",
        "to": "12pt",
        "roles": ["body"],
        "examples": [
          { "dataId": "409-474", "snippet": "第一条…" }
        ]
      },
      {
        "type": "removeEmptyParagraph",
        "count": 5,
        "from": "空段",
        "to": "删除",
        "examples": [{ "dataId": "304-305", "snippet": "（空）" }]
      }
    ],
    "byLocation": [
      {
        "label": "合同标题",
        "dataIds": ["33-55", "56-63"],
        "delta": "16pt 左对齐 → 18pt 黑体居中"
      }
    ],
    "skipped": [
      { "dataId": "120-125", "reason": "疑似表格碎片" }
    ],
    "stats": {
      "totalOps": 52,
      "styleOps": 47,
      "structureOps": 5,
      "skippedBlocks": 7
    }
  }
}
```

## 从 op 反推摘要

生成摘要时 **聚合 oplist 条目**，按格式差异归类，禁止按 role 模板名罗列：

1. 读 Phase 2 前 overview detail / 当前块样式作为 **from**
2. 原子能力 `format_rule` / `element_style_rules` 中的目标格式作为 **to**
3. 相同 `from → to` 的 oplist 条目合并为一行，`count` 累加
4. 取 1～3 个 `examples`（data-id + skeleton 引文前 20 字）
5. 清理空段、清理段首字符等结构类原子能力单独列为结构类变更

## 一句话结论（摘要开头）

用一句话说清价值，例如：

> 将在 **47 处** 统一正文字号为 12pt 并规范缩进，**删除 5 个**多余空段；**7 块**（含表格区域）保持不动。

禁止以「总操作数 52 条」作为唯一结论。
