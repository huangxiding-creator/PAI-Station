# -*- coding: utf-8 -*-
"""direct_fetch_supply — WebSearch发现+直抓入池 (r4 腿, 零配额).

anysearch 日配额见底 (186/200) → 本腿照 JIAGE 涉诉腿先例:
  SERP 发现 = 会话内建 WebSearch (真调, 逐条落 channel_invocations);
  全文 = curl_cffi impersonate=chrome 纯HTTP直抓 (零浏览器零配额);
  域门 = CJK ≥400 ∧ want 词在场 (与池 substance 同口径), 不域内=如实拒。

用法: py -X utf8 direct_fetch_supply.py "<url>" "<eei如Q14-E2>" "<want词>" \
        [--stance against] [--cred media] [--engine direct_web]
"""
from __future__ import annotations

import argparse
import html as H
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from ammo_pool import count_chars  # noqa: E402

REPO = Path(r"E:\AI-Station")
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
POOL = REPO / "ammo_pool" / "EPC-TOP50"
STAGE = POOL / "staging" / "direct_fetch"
STAGE.mkdir(parents=True, exist_ok=True)
CID = "EPC-TOP50"

DOM_SKIP = ("zhihu.com/question", "weibo.com", "douyin", "bilibili",
            "csdn.net", "tieba", "mp.blog.csdn")


def html2text(html: str) -> str:
    h = re.sub(r"(?is)<(script|style|iframe|noscript|svg)[^>]*>.*?</\1>",
               " ", html)
    h = re.sub(r"(?is)<br\s*/?>|</p>|</div>|</li>|</tr>|</h[1-6]>", "\n", h)
    t = re.sub(r"(?s)<[^>]+>", " ", h)
    t = H.unescape(t)
    t = re.sub(r"[ \t\r\xa0]+", " ", t)
    return re.sub(r"\n\s*\n+", "\n", t).strip()


def fetch(url: str) -> str:
    from curl_cffi import requests as cr
    r = cr.get(url, impersonate="chrome", timeout=40,
               headers={"Accept-Language": "zh-CN,zh;q=9"})
    r.raise_for_status()
    enc = r.encoding or "utf-8"
    try:
        body = r.content.decode(enc, errors="replace")
    except LookupError:
        body = r.content.decode("utf-8", errors="replace")
    if "<html" in body[:2000].lower() or "<div" in body[:2000].lower():
        return html2text(body)
    return body.strip()


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("url")
    ap.add_argument("eeis")            # 逗号分隔, 首个为主挂树
    ap.add_argument("want")
    ap.add_argument("--stance", default="")
    ap.add_argument("--cred", default="media")
    ap.add_argument("--engine", default="direct_web")
    ap.add_argument("--title", default="")
    ns = ap.parse_args()
    eeis = [e.strip() for e in ns.eeis.split(",") if e.strip()]
    if any(d in ns.url for d in DOM_SKIP):
        print(json.dumps({"ok": False, "why": "dom_skip"}, ensure_ascii=False))
        return 1
    try:
        text = fetch(ns.url)
    except Exception as e:                                # noqa: BLE001
        rec = {"ok": False, "why": f"fetch_fail:{type(e).__name__}"}
        print(json.dumps(rec, ensure_ascii=False))
        (STAGE / "fetch_log.jsonl").open("a", encoding="utf-8").write(
            json.dumps({**rec, "url": ns.url, "eeis": eeis,
                        "ts": time.strftime("%F %T")},
                       ensure_ascii=False) + "\n")
        return 1
    cjk = count_chars(text)
    want = [w for w in ns.want.split(",") if w]
    if cjk < 400 or not any(w in text for w in want):
        rec = {"ok": False, "why": "content_not_in_domain", "cjk": cjk}
        print(json.dumps(rec, ensure_ascii=False))
        (STAGE / "fetch_log.jsonl").open("a", encoding="utf-8").write(
            json.dumps({**rec, "url": ns.url, "eeis": eeis,
                        "ts": time.strftime("%F %T")},
                       ensure_ascii=False) + "\n")
        return 1
    title = ns.title or re.sub(r"\s+", " ", text[:60])[:50]
    md = STAGE / (re.sub(r"\W+", "_", title)[:50] + ".md")
    md.write_text(
        f"# {title}\n\n来源: {ns.url} (engine={ns.engine}, 直抓 "
        f"{time.strftime('%F %T')}, r4 WebSearch发现+纯HTTP直抓腿)\n"
        f"campaign {CID}, tree {'+'.join(eeis)}, cred {ns.cred}\n\n---\n\n"
        f"{text[:120000]}", encoding="utf-8")
    stance = ns.stance or ("against" if eeis[0].endswith("-E2")
                           else "support")
    rc = subprocess.run(
        ["py", "-X", "utf8", str(AMMO), "ingest", CID, "--file", str(md),
         "--engine", ns.engine, "--url", ns.url, "--cred", ns.cred,
         "--tree", eeis[0], "--stance", stance],
        capture_output=True, text=True, encoding="utf-8", errors="replace")
    msg = (rc.stdout or "") + (rc.stderr or "")
    ok = rc.returncode == 0 and ("+待审" in msg or "重复" in msg)
    rec = {"ok": ok, "cjk": cjk, "title": title, "file": str(md),
           "eeis": eeis, "msg": msg.strip()[-80:]}
    print(json.dumps(rec, ensure_ascii=False))
    (STAGE / "fetch_log.jsonl").open("a", encoding="utf-8").write(
        json.dumps({**rec, "url": ns.url, "ts": time.strftime("%F %T")},
                   ensure_ascii=False) + "\n")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
