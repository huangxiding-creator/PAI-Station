# -*- coding: utf-8 -*-
"""W3 · judge#2 迅雷补录（2026-10-30 夜）

任务：新猎 3+3 条迅雷链（活源/TG 搜「迅雷 网盘 分享」类词）逐链落档——
修复后盐值（pansou L1305 真盐）的在档证据。judge 病灶：W2 真盐修复后仅一发探针在档，需 6 发档。
铁律：本腿总预算 ≤30 发（TG 2 + 活源 6 搜 + 6 链×≤3 验）；单源间隔≥2s；零凭据零下载。
产出：analysis/w3_xunlei_links.json（新猎链清单）+ analysis/w3_xunlei_results.jsonl（逐链落档）
      + analysis/w3_xunlei_ledger.jsonl（逐发台账）
"""
from __future__ import annotations

import json
import random
import re
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from searchagg import SearchSession, SearchLedger          # noqa: E402
from discovery import DiscoveryLedger, discover_url, strip_pwd, link_gap   # noqa: E402
from curl_cffi import requests as creq                     # noqa: E402

LEDGER_PATH = ROOT / "analysis" / "w3_xunlei_ledger.jsonl"
RESULTS_PATH = ROOT / "analysis" / "w3_xunlei_results.jsonl"
LINKS_PATH = ROOT / "analysis" / "w3_xunlei_links.json"
RUN_ID = time.strftime("%Y%m%d_%H%M%S")
TOTAL_BUDGET = 30                                          # 本腿铁顶

#: W2 已测三链（去重用：share_id 级排除）
OLD_IDS = {"VP1hRejZmkpJcRrBpjHraHZ5A1", "VP2WcZD_P5LYvfTXWNeWF7MOA1",
           "VP2Ae5hVGJLvfTXWNeWF7MOA1"}

TG_KWS = ["迅雷", "网盘 迅雷 分享"]
AGG_JOBS = [("迅雷", "melost"), ("迅雷", "panhunt"), ("迅雷", "mikuclub"),
            ("迅雷", "naspt")]

_XL_RE = re.compile(r'https?://pan\.xunlei\.com/s/[A-Za-z0-9_-]+[^\s"\'<>）】\]]*')
_PWD_RE = re.compile(r'(?:提取码|密码|口令)[：:\s]*([A-Za-z0-9]{3,8})')
_BLK_RE = re.compile(r'tgme_widget_message_text[^>]*>(.*?)</div>', re.S)
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
PROXIES = {"http": "http://127.0.0.1:7892", "https": "http://127.0.0.1:7892"}

shots = 0                                                  # 本腿总发数（数字零造假）


def _shot(tag: str, url: str):
    global shots
    shots += 1
    with open(LEDGER_PATH, "a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%H:%M:%S"), "leg": "xunlei_hunt",
                            "tag": tag, "url": url[:110]}, ensure_ascii=False) + "\n")


def tg_hunt(kw: str, found: dict[str, dict]):
    """TG 腿：t.me/s/ 频道页 → 消息块内 迅雷链×提取码 同块配对（代理重试 1 发）。"""
    url = f"https://t.me/s/tgsearchers7?q={kw}"
    for path in ("direct", "proxy"):
        _shot(f"tg:{path}", url)
        try:
            r = creq.get(url, headers={"User-Agent": UA}, timeout=15,
                         impersonate="chrome124",
                         proxies=PROXIES if path == "proxy" else None)
            body = r.text or ""
            n_blk = 0
            for blk in _BLK_RE.findall(body):
                n_blk += 1
                m = _PWD_RE.search(blk)
                pwd = m.group(1) if m else ""
                for u in _XL_RE.findall(blk):
                    sid = re.search(r"/s/([A-Za-z0-9_-]+)", u).group(1)
                    if sid in OLD_IDS:
                        continue
                    if sid not in found or (pwd and not found[sid].get("pwd")):
                        found[sid] = {"url": u, "pwd": pwd, "kw": kw,
                                      "source": "tg_tgsearchers7"}
            print(f"  TG[{path}] {kw}: blocks={n_blk} 累计新链={len(found)}", flush=True)
            return
        except Exception as e:
            if path == "proxy":
                print(f"  TG[{kw}] 直连+代理均失败：{type(e).__name__}")
            time.sleep(2)
    return


