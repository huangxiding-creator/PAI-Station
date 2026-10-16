# -*- coding: utf-8 -*-
"""demand_signals_comments — 需求信号源②公众号评论区采集器 (L1).

评论=公开痛点。源: 有 comment 权限的号 (实测总包说; 另两号 48001 待权限).
流: freepublish/batchget 取已发文章 → 逐篇 comment/list (elect=0 全部) →
精选留言 jsonl。

用法: WECHAT_ACCOUNTS_FILE=F:/We-AIPO/data/wechat_accounts.json \
      py -X utf8 tools/demand_signals_comments.py [--account 总包说] [--count 10]
"""
from __future__ import annotations

import argparse
import json
import os
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1] /
                        "ResearchFactory-Eng" / "scripts"))
from research_studio.promotion.wechat_publisher import (  # noqa: E402
    _session, load_account, get_access_token)

OUT = Path(__file__).resolve().parents[1] / "data" / "demand_signals"


def api(s, tok, path, payload):
    r = s.post(f"https://api.weixin.qq.com/cgi-bin/{path}?access_token={tok}",
               json=payload or {}, timeout=30)
    return json.loads(r.content.decode("utf-8", "replace"))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--account", default="总包说")
    ap.add_argument("--count", type=int, default=10)
    ns = ap.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    s = _session()
    acc = load_account(ns.account)
    tok = get_access_token(acc, s)
    arts = api(s, tok, "freepublish/batchget",
               {"offset": 0, "count": ns.count, "no_content": 1})
    items = arts.get("item", []) or []
    print(f"[cmt] {ns.account} 已发 {arts.get('total_count')} 篇, 取 {len(items)} 篇")
    n = 0
    out = OUT / f"raw_comments_{time.strftime('%Y%m%d')}.jsonl"
    with out.open("a", encoding="utf-8") as f:
        for it in items:
            art = ((it.get("content", {}) or {}).get("news_item") or [{}])[0]
            title = art.get("title", "")
            msg_id = str(it.get("article_id") or art.get("article_id") or "")
            d = api(s, tok, "comment/list",
                    {"msg_dataid": msg_id, "index": 0, "begin": 0,
                     "count": 30, "type": 0, "elect": 0})
            if d.get("errcode") not in (0, None):
                print(f"  comment/list errcode={d.get('errcode')}"
                      f"({title[:20]}) — 48001=无权限, 其余格式问题继续")
                if d.get("errcode") == 48001:
                    return 2
                continue
            for c in d.get("comment", []) or []:
                f.write(json.dumps({
                    "ts": time.strftime(
                        "%Y-%m-%d %H:%M:%S",
                        time.localtime(c.get("create_time", 0))),
                    "source": "comments",
                    "channel": f"gzh:{ns.account}",
                    "actor": c.get("openid", "")[:16] + "…",
                    "text": (c.get("content", "") or "")[:500],
                    "meta": {"article": title[:60],
                             "reply_n": bool(c.get("reply", {}).get(
                                 "reply_list"))}},
                    ensure_ascii=False) + "\n")
                n += 1
    print(f"[cmt] {n} 条评论 → {out.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
