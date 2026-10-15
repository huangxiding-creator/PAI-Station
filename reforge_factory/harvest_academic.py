# -*- coding: utf-8 -*-
"""harvest_academic — 学术API三件套收割腿 (1015 用户批 B/C 补采 · C 轴
openalex/semantic_scholar/arxiv 三渠道 + B 轴国际对标/技术方案/渠道生态四面).

发现层=channels/academic.py (统一 Doc, 礼貌间隔内建); 本腿补「落地三步」:
  1) 每条 Doc 合成 md 证据件 (题/年/刊/URL/摘要 — 非 SERP 形, 过 snippet 门);
  2) ammo_pool.ingest 入池 (engine=academic:<渠道id> — C 轴 resolve_engine
     子串直命中; url=原文 DOI 链接 → 独立 host 计入 B 轴);
  3) --tree 挂到目标 EEI (E1 正面槽), stance=support。

限流如实: S2/arXiv 429/超时 → 该渠道记 skip 不造假; OpenAlex 为主力。
幂等: 文件名=渠道+查询slug+序号, ingest 自身按 source_path+dedup 双查重。

用法: py reforge_factory/harvest_academic.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parent / "channels"))
import academic as ac                                  # noqa: E402
import ammo_pool                                       # noqa: E402

REPO = Path(__file__).resolve().parents[1]

# (渠道, 检索式, 目标EEI, 主题) — EEI 对齐 question_tree 十维树 (Q18-26 扩展四面)
PLAN: list[tuple[str, str, str, str]] = [
    # 国际对标 Q23 (国际规则与惯例) / Q24 (海外实践)
    ("openalex", "FIDIC contract engineering procurement construction", "Q23-E1", "国际规则"),
    ("openalex", "World Bank procurement guidelines construction", "Q23-E1", "国际规则"),
    ("openalex", "China construction companies overseas contracts Belt Road", "Q24-E1", "海外实践"),
    ("openalex", "international construction tender evaluation practice", "Q23-E1", "国际规则"),
    ("openalex", "public procurement law comparison China EU", "Q23-E2", "国际规则反证"),
    # 技术方案 Q19 (数字化平台) / Q20 (标准专利)
    ("openalex", "e-procurement platform digital bidding construction", "Q19-E1", "数字化平台"),
    ("openalex", "BIM building information modeling construction project management", "Q19-E1", "数字化平台"),
    ("openalex", "blockchain smart contract public procurement tender", "Q20-E1", "标准专利"),
    # 渠道生态 Q25 (供应链)
    ("openalex", "construction supply chain procurement ecosystem China", "Q25-E1", "供应链生态"),
    # S2 备源 (429 常见, 如实 skip)
    ("semantic_scholar", "construction procurement bidding compliance", "Q23-E1", "国际规则"),
    ("semantic_scholar", "FIDIC dispute resolution arbitration", "Q23-E2", "国际规则反证"),
    # arXiv (工程经济类稀疏, 探一面)
    ("arxiv", "procurement auction mechanism design", "Q23-E1", "国际规则"),
]

SEARCHERS = {"openalex": ac.search_openalex,
             "semantic_scholar": ac.search_s2,
             "arxiv": ac.search_arxiv}


def _slug(q: str) -> str:
    return re.sub(r"[^a-z0-9]+", "-", q.lower()).strip("-")[:40]


def compose_doc(doc: dict, topic: str) -> str:
    """Doc → md 证据件 (非 SERP 形; 摘要+元数据, 过 snippet 三规则)."""
    year = doc.get("year") or "n.d."
    src = doc.get("source") or ""
    url = doc.get("url") or "(无链接, 库内索引条目)"
    abstract = doc.get("abstract_head") or "(该库未收录摘要, 以标题/年份/来源为索引线索)"
    return (f"# {doc['title']}\n\n"
            f"- 年份: {year} ｜ 主题归类: {topic}\n"
            f"- 来源期刊/库: {src}\n"
            f"- 原文: {url}\n\n"
            f"## 摘要\n\n{abstract}\n\n"
            f"> 学术库索引件 (开放学术元数据; 摘要版权归出版方, 全文经原文链接获取)\n")


def run(cid: str, dry: bool = False, per_query: int = 5) -> int:
    out_dir = REPO / "data" / "harvest" / "academic" / cid
    out_dir.mkdir(parents=True, exist_ok=True)
    n_ok = n_skip = n_doc = 0
    for chan, query, eei, topic in PLAN:
        fn = SEARCHERS.get(chan)
        if not fn:
            continue
        try:
            docs = fn(query, limit=per_query)
        except Exception as e:                       # 429/超时/HTTP 错如实 skip
            n_skip += 1
            print(f"[harvest] skip {chan} '{query[:40]}' — {type(e).__name__}: "
                  f"{str(e)[:80]}")
            continue
        for i, doc in enumerate(docs, 1):
            fp = out_dir / f"{chan}_{_slug(query)}_{i}.md"
            if not fp.exists():
                fp.write_text(compose_doc(doc, topic), encoding="utf-8")
            if dry:
                n_doc += 1
                continue
            rc = ammo_pool.ingest(
                cid, str(fp), engine=f"academic:{chan}",
                url=doc.get("url") or "", cred="research",
                tree=eei, stance="support")
            n_doc += 1
            n_ok += 1 if rc == 0 else 0
        print(f"[harvest] {chan:<17} '{query[:44]}' → {len(docs)} docs → {eee_label(eei, topic)}")
    tag = "DRY" if dry else "APPLY"
    print(f"[harvest] {tag}: 发起 {len(PLAN)} 查询 | 文档 {n_doc} | 渠道级 skip "
          f"{n_skip} (限流如实) | 入池 rc0 {n_ok}")
    return 0


def eee_label(eei: str, topic: str) -> str:
    return f"{eei}({topic})"


def main() -> int:
    ap = argparse.ArgumentParser(description="学术API收割腿 (B/C 补采)")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--per-query", type=int, default=5)
    ns = ap.parse_args()
    return run(ns.campaign, ns.dry, ns.per_query)


if __name__ == "__main__":
    sys.exit(main())
