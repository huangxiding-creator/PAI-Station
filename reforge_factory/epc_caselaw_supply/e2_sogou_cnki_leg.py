# -*- coding: utf-8 -*-
"""e2_sogou_cnki_leg — EPC-CASELAW E2 反证位+零源维补采件 (1031 饱和冲门·四).

任务书: 调解与ADR (sogou/cnki 搜 造价争议 调解案例/争议评审 DAAB) /
工期与费用索赔 (工期索赔 费用索赔 案例) / 同案不同判证据 (cnki/court).

机制 (零造假铁律):
  · 搜狗微信 = 复刻件四段纯HTTP链 (SNUID门票+碎片拼接), 每查询取前
    --top 篇全文, 节流 ≥2s; antispider 命中如实 BLOCKED 不硬刚;
  · CNKI = 老版免登录题录面 (题录层过不了 S2-1 snippet 硬门 = 0入池
    如实, 调用仍留 invocation 账);
  · 全文件落 data/harvest/sogou_e2/EPC-CASELAW/ → ingest
    (engine=sogou_wechat, cred=media, tree=E2 EEI)。

用法: py -X utf8 e2_sogou_cnki_leg.py [--dry] [--top 2]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
sys.path.insert(0, r"E:\AI-Station\逆向工程\sogou-weixin-reverse\replica")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as AP  # noqa: E402

CID = "EPC-CASELAW"
OUT = Path(r"E:\AI-Station\data\harvest\sogou_e2\EPC-CASELAW")
LEDGER = AP.POOL_ROOT / CID / "e2_sogou_ledger.jsonl"
SOGOU = Path(r"E:\AI-Station\逆向工程\sogou-weixin-reverse\replica"
             r"\sogou_weixin_api.py")
CNKI = Path(r"E:\AI-Station\逆向工程\cnki-reverse\replica\cnki_api.py")

#: (查询, 目标EEI) — E2 反证位 + 零源维
PLAN = [
    ("造价争议 调解 调解协议 司法确认 案例", "Q23-E2"),
    ("争议评审 DAAB FIDIC 工程 实践", "Q24-E2"),
    ("工期索赔 费用索赔 案例 判决", "Q17-E2"),
    ("工期延误 顺延 败诉 判例", "Q16-E2"),
    ("同案不同判 造价 判例", "Q26-E2"),
    ("造价鉴定 重新鉴定 质证 案例", "Q14-E2"),
    ("黑白合同 结算依据 案例 改判", "Q18-E2"),
]

_CNKI_NOTE = ("cnki 题录层过不了 S2-1 snippet 硬门 (0入池如实); "
              "调用留 channel_invocations 账")


def safe_name(s: str) -> str:
    return re.sub(r"[\\/:*?\"<>|\s]+", "_", s)[:60]


def log_inv(channel: str, tool: str, queries: str, yield_note: str):
    p = AP.POOL_ROOT / CID / "channel_invocations.jsonl"
    with p.open("a", encoding="utf-8") as f:
        f.write(json.dumps(
            {"channel": channel, "ts": time.strftime("%F %T"), "tool": tool,
             "queries": queries, "yield": yield_note},
            ensure_ascii=False) + "\n")


def run_sogou(query: str, eei: str, top: int, dry: bool, lf) -> int:
    n = 0
    out_dir = OUT / safe_name(query)
    out_dir.mkdir(parents=True, exist_ok=True)
    cmd = [sys.executable, "-X", "utf8", str(SOGOU), *query.split(),
           "--top", str(top), "--json"]
    r = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=300,
                       cwd=str(SOGOU.parent))
    blob = r.stdout or ""
    if "BLOCKED" in (r.stderr or "") or r.returncode == 3:
        log_inv("sogou_wechat", "sogou_weixin_api.py 复刻件 (四段纯HTTP链)",
                query, "BLOCKED antispider (如实; 冷却后再试)")
        lf.write(json.dumps({"ts": time.strftime("%F %T"), "query": query,
                             "result": "blocked"}, ensure_ascii=False) + "\n")
        return 0
    try:
        data = json.loads(blob[blob.find("{"):])
    except Exception:                                       # noqa: BLE001
        lf.write(json.dumps({"ts": time.strftime("%F %T"), "query": query,
                             "result": f"parse_err rc={r.returncode}",
                             "stderr": (r.stderr or "")[:200]},
                            ensure_ascii=False) + "\n")
        log_inv("sogou_wechat", "sogou_weixin_api.py 复刻件 (四段纯HTTP链)",
                query, f"解析异常 rc={r.returncode} (如实)")
        return 0
    (out_dir / "search.json").write_text(blob, encoding="utf-8")
    arts = data.get("articles") or []
    for a in arts:
        text = (a.get("text") or "").strip()
        title = a.get("title") or "无题"
        if len(re.sub(r"\s", "", text)) < 400:
            continue
        if dry:
            print(f"  (dry) {title[:40]} {len(text)}字")
            continue
        fp = out_dir / f"{safe_name(title)}.md"
        fp.write_text(
            f"# {title}\n\n> 公众号: {a.get('account','')} | "
            f"发布: {a.get('publish_time','')}\n> 源链: "
            f"{a.get('permanent_url') or a.get('url','')}\n> 抓取: "
            f"{time.strftime('%F %T')} (搜狗微信复刻件, 纯HTTP)\n\n{text}",
            encoding="utf-8", newline="\n")
        rc = AP.ingest(CID, str(fp), engine="sogou_wechat",
                       url=a.get("permanent_url") or "", cred="media",
                       tree=eei, stance="against", band="gap")
        n += 1
        lf.write(json.dumps(
            {"ts": time.strftime("%F %T"), "query": query, "eei": eei,
             "file": str(fp), "chars": len(text), "ingest_rc": rc,
             "title": title[:50]}, ensure_ascii=False) + "\n")
        print(f"  + {title[:42]} → {eei} ({len(text):,}字 rc={rc})")
    hits = len(data.get("hits") or [])
    log_inv("sogou_wechat", "sogou_weixin_api.py 复刻件 (四段纯HTTP链)",
            query, f"{hits}条线索/{len(arts)}篇全文/{n}件入池→{eei}")
    return n


def run_cnki(query: str, dry: bool, lf):
    out_dir = OUT / safe_name("cnki_" + query)
    out_dir.mkdir(parents=True, exist_ok=True)
    j = out_dir / "cnki_titles.json"
    cmd = [sys.executable, "-X", "utf8", str(CNKI), query,
           "--pages", "1", "--abstracts", "5", "--json", str(j)]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=240,
                           cwd=str(CNKI.parent))
        n = 0
        if j.is_file():
            try:
                n = len(json.loads(j.read_text(encoding="utf-8")))
            except Exception:                               # noqa: BLE001
                n = -1
        note = f"题录 {n} 条 (rc={r.returncode}); {_CNKI_NOTE}"
        log_inv("cnki", "cnki_api.py search.cnki.com.cn 老版免登录检索",
                query, note)
        lf.write(json.dumps({"ts": time.strftime("%F %T"), "query": query,
                             "channel": "cnki", "titles": n,
                             "rc": r.returncode}, ensure_ascii=False) + "\n")
        print(f"  [cnki] {query[:24]} → 题录 {n} 条 (rc={r.returncode})")
    except Exception as e:                                  # noqa: BLE001
        log_inv("cnki", "cnki_api.py search.cnki.com.cn 老版免登录检索",
                query, f"异常{type(e).__name__} (调用已发生)")
        print(f"  [cnki] {query[:24]} 异常 {type(e).__name__}")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--top", type=int, default=2)
    ns = ap.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    total = 0
    with LEDGER.open("a", encoding="utf-8") as lf:
        for query, eei in PLAN:
            print(f"== sogou: {query} → {eei}", flush=True)
            total += run_sogou(query, eei, ns.top, ns.dry, lf)
            time.sleep(3)
            if not ns.dry:
                run_cnki(query, ns.dry, lf)
                time.sleep(2)
    print(f"[e2] 入池 {total} 件")
    return 0


if __name__ == "__main__":
    sys.exit(main())
