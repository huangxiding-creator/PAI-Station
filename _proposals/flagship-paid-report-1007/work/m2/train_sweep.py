# -*- coding: utf-8 -*-
"""bid26_sweep — 主编独立复验器 (BID26 S2; 零采信写手自报).

两查/章:
  ① 密度门复跑 (density_check.py 现读 v2 标定阈值)
  ② 锚点数字门 (gate2 式): 章内数字句 (含 3+ 位数字或数字+单位/年/条/号)
     抽取 → 逐个在对应 bank 中查找; own_calc 标注豁免;
     报告 未命中锚点清单 (UNANCHORED) — >0 即 FAIL (写手须补锚或改 own_calc)。

用法: py -X utf8 .../work/m2/bid26_sweep.py [--chapter N]
"""
from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[4]
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2"
BID = M2 / "train"

NUM_RE = re.compile(
    r"\d+(?:\.\d+)?\s*(?:万亿元|亿元|万元|亿|万|元|%|％|家|条|个|项|件|人|"
    r"次|起|例|宗|号|年|月|日|页|款|项)")
OWN_CALC = "own_calc"


def anchors_missing(text: str, bank: str, chapter: Path) -> list[str]:
    """两段核验: ①bank 节选 ②未中者回源全文 (章内引用的 P 锚对应源文件)."""
    cited: list[Path] = []
    for m in re.finditer(r"^## (P\d+)", bank, re.M):
        pid = m.group(1)
        sm = re.search(rf"^## {pid} .*\n> 源: (.+?) \|", bank, re.M)
        if sm:
            cited.append(Path(sm.group(1).strip()))
    miss = []
    for para in re.split(r"\n+", text):
        if OWN_CALC in para:
            continue
        for m in NUM_RE.finditer(para):
            tok = re.sub(r"\s", "", m.group(0))
            # 3 年/2026 年类年份与序号 3 条粗粒度豁免 (噪声大), 只核实质量词
            if re.fullmatch(r"\d{1,2}(条|个|项|款|年)", tok):
                continue
            if tok in bank or tok.replace("年", "") in bank:
                continue
            hit_src = False
            for sp in cited:
                try:
                    if tok in sp.read_text(encoding="utf-8", errors="replace"):
                        hit_src = True
                        break
                except OSError:
                    continue
            if not hit_src:
                miss.append(f"{tok} | {para[:44]}")
    return miss


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    only = None
    if "--chapter" in sys.argv:
        only = sys.argv[sys.argv.index("--chapter") + 1].zfill(2)
    files = sorted(BID.glob("ch*.md"))
    if only:
        files = [f for f in files if f.stem[2:4] == only]
    n_pass = 0
    for f in files:
        text = f.read_text(encoding="utf-8")
        bank_fp = BID / f"bank_{f.stem}.md"
        bank = bank_fp.read_text(encoding="utf-8") if bank_fp.exists() else ""
        r = subprocess.run(
            ["py", "-X", "utf8", str(M2 / "density_check.py"), str(f)],
            capture_output=True, text=True, timeout=120)
        density_ok = r.returncode == 0
        miss = anchors_missing(text, bank, f) if bank else ["(bank 缺失)"]
        status = "PASS" if density_ok and not miss else "FAIL"
        n_pass += status == "PASS"
        print(f"[sweep] {f.stem}: 密度{'✅' if density_ok else '❌'} "
              f"锚点 {'✅' if not miss else '❌ ' + str(len(miss)) + ' 未命中'} "
              f"→ {status}")
        for m in miss[:4]:
            print(f"    UNANCHORED: {m}")
    print(f"[sweep] {n_pass}/{len(files)} PASS")
    return 0 if n_pass == len(files) else 2


if __name__ == "__main__":
    raise SystemExit(main())