def agg_hunt(kw: str, src: str, found: dict[str, dict]):
    """活源腿：SearchSession 聚合收割（URL 级；?pwd= 由 strip_pwd 解）。"""
    led = SearchLedger(str(LEDGER_PATH))
    s = SearchSession(src, led)
    hits = s.search(kw)
    global shots
    shots += 1
    for h in hits:
        if "xunlei.com/s/" not in h.url:
            continue
        sid = re.search(r"/s/([A-Za-z0-9_-]+)", h.url).group(1)
        if sid in OLD_IDS:
            continue
        _, pwd = strip_pwd(h.url)
        if sid not in found or (pwd and not found[sid].get("pwd")):
            found[sid] = {"url": h.url, "pwd": pwd, "kw": kw, "source": src}
    print(f"  {src}[{kw}]: hits={len(hits)} 累计新链={len(found)}", flush=True)


def main():
    found: dict[str, dict] = {}
    print("== 猎链阶段（≤8 发）==")
    for kw in TG_KWS:
        tg_hunt(kw, found)
        time.sleep(random.uniform(2.0, 3.0))
    for kw, src in AGG_JOBS:
        agg_hunt(kw, src, found)
        time.sleep(random.uniform(2.0, 3.0))

    # 选样：3 无码 + 3 带码（不足如实补位并声明）
    free = [v for v in found.values() if not v["pwd"]]
    withpwd = [v for v in found.values() if v["pwd"]]
    picked = free[:3] + withpwd[:3]
    LINKS_PATH.write_text(json.dumps(
        {"run": RUN_ID, "hunted_total": len(found), "free": len(free),
         "withpwd": len(withpwd), "picked": picked,
         "note": f"新猎去重后 {len(found)} 链（排除 W2 三旧链）；选样 3 无码+3 带码"
                 f"（不足则如实补位）"}, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\n新猎 {len(found)} 链（无码 {len(free)} / 带码 {len(withpwd)}），"
          f"选样 {len(picked)} 链 → 逐链落档\n")

    dled = DiscoveryLedger(TOTAL_BUDGET - shots, str(LEDGER_PATH))
    with open(RESULTS_PATH, "a", encoding="utf-8") as sink:
        sink.write(json.dumps({"type": "run_start", "run": RUN_ID,
                               "leg": "xunlei_hunt", "picked": len(picked),
                               "search_shots": shots}, ensure_ascii=False) + "\n")
        ok = 0
        for i, item in enumerate(picked):
            u = item["url"]
            try:
                r = discover_url(u, pwd=item["pwd"], ledger=dled)
            except Exception as e:
                from discovery.base import DResult
                r = DResult(url=u, disk="xunlei", state=f"err:{type(e).__name__}",
                            message=str(e)[:100])
            row = {"run": RUN_ID, "url": u[:90], "pwd": item["pwd"],
                   "source": item["source"], "ok": r.ok, "alive": r.alive,
                   "state": r.state, "message": r.message[:130],
                   "title": r.title[:60], "n": len(r.entries),
                   "file_count": r.file_count, "shots": r.shots,
                   "sample": [f"{'D' if e.is_dir else 'F'}:{e.name[:36]}:{e.size}"
                              for e in r.entries[:4]]}
            sink.write(json.dumps(row, ensure_ascii=False) + "\n")
            sink.flush()
            ok += bool(r.ok)
            print(f"  [{i+1}/{len(picked)}] {'OK ' if r.ok else '   '}{r.state:10s} "
                  f"n={len(r.entries):3d} shots={r.shots} pwd={item['pwd'] or '-':5s} {u[:56]}")
            if i < len(picked) - 1:
                link_gap()
    print(f"\n== 迅雷补录收官：列表成 {ok}/{len(picked)}；"
          f"本腿总发 = 搜 {shots} + 验 {dled.shots} = {shots + dled.shots}（≤{TOTAL_BUDGET}）")


if __name__ == "__main__":
    main()
