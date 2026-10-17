# -*- coding: utf-8 -*-
"""eei_gap_harvest — 未点亮 EEI 定向收割 (EPC49 饱和门攻坚).

流程: 计算未点亮 EEI → 每条生成精炼检索词(主题词+立场角) → zh-search-pro 技能
检索(必应中国+百度, 免key) → curl_cffi 取正文 → md 落盘 → ammo_pool ingest
--tree <EEI> --stance <立场> 直挂点亮。
用法: py -X utf8 tools/eei_gap_harvest.py --campaign EPC49-SEPDC [--max-eei 40] [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
import urllib.parse
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
SKILL = REPO / ".claude" / "skills" / "zh-search-pro" / "scripts" / "search.py"
OUTROOT = REPO / "data" / "harvest" / "eei_gap"

RISK_WORDS = ("处罚", "纠纷", "风险", "质疑", "亏损", "败诉", "通报", "违约")

# 金查询表 (1015 实测病理: 必应中国对精确实体名/法规全名稳定直给, 泛词降级为诱饵
# → 全部实体名/专名优先)。键=(子问题号, 立场); against 缺省走公司反证三连。
GOLD: dict[tuple[int, str], list[str]] = {
    (18, "support"): ["电力工程数字化交付标准", "输变电工程 三维设计 BIM"],
    (19, "support"): ["数字化输电设计平台 中国电建", "电力设计院 数字化转型 案例"],
    (20, "support"): ["四川电力设计咨询 专利", "电力行业 团体标准 主编"],
    (21, "support"): ["四川电力设计咨询 招聘 注册电气工程师", "电力设计院 一级注册结构工程师"],
    (22, "support"): ["四川省工程勘察设计大师", "四川电力设计咨询 专家团队"],
    (23, "support"): ["FIDIC 合同条件", "国际工程 EPC 合风险管理"],
    (24, "support"): ["四川电力设计咨询 海外项目", "中国电建 印尼 电厂 建设",
                    "肯尼亚 拉姆 电站"],
    (25, "support"): ["四川电力设计咨询 采购 招标公告", "中国电建 集中采购 平台"],
    (26, "support"): ["电力设计 企业 数字化平台", "四川电力设计咨询 官网 平台"],
    (0, "against"): ["四川电力设计咨询 行政处罚", "四川电力设计咨询 巡视 通报",
                   "四川电力设计咨询 净利润 亏损"],
}
EEI_PER_SUBQ = {}  # 由 unlit_eeis 动态填


def unlit_eeis(cid: str) -> list[dict]:
    lit = set()
    for ln in open(REPO / "ammo_pool" / cid / "manifest.jsonl",
                   encoding="utf-8", errors="ignore"):
        if '"valid"' not in ln:
            continue
        try:
            d = json.loads(ln)
        except json.JSONDecodeError:
            continue
        if d.get("tree_node"):
            lit.add(d["tree_node"])
    tree = json.loads((REPO / "ammo_pool" / cid / "question_tree.json")
                      .read_text(encoding="utf-8"))
    out = []
    for s in tree.get("subquestions", []):
        qn = int(s["id"].lstrip("Q"))
        for e in s.get("eeis") or []:
            if e["id"] in lit:
                continue
            stance = "against" if e.get("stance") in ("against", "contradict") else \
                     ("authority" if "权威" in e.get("need", "") else "support")
            if stance == "against":
                gold = GOLD[(0, "against")]
            else:
                gold = GOLD.get((qn, "support")) or \
                       GOLD.get((qn, "authority")) or []
                if not gold:  # 该题无金词 → 用题干实体名
                    base = re.sub(r"^.*?全景研究\s*", "", s.get("text", "")).strip()[:16]
                    gold = [f"四川电力设计咨询 {base}"]
            out.append({"id": e["id"], "stance": stance, "q": gold[0], "q2": gold[1 % len(gold)] if len(gold) > 1 else gold[0]})
    return out


def search(q: str) -> list[dict]:
    r = subprocess.run([sys.executable, "-X", "utf8", str(SKILL), q,
                        "-e", "sogou_weixin,bing_cn", "--top", "6", "--json"],
                       capture_output=True, text=True, timeout=90, cwd=str(REPO))
    try:
        d = json.loads(r.stdout)
    except json.JSONDecodeError:
        return []
    items = []
    if isinstance(d, dict):
        for arr in (d.get("hits") or {}).values():
            items += arr or []
    elif isinstance(d, list):
        items = d
    return [x for x in items if x.get("url")][:4]


def fetch(url: str) -> str:
    from curl_cffi import requests as cr
    r = cr.get(url, impersonate="chrome", timeout=25)
    if r.status_code != 200 or len(r.content) < 1500:
        return ""
    html = r.text
    html = re.sub(r"<(script|style)[^>]*>.*?</\1>", " ", html, flags=re.S | re.I)
    text = re.sub(r"<[^>]+>", " ", html)
    text = re.sub(r"\s+", " ", text)
    return text if len(text) > 500 else ""


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--max-eei", type=int, default=40)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    cid = ns.campaign
    out = unlit_eeis(cid)
    print(f"[gap] 未点亮 EEI {len(out)} → 取前 {ns.max_eei}")
    outdir = OUTROOT / cid
    outdir.mkdir(parents=True, exist_ok=True)
    ingested = 0
    qcache: dict[str, list] = {}
    for e in out[:ns.max_eei]:
        hits = []
        for q in (e["q"], e["q2"]):
            if q in qcache:
                hits = qcache[q]
            else:
                try:
                    hits = search(q)
                except Exception as ex:  # noqa: BLE001
                    print(f"  {e['id']} 搜索失败: {ex}")
                    hits = []
                qcache[q] = hits
                time.sleep(1.5)
            if hits:
                break
        n = 0
        for h in hits:
            if ns.dry:
                print(f"  [dry] {e['id']} <- {h.get('title','')[:36]} {h['url'][:60]}")
                n += 1
                continue
            try:
                body = fetch(h["url"])
            except Exception:  # noqa: BLE001
                continue
            if not body:
                continue
            # 实体相关门: 正文须含主题实体/词, 杀「四川省」类泛结果
            if not re.search(r"电力设计|四川院|EPC|总承包|FIDIC|招投标|设计院|"
                             r"恒顺众昇|勘察设计|输变电|新能源", body):
                continue
            slug = re.sub(r"[^\w]+", "_", h.get("title") or "doc")[:40]
            fp = outdir / f"{e['id']}_{slug}.md"
            fp.write_text(
                f"# {h.get('title','')}\n\n> 来源: zh-search-pro | {h['url']}"
                f" | EEI: {e['id']} | 立场: {e['stance']}\n\n{body[:20000]}\n",
                encoding="utf-8")
            r = subprocess.run(
                [sys.executable, "-X", "utf8", "reforge_factory/ammo_pool.py",
                 "ingest", cid, "--file", str(fp), "--engine", "web:zhsearchpro",
                 "--cred", "media", "--tree", e["id"], "--stance",
                 "against" if e["stance"] == "against" else "support"],
                capture_output=True, text=True, timeout=120, cwd=str(REPO))
            if r.returncode == 0:
                ingested += 1
                n += 1
            time.sleep(0.8)
        print(f"  {e['id']} [{e['stance']}] q=「{e['q'][:30]}」 → {n} 件")
    print(f"[gap] 完成: 入池 {ingested} 件" + (" (dry)" if ns.dry else ""))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
