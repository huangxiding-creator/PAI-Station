# insert_table_of_contents / update_table_of_contents / delete_table_of_contents

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§公共数据结构。

## 用途

| action.type | 用途 |
|-------------|------|
| `insert_table_of_contents` | 插入目录；插入点由 `tocPr.insertAt` 控制 |
| `update_table_of_contents` | 更新目录；更新范围由 `tocPr.updateScope` 控制；无目录则自动插入 |
| `delete_table_of_contents` | 删除目录 |

共用：`scope: {}`；**oplist 内**参数经 `action.action.format.tocPr`（约束 #6）；直接单步调用时路径为 `action.format.tocPr`。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `action.action.format.tocPr` | 否 | 目录参数（oplist 内）；可省略使用默认值 |

| op | 独有 tocPr / 行为 |
|----|-------------------|
| `insert_table_of_contents` | `insertAt` 控制插入点；`deleteExisting` 默认 true；已有目录域则转更新 |
| `update_table_of_contents` | `updateScope`（见下）；`tocLevel`=-1 不变更；无目录则自动插入 |
| `delete_table_of_contents` | `deleteScope`（`all`/`first`）、`removeTitle`、`titlePattern`（默认 `^目\s*录$`） |

`updateScope`（`update_table_of_contents`）：

| 值 | 行为 |
|----|------|
| `"all"`（默认） | 刷新全部目录域；**忽略** `tabLeader`、`includePageNumbers` 等样式字段 |
| `"first"` | 仅更新第一个目录域；**可改**上述样式字段（须显式写出要改的键） |

仅有手动目录文本（非 TOC 域）时 `update_table_of_contents` 报错，须用 `insert_table_of_contents`。

**tocPr 共享字段**：

| 字段 | 默认 | 说明 |
|------|------|------|
| `tocLevel` | 3 | 收录标题级数 1~9 |
| `source` | `"headingStyle"` | `"headingStyle"` / `"outlineLvl"` |
| `contentType` | 0 | 0=AutoToc, 1=SmartToc, 2=AIToc, 3=PlaceHolderToc |
| `insertAt` | — | 插入位置，见下表（`insert_table_of_contents`） |
| `insertTitle` | true | 插入目录标题行 |
| `insertBreak` | false | 目录前分页 |
| `deleteExisting` | true | 插入前删旧目录域（`insert_table_of_contents`） |
| `updateScope` | `"all"` | 更新范围（`update_table_of_contents`） |
| `deleteScope` | `"all"` | 删除范围（`delete_table_of_contents`）：`all`/`first` |
| `removeTitle` | false | 删除时是否删标题段 |
| `titlePattern` | `^目\s*录$` | 删除时标题段匹配正则 |
| `tabLeader` | 1 | 0~5 或 `none`/`dot`/`hyphen`/`solid`/`heavy`/`middleDot`；改此项须 `updateScope:"first"` |
| `includePageNumbers` | true | 显示页码 |
| `rightAlignPageNumbers` | true | 页码右对齐 |
| `useHyperlinks` | true | 目录项可点击跳转 |
| `hidePageNumbersInWeb` | false | Web 视图隐藏页码 |

`insertAt`（`insert_table_of_contents`）：

| 字段 | 说明 |
|------|------|
| `mode` | `documentStart` / `beforeTag` / `afterTag` / `afterArea` / `paragraphIndex` |
| `tag` | `beforeTag`/`afterTag` 时必填；**areaFormatList** 键（如 `catalog`），非 formatList 的 `catalog_h1` |
| `areaKey` | `afterArea` 时必填 |
| `index` | `paragraphIndex` 时必填；1-based（>0） |

## 示例 JSON

### 插入目录（`beforeTag` 定位）

```json
{
  "scope": {},
  "action": {
    "type": "insert_table_of_contents",
    "action": {
      "format": {
        "tocPr": {
          "tocLevel": 3,
          "source": "headingStyle",
          "insertAt": { "mode": "beforeTag", "tag": "catalog" },
          "deleteExisting": true,
          "insertTitle": true,
          "tabLeader": "dot",
          "includePageNumbers": true,
          "rightAlignPageNumbers": true,
          "useHyperlinks": true
        }
      }
    }
  }
}
```

### 更新目录（改样式须 `updateScope: "first"`）

```json
{
  "scope": {},
  "action": {
    "type": "update_table_of_contents",
    "action": {
      "format": {
        "tocPr": {
          "updateScope": "first",
          "tabLeader": "solid",
          "includePageNumbers": true
        }
      }
    }
  }
}
```

### 删除目录

```json
{
  "scope": {},
  "action": {
    "type": "delete_table_of_contents",
    "action": {
      "format": {
        "tocPr": {
          "deleteScope": "all",
          "removeTitle": true,
          "titlePattern": "^目\\s*录$"
        }
      }
    }
  }
}
```

## 常见误用

- ❌ oplist 内写一层 `action.format.tocPr` — 须嵌套 `action.action.format.tocPr`（见约束 #6）
- ❌ 用 `update_table_of_contents` 改 `tabLeader` 等样式却 `updateScope:"all"` — 改样式须 `updateScope:"first"`
