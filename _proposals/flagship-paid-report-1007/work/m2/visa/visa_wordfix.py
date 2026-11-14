# -*- coding: utf-8 -*-
"""audit_wordfix — 第15份word四修 (1113用户令):
1) 删各章'出品：总包创研院研究团队'(全书merge头只留一次) 2) 删各章'本章事实纪律声明'块
3) 章节序号重排(N.M从1起) 4) 代码栅栏内ASCII框图(│表)转markdown真表格
备份: *.bak_wordfix.md
"""
import re
import sys
from pathlib import Path

SCHED = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\visa\sched")


def strip_chuipin(lines: list) -> list:
    return [l for l in lines if l.strip() != "出品：总包创研院研究团队"]


def strip_declare(text: str) -> str:
    # 删除 "> **本章事实纪律声明**..." 整个引用段(到空行为止)
    return re.sub(r"> \*\*本章事实纪律声明\*\*.*?(?:\n(?!>).*)*?\n\n", "\n", text, flags=re.S)


def renumber(text: str, ch: int) -> str:
    # 收集 ## N.M 标题按出现序重排
    secs = re.findall(r"^## %d\.(\d+)" % ch, text, flags=re.M)
    seen, order = set(), []
    for m in re.finditer(r"^## %d\.(\d+)" % ch, text, flags=re.M):
        old = m.group(1)
        if old not in seen:
            seen.add(old)
            order.append(old)
    mapping = {old: str(i + 1) for i, old in enumerate(order)}
    # 先替换 ### N.M.K (三段)
    def sub3(m):
        old = m.group(1)
        return f"### {ch}.{mapping.get(old, old)}.{m.group(2)}"
    text = re.sub(r"^### %d\.(\d+)\.(\d+)" % ch, sub3, text, flags=re.M)
    # 再替换 ## N.M
    def sub2(m):
        old = m.group(1)
        return f"## {ch}.{mapping.get(old, old)}"
    text = re.sub(r"^## %d\.(\d+)" % ch, sub2, text, flags=re.M)
    return text


def fence_tables(text: str) -> tuple[str, int]:
    """栅栏内含│的ASCII表 → markdown表; 纯树图栅栏保留."""
    out, converted = [], 0
    parts = re.split(r"^```.*$", text, flags=re.M)
    fences = re.findall(r"^```.*$", text, flags=re.M)
    # 逐栅栏处理
    lines = text.split("\n")
    res, i, n = [], 0, len(lines)
    in_fence = False
    buf = []
    for line in lines:
        if line.strip().startswith("```"):
            if in_fence:
                # 关栅栏: 处理buf
                tbl = ascii_to_table(buf)
                if tbl is not None:
                    res.append(tbl)
                    converted += 1
                else:
                    res.extend(buf)
                res.append(line)
                in_fence = False
                buf = []
            else:
                if buf:
                    res.extend(buf)
                    buf = []
                res.append(line)
                in_fence = True
            continue
        if in_fence:
            buf.append(line)
        else:
            res.append(line)
    if buf:
        res.extend(buf)
    return "\n".join(res), converted


def ascii_to_table(buf: list) -> str | None:
    """buf=栅栏内行; 若含│行≥2 → md表; 否则None(原样)."""
    rows = [l for l in buf if "│" in l]
    if len(rows) < 2:
        return None
    parsed = []
    for r in rows:
        cells = [c.strip() for c in r.strip().strip("│").split("│")]
        cells = [c for c in cells if c != ""]
        if cells:
            parsed.append(cells)
    if not parsed:
        return None
    width = max(len(p) for p in parsed)
    norm = [p + [""] * (width - len(p)) for p in parsed]
    md = ["| " + " | ".join(norm[0]) + " |",
          "|" + "|".join([" --- "] * width) + "|"]
    for p in norm[1:]:
        md.append("| " + " | ".join(p) + " |")
    return "\n".join(md)


def clean_blanks(text: str) -> str:
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip() + "\n"


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    tot_tbl = 0
    for fp in sorted(SCHED.glob("_ch[0-9][0-9]_final.md")):
        ch = int(fp.stem[3:5])
        bak = fp.with_suffix(".bak_wordfix.md")
        if not bak.exists():
            bak.write_text(fp.read_text(encoding="utf-8"), encoding="utf-8")
        t = fp.read_text(encoding="utf-8")
        lines = t.split("\n")
        lines = strip_chuipin(lines)
        t = "\n".join(lines)
        t = strip_declare(t)
        t = renumber(t, ch)
        t, n_tbl = fence_tables(t)
        tot_tbl += n_tbl
        t = clean_blanks(t)
        fp.write_text(t, encoding="utf-8")
        print(f"[fix] ch{ch:02d} 声明删/出品删/序号重排/框图转表{n_tbl} (备份.bak_wordfix)")
    print(f"[done] 合计框图转表 {tot_tbl}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
