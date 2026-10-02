# Skill-Fusion R2 实施台账

提案: [PROPOSAL.md](PROPOSAL.md) (scorecard 0.833 proceed, 用户 2026-09-26 批准全量实施)
每阶段验收判据实测后进下一段; 本台账只记实测, 不记意图。

## P0 — 输出侧三门闸 (2026-09-26 完成)

### 包A 审计腿 `EPC100/epc100_audit/` ✅
- verdicts.py 六值状态机 (PASS/WARN/FAIL/NOT_APPLICABLE/BLOCKED/ERROR, 禁留空禁SKIP)
- denominator.py 审计分母: 真实中核终稿 667 对象 (number 200 / causal 319 /
  prediction 6 / superlative 90 / year 52) + 55 源 + 占位符 + 主观行
- verify_l0.py L0 互查: 引用绑定/语料存在性/量纲冲突/百分位 sanity/占位符(永远FAIL)/主观行
- ledger.py 双账本 (claims_ledger 667 行 / source_ledger 55 行, 禁 not_checked 空洞)
- run_audit.py STALE 重哈希 (改稿→旧审计轮转 stale_*.json, 只增不删)
- validate_report.py 交付结构契约 (六必备章 + ban 模式 + 强词来源绑定)
- 单测 19/19 绿; 诚实基线: 51% (341/667) 对象无引用 — 观察模式 (advisory) 首月

### 包B 交付门 `epc100_audit/deliver_gate.py` ✅
- 四腿: stale_audit (md指纹↔AUDIT_REPORT) / placeholder_docx (unzip实体扫描) /
  result_match (md章数↔docx章级Heading1 同口径对账) / render_pdf (KWPS/Word COM
  后台导PDF + PyMuPDF 页数地板≥5)
- 真机实锤坑: ① COM 只认绝对路径 (相对路径静默失败→渲染腿假WARN) ② result_match
  必须同口径 (docx Heading1 含前置件, 只数「第X章」否则每次假阳 14≠19)

### 包C 样式门 `epc100_audit/style_gate.py` ✅
- h3禁令(硬FAIL)/标题禁词/章末bullet禁/薄章地板/图表双向对账(断图硬FAIL)/
  千分位advisory + validate 并入 (必备章+ban+强词)
- 稳定 Slot ID 差距表 style_gap.csv (13 槽, 槽号只增不改号)

### 接线 `pipeline/epc100_postchain.py` ✅
- main() 4.5 步 run_quality_gates: 审计→样式→交付三门, 输出落
  08 质量飞轮成果/gates/ (AUDIT_REPORT/STYLE_REPORT/DELIVER_REPORT/
  GATES_SUMMARY + 双账本 + 差距表 + 渲染PDF); FAIL → return 1 拦发布;
  单门崩溃 → BLOCKED 拦发布 (no silent failure)
- conftest.py 子目录元组 + "epc100_audit"

### 验收判据实测 ①-④ ✅
- ① 审计分母在真实成稿跑出: 667 对象/55 源/六值全覆盖零空白 (P0 完成时)
- ② 人为改一个数字 (739→731) → stale_audit FAIL, exit 1 ✓ (沙箱副本演练,
  原稿未动)
- ③ docx 埋「待补充」→ placeholder_docx FAIL, exit 1 ✓ (单测真注入 zipfile 实证)
- ④ 首批 Slot ID 差距表 ✓: 终稿跑出 13 槽全实值 — 版权/简介/序/版本记录 4 槽
  missing (终稿阶段本就没有, 交付版组装补齐→下游 covered), h3 222 处 FAIL
  (排版源归一消灭对象), 标题禁词 3 行/章末bullet 1章/大数 9 处 WARN
- 真机渲染门: KWPS.Application 后台 (Visible=False 不弹窗) 渲染真实 14.3 万字
  定稿 → 244 页 PDF, render_pdf PASS; 全链干净审计四腿全 PASS exit 0
- 测试: test_audit_leg 19 + test_gates 16 = 35/35 绿

### 工具栈探明 (供后续复用)
- soffice/libreoffice 不在 PATH; WPS COM (KWPS.Application) HKCU 在位可用
- PyMuPDF 1.28.2 / python-docx / pywin32 在 venv 在位

## 环境备注
- SkillSpector uv 安装重试仍 build failure (兜底: 直装件入库前跑凭据正则扫描)
- 沙箱证据: EPC100/data/audit_runs/cnpec_gates/ + cnpec_stale_test/ (只增不删)
