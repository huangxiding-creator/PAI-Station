# -*- coding: utf-8 -*-
"""QQ 邮箱驱动：envelope 分页拉取（只读+限流纪律）→ 缓存 → 实体/时间轴/报告。

账号安全：QQMAIL_CLI_READONLY=1；每页 2s 间隔、上限 10 页；退码 30（限流）即停。
用法：python tools/cx_qqmail.py [--pages N]
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_qqmail import (  # noqa: E402
    classify_mail,
    collect_mail_events,
    parse_envelopes,
    register_mail_contacts,
)
from paistation.cx.timeline import TimelineStore  # noqa: E402

CACHE = REPO / "data/cx/collect_cache/qqmail_envelopes.json"
REPORT = REPO / "SELF_PROFILE/cx_邮件工作面_20260916.md"
CLI = Path.home() / "AppData/Local/Microsoft/WindowsApps/qqmail-cli.exe"
MAX_PAGES = 10


def pull_envelopes(pages: int) -> list[dict]:
    """分页拉信封（增量合并缓存），返回全量列表。"""
    cached = json.loads(CACHE.read_text(encoding="utf-8")) if CACHE.exists() else []
    have = {m["id"] for m in cached}
    merged = list(cached)
    before_uid = 0
    for page in range(pages):
        cmd = [str(CLI), "envelope", "list", "--json", "--limit", "50"]
        if before_uid:
            cmd += ["--before-uid", str(before_uid)]
        proc = subprocess.run(cmd, capture_output=True, text=True,
                              encoding="utf-8", errors="replace",
                              env={"QQMAIL_CLI_READONLY": "1", **__import__("os").environ},
                              creationflags=0x08000000, timeout=90)
        if proc.returncode == 30:
            print("限流（rc=30）——停 10-15 分钟后再跑（断点在缓存）")
            break
        if proc.returncode != 0:
            print(f"rc={proc.returncode}: {proc.stderr.strip()[:200]}")
            break
        mails = parse_envelopes(proc.stdout)
        new = [m for m in mails if m["id"] not in have]
        for m in new:
            have.add(m["id"])
            merged.append(m)
        print(f"页{page + 1}: +{len(new)}（服务端 {len(mails)}）")
        if not mails:
            break
        CACHE.write_text(json.dumps(merged, ensure_ascii=False, indent=1),
                         encoding="utf-8")
        try:
            nxt = json.loads(proc.stdout).get("data", {}).get("page", {}).get(
                "next_before_uid")
        except ValueError:
            nxt = None
        if not nxt or len(mails) < 20:
            break
        before_uid = int(nxt)
        time.sleep(2.0)
    return merged


def main() -> int:
    pages = MAX_PAGES
    if "--pages" in sys.argv:
        pages = int(sys.argv[sys.argv.index("--pages") + 1])
    mails = pull_envelopes(pages)
    print(f"缓存合计: {len(mails)} 封")

    by_cls: dict[str, int] = {}
    for m in mails:
        cls = classify_mail(m["subject"], m["from_email"])
        by_cls[cls] = by_cls.get(cls, 0) + 1
    print(f"分类: {json.dumps(by_cls, ensure_ascii=False)}")

    store = EntityStore(REPO / "data/cx/entities.db")
    registered = register_mail_contacts(store, mails)
    evs = collect_mail_events(mails)
    tstore = TimelineStore(REPO / "data/cx/timeline.db")
    ins, skip = tstore.ingest(evs)
    print(f"work 信封入图谱: {registered} | timeline email.receive: "
          f"inserted {ins}, skipped {skip}")

    work = [m for m in mails if classify_mail(m["subject"], m["from_email"]) == "work"]
    work.sort(key=lambda m: m["date"], reverse=True)
    lines = [
        "# 邮件工作面（QQ 邮箱信封元数据）",
        "",
        f"> 2026-09-16 · 只读信封 {len(mails)} 封；个人消费类 {by_cls.get('personal', 0)} 封"
        f"按目的边界不入图谱；工作面 {len(work)} 封",
        "",
        "| 日期 | 发件方 | 主题 |",
        "|---|---|---|",
    ]
    for m in work[:60]:
        lines.append(f"| {m['date'][:10]} | {m['from_name'] or m['from_email']} "
                     f"| {m['subject'][:60]} |")
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"→ {REPORT.name} | stats: "
          f"{json.dumps(store.stats(), ensure_ascii=False)}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
