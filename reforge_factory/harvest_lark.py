# -*- coding: utf-8 -*-
"""harvest_lark — 飞书语料收割腿 (1015 用户批 B/C 补采 · C 轴 lark 渠道).

链路: lark-cli drive +search (面词×域词) → docs +fetch markdown → 落
data/harvest/lark/<cid>/ → ammo_pool.ingest (engine=lark:docs, C 轴子串
命中 lark 渠道; url=飞书文档链接 → 独立 host=epctalkk.feishu.cn).

纪律: 双重相关门 (标题命中查询词即可信 — 服务端搜索已按相关召回, 再做
域词兜底); 只取 DOCX/DOC 正文文档 (SHORTCUT/表格跳过); 每查询 5 件,
全租户语料只读零写入; snippet 门/查重 ingest 内建。

用法: py reforge_factory/harvest_lark.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import ammo_pool                                        # noqa: E402

REPO = Path(__file__).resolve().parents[1]
LARK = r"C:\Users\91216\AppData\Roaming\npm\lark-cli.cmd"

# (查询词, 目标 EEI) — 四面为主, 域词兜底
PLAN: list[tuple[str, str]] = [
    ("FIDIC", "Q23-E1"),
    ("国际工程", "Q24-E1"),
    ("电子招投标", "Q19-E1"),
    ("招标代理", "Q25-E1"),
    ("评标专家", "Q21-E1"),
    ("工程总承包 招标", "Q1-E1"),
    ("BIM", "Q19-E1"),
    ("供应链 采购", "Q25-E1"),
]
DOMAIN_RE = re.compile(r"招标|投标|评标|工程|EPC|采购|承包|造价|FIDIC|BIM|供应链")
PER_QUERY = 5


def _lark(*args: str) -> dict:
    r = subprocess.run(["cmd", "/c", LARK, *args], capture_output=True,
                       text=True, encoding="utf-8", errors="replace",
                       timeout=120)
    try:
        return json.loads(r.stdout)
    except json.JSONDecodeError:
        return {"ok": False, "error": {"message": f"stdout: {r.stdout[:120]}"}}


def search(q: str, size: int = PER_QUERY) -> list[dict]:
    d = _lark("drive", "+search", "--query", q, "--page-size", str(size))
    if not d.get("ok"):
        print(f"[lark] search 失败 '{q}': "
              f"{str(d.get('error', {}).get('message'))[:80]}")
        return []
    out = []
    for it in (d.get("data", {}) or {}).get("results") or []:
        meta = it.get("result_meta", {}) or {}
        title = re.sub(r"</?h>", "", str(it.get("title_highlighted", "")))
        dt = str(meta.get("doc_types", ""))
        if dt not in ("DOCX", "DOC"):          # 正文文档才取 (快捷方式/表跳过)
            continue
        out.append({"title": title, "token": meta.get("token", ""),
                    "url": meta.get("url", ""), "type": dt})
    return out


def fetch_md(token: str) -> str:
    d = _lark("docs", "+fetch", "--doc", token, "--doc-format", "markdown")
    if not d.get("ok"):
        return ""
    doc = ((d.get("data", {}) or {}).get("document")) or {}
    v = doc.get("content")
    if isinstance(v, str) and len(v) > 200:
        return v
    # 兜底: data 直挂 / document.text 形态
    data = d.get("data", {}) or {}
    for src in (data, doc):
        for v in (src.get("markdown"), src.get("content"), src.get("text")):
            if isinstance(v, str) and len(v) > 200:
                return v
    return ""


def run(cid: str, dry: bool = False) -> int:
    out_dir = REPO / "data" / "harvest" / "lark" / cid
    out_dir.mkdir(parents=True, exist_ok=True)
    n_fetched = n_ing = n_skip = 0
    seen_tokens: set[str] = set()
    for q, eei in PLAN:
        for hit in search(q):
            tok = hit["token"]
            if not tok or tok in seen_tokens:
                continue
            seen_tokens.add(tok)
            if not DOMAIN_RE.search(hit["title"]):
                n_skip += 1
                continue
            fp = out_dir / (re.sub(r"[^\w一-鿿-]+", "_",
                                   hit["title"])[:50] + ".md")
            if not fp.exists():
                md = fetch_md(tok)
                if len(md) < 300:              # 空文档/权限不足如实跳
                    n_skip += 1
                    continue
                head = (f"# {hit['title']}\n\n> 来源: 飞书文档 ({hit['url']})\n\n"
                        + md)
                fp.write_text(head, encoding="utf-8")
            n_fetched += 1
            if dry:
                print(f"  [dry] {eei} {hit['title'][:48]}")
                continue
            ammo_pool.ingest(cid, str(fp), engine="lark:docs",
                             url=hit["url"], cred="research",
                             tree=eei, stance="support")
            n_ing += 1
        print(f"[lark] '{q}' → 累计 fetched {n_fetched} / skip {n_skip}")
    print(f"[lark] {'DRY' if dry else 'APPLY'}: 抓取 {n_fetched} | 域门跳过 "
          f"{n_skip} | 入池 {n_ing}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="飞书语料收割腿 (C lark 渠道)")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    return run(ns.campaign, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
