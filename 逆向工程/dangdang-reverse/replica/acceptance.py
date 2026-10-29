# -*- coding: utf-8 -*-
"""acceptance.py — 复刻件验收件: 5 次独立会话 × 3 验收关键词 全链贯通。

每会话全新 DangdangClient (零共享 cookie/态):
  搜索「国际工程 EPC」/「FIDIC」/「电力工程」→ 断言题录契约 (书名/作者/出版社/价格/评论数);
  每词取实质书 top3 (pick_books 去旧书集市噪音) 逐本详情 →
  断言 top3 内含 内容简介 (简介能力实证) 且含 目录 (目录框架能力实证);
  单本书缺简介/缺目录如实记账 (并非所有书都提供 — 不造假, 不硬凑)。
产物: ../captures/acceptance_5sessions.json
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
from dangdang_api import DangdangClient  # noqa: E402

KEYWORDS = ["国际工程 EPC", "FIDIC", "电力工程"]
CAP = Path(__file__).resolve().parents[1] / "captures" / "acceptance_5sessions.json"


def one_session(i: int) -> dict:
    rec = {"session": i, "keywords": {}, "ok": False}
    c = DangdangClient()                      # 独立会话
    for kw in KEYWORDS:
        items = c.search(kw)
        assert len(items) >= 10, f"{kw} 题录过少: {len(items)}"
        assert all(t["title"] and t["pid"] for t in items[:5]), f"{kw} 题录缺书名/pid"
        top5 = items[:5]
        assert any(t["publisher"] for t in top5), f"{kw} 题录缺出版社"
        assert any(t["price"] for t in top5), f"{kw} 题录缺价格"
        assert any(t["author_line"] or t["authors"] for t in top5), f"{kw} 题录缺作者"
        assert all(isinstance(t["comments"], int) for t in top5), f"{kw} 评论数非整数"
        books = []
        for rec_it in c.pick_books(kw, need=3):
            d = c.detail(rec_it["pid"])
            assert d["title"] and (d["isbn"] or d["publisher"]), \
                f"{kw} 详情缺书名/出版信息 pid={d['pid']}"
            books.append({
                "pid": d["pid"], "title": d["title"][:40],
                "serp": {"author_line": rec_it["author_line"][:24],
                         "publisher": rec_it["publisher"], "price": rec_it["price"],
                         "comments": rec_it["comments"]},
                "isbn": d["isbn"], "intro_chars": len(d["content_intro"] or ""),
                "intro_missing": d["content_intro"] is None,
                "toc_missing": d["toc_missing"], "toc_lines": len(d["toc_lines"]),
            })
        assert any(not b["intro_missing"] for b in books), f"{kw} top3 全缺内容简介"
        assert any(not b["toc_missing"] for b in books), f"{kw} top3 全缺目录"
        rec["keywords"][kw] = {"items": len(items), "books": books}
    rec["ok"] = True
    return rec


def main() -> int:
    log = []
    ok = 0
    for i in range(1, 6):
        try:
            rec = one_session(i)
            ok += 1
            state = "OK"
        except Exception as e:
            rec = {"session": i, "ok": False, "error": f"{type(e).__name__}: {e}"}
            state = "FAIL " + rec["error"]
        log.append(rec)
        print(f"[accept] session {i}/5: {state}", flush=True)
    out = {"ts": time.strftime("%F %T"), "pass_rate": f"{ok}/5", "ok": ok,
           "keywords": KEYWORDS, "log": log}
    CAP.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[accept] 贯通率 {ok}/5 → {CAP}")
    return 0 if ok == 5 else 1


if __name__ == "__main__":
    raise SystemExit(main())
