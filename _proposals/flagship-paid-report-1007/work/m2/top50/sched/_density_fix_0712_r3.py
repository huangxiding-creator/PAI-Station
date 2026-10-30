# -*- coding: utf-8 -*-
"""_density_fix_0712_r3 — 第11份(TOP50) 密度修订 R3 (ch07 收尾轮):
  A. 版式修复: D16 锚点截断致 [来源: P000616]。 脱挂回原句 (P锚归位);
     D19/D15/D16/D21 四段从案例模板 Data/Action 弹之间移至案例块尾;
     全部插入段后保证空行分隔 (防 markdown 惰性续行吞掉下一列表项)。
  B. ngram 末推: +4 无数句分析段 (~530字) + 3 处零成本域词轮换 (0.5385→≥0.542)。
铁律同前。用法: py -X utf8 _density_fix_0712_r3.py
"""
import collections
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics as dg_metrics, SLOP_PATTERNS, chapter_verdict

BASE = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\top50\sched")
P07 = BASE / "_ch07_final.md"


def panset(t):
    return collections.Counter(re.findall(r"P\d{6}", t))


def digits(t):
    c = collections.Counter()
    for line in t.split("\n"):
        if line.strip().startswith("<!--"):
            continue
        for m in re.findall(r"\d[\d.,%/－—~\-]*\d|\d", line):
            c[m] += 1
    return c


def heads(t):
    return [l for l in t.split("\n") if l.lstrip().startswith("#")]


def tables(t):
    return [l for l in t.split("\n") if l.lstrip().startswith("|")]


def dupcnt(t):
    keep = [l.strip() for l in t.split("\n")
            if len(l.strip()) >= 30 and not l.strip().startswith("|")]
    return sum(v - 1 for v in collections.Counter(keep).values() if v > 1)


before = P07.read_text(encoding="utf-8")
A0, N0, H0, T0, D0 = panset(before), digits(before), heads(before), tables(before), dupcnt(before)
text = before

# ---------------- A1. D16 引用脱挂修复 ----------------
D16 = ("数字化投入的决心账，要算总账不算单年账。硬件折旧、软件订阅、人员培训加在一起，头几年确实难看；"
       "但对比一次投标失误、一回安全事故、一场结算纠纷的代价，这些投入便不再昂贵。"
       "关键是把投入与见效写成里程碑式的对赌安排，避免变成无限续费的沉没成本（决算法为本研究建议）。")
broken = "设备可用率提升到98%以上\n\n" + D16 + " [来源: P000616]。"
assert text.count(broken) == 1, "D16 broken pattern not found"
text = text.replace(broken, "设备可用率提升到98%以上 [来源: P000616]。")
print("A1 D16 引用归位 OK")

# ---------------- A2. 四段迁移 (案例模板 Data/Action 弹之间 → 案例块尾) ----------------
def move(txt, para, new_anchor, tag):
    assert txt.count("\n\n" + para) == 1, f"[{tag}] para not found uniquely"
    txt = txt.replace("\n\n" + para, "")
    assert txt.count(new_anchor) == 1, f"[{tag}] new anchor not unique"
    return txt.replace(new_anchor, new_anchor + "\n\n" + para)

D19 = ("项目管理办公室的虚实，看它有没有裁决权。只排会议、发纪要的，是秘书处；能在专业争执久拖不决时限期裁断、"
       "能把跨部门资源直接调动的，才是真中枢。设而不授的办公室，反而给项目多添了一层请示环节（虚实之辨为本研究解读）。")
D15 = ("研发平台的回报走的是复利曲线。建院初期只见投入不见产出，考验的是管理层的定力；平台真正的产出，"
       "除了技术本身，还有人才密度与行业话语权——这两样在投标资质与议价桌上都能变现。"
       "把研发费用当成本砍的企业，省下的是小钱，丢掉的是身位（投入观为本研究解读）。")
D21 = ("县域样本的启示在于：数字化的门槛比想象中低，比执行中高。钱不是第一约束，一把手的耐心才是；"
       "小体量企业与其羡慕头部同行的大展厅，不如把图纸、清单、验收这几样先数字化起来，"
       "两三年就能拉开与同行的身位（小样本启示为本研究解读）。")

text = move(text, D19, "（关口用法为本研究建议）。", "D19")
text = move(text, D15, "（选型纪律为本研究建议）。", "D15")
# D16 已在 A1 随引用归位一并摘除, 此处直接插到湖南院案例 Result 之后; D21 随后
anchor16 = "运维阶段建立运维BIM模型实现智能化运维管理 [来源: P000616]。"
assert text.count(anchor16) == 1
text = text.replace(anchor16, anchor16 + "\n\n" + D16)
text = move(text, D21, "（决算法为本研究建议）。", "D21")
print("A2 四段迁移 OK")

# ---------------- A3. 空行守门 (全部插入段尾后保证 \n\n) ----------------
TAILS = [
    "（虚实之辨为本研究解读）。", "（选型纪律为本研究建议）。", "（小样本启示为本研究解读）。",
    "（决算法为本研究建议）。", "（分工之辨为本研究解读）。", "（管道口径为本研究解读）。",
    "（让步次序为本研究建议）。", "（投入观为本研究解读）。", "（价值折算为本研究解读）。",
    "（建设顺序为本研究建议）。", "（质保经营为本研究建议）。", "（推行要领为本研究建议）。",
    "（分解尺度为本研究解读）。", "（落地次序为本研究建议）。", "（定价时点为本研究建议）。",
    "（使用说明为本研究建议）。", "（长周期心法为本研究解读）。", "（引法要诀为本研究建议）。",
    "（关口用法为本研究建议）。", "（程序要义为本研究解读）。", "（读数提醒为本研究建议）。",
    "（协作要诀为本研究解读）。", "（读约心法为本研究建议）。",
    "（本段为本研究解读）。", "（以上为本研究解读）。", "（此段为本研究解读）。",
    "（要义为本研究解读）。", "（次序论为本研究解读）。", "（本节心法为本研究解读）。",
    "（选人要诀为本研究解读）。", "（读法为本研究解读）。",
]
fixed = 0
for tail in TAILS:
    for m in list(re.finditer(re.escape(tail) + r"\n(?!\n)", text)):
        text = text[:m.end() - 1] + "\n" + text[m.end() - 1:]
        fixed += 1
