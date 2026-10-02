# -*- coding: utf-8 -*-
"""一次性侦察: #50 战场目录种子内容 + 为 #49 建目录骨架."""
import glob
import os
import shutil
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

b50 = glob.glob(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
                r"\*中石化南京工程*")[0]
print("== #50 00 研究报告需求 ==")
d = os.path.join(b50, "00 研究报告需求")
for f in os.listdir(d)[:10]:
    fp = os.path.join(d, f)
    print("  ", f, f"{os.path.getsize(fp)//1024}KB" if os.path.isfile(fp) else "(dir)")
print("== #50 02 初次网络调研 ==")
d = os.path.join(b50, "02 初次网络调研")
for root, dirs, files in os.walk(d):
    rel = os.path.relpath(root, d)
    print("  ", rel, f"{len(files)}件")
    if rel.count(os.sep) >= 1:
        dirs[:] = []
print("== #50 _pipeline 尾部 ==")
d = os.path.join(b50, "_pipeline")
for f in sorted(os.listdir(d))[-15:]:
    print("  ", f)
