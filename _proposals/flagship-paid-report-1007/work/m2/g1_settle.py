# -*- coding: utf-8 -*-
"""g1_settle — G1 字数门结算（全书 CJK 同口径合计）。

口径（与 m2_gate 逐字一致）：
  - 章文件: body = 首个 '## 一、' 之后 至 最后一个 '---' 之前; CJK = 纯汉字计数
  - 前置件(front/): 非 '#' 标题行的 CJK（总序+卷导语, 成书正文的一部分）
G1 门: 合计 >= 500,000
usage: PYTHONIOENCODING=utf-8 python g1_settle.py
exit: 0 PASS / 1 FAIL
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
BLUE = Path(__file__).resolve().parents[2] / "bluebook"
CJK = re.compile(r"[一-鿿]")


def chapter_cjk(path):
    t = path.read_text(encoding="utf-8")
    body = t.split("## 一、", 1)[1].rsplit("---", 1)[0] if "## 一、" in t else t
    return len(CJK.findall(body))


def front_cjk(path):
    body = "\n".join(ln for ln in path.read_text(encoding="utf-8").splitlines()
                     if not ln.lstrip().startswith("#"))
    return len(CJK.findall(body))


def main():
    total, rows = 0, []
    for vol in ["vol1", "vol2", "vol3", "vol4", "vol5"]:
        files = sorted((BLUE / vol).glob("*.md"),
                       key=lambda p: [int(x) for x in re.match(r"(\d+)-(\d+)", p.name).groups()])
        n = sum(chapter_cjk(p) for p in files)
        total += n
        rows.append((f"{vol} ({len(files)}章)", n))
    f_total, f_rows = 0, []
    front_dir = BLUE / "front"
    for p in sorted(front_dir.glob("*.md")):
        n = front_cjk(p)
        f_total += n
        f_rows.append((p.name, n))
    total += f_total
    for r in rows + [("front 前置件", f_total)] + f_rows:
        print(f"{r[0]:<22}{r[1]:>9,}")
    ok = total >= 500_000
    print(f"\n全书合计 = {total:,}  (G1 门 500,000)  -> {'PASS' if ok else 'FAIL'}")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
