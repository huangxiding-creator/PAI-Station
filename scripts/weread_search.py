"""微信读书关键词搜索：书单落盘 _recon 并打印表格。

用法: python scripts/weread_search.py <关键词> [数量，默认20]

安全节流（2026-09-16 风控提醒后新增）：两次搜索间隔 ≥25s（自动等待），
每日搜索上限 8 次（超出拒跑——搜索连发是 09-15 风控的头号嫌疑）。
"""
import json
import os
import random
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.weread import WeReadClient  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
AUTH = os.path.join(ROOT, "data", "weread", "_auth", "weread_auth.json")
RECON = os.path.join(ROOT, "data", "weread", "_recon")

MIN_INTERVAL = 25   # 两次搜索最小间隔（秒）
DAILY_CAP = 8       # 每日搜索次数上限
PACE = os.path.join(RECON, "search_pace.json")


def pace_guard() -> bool:
    """搜索配速：间隔不足自动等待；当日超上限返回 False（拒跑）。"""
    today = time.strftime("%Y-%m-%d")
    state = {"date": today, "count": 0, "last": 0.0}
    if os.path.exists(PACE):
        try:
            loaded = json.load(open(PACE, encoding="utf-8"))
            if loaded.get("date") == today:
                state = loaded
        except Exception:
            pass
    if int(state["count"]) >= DAILY_CAP:
        print(f"[search] 已达每日搜索上限 {DAILY_CAP} 次（风控收紧），明日再搜")
        return False
    wait = float(state["last"]) + MIN_INTERVAL + random.uniform(0, 10) - time.time()
    if wait > 0:
        print(f"[search] 距上次搜索不足 {MIN_INTERVAL}s，等待 {int(wait)}s…")
        time.sleep(wait)
    return True


def bump_pace() -> None:
    today = time.strftime("%Y-%m-%d")
    state = {"date": today, "count": 0, "last": 0.0}
    if os.path.exists(PACE):
        try:
            loaded = json.load(open(PACE, encoding="utf-8"))
            if loaded.get("date") == today:
                state = loaded
        except Exception:
            pass
    state["count"] = int(state.get("count", 0)) + 1
    state["last"] = time.time()
    os.makedirs(RECON, exist_ok=True)
    tmp = PACE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as fh:
        json.dump(state, fh, ensure_ascii=False, indent=1)
    os.replace(tmp, PACE)


def main() -> int:
    if len(sys.argv) < 2:
        print("用法: python scripts/weread_search.py <关键词> [数量]")
        return 2
    keyword = sys.argv[1]
    count = int(sys.argv[2]) if len(sys.argv) > 2 else 20
    if not pace_guard():
        return 3
    cli = WeReadClient(auth_path=AUTH)
    if not cli.is_logged_in():
        print("[search] 登录态失效，请先: python scripts/weread_login.py")
        return 1
    books = cli.search(keyword, count=count)
    bump_pace()
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
