"""微信读书整书批量提取（断点续采 + 账号安全护栏）。

用法:
  python scripts/weread_batch.py --keyword "曾鸣" [--limit 3]
  python scripts/weread_batch.py --book-id 3300029037
护栏（标准节奏，用户 2026-09-10 批准）：
- 章节请求随机间隔 1.5~3.5s（客户端内置节流）
- 单书完成后冷却 ≥120s；日提取上限默认 3 本（config/weread.secret.ini
  [safety] daily_book_limit / cooldown_seconds 可调）
- 熔断：连续异常/登录失效立即终止并落盘 _recon/circuit_break.json
产物（对齐提案 19.11 原料湖约定）：
  data/weread/{书名}/book.json + {书名}.md + {书名}.docx + images/
幂等：book.json 已存在即跳过；单书失败记 _recon/failed.json 不挡批。
"""
import argparse
import configparser
import hashlib
import json
import os
import re
import sys
import time
import urllib.request

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.weread import (  # noqa: E402
    CircuitBreakerError,
    WeReadAuthError,
    WeReadClient,
    extract_book,
)
from paistation.forge.weread_export import to_docx, to_markdown  # noqa: E402
from paistation.forge.weread_html import (  # noqa: E402
    html_to_blocks,
    html_to_text,
)
from paistation.forge.weread_sign import USER_AGENT  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "data", "weread")
AUTH = os.path.join(BASE, "_auth", "weread_auth.json")
RECON = os.path.join(BASE, "_recon")
SECRET = os.path.join(ROOT, "config", "weread.secret.ini")


def slugify(title: str) -> str:
    keep = re.sub(r"[^\w一-鿿-]+", "_", title).strip("_")
    return keep[:60] or "book"


def load_safety() -> dict:
    conf = configparser.ConfigParser()
    conf.read(SECRET, encoding="utf-8")
    return {
        "daily_book_limit": conf.getint(
            "safety", "daily_book_limit", fallback=3),
        "cooldown_seconds": conf.getint(
            "safety", "cooldown_seconds", fallback=120),
    }


def daily_count() -> int:
    path = os.path.join(RECON, "daily_count.json")
    today = time.strftime("%Y-%m-%d")
    if os.path.exists(path):
        with open(path, encoding="utf-8") as fh:
            state = json.load(fh)
        if state.get("date") == today:
            return int(state.get("count", 0))
    return 0


def bump_daily() -> None:
    os.makedirs(RECON, exist_ok=True)
    path = os.path.join(RECON, "daily_count.json")
    today = time.strftime("%Y-%m-%d")
    state = {"date": today, "count": daily_count() + 1}
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="utf-8") as fh:
        json.dump(state, fh, ensure_ascii=False, indent=1)
    os.replace(tmp, path)


def download_images(book: dict, bookdir: str, cli: WeReadClient) -> dict:
    """下载章节图片到 images/，返回 src→本地相对路径映射（失败项缺席）。"""
    mapping = {}
    srcs = []
    for ch in book["chapters"]:
        for img in html_to_blocks(ch.get("html", ""))[1]:
            if img["src"] not in srcs:
                srcs.append(img["src"])
    if not srcs:
        return mapping
    imgdir = os.path.join(bookdir, "images")
    os.makedirs(imgdir, exist_ok=True)
    opener = cli._opener                            # noqa: SLF001 - 复用直连
    for src in srcs:
        ext = ".jpg"
        m = re.search(r"\.(jpe?g|png|gif|webp)(?:[?#]|$)", src, re.I)
        if m:
            ext = "." + m.group(1).lower()
        name = hashlib.md5(src.encode()).hexdigest()[:12] + ext
        local = os.path.join(imgdir, name)
        if not os.path.exists(local):
            try:
                req = urllib.request.Request(
                    src, headers={"User-Agent": USER_AGENT,
                                  "Referer": "https://weread.qq.com/"})
                with opener.open(req, timeout=20) as resp:
                    data = resp.read()
                tmp = local + ".tmp"
                with open(tmp, "wb") as fh:
                    fh.write(data)
                os.replace(tmp, local)
                time.sleep(0.5)                     # 图片下载礼貌间隔
            except Exception as exc:                # noqa: BLE001 - 单图失败跳过
                print(f"  [img] 跳过 {src[:60]}: {str(exc)[:60]}")
                continue
        mapping[src] = f"images/{name}"
    return mapping


def persist_book(book: dict, cli: WeReadClient, with_docx: bool = True) -> str:
    """book.json + md (+ docx) 落盘，返回书目录。"""
    name = slugify(book["title"])
    bookdir = os.path.join(BASE, name)
    os.makedirs(bookdir, exist_ok=True)
    mapping = download_images(book, bookdir, cli)
    mapper = mapping.get
    for ch in book["chapters"]:                      # 原料湖：补纯文本字段
        if not ch.get("skipped"):
            ch["text"] = html_to_text(ch.get("html", ""))
            ch["images"] = [mapping.get(i["src"], i["src"])
                            for i in html_to_blocks(ch.get("html", ""))[1]]
    raw = os.path.join(bookdir, "book.json")
    tmp = raw + ".tmp"
    with open(tmp, "w", encoding="utf-8") as fh:
        json.dump(book, fh, ensure_ascii=False, indent=1)
    os.replace(tmp, raw)
    md_path = os.path.join(bookdir, f"{name}.md")
    with open(md_path, "w", encoding="utf-8") as fh:
        fh.write(to_markdown(book, image_mapper=mapper))
    cover_local = ""
    if book.get("cover"):
        try:
            req = urllib.request.Request(
                book["cover"], headers={"User-Agent": USER_AGENT})
            with cli._opener.open(req, timeout=20) as resp:  # noqa: SLF001
                data = resp.read()
            cover_local = os.path.join(bookdir, "cover.img")
            with open(cover_local, "wb") as fh:
                fh.write(data)
        except Exception:                            # noqa: BLE001 - 封面可选
            cover_local = ""
    if with_docx:
        to_docx(book, os.path.join(bookdir, f"{name}.docx"),
                image_mapper=mapper, cover_image=cover_local)
    return bookdir


