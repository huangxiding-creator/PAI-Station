# rPr 字符属性参考

OOXML `w:rPr`（Run Properties）子元素，按标准顺序排列。

---

## 属性列表

| 属性名 | 类型 | XML 元素 | 说明 |
|--------|------|----------|------|
| `rStyle` | string | `w:rStyle` | 字符样式 ID |
| `rFonts` | object | `w:rFonts` | 字体 `{ascii, hAnsi, eastAsia, cs}` |
| `b` | boolean | `w:b` | 粗体 |
| `bCs` | boolean | `w:bCs` | 复杂字符粗体 |
| `i` | boolean | `w:i` | 斜体 |
| `iCs` | boolean | `w:iCs` | 复杂字符斜体 |
| `caps` | boolean | `w:caps` | 全部大写 |
| `smallCaps` | boolean | `w:smallCaps` | 小型大写字母 |
| `strike` | boolean | `w:strike` | 删除线 |
| `dstrike` | boolean | `w:dstrike` | 双删除线 |
| `outline` | boolean | `w:outline` | 空心字 |
| `shadow` | boolean | `w:shadow` | 阴影 |
| `emboss` | boolean | `w:emboss` | 阳文 |
| `imprint` | boolean | `w:imprint` | 阴文 |
| `noProof` | boolean | `w:noProof` | 禁用拼写/语法检查 |
| `snapToGrid` | boolean | `w:snapToGrid` | 对齐网格 |
| `vanish` | boolean | `w:vanish` | 隐藏文字 |
| `webHidden` | boolean | `w:webHidden` | Web 隐藏文本 |
| `color` | string/object | `w:color` | 字体颜色（6位十六进制 或 `"auto"`） |
| `spacing` | number | `w:spacing` | 字符间距（twips，正值加宽，负值紧缩） |
| `w` | number | `w:w` | 文字缩放比例（%） |
| `kern` | number | `w:kern` | 字距调整阈值（半磅） |
| `position` | number | `w:position` | 位置偏移（半磅，正上负下） |
| `sz` | number | `w:sz` | 字号（半磅值） |
| `szCs` | number | `w:szCs` | 复杂字符字号（半磅值） |
| `highlight` | string | `w:highlight` | 突出显示色 |
| `u` | string/object | `w:u` | 下划线 |
| `effect` | string | `w:effect` | 文本效果 |
| `bdr` | object | `w:bdr` | 字符边框 `{val, sz, space, color}` |
| `shd` | object | `w:shd` | 字符底纹 `{val, color, fill}` |
| `fitText` | number | `w:fitText` | 适应文字宽度（twips） |
| `vertAlign` | string | `w:vertAlign` | 上下标 |
| `rtl` | boolean | `w:rtl` | 从右到左文字 |
| `cs` | boolean | `w:cs` | 复杂文本 |
| `em` | string | `w:em` | 着重号 |
| `lang` | object | `w:lang` | 语言设置 `{val, eastAsia, bidi}` |
| `eastAsianLayout` | object | `w:eastAsianLayout` | 东亚文字布局 `{val, vert, vertCondense}` |
| `specVanish` | boolean | `w:specVanish` | 特殊消失 |
| `oMath` | boolean | `w:oMath` | Office 数学公式 |

---

## rFonts 子属性

| 子属性 | 说明 |
|--------|------|
| `eastAsia` | 中文字体：`"宋体"` `"黑体"` `"楷体"` `"仿宋"` |
| `ascii` | 西文字体：`"Times New Roman"` `"Arial"` |
| `hAnsi` | 高 ANSI 字体（不填则同 ascii） |
| `cs` | 复杂文种字体 |

---

## 字号对照

半磅值是磅值的2倍

| 中文字号 | 对应磅值 (pt) | 半磅值（w:sz中记录的） |
| :--- | :--- | :--- |
| 初号 | 42 | 84 |
| 小初 | 36 | 72 |
| 一号 | 26 | 52 |
| 小一 | 24 | 48 |
| 二号 | 22 | 44 |
| 小二 | 18 | 36 |
| 三号 | 16 | 32 |
| 小三 | 15 | 30 |
| 四号 | 14 | 28 |
| 小四 | 12 | 24 |
| 五号 | 10.5 | 21 |
| 小五 | 9 | 18 |
| 六号 | 7.5 | 15 |
| 小六 | 6.5 | 13 |
| 七号 | 5.5 | 11 |
| 八号 | 5 | 10 |

---

## highlight 可用色值

`yellow` `green` `cyan` `magenta` `blue` `red` `darkBlue` `darkCyan` `darkGreen` `darkMagenta` `darkRed` `darkYellow` `darkGray` `lightGray` `black`

## 下划线 u 可用样式

`single` `double` `thick` `dotted` `dashed` `dotDash` `dotDotDash` `wave` `none`

## vertAlign 可用值

`baseline` `superscript` `subscript`

## em 着重号可用值

`dot` `comma` `circle` `underDot` `none`

## effect 文本效果可用值

`blinkBackground` `lights` `antsBlack` `antsRed` `shimmer` `sparkle` `none`
