# -*- coding: utf-8 -*-
"""harvest_court — 涉诉检索收割腿 (1015 用户批 B/C 补采 · C 轴 court 渠道).

manifest 口径: wenshu 直采受限 → metaso/websearch 二手源兜底。本腿用
anysearch 通道 (已验证可用) 的 search+extract 打二手源: 裁判文书网镜像/
法院官网/律所解读/检察文书, 取 EPC 招投标 纠纷判例全文。

纪律: engine=court:anysearch 兜底 (C 轴 court 子串命中, 源语义=二手兜底
如实标 media/research); 判例原文优先 (cred=research), 官方站台 cred=official;
snippet 门/查重 ingest 内建; 限流沿用 AnySearchClient (匿名 10/窗)。

用法: py reforge_factory/harvest_court.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
import ammo_pool                                        # noqa: E402
from collectors.anysearch.client import AnySearchClient   # noqa: E402

REPO = Path(__file__).resolve().parents[1]

# (查询, EEI) — 风险纠纷 Q13(判例/败诉) 国际对标 Q23(争议解决 FIDIC 仲裁)
PLAN: list[tuple[str, str, str]] = [
    ("工程总承包 EPC 合同纠纷 判决书", "Q13-E2", "research"),
    ("招标投标 合同纠纷 裁判文书 判例", "Q13-E2", "research"),
    ("EPC 总承包 超概算 纠纷 案例", "Q13-E1", "media"),
    ("FIDIC 合同 仲裁 争议解决 案例", "Q23-E2", "research"),
    ("招投标 行政诉讼 处罚 判决", "Q13-E2", "research"),
]
JUDGE_RE = re.compile(r"判决|裁定|仲裁|判例|裁判|纠纷|诉讼|案")
PER_QUERY = 3


def run(cid: str, dry: bool = False) -> int:
    out = REPO / "data" / "harvest" / "court" / cid
    out.mkdir(parents=True, exist_ok=True)
    cli = AnySearchClient()
    n_ok = n_skip = 0
    for q, eei, cred in PLAN:
        try:
            resp = cli.search(q, max_results=PER_QUERY + 2) or {}
            res = ((resp.get("data") or {}).get("results")) or []
        except Exception as e:
            print(f"[court] search 失败 '{q}': {str(e)[:70]}")
            continue
        got = 0
        for it in res:
            if got >= PER_QUERY:
                break
            data = it if isinstance(it, dict) else {}
            title = str(data.get("title") or data.get("name") or "")
            url = str(data.get("url") or data.get("link") or "")
            if not title or not url or not JUDGE_RE.search(title):
                continue
            content = ""
            try:
                ex = cli.extract(url) or {}
                content = str(((ex.get("data") or {}).get("content"))
                              or ex.get("content") or "")
            except Exception:
                pass
            if len(content) < 400:
                # extract 失败/薄 → 搜索结果自带 content 字段兜底 (二手源摘要级)
                content = str(data.get("content") or data.get("snippet") or "")
            if len(content) < 400:
                n_skip += 1
                continue
            fp = out / (re.sub(r"[^\w一-鿿-]+", "_", title)[:50] + ".md")
            fp.write_text(f"# {title}\n\n> 涉诉检索二手源 ({url})\n\n{content}",
                          encoding="utf-8")
            got += 1
            n_ok += 1
            if not dry:
                ammo_pool.ingest(cid, str(fp), engine="court:anysearch",
                                 url=url, cred=cred, tree=eei, stance="against")
        print(f"[court] '{q}' → {got} 件")
    print(f"[court] {'DRY' if dry else 'APPLY'}: 取回 {n_ok} | 内容不足跳过 "
          f"{n_skip}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="涉诉检索收割腿 (court 兜底)")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    return run(ns.campaign, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
