# EPC-TOP50 第 11 份 · S2 写作阶段武器清单（一行命令一件）

> 用法: S2 编辑段直接引用本清单逐件调用; 全部武器产日志件 (只增), 数字零造假。
> 产物均落在章节件同目录 (`<chapter>.<武器>.md/.json`), 便于逐章归档。

## 1. S&P 记分卡 (五维双仪表 AAA..D — 章节级可信度体检)

```
py -X utf8 E:/AI-Station/reforge_factory/sp_scorecard.py --chapter <chNN.md> --bank <bank_chNN.md> --campaign EPC-TOP50
```

可选 `--no-llm` (纯确定性口径)。产物: `<chapter>.sp_scorecard.md/.json` + `reforge_factory/sp_scorecard_log.jsonl`。
参考基线: ch01=BBB 3.78 (bank 可溯 97%) / EPC-TOP50 华东院件=BB 3.17 (1028 P2 实测)。

## 2. Claim 级核查链 (句级三态: 可溯/存疑/造假)

```
py -X utf8 E:/AI-Station/reforge_factory/claim_verifier.py --chapter <chNN.md> --bank <bank_chNN.md>
```

可选 `--out/--json` 定制产物路径, `--max-rows 0` 全量。产物: `<chapter>.claim_verdict.md/.json`。

## 3. 牛熊对抗辩论 (多空双视角 + 裁决)

```
py -X utf8 E:/AI-Station/reforge_factory/adversarial_review.py --chapter <chNN.md> --bank <bank_chNN.md> --sections 3
```

可选 `--max-section-chars 6000` 分段上限。产物: `<chapter>.adversarial.md/.json` + `reforge_factory/adversarial_review_log.jsonl`。

---

## 附: S2 阶段可直接复用的 S1 资产指针

- 弹药池: `E:/AI-Station/ammo_pool/EPC-TOP50/` (T1=28,676,440 fulltext_v2; manifest 652 行)
- 问题树: `E:/AI-Station/ammo_pool/EPC-TOP50/question_tree.json` (78 EEI, 饱和 68/78=87.2%)
- 图谱查询 (LightRAG, 3,071 实体/2,157 关系; 注意走 .venv 解释器):
  `E:/AI-Station/.venv/Scripts/python.exe -X utf8 E:/AI-Station/reforge_factory/graph_rag.py query --campaign EPC-TOP50 --question "<问题>" --mode global`
- 数仓序列 (八大央企营收等, engine=warehouse 已挂 Q17-E1):
  `py -X utf8 E:/AI-Station/reforge_factory/legs/warehouse_leg.py --campaign EPC-TOP50 --tree Q17-E1 --queries "<公司名>近5年营收序列"`
- 多视角问题框架 (STORM 4 persona×8 问): `E:/AI-Station/reforge_factory/completeness/storm_efdf1aec.md` (NBLM Phase 0 自动前置)
- 麦肯锡七步立题卷: `E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/top50/S-1-选题案卷.mckinsey_gate.md` (7/7 PASS)