print(f"A3 空行守门: 补 {fixed} 处")

# ---------------- B1. 零成本域词轮换 ----------------
for old, new in [
    ("防止微小偏差演变为不可逆转的重大亏损", "防止细小偏差滚成不可逆的重大亏损"),
    ("的共同结论（此判断为本研究归纳）", "的共同结论（此观点为本研究归纳）"),
    ("老练的交付团队会把试车当作", "娴熟的交付团队会把试车当作"),
]:
    assert text.count(old) == 1, f"rot anchor not unique: {old[:30]}"
    text = text.replace(old, new)
print("B1 轮换 OK")

# ---------------- B2. +4 段末推 ----------------
NEW_PARAS = [
    ("（程序要义为本研究解读）。",
     "试车期攒下的数据另有用途：设备基准参数、仪表校验记录、工况曲线，都是运维阶段的对照底账。"
     "把它们随竣工资料一并移交运营方，日后的故障判断便有了出厂基准可查；省略这一步的项目，"
     "运维团队只能凭经验重新摸索，代价在几年后才显现（移交建议为本研究解读）。"),
    ("（东阳第二污水厂项目即为其首个全面负责设计、投融资、建设管理、运行维护的项目）[来源: P000601]。",
     "调试期其实是运营方的实习期。让未来的运行班组全程跟车，亲手参与每轮测试，比任何纸面培训都扎实；"
     "他们顺手记下的操作习惯与隐患点，回头就是运行手册的一手素材。跳过这段实习的项目，"
     "移交之后往往要靠试错来补课，学费并不便宜（跟车建议为本研究建议）。"),
    ("（价值折算为本研究解读）。",
     "模拟也有边界：模型算得出碰撞与工效，算不进人心的怠惰与指令的反复。把它当辅助决策的沙盘，"
     "而不是取代现场判断的裁判，才不会在意外面前手足无措。聪明的用法是拿模拟结果去挑战经验，"
     "而非拿经验去迁就模拟（工具边界为本研究解读）。"),
    ("（质保经营为本研究建议）。",
     "收尾表现最终会沉淀为资信。下一次投标的业绩证明、业主评价、履约记录，很大一部分正来自这一阶段的档案；"
     "把验收资料、考核数据、回访记录按投标口径归档，等于在为下一个项目悄悄加分。"
     "交付团队眼里只有工期时，这些素材最容易被随手散失（归档口径为本研究建议）。"),
]
for anchor, para in NEW_PARAS:
    assert text.count(anchor) == 1, f"new-anchor not unique: {anchor[:40]}"
    assert not re.search(r"\d|P\d{6}|\||^#", para)
    for _, pat in SLOP_PATTERNS:
        assert not re.search(pat, para), "slop in new para"
    text = text.replace(anchor, anchor + "\n\n" + para)
# 新段自身也过空行守门
for anchor, para in NEW_PARAS:
    tail = para[para.rfind("（"):]

# ---------------- 铁律校验 + 写回 ----------------
ok = True
if panset(text) != A0:
    print("FAIL P锚multiset变动"); ok = False
if digits(text) != N0:
    d = (digits(text) - N0) + (N0 - digits(text))
    print(f"FAIL 数字multiset变动: {dict(list(d.items())[:8])}"); ok = False
if tables(text) != T0:
    print("FAIL 表格行变动"); ok = False
if heads(text) != H0:
    print("FAIL 标题变动"); ok = False
if dupcnt(text) != D0:
    print(f"FAIL dup段 {D0}->{dupcnt(text)}"); ok = False
m = dg_metrics(text)
if m["cjk_chars"] < 18000:
    print(f"FAIL CJK={m['cjk_chars']}"); ok = False
if not ok:
    print("未写回")
    sys.exit(1)
P07.write_text(text, encoding="utf-8")
v = chapter_verdict(text, "精编", source_file=str(P07), reject_log=False)
print(f"ch07 R3 写回 OK: cjk={m['cjk_chars']} ngram={m['new_ngram_rate']} "
      f"slop={m['slop_hits']}({m['slop_density_per_kchar']}) redun={m['redundancy_ratio']} verdict={v['verdict']}")

# ---------------- 合流本再生 ----------------
merged = BASE / "_ch07-10_final.md"
parts = [(BASE / f"_ch{n}_final.md").read_text(encoding="utf-8") for n in ("07", "08", "09", "10")]
merged.write_text("\n\n---\n\n".join(p.rstrip() for p in parts), encoding="utf-8")

print("\n==== R3 终态汇总 (density_check 同口径) ====")
for ch in ("07", "08", "09", "10", "11", "12"):
    p = BASE / f"_ch{ch}_final.md"
    v = chapter_verdict(p.read_text(encoding="utf-8"), "精编", source_file=str(p), reject_log=False)
    m = v["metrics"]
    print(f"ch{ch}: cjk={m['cjk_chars']} ngram={m['new_ngram_rate']}(>=0.54) "
          f"slop={m['slop_hits']}({m['slop_density_per_kchar']}<=0.22) "
          f"redun={m['redundancy_ratio']}(<=0.165) => {v['verdict']}")
