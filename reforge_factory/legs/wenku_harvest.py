# -*- coding: utf-8 -*-
"""wenku_harvest — 百度文库采集腿 v3 (1024 API优先令).

架构 (API 优先, 浏览器降级兜底):
  ① API 路径 (优先): 复刻件 wenku_full_api (syncmrecall 免登录检索 + ndview
     判型 + type3 文字层直链全文, 纯 HTTP 零浏览器) — 1024 逆向收官成果;
  ② 浏览器路径 (降级兜底, 原样保留): 一个浏览器全程: wenku搜索页→提取文档
     链接→逐个拉正文→入池 (百度403直采+JS渲染必须浏览器, 但一次打开批量处理=高效)。
产物: corpus/wenku_harvest/*.md → 入池 engine=wenku

用法: py wenku_harvest.py EPC-OVERSEAS [--q "词1|词2"] [--limit 5]
"""
from __future__ import annotations

import argparse
import json
import random
import re
import sys
import time
from pathlib import Path
from urllib.parse import quote_plus

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb               # noqa: E402 (1024 API优先桥)
REPO = Path(__file__).resolve().parents[2]
OUT = REPO / "corpus" / "wenku_harvest"


def harvest_api(query: str, limit: int) -> tuple[list[dict], str]:
    """API 优先路径 (1024): 复刻件 wenku_full_api.full_chain — 纯 HTTP 零浏览器.

    成功 → (docs, ""); 复刻件抛错/零全文 → ([], 原因) — 调用方降级浏览器路径。"""
    try:
        mod = arb.load("wenku")
        sess_dir = OUT / f"api_{time.strftime('%Y%m%d_%H%M%S')}"
        summary = mod.full_chain(query, sess_dir, need=limit,
                                 scan=max(limit * 3, 6), session="leg")
        docs = []
        for rec in summary.get("full_docs", []):
            fp = Path(rec.get("file") or "")
            if not fp.is_file():
                continue
            docs.append({"title": rec.get("title", ""),
                         "url": f"https://wenku.baidu.com/view/{rec.get('doc_id')}.html",
                         "body": fp.read_text(encoding="utf-8")})
        if not docs:
            skip = summary.get("skipped", [])
            return [], (f"api零全文: full_n={summary.get('full_n', 0)} "
                        f"skip={len(skip)}" + (f" 首因={skip[0].get('why', '')}" if skip else ""))
        return docs, ""
    except Exception as e:                            # 墙/配额/依赖缺 — 如实降级
        return [], f"{type(e).__name__}: {str(e)[:120]}"


def harvest_browser(query: str, limit: int) -> list[dict]:
    """一个浏览器: 搜索→提取链接→逐个拉正文."""
    from DrissionPage import Chromium, ChromiumOptions
    co = ChromiumOptions()
    co.set_argument("--window-position=-32000,0")
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_local_port(9986)
    browser = Chromium(co)
    page = browser.latest_tab
    docs = []

    try:
        # ① 文库搜索页
        search_url = f"https://wenku.baidu.com/search?word={quote_plus(query)}&lm=0"
        page.get(search_url)
        time.sleep(5)
        print(f"  搜索页: {page.url[:50]}", flush=True)

        # ② 提取文档链接 (等JS渲染)
        links = page.run_js("""
            var results = [];
            document.querySelectorAll('a[href*="/view/"]').forEach(function(a) {
                var href = a.href;
                var title = a.innerText.trim();
                if (href.includes('/view/') && title.length > 5 && title.length < 100) {
                    results.push({url: href, title: title});
                }
            });
            return JSON.stringify(results.slice(0, 15));
        """)
        results = json.loads(links) if links else []
        print(f"  文档链接: {len(results)}", flush=True)

        # ③ 逐个拉正文
        for item in results[:limit]:
            try:
                page.get(item["url"])
                time.sleep(3)
                body = page.run_js("""
                    var el = document.querySelector('.doc-content') ||
                            document.querySelector('.reader-content') ||
                            document.querySelector('.reader-inner') ||
                            document.querySelector('#html-reader-wrapper');
                    if (el) return el.innerText.substring(0, 30000);
                    return document.body.innerText.substring(0, 30000);
                """)
                if body and len(str(body)) > 500:
                    docs.append({**item, "body": str(body)})
                    print(f"  📄 {item['title'][:30]} ({len(str(body))}字)", flush=True)
                else:
                    print(f"  ⚠️ {item['title'][:20]} 正文薄({len(str(body)) if body else 0}字)", flush=True)
            except Exception as e:
                print(f"  ✗ {item['title'][:20]}: {type(e).__name__}", flush=True)
            time.sleep(random.uniform(2, 4))
    except Exception as e:
        print(f"  浏览器异常: {type(e).__name__}: {str(e)[:80]}", flush=True)
    finally:
        browser.quit()
    return docs


def harvest(query: str, limit: int, campaign: str, ingest: bool = True) -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    print(f"[wenku] '{query[:20]}' limit={limit}", flush=True)
    docs, api_reason = harvest_api(query, limit)      # ① API 优先 (零浏览器)
    if docs:
        chars = sum(len(d["body"]) for d in docs)
        print(f"[wenku] API路径直出 {len(docs)} 件 ({chars}字, 复刻件 wenku_full_api, 零浏览器)", flush=True)
        arb.append_invocation(
            "kb_harvest",
            "api_replica:wenku_full_api.full_chain(syncmrecall检索+ndview判型+type3全文, 纯HTTP)",
            query, f"{len(docs)}件全文({chars}字)",
            note="1024 API优先令: wenku浏览器腿切复刻件直出; 降级条件=复刻件抛墙/零全文",
            campaign=campaign)
    else:                                             # ② 降级兜底 (原浏览器路径, 原样保留)
        print(f"[wenku] API路径未成({api_reason}) → 降级浏览器路径 (fallback 原因如上)", flush=True)
        docs = harvest_browser(query, limit)
    if not docs:
        return 0

    n = 0
    for doc in docs:
        fn = OUT / f"wenku_{n:03d}.md"
        fn.write_text(
            f"# {doc['title']}\n\n> 来源: 百度文库\n> URL: {doc['url']}\n"
            f"> 查询: {query}\n> 采集: {time.strftime('%F %T')}\n\n"
            f"{doc['body']}\n", encoding="utf-8")
        n += 1

    if n > 0 and ingest:
        sys.path.insert(0, str(REPO / "reforge_factory"))
        from ammo_pool import ingest_files
        items = [{"file": str(p), "engine": "wenku", "cred": "research"}
                 for p in sorted(OUT.glob("wenku_*.md"))]
        a, s = ingest_files(campaign, items)
        print(f"[wenku] 入池: {a}/{n}", flush=True)
        for p in OUT.glob("wenku_*.md"):
            p.unlink()
    elif n > 0:
        print(f"[wenku] --no-ingest: {n} 件留 corpus/wenku_harvest/ 未入池", flush=True)
    return n


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("campaign")
    ap.add_argument("--q", default="国际工程 EPC 海外")
    ap.add_argument("--limit", type=int, default=5)
    ap.add_argument("--no-ingest", action="store_true",
                    help="只落 corpus 不入池 (冒烟/检视用)")
    ns = ap.parse_args()
    queries = ns.q.split("|") if "|" in ns.q else [ns.q]
    total = 0
    for q in queries:
        total += harvest(q.strip(), ns.limit, ns.campaign, ingest=not ns.no_ingest)
        time.sleep(2)
    print(f"== 百度文库采集: {total} 件")


if __name__ == "__main__":
    main()
