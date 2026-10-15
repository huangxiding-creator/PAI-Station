# -*- coding: utf-8 -*-
"""density_check — m2 章节验收密度门旁挂脚本 (百倍V3 T-012R / REQ-014 / REQ-013).

接线方式 (旁挂, 不改动既有 m2_gate*.py 本体):
  m2 章节验收顺序 = 先跑本件 (密度门主判), 再跑既有 m2_gate.py / m2_gate2.py /
  m2_gate3*.py (锚点/own_calc/数字互引等断言全部保留不动):
      python density_check.py <chapter_md> [chapter_type]   # 本件, exit 0=pass / 1=reject
      python ../m2_gate.py  <chapter_md> [--target 6800]    # 既有门照旧
  章型 (精编/融合/原创) 自动从章首「三态：[精编]」标记推断, 抓不到时用第 2 参,
  缺省精编.

V3 口径 (REQ-013): 章字数带降为参考值 (随报告携带 floor 参考, 不判),
密度门主判 — 三判据 = gzip 冗余增量(1-NCD 前后半) / 新 n-gram 率 / slop 规则密度,
阈值表 reforge_factory/config/density_thresholds.json (样板分位数待标, 当前临时基线).

超标章打回记录追加: ResearchFactory-Eng/06 迭代优化/百倍V3_极致调研变现计划/
work/density_rejects.jsonl ({file,chapter,metrics,verdict,ts}).

usage: python density_check.py <chapter_md> [chapter_type]
exit : 0 = 密度门通过; 1 = 超标打回 (已落账); 2 = 用法/读取错误
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")   # 引擎层
import density_gate as dg                                    # noqa: E402


def infer_chapter_type(text: str) -> str:
    """从章首「三态：[精编]」标记推断章型; 未标注返回 None.

    1015 修宽: 实书章首为粗体/全角变体 (**三态**：[精编] / 三态＝［融合］),
    旧正则只认半角裸形 → 全部落默认精编 (潜伏 bug, 标定器实测暴露)."""
    m = re.search(r"三态[*＊=＝行]{0,3}\s*[：:=＝]?\s*[\[［]\s*([精融原][编合创])",
                  text[:800])
    return m.group(1) if m else None


def main(argv):
    if len(argv) < 2:
        print(__doc__)
        return 2
    md_path = Path(argv[1])
    try:
        text = md_path.read_text(encoding="utf-8")
    except OSError as e:
        print(f"READ_FAIL {md_path}: {e}")
        return 2
    ctype = (argv[2] if len(argv) > 2 else None) or infer_chapter_type(text) or "精编"

    v = dg.chapter_verdict(text, ctype, source_file=str(md_path))
    m = v["metrics"]
    ref = v["char_count_reference"]
    print(f"[density_gate] file={md_path} chapter_type={ctype} "
          f"cjk_chars={m['cjk_chars']}(参考,floor={ref['floor_per_type']})")
    print(f"  redundancy_ratio={m['redundancy_ratio']:.4f} "
          f"(<= {v['thresholds_used'].get('redundancy_ratio_max')})")
    print(f"  new_ngram_rate={m['new_ngram_rate']:.4f} "
          f"(>= {v['thresholds_used'].get('new_ngram_rate_min')})")
    print(f"  slop_hits={m['slop_hits']} density/kchar="
          f"{m['slop_density_per_kchar']:.4f} "
          f"(<= {v['thresholds_used'].get('slop_density_per_kchar_max')})")
    if v["verdict"] == "pass":
        print("VERDICT: PASS (密度门通过; 章字数带为参考值, REQ-013)")
        return 0
    for f in v["failed"]:
        print(f"REJECT_RULE: {f['rule']} value={f['value']} "
              f"{f['op']} {f['threshold']} 超标")
    print(f"VERDICT: REJECT (超标打回, 已落账 {dg.DEFAULT_REJECTS_PATH.name})")
    return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
