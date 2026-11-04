# -*- coding: utf-8 -*-
"""RadarCycle 轻量轮 1101 14:06 全量分析: 全史信号+时间加权(近3h加倍)+样板文降噪+主题聚合+三族过滤+KB禁推标记"""
import json, re, collections, datetime as dt

LEDGER = "ledger/signals.jsonl"
NOW = dt.datetime(2026, 11, 1, 14, 6, 0)

rows = []
with open(LEDGER, encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line: continue
        try: rows.append(json.loads(line))
        except: pass

# 平台样板文/噪声过滤(数字零造假: 噪声不入聚合)
NOISE_PAT = re.compile(
    r"channels@tencent\.com|MCN招募计划|视频号.{0,6}创作|创作者服务中心|关注公众号|长按识别|扫码|"
    r"点击(蓝字|链接|右上角)|往期(推荐|回顾)|觉得不错请|转发|收藏|点赞|在看|留言区|后台回复|"
    r"版权声明|免责声明|侵权请联系|来源.{0,12}网络|图源|侵删|参考文献.{0,4}$|官方(客服|微信)|加入社群|知识星球|星球",
    re.I)

def parse_ts(s):
    try: return dt.datetime.strptime(s[:19], "%Y-%m-%d %H:%M:%S")
    except: return None

def weight(ts):
    if ts is None: return 0.25
    age_h = (NOW - ts).total_seconds()/3600
    if age_h < 0: age_h = 0
    if age_h <= 3: return 2.0
    if age_h <= 24: return 1.0
    if age_h <= 72: return 0.5
    return 0.25

KB_PAT = re.compile(r"知识库|KB|kb[_-]|ima|文库广场|蓝皮书语料", re.I)
themes = collections.defaultdict(lambda: {"w":0.0,"n":0,"recent3h":0,"samples":[],"urg":[], "faces":collections.Counter()})
src_stat = collections.Counter()
noise_n = 0

for r in rows:
    sig = r.get("signal", {})
    st = sig.get("source_type","?")
    src_stat[st] += 1
    ts = parse_ts(sig.get("ts","") or r.get("ingested_at",""))
    w = weight(ts)
    p = sig.get("payload", {}) or {}
    if st == "viaim":
        text = (p.get("title","") + " " + p.get("overview","") or "")
    elif st == "wechat_insight":
        text = p.get("demand_quote","") or ""
    else:
        text = (p.get("title","") or p.get("demand","") or p.get("text","") or json.dumps(p, ensure_ascii=False))
    if NOISE_PAT.search(text):
        noise_n += 1
        continue
    jtbd = p.get("jtbd", {}) or {}
    trig = jtbd.get("trigger","") or ""
    urg = p.get("urgency","")
    face = p.get("source_face","") or st
    is_kb = bool(KB_PAT.search(text)) or ("知识库" in str(jtbd))

    buckets = []
    t = text + " " + trig
    for key, pats in {
        "EPC/工程/水利/眼镜": [r"EPC", r"水利", r"工程", r"眼镜", r"施工", r"监理"],
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
            if re.search(pat, text + " " + trig, re.I):
                buckets.append(key); break
    if not buckets: buckets = ["__其他__"]
    for b in buckets:
        d = themes[b]; d["w"] += w; d["n"] += 1
        if ts and 0 <= (NOW-ts).total_seconds() <= 3*3600: d["recent3h"] += 1
        if urg: d["urg"].append(urg)
        d["faces"][face] += 1
        if len(d["samples"]) < 5: d["samples"].append(text[:70])

print(f"=== 全量分析 {len(rows)} 条 | 时间={NOW} | 降噪剔除={noise_n} ===")
print("来源分布:", dict(src_stat))
print("\n=== 主题加权榜 (w=时间加权和, n=条数, r3h=近3小时条数) ===")
for b, d in sorted(themes.items(), key=lambda kv: -kv[1]["w"]):
    print(f"[{b}] w={d['w']:.1f} n={d['n']} r3h={d['recent3h']} faces={dict(d['faces'].most_common(4))} urg={collections.Counter(d['urg'])}")
    for s in d["samples"][:4]: print(f"   样本: {s}")

print("\n=== 近24小时非样板信号明细(方向研判) ===")
recent = [(r, parse_ts(r.get("signal",{}).get("ts","") or r.get("ingested_at",""))) for r in rows]
recent = [(r,t) for r,t in recent if t and 0 <= (NOW-t).total_seconds() <= 24*3600]
shown = 0
for r, t in sorted(recent, key=lambda x: -x[1].timestamp())[:60]:
    s = r["signal"]; p = s.get("payload",{})
    txt = p.get("demand_quote","") or p.get("title","") or str(p.get("text",""))[:60]
    if NOISE_PAT.search(txt): continue
    shown += 1
    urg = p.get("urgency",""); face = p.get("source_face","")
    jt = p.get("jtbd",{}) or {}
    mark = "★3h" if (NOW-t).total_seconds() <= 3*3600 else "  24h"
    print(f"  {t:%m-%d %H:%M} {mark} [{s.get('source_type')}/{face}] urg={urg} score={p.get('score','')} | {txt[:80]} | job={str(jt.get('job_statement',''))[:45]}")
    if shown >= 35: break
print(f"近24小时总数(含样板): {len(recent)}, 展示非样板: {shown}")
print(f"\n近3h窗(08:05-11:05)总数: {sum(1 for r,t in recent if (NOW-t).total_seconds() <= 3*3600)}")
