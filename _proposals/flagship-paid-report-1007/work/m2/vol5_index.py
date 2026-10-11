# -*- coding: utf-8 -*-
"""卷五大 bank 轻索引 (索引纪律: 写手禁整读 bank, 只读索引+Grep 按锚取件).

行格式: [P锚] ◆首40字  — 标题样段落全文, 普通段截40字按步长抽样.
  vol5_wubufa_index.txt  <- vol5_bank_wubufa.txt
  vol5_sample_index.txt  <- vol5_bank_sample.txt
幂等: 存在即跳过 (--force 重跑).
"""
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
ANCHOR_RE = re.compile(r"^\[P(\d{6})\]\s?(.*)$")

JOBS = [
    ("vol5_bank_wubufa.txt", "vol5_wubufa_index.txt", 8),
    ("vol5_bank_sample.txt", "vol5_sample_index.txt", 8),
]


def build(bank, idx, stride, force=False):
    if os.path.exists(os.path.join(HERE, idx)) and not force:
        print(f"[{idx}] skip (exists)")
        return
    lines, kept = [], 0
    for raw in open(os.path.join(HERE, bank), encoding="utf-8"):
        m = ANCHOR_RE.match(raw.strip())
        if not m:
            continue
        anchor, text = m.group(1), m.group(2).strip()
        if text.startswith("◆"):                       # 区间头恒入
            lines.append(f"[P{anchor}] {text[:90]}")
            kept += 1
            continue
        is_head = (len(text) <= 50 and not re.search(r"[。；，]$", text)
                   and re.match(r"^(第?[一二三四五六七八九十0-9第（(]|章节|Part|STEP|步骤|招式|案例|案例)", text))
        if is_head or kept % stride == 0:
            lines.append(f"[P{anchor}] ◆{text[:40]}")
        kept += 1
    open(os.path.join(HERE, idx), "w", encoding="utf-8").write("\n".join(lines) + "\n")
    print(f"[{idx}] {len(lines)} 行 -> {os.path.getsize(os.path.join(HERE, idx))} bytes")


if __name__ == "__main__":
    force = "--force" in sys.argv
    for bank, idx, stride in JOBS:
        build(bank, idx, stride, force)
    print("DONE")
