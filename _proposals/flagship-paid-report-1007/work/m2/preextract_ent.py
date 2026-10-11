# -*- coding: utf-8 -*-
"""卷二预抽取: 28 家企业源 -> work/m2/ent_<slug>.txt/.headings.md
双稿企业: 多 docx 依次抽取后合并进单 bank, 第 k 份(0 起)锚点 +500000*k 防碰撞
(章内引 P 锚时直接抄 bank 里的最终锚号, gate2 查 bank 恒命中).
幂等: bank 已存在则跳过.
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
TMP = os.path.join(OUT, "_ent_tmp")
os.makedirs(TMP, exist_ok=True)

# (slug, [glob 关键词...], [显式路径...]) — 命中多 docx 时按体积全取合并
JOBS = [
    ("gonglu",    ["*公路工程咨询*"], []),
    ("huanqiu",   ["*寰球*全景洞察*", "*寰球*经营管理*"], []),
    ("cpcec",     ["*中国石油工程建设*"], []),
    ("gxdy",      ["*广西电力设计*"], []),
    ("gzgc",      ["*中石化广州*"], []),
    ("sdyuan",    ["*山东电力工程咨询院有限公司*", "*山东电力工程咨询院EPC*"], []),
    ("mingyang",  ["*铭扬*"], []),
    ("shizheng",  ["*上海市政总院*", "*上海市政工程设计研究总院*"], []),
    ("zhongyi",   ["*中亿国际*"], []),
    ("nanfang",   ["*中冶南方*"], []),
    ("zndianli",  ["*中南电力设计院*"], []),
    ("wuhuan",    ["*五环*"], []),
    ("tianchen",  ["*天辰*"], []),
    ("jianerju",  ["*中国建筑第二工程局*"], []),
    ("qiche",     ["*汽车工业工程*"], []),
    ("huadong",   ["*中国电建华东院EPC经营管理*"], []),
    ("znyuan",    ["*中南勘测设计*"], []),
    ("cdyuan",    ["*成都勘测设计*"], []),
    ("kmyuan",    ["*昆明勘测设计*"], []),
    ("lianhe",    ["*中国联合工程*"], []),
    ("ckz",       ["*中城科泽*"], []),
    ("sanju",     ["*中建三局集团有限公司EPC总承包业务经营*"], []),
    ("wuju",      ["*中建五局*"], []),
    ("baju",      ["*中建八局*"], []),
    ("tiesi",     ["*中铁第四勘察*"], []),
    ("hualu",     ["*华陆*"], []),
    ("hunanyuan", ["*湖南省建筑设计院*"], []),
    ("liuju",     [], [os.path.join(BASE, "00 排队处理研报",
                                    "《中国建筑第六工程局有限公司EPC总承包业务全景洞察报告》.docx")]),
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
    bank = os.path.join(OUT, f"ent_{slug}.txt")
    if os.path.exists(bank):
        print(f"[{slug}] skip (exists)")
        continue
    srcs = list(explicit)
    for kw in kws:
        srcs += glob.glob(os.path.join(BASE, kw, "*.docx"))
    # 剔「副本」重复稿; 同目录多稿(大纲+正文)只取最大; 跨目录各保留; 0 字节弃
    srcs = [s for s in srcs if "副本" not in os.path.basename(s)
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
        parts.append(offset_text(io_text := open(tp + ".txt", encoding="utf-8").read(), k)
                     + ("" if open(tp + ".txt", encoding="utf-8").read().endswith("\n") else "\n"))
        hp = open(tp + ".headings.md", encoding="utf-8").read()
        hparts.append(offset_text(hp, k))
        os.remove(tp + ".txt")
        if os.path.exists(tp + ".headings.md"):
            os.remove(tp + ".headings.md")
    if parts is None:
        continue
    open(bank, "w", encoding="utf-8").write("".join(parts))
    open(os.path.join(OUT, f"ent_{slug}.headings.md"), "w", encoding="utf-8").write("".join(hparts))
    n = sum(len(p) for p in parts)
    print(f"[{slug}] {len(srcs)}稿 -> ent_{slug}.txt ({n} chars)")
print("DONE")
