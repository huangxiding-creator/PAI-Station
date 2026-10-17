# -*- coding: utf-8 -*-
"""epc49_academic_harvest — EPC49 三学术API收割腿 (OpenAlex/SemanticScholar/arXiv, 全免key).

点亮 C 轴缺口里的三条学术渠道 + 补 T 轴国际文献证据。产出 md → ammo_pool ingest。
用法: py -X utf8 Auto_Manus/epc49_academic_harvest.py [--max 15]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
OUT = REPO / "data" / "harvest" / "academic" / "EPC49-SEPDC"
OUT.mkdir(parents=True, exist_ok=True)

QUERIES = [
    "Sichuan Electric Power Design Consulting",
    "PowerChina Sichuan electric power design institute EPC",
    "Sichuan power grid transmission EPC ultra high voltage",
    "lithium battery energy storage EPC Sichuan",
    "PowerChina overseas hydropower EPC project",
]


def _get(url: str, headers: dict | None = None, timeout: int = 25) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": "research-station/1.0",
                                               **(headers or {})})
    with urllib.request.build_opener(urllib.request.ProxyHandler({})).open(req, timeout=timeout) as r:
        return r.read()


def openalex(q: str, n: int) -> list[dict]:
    u = ("https://api.openalex.org/works?search=" + urllib.parse.quote(q)
         + f"&per-page={n}&mailto=station@epcschool.top")
    d = json.loads(_get(u))
    out = []
    for w in d.get("results", []):
        ab = ((w.get("abstract_inverted_index") or {}))
        # 重建摘要文本
        words: dict[int, str] = {}
        for word, poss in ab.items():
            for p in poss:
                words[p] = word
        abstract = " ".join(words[k] for k in sorted(words))[:1200]
        out.append({"title": w.get("title") or "", "year": w.get("publication_year"),
                    "doi": w.get("doi") or "", "src": (w.get("primary_location") or {})
                    .get("source", {}) or {}, "abstract": abstract})
    return out


def semanticscholar(q: str, n: int) -> list[dict]:
    u = ("https://api.semanticscholar.org/graph/v1/paper/search?query="
         + urllib.parse.quote(q) + f"&limit={n}&fields=title,abstract,year,externalIds,url")
    d = json.loads(_get(u))
    return [{"title": p.get("title") or "", "year": p.get("year"),
             "doi": (p.get("externalIds") or {}).get("DOI", ""),
             "src": {"display_name": "Semantic Scholar"},
             "abstract": (p.get("abstract") or "")[:1200]}
            for p in d.get("data", [])]


def arxiv(q: str, n: int) -> list[dict]:
    u = ("https://export.arxiv.org/api/query?search_query=all:"
         + urllib.parse.quote(q) + f"&max_results={n}")
    raw = _get(u).decode("utf-8", "ignore")
    out = []
    for m in re.finditer(r"<entry>(.*?)</entry>", raw, re.S):
        e = m.group(1)
        t = re.search(r"<title>(.*?)</title>", e, re.S)
        s = re.search(r"<summary>(.*?)</summary>", e, re.S)
        i = re.search(r"<id>(.*?)</id>", e, re.S)
        y = re.search(r"<published>(\d{4})", e)
        out.append({"title": re.sub(r"\s+", " ", t.group(1)).strip() if t else "",
                    "year": y.group(1) if y else "",
                    "doi": i.group(1) if i else "",
                    "src": {"display_name": "arXiv"},
                    "abstract": re.sub(r"\s+", " ", s.group(1)).strip()[:1200] if s else ""})
    return out


def save_md(engine: str, i: int, p: dict, q: str) -> Path | None:
    if not p["title"] or len(p["abstract"]) < 120:
        return None
    slug = re.sub(r"[^\w\-]+", "_", p["title"])[:60]
    fp = OUT / f"{engine.replace(":", "-")}_{i:03d}_{slug}.md"
    fp.write_text(
        f"# {p['title']}\n\n> 来源: {engine} | 年份: {p['year']} | DOI: {p['doi']}"
        f" | 检索词: {q}\n期刊/库: {(p['src'] or {}).get('display_name', '')}\n\n"
        f"## 摘要\n\n{p['abstract']}\n", encoding="utf-8")
    return fp


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--max", type=int, default=15)
    ns = ap.parse_args()
    total = 0
    for name, fn in (("paper:openalex", openalex),
                     ("paper:s2", semanticscholar),
                     ("paper:arxiv", arxiv)):
        got = 0
        for q in QUERIES[:3] if name == "paper:arxiv" else QUERIES:
            try:
                for p in fn(q, ns.max):
                    if save_md(name, total, p, q):
                        total += 1
                        got += 1
            except Exception as e:  # noqa: BLE001
                print(f"[{name}] query 「{q[:30]}」失败: {e}")
            time.sleep(3.5)
        print(f"[{name}] 收 {got} 篇")
    print(f"[harvest] 合计 {total} 篇 → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
