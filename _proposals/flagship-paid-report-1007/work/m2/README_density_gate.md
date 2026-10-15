# m2 章节验收 · 密度门接线说明（百倍V3 T-012R / REQ-014 / REQ-013）

> V3：章字数带降为参考值，密度门主判。

## 接线方式（旁挂，不改既有门）

m2 章节验收链新增前置步骤——**m2_gate 验收前先跑本件**：

```bash
cd E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2
python density_check.py <chapter_md> [chapter_type]   # 先：密度门主判，exit 0=pass / 1=reject
python ../m2_gate.py  <chapter_md> [--target 6800]    # 后：既有字数带/锚点/own_calc/黑话门照旧
python ../m2_gate2.py <chapter_md> <bank_txt>         # 既有数字互引门照旧
python ../m2_gate3*.py …                              # 既有融合章互引门照旧
```

- `density_check.py` 为旁挂脚本，**不改动既有 m2_gate*.py 任何断言**（字数带在
  m2_gate 里仍打印，但 V3 起仅作参考值）。
- 章型（精编/融合/原创）自动从章首「三态：[精编]」标记推断，抓不到时传第 2 参，
  缺省精编。

## 三判据（引擎：`E:/AI-Station/reforge_factory/density_gate.py`）

| 指标 | 公式（标准库 zlib raw-deflate / 正则） | 方向 |
|------|----------------------------------------|------|
| gzip 冗余增量 | `1 - NCD(A,B)`，A/B=章汉字流前 8000 字的 UTF-8 等长前后半，`NCD=(C(A+B)-min(CA,CB))/max(CA,CB)` | 高=冗余，超 max 打回 |
| 新 n-gram 率 | 非骨架去重 2/3-gram 类型数 / n-gram token 总数（骨架=冻结中文虚词集） | 低=多样性差，低于 min 打回 |
| slop 规则密度 | 内置 24 条中文套话正则命中 / 千汉字（`slop_hits` 原值随报告） | 高=套话堆砌，超 max 打回 |

阈值表：`E:/AI-Station/reforge_factory/config/density_thresholds.json`（每次判定
现读，可热改）。**黄金样板分位数标定位待标，当前值=临时基线（保守启发）**。

## 打回落账

超标章自动追加 `ResearchFactory-Eng/06 迭代优化/百倍V3_极致调研变现计划/work/
density_rejects.jsonl`，字段 `{file, chapter, metrics, verdict, ts}`。
