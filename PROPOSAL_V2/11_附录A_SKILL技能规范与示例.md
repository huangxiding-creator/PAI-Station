# 附录 A SKILL.md 技能规范全集（含三个完整示例技能）

## A.1 规范总则

技能是 PAI-Station 的可执行方法论单元。规范兼容 anthropics/skills（frontmatter 字段一致），扩展三个自有字段：`level`（Bloom 层级）、`triggers`（触发器声明）、`privacy`（数据接触级别）。

```markdown
---
name: weekly-report-pro           # 技能唯一名（kebab-case，市场检索键）
description: 按用户历史偏好生成周报初稿，结论前置、数据带出处   # 一句话，市场卡片文案
version: 1.3.0                    # 语义化版本
author: user@local 或 market-id
level: 3                          # Bloom 层级 1-6（调度器用于模型路由）
triggers:                         # 声明式触发（proactive 层订阅）
  - cron: "0 16 * * FRI"          # 每周五 16:00
  - event: calendar.meeting_end{tag=周会}
privacy: documents                # none/documents/contacts/org（File Guard 据此授权）
inputs:                           # 参数契约
  - name: week_range
    type: daterange
    default: last_week
outputs:
  - type: docx
    template: pydocx@9704-lite
---
# 周报技能

## 规则（distiller 自动蒸馏+人工可编辑）
1. 当生成周报时，第一段必须是本周结论，≤50 字（来源：用户近 12 次周报 11 次如此）。
2. 当引用数据时，必须附出处文件名（来源：领导 3 次追问出处）。
3. 当描述进展时，使用"已完成/进行中/受阻"三态词（用户习惯）。
4. 当写风险时，必须同时给对策（用户文风偏好）。

## 执行步骤
1. recall.query("本周 {week_range} 工作") 召回记忆 top 12
2. 按 Minto 金字塔组织：结论→分项→证据
3. glm-4-flash 起草（level=3 走系统 1），>2000 字切分生成
4. 应用个人规则库 rules/personal.ini 文风规则
5. 输出 docx 至抽屉，静默（重要不紧急象限）

## 反例（禁止）
- 第一段写背景铺垫（用户明确删除过 4 次）
- 出现"赋能/抓手"（用户黑名单词）
```

## A.2 示例技能二：红头文件（GB/T 9704）

```markdown
---
name: gov-doc-redheader
description: 生成符合 GB/T 9704-2012 的红头公文（通知/请示/报告）
level: 5
triggers:
  - command: "/公文"
privacy: org
inputs:
  - name: doc_type    # enum: 通知/请示/报告/函
  - name: subject
  - name: main_body_bullets   # array
outputs:
  - type: docx
    template: pydocx@9704-full
---
# 红头文件技能
## 规则
1. 版式：标题二号小标宋、正文三号仿宋_GB2312、行距 28-30 磅（GB/T 9704 表 2）
2. 结构：份号→密级→紧急程度→发文机关标志→发文字号→签发人→标题→主送机关→正文→附件说明→发文机关署名→成文日期→印章→附注→附件
3. 请示必须一文一事；报告不得夹带请示事项（公文处理条例）
4. 日期用阿拉伯数字（2012 版修订要点）

## 执行步骤
1. 校验 doc_type 与结构模板匹配
2. 组装正文：金字塔结构+公文特定语（"现将有关情况报告如下"）
3. python-docx 套版式模板（字号/字体/版头间距程序化）
4. 版式自检脚本核对 GB/T 9704 清单（17 项）
```

## A.3 示例技能三：合同风险审查

```markdown
---
name: contract-risk-scan
description: 扫描合同风险条款并输出带出处与修改建议的审查表
level: 5
triggers:
  - event: fs.new_file{ext=docx|pdf, dir=~\Desktop}
privacy: documents
inputs:
  - name: contract_path
outputs:
  - type: xlsx
    sheet: 风险清单
---
# 合同风险审查技能
## 规则
1. 逐条扫描九大风险区：主体资格/标的/价款与支付/违约责任/解除条款/知识产权/保密/争议解决/通知送达
2. 每条发现输出：条款原文引用→风险等级（高中低）→修改建议→法律依据（民法典条文号）
3. 缺失条款（如无保密条款）按"缺失项"单独列出
4. 使用 glm-4.7-flash 长上下文整文解析（>20 页），z1 对高风险条款复核

## 执行步骤
1. MarkItDown/MinerU 转 Markdown（保留条款编号）
2. glm-4.7-flash 结构化抽取条款树
3. 九区扫描（系统 2，reasoning=true）
4. xlsx 输出（风险清单 sheet+建议修订 sheet）
5. 高风险项同步企微推送（重要且紧急判定）
```

## A.4 技能生命周期状态机

```
drafting（样本<5，标"学习中"）→ stable（采纳率≥60%）
   ↑蒸馏迭代                          ↓连续 10 次 <40%
   └────── relearning ←── degrading ──┘
market 上架另需：scanner 通过 → 人工抽检 → published → (version 更新循环)
```
