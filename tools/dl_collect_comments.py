# -*- coding: utf-8 -*-
"""dl_collect_comments — 面B1：公众号评论 API 采集器 (F4).

合法正道: material/news → (freepublish 回执链不可用时) 逐篇试 comment/list。
实测: 总包说 comment 权限通(需 article_id); 48001 号如实 skip。
用法: WECHAT_ACCOUNTS_FILE=F:/We-AIPO/data/wechat_accounts.json \
      py -X utf8 tools/dl_collect_comments.py
"""
from __future__ import annotations

import os
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "ResearchFactory-Eng" / "scripts"))
import demand_ledger as dl  # noqa: E402
from research_studio.promotion.wechat_publisher import (  # noqa: E402
    _session, load_account, get_access_token)

ACCOUNTS = ("总包之声", "总包说", "工程行业大脑")


def collect(acct: str) -> int:
    s = _session()
    try:
        acc = load_account(acct)
        tok = get_access_token(acc, s)
    except Exception as e:
        print(f"[B1] {acct} 凭据失败: {str(e)[:50]}")
        return 0
    n = 0
    # 已发文章 media_ids ← promo_ledger（自家发布回执，含 title）
    ledger = Path(__file__).resolve().parents[1] / "report_platform" / "promo" / "promo_ledger.jsonl"
    mids: list[tuple[str, str]] = []
    if ledger.exists():
        for ln in ledger.open(encoding="utf-8"):
            try:
                r = eval(ln.strip()) if ln.strip().startswith("{") and '"sku"' in ln else None
            except Exception:
                r = None
            if not r:
                continue
            if r.get("account") == acct and r.get("media_id"):
                mids.append((r["media_id"], r.get("title", "?")))
    for mid, title in mids[:20]:
        for cid_try in (0,):
            r = s.post(
                f"https://api.weixin.qq.com/cgi-bin/comment/list?access_token={tok}",
                json={"comment_id": cid_try, "article_id": mid,
                      "offset": 0, "count": 30, "elect": 0},
                timeout=20).json()
            err = r.get("errcode")
            if err == 48001:
                print(f"[B1] {acct} 48001 无评论权限, 如实 skip")
                return n
            if err == 88001:
                break  # 该文无评论数据, 下一篇
            if err:
                break
            cl = (r.get("comment") or {}).get("comment_list", [])
            for c in cl:
                quote = (c.get("content") or "").strip()
                if len(quote) < 8:
                    continue
                if dl.append("gzh_comment", quote,
                             ref=f"{acct}:{mid[:16]}",
                             jtbd={"trigger": "文章评论",
                                   "job_statement": f"读者在《{title[:20]}》下评论",
                                   "outcome": "表达需求/观点"},
                             urgency="high", score=70):
                    n += 1
            time.sleep(1.2)
            break
    print(f"[B1] {acct} 评论入账 {n}")
    return n


def main() -> int:
    total = 0
    for acct in ACCOUNTS:
        total += collect(acct)
    print("[B1] 完成:", dl.stats())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
