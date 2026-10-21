# Oplist 参数验证环对照报告

- **Plan**: `plan_import.json` | **Spec**: `spec_import.txt`
- **oplist 形态**: `import-batch` | **spec 输入模式**: `user-entered` | **换算来源**: `aipaiban`
- **verify role 数**: 1 | 总 op: 2 | 非格式 op: 无

## 概览（三态统计）

- **一致**: 4 | **无中生有**: 0（涉 0 个 role） | **缺失**: 0 | 另：不一致 0、待核 0
- **退出码**: 0（干净）

> 判定口径移植 verify-oplist-workflow.md：要求已写明→一致/不一致；要求未写而 oplist 有→无中生有；要求写了 oplist 没有→缺失。

## 逐 Role 对照

### abstract-title

**AI ops**: 1 条（tag: `abs_title` → target: `_Strict_abs_title`，style_name: `_Strict_abs_title`）
**内部一致性**: OK
**规范检索**:
- [录入1] 摘要标题：黑体三号，加粗，居中

| 参数 | oplist 值 | 规范要求 | 规范原文命中 | 判定 |
|---|---|---|---|---|
| 中文字体（fontFamily） | 黑体 | 黑体 | 「黑体」（录入1） | 一致 |
| 字号（fontSize） | 16pt | 三号=16pt | 「三号」（录入1） | 一致 |
| 加粗（bold） | 加粗 | 加粗 | 「加粗」（录入1） | 一致 |
| 对齐（textAlign） | center | center | 「居中」（录入1） | 一致 |

- **role 判定**: **一致**

## 汇总对照表（role | oplist 参数 | 规范原文 | 判定）

| role | oplist 参数 | 规范原文 | 判定 |
|---|---|---|---|
| abstract-title | fontFamily=黑体 | [录入1] 摘要标题：黑体三号，加粗，居中 | 一致 |
| abstract-title | fontSize=16pt | [录入1] 摘要标题：黑体三号，加粗，居中 | 一致 |
| abstract-title | bold=加粗 | [录入1] 摘要标题：黑体三号，加粗，居中 | 一致 |
| abstract-title | textAlign=center | [录入1] 摘要标题：黑体三号，加粗，居中 | 一致 |

## 无中生有清单

（无）

## 缺失清单（规范已写、oplist 未设置）

（无）
