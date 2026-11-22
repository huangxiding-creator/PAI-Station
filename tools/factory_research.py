# -*- coding: utf-8 -*-
"""factory_research — W3 调研舰队编排器: 六渠道编排+DoD门槛 (FACTORY-7x24).
吃 HANDOFF_next.md 的战役 → 按方向跑核心渠道(可脚本化腿)+登记人工/技能腿工单 →
DoD核验(广度6/6+3/深度/密度) → 出 factory_research_report.json (生产准入凭据).
渠道执行分层:
  A 自动腿(本脚本直跑): 判例切片池/ebook库/academic池/rss库 —— 本地库检索
  B 技能腿(产线技能, 由Claude会话/后续W4接线执行): bdn/ima/weread/wenku/metaso…→ 产出登记进工单
用法: py -X utf8 tools/factory_research.py --campaign EPC-XXXX [--check-only]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
FACT = REPO / "data" / "factory"
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2"
OUT = FACT / "factory_research_report.json"

THEME_KWS = {
    "招投标": ["招投标", "招标", "投标", "中标", "评标"], "合同": ["变更签证", "索赔", "黑白合同"],
    "结算": ["结算", "造价", "审减", "审计"], "验收": ["验收", "竣工"], "分包": ["分包", "转包", "挂靠"],
    "安全": ["安全"], "保函": ["保函", "保险"], "融资": ["融资", "BOT", "PPP"], "税务": ["发票"],
    "国际": ["国际", "FIDIC"], "储能": ["储能", "光伏", "风电"], "水利": ["水利", "水电"],
    "交通": ["公路", "桥梁", "隧道"], "鉴定": ["鉴定", "管辖"], "数字化": ["BIM"],
}


def cjk(t): return len(re.findall(r"[一-鿿]", t))


def kws_for(theme: str) -> list[str]:
    for k, v in THEME_KWS.items():
        if k in theme:
            return v
    return [theme[:4]]


def leg_auto(campaign: str, theme: str, kws: list[str]) -> dict:
    """A 自动腿: 本地四库检索计数."""
    r = {"slices": 0, "ebooks": 0, "papers": 0, "rss": 0, "ammo_hits": 0}
    js = REPO / "data" / "harvest" / "judgment_slices"
    seen = set()
    for f in js.rglob("*.md"):
        if f.stem in seen:
            continue
        if any(k in f.stem for k in kws):
            seen.add(f.stem)
            r["slices"] += 1
    # ebook 库索引 (ebook-treasure 本地索引)
    eb = REPO / "ebook-treasure" / "index"
    if not eb.is_dir():
        eb = REPO / "data" / "ebook-treasure"
    for f in list(eb.rglob("*.json"))[:3] if eb.is_dir() else []:
        try:
            t = f.read_text(encoding="utf-8", errors="replace")
            r["ebooks"] += sum(t.count(k) for k in kws[:3])
        except OSError:
            pass
    # rss 近3日
    for d in range(3):
        day = time.strftime("%Y-%m-%d", time.localtime(time.time() - d * 86400))
        p = REPO / "data" / "rss_harvest" / "articles" / day
        if p.is_dir():
            for f in list(p.glob("*.md"))[:400]:
                try:
                    head = f.name
                    r["rss"] += sum(head.count(k) for k in kws[:3])
                except OSError:
                    pass
    return r


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--theme", default="")
    ap.add_argument("--check-only", action="store_true")
    ns = ap.parse_args()
    handoff = FACT / "HANDOFF_next.md"
    theme = ns.theme
    if not theme and handoff.is_file():
        m = re.search(r"- 主题: (.+?) \(评分", handoff.read_text(encoding="utf-8"))
        theme = m.group(1).strip() if m else ns.campaign
    kws = kws_for(theme)
    print(f"[research] {ns.campaign} 主题「{theme}」 词表={kws[:4]}")
    auto = leg_auto(ns.campaign, theme, kws)
    print(f"[research] 自动腿: 切片{auto['slices']}卷 rss命中{auto['rss']} ebooks信号{auto['ebooks']}")
    # B 技能腿工单 (产线技能执行——Claude会话或后续接线)
    skill_orders = [
        {"channel": "bdpan", "order": f"bdn全盘检索+下载: {' '.join(kws[:3])}", "tier": 1},
        {"channel": "ima", "order": f"ima广场收割: {kws[0]}", "tier": 1},
        {"channel": "weread", "order": f"微信读书搜书: {kws[0]} (日限2本铁律)", "tier": 1},
        {"channel": "papers", "order": f"论文检索: {kws[0]}", "tier": 1},
        {"channel": "wenku", "order": f"文库检索: {kws[0]}", "tier": 1},
        {"channel": "dangdang", "order": f"当当书讯: {kws[0]} (W3扩展)", "tier": 1},
        {"channel": "gbstd", "order": f"国标检索: 涉{theme[:4]}标准", "tier": 2},
        {"channel": "panhunter", "order": f"全网网盘: {kws[0]}", "tier": 2},
    ]
    # DoD 预核 (自动腿能核的部分)
    dod = {"auto_slices": auto["slices"], "slice_gate": auto["slices"] >= 5,
           "tier1_ordered": 6, "tier2_ordered": 2,
           "full_dod": "待技能腿产出后终核(广度6/6+3/深度3本/密度50锚)"}
    doc = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "campaign": ns.campaign,
           "theme": theme, "kws": kws, "auto": auto, "skill_orders": skill_orders,
           "dod": dod}
    OUT.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[research] 报告+工单 → {OUT}")
    print(f"[research] 切片门: {'PASS' if dod['slice_gate'] else 'FAIL'} (>=5卷)")
    return 0 if dod["slice_gate"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
