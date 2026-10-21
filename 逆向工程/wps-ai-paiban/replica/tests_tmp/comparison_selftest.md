# Oplist 参数验证环对照报告

- **Plan**: `plan_selftest.json` | **Spec**: `spec_selftest.txt`
- **oplist 形态**: `strict-props` | **spec 输入模式**: `user-entered` | **换算来源**: `aipaiban`
- **verify role 数**: 2 | 总 op: 1 | 非格式 op: 无

## 概览（三态统计）

- **一致**: 10 | **无中生有**: 1（涉 1 个 role） | **缺失**: 0 | 另：不一致 0、待核 0
- **无中生有涉及 role**: body
- **退出码**: 1（存在无中生有）

> 判定口径移植 verify-oplist-workflow.md：要求已写明→一致/不一致；要求未写而 oplist 有→无中生有；要求写了 oplist 没有→缺失。

## 逐 Role 对照

### heading-1

**AI ops**: 1 条 rule（tag: `catalog_h1`，op: `batch_set_paragraph_props`）
**内部一致性**: OK
**规范检索**:
- [录入2] 一级标题：黑体三号，居中，段前12磅，段后6磅，行距固定值20磅

| 参数 | oplist 值 | 规范要求 | 规范原文命中 | 判定 |
|---|---|---|---|---|
| 中文字体（fontFamily） | 黑体 | 黑体 | 「黑体」（录入2） | 一致 |
| 字号（fontSize） | 16pt | 三号=16pt | 「三号」（录入2） | 一致 |
| 对齐（textAlign） | center | center | 「居中」（录入2） | 一致 |
| 段前（marginTop） | 12pt | 12pt | 「段前12磅」（录入2） | 一致 |
| 段后（marginBottom） | 6pt | 6pt | 「段后6磅」（录入2） | 一致 |
| 行距（lineHeight） | 20pt | 20pt | 「行距固定值20磅」（录入2） | 一致 |

- **role 判定**: **一致**

### body

**AI ops**: 1 条 rule（tag: `main_text`，op: `batch_set_paragraph_props`）
**内部一致性**: OK
**规范检索**:
- [录入3] 正文：宋体，两端对齐，首行缩进2字符，1.5倍行距

| 参数 | oplist 值 | 规范要求 | 规范原文命中 | 判定 |
|---|---|---|---|---|
| 中文字体（fontFamily） | 宋体 | 宋体 | 「宋体」（录入3） | 一致 |
| 字号（fontSize） | 22pt | （未写明） | — | 无中生有 |
| 对齐（textAlign） | justify | justify | 「两端对齐」（录入3） | 一致 |
| 行距（lineHeight） | 1.5倍行距 | 1.5倍行距 | 「1.5倍行距」（录入3） | 一致 |
| 首行缩进（textIndent） | 2字符 | 2字符 | 「首行缩进2字符」（录入3） | 一致 |

- **role 判定**: **无中生有**

## 汇总对照表（role | oplist 参数 | 规范原文 | 判定）

| role | oplist 参数 | 规范原文 | 判定 |
|---|---|---|---|
| heading-1 | fontFamily=黑体 | [录入2] 一级标题：黑体三号，居中，段前12磅，段后6磅，行距固定值20磅 | 一致 |
| heading-1 | fontSize=16pt | [录入2] 一级标题：黑体三号，居中，段前12磅，段后6磅，行距固定值20磅 | 一致 |
| heading-1 | textAlign=center | [录入2] 一级标题：黑体三号，居中，段前12磅，段后6磅，行距固定值20磅 | 一致 |
| heading-1 | marginTop=12pt | [录入2] 一级标题：黑体三号，居中，段前12磅，段后6磅，行距固定值20磅 | 一致 |
| heading-1 | marginBottom=6pt | [录入2] 一级标题：黑体三号，居中，段前12磅，段后6磅，行距固定值20磅 | 一致 |
| heading-1 | lineHeight=20pt | [录入2] 一级标题：黑体三号，居中，段前12磅，段后6磅，行距固定值20磅 | 一致 |
| body | fontFamily=宋体 | [录入3] 正文：宋体，两端对齐，首行缩进2字符，1.5倍行距 | 一致 |
| body | fontSize=22pt | [录入3] 正文：宋体，两端对齐，首行缩进2字符，1.5倍行距 | 无中生有 |
| body | textAlign=justify | [录入3] 正文：宋体，两端对齐，首行缩进2字符，1.5倍行距 | 一致 |
| body | lineHeight=1.5倍行距 | [录入3] 正文：宋体，两端对齐，首行缩进2字符，1.5倍行距 | 一致 |
| body | textIndent=2字符 | [录入3] 正文：宋体，两端对齐，首行缩进2字符，1.5倍行距 | 一致 |

## 无中生有清单

| role | 字段 | oplist 值 | 说明 |
|---|---|---|---|
| body | fontSize | 22pt | 规范检索结果未写明该属性 |

## 缺失清单（规范已写、oplist 未设置）

（无）
