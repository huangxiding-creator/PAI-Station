# setup_page_setup

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定、§scope。

## 用途

纸张/边距/方向。scope 必填；`pgSz`/`pgMar` 为**带单位字符串**。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.sectPr` | 是 | 节级页面属性；单位见 [atomic-ops.md §单位约定](../atomic-ops.md) |

| sectPr 字段 | 说明 |
|-------------|------|
| `pgSz.w` / `pgSz.h` | 纸宽/纸高，**必须为带单位字符串**，如 A4 纵向 `"595.3pt"`×`"841.9pt"` |
| `pgSz.orient` | `portrait`/`landscape`；须在 `pgSz` 内（OOXML 规范） |
| `pgMar.top/bottom/left/right` | 页边距，字符串带单位，如 `"72pt"`（≈2.54cm） |
| `pgMar.header/footer/gutter` | 页眉/页脚距边、装订线（可选） |

> 纯数值（如 `11906`）会被静默忽略；必须用 `"595.3pt"` 等形式。

## 示例 JSON

### A4 纵向 + 页边距

```json
{
  "scope": {},
  "action": {
    "type": "setup_page_setup",
    "format_rule": {
      "sectPr": {
        "pgSz": { "w": "595.3pt", "h": "841.9pt", "orient": "portrait" },
        "pgMar": { "top": "72pt", "bottom": "72pt", "left": "90pt", "right": "90pt" }
      }
    }
  }
}
```

### 仅第 1 节横向

```json
{
  "scope": { "start": { "type": "section", "index": 1 }, "end": { "type": "section", "index": 1 } },
  "action": {
    "type": "setup_page_setup",
    "format_rule": {
      "sectPr": {
        "pgSz": { "w": "841.9pt", "h": "595.3pt", "orient": "landscape" },
        "pgMar": { "top": "72pt", "bottom": "72pt", "left": "72pt", "right": "72pt" }
      }
    }
  }
}
```
