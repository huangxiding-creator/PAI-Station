"""空章修复轮：对已提取书籍的 html=0 章节复取并回写产物。

背景（2026-09-21 实锤《筑基专家话"新基建EPC"》）：批跑时 15 章 html=0，
抽查复取 3 章中 2 章有正文——瞬态空（解密空/服务端抖动）非真分节页。
复取仍空者视为真分节页（标题即全页，可接受），保持原样。

用法:
  python scripts/weread_patch_empty.py --book-dir "data/weread/筑基专家话_新基建EPC" --book-id 3300224317

安全：走 WeReadClient 内置节流（3.5-8s/请求+长歇）；只补今日自己提的书。
"""
import argparse
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.weread import WeReadClient, extract_book  # noqa: E402
from scripts.weread_batch import persist_book  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser(description="微信读书空章修复轮")
    ap.add_argument("--book-dir", required=True)
    ap.add_argument("--book-id", required=True)
    args = ap.parse_args()

    raw = os.path.join(args.book_dir, "book.json")
    with open(raw, encoding="utf-8") as fh:
        book = json.load(fh)

    empties = [c for c in book["chapters"]
               if not c.get("skipped") and not (c.get("html") or "").strip()]
    print(f"[patch] 空章 {len(empties)} 个，逐个复取")
    cli = WeReadClient(auth_path=os.path.join(
        os.path.dirname(args.book_dir), "_auth", "weread_auth.json"))
    fixed = still = 0
    for c in empties:
        try:
            got = cli.chapter_html(args.book_id, c["chapterUid"],
                                   book.get("format", "epub"))
        except Exception as exc:                     # noqa: BLE001 - 单章不挡轮
            print(f"[patch] uid={c['chapterUid']} 异常跳过: {str(exc)[:80]}")
            continue
        html = (got.get("html") or "").strip()
        if html:
            c["html"] = got["html"]
            fixed += 1
            print(f"[patch] uid={c['chapterUid']} ✓ 补正文 "
                  f"{len(html)} 字符 [{c['title'][:24]}]")
        else:
            still += 1
            print(f"[patch] uid={c['chapterUid']} - 仍空（真分节页）"
                  f" [{c['title'][:24]}]")

    if not fixed:
        print(f"[patch] 无可修复章（仍空 {still}）")
        return 0

    # 原子回写 + 全量重出产物（persist_book 内含 text 字段/图片/md/docx）
    persist_book(book, cli, with_docx=True)
    n_empty = sum(1 for c in book["chapters"]
                  if not c.get("skipped") and not (c.get("html") or "").strip())
    chars = sum(len(c.get("text", "")) for c in book["chapters"])
    print(f"[patch] 完成：补 {fixed} 章 / 仍空 {n_empty}（分节页） | "
          f"全书 {chars} 字 | book.json+md+docx 已重写")
    return 0


if __name__ == "__main__":
    sys.exit(main())
