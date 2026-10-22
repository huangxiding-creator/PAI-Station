# -*- coding: utf-8 -*-
"""academic_sweep — S1 学术API三腿 (OpenAlex + Semantic Scholar + arXiv, 全免key).

EPC-OVERSEAS 出海专题定向: FIDIC/国际工程/中资出海文献面.
产物: corpus/academic_overseas/{openalex,s2,arxiv}_NN.md → 编排方 ingest
(engine=对应渠道id, 进 C 轴命中账+T1+饱和).
"""
import json
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = Path(r"E:\AI-Station\corpus\academic_overseas")
QUERIES = [
    "FIDIC contract international construction dispute",
    "Chinese contractors overseas EPC projects risk",
    "Belt and Road infrastructure investment power",
    "international engineering procurement construction turnkey",
    "overseas power plant construction market entry",
]


def get_json(url: str, headers: dict | None = None):
    req = urllib.request.Request(url, headers={"User-Agent": "research/1.0",
                                               **(headers or {})})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.loads(r.read().decode("utf-8", errors="replace"))


def openalex_leg():
    n = 0
    for q in QUERIES:
        u = ("https://api.openalex.org/works?search=" + urllib.parse.quote(q)
             + "&per-page=10&mailto=research@example.org")
        try:
            d = get_json(u)
        except Exception as e:
            print(f"[oa] {q[:30]}: {type(e).__name__}"); continue
        for w in d.get("results", []):
            title = w.get("display_name", "")
            if not title:
                continue
            year = w.get("publication_year", "")
            src = ((w.get("primary_location") or {}).get("source")
                   or {}).get("display_name", "")
            cites = w.get("cited_by_count", 0)
            abstract = w.get("abstract_inverted_index")
            abstr = ""
            if abstract:
                pos = {}
                for word, idxs in abstract.items():
                    for i in idxs:
                        pos[i] = word
                abstr = " ".join(pos[i] for i in sorted(pos))[:2500]
            f = OUT / f"openalex_{n:03d}.md"
            f.write_text(
                f"# {title}\n\n> 来源: OpenAlex | 年: {year} | 期刊: {src} | "
                f"被引: {cites}\n> 查询: {q}\n\n{abstr}\n",
                encoding="utf-8")
            n += 1
        print(f"[oa] {q[:40]}: 累计{n}", flush=True)
        time.sleep(2)
    return n


def s2_leg():
    n = 0
    for q in QUERIES:
        u = ("https://api.semanticscholar.org/graph/v1/paper/search?query="
             + urllib.parse.quote(q)
             + "&limit=10&fields=title,year,abstract,citationCount,venue")
        try:
            d = get_json(u)
        except Exception as e:
            print(f"[s2] {q[:30]}: {type(e).__name__}"); continue
        for p in d.get("data", []):
            title = p.get("title", "")
            if not title:
                continue
            f = OUT / f"s2_{n:03d}.md"
            f.write_text(
                f"# {title}\n\n> 来源: Semantic Scholar | 年: "
                f"{p.get('year','')} | {p.get('venue','')} | 被引: "
                f"{p.get('citationCount',0)}\n> 查询: {q}\n\n"
                f"{(p.get('abstract') or '')[:2500]}\n",
                encoding="utf-8")
            n += 1
        print(f"[s2] {q[:40]}: 累计{n}", flush=True)
        time.sleep(3)
    return n


def arxiv_leg():
    n = 0
    for q in QUERIES[:3]:
        u = ("http://export.arxiv.org/api/query?search_query=all:"
             + urllib.parse.quote(q) + "&max_results=10")
        try:
            import urllib.request as rq
            with rq.urlopen(u, timeout=30) as r:
                xml = r.read().decode("utf-8", errors="replace")
        except Exception as e:
            print(f"[ax] {q[:30]}: {type(e).__name__}"); continue
        import re
        for m in re.finditer(r"<entry>(.*?)</entry>", xml, re.S):
            e = m.group(1)
            t = re.search(r"<title>(.*?)</title>", e, re.S)
            s = re.search(r"<summary>(.*?)</summary>", e, re.S)
            if not t:
                continue
            title = re.sub(r"\s+", " ", t.group(1)).strip()
            summ = re.sub(r"\s+", " ", s.group(1)).strip()[:2500] if s else ""
            f = OUT / f"arxiv_{n:03d}.md"
            f.write_text(f"# {title}\n\n> 来源: arXiv | 查询: {q}\n\n{summ}\n",
                         encoding="utf-8")
            n += 1
        print(f"[ax] {q[:40]}: 累计{n}", flush=True)
        time.sleep(3)
    return n


if __name__ == "__main__":
    OUT.mkdir(parents=True, exist_ok=True)
    a = openalex_leg()
    b = s2_leg()
    c = arxiv_leg()
    print(f"== 学术三腿: OpenAlex {a} + S2 {b} + arXiv {c} = {a+b+c} 件")
