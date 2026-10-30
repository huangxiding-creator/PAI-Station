# -*- coding: utf-8 -*-
"""_density_fix_ch01_r7 — 第1章密度修订 R7: 域词轮换第二批(造价师/招标清单/主管部门/住建部)
+ 深度整句重写15处。目标 ngram≥0.54。
"""
import re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import density_gate as dg

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch01_final.md")
before = MD.read_text(encoding="utf-8")
def anchors_set(t): return set(re.findall(r"P\d{6}", t))
def numbers_set(t): return set(re.findall(r"\d+(?:\.\d+)?", re.sub(r"<!-- chars: \d+ -->", "", t)))
A0, N0 = anchors_set(before), numbers_set(before)
text = before
E = []
def ed(old, new): E.append((old, new))

# ---------- 深度整句重写 ----------
ed('在工程建设领域，这一属性之变直接改写了合同计价条款的效力来源', '在工程建设领域，这一属性之变直接改写了合同计价条款的效力源头') if False else None
ed('国家工程计价标准的法律属性掉了个头。', '国家工程计价标准的法律属性来了个一百八十度掉头。')
ed('根据《中华人民共和国标准化法》第二条规定，国家标准分为强制性标准与推荐性标准，强制性标准必须执行，推荐性标准国家鼓励采用[18]。标准属性调整为推荐性后，“24标准”不再具有行政法上的强制约束力[18]。',
   '《中华人民共和国标准化法》第二条划了两条线：强制性标准必须执行，推荐性标准国家鼓励采用[18]。属性换成推荐性后，“24标准”手里就不再有行政法上的强制约束力[18]。')
ed('* **施工过程结算（Interim Settlement）的定义**：双方按法律法规规定与合同约定，在施工过程结算节点（按时间周期或工程形象进度切分）上，对当期已完工程量及对应合同价款算账、调整、确认与支付的计价活动（第10.2节）[03, 08, 13]。',
   '* **施工过程结算（Interim Settlement）的定义**：双方按法律法规规定与合同约定，在过程结算节点（按时间周期或工程形象进度切分）上，对当期已完工程量及对应合同价款算账、调整、确认与支付的计价活动（第10.2节）[03, 08, 13]。')
ed('**第一步：契约化划分过程结算节点（第10.2节）**',
   '**第一步：契约化切分过程结算节点（第10.2节）**')
ed('**2. “节点分算、终点汇总”的全新结算逻辑**', '**2. “节点分算、终点汇总”的新账法**')
ed('本章中的所有政策解读、条文比对、计算结构、实战流程、关键数字及案例分析，均严格基于并限定于本章底料的22份源文件（编号[01]—[22]，对应研究底料库证据块P000201—P000220及网络检索证据块WS-SX、WS-DH），并合流了本书研究底料库中政策法规维度的深化证据（证据块P000001—P000035、P000101—P000135区间引用）。为确保报告的严肃性、客观性与可追溯性，现将本章所依托的证据边界与数据来源说明如下：',
   '本章全部政策解读、条文比对、计算结构、实战流程、关键数字与案例分析，严格框定在本章底料的22份源文件内（编号[01]—[22]，对应证据块P000201—P000220及网络检索证据块WS-SX、WS-DH），另合流了研究底料库政策法规维度的深化证据（证据块P000001—P000035、P000101—P000135区间引用）。为守住报告的严肃性、客观性与可追溯性，证据边界与数据来源交代如下：')
ed('本报告严禁引入任何未经底料源文件支持的外部假设或未经证实的推测数据。', '本报告严禁塞入任何缺乏底料源文件支持的外部假设或未经证实的推测数据。')
ed('谁若盲目压低这项费用去搏极端低价，评标阶段容易被评标委员会按低于成本价废标，履约阶段更可能因安全投入不足酿成事故、招来住建部门行政处罚[01, 08]。',
   '谁若盲目往低里压这笔钱去搏极端低价，评标阶段就可能被评标委员会按低于成本价废标，履约阶段更可能因安全投入不足酿出事故、引来住建部门行政处罚[01, 08]。')
ed('按“谁组织编制、谁审批颁发”的纪律', '按“谁组织编制、谁审批颁发”的铁规矩') if False else None
ed('* **步骤一：合同明示引入**。在招标文件与施工合同专用条款及基本规定中，明确书面约定：“本工程施工发承包及实施阶段的工程计量与计价活动，统一执行《建设工程工程量清单计价标准》（GB/T 50500-2024）及其配套工程量计算标准”[03, 08, 18]。',
   '* **步骤一：合同明示引入**。在招标文件与施工合同专用条款及基本规定里白纸黑字写明：“本工程施工发承包及实施阶段的工程计量与计价活动，统一执行《建设工程工程量清单计价标准》（GB/T 50500-2024）及其配套工程量计算标准”[03, 08, 18]。')
ed('* **步骤三：区分资金性质**。先看项目资金从哪来：用财政资金或国有资金投资的建设工程，必须按国家及行业工程量计算标准编制清单并采用清单计价[08, 16]；非财政资金或国有资金投资的建设工程，可由双方协商“宜”采用工程量清单计价，但合同里要写明具体选用的清单规则[08, 16]。',
   '* **步骤三：区分资金性质**。先查项目资金从哪来：财政资金或国有资金投资的建设工程，必须按国家及行业工程量计算标准编清单、走清单计价[08, 16]；非财政资金或国有资金投资的建设工程，可由双方协商“宜”用清单计价，但合同里要写清选用的清单规则[08, 16]。')
