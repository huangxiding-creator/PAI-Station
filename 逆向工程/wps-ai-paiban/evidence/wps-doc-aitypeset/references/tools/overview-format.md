# overview 输出解析

通过 `wps_read` 冷启动获取全貌：

```js
(wps) => { return wps.overview() }
```

返回 Markdown/HTML 混排文本，分为 meta、skeleton、detail HTML、style index 四部分。读法见 `references/tools/wps_read_usage.md`。

## Meta 注释

```text
<!-- 377 元素 / textContent.length ~6759 / 41 种 class / GCP [0-5217]；... -->
<!-- skeleton: 116 blocks，中间省略 46（头尾保留） | detail HTML: 12/116 -->
```

| 字段 | 用途 |
|------|------|
| GCP 范围 | 文档字符全局范围 |
| blocks 总数 | 规划分批阈值（建议 >200 块时分 phase 执行） |
| 省略块数 | 中间段用 `wps_read` + `querySelector('[data-id="…"]')` 补 detail |

## Skeleton

每行一块段落：

```text
<p data-id="56-63"> "一、总 则"
<p data-id="63-159"> "为进一步加强基层党组织建设，提高基层党支部工作水平，依据《中国共产党普通高等学校基层组织工作条例》（…"
```

- **data-id**：`start-end`，GCP 范围，作为 op 的 primary target
- **引文**：块内文本摘要；空段可能无引文
- 定位方式：`querySelector('[data-id="56-63"]')` 或 `range(56, 63)`

## 与 A 源对齐

overview 的 `data-id` 与 `doc_element_recog` 回包 **格式一致**（`"start-end"`）。reconcile 时按 id 直接 join，无需 paraId 映射。段内拆分语义见 A 源 `splitHints`。

## Detail HTML

仅含前 N 块完整 DOM，例如：

```html
<p data-id="63-159" class="p8 style1" style="line-height:1.5;margin-top:0pt;margin-bottom:0pt;">
   <span data-id="63-158" class="r7">　　为进一步加强…</span>
   <object data-id="be-159-159"></object>
</p>
```

关注：

| 层级 | 用途 |
|------|------|
| `<p>` class + inline style | 段落级 op（setParaStyle / clearInline） |
| `<span>` class | run 级 op（setRunStyle） |
| `<object>` | 边界标记，不直接操作 |

inline style 与 class 同时存在时，执行前若需覆盖，先 `clearInline` 再 `setParaStyle`。

## Style index

```text
.r7          ×92  —       15pt
.normal      ×20  正文      left 12pt
.r6          ×18  —       bold 15pt
```

用于快速判断：字号档位是否过多（>3 档建议统一）、正文是否混用多种 class。

## 与 op target 的对应

```json
{ "target": { "dataId": "63-159" } }
{ "target": { "dataId": "63-159", "spanId": "63-158" } }
```

默认只 target 段落；改局部 run 时才加 `spanId`。
