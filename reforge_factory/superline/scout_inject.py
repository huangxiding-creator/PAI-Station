# -*- coding: utf-8 -*-
"""S1-2 规划前免费侦察注入腿 (超级生产线).

对报告名 + 每章 T1 top 词各搜一把 (zh-search-pro 免 key 全量 /
anysearch 只打报告名一查 — 限额纪律), 去重截断成 `# Relative Search
Results` 段进框架生成器 prompt; 侦察命中喂 framework_gen 的 scout 参数
升密度 (无命中章显式 low — 可追溯).

纪律:
- 免费面专用: zh-search-pro (curl_cffi 多引擎) + anysearch (匿名免鉴权);
  anysearch 限额纪律=每战役只打报告名一查, 章词全走 zh-search-pro.
- 每次腿调用落 scout_ledger.jsonl (渠道账本: anysearch 首笔产量在案).
- 检索腿全部 injectable — 单测注入假腿, 离线绝不真触网.

用法:
  python superline/scout_inject.py --battle-dir D [--emit-only] [--offline]
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

import superline as _sl
from superline import charter_gate as CG
from superline import tier_expander as TE

ZHSEARCH = (r"E:\AI-Station\.claude\skills\zh-search-pro\scripts\search.py")
ANYSEARCH = (r"E:\AI-Station\ResearchFactory-Eng\EPC100\collectors"
             r"\anysearch\cli.py")
PER_CHAPTER_TOP = 5      # 每章喂给生成器的命中截断
TOTAL_CAP = 40           # Relative Results 段总截断
LEDGER_PATH = Path(__file__).resolve().parent / "scout_ledger.jsonl"
CREATION_FLAGS = 0x08000000 if sys.platform == "win32" else 0


# ---------- 检索腿 (生产实现; 单测注入替换) ----------
def _leg_zhsearch(query: str) -> list[dict]:
    """zh-search-pro 免 key 多引擎 (subprocess; 输出 {hits:{引擎:[…]}})."""
    import subprocess
    try:
        r = subprocess.run(
            [sys.executable, ZHSEARCH, query, "--top", "5", "--json"],
            capture_output=True, text=True, encoding="utf-8",
            errors="replace", timeout=90, check=False,
            creationflags=CREATION_FLAGS)
        stdout = r.stdout or ""
        blob = stdout[stdout.find("{"):] if "{" in stdout else "{}"
        by_engine = (json.loads(blob) or {}).get("hits") or {}
        hits = []
        for items in by_engine.values():            # 引擎面摊平
            for it in items or []:
                if isinstance(it, dict) and it.get("url"):
                    hits.append({"title": it.get("title") or "",
                                 "url": it["url"],
                                 "source": "zh-search-pro", "query": query})
        return hits
    except Exception:
        return []                                   # 诚实空优于臆造


def _leg_anysearch(query: str) -> list[dict]:
    """anysearch 匿名免鉴权 (subprocess; 输出 markdown, 解析 ### N./URL 行)."""
    import re
    import subprocess
    try:
        r = subprocess.run(
            [sys.executable, ANYSEARCH, "search", "--query", query,
             "--max-results", "5"],
            capture_output=True, text=True, encoding="utf-8",
            errors="replace", timeout=90, check=False,
            creationflags=CREATION_FLAGS)
        txt = r.stdout or ""
        pairs = re.findall(r"^### \d+\. (.+)$\n- \*\*URL\*\*: (\S+)",
                           txt, flags=re.M)
        return [{"title": t.strip(), "url": u, "source": "anysearch",
                 "query": query} for t, u in pairs]
    except Exception:
        return []


LEGS = {"zh-search-pro": _leg_zhsearch, "anysearch": _leg_anysearch}


def _log_leg(channel: str, query: str, n_hits: int) -> None:
    """渠道账本: 每次腿调用留痕 (anysearch 首笔产量在此在案)."""
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "channel": channel,
           "query": query, "n_hits": n_hits}
    with open(LEDGER_PATH, "a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def ledger_first(channel: str) -> dict | None:
    """某渠道首笔账 (验收: anysearch 渠道账本首笔产量)."""
    if not LEDGER_PATH.is_file():
        return None
    for ln in LEDGER_PATH.read_text(encoding="utf-8").splitlines():
        if ln.strip():
            rec = json.loads(ln)
            if rec.get("channel") == channel:
                return rec
    return None


def _simplify_title(title: str) -> str:
    """长标题 → 简化查 (企业名 + 领域词). 《…怎么干X？》形 API 常诚实 0.

    例: 《中石化南京工程有限公司怎么干EPC总承包？》
        → 中石化南京工程有限公司 EPC
    提不出企业名 → 去书名号/问号后的裸题干."""
    company = TE.extract_company_name(title)
    if company:
        for dom in ("EPC", "LNG", "光伏", "储能", "氢能"):
            if dom in title and dom not in company:
                return f"{company} {dom}"
        return company
    bare = title.strip("《》?？ \t")
    return bare[:24] if bare else ""


# ---------- 侦察主口 ----------
def scout(framework: dict, legs: dict | None = None,
          log: bool = True) -> dict:
    """框架 → {章题: [命中]} + 报告名腿. 免费面, 去重截断, 全程留痕.

    查询面: 报告名 (双腿: zh-search-pro + anysearch 一查) + 每章 T1 top
    词 (仅 zh-search-pro — anysearch 限额纪律)."""
    legs = legs or LEGS
    title = framework.get("report_title") or framework.get("campaign_id", "")
    out: dict[str, list[dict]] = {}
    seen: set[str] = set()

    def _dedup(hits: list[dict]) -> list[dict]:
        fresh = []
        for h in hits:
            if h.get("url") and h["url"] not in seen:
                seen.add(h["url"])
                fresh.append(h)
        return fresh

    if title and "zh-search-pro" in legs:            # 报告名腿 (双渠道)
        hits = _dedup(legs["zh-search-pro"](title))
        out[title] = hits[:PER_CHAPTER_TOP]
        if log:
            _log_leg("zh-search-pro", title, len(hits))
    if title and "anysearch" in legs:
        hits = _dedup(legs["anysearch"](title))
        if log:
            _log_leg("anysearch", title, len(hits))
        if not hits:                        # 长标题常见诚实0 → 简化查一次
            simp = _simplify_title(title)
            if simp and simp != title:
                hits = _dedup(legs["anysearch"](simp))
                if log:
                    _log_leg("anysearch", simp, len(hits))
        out.setdefault(title, [])
        out[title] += hits[:PER_CHAPTER_TOP]
    for ch in framework.get("chapters", []):          # 章词腿 (zh 面全量)
        q = (ch.get("tier_map", {}).get("T1") or [""])[0]
        if not q or "zh-search-pro" not in legs:
            continue
        hits = _dedup(legs["zh-search-pro"](q))
        out[ch["title"]] = hits[:PER_CHAPTER_TOP]     # 0 命中=显式低密度
        if log:
            _log_leg("zh-search-pro", q, len(hits))
    return out


def to_scout_json(scout_hits: dict) -> dict:
    """{键: [hit dict]} → framework_gen.generate(scout=…) 消费形."""
    return {k: [f"{h.get('title') or h.get('url')} | {h.get('url')}"
                for h in v] for k, v in scout_hits.items() if v}


def relative_results_md(scout_hits: dict) -> str:
    """去重截断成 `# Relative Search Results` 段 (生成器 prompt 注入件)."""
    lines = ["# Relative Search Results", "",
             "> 免费侦察腿 (zh-search-pro + anysearch) 去重截断清单 —",
             "> 进框架生成器 prompt 作密度预估依据; 无命中章显式 low。", ""]
    n = 0
    for key, hits in scout_hits.items():
        if not hits:
            lines.append(f"## {key}\n- (零命中 — 密度显式 low)")
            lines.append("")
            continue
        lines.append(f"## {key}")
        for h in hits:
            if n >= TOTAL_CAP:
                lines.append(f"- …总截断 {TOTAL_CAP} 条")
                return "\n".join(lines) + "\n"
            lines.append(f"- [{h.get('title') or h['url']}]({h['url']}) "
                         f"({h.get('source')})")
            n += 1
        lines.append("")
    return "\n".join(lines) + "\n"


def run(battle_dir: str, legs: dict | None = None) -> dict:
    """读战役 framework.json → 侦察 → 落 scout.json + 相对结果段 + 回灌."""
    out = CG._out_dir(battle_dir)
    fw = CG._read_json(out / "framework.json")
    if not fw.get("chapters"):
        raise FileNotFoundError(f"{out / 'framework.json'} 缺失, 先跑 S1-1")
    hits = scout(fw, legs=legs)
    (out / "scout.json").write_text(
        json.dumps({"schema": "scout_v1", "hits": hits},
                   ensure_ascii=False, indent=1), encoding="utf-8")
    (out / "scout_relative_results.md").write_text(
        relative_results_md(hits), encoding="utf-8")
    return hits


def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="S1-2 免费侦察注入腿")
    ap.add_argument("--battle-dir", default="")
    ap.add_argument("--offline", action="store_true",
                    help="只读账本不检索 (诊断)")
    args = ap.parse_args(argv)
    print(f"[s1-2] superline {_sl.__version__} 侦察注入腿 "
          f"(zh-search-pro 全量 + anysearch 报告名一查)")
    if args.offline:
        for chn in ("zh-search-pro", "anysearch"):
            first = ledger_first(chn)
            print(f"[s1-2] {chn} 首笔: {first or '无 (未生产)'}")
        return 0
    if not args.battle_dir:
        print("[s1-2] 须 --battle-dir", file=sys.stderr)
        return 2
    hits = run(args.battle_dir)
    n_all = sum(len(v) for v in hits.values())
    zero = [k for k, v in hits.items() if not v]
    print(f"[s1-2] 侦察 {len(hits)} 键 | 命中 {n_all} 条 (去重) | "
          f"零命中 {len(zero)} 键显式 low")
    print(f"[s1-2] 落盘: scout.json + scout_relative_results.md "
          f"(回灌: framework_gen --scout)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
