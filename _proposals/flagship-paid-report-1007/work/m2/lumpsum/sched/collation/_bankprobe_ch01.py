# -*- coding: utf-8 -*-
"""ch01 收编对勘助手: 定向检索 bank_ch01.md, 报告每个 pattern 命中所在的 P 节. 只读."""
import re, sys

BANK = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\lumpsum\sched\bank_ch01.md"

def load():
    t = open(BANK, encoding='utf-8').read().replace('\x00', '')
    parts = re.split(r'(?m)^## (P\d+)', t)
    secs = {}  # pid -> text
    order = []
    for i in range(1, len(parts), 2):
        pid, body = parts[i], parts[i+1]
        secs[pid] = body
        order.append(pid)
    return t, secs, order

def probe(patterns):
    full, secs, order = load()
    for pat in patterns:
        hits = []
        for pid in order:
            n = secs[pid].count(pat)
            if n:
                hits.append(f"{pid}x{n}")
        # full-text line sample
        lines = [l.strip()[:100] for l in full.split('\n') if pat in l][:2]
        print(f"[{pat}] -> " + (', '.join(hits) if hits else '*** NO HIT ***'))
        for l in lines:
            print(f"    | {l}")

if __name__ == '__main__':
    pats = sys.argv[1:]
    probe(pats)
