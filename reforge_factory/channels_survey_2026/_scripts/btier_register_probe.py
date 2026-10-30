# -*- coding: utf-8 -*-
"""btier_register_probe.py - B-tier free_register wave probe (1026).

Pure HTTP, zero browser (iron rule). Direct first, then proxies 7895/7890/7891/7893.
Output: _raw/btier_register_probe.jsonl (measured results only, no fabrication).
verdicts: LIT / FAIL_HTTP / BLOCKED_ANTIBOT / DEAD / USER_ACTION / SKIP
"""
from __future__ import annotations
import collections
import json
import re
import ssl
import sys
import urllib.error
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent.parent
PLAN = HERE / "btier_plan.json"
RAW = HERE / "_raw" / "btier_register_probe.jsonl"
SECRETS = Path("E:/AI-Station/data/secrets")

PROXIES = ["http://127.0.0.1:7895", "http://127.0.0.1:7890",
           "http://127.0.0.1:7891", "http://127.0.0.1:7893"]
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36")
TIMEOUT = 14
CTX = ssl.create_default_context()
CTX.check_hostname = False
CTX.verify_mode = ssl.CERT_NONE

def norm_url(e):
    for raw in (e.get("action_url") or "", e.get("repo_or_site") or ""):
        raw = raw.strip()
        if not raw:
            continue
        m = re.search(r"https?://[^\s()(),,;;|]+", raw)
        if m:
            return m.group(0).rstrip("/")
        first = raw.split()[0]
        m2 = re.match(r"^[a-z0-9.-]+\.[a-z]{2,}(/[^\s]*)?$", first, re.I)
        if m2:
            return "https://" + m2.group(0).rstrip("/")
    return None


def fetch(url, cookie=None):
    last = dict(status=0, final_url="", size=0, title="", snippet="", via="", err="")
    hdrs = {"User-Agent": UA,
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}
    if cookie:
        hdrs["Cookie"] = cookie
    for p in [None] + PROXIES:
        try:
            handler = urllib.request.ProxyHandler({} if not p else {"http": p, "https": p})
            op = urllib.request.build_opener(handler, urllib.request.HTTPSHandler(context=CTX))
            req = urllib.request.Request(url, headers=hdrs)
            with op.open(req, timeout=TIMEOUT) as r:
                raw = r.read(400000)
                txt = raw.decode("utf-8", "replace")
                t = re.search(r"<title[^>]*>(.*?)</title>", txt, re.S | re.I)
                return dict(status=r.status, final_url=r.geturl(), size=len(raw),
                            title=(t.group(1).strip()[:80] if t else ""),
                            snippet=txt, via=(p or "direct"), err="")
        except urllib.error.HTTPError as ex:
            try:
                body = ex.read(60000).decode("utf-8", "replace")
            except Exception:
                body = ""
            t = re.search(r"<title[^>]*>(.*?)</title>", body, re.S | re.I)
            last = dict(status=ex.code, final_url=url, size=len(body),
                        title=(t.group(1).strip()[:80] if t else ""),
                        snippet=body, via=(p or "direct"), err="HTTPError")
            if ex.code in (403, 429, 503):
                continue
            return last
        except Exception as ex:
            last = dict(status=0, final_url=url, size=0, title="", snippet="",
                        via=(p or "direct"), err=type(ex).__name__ + ": " + str(ex)[:90])
            continue
    return last

CAPTCHA_MK = ["recaptcha", "grecaptcha", "hcaptcha", "turnstile", "geetest",
              "tcaptcha", "captcha"]
OAUTH_MK = ["accounts.google.com", "oauth", "sign in with google"]
PHONE_MK = ["phone", "sms"]
EMAILVFY_MK = ["verify your email", "email verification"]
CN_CAPTCHA_MK = ["验证码", "滑动验证", "安全验证", "人机验证"]
CN_OAUTH_MK = ["扫码登录", "微信登录", "扫码"]
CN_PHONE_MK = ["手机号", "短信验证码"]
CN_EMAILVFY_MK = ["验证邮件", "确认邮件", "激活邮件"]
ANTIBOT_MK = ["just a moment", "attention required", "ddos protection",
              "cf-error", "px-captcha", "challenge-platform", "cf_chl",
              "访问验证"]


