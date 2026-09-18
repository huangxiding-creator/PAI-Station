# -*- coding: utf-8 -*-
"""zbzs 外部号声誉边：B-ext/A-mirror 文章的来源号 → mentions → 总包之声。

31+ 家行业号（律所/工程局/咨询号）提及或转载总包之声内容——
品牌在生态里的声誉侧网络（关系维 org edges）。计数留在语料层
（zbzs_articles.jsonl），边只表达提及关系存在，幂等可重跑。

用法：python tools/cx_zbzs_edges.py
"""
from __future__ import annotations

import json
import sys
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402

ARTICLES = REPO / "SELF_PROFILE" / "zbzs" / "zbzs_articles.jsonl"
DB = REPO / "data" / "cx" / "entities.db"


def main() -> int:
    counts: Counter[str] = Counter()
    years: dict[str, str] = {}
    for ln in ARTICLES.read_text(encoding="utf-8").splitlines():
        a = json.loads(ln)
        if a.get("verdict") not in ("B-ext", "A-mirror"):
            continue
        acc = (a.get("account") or "").strip()
        if not acc:
            continue
        counts[acc] += 1
        y = a.get("year") or ""
        if y:
            years[acc] = min(years.get(acc, "9999"), y)

    store = EntityStore(DB)
    zbzs_id, _ = store.register(
        "org", "总包之声",
        aliases=["总包之声公众号", "zbzs"],
        source="zbzs_articles",
    )
    n_new_link = 0
    now = datetime.now(timezone.utc).isoformat(timespec="seconds")
    for acc, n in counts.most_common():
        acc_id, _ = store.register(
            "org", acc, aliases=[f"zbzs提及×{n}"], source="zbzs_articles")
        if store.register_link(
            acc_id, zbzs_id, "mentions", "zbzs_articles",
            seen_at=f"{years.get(acc, '2016')}-01-01T00:00:00+08:00"
            if years.get(acc) else now,
        ):
            n_new_link += 1
    print(f"声誉边：{len(counts)} 家外部号 mentions 总包之声"
          f"（新建 {n_new_link}，其余幂等）；文章计数 Top5：")
    for acc, n in counts.most_common(5):
        print(f"  {n} 篇 | {acc}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
