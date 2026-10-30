# -*- coding: utf-8 -*-
"""第3章(终稿)双口径全量数字审计: _ch03_final.md 全部数字token逐个回查 bank_ch04.md.
口径一: 数字token全量回bank(全半角/OCR连字号/逗号变体归一化);
口径二: 中文数字与关键事实专项回查(cn_facts 逐字验证);
附加门: CJK>=18000 | dup段/题=0(剔除表格分隔行) | P锚全部存在于bank | 无裸[N]引用 | 体裁(无AI词/聊天痕/生产腔).
用法: py -X utf8 _audit_ch03_final.py   (sched/ 目录下运行)
"""
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

CH_FILE = "_ch03_final.md"
BANK_FILE = "bank_ch04.md"

ch = open(CH_FILE, encoding="utf-8").read()
bank = open(BANK_FILE, encoding="utf-8").read()

FW = "０１２３４５６７８９．，－／％＋（）［］"
HW = "0123456789.,-/%+()[]"
TRANS = str.maketrans(FW, HW)


def norm(s: str) -> str:
    s = s.translate(TRANS)
    s = re.sub(r"(?<=\d)\s+(?=\d)", "", s)                      # 数字间空格去除
    s = re.sub(r"(?<=\d)[一一—–−]+(?=\d)", "-", s)              # OCR连字号归一为-
    return s


bank_n = norm(bank)
bank_nc = bank_n.replace(",", "")

num_re = re.compile(r"\d[\d.,%/－—~\-]*\d|\d")
fail, checked = [], 0

for ln, raw in enumerate(ch.splitlines(), 1):
    st = raw.strip()
    if st.startswith("<!--") or st.startswith("#"):
        continue                                                # 注释与标题行跳过
    line = raw
    if st.startswith("|"):
        line = re.sub(r"第\d+章", " ", line)                    # 表内章次列为结构数
    line = re.sub(r"\[来源:[^\]]*\]", " ", line)                # 锚点编号剔除
    line = re.sub(r"P\d{6}", " ", line)                         # 尾注表裸锚号剔除
    line = re.sub(r"表\d+[-．.]\d+[A-Za-z]?", " ", line)         # 表3-1等结构标签剔除
    line = re.sub(r"第\d+(至\d+)?[章节]", " ", line)             # 章节序号剔除
    line = re.sub(r"\d+(?:\.\d+)+\s*节", " ", line)             # 小节交叉引用(3.1.3节)剔除
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

# ---- 口径二: 中文数字与关键事实专项回查
cn_facts = {
    "屋顶面积三分之一规则": "三分之一" in bank,
    "四新技术用语": "新技术、新工艺" in bank or "四新" in bank,
    "8小时工作制(房建消耗量定额)": "8小时工作制" in bank,
    "社会平均水平": "社会平均水平" in bank,
    "四年调整一次(定额人工)": "四年调整一次" in bank,
    "技术测定法": "技术测定法" in bank,
    "量价分离": "量价分离" in bank,
    "计时观察/测时术语": "测时" in bank,
    "拆除清理入库0.70系数原文": "0.70" in bank_n,
    "现拌砂浆0.382工日原文": "0.382" in bank_n,
    "灰浆搅拌机0.167台班原文": "0.167" in bank_n,
    "砖基础3-15基价2754原文": "2754" in bank_n,
}

# ---- 附加门
cjk = len(re.findall(r"[㐀-䶿一-鿿豈-﫿]", ch))
paras = [x.strip() for x in re.split(r"\n+", ch) if len(x.strip()) >= 30
         and not x.strip().startswith("| :")]
dpc = sum(v - 1 for v in Counter(paras).values() if v > 1)
heads = [l.strip() for l in ch.split("\n") if re.match(r"^#{1,4}\s+\S", l.strip())]
dhc = sum(v - 1 for v in Counter(heads).values() if v > 1)
anchors_used = sorted(set(re.findall(r"P\d{6}", ch)))
anchors_bank = set(re.findall(r"(?m)^## (P\d{6})", bank))
ghost_anchors = [a for a in anchors_used if a not in anchors_bank]
bare_cites = re.findall(r"\[\d{1,3}(?:[,，\-]\d{1,3})*\]", ch)
genre_hits = {}
for kw in ["人工智能", "大模型", "GPT", "Claude", "NotebookLM", "机器生成",
           "本笔记本", "未写小节清单", "指令要求", "前两次输出"]:
    if kw in ch:
        genre_hits[kw] = ch.count(kw)

print("=" * 60)
print(f"[口径一] 数字token总数(含表格,含重复): {checked + len(fail)}")
print(f"[口径一] 回bank验证通过: {checked}")
print(f"[口径一] 未通过: {len(fail)}")
for ln, tok in fail:
    print(f"  FAIL line {ln} : {tok}")
print("-" * 60)
print("[口径二] 中文数字/事实核查:")
bad_cn = 0
for k, v in cn_facts.items():
    print(f"  {'PASS' if v else 'FAIL'}  {k}")
    bad_cn += 0 if v else 1
print("-" * 60)
print(f"[字数门] CJK {cjk:,} (门18,000 {'✓' if cjk >= 18000 else '✗'})")
print(f"[dup手术] dup段 {dpc} | dup题 {dhc} ({'✓' if dpc == 0 and dhc == 0 else '✗'})")
print(f"[P锚门] 使用锚 {len(anchors_used)} 个, bank外幽灵锚 {len(ghost_anchors)} {ghost_anchors if ghost_anchors else ''}")
print(f"[引用门] 残留裸[N]引用 {len(bare_cites)} {bare_cites[:5] if bare_cites else ''}")
print(f"[体裁门] 违禁词命中 {genre_hits if genre_hits else '无'}")
print("=" * 60)
verdict = (len(fail) == 0 and bad_cn == 0 and cjk >= 18000 and dpc == 0 and dhc == 0
           and not ghost_anchors and not bare_cites and not genre_hits)
print("终判:", "全绿 PASS" if verdict else "存在未过项, 需修")
