# -*- coding: utf-8 -*-
"""bank_index — 分章素材库锚头摘要器 (1124 用户令 ④: 收编工人跳过读卷阶段).

bank_chNN.md → bank_chNN.index.md: 每锚一行 = 锚号|案号|法院|裁判日期|案件名称|首句摘要。
收编工人先读 1-2KB 的 index 选锚, 再精读选中锚 — 省去 grep+分段读 592KB bank 的三角化。

用法: py -X utf8 tools/bank_index.py <sched目录>   (处理其下所有 bank_chNN.md)
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def index_bank(bank: Path) -> Path:
    t = bank.read_text(encoding="utf-8", errors="replace")
    lines = []
    for m in re.finditer(r"^## (\S{6,16})[^\n]*\n(.*?)(?=^## \S{6,16}|\Z)", t, re.M | re.S):
        aid, body = m.group(1), m.group(2)
        an = re.search(r"案号:\s*([^\n]+)", body)
        court = re.search(r"法院:\s*([^\n]+)", body)
        date = re.search(r"裁判日期:\s*([0-9-]+)", body)
        name = re.search(r"案件名称:\s*([^\n]+)", body)
        # 首句摘要: 跳过元数据行, 取正文第一个 ≥30 字的句子
        head = ""
        for ln in body.splitlines():
            s = ln.strip()
            if len(s) >= 30 and not re.match(r"^(案号|案件名称|法院|所属地区|案件类型|审理程序|裁判日期|当事人|案由|路径|#)", s):
                head = s[:80]
                break
        lines.append("|".join([
            aid,
            (an.group(1).strip() if an else "?"),
            (court.group(1).strip() if court else "?"),
            (date.group(1) if date else "?"),
            (name.group(1).strip()[:60] if name else "?"),
            head,
        ]))
    out = bank.with_name(bank.stem.replace("bank_", "bank_") + ".index.md")
    out.write_text(
        f"# {bank.stem} 锚头索引 ({len(lines)}锚) — 选锚用, 精读请读原bank\n"
        + "\n".join(lines) + "\n",
        encoding="utf-8")
    return out


def main() -> int:
    sched = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(".")
    made = []
    for b in sorted(sched.glob("bank_ch*.md")):
        if ".index" in b.stem or b.stem.endswith("_index"):
            continue
        out = index_bank(b)
        made.append(out.name)
        print(f"[index] {out.name} ({out.stat().st_size:,}B)")
    print(f"[done] {len(made)} 份锚头索引")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
