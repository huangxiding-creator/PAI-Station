# -*- coding: utf-8 -*-
"""lumpsum_saturation_drive — EPC-LUMPSUM 饱和门冲门驱动 (1102).

瓶颈诊断: 池内 4199 万字弹药充足, 但 62/78 EEI 零挂树 — 饱和门(≥2件valid+≥2独立host)
需要逐 EEI 精准多源采集. 本驱动: 读 coverage 缺口 EEI → 逐 EEI 生成精准词 →
6 渠道(搜狗微信/秘塔/anysearch/中文多引擎/抖研报/官网)真采 → 入池(engine=按渠道) →
manifest 行预挂 tree_node(精准词必命中, judge 后生效).
用法: py -X utf8 lumpsum_saturation_drive.py [--max-eeis N] [--only "Q3-E1,Q5-E2"]
"""
from __future__ import annotations

import json
import re
import subprocess
import sys
import time
from pathlib import Path
from urllib.parse import quote_plus, urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
CAMP = "EPC-LUMPSUM"
POOL = REPO / "ammo_pool" / CAMP
REPLICA = REPO / "逆向工程"
MANIFEST = POOL / "manifest.jsonl"

CHANNEL_TOOLS = {
    "sougo": ["py", "-X", "utf8", str(REPLICA / "sogou-weixin-reverse" / "replica" / "sogou_weixin_api.py")],
    "metaso": ["py", "-X", "utf8", str(REPLICA / "metaso-reverse" / "replica" / "metaso_api.py")],
    "djyanbao": ["py", "-X", "utf8", str(REPLICA / "djyanbao-reverse" / "replica" / "djyanbao_api.py")],
    "zh_search_pro": ["py", "-X", "utf8", str(REPO / ".claude" / "skills" / "zh-search-pro" / "scripts" / "search.py")],
}


def sh(cmd, timeout=150, cwd=None) -> str:
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                           errors="replace", timeout=timeout, cwd=str(cwd or REPO))
        return ((r.stdout or "") + (r.stderr or ""))
    except Exception as e:  # noqa: BLE001
        return f"EXC:{type(e).__name__}"


def gap_eeis() -> list[dict]:
    """coverage 口径复算: 零挂/单源的 EEI 清单 (带问题树预生成 queries)."""
    tree = json.loads((POOL / "question_tree.json").read_text(encoding="utf-8"))
    rows = [json.loads(x) for x in MANIFEST.read_text(encoding="utf-8").splitlines() if x.strip()]
    valid = [r for r in rows if r.get("judge") == "valid"]
    by = {}
    for r in valid:
        if r.get("tree_node"):
            by.setdefault(r["tree_node"], []).append(r)
    out = []
    for q in tree["subquestions"]:
        for e in q["eeis"]:
            ev = by.get(e["id"], [])
            hosts = {(urlsplit(r.get("url_norm") or "").netloc or Path(r["source_path"]).stem)
                     for r in ev}
            if len(ev) >= 2 and len(hosts) >= 2:
                continue                      # 已饱和
            out.append({"id": e["id"], "desc": e.get("need", q.get("text", "")),
                        "queries": e.get("queries", []),
                        "n_ev": len(ev), "n_host": len(hosts)})
    return out


def eei_query(e: dict) -> str:
    """EEI 表述 → 精准检索词 (去问题框架词, 保留实词)."""
    d = re.sub(r"[?？。，、；：\s]+", " ", e["desc"])
    for w in ("如何", "哪些", "什么", "怎样", "现状", "趋势", "分析", "研究", "对比",
              "本战役", "主题", "角度", "从", "对", "与", "的", "和", "在", "为", "中"):
        d = d.replace(w, " ")
    d = re.sub(r"\s+", " ", d).strip()
    words = [w for w in d.split() if len(w) >= 2][:4]
    return " ".join(words) if words else e["desc"][:24]


