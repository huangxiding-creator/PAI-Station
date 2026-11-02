# -*- coding: utf-8 -*-
"""fomi_cleanup - 章稿机械清洗: NBLM对话残留/emoji/绝对化套话/金额格式 (判断性修改留给修复军团).
用法: py -X utf8 fomi_cleanup.py   (原地清洗 nblm_out/_ch*.md)
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区\nblm_out")

DEBRIS = [
    r"(?m)^\s*💡.*$\n?",
    r"(?m)^\s*[*_>`]*\s*(是否需要我|需要我继续|我可以继续|已为您完成|作为世界顶级|下面我|接下来我将|我将为您|现在为您|以上是|本次只写|结尾注明)[^\n]*$\n?",
    r"(?m)^\s*#{0,3}\s*(待续|【待续】)\s*$\n?",
    r"【待续】",
    r"(?m)^\s*>\s*继续充实本章[^\n]*$\n?",
]
ABSOLUTE = [
    ("彻底消除疑虑", "系统性回应疑虑"),
    ("彻底杜绝", "严控"),
    ("无缝闭环", "闭环管控"),
    ("无偿付死角", "偿债覆盖经测算安排"),
    ("极高的确定性与保障度", "较高的确定性与保障安排"),
    ("绝对主导地位", "主导地位"),
    ("百分之百", "目标 100%"),
]
EMOJI = re.compile("[\U0001F300-\U0001FAFF\u2600-\u27BF\uFE0F]")


def main() -> int:
    for fp in sorted(OUT.glob("_ch*.md")):
        t = fp.read_text(encoding="utf-8", errors="replace")
        orig = t
        for pat in DEBRIS:
            t = re.sub(pat, "", t)
        t = EMOJI.sub("", t)
        for a, b in ABSOLUTE:
            t = t.replace(a, b)
        t = re.sub(r"\n{4,}", "\n\n\n", t)
        if t != orig:
            fp.write_text(t, encoding="utf-8")
            print(f"[clean] {fp.name} {len(orig):,}->{len(t):,}")
        else:
            print(f"[clean] {fp.name} 无残留")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
