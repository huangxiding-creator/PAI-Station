# Oplist 参数验证环对照报告

- **Plan**: `plan_mismatch.json` | **Spec**: `spec_mismatch.txt`
- **oplist 形态**: `strict-props` | **spec 输入模式**: `user-entered` | **换算来源**: `aipaiban`
- **verify role 数**: 1 | 总 op: 1 | 非格式 op: 无

## 概览（三态统计）

- **一致**: 1 | **无中生有**: 0（涉 0 个 role） | **缺失**: 2 | 另：不一致 1、待核 0
- **退出码**: 2（仅存在不一致）

> 判定口径移植 verify-oplist-workflow.md：要求已写明→一致/不一致；要求未写而 oplist 有→无中生有；要求写了 oplist 没有→缺失。

## 逐 Role 对照

### heading-1

**AI ops**: 1 条 rule（tag: `catalog_h1`，op: `batch_set_paragraph_props`）
**内部一致性**: OK
**规范检索**:
- [录入1] 一级标题：黑体四号，加粗，行距固定值22磅

| 参数 | oplist 值 | 规范要求 | 规范原文命中 | 判定 |
|---|---|---|---|---|
| 中文字体（fontFamily） | 黑体 | 黑体 | 「黑体」（录入1） | 一致 |
| 字号（fontSize） | 16pt | 四号=14pt | 「四号」（录入1） | 不一致 |
| 行距（lineHeight） | （oplist 未设置） | 22pt | 「行距固定值22磅」（录入1） | 缺失 |
| 加粗（bold） | （oplist 未设置） | 加粗 | 「加粗」（录入1） | 缺失 |

- **role 判定**: **不一致**

## 汇总对照表（role | oplist 参数 | 规范原文 | 判定）

| role | oplist 参数 | 规范原文 | 判定 |
|---|---|---|---|
| heading-1 | fontFamily=黑体 | [录入1] 一级标题：黑体四号，加粗，行距固定值22磅 | 一致 |
| heading-1 | fontSize=16pt | [录入1] 一级标题：黑体四号，加粗，行距固定值22磅 | 不一致 |
| heading-1 | lineHeight=（oplist 未设置） | [录入1] 一级标题：黑体四号，加粗，行距固定值22磅 | 缺失 |
| heading-1 | bold=（oplist 未设置） | [录入1] 一级标题：黑体四号，加粗，行距固定值22磅 | 缺失 |

## 无中生有清单

（无）

## 缺失清单（规范已写、oplist 未设置）

| role | 字段 | 规范要求 | 规范原文命中 |
|---|---|---|---|
| heading-1 | lineHeight | 22pt | 「行距固定值22磅」（录入1） |
| heading-1 | bold | 加粗 | 「加粗」（录入1） |