def markers(txt):
    low = txt.lower()
    found = {}
    found["captcha"] = [m for m in CAPTCHA_MK if m in low]
    found["captcha"] += [m for m in CN_CAPTCHA_MK if m in txt]
    found["oauth"] = [m for m in OAUTH_MK if m in low]
    found["oauth"] += [m for m in CN_OAUTH_MK if m in txt]
    found["phone"] = [m for m in PHONE_MK if m in low]
    found["phone"] += [m for m in CN_PHONE_MK if m in txt]
    found["emailvfy"] = [m for m in EMAILVFY_MK if m in low]
    found["emailvfy"] += [m for m in CN_EMAILVFY_MK if m in txt]
    found["antibot"] = [m for m in ANTIBOT_MK if m in low]
    return found


def access_kind(e):
    t = (e.get("access_raw") or "") + " " + (e.get("form") or "")
    NL = "免登录"          # nologin
    free_kw = (NL, "免费页面", "免费在线查询",
               "免费公开查询", "免费数据页")
    acct_kw = ("注册", "需登录", "账号", "申请",
               "文献传递")
    free = any(k in t for k in free_kw)
    acct = any(k in t for k in acct_kw)
    if not free and not acct:
        free = True   # no account keyword -> page smoke (unknown form)
    return free, acct


def baidu_cookie():
    d = {}
    for line in (SECRETS / "baidu_bduss.ini").read_text(
            encoding="utf-8", errors="replace").splitlines():
        s = line.strip()
        if "=" in s and not s.startswith(("#", "[")):
            k, v = s.split("=", 1)
            d[k.strip()] = v.strip()
    return "BDUSS=" + d.get("bduss", "") + "; STOKEN=" + d.get("stoken", "")


def run():
    plan = json.loads(PLAN.read_text(encoding="utf-8"))
    entries = [e for e in plan["entries"] if e.get("bucket") == "free_register"]
    print("free_register entries:", len(entries))

    def work(e):
        url = norm_url(e)
        free, acct = access_kind(e)
        rec = dict(idx=e["idx"], name=e["name"], url=url, free_face=free,
                   account=acct, status=0, via="", title="", size=0,
                   markers={}, verdict="", reason="", err="")
        if not url:
            rec.update(verdict="SKIP", reason="url-unparsable")
            return rec
        cookie = None
        host = urllib.parse.urlparse(url).netloc.lower()
        if host.endswith("index.baidu.com") or host.endswith("aiqicha.baidu.com"):
            cookie = baidu_cookie()
            rec["cred"] = "baidu_bduss(masked)"
        r = fetch(url, cookie=cookie)
        mk = markers(r["snippet"] or "")
        rec.update(status=r["status"], via=r["via"], title=r["title"],
                   size=r["size"], markers={k: v for k, v in mk.items() if v},
                   err=r["err"])
        body_ok = (r["status"] == 200 and r["size"] > 800 and not mk["antibot"])
        if free:
            if body_ok:
                rec.update(verdict="LIT",
                           reason="free-face smoke 200/" + str(r["size"]) + "B via " + r["via"])
            elif r["status"] == 0:
                rec.update(verdict="DEAD", reason="unreachable " + r["err"][:70])
            elif r["status"] in (403, 429, 503):
                rec.update(verdict="BLOCKED_ANTIBOT",
                           reason="antibot " + str(r["status"]) + " via " + r["via"])
            else:
                rec.update(verdict="FAIL_HTTP",
                           reason="status=" + str(r["status"]) + " size=" + str(r["size"]) +
                                  " via " + r["via"])
        else:
            why = "interactive_login"
            if mk["phone"]:
                why = "phone_sms_gate"
            elif mk["captcha"]:
                why = "captcha_gate:" + ",".join(mk["captcha"][:2])
            elif mk["oauth"]:
                why = "oauth_or_qr_gate"
            elif mk["emailvfy"]:
                why = "email_verify_gate"
            rec.update(verdict="USER_ACTION", reason=why)
        return rec

    with ThreadPoolExecutor(max_workers=10) as ex:
        out = list(ex.map(work, entries))
    RAW.parent.mkdir(parents=True, exist_ok=True)
    stamp = __import__("datetime").datetime.now().isoformat(timespec="seconds")
    with RAW.open("a", encoding="utf-8") as f:
        for rec in out:
            rec["ts"] = stamp
            f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    c = collections.Counter(r["verdict"] for r in out)
    print(json.dumps(dict(c), ensure_ascii=False))
    for r in out:
        print(str(r["idx"]).rjust(3), r["verdict"].ljust(15),
              str(r["status"]).rjust(3), r["name"][:36].ljust(38), r["reason"][:72])


if __name__ == "__main__":
    run()
