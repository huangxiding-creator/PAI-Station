# -*- coding: utf-8 -*-
"""build_docx — 蓝皮书成书构建：五卷 merged md → docx（分卷交付）。

每卷产出:
  dist/volN-merged.md  = 卷题(# 书名·卷N 卷名) + 封面行 + [卷一含总序] + 卷导语 + 正文章
  dist/卷N-卷名.docx    = tools/report_to_docx.py 排版（封面/点线目录/页码/中文字体基建）
章尾「--- + 章级门自检」块在合并时剥除（不入书）。
usage: PYTHONIOENCODING=utf-8 python build_docx.py [vol ...]   # 缺省全五卷
"""
import re
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[2]
BLUE = ROOT / "bluebook"
PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"
TO_DOCX = ROOT.parent.parent / "tools" / "report_to_docx.py"  # E:\AI-Station\tools

BOOK = "中国工程总承包（EPC）产业蓝皮书·二〇二七"
VOLS = [
    ("vol1", "卷一", "市场全景", "总序 · 卷一导语 · 正文九章"),
    ("vol2", "卷二", "标杆企业", "卷二导论 · 二十八家章 · 对标矩阵（三十章）"),
    ("vol3", "卷三", "区域机会", "卷三导论 · 十七省章（十八章）"),
    ("vol4", "卷四", "专题实战", "卷四导论 · 八域专题 · 工具箱总账（十章）"),
    ("vol5", "卷五", "独家判断", "卷五七章 · 全书判断层"),
]


def chap_sort(p):
    return [int(x) for x in re.match(r"(\d+)-(\d+)", p.name).groups()]


def build(vol_dir, vol_cn, vol_name, cover):
    dist = BLUE / "dist"
    dist.mkdir(exist_ok=True)
    parts = [f"# {BOOK}——{vol_cn} {vol_name}", "", cover, ""]
    if vol_dir == "vol1":
        parts.append((BLUE / "front" / "0-zongxu.md").read_text(encoding="utf-8").rstrip() + "\n")
    parts.append((BLUE / "front" / f"{vol_dir}-daoyu.md").read_text(encoding="utf-8").rstrip() + "\n")
    for p in sorted((BLUE / vol_dir).glob("*.md"), key=chap_sort):
        body = p.read_text(encoding="utf-8").rsplit("---", 1)[0].rstrip()  # 剥章尾门自检
        parts.append(body + "\n")
    merged = dist / f"{vol_dir}-merged.md"
    merged.write_text("\n".join(parts), encoding="utf-8")
    docx = dist / f"{vol_cn}-{vol_name}.docx"
    r = subprocess.run([PY311, str(TO_DOCX), str(merged), str(docx)],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace", creationflags=0x08000000, cwd=str(ROOT))
    ok = r.returncode == 0 and docx.exists()
    print(f"{vol_cn} {vol_name}: merged={merged.name} docx={'✓ ' + str(docx.stat().st_size) + 'B' if ok else '✗'}")
    if not ok:
        print((r.stdout or "")[-300:], (r.stderr or "")[-300:])
    return ok


def main():
    only = set(sys.argv[1:]) or None
    fails = 0
    for vol_dir, vol_cn, vol_name, cover in VOLS:
        if only and vol_dir not in only and vol_cn not in only:
            continue
        if not build(vol_dir, vol_cn, vol_name, cover):
            fails += 1
    print("BUILD " + ("PASS 全绿" if fails == 0 else f"FAIL ×{fails}"))
    sys.exit(1 if fails else 0)


if __name__ == "__main__":
    main()