def record_circuit_break(exc: Exception, keyword: str) -> None:
    os.makedirs(RECON, exist_ok=True)
    path = os.path.join(RECON, "circuit_break.json")
    with open(path, "w", encoding="utf-8") as fh:
        json.dump({"at": time.strftime("%Y-%m-%dT%H:%M:%S"),
                   "keyword": keyword, "err": str(exc)[:300]},
                  fh, ensure_ascii=False, indent=1)


def main() -> int:
    ap = argparse.ArgumentParser(description="微信读书整书批量提取")
    ap.add_argument("--keyword", help="搜索关键词")
    ap.add_argument("--limit", type=int, default=3, help="每关键词提取本数")
    ap.add_argument("--book-id", help="直接按 bookId 提取（跳过搜索）")
    ap.add_argument("--no-docx", action="store_true", help="只出 md+json")
    args = ap.parse_args()
    if not args.keyword and not args.book_id:
        ap.error("需要 --keyword 或 --book-id")

    safety = load_safety()
    done_today = daily_count()
    if done_today >= safety["daily_book_limit"]:
        print(f"[batch] 今日已提取 {done_today} 本，达日限额 "
              f"{safety['daily_book_limit']}（账号安全红线，明日再跑）")
        return 0

    cli = WeReadClient(auth_path=AUTH)
    if not cli.is_logged_in():
        try:
            cli.renew()
        except Exception:                            # noqa: BLE001
            pass
        if not cli.is_logged_in():
            print("[batch] 登录态失效，请先: python scripts/weread_login.py")
            return 1

    if args.book_id:
        targets = [{"bookId": args.book_id,
                    "title": cli.book_info(args.book_id).get("title", "")}]
    else:
        remaining = safety["daily_book_limit"] - done_today
        hits = cli.search(args.keyword, count=max(args.limit * 2, 10))
        targets = hits[:min(args.limit, remaining)]     # 日限额硬顶（R10）
        if not targets:
            print(f"[batch] 关键词「{args.keyword}」无搜索结果")
            return 0
        print(f"[batch] 「{args.keyword}」命中 {len(hits)} 本，"
              f"取前 {len(targets)} 本（日限额剩 {remaining}）")

    os.makedirs(RECON, exist_ok=True)
    failed_path = os.path.join(RECON, "failed.json")
    failed = json.load(open(failed_path, encoding="utf-8")) \
        if os.path.exists(failed_path) else []
    ok = skipped = 0
    for i, target in enumerate(targets, 1):
        book_id = target["bookId"]
        guess = slugify(target.get("title", "") or book_id)
        if os.path.exists(os.path.join(BASE, guess, "book.json")):
            skipped += 1
            print(f"[{i}/{len(targets)}] SKIP 已存在 {guess}")
            continue
        t0 = time.time()
        try:
            def prog(idx, total, title):
                print(f"  章节 {idx}/{total} {title[:36]}", flush=True)
            book = extract_book(cli, book_id, on_progress=prog)
            persist_book(book, cli, with_docx=not args.no_docx)
            bump_daily()
            ok += 1
            chars = sum(len(c.get("text", "")) for c in book["chapters"])
            flag = " [部分:免费范围]" if book["partial"] else ""
            print(f"[{i}/{len(targets)}] OK {book['title'][:32]} | "
                  f"{book['chapterCount']}章 {chars}字 "
                  f"{(time.time() - t0) / 60:.1f}min{flag}")
        except WeReadAuthError as exc:
            record_circuit_break(exc, args.keyword or args.book_id)
            print(f"[batch] 登录失效，已停止（已完成 ok={ok}）：{exc}")
            print("请重新扫码: python scripts/weread_login.py")
            return 1
        except CircuitBreakerError as exc:
            record_circuit_break(exc, args.keyword or args.book_id)
            print(f"[batch] 熔断停止（ok={ok} skip={skipped}）：{exc}")
            print("请人工检查 _recon/circuit_break.json 后再继续")
            return 1
        except Exception as exc:                     # noqa: BLE001 - 单书不挡批
            failed.append({"bookId": book_id,
                           "title": target.get("title", ""),
                           "err": str(exc)[:200]})
            with open(failed_path, "w", encoding="utf-8") as fh:
                json.dump(failed, fh, ensure_ascii=False, indent=1)
            print(f"[{i}/{len(targets)}] FAIL {target.get('title', '')[:30]}:"
                  f" {str(exc)[:90]}")
        if i < len(targets):
            wait = safety["cooldown_seconds"]
            print(f"[cooldown] 单书冷却 {wait}s …", flush=True)
            time.sleep(wait)
    print(f"[batch] 完成：ok={ok} skip={skipped} fail={len(failed)} "
          f"今日累计 {daily_count()}/{safety['daily_book_limit']} 本")
    return 0


if __name__ == "__main__":
    sys.exit(main())
