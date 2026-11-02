# -*- coding: utf-8 -*-
"""wrapp_batch.py — 微信读书 app 域批量整书下载产线（1102 破签之战产物）

通道：i.weread.qq.com/book/chapterdownload（一书 1-2 请求，app 同款流量）
凭据：data/secrets/weread_app_token.json（模拟器真 app 提取；头=在线 dump 真值）
安全节奏（常令级，勿放宽）：
  - 书间 60~180s 人类抖动（模拟晚间囤书）
  - info→download 间 6~12s
  - 日预算默认 15 本（首跑观察期；稳定后可提 30）
  - 熔断：401=token 过期即停 / 连续2失败即停 / 未知错误码即停
用法：
  python wrapp_batch.py plan 3300229637,3300199792     # 登记队列
  python wrapp_batch.py run [--limit 15]               # 批量执行
  python wrapp_batch.py status
"""
import json
import os
import random
import re
import sys
import time

import requests

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from wrapp_client import BASE, headers, book_info, chapter_download  # noqa: E402
from wrapp_zip import convert  # noqa: E402

TOKEN = json.load(open(r"E:\AI-Station\data\secrets\weread_app_token.json", encoding="utf-8"))
STATE = os.path.join(HERE, "..", "evidence", "wrapp_batch_state.json")
OUTROOT = r"E:\AI-Station\data\weread"
EV = os.path.join(HERE, "..", "evidence")
DAILY = os.path.join(OUTROOT, "_recon", "app_daily_count.json")


def slug(s):
    return re.sub(r'[\\/:*?"<>|]', "_", s).strip()


def load(path, default):
    if os.path.exists(path):
        try:
            return json.load(open(path, encoding="utf-8"))
        except Exception:
            pass
    return default


def save(path, obj):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    json.dump(obj, open(path, "w", encoding="utf-8"), ensure_ascii=False, indent=1)


def daily_count():
    d = load(DAILY, {})
    today = time.strftime("%Y-%m-%d")
    return d.get(today, 0), today


def already_have(book_id):
    for d in os.listdir(OUTROOT):
        if d.startswith("_"):
            continue
        p = os.path.join(OUTROOT, d, "book.json")
        if os.path.exists(p):
            try:
                if json.load(open(p, encoding="utf-8")).get("bookId") == book_id:
                    return d
            except Exception:
                pass
    return None


def one_book(sess, bid, idx, total):
    print("[%d/%d] %s" % (idx, total, bid), flush=True)
    r = book_info(sess, bid)
    if r.status_code != 200:
        print("  info HTTP", r.status_code, r.text[:150], flush=True)
        return ("AUTH_DEAD" if r.status_code == 401 else "FAIL"), None
    j = r.json()
    if not j.get("title"):
        print("  info no title (bookId 无效?)", flush=True)
        return "SKIP", None
    if j.get("soldout") or (not j.get("version") and not j.get("chapterSize")):
        print("  已下架/无内容分发（soldout=%s），跳过" % j.get("soldout"), flush=True)
        return "SKIP_SOLDOUT", j.get("title")
    title = j["title"]
    print("  《%s》%s章 %s字" % (title, j.get("chapterSize", "?"),
                                format(j.get("totalWords", 0), ",")), flush=True)
    time.sleep(random.uniform(6, 12))
    chap_end = int(j.get("chapterSize", 1)) + int(j.get("lastChapterIdx", 0)) - 1
    r2 = chapter_download(sess, bid, j.get("version"), j.get("format", "epub"), chap_end)
    if r2.status_code == 402:
        print("  402 无整本权限（账号读不了的边界），跳过", flush=True)
        return "SKIP402", title
    if r2.status_code != 200:
        print("  download HTTP", r2.status_code, r2.text[:150], flush=True)
        return ("AUTH_DEAD" if r2.status_code == 401 else "FAIL"), title
    import io
    import zipfile
    from wrapp_zip import zip_password
    ek = r2.headers.get("encryptKey", "")
    out_dir = os.path.join(OUTROOT, slug(title)[:60])
    zf = zipfile.ZipFile(io.BytesIO(r2.content))
    enc = any(zi.flag_bits & 0x1 for zi in zf.infolist())
    pwd = zip_password(int(TOKEN["vid"]), ek).encode() if enc else None
    book = convert(zf, pwd, enc, out_dir, book_id=bid,
                   meta={"title": title, "author": j.get("author", ""),
                         "format": j.get("format"), "totalWords": j.get("totalWords"),
                         "intro": j.get("intro", ""), "cover": j.get("cover", "")})
    print("  ✓ %d章 → %s" % (len(book["chapters"]), out_dir), flush=True)
    open(os.path.join(EV, "wrapp_%s.zip" % bid), "wb").write(r2.content)
    return "OK", title


def run(limit):
    st = load(STATE, {"queue": [], "done": [], "failed": [], "log": []})
    n_today, today = daily_count()
    budget = max(0, limit - n_today)
    if budget == 0:
        print("今日预算已满（%d 本），明日再战" % n_today)
        return 0
    queue = [b for b in st["queue"]
             if b not in st["done"] and b not in st["failed"] and not already_have(b)]
    queue = queue[:budget]
    print("queue=%d 今日已下=%d 预算=%d" % (len(queue), n_today, budget), flush=True)
    sess = requests.Session()
    sess.headers.update(headers())
    fails = 0
    for i, bid in enumerate(queue, 1):
        status, title = one_book(sess, bid, i, len(queue))
        if status == "OK":
            st["done"].append(bid)
            n_today += 1
        elif status.startswith("SKIP"):
            st["failed"].append(bid)  # 无效/无权/下架：不重试、不计熔断
        elif status == "AUTH_DEAD":
            print("!! 401：token 过期（回模拟器重提取 weread_app_token.json）", flush=True)
            st["failed"].append(bid)
            save(st, STATE) if False else save(STATE, st)
            save(DAILY, {today: n_today})
            return 2
        else:
            st["failed"].append(bid)
            fails += 1
            if fails >= 2:
                print("!! 连续 2 失败，熔断停批", flush=True)
                save(STATE, st)
                save(DAILY, {today: n_today})
                return 3
        st["log"].append({"bid": bid, "status": status, "title": title,
                          "ts": time.strftime("%H:%M:%S")})
        save(STATE, st)
        save(DAILY, {today: n_today})
        if i < len(queue) and status == "OK":
            gap = random.uniform(60, 180)
            print("  书间歇 %.0fs …" % gap, flush=True)
            time.sleep(gap)
    print("批完成：done=%d failed=%d 今日累计=%d" % (len(st["done"]), len(st["failed"]), n_today), flush=True)
    return 0


if __name__ == "__main__":
    a = sys.argv[1:]
    if a and a[0] == "plan":
        st = load(STATE, {"queue": [], "done": [], "failed": [], "log": []})
        for bid in a[1].split(","):
            bid = bid.strip()
            if bid and bid not in st["queue"]:
                st["queue"].append(bid)
        save(STATE, st)
        print("queue:", st["queue"])
    elif a and a[0] == "status":
        st = load(STATE, {"queue": [], "done": [], "failed": [], "log": []})
        n, today = daily_count()
        print(json.dumps({"queue": st["queue"], "done": len(st["done"]),
                          "failed": st["failed"], "today": "%s: %d本" % (today, n)},
                         ensure_ascii=False, indent=1))
    elif a and a[0] == "run":
        lim = int(a[a.index("--limit") + 1]) if "--limit" in a else 15
        sys.exit(run(lim))
    else:
        print(__doc__)
