# -*- coding: utf-8 -*-
"""skeleton_swap.py — 把骨架虚词换成非骨架同义表达, 抬新词率(零token成本+新type)
用法: py -X utf8 skeleton_swap.py <file> [apply]
默认 dry-run: 打印每处替换与指标, 不写盘; apply 才写。
"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, SKELETON_GRAMS, metrics

PATH = sys.argv[1]
APPLY = len(sys.argv) > 2 and sys.argv[2] == "apply"
text = open(PATH, encoding="utf-8").read()
orig = text

SYN = {
    "通过": ["经由", "凭着", "靠着"],
    "进行": ["展开", "推进", "着手"],
    "可以": ["能", "得以", "做得到"],
    "需要": ["须要", "有必要"],
    "能够": ["得以", "做得到"],
    "成为": ["变成", "蜕变为"],
    "包括": ["涵盖", "囊括"],
    "例如": ["譬如", "举例说"],
    "此外": ["再者", "另有一层"],
    "另外": ["另一头", "换个角度"],
    "随着": ["伴着", "眼看着"],
    "因此": ["故而", "由此", "于是"],
    "所以": ["故而", "于是"],
    "然而": ["可是", "不过"],
    "但是": ["可是", "不过"],
    "如果": ["倘若", "假使", "要是", "万一"],
    "已经": ["早已", "早就", "业已"],
    "以及": ["连同", "外加"],
    "目前": ["眼下", "当下"],
    "现在": ["如今", "眼前"],
    "最终": ["到头来", "末了", "落到最后"],
    "更加": ["愈发", "越发"],
    "情况": ["情形", "局面"],
    "其中": ["这里面", "这中间"],
    "之间": ["中间", "彼此间"],
    "自己": ["自身", "本身"],
    "就是": ["便是", "即是"],
    "还有": ["另有", "再有一条"],
    "一些": ["若干", "数项"],
    "不仅": ["不只", "不止"],
    "而且": ["更兼", "还兼"],
    "因为": ["缘于", "出于", "究其因"],
    "虽然": ["纵然", "固然"],
    "使得": ["让", "致使"],
    "或者": ["或是", "抑或"],
    "许多": ["不少", "一大把"],
    "很多": ["不少", "成堆"],
    "大量": ["成批", "大宗"],
    "部分": ["某些", "一部分"],
    "整个": ["全盘", "整条"],
    "针对": ["对准", "专对"],
    "根据": ["依据", "按"],
    "按照": ["依着", "照着"],
    "由于": ["缘于", "出于"],
    "无论": ["不论"],
    "只有": ["唯有", "单凭"],
    "即使": ["即便"],
    "曾经": ["一度"],
    "立刻": ["当即", "当场"],
    "随后": ["旋即"],
    "这样": ["如此"],
    "这些": ["此番", "这批"],
    "水平": ["水准"],
    "时候": ["当口", "时分"],
    "依然": ["照旧"],
}
CAP = {"这些": 5, "其中": 3, "可以": 12, "已经": 10, "因为": 8, "最终": 8, "自己": 6, "就是": 5, "之间": 3, "部分": 6, "同时": 5}

def protected(line, i, w):
    """上下文守卫: 返回 True 则跳过"""
    prev = line[i-1] if i > 0 else ""
    nxt = line[i+len(w)] if i+len(w) < len(line) else ""
    after6 = line[i+len(w):i+len(w)+6]
    if w == "通过" and (nxt in "决议审核审批票" or prev in "国会部局"): return True
    if w == "部分" and prev not in "，、。：；！？也其大绝大部全一二三四五六七八九" and prev != "": return True
    if w == "就是" and (prev == "也" or nxt == "说"): return True
    if w == "还是": return True  # 语义双关风险高, 全跳
    if w == "最后" and not (prev in "。；！？\n" or i == 0): return True
    if w == "最后" and nxt not in "，。、；": return True
    if w == "只有" and re.search(r"[\d%]", after6): return True
    if w == "达到" and re.search(r"[\d]", after6[:3]): return True
    if w == "同时" and nxt not in "一同步启开": return True  # 仅动词前状语
    if w == "随后" and nxt == "的": return True
    if w == "之间" and prev in "年月天周小时kKMWT%": return True
    if w == "以及" and prev in "，、；": return True
    if w == "使得" and prev in "，、。；": return True
    return False

def process(line):
    if line.startswith(("|", "#", "> 出品", "（本章完")): return line, 0
    n = 0
    for w, syns in SYN.items():
        cap = CAP.get(w, 99)
        done = 0
        start = 0
        while done < cap:
            i = line.find(w, start)
            if i < 0: break
            start = i + len(w)
            if protected(line, i, w): continue
            s = syns[done % len(syns)]
            line = line[:i] + s + line[i+len(w):]
            start = i + len(s)
            done += 1; n += 1
            print(f"  SWAP {w}->{s}: …{line[max(0,i-12):i+len(s)+12]}…")
    return line, n

lines = text.split("\n")
out, total = [], 0
for line in lines:
    nl, n = process(line)
    out.append(nl); total += n
text = "\n".join(out)

# 完整性
d0 = collections.Counter(re.findall(r"\d+", orig)); d1 = collections.Counter(re.findall(r"\d+", text))
if d0 != d1: print("DIGIT MISMATCH — 中止"); sys.exit(1)
p0 = re.findall(r"P\d{6}", orig); p1 = re.findall(r"P\d{6}", text)
if p0 != p1: print("ANCHOR MISMATCH — 中止"); sys.exit(1)
h0 = [l for l in orig.split("\n") if l.startswith("#")]; h1 = [l for l in text.split("\n") if l.startswith("#")]
if h0 != h1: print("HEADING MISMATCH — 中止"); sys.exit(1)
t0 = [l for l in orig.split("\n") if l.startswith("|")]; t1 = [l for l in text.split("\n") if l.startswith("|")]
if t0 != t1: print("TABLE MISMATCH — 中止"); sys.exit(1)
for _, pat in SLOP_PATTERNS:
    h = re.findall(pat, text)
    if h: print(f"SLOP REGRESSED: {pat} x{len(h)} — 中止"); sys.exit(1)

mt0, mt1 = metrics(orig), metrics(text)
print(f"\nswaps={total}")
print(f"BEFORE cjk={mt0['cjk_chars']} rate={mt0['new_ngram_rate']} redund={mt0['redundancy_ratio']}")
print(f"AFTER  cjk={mt1['cjk_chars']} rate={mt1['new_ngram_rate']} redund={mt1['redundancy_ratio']} slop={mt1['slop_hits']}")
if APPLY:
    open(PATH, "w", encoding="utf-8", newline="\n").write(text)
    print("WRITTEN")
else:
    print("DRY-RUN (未写盘)")
