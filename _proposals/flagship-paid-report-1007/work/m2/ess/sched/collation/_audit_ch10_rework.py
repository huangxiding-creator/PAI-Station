# -*- coding: utf-8 -*-
"""ch10 rework audit: CJK count, anchor ghost check, forbidden terms, NBLM residue."""
import re, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

BASE = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess/sched/"
FINAL = BASE + "_ch10_final.md"
NBLM = BASE + "_ch10_nblm.md"
BANK = BASE + "bank_ch10.md"

t = open(FINAL, encoding="utf-8").read()
src = open(NBLM, encoding="utf-8").read()
bank = open(BANK, encoding="utf-8").read()

cjk = len(re.findall(r"[\u4e00-\u9fff]", t))
src_cjk = len(re.findall(r"[\u4e00-\u9fff]", src))
print("final CJK:", cjk, "| source CJK:", src_cjk, "| gate>=15000:", cjk >= 15000, "| >=source:", cjk >= src_cjk)
print("final bytes:", len(t.encode("utf-8")), "| source bytes:", len(src.encode("utf-8")))

bankset = set(re.findall(r"^## (P\d{6})", bank, flags=re.M))
used = set(re.findall(r"P\d{6}", t))
inst = len(re.findall(r"P\d{6}", t))
print("bank anchors total:", len(bankset))
print("used anchors:", sorted(used))
print("ghost:", sorted(used - bankset))
print("P instances in final:", inst)
print("[N]-style refs:", len(re.findall(r"\[\d{1,2}\]", t)), "| 源N refs:", len(re.findall(r"源\d{1,2}", t)), "| [来源 refs:", len(re.findall(r"\[来源", t)))

# computer/AI terms per rework order + production-line scan list
terms = ["深度学习", "端到端", "贝叶斯", "加权投票", "特征提取", "张量分解", "稀疏表示", "残差网络",
         "算法", "像素", "传感器", "光谱角映射", "均方根误差", "遥感", "多光谱", "高光谱", "SAR",
         "LiDAR", "雷达", "全色", "夜光", "立体", "视频星", "测绘", "成像", "波段的", "反演",
         "AI", "大模型", "语料", "token", "API", "Studio", "NBLM", "NB稿", "抓取", "HTTP",
         "机器学习", "神经网络", "数据融合", "配准", "分类", "像元", "图谱", "模态"]
hits = {w: len(re.findall(re.escape(w), t)) for w in terms if w in t}
print("term hits:", hits)
