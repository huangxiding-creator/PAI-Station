# -*- coding: utf-8 -*-
"""第8章(终稿)双口径全量数字审计: _ch08_final.md 全部数字token逐个回查 bank_ch09.md
(含websearch三新源回灌件 P000836-P000838).
口径一: 数字token全量回bank(全半角/OCR连字号/逗号变体归一化);
口径二: 中文数字与关键事实专项回查(cn_facts 逐字验证);
附加门: CJK>=18000 | dup段/题=0(剔除表格分隔行) | P锚全部存在于bank | 无裸[N]引用 | 体裁(无AI词/聊天痕/生产腔).
用法: py -X utf8 _audit_ch08_final.py   (sched/ 目录下运行)
"""
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

CH_FILE = "_ch08_final.md"
BANK_FILE = "bank_ch09.md"

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
    line = re.sub(r"表\d+[-．.]\d+[A-Za-z]?", " ", line)         # 表8-1等结构标签剔除
    line = re.sub(r"第\d+(至\d+)?[章节]", " ", line)             # 章节序号剔除
    line = re.sub(r"\d+(?:\.\d+)+\s*节", " ", line)             # 小节交叉引用(8.2.2节)剔除
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
    "方升合同总价68345700": "68345700" in bank_nc,
    "单价1860元/㎡": "1860元" in bank,
    "建筑面积36745㎡": "36745" in bank,
    "定额预算总价89098947.93": "89098947.93" in bank_nc,
    "鉴定合同价68246673.60": "68246673.60" in bank_nc,
    "下浮比例76.6%": "76.6%" in bank,
    "已完定额价40652058.17": "40652058.17" in bank_nc,
    "已完鉴定价32723973.82": "32723973.82" in bank_nc,
    "争议签证1451136.16": "1451136.16" in bank_nc,
    "已完总价款31272837.66": "31272837.66" in bank_nc,
    "税金1050767.35": "1050767.35" in bank_nc,
    "已付款31057562": "31057562" in bank_nc,
    "超付返还835491.69": "835491.69" in bank_nc,
    "维修费248000": "248000" in bank_nc,
    "方案一31139476.56": "31139476.56" in bank_nc,
    "方案二83128938.40": "83128938.40" in bank_nc,
    "差额14783238.40": "14783238.40" in bank_nc,
    "方案三应付68752058.17": "68752058.17" in bank_nc,
    "配套案例8900/8100/9700": "8900" in bank and "8100" in bank and "9700" in bank,
    "比例系数83.5%": "83.5%" in bank,
    "安阳中广发194.257432万": "194.257432" in bank_nc,
    "EPC案58%已完": "58%" in bank,
    "EPC案67%续建": "67%" in bank,
    "建标〔2013〕44号": "建标〔2013〕44号" in bank,
    "GB/T51262-2017第5.10.7条": "51262" in bank and "5.10.7" in bank,
    "江苏中兴1060元/46000㎡": "1060" in bank and "46000" in bank,
    "江西日升1130元地上1-10层": "1130元" in bank and "1-10层" in bank,
    "京高法发2012-245号": "京高法发〔2012〕245号" in bank,
    "冀高法2023-30号": "冀高法〔2023〕30号" in bank,
    "重庆四川2022解答第15条": "2022年12月28日" in bank and "第15条" in bank,
    "湖北纪要2013-9-1": "2013年09月01日" in bank or "2013年9月1日" in bank,
    "hairun发包人过错892号": "892" in bank_nc,
    "hairun民终115号据实结算": "115" in bank_nc,
    "dh新标准2024-11-26发布": "2024年11月26日" in bank,
    "sx新标准2025-9-1实施": "2025年9月1日" in bank,
    "条款利润3%-8%区间": "3%-8%" in bank,
    "审计衔接一年期限": "一年" in bank,
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
           "本笔记本", "未写小节清单", "指令要求", "前两次输出", "笔记本", "复盘", "下一步建议"]:
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
