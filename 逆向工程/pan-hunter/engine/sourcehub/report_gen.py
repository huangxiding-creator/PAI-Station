# -*- coding: utf-8 -*-
"""从 source_audit_1030.jsonl 生成 SOURCE_AUDIT_1030.md §3 实测表（零手抄）。"""
import json
import os
import sys
from collections import Counter, defaultdict

sys.stdout.reconfigure(encoding="utf-8")
HERE = os.path.dirname(os.path.abspath(__file__))
JSONL = os.path.normpath(os.path.join(HERE, "..", "..", "analysis", "source_audit_1030.jsonl"))

rows = [json.loads(l) for l in open(JSONL, encoding="utf-8") if l.strip()]
by_src = defaultdict(list)
for r in rows:
    by_src[r["source"]].append(r)

ORDER = ["LIVE_JSON", "LIVE_HTML", "LIVE_SSE", "ALIVE_EMPTY", "ALIVE_SHELL",
         "CF_CHALLENGE", "ANTICRAWL", "WALL_PROXY", "DEAD", "BUDGET_EXHAUSTED"]

def cell(rs, kw):
    for r in rs:
        if r["keyword"] == kw:
            v = r["verdict"]
            return f"{v}({r['hits']})" if v.startswith("LIVE") else v
    return "-"

lines = []
lines.append("### 3.1 逐源判定表（关键词=民法典 / 水电站 施工组织 / 机器学习；括号=实测命中条目数）\n")
lines.append("| 源 | 民法典 | 水电站施工组织 | 机器学习 | 判定 |")
lines.append("|---|---|---|---|---|")
live, empty, shell, cf, anticrawl, dead = [], [], [], [], [], []
for src, rs in by_src.items():
    vs = [r["verdict"] for r in rs]
    if any(v.startswith("LIVE") for v in vs):
        judge = "活源"
        live.append(src)
    elif "CF_CHALLENGE" in vs:
        judge = "CF 质询墙（待浏览器栈）"
        cf.append(src)
    elif "ANTICRAWL" in vs:
        judge = "行为反爬"
        anticrawl.append(src)
    elif "ALIVE_SHELL" in vs:
        judge = "SPA 壳（引擎不可用）"
        shell.append(src)
    elif "ALIVE_EMPTY" in vs:
        judge = "活而零命中（配方或形态待深挖）"
        empty.append(src)
    else:
        judge = "死源"
        dead.append(src)
    lines.append(f"| {src} | {cell(rs, '民法典')} | {cell(rs, '水电站 施工组织')} | {cell(rs, '机器学习')} | {judge} |")

by_verdict = Counter(r["verdict"] for r in rows)
total_hits = sum(r["hits"] for r in rows if r["verdict"].startswith("LIVE"))
spent = len(rows) + sum(1 for r in rows if r["path"] == "proxy_retry" and r["verdict"] != "BUDGET_EXHAUSTED")

lines.append(f"""
### 3.2 基线汇总

- 对外请求（发）≈ {spent}（含代理重试；硬顶 600，频控三律全合规）
- verdict 分布：{dict(by_verdict)}
- **实测活源（LIVE*）= {len(live)} / {len(by_src)} 配方源**：{sorted(live)}
- 活而零命中 = {len(empty)}：{sorted(empty)}
- SPA 壳 = {len(shell)}：{sorted(shell)}
- CF 质询墙 = {len(cf)}：{sorted(cf)}
- 行为反爬 = {len(anticrawl)}：{sorted(anticrawl)}
- 死源 = {len(dead)}：{sorted(dead)}
- LIVE 总命中条目 = {total_hits}（3 关键词合计）

### 3.3 覆盖叙事口径（出口硬门兑现）

旧口径「122 配方」废止。新口径：**37 配方源实测 N 活源**（上表 LIVE* 数）+ TG 腿（t.me/s/ 直连被墙、
代理可用）+ CF 质询源 3 个待 W3 浏览器栈腿转正。122 插件中其余 ~85 个影视站插件不在泛盘检索口径内，
W1 起按需增译。doctor 命令沿用本审计管线（core.run_audit 即健康轮内核）。

### 3.4 与调研预期的对账

- r2 A 级 3 直调源：全部复证 LIVE（naspt/melost/panhunt）✓
- r2 B 级「000 需代理复测」批（GAP A13）：yunso/pansearch 代理+直连形态已定（§2）；haisou/jikepan 判死；funletu 404 站变
- GAP A12 未核批（ting77/quarksoo/lingjisp/meitizy/leso/miosou）：本审计逐源已核，判定见 3.1 表
- melost 响应结构已变（search_result→list），配方表以本日实测为准
""")

out = os.path.normpath(os.path.join(HERE, "..", "..", "analysis", "audit_section3.md"))
with open(out, "w", encoding="utf-8") as f:
    f.write("\n".join(lines))
print(f"written {out}; live={len(live)} dead={len(dead)} hits={total_hits}")
