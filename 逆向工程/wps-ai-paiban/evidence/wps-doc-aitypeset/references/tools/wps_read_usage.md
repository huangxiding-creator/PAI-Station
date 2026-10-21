# wps_read 工具用法介绍

## 功能

`wps_read` 是用于读取聚焦文档（左侧 WPS 文字文档）内容的工具。返回 HTML 格式的文档骨架、段落细节和样式信息。是所有文档编辑操作的前置步骤——**动手前先读取**。

## 参数

只有一个参数 `code`，是一个 **JS 函数体**，签名固定为 `(wps) => { ... }`，**必须 return 结果**（通常是字符串）。

## 可用成员

`wps` 对象提供以下成员，**使用前必须先解构**：

| 成员 | 用途 |
|------|------|
| `doc` | 只读文档对象，用于 `querySelector` 等查询 |
| `overview()` | 返回文档骨架（skeleton）、detail HTML、样式索引的字符串地图 |
| `range(start, end)` | 按 GCP 范围获取顶层内容块数组 |
| `css(target?)` | 查询 `<style>` 规则体 |

## 典型用法

### 1. 冷启动 — 获取文档全貌（第一步永远是这个）

```js
(wps) => { return wps.overview() }
```

返回内容包含三层：

- **skeleton**：全文骨架，每块一行 `<tag data-id="start-end">`，类似目录
- **detail HTML**：头部若干块的完整 HTML（含 class、style 等）
- **style index**：文档中使用的样式语义索引

### 2. 读取指定范围的原始 HTML

```js
(wps) => {
  const { doc, range } = wps
  const blocks = range(100, 500)
  return blocks.map(b => b.outerHTML).join('\n')
}
```

### 3. 查询样式规则

```js
(wps) => {
  const { css } = wps
  return css('.p8')
}
```

### 4. 读取省略块 / 单块 detail（skeleton 未展开或需要样式现状）

overview 的 detail HTML 仅含头部若干块；生成变更摘要、提取 baseline 时，可用 `wps_read` 按 `data-id` 或 GCP 范围补读当前块 detail。

**按 data-id 读单块**（推荐，`data-id` 即 `"start-end"`）：

```js
(wps) => {
  const { doc } = wps
  const el = doc.querySelector('[data-id="63-159"]')
  return el ? el.outerHTML : ''
}
```

**按 GCP 范围读多块**（从 `data-id` 解析 `start`、`end`）：

```js
(wps) => {
  const { range } = wps
  return range(63, 159).map(b => b.outerHTML).join('\n')
}
```

**批量补读**（skeleton 中间省略段）：对目标 `data-id` 列表逐块 querySelector，或合并为连续 range 一次读取。

## 定位方式

- 通过 `data-id` 定位：`doc.querySelector('[data-id="63-159"]')`
- 通过标签定位：标题就是 `<h1>`~`<h6>`
- **不要用 class 定位**（class 是排版类，如 `p2`、`r3`，会撞错块）

## 注意事项

- **每次用户新消息后必须重新读取**，文档状态可能已变化
- `range()` 返回的是裸 `<p>/<h*>` 元素，不含 `<ol>/<ul>/<li>` 外壳
- 连读多次仍无进展应停下来向用户澄清
- 用户发新消息后必须重新 `overview()`，不能复用旧结果
