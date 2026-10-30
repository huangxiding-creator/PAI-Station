# -*- coding: utf-8 -*-
"""RadarCycle 轻量轮 1030 首巡: 全史信号+时间加权(近3h加倍)+主题聚合+三族过滤+KB禁推标记"""
import json, re, collections, datetime as dt

LEDGER = "ledger/signals.jsonl"
NOW = dt.datetime.now()

rows = []
with open(LEDGER, encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line: continue
        try: rows.append(json.loads(line))
        except: pass

def parse_ts(s):
    try: return dt.datetime.strptime(s[:19], "%Y-%m-%d %H:%M:%S")
    except: return None

# 时间加权: 近3h=2.0, 3-24h=1.0, 1-3d=0.5, >3d=0.25 (历史模式不丢)
def weight(ts):
    if ts is None: return 0.25
    age_h = (NOW - ts).total_seconds()/3600
    if age_h < 0: age_h = 0
    if age_h <= 3: return 2.0
    if age_h <= 24: return 1.0
    if age_h <= 72: return 0.5
    return 0.25

KB_PAT = re.compile(r"知识库|KB|kb[_-]|ima|文库广场|蓝皮书语料", re.I)
stats = collections.Counter(); themes = collections.defaultdict(lambda: {"w":0.0,"n":0,"recent3h":0,"samples":[],"urg":[], "faces":collections.Counter()})
src_stat = collections.Counter()

for r in rows:
    sig = r.get("signal", {})
    st = sig.get("source_type","?")
    src_stat[st] += 1
    ts = parse_ts(sig.get("ts","") or r.get("ingested_at",""))
    w = weight(ts)
    p = sig.get("payload", {}) or {}
    if st == "viaim":
        text = ((p.get("title","") or "") + " " + (p.get("overview","") or "")).strip()
    elif st in ("wechat_insight","demand_ledger"):
        text = p.get("demand_quote","") or ""
    else:
        text = (p.get("title","") or p.get("demand","") or p.get("text","") or json.dumps(p, ensure_ascii=False))
    jtbd = p.get("jtbd", {}) or {}
    trig = jtbd.get("trigger","") or ""
    urg = p.get("urgency","")
    face = p.get("source_face","") or st
    is_kb = bool(KB_PAT.search(text)) or ("知识库" in str(jtbd))

    buckets = []
    t = text + " " + trig
    for key, pats in {
        "EPC/工程/水利/水利安全": [r"EPC", r"水利", r"工程", r"眼镜", r"施工", r"监理"],
        "造价/计价/成本/招采": [r"造价", r"计价", r"定额", r"成本", r"招采", r"投标|标书|招标"],
        "报告/研报/研究": [r"研报|研究报告|报告", r"洞察", r"白皮书"],
        "AI工具/自动化/引擎": [r"AI", r"自动", r"引擎", r"智能体", r"agent", r"大模型"],
        "培训/教育": [r"培训", r"课程", r"教育"],
        "法律/合同/合规": [r"法律", r"合同", r"合规", r"索赔"],
        "营销/私域/获客": [r"私域", r"获客", r"营销", r"朋友圈", r"公众号"],
        "海外/出海": [r"海外", r"出海", r"国际", r"境外"],
        "知识库类(KB禁推)": [r"知识库", r"\bima\b", r"文库广场"],
    }.items():
        for pat in pats:
            if re.search(pat, t, re.I):
                buckets.append(key); break
    if not buckets: buckets = ["__其他__"]
    for b in buckets:
        d = themes[b]; d["w"] += w; d["n"] += 1
        if ts and -3600 <= (NOW-ts).total_seconds() <= 3*3600: d["recent3h"] += 1
        if urg: d["urg"].append(urg)
        d["faces"][face] += 1
        if len(d["samples"]) < 4 and text: d["samples"].append(text[:60])

print(f"=== 全量分析 {len(rows)} 条 | 时间={NOW} ===")
print("来源分布:", dict(src_stat))
print("\n=== 主题加权榜 (w=时间加权和, n=条数, r3h=近3小时条数) ===")
for b, d in sorted(themes.items(), key=lambda kv: -kv[1]["w"]):
    print(f"[{b}] w={d['w']:.1f} n={d['n']} r3h={d['recent3h']} faces={dict(d['faces'])} urg={collections.Counter(d['urg'])}")
    for s in d["samples"][:3]: print(f"   样本: {s}")

# 近3小时明细 (最新需求方向主导)
print("\n=== 近3小时窗口信号明细(权重加倍) ===")
recent = [(r, parse_ts(r.get("signal",{}).get("ts","") or r.get("ingested_at",""))) for r in rows]
recent = [(r,t) for r,t in recent if t and 0 <= (NOW-t).total_seconds() <= 3*3600]
for r, t in recent[:45]:
    s = r["signal"]; p = s.get("payload",{})
    txt = p.get("demand_quote","") or p.get("title","") or str(p.get("text",""))[:50]
    urg = p.get("urgency",""); face = p.get("source_face","")
    jt = p.get("jtbd",{}) or {}
    print(f"  {t:%m-%d %H:%M} [{s.get('source_type')}/{face}] urg={urg} score={p.get('score','')} | {txt[:70]} | job={str(jt.get('job_statement',''))[:50]}")
print(f"近3小时总数: {len(recent)}")

# 近24h viaim 录音明细(高价值语音想法)
print("\n=== 近24h viaim 录音 ===")
for r in rows:
    s = r.get("signal",{})
    if s.get("source_type") != "viaim": continue
    ts = parse_ts(s.get("ts",""))
    if not ts or (NOW-ts).total_seconds() > 24*3600: continue
    p = s.get("payload",{})
    print(f"  {ts:%m-%d %H:%M} [{p.get('duration_sec',0):.0f}s] {p.get('title','')[:40]} | {(p.get('overview','') or '')[:120]}")
