# -*- coding: utf-8 -*-
"""_tmp_patch_top50_cite — ch01/ch02 锚引短式化 [来源: Pxxx] -> (Pxxx) (JIAGE 打法).
规则: 只改非表格行(不以|开头的行); P锚号一字不动; 多锚 [来源: P1, P2] -> (P1, P2).
表格数据行(|开头)一律不动."""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SCHED = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\top50\sched")
RX = re.compile(r"\[\s*来源\s*[:：]\s*((?:P[0-9]{6}(?:\s*,\s*P[0-9]{6})*))\s*\]")

for fname in sys.argv[1:]:
    p = SCHED / fname
    lines = p.read_text(encoding="utf-8").split("\n")
    out, n = [], 0
    for ln in lines:
        if ln.lstrip().startswith("|"):
            out.append(ln)          # 表格行不动
            continue
        new, k = RX.subn(lambda m: "(" + re.sub(r"\s*,\s*", ", ", m.group(1)) + ")", ln)
        n += k
        out.append(new)
    p.write_text("\n".join(out), encoding="utf-8")
    left = sum(len(RX.findall(ln)) for ln in out if not ln.lstrip().startswith("|"))
    print(f"{fname}: converted={n} prose_long_cite_left={left}")
