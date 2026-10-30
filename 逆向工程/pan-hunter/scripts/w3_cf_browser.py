# -*- coding: utf-8 -*-
"""W3 · CF 浏览器栈腿：5 质询源过墙 + 搜索 API 形态采集（2026-10-30 夜）

任务：DrissionPage（.venv 4.1.1.4）离屏/最小化开 CF 质询源（yiso/aipanso/kkmao/ting77/pan666），
过质询后抓搜索 API 形态；明文 API→curl_cffi 配方化验证；纯页面→记录 SPA 采集要点。
浏览器纪律：headless 优先（CF 拒则离屏窗口兜底）、auto_port 临时 profile（绝不碰 9222）、
用完即 quit、只这 5 站；Chrome 进程守门=脚本自记前后进程数。
铁律：本腿浏览器导航+复放合计 ≤40 发（入 w3_cf_ledger.jsonl）；零凭据。
产出：analysis/w3_cf_browser.json（逐站证据）+ analysis/w3_cf_ledger.jsonl
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.stdout.reconfigure(encoding="utf-8")

OUT = ROOT / "analysis" / "w3_cf_browser.json"
LEDGER = ROOT / "analysis" / "w3_cf_ledger.jsonl"
RUN = time.strftime("%Y%m%d_%H%M%S")
KW = "民法典"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

CF_TITLES = ("just a moment", "attention required", "请稍候", "security check",
             "verifying", "cf-chl")

SITES = [
    {"name": "yiso", "home": "https://yiso.fun/",
     "probe": ["https://yiso.fun/api/search?name=%s&from=ali" % KW]},
    {"name": "aipanso", "home": "https://aipanso.com/",
     "probe": ["https://aipanso.com/search?page=1&k=%s&p=baidu" % KW],
     "spa": True},
    {"name": "kkmao", "home": "https://www.kuakemao.com/",
     "probe": ["https://www.kuakemao.com/?s=%s" % KW]},
    {"name": "ting77", "home": "https://sou.77ting.top/",
     "probe": ["https://sou.77ting.top/search?q=%s" % KW]},
    {"name": "pan666", "home": "https://pan666.net/",
     "probe": ["https://pan666.net/api/discussions?filter[q]=%s&include=mostRelevantPost"
               "&page[offset]=0&page[limit]=20" % KW]},
]

shots = 0


def _shot(tag, url, note=""):
    global shots
    shots += 1
    with open(LEDGER, "a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%H:%M:%S"), "run": RUN,
                            "tag": tag, "url": url[:140], "note": note[:80]},
                           ensure_ascii=False) + "\n")


def chrome_count() -> int:
    try:
        out = subprocess.run(["tasklist", "/FI", "IMAGENAME eq chrome.exe"],
                             capture_output=True, text=True).stdout
        return out.count("chrome.exe")
    except Exception:
        return -1


def _new_page(headless: bool = True):
    from DrissionPage import ChromiumPage, ChromiumOptions
    co = ChromiumOptions()
    co.auto_port()                       # 独立端口+临时 profile：绝不触碰 9222 在役浏览器
    co.set_user_agent(UA)                # 防 HeadlessChrome UA 指纹
    co.set_argument("--disable-gpu")
    co.set_argument("--no-first-run")
    co.set_argument("--no-default-browser-check")
    if headless:
        co.headless()
    else:                                # 离屏兜底：窗口移出可视区（=最小化形态）
        co.set_argument("--window-position=-32000,-32000")
        co.set_argument("--window-size=1280,900")
    return ChromiumPage(co)


def _challenged(page) -> bool:
    t = (page.title or "").lower()
    h = (page.html or "")[:6000].lower()
    return any(m in t for m in CF_TITLES) or any(m in h for m in
                                                 ("challenge-platform", "cf_chl", "just a moment"))


def _wait_clear(page, timeout=25) -> bool:
    t0 = time.time()
    while time.time() - t0 < timeout:
        if not _challenged(page):
            return True
        time.sleep(2)
        try:
            page.wait.doc_loaded(timeout=5)
        except Exception:
            pass
    return not _challenged(page)


def _body_sniff(page) -> str:
    try:
        txt = (page.html or "").strip()
    except Exception:
        return ""
    return txt[:400].replace("\n", " ")


def _replay(url: str, cookies: list[dict], referer: str) -> dict:
    """curl_cffi impersonate + 浏览器 cookie 复放（配方化验证）。"""
    from curl_cffi import requests as creq
    jar = {c["name"]: c["value"] for c in cookies if isinstance(c, dict) and c.get("name")}
    h = {"User-Agent": UA, "Referer": referer, "Accept-Language": "zh-CN,zh;q=0.9"}
    _shot("replay", url)
    try:
        r = creq.get(url, headers=h, cookies=jar, timeout=15, impersonate="chrome124")
        body = r.text or ""
        return {"status": r.status_code, "len": len(body),
                "ct": r.headers.get("content-type", "")[:40],
                "is_json": body.lstrip()[:1] in "[{",
                "head": body[:200].replace("\n", " ")}
    except Exception as e:
        return {"error": f"{type(e).__name__}:{str(e)[:80]}"}


def run_site(site: dict, results: dict):
    print(f"\n== {site['name']} ==", flush=True)
    rec = {"site": site["name"], "home": site["home"]}
    for mode in ("headless", "offscreen"):
        page = None
        try:
            page = _new_page(headless=(mode == "headless"))
            _shot(f"{site['name']}:{mode}:home", site["home"])
            page.get(site["home"], timeout=40)
            cleared = _wait_clear(page)
            rec[f"{mode}_title"] = (page.title or "")[:60]
            rec[f"{mode}_cleared"] = cleared
            print(f"  [{mode}] title={rec[f'{mode}_title']!r} cleared={cleared}", flush=True)
            if not cleared:
                try:
                    page.quit()
                except Exception:
                    pass
                continue

            # ---- 过墙成功：cookie/UA 采集 ----
            try:
                cookies = page.cookies(all_domains=True)
            except TypeError:
                cookies = page.cookies()
            rec["cookies"] = sorted({c.get("name") for c in cookies if isinstance(c, dict)})
            rec["n_cookies"] = len(cookies)
            print(f"  cookies({len(cookies)}): {rec['cookies'][:8]}", flush=True)

            # ---- 搜索 API 形态采集 ----
            probes = []
            for pu in site["probe"]:
                _shot(f"{site['name']}:{mode}:probe", pu)
                packets = []
                try:
                    page.listen.start("")               # 全捕，稍后按 url 过滤
                except Exception:
                    pass
                page.get(pu, timeout=40)
                time.sleep(4)                            # SPA 异步取数窗口
                try:
                    for pkt in page.listen.steps(timeout=6, gap=1):
                        if pkt.url and not any(x in pkt.url for x in
                                               (".css", ".js?", ".png", ".jpg", ".woff",
                                                ".svg", ".ico", "googletag", "baidu.com/hm",
                                                "cloudflareinsights", "/cdn-cgi/")):
                            packets.append(pkt.url[:160])
                        if len(packets) >= 12:
                            break
                except Exception:
                    pass
                try:
                    page.listen.stop()
                except Exception:
                    pass
                body = _body_sniff(page)
                probes.append({"url": pu[:150], "title": (page.title or "")[:60],
                               "xhr": packets, "body_head": body})
                print(f"  probe: {pu[:80]}", flush=True)
                print(f"    title={probes[-1]['title']!r} xhr={len(packets)} "
                      f"body[:120]={body[:120]!r}", flush=True)
            rec["probes"] = probes

            # ---- curl_cffi 复放（配方化判定）----
            if probes:
                rec["replay"] = _replay(site["probe"][0], cookies, site["home"])
                print(f"  replay: {json.dumps(rec['replay'], ensure_ascii=False)[:200]}",
                      flush=True)
            rec["mode_used"] = mode
            break
        except Exception as e:
            rec[f"{mode}_error"] = f"{type(e).__name__}:{str(e)[:120]}"
            print(f"  [{mode}] EXC {rec[f'{mode}_error']}", flush=True)
        finally:
            if page is not None:
                try:
                    page.quit()
                except Exception:
                    pass
    results[site["name"]] = rec


def main():
    base = chrome_count()
    print(f"Chrome 进程基线：{base}")
    results: dict = {}
    try:
        for site in SITES:
            run_site(site, results)
    finally:
        time.sleep(3)
        after = chrome_count()
        results["_hygiene"] = {"chrome_before": base, "chrome_after": after,
                               "delta": after - base}
        print(f"\nChrome 进程收口：{base} → {after}（delta={after-base}，应=0）")
    OUT.write_text(json.dumps({"run": RUN, "kw": KW, "shots": shots,
                               "results": results}, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"\n== CF 腿收官：{shots} 发（预算 40）；证据 → {OUT.name}")


if __name__ == "__main__":
    main()
