# -*- coding: utf-8 -*-
"""预扫: NBLM ch01/ch02 全部数字token 回 bank(全12章) + nblm源包(22件) 双账.
找出无源数字(需修/删)."""
import re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

HERE = Path(__file__).resolve().parent
FW = "０１２３４５６７８９．，－／％＋（）［］"
HW = "0123456789.,-/%+()[]"
TRANS = str.maketrans(FW, HW)

def norm(s):
    s = s.translate(TRANS)
    s = re.sub(r"(?<=\d)\s+(?=\d)", "", s)
    s = re.sub(r"(?<=\d)[一一—–−]+(?=\d)", "-", s)
    return s

banks = ""
for f in sorted(HERE.glob("bank_ch*.md")):
    banks += f.read_text(encoding="utf-8", errors="ignore")
banks_n = norm(banks)
banks_nc = banks_n.replace(",", "")

srcs = ""
SRC = HERE / "nblm_upload" / "ch03_笔记本"
src_list = []
for f in sorted(SRC.glob("*.md")):
    t = f.read_text(encoding="utf-8", errors="ignore")
    srcs += t
    src_list.append(f.name)
srcs_n = norm(srcs)
srcs_nc = srcs_n.replace(",", "")

num_re = re.compile(r"\d[\d.,%/－—~－-]*\d|\d")

for chf in ["_ch01_nblm.md", "_ch02_nblm.md"]:
    t = (HERE / chf).read_text(encoding="utf-8")
    fail_bank, fail_both = [], []
    total = passb = passs = 0
    for ln, raw in enumerate(t.splitlines(), 1):
        st = raw.strip()
        if st.startswith("#") or st.startswith("```"):
            continue
        line = raw
        line = re.sub(r"\[(?:来源:)?\s*[^\]]*\]", " ", line)   # 剔除一切[N]/[来源:..]引用
        line = re.sub(r"第\d+(至\d+)?[章节]", " ", line)
        line = re.sub(r"^\s*\d+(\.\d+)*\s*$", " ", line)
        line = re.sub(r"^\s*[-*]?\s*`?\[\d+\]`?[,，]?\s*$", " ", line)
        for tok in num_re.findall(line):
            tt = norm(tok).strip("%+")
            if not tt or not re.search(r"\d", tt):
                continue
            total += 1
            variants = {tt, tt.replace(",", ""), tt.rstrip("."), re.sub(r"[.,]+$", "", tt)}
            if any(v in banks_n or v in banks_nc for v in variants if v):
                passb += 1
            elif any(v in srcs_n or v in srcs_nc for v in variants if v):
                passs += 1
            else:
                fail_both.append((ln, tok))
    print(f"== {chf}: 数字token {total} | bank命中 {passb} | 仅源包命中 {passs} | 双账未中 {len(fail_both)}")
    for ln, tok in fail_both:
        line = t.splitlines()[ln-1][:70]
        print(f"   MISS L{ln} [{tok}] :: {line}")
