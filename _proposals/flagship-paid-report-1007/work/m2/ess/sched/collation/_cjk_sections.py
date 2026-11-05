# -*- coding: utf-8 -*-
import re, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
p = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess/sched/_ch10_final.md"
t = open(p, encoding="utf-8").read()
lines = t.split("\n")
marks = []
for i, ln in enumerate(lines):
    if re.match(r"^#{1,4} ", ln):
        marks.append((i, ln.strip()))
marks.append((len(lines), "END"))
for k in range(len(marks) - 1):
    i0, h = marks[k]; i1 = marks[k + 1][0]
    seg = "\n".join(lines[i0:i1])
    c = len(re.findall(r"[\u4e00-\u9fff]", seg))
    print(f"{c:6d}  L{i0+1:4d}  {h[:60]}")
print("TOTAL", len(re.findall(r"[\u4e00-\u9fff]", t)))