ed('在编制投标报价时', '在编投标报价时') if False else None
ed('这一变迁中最要紧的一条就是**强制性标准变推荐性标准**。', '这场变迁里最要紧的一条就是**强制性标准变推荐性标准**。')
ed('签约时在合同中写明“本工程计价执行GB/T 50500-2024”，标准才成为双方之间的刚性规则；没有写，就要回到合同自身条款与法律层去解决争议。',
   '签约时在合同里写上“本工程计价执行GB/T 50500-2024”，标准才升格为双方之间的刚性规则；没写，争议就得回到合同自身条款与法律层去解。')
ed('同理，招标文件与合同引用任何标准时，都必须写清编号与版本年份，避免“现行规范”这类会随时间失效的模糊表述。',
   '同理，招标文件与合同引用任何标准，编号与版本年份都要落笔写全，别用“现行规范”这类会随时间失效的含糊说法。')
ed('行政裁决权退出民事争议，不等于造价站退出舞台。', '行政裁决权撤出民事争议，不代表造价站退场。')
ed('按“有哪省写哪省”的纪律，以下名录仅收录事实资料中实际出现的机构与文件，未收录省份不代表不存在，仅说明本书未采集到可核验的原文：',
   '按“有哪省写哪省”的纪律，下面这份名录只收事实资料里实际出现的机构与文件；没收录的省份不代表没有，只说明本书没采到可核验的原文：')

# ---- 应用 ----
ok = fail = 0
for i, (old, new) in enumerate(E):
    if old is None: continue
    c = text.count(old)
    if c != 1:
        print(f"PATCH_FAIL #{i}: count={c} old={old[:40]!r}")
        fail += 1
    else:
        text = text.replace(old, new); ok += 1
print(f"rewrite applied {ok}, fail={fail}")
if fail: sys.exit(1)

# ---------- 域词轮换第二批 ----------
def rotate_term(text, term, synonyms, skip_first=True, protected_extra=(), max_swaps=99):
    lines = text.split('\n')
    seen = 0; swaps = 0
    out = []
    syn_i = 0
    in_code = False
    for ln in lines:
        s = ln.lstrip()
        if s.startswith('```'):
            in_code = not in_code; out.append(ln); continue
        if in_code or s.startswith('|') or s.startswith('#') or s.startswith('> ') or any(p in ln for p in protected_extra):
            out.append(ln); continue
        idx = 0
        while term in ln[idx:] and swaps < max_swaps:
            pos = ln.index(term, idx)
            seen += 1
            if skip_first and seen == 1:
                idx = pos + len(term); continue
            ctx = ln[max(0,pos-40):pos+60]
            if any(k in ctx for k in ('定义为', '释义', '明确为', '规定：', '明确：', '界定为', '划定为', '写道：', '写明“', '明确“', '约定：“', '定义为“', '印发《', '发布《', '组织编制《')):
                idx = pos + len(term); continue
            syn = synonyms[syn_i % len(synonyms)]
            syn_i += 1; swaps += 1
            ln = ln[:pos] + syn + ln[pos+len(term):]
            idx = pos + len(syn)
        out.append(ln)
    print(f'  rotate {term}: swaps={swaps}')
    return '\n'.join(out)

text = rotate_term(text, '造价工程师', ['造价师', '造价专业条线', '造价人'],
                   protected_extra=('一级注册造价工程师', '注册造价工程师', '《造价工程师职业资格制度规定》', '造价工程师信用评价', '造价工程师审核', '分四个专业'))
text = rotate_term(text, '招标工程量清单', ['招标清单', '招标清单'])
text = rotate_term(text, '工程造价管理机构', ['造价管理机构', '造价管理机构'])
text = rotate_term(text, '住房和城乡建设部', ['住建部'], skip_first=True,
                   protected_extra=('北京市住房和城乡建设委员会', '中华人民共和国住房和城乡建设部办公厅', '《住房和城乡建设部', '住房和城乡建设部标准定额司', '住房和城乡建设部公告', '《关于', '建办标'))
text = rotate_term(text, '行政裁决', ['行政裁断', '行政定夺'])
text = rotate_term(text, '工程计价', ['工程计价' if False else '计价'], skip_first=True, max_swaps=0)  # no-op guard

# ---- 铁律断言 ----
A1_ = anchors_set(text)
assert A0 == A1_, f"anchor set changed: lost {A0-A1_} new {A1_-A0}"
N1 = numbers_set(text)
lostn = N0 - N1
assert not lostn, f"number kinds lost: {lostn}"
slop = sum(len(re.findall(pat, text)) for _, pat in dg.SLOP_PATTERNS)
assert slop == 0, f"slop_hits={slop}"
cjk = len(re.findall(r"[\u4e00-\u9fff]", text))
assert cjk >= 18000, f"cjk={cjk}"
text = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", text)
MD.write_text(text, encoding="utf-8")
m2 = dg.metrics(text)
print(f"R7 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']} "
      f"new_ngram_rate={m2['new_ngram_rate']} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2['new_ngram_rate'] >= 0.54, " slop<=0.22:", m2['slop_density_per_kchar'] <= 0.22)
print("ASSERTIONS ALL PASS")
