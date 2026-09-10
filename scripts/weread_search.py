"""微信读书关键词搜索：书单落盘 _recon 并打印表格。

用法: python scripts/weread_search.py <关键词> [数量，默认20]
"""
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.weread import WeReadClient  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
AUTH = os.path.join(ROOT, "data", "weread", "_auth", "weread_auth.json")
RECON = os.path.join(ROOT, "data", "weread", "_recon")


def main() -> int:
    if len(sys.argv) < 2:
        print("用法: python scripts/weread_search.py <关键词> [数量]")
        return 2
    keyword = sys.argv[1]
    count = int(sys.argv[2]) if len(sys.argv) > 2 else 20
    cli = WeReadClient(auth_path=AUTH)
    if not cli.is_logged_in():
        print("[search] 登录态失效，请先: python scripts/weread_login.py")
        return 1
    books = cli.search(keyword, count=count)
    os.makedirs(RECON, exist_ok=True)
    safe = "".join(c for c in keyword if c.isalnum() or "一" <= c <= "鿿")
    out = os.path.join(RECON, f"search_{safe or 'kw'}.json")
    with open(out, "w", encoding="utf-8") as fh:
        json.dump({"keyword": keyword, "books": books}, fh,
                  ensure_ascii=False, indent=1)
    print(f"[search] 关键词「{keyword}」命中 {len(books)} 本 → "
          f"{os.path.relpath(out, ROOT)}\n")
    print(f"{'#':<3}{'书名':<28}{'作者':<14}bookId")
    for i, b in enumerate(books, 1):
        title = (b.get("title") or "")[:24]
        author = (b.get("author") or "")[:12]
        print(f"{i:<3}{title:<28}{author:<14}{b.get('bookId', '')}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
