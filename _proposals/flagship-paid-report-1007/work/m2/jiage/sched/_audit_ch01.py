# -*- coding: utf-8 -*-
"""第1章全量数字回bank审计（终版）: 提取_ch01_p1.md正文与表格全部数字token,
剔除章节序号/锚点编号/表格结构行, 经全半角与OCR连字号归一化后逐个验证在bank_ch01.md中存在。
用法: py -3 _audit_ch01.py   (在 sched/ 目录下运行)
"""
import re, sys
sys.stdout.reconfigure(encoding="utf-8")

ch = open("_ch01_p1.md", encoding="utf-8").read()
bank = open("bank_ch01.md", encoding="utf-8").read()

FW = "０１２３４５６７８９．，－／％＋（）［］"
HW = "0123456789.,-/%+()[]"
TRANS = str.maketrans(FW, HW)

def norm(s: str) -> str:
    s = s.translate(TRANS)
    s = re.sub(r"(?<=\d)\s+(?=\d)", "", s)                      # 数字间空格去除
    s = re.sub(r"(?<=\d)[一一—–−]+(?=\d)", "-", s)              # OCR连字号(一/—/–)归一为-
    return s

bank_n = norm(bank)
bank_nc = bank_n.replace(",", "")

num_re = re.compile(r"\d[\d.,%/－—~－-]*\d|\d")
fail, checked = [], 0

for ln, raw in enumerate(ch.splitlines(), 1):
    st = raw.strip()
    if st.startswith("<!--") or st.startswith("#"):
        continue                                                # 注释与标题行跳过
    line = raw
    if st.startswith("|"):
        line = re.sub(r"第\d+章", " ", line)                    # 12章导读表的章次列为结构数
    line = re.sub(r"\[来源:[^\]]*\]", " ", line)                # 锚点编号剔除
    line = re.sub(r"第\d+(至\d+)?[章节]", " ", line)             # 章节序号剔除
    line = re.sub(r"^\s*\d+(\.\d+)*\s*$", " ", line)            # 纯小节号行剔除
    for tok in num_re.findall(line):
        t = norm(tok).strip("%+")
        if not t or not re.search(r"\d", t):
            continue
        variants = {t, t.replace(",", ""), t.rstrip("."), re.sub(r"[.,]+$", "", t)}
        if any(v in bank_n or v in bank_nc for v in variants if v):
            checked += 1
        else:
            fail.append((ln, tok))

# 显式引用的中文数字事实专项回查
cn_facts = {
    "二十三章": "二十三章" in bank,
    "二十四章": "二十四章" in bank,
    "共十七章": "共十七章" in bank,
    "一星到五星级": "从一星到五星级" in bank,
    "A、B、C三级": ("A、B、C 三级" in bank) or ("A、B、C三级" in bank),
    "Tier I到IV四个等级": "Tier I到Tier IV四个等级" in bank,
}

print("中文数字/等级事实核查:", cn_facts)
print("数字token总数(含表格,含重复):", checked + len(fail))
print("回bank验证通过:", checked)
print("未通过:", len(fail))
for ln, tok in fail:
    print("  FAIL line", ln, ":", tok)

# CJK字数
cjk = re.findall(r"[㐀-䶿一-鿿豈-﫿]", ch)
print("CJK chars(全文件):", len(cjk))
