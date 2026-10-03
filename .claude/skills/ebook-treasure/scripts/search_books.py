# -*- coding: utf-8 -*-
"""ebook-treasure-chest 本地书单检索 — 24,071 本结构化索引 (docs/all-books.json).

来源: https://github.com/jbiaojerry/ebook-treasure-chest (19.9k stars)
索引: vendors 落地缓存 docs/all-books.json — 每条 {title, author, link,
      category, language, formats}; 链接=城通网盘三格式打包 zip, 全库密码 8866.

用法:
  python search_books.py 关键词 [关键词2 ...] [-n 20] [-c 分类] [-a 作者] \
      [--json] [--index 路径]

匹配: 关键词 OR 命中 书名/分类/作者 (大小写不敏感);
排序: 书名前缀 > 书名包含 > 分类包含 > 作者包含。
版权: 上游声明仅供测试研究、24小时内删除、支持正版 — 按需取用, 不批量。
"""
import argparse
import io
import json
import sys
from pathlib import Path


def _utf8_stdout() -> None:
    """GBK 控制台防炸 (仅 CLI 直跑时包; 被 import 时不动别人的流)."""
    try:
        if sys.stdout.encoding and sys.stdout.encoding.lower() != "utf-8":
            sys.stdout = io.TextIOWrapper(sys.stdout.buffer,
                                          encoding="utf-8",
                                          errors="replace")
    except Exception:                                  # noqa: BLE001
        pass

DEFAULT_INDEX = (Path(r"E:\AI-Station\vendors\ebook-treasure-chest")
                 / "docs" / "all-books.json")


def load_index(path: Path) -> list:
    books = json.loads(path.read_text(encoding="utf-8"))
    if isinstance(books, dict):           # 容错: {books: [...]} 包装形态
        books = books.get("books") or books.get("data") or []
    return books


def match_score(b: dict, kws: list, cat: str, author: str) -> int:
    title = (b.get("title") or "").lower()
    bcat = (b.get("category") or "").lower()
    bauth = (b.get("author") or "").lower()
    if cat and cat.lower() not in bcat:
        return -1
    if author and author.lower() not in bauth:
        return -1
    best = 0
    for kw in kws:
        k = kw.lower()
        if not k:
            continue
        if title.startswith(k):
            best = max(best, 40)
        elif k in title:
            best = max(best, 30)
        elif k in bcat:
            best = max(best, 20)
        elif k in bauth:
            best = max(best, 10)
    return best


def search(books: list, kws: list, cat: str, author: str, limit: int) -> list:
    scored = []
    for i, b in enumerate(books):
        sc = match_score(b, kws, cat, author)
        if sc > 0:
            scored.append((sc, -i, b))     # -i: 同分靠前 (上游序)
    scored.sort(key=lambda x: (x[0], x[1]), reverse=True)
    out, seen_links = [], set()            # 同书多类目只留最高分位
    for _, _, b in scored:
        key = b.get("link") or (b.get("title"), b.get("author"))
        if key in seen_links:
            continue
        seen_links.add(key)
        out.append(b)
        if len(out) >= limit:
            break
    return out


def fmt_row(i: int, b: dict) -> str:
    fmts = "/".join(b.get("formats") or [])
    return (f"{i}. 《{b.get('title', '?')}》 {b.get('author', '')} "
            f"[{b.get('category', '')}] ({fmts})\n   {b.get('link', '')}")


def main() -> int:
    _utf8_stdout()
    ap = argparse.ArgumentParser(description="ebook-treasure 书单检索")
    ap.add_argument("keywords", nargs="+", help="关键词 (OR 匹配)")
    ap.add_argument("-n", "--limit", type=int, default=20)
    ap.add_argument("-c", "--category", default="")
    ap.add_argument("-a", "--author", default="")
    ap.add_argument("--json", action="store_true", help="JSON 输出")
    ap.add_argument("--index", default=str(DEFAULT_INDEX))
    args = ap.parse_args()

    index = Path(args.index)
    if not index.is_file():
        print(f"[ERR] 索引不存在: {index} (先落地 vendors 缓存, 见 SKILL.md)",
              file=sys.stderr)
        return 2
    books = load_index(index)
    hits = search(books, args.keywords, args.category, args.author,
                  args.limit)
    if args.json:
        print(json.dumps({"total": len(books), "hits": hits},
                         ensure_ascii=False, indent=1))
        return 0
    print(f"库藏 {len(books)} 本 | 命中 {len(hits)} 本 "
          f"(密码统一 8866, 链接=epub/mobi/azw3 打包 zip)")
    for i, b in enumerate(hits, 1):
        print(fmt_row(i, b))
    return 0 if hits else 1


if __name__ == "__main__":
    sys.exit(main())