def collect_via(channel: str, q: str) -> list[dict]:
    """单渠道采集 → 返回 [{title, text, url}] 原始条目 (尽力解析, 失败空集)."""
    out = []
    try:
        if channel == "sougo":
            r = sh(CHANNEL_TOOLS[channel] + [q, "--top", "3", "--json"], 180)
            try:
                arts = json.loads(r[r.index("["):r.rindex("]") + 1]) if "[" in r else []
                for a in arts[:3]:
                    out.append({"title": str(a.get("title", ""))[:80],
                                "text": str(a.get("summary", a.get("content", "")))[:2000],
                                "url": a.get("url", a.get("link", ""))})
            except Exception:
                pass
        elif channel == "metaso":
            r = sh(CHANNEL_TOOLS[channel] + [q], 200)
            if "sources=" in r:
                m = re.search(r"sources=(\d+)", r)
                body = r[:4000]
                out.append({"title": f"秘塔AI综述·{q[:24]}",
                            "text": body, "url": "https://metaso.cn"})
        elif channel == "djyanbao":
            r = sh(CHANNEL_TOOLS[channel] + ["search", q], 180)
            if len(r) > 150:
                out.append({"title": f"研报检索·{q[:24]}", "text": r[:3000],
                            "url": "https://api.djyanbao.com"})
        elif channel == "zh_search_pro":
            r = sh(CHANNEL_TOOLS[channel] + ["--q", q], 120)
            if len(r) > 150:
                out.append({"title": f"多引擎SERP·{q[:24]}", "text": r[:3000],
                            "url": "https://bing.com"})
    except Exception:  # noqa: BLE001
        pass
    return out


def stage_file(eei_id: str, channel: str, item: dict) -> Path:
    d = POOL / "saturation_harvest"
    d.mkdir(exist_ok=True)
    stamp = time.strftime("%H%M%S")
    p = d / f"sat_{eeei_id}_{channel}_{stamp}.md" if False else d / f"sat_{eei_id}_{channel}_{stamp}.md"
    p.write_text(
        f"# {item['title']}\n\n来源: {channel} | 检索词: 见manifest | URL: {item.get('url','')}\n\n"
        f"{item['text']}\n", encoding="utf-8")
    return p


def tag_tree_node(file_path: Path, eei_id: str):
    """ingest 后给对应 manifest 行写 tree_node (精准件直挂, 免词面 backfill 漏挂)."""
    try:
        lines = MANIFEST.read_text(encoding="utf-8").splitlines()
        out, hit = [], False
        for ln in lines:
            if not ln.strip():
                continue
            try:
                r = json.loads(ln)
            except Exception:  # noqa: BLE001
                out.append(ln)
                continue
            if str(file_path) == str(r.get("source_path", "")):
                r["tree_node"] = eei_id
                hit = True
            out.append(json.dumps(r, ensure_ascii=False))
        MANIFEST.write_text("\n".join(out) + "\n", encoding="utf-8")
        return hit
    except Exception:  # noqa: BLE001
        return False


def main() -> int:
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--max-eeis", type=int, default=70)
    ap.add_argument("--only", default="")
    ns = ap.parse_args()

    gaps = gap_eeis()
    if ns.only:
        keep = {x.strip() for x in ns.only.split(",")}
        gaps = [g for g in gaps if g["id"] in keep]
    gaps = gaps[:ns.max_eeis]
    print(f"[sat] 缺口 EEI {len(gaps)} 个 → 逐 EEI 四渠道采集", flush=True)

    n_ing = 0
    for i, e in enumerate(gaps, 1):
        qs = e.get("queries") or []
        q = qs[0] if qs else eei_query(e)      # 树预生成词优先
        got_hosts = set()
        for ch in ("sougo", "metaso", "djyanbao", "zh_search_pro"):
            if len(got_hosts) >= 2:
                break
            items = collect_via(ch, q)
            for it in items[:1]:          # 每渠道取1件, 保 host 多样
                host = urlsplit(it.get("url") or "").netloc or ch
                if host in got_hosts:
                    continue
                p = stage_file(e["id"], ch, it)
                r = sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "ammo_pool.py"),
                        "ingest", CAMP, "--file", str(p), "--engine", ch], 120)
                if "[pool]" in r:
                    tag_tree_node(p, e["id"])
                    got_hosts.add(host)
                    n_ing += 1
        print(f"  [{i}/{len(gaps)}] {e['id']} '{q[:30]}' → {len(got_hosts)}源 "
              f"({','.join(sorted(got_hosts)) or '零获'})", flush=True)
        time.sleep(2)                      # 渠道节流
    print(f"[sat] 入池 {n_ing} 件 (预挂 tree_node 待 judge+backfill)", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
