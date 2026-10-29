# -*- coding: utf-8 -*-
"""dangdang_leg — 当当图书情报采集腿 (1024 当当专项令 + API优先令).

架构 (同 wenku_harvest v3 模式, 纯 API 无浏览器降级 — 当当面无浏览器腿, WAF 走 m 端绕行):
  复刻件 dangdang_api (api_replica_bridge 登记): search.dangdang.com SERP 题录 +
  product.m.dangdang.com/detail<pid>-0-1.html 详情 (内容简介/作者简介/目录框架/出版信息);
  PC 详情页在 Aliyun WAF aliyunwaf JS 挑战后 — m 端免挑战, 复刻件原生绕行 (不破挑战)。

链路: 关键词 → 题录 (家族去重: 书名核心+评论择优) → 详情 → staging/dangdang/
简介md + 目录md → ammo_pool ingest (engine=dangdang, cred=media, url=商品页/m页真源)
→ 台账 channel_invocations.jsonl 追加 (api_replica: 前缀)。

产物: ammo_pool/<战役>/staging/dangdang/dd_<pid>_{intro,toc}.md
用法: py reforge_factory/legs/dangdang_leg.py EPC-OVERSEAS [--q "词1|词2"] [--limit 5]
      [--no-ingest]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb               # noqa: E402 (1024 API优先桥)
REPO = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO / "reforge_factory"))
from ammo_pool import ingest as pool_ingest    # noqa: E402 (URL 真源入池)


def core(title: str) -> str:
    s = re.sub(r"^(正版书籍|正版书|正版|全新|新书|2023新)\s*[:：]?\s*", "", title.strip())
    s = re.sub(r"^[“”\"'《【[]+", "", s)
    s = re.sub(r"[^\w一-鿿A-Za-z0-9]", "", s)
    return s[:12]


def harvest_api(query: str, limit: int, campaign: str, out_dir: Path,
                ingest: bool = True) -> dict:
    """API 优先路径 (当当无浏览器腿 — 复刻件抛错即如实失败, 不造假)。"""
    mod = arb.load("dangdang")
    cli = mod.DangdangClient()
    items = cli.search(query)
    # 已入池 URL 集 (engine=dangdang) — 入池计数只记新URL, 重复跳过如实分开计
    seen_urls: set[str] = set()
    mp = REPO / "ammo_pool" / campaign / "manifest.jsonl"
    if mp.is_file():
        try:
            for line in mp.read_text(encoding="utf-8").splitlines():
                if not line.strip():
                    continue
                j = json.loads(line)
                if j.get("engine") == "dangdang" and j.get("url_norm"):
                    seen_urls.add(j["url_norm"])
        except (json.JSONDecodeError, OSError):
            pass
    def _ingest(fp: Path, url: str) -> int:
        """入池 → 1=新入池 0=重复跳过 -1=失败 (数字零造假禁)。"""
        if url in seen_urls:
            return 0
        if pool_ingest(campaign, str(fp), "dangdang", url=url, cred="media") != 0:
            return -1
        seen_urls.add(url)
        return 1
    fams: dict[str, list[dict]] = {}
    for it in items[:15]:
        fams.setdefault(core(it["title"]), []).append(it)
    ranked = sorted(fams.items(),
                    key=lambda kv: -max(x["comments"] for x in kv[1]))
    n_books = n_files = n_ing = 0
    results = []
    for _k, copies in ranked:
        if n_books >= limit:
            break
        copies = sorted(copies, key=lambda x: (-x["comments"], len(x["pid"])))
        got = None
        for rec in copies[:4]:                   # 集市副本薄页 → 换份再试
            try:
                d = cli.detail(rec["pid"])
            except Exception:
                continue
            has_intro = bool(d["content_intro"] or d["sections"].get("编辑推荐")
                             or d["sections"].get("推荐语"))
            if has_intro or not d["toc_missing"]:
                if got is None or (has_intro and not got[2]):
                    got = (rec, d, has_intro, not d["toc_missing"])
                if got[2] and got[3]:
                    break
        if not got:
            continue
        rec, d, has_intro, has_toc = got
        n_books += 1
        head = (f"# {d['title']}\n\n"
                f"> 来源: 当当网图书情报 (dangdang_leg, 纯HTTP)\n"
                f"> URL: {d['url']}\n> ISBN: {d['isbn'] or ''}\n"
                f"> 作者: {d['parms'].get('作者', rec['author_line'])}\n"
                f"> 出版社: {d['publisher'] or ''}\n> 出版时间: {d['pubdate'] or ''}\n"
                f"> 检索词: {query}\n> 采集: {time.strftime('%F %T')}\n\n")
        if has_intro:
            parts = []
            if d["content_intro"]:
                parts.append(("内容简介", d["content_intro"]))
            if d["author_intro"]:
                parts.append(("作者简介", d["author_intro"]))
            body = "\n\n".join(f"## {t}\n\n{v}" for t, v in parts)
            fp = out_dir / f"dd_{d['pid']}_intro.md"
            fp.write_text(head + body + "\n", encoding="utf-8")
            if ingest:
                rc = _ingest(fp, d["url"])
                if rc == 1:
                    n_ing += 1
            n_files += 1
        if has_toc:
            fp = out_dir / f"dd_{d['pid']}_toc.md"
            fp.write_text(head + "## 目录框架\n\n```\n" + d["toc"] + "\n```\n",
                          encoding="utf-8")
            if ingest:
                # 目录真源=移动端详情页 (同书两个真源URL, 池按URL去重各留一份)
                rc = _ingest(fp, f"http://product.m.dangdang.com/detail{d['pid']}-0-1.html")
                if rc == 1:
                    n_ing += 1
            n_files += 1
        results.append({"pid": d["pid"], "title": d["title"][:40],
                        "intro": has_intro, "toc": has_toc,
                        "toc_lines": len(d["toc_lines"])})
        print(f"  [dangdang] {n_books:02d} {'V' if has_intro else '-'}"
              f"{'V' if has_toc else '-'} {d['title'][:32]} (目录{len(d['toc_lines'])}行)",
              flush=True)
    return {"books": n_books, "files": n_files, "ingested": n_ing, "results": results}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("campaign")
    ap.add_argument("--q", default="国际工程EPC")
    ap.add_argument("--limit", type=int, default=5)
    ap.add_argument("--no-ingest", action="store_true",
                    help="只落 staging 不入池 (冒烟/检视用)")
    ns = ap.parse_args()
    queries = ns.q.split("|") if "|" in ns.q else [ns.q]

    tot_books = tot_files = tot_ing = 0
    for q in queries:
        out_dir = REPO / "ammo_pool" / ns.campaign / "staging" / "dangdang"
        out_dir.mkdir(parents=True, exist_ok=True)
        print(f"[dangdang] '{q.strip()}' limit={ns.limit}", flush=True)
        try:
            r = harvest_api(q.strip(), ns.limit, ns.campaign, out_dir,
                            ingest=not ns.no_ingest)
        except Exception as e:                    # 墙/网络/依赖缺 — 如实打印不造假
            print(f"[dangdang] FAIL {q.strip()}: {type(e).__name__}: {str(e)[:160]}",
                  flush=True)
            continue
        tot_books += r["books"]; tot_files += r["files"]; tot_ing += r["ingested"]
        arb.append_invocation(
            "dangdang",
            "api_replica:dangdang_api(SERP题录+移动端详情简介/目录, 纯HTTP零浏览器)",
            q.strip(),
            f"{r['books']}本书/{r['files']}件md"
            + (f"/入池{r['ingested']}" if not ns.no_ingest else "/未入池(no-ingest)"),
            note="1024 当当专项令: 图书情报腿 (题录/简介/目录框架); "
                 "PC详情页Aliyun WAF→m端原生绕行",
            campaign=ns.campaign)
        time.sleep(2)
    print(f"== 当当图书情报腿: {tot_books} 本 / {tot_files} 件 / 入池 {tot_ing}")


if __name__ == "__main__":
    main()
