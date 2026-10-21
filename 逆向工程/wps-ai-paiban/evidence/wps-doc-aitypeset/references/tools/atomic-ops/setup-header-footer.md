# setup_header_footer

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定。

## 用途

页眉/页脚/页码。scope 忽略；按 target 定位节；同 variant 页眉/页脚不可同时 `pageNumber.show`。

按节写入页眉/页脚内容及页码。通过 `format_rule.rules[].target` 定位节。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.rules` | 是 | 规则数组，至少一条 |
| `format_rule.defaults` | 否 | 与各 rule 深度合并的默认 payload |
| `rules[].target` | 是 | 节定位：`{ tag }`（formatList 键）/ `{ section }` / `{ sectionFrom, sectionTo }` |
| `rules[].sectionFlags` | 否 | `differentFirstPage`、`oddAndEvenPages`、`linkToPrevious` |
| `rules[].headers` / `rules[].footers` | 否 | 按 variant 键：`default`/`first`/`even` |

**variant 部分字段**（`headers.default` 等）：

| 字段 | 默认 | 说明 |
|------|------|------|
| `mode` | `"skip"` | `"skip"`/`"clear"`/`"set"`；写入须 `"set"`（见 [atomic-ops.md §常见误用](../atomic-ops.md)） |
| `text` | — | 页眉/页脚纯文本 |
| `pPr` / `rPr` | — | 段落/字符格式；单位见 [atomic-ops.md §单位约定](../atomic-ops.md) |
| `borderLine` | — | 仅 headers：页眉下划线 `{ show, style, width, color }` |

**`pageNumber` 字段**：

| 字段 | 默认 | 说明 |
|------|------|------|
| `show` | true | 省略键=保持原页码域；`show=false`=删除已有页码域 |
| `format` | `"arabic"` | `arabic`/`romanUpper`/`romanLower`/`letterUpper`/`letterLower`/`pageX`/`pageXOfY` |
| `align` | `"center"` | `"left"`/`"start"`/`"center"`/`"right"`/`"end"` |
| `start` | 1 | 起始页码 |
| `restart` | false | 本节重新编号 |
| `replaceExisting` | true | 替换已有页码域 |
| `decor.prefix` / `decor.suffix` | — | 页码前后装饰文字 |
| `decor.fullWidthSpace` | false | 装饰文字两侧加全角空格 |
| `rPr` | — | 页码字符格式 |


## 约定
如无特殊要求，页眉/页脚/页码，都默认居中。有特殊要求，按照要求的位置对齐


## 示例 JSON

### 首页罗马页码 + 正文阿拉伯页码重启

```json
{
  "scope": {},
  "action": {
    "type": "setup_header_footer",
    "format_rule": {
      "rules": [
        {
          "target": { "sectionFrom": 1, "sectionTo": 1 },
          "footers": {
            "default": {
              "mode": "set",
              "pageNumber": { "show": true, "format": "romanUpper", "align": "center" }
            }
          }
        },
        {
          "target": { "tag": "catalog_h1" },
          "footers": {
            "default": {
              "mode": "set",
              "pageNumber": { "show": true, "format": "arabic", "restart": true, "start": 1 }
            }
          }
        }
      ]
    }
  }
}
```

### 页眉文字 + 下划线 + 页脚页码

```json
{
  "scope": {},
  "action": {
    "type": "setup_header_footer",
    "format_rule": {
      "defaults": {
        "headers": { "default": { "mode": "set", "rPr": { "sz": 9 } } },
        "footers": { "default": { "mode": "set", "rPr": { "sz": 9 } } }
      },
      "rules": [
        {
          "target": { "section": 1 },
          "headers": {
            "default": {
              "mode": "set",
              "text": "XX 大学硕士学位论文",
              "pPr": { "jc": "center" },
              "borderLine": { "show": true, "style": "single", "width": "0.5pt", "color": "#000000" }
            }
          },
          "footers": {
            "default": {
              "mode": "set",
              "pageNumber": {
                "show": true,
                "format": "pageXOfY",
                "align": "center",
                "decor": { "prefix": "第 ", "suffix": " 页", "fullWidthSpace": true }
              }
            }
          }
        }
      ]
    }
  }
}
```

## 常见误用

- ❌ 写了 `text`/`pageNumber` 却省略 `mode` — 默认 `"skip"` 不写入，写入须 `"mode": "set"`
- ❌ 同一 variant 下 `headers` 与 `footers` 同时 `pageNumber.show=true`
- ❌ `linkToPrevious=true` 且 `section>1` 时 variant `mode` 非 `skip`
- ❌ "正文开始设页眉"不查找正文的节号，直接`sectionFrom: 1`，`1`不一定是正文的节号，可能有封面或目录

## 节定位指引

优先用 `target.tag` 定位节（引擎自动将 tag 段落范围与节求交，无需知道具体节号）：

1. **首选 `target.tag`**：formatList 中有 `main_text`（正文）、`catalog_h1`（一级标题）等 tag → 直接用 `"target": { "tag": "main_text" }`
2. **兜底 `sectionFrom/sectionTo`**：仅当 formatList 无合适 tag 时，查 `structureProfile` 确认节号后用 `"target": { "section": N}`

### 正文节起设页眉（tag 定位）

```json
{
  "scope": {},
  "action": {
    "type": "setup_header_footer",
    "format_rule": {
      "rules": [
        {
          "target": { "tag": "main_text" },
          "sectionFlags": { "differentFirstPage": false, "oddAndEvenPages": false, "linkToPrevious": false },
          "headers": {
            "default": {
              "mode": "set",
              "text": "XX大学毕业论文",
              "pPr": { "jc": "center" }
            }
          }
        }
      ]
    }
  }
}
```
