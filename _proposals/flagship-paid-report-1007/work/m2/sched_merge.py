# -*- coding: utf-8 -*-
"""sched_merge — SCHED 全书合并器: 章内「本章小结与盲区」块移章尾 + 总装.

各章部件(p1..p4)按序合并后, 若「## 本章小结与盲区」块位于章中部(扩章军团
追加节排在了它后面), 将该块剪切移到章尾——纯顺序调整, 一字不改。
输出 sched/REPORT_FULL.md = 导言+12章+结语+附录。
用法: py sched_merge.py
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

M2 = Path(__file__).resolve().parent / "sched"
HEAD = r"^## 本章小结与盲区"


def fix_chapter_order(text: str) -> tuple[str, bool]:
    """把小结块(从标题到章尾或下一 ## 顶级块前)移到章尾。"""
    m = re.search(HEAD, text, flags=re.M)
    if not m:
        return text, False
    # 小结块 = 从标题到下一个 '\n## '(非小结的二级标题)或文末
    rest = text[m.start():]
    nxt = re.search(r"\n## (?!小结|反证|证据未覆盖)", rest[1:])
    # 小结内部含 ### 子块, 只在遇到新的 ## 级(非小结族)时切
    end = None
    for mm in re.finditer(r"\n## ", rest):
        seg = rest[mm.start()+1:mm.start()+40]
        if not re.match(r"## (本章小结|反证三问|证据未覆盖)", seg):
            end = mm.start()
            break
    block = rest[:end] if end else rest
    after = rest[end:] if end else ""
    before = text[:m.start()]
    new = before.rstrip() + "\n\n" + after.rstrip() + "\n\n" + block.rstrip() + "\n"
    return new, True


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    parts = [M2 / "_ch00_daolun.md"]
    for i in range(1, 13):
        src = M2 / f"ch{i:02d}.md"
        t = src.read_text(encoding="utf-8")
        t2, moved = fix_chapter_order(t)
        if moved:
            src.write_text(t2, encoding="utf-8")
            print(f"[merge] ch{i:02d} 小结块移章尾")
        parts.append(src)
    parts += [M2 / "chZ.md", M2 / "chA.md"]
    full = []
    import re as _re
    for p in parts:
        t = p.read_text(encoding="utf-8")
        # 去部件尾部的临时校注行
        t = _re.sub(r"\n（校：[^）]*）\n", "\n", t)
        full.append(t.strip())
    out = M2 / "REPORT_FULL.md"
    out.write_text("\n\n---\n\n".join(full) + "\n", encoding="utf-8")
    cjk = len(_re.findall(r"[一-鿿]", out.read_text(encoding="utf-8")))
    print(f"[merge] REPORT_FULL.md 落盘 | 全书CJK {cjk:,}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
