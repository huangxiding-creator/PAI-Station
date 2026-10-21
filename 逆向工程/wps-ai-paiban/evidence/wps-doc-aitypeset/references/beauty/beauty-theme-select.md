# full 模式主体风格选择

配色与字号配套均属文档**主体**视觉风格，在本文件统一决策。**不 ask_user**。

- 排版基线：`beauty-default.yaml`
- 字号 / 行距 / 字体：`beauty-type-scales.yaml`
- 配色：`beauty-palettes.yaml`

自动美化只使用 3 套主题包，配色与字号必须成套选择；不要再把“正式黑色配色”和“现代/学术字号”自由组合。

---

## 自动主题目录

| themeId | label | 配套 scaleId | 默认使用边界 |
|---------|-------|--------------|--------------|
| `official-black` | 通用黑色 | `official-document` | **默认主题**。正式/通用办公文档、政务/会议/制度/通知/报告/总结/方案、合同式文本、打印交付文档、无法判断类型的普通文档 |
| `steel-blue` | 方案钢蓝 | `modern-steel` | 现代感文档：产品/项目方案、对外介绍、科技/互联网材料、轻量商业方案；必须有“现代、方案感、对外展示、科技感”等信号 |
| `personal-navy` | 藏青蓝 | `personal-navy` | 个人文档：日记、札记、读书笔记、个人复盘、实习/实践记录、思想汇报等克制个人记录 |

例外主题不参与自动默认：

| themeId | label | 触发条件 |
|---------|-------|----------|
| `derived-from-doc` | 沿用原文档配色 | 仅当用户明确说“按原文档配色 / 保留原配色 / 不改颜色” |
| `user-specified-color` | 用户指定色 | 仅当用户明确指定具体颜色；指定色只作为标题/强调辅助色，正文仍为黑色 |

`beauty-palettes.yaml` 提供 role → color；`beauty-type-scales.yaml` 提供 scaleId → fontSize / lineHeight / fontFamily。

---

## 输出 themeAssessment

```json
{
  "themeId": "official-black",
  "themeLabel": "通用黑色",
  "reason": "正式报告类文档，默认使用通用黑色配色"
}
```

写入规划 JSON 顶层 `themeAssessment`。

## 输出 scaleAssessment

```json
{
  "scaleId": "official-document",
  "scaleLabel": "通用字号",
  "confidence": "high",
  "signals": ["skeleton:报告", "正式文档"],
  "reason": "与通用黑色主题成套，正文宋体 12pt，首页大标题宋体加粗 18pt"
}
```

写入规划 JSON 顶层 `scaleAssessment`；`scaleId` 必须来自所选自动主题的配套 scale。`derived-from-doc` / `user-specified-color` 只改变配色来源，字号仍按三套自动主题之一选择，默认 `official-document`。

---

## 主题挑选顺序

1. 用户明确要求保留原配色 → `derived-from-doc`；字号按文档气质选择三套之一，无法判断则 `official-document`。
2. 用户明确指定颜色 → `user-specified-color`；指定色只用于标题/强调，不得让正文变成非黑色。
3. 有明确现代感/对外方案/科技产品/轻量商业展示信号 → `steel-blue` + `modern-steel`。
4. 有明确个人记录信号（日记、笔记、复盘、思想汇报、实习实践记录等）→ `personal-navy` + `personal-navy`。
5. 其他全部情况 → `official-black` + `official-document`。

正式/通用办公文档信号一旦成立，优先走 `official-black`，不得因为“报告、方案、工作总结”等词自动转入蓝色主题。

---

## 字体与字号策略

| 主题 | 标题 | 正文 | 数字/英文 | 正文主字号 |
|------|------|------|-----------|------------|
| 通用黑色 | 宋体加粗 | 宋体 | Times New Roman | 12pt（小四） |
| 方案钢蓝 | 宋体加粗 | 微软雅黑 | Arial | 12pt（小四） |
| 藏青蓝 | 宋体加粗 | 宋体 | Times New Roman | 12pt（小四） |

三套主题均使用 WPS 内置宋体加粗作为首页大标题。通用黑色主题遵循通用办公层级：首页大标题宋体加粗 18pt；一级标题黑体加粗 14pt；二级标题宋体加粗 13pt；三级/四级标题宋体加粗 12pt；正文宋体 12pt。正文行距统一收敛到 1.35 倍，标题段前/段后按小四正文比例收紧，以保持类似三号正文时期的协调密度。标题与正文都用黑色，页眉页脚等辅助信息可用灰色。

通用方案/报告若没有现代感信号，仍走通用黑色；只有用户或文档明确呈现现代展示气质时，才走方案钢蓝。

---

## 配色约束

- 正文、主送对象、列表正文必须为黑色。
- 正式/通用文档的标题、各级标题、正文、附件标题、落款/日期均为黑色；不要使用灰色标题。
- 页眉页脚、图表题注、引用说明等辅助信息可用灰色。
- 通用办公文档颜色不要超过 3 类：黑灰文字系统、红色/业务色强调系统、浅灰/浅米背景系统。
- 禁止大面积高饱和蓝、紫、橙、渐变色；业务色只能作辅助强调，不作正文主视觉。

---

## 禁止

- beauty-full 下 ask_user 选配色或字号配套。
- 自动选择 `steel-blue` 或 `personal-navy` 作为兜底主题。
- 对 `body` / `addressees` / `list-item` 使用非黑色。
- 段内为了句级强调写入不同于段落主体的 `color`。
- themeId / scaleId 超出本文件枚举；用户指定色与沿用原配色除外，但也必须保留正文黑色。