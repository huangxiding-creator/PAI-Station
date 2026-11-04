# -*- coding: utf-8 -*-
"""RadarCycle 轻量轮全量分析 1031 08:05: 全史信号+时间加权(近3h加倍)+主题聚合+三族过滤+KB禁推标记"""
import json, re, collections, datetime as dt, ast

LEDGER = "ledger/signals.jsonl"
NOW = dt.datetime(2026, 10, 31, 8, 5, 30)

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

def weight(ts):
    if ts is None: return 0.25
    age_h = (NOW - ts).total_seconds()/3600
    if age_h < 0: age_h = 0
    if age_h <= 3: return 2.0
    if age_h <= 24: return 1.0
    if age_h <= 72: return 0.5
    return 0.25

KB_PAT = re.compile(r"知识库|KB|kb[_-]|ima|文库广场|蓝皮书语料", re.I)
THEMES = [
    ("EPC/工程/招标/资质/居间", re.compile(r"EPC|总包|分包|招标|中标|投标|资质|居间|工程量|预付款|保证金|央企|施工单位|路面|路基|涵|桥梁|公路|隧道|水利|闸|大坝|黄藏寺|安措费|低价中标|围串标|造价鉴定|签证|结算|审计|定额|下浮|工序|进场|工期")),
    ("造价/计价/计量", re.compile(r"造价|计价|计量|定额|清单|组价|下浮|概算|预算|结算|工程款")),
    ("法律/仲裁/律所/工伤", re.compile(r"仲裁|律师|律所|司法|工伤|法务|合同纠纷|追责|判例|司法解释|风险代理")),
    ("AI/工具/部署/软件", re.compile(r"\bAI\b|人工智能|大模型|GPT|GLM|部署|私有化|软件|SaaS|工具|小程序|自动化|识别|检测算法|眼镜")),
    ("视频号/流量/运营", re.compile(r"视频号|流量券|直播|MCN|运营者|曝光|粉丝|加热|变现")),
    ("报告/读者反馈/迭代", re.compile(r"读者|反馈|第\d+章|报告迭代|口径|样本|复核|数据有误|内容太浅")),
    ("海外/国际工程", re.compile(r"ADNOC|沙特|中东|海外|国际工程|联合体|ICV|属地化|APEC|湾区")),
]

theme_w = collections.Counter()
theme_cnt = collections.Counter()
recent3h = []   # 近3h窗原始条目
kb_hits = []
src_cnt = collections.Counter()
face_cnt = collections.Counter()

for d in rows:
    sig = d.get("signal")
    if isinstance(sig, str):
        try: sig = ast.literal_eval(sig)
        except: sig = {}
    if not isinstance(sig, dict): continue
    st = sig.get("source_type", "?")
    p = sig.get("payload", {}) or {}
    ts = parse_ts(d.get("ingested_at", ""))
    w = weight(ts)
    src_cnt[st] += 1
    text = ""
    if st == "demand_ledger":
        text = str(p.get("demand_quote", ""))
        face_cnt[p.get("source_face", "?")] += 1
    elif st == "wechat_insight":
        text = str(p.get("text", p.get("content", p.get("quote", ""))))
    elif st == "viaim":
        text = str(p.get("title", "") or "") + " " + str(p.get("summary", "") or "")
    elif st == "moments":
        text = str(p.get("text", ""))
    else:
        text = str(p)
    if not text.strip() and st == "viaim":
        text = "(viaim无转写)" + str(p.get("duration_s", ""))
    hit = False
    for name, pat in THEMES:
        if pat.search(text):
            theme_w[name] += w
            theme_cnt[name] += 1
            hit = True
    if not hit:
        theme_w["(其他/噪音)"] += w
        theme_cnt["(其他/噪音)"] += 1
    if KB_PAT.search(text):
        kb_hits.append((d.get("seq"), text[:60]))
    if ts and (NOW - ts).total_seconds() <= 3*3600:
        recent3h.append((d.get("seq"), ts, st, str(p.get("source_face","")), p.get("score"), text[:70]))

print("=== 全史 %d 条 | 源分布: %s" % (len(rows), dict(src_cnt)))
print("=== demand_ledger source_face 分布: %s" % dict(face_cnt))
print("\n=== 主题加权榜 (全史+时间加权, 近3h=2.0/24h=1.0/72h=0.5/更老=0.25) ===")
for name, wsum in theme_w.most_common():
    print("%6.1f  %4d条  %s" % (wsum, theme_cnt[name], name))
print("\n=== 近3h窗 %d 条 ===" % len(recent3h))
for seq, ts, st, face, score, text in recent3h:
    print(seq, ts.strftime("%H:%M"), st, face, score, "|", text)
print("\n=== KB禁推命中 %d 条(仅标记) ===" % len(kb_hits))
for seq, t in kb_hits[-8:]:
    print(seq, t)
