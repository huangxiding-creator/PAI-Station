# 报告结构模板（六配件 + 章节骨架）

> 用途: `reports/<课题>/报告结构.md` 的初始骨架。章节按 12 章范式裁剪。
> 结构文件是"活的"——各章交付后按实际回填, 终稿以此无损合并。

```markdown
# {{报告全名}}

## 报告结构总览

| 序 | 部分 | 文件 | 字数 | 状态 |
|---|---|---|---|---|
| P0 | 严正声明 | parts/00-declaration.md | ≥500 | todo |
| P1 | 内容摘要 | parts/01-executive-summary.md | ≥3000 | todo |
| P2 | 研究方法说明 | parts/02-methodology.md | ≥1500 | todo |
| P3 | 报告价值说明 | parts/03-value.md | ≥1500 | todo |
| P4 | 推荐序 | parts/04-preface.md | ≥5000 | todo |
| C1 | 第1章 {{概念制度边界}} | chapters/01.md | ≥4500 | todo |
| C2 | 第2章 {{市场政策环境}} | chapters/02.md | ≥4500 | todo |
| C3 | 第3章 {{全周期识别框架}} | chapters/03.md | ≥4500 | todo |
| C4-C{{N-1}} | 分域展开章 | chapters/NN.md | ≥4500 | todo |
| C{{N}} | 第N章 {{评价预警与案例}} | chapters/{{NN}}.md | ≥4500 | todo |
| P5 | 术语表 | parts/05-glossary.md | — | todo |
| F | 终稿合并 | 终稿.md → 终稿.docx | 合计≥{{M}}万 | todo |

## 结构纪律（Manus 实证规则）

- 章为一级标题；**禁止"部分/Part"层级**出现在章序里
- 总章序号连续规范（自动序号防乱）
- 章节内容不重复；有重复取字数最多版本
- 各章 4 级标题深度 + 章末小结
- 参考资料只在章末, 不在正文段落里堆链接
- 更新直接改原文件, 不建 v2/v3 新文件

## 章节分解范式（12章通用骨架 · 按课题裁剪）

理论: 概念制度边界 → 环境: 市场政策监管 → 框架: 全生命周期识别
→ 分域×7: 前期设计 / 招标合同 / 技术接口 / 施工安全 / 生态社会 /
自然灾害 / 经济融资 (+供应链/数字化)
→ 收口: 评价预警应急 + 典型案例

## state.json 续跑台账（同目录）

{"topic":"…","prompt_hash":"…","chapters":{"01":{"status":"done","chars":4832,
"sources":12}, …},"gaps":["ch07 partial: 缺事故统计"],"target":{"chapters":12,
"total_chars":60000},"updated":"…"}
新会话读此文件即知进度, "继续"语义 = 补 gaps → 合并 → 自检 → 交付。
```
