# -*- coding: utf-8 -*-
"""卷四预抽取: 8 专题源 -> work/m2/topic_<slug>.txt/.headings.md
多稿专题: 多 docx 依次抽取后合并进单 bank, 第 k 份(0 起)锚点 +500000*k 防碰撞
(章内引 P 锚时直接抄 bank 里的最终锚号, gate2 查 bank 恒命中).
幂等: bank 已存在则跳过.
CNNC 全景洞察目录为空盘(1011 实测) — 核电 3 稿实为 探秘+研究报告 两目录 docx, 如实入账.
"""
import glob
import os
import re
import subprocess
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BASE = r"F:\新建文件夹\AI总包创新院\总包研报"
PY = r"C:/Users/91216/AppData/Local/Programs/Python/Python311/python.exe"
EX = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2_extract.py"
OUT = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2"
TMP = os.path.join(OUT, "_topic_tmp")
os.makedirs(TMP, exist_ok=True)

# (slug, [glob 关键词...], [显式路径...]) — 命中多 docx 时按体积全取合并
JOBS = [
    # 4-1 储能
    ("chuneng", ["*储能EPC总承包全流程*"], []),
    # 4-2 风电
    ("fengdian", ["*风电EPC总承包全流程*"], []),
    # 4-3 核电: 策划指南 + CNNC 探秘/研究报告
    ("hedian", ["*核电工程EPC项目管理策划*",
                "*中国核电工程有限公司EPC业务经营管理探秘*",
                "*中国核电工程有限公司EPC总承包业务经营与管理研究报告*"], []),
    # 4-4 水电: 杨房沟复盘 + 雅江机会
    ("shuidian", ["*杨房沟水电站EPC实践全景复盘*",
                  "*雅鲁藏布江下游水电工程*"], []),
    # 4-5 水利: 策划指南 + 实施效果
    ("shuili", ["*水利工程EPC项目管理策划编制指南*",
                "*水利工程EPC总承包模式实施效果*"], []),
    # 4-6 事故复盘: 沉思录 + 招投标合规
    ("fengcheng", ["*江西丰城电厂三期EPC特大事故沉思录*",
                   "*工程总承包招投标合规工作指南*"], []),
    # 4-7 项目经理能力: 能力手册 + 培训洞察
    ("jingli", ["*EPC总承包项目经理能力手册*",
                "*企业EPC总承包培训深度洞察报告*"], []),
    # 4-8 AI 应用: DeepSeek
    ("ai", ["*DeepSeek在EPC项目中的应用研究*"], []),
]

ANCHOR = re.compile(r"\[(P|T)(\d+)")


def offset_text(text, k):
    if k == 0:
        return text
    off = 500000 * k

    def sub(m):
        return f"[{m.group(1)}{int(m.group(2)) + off}"

    return ANCHOR.sub(sub, text)


for slug, kws, explicit in JOBS:
    bank = os.path.join(OUT, f"topic_{slug}.txt")
    if os.path.exists(bank):
        print(f"[{slug}] skip (exists)")
        continue
    srcs = list(explicit)
    for kw in kws:
        srcs += glob.glob(os.path.join(BASE, kw, "*.docx"))
    # 剔「副本」重复稿与 office 锁文件; 同目录多稿只取最大; 0 字节弃
    srcs = [s for s in srcs if "副本" not in os.path.basename(s)
            and not os.path.basename(s).startswith("~$")
            and os.path.getsize(s) > 10000]
    by_dir = {}
    for s in srcs:
        d = os.path.dirname(s)
        if d not in by_dir or os.path.getsize(s) > os.path.getsize(by_dir[d]):
            by_dir[d] = s
    srcs = sorted(by_dir.values(), key=lambda s: (-os.path.getsize(s), s))
    if not srcs:
        print(f"[{slug}] NO DOCX")
        continue
    parts, hparts = [], []
    for k, src in enumerate(srcs):
        tp = os.path.join(TMP, f"{slug}_{k}")
        r = subprocess.run([PY, EX, src, tp], capture_output=True, text=True,
                           encoding="utf-8", errors="replace")
        if not os.path.exists(tp + ".txt"):
            print(f"[{slug}] EXTRACT FAIL: {os.path.basename(src)[:40]} :: {(r.stderr or '')[:80]}")
            parts = None
            break
        raw = open(tp + ".txt", encoding="utf-8").read()
        parts.append(offset_text(raw, k)
                     + ("" if raw.endswith("\n") else "\n"))
        hp = open(tp + ".headings.md", encoding="utf-8").read()
        hparts.append(offset_text(hp, k))
        os.remove(tp + ".txt")
        if os.path.exists(tp + ".headings.md"):
            os.remove(tp + ".headings.md")
    if parts is None:
        continue
    open(bank, "w", encoding="utf-8").write("".join(parts))
    open(os.path.join(OUT, f"topic_{slug}.headings.md"), "w", encoding="utf-8").write("".join(hparts))
    n = sum(len(p) for p in parts)
    print(f"[{slug}] {len(srcs)}稿 -> topic_{slug}.txt ({n} chars)")
print("DONE")
