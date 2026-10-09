# -*- coding: utf-8 -*-
"""任务③ 宣传文资产腿：① 自产归因 trial 小程序码 ② 四图 uploadimg 换 mmbiz 域 URL。
总包之声 appid/secret 读 We-AIPO 账号表（EPC100 同源不复制）；小程序密钥读 data/secrets。
网络纪律：微信 API 不走代理（trust_env=False）；裸 requests 优先，SSL 断再落 curl_cffi。
"""
import json
import re
import sys
import time
from pathlib import Path

import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMO = Path(r"E:\AI-Station\WeAppForge\work\promo_article_1009")
QR_OUT = PROMO / "qr_art_trial_1280.png"
URL_MAP = PROMO / "url_map.json"

S = requests.Session()
S.trust_env = False  # 微信 API 绝不走代理


def read_kv(path: Path) -> dict:
    kv = {}
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        if "=" in line:
            k, v = line.split("=", 1)
            kv[k.strip()] = v.strip()
    return kv


def mp_cred() -> tuple[str, str]:
    kv = read_kv(Path(r"E:\AI-Station\data\secrets\zongbao_qianwen_mp.secret"))
    return kv["appid"], kv["appsecret"]


def gh_cred() -> tuple[str, str]:
    for a in json.load(open(r"E:\CPOPC\We-AIPO\data\wechat_accounts.json", encoding="utf-8")):
        if a.get("name") == "总包之声":
            return a["appid"], a["appsecret"]
    raise SystemExit("总包之声 not found in accounts json")


def fetch_token(appid: str, secret: str) -> str:
    r = S.get(
        "https://api.weixin.qq.com/cgi-bin/token",
        params={"grant_type": "client_credential", "appid": appid, "secret": secret},
        timeout=15,
    )
    d = r.json()
    if "access_token" not in d:
        raise SystemExit(f"token FAIL: {d}")
    return d["access_token"]


def gen_qr(token: str, env: str) -> None:
    r = S.post(
        "https://api.weixin.qq.com/wxa/getwxacodeunlimit",
        params={"access_token": token},
        json={
            "page": "pages/ask/ask",
            "scene": "s=art",
            "check_path": False,
            "env_version": env,
            "width": 1280,
        },
        timeout=30,
    )
    ct = r.headers.get("Content-Type", "")
    if "json" in ct:
        raise SystemExit(f"qr FAIL ({env}): {r.json()}")
    QR_OUT.write_bytes(r.content)
    print(f"QR[{env}] OK -> {QR_OUT.name} {len(r.content)}B")


def uploadimg(token: str, img: Path) -> str:
    for attempt in range(3):
        with open(img, "rb") as f:
            r = S.post(
                "https://api.weixin.qq.com/cgi-bin/media/uploadimg",
                params={"access_token": token},
                files={"media": (img.name, f, "image/png")},
                timeout=60,
            )
        d = r.json()
        if "url" in d:
            print(f"uploadimg OK {img.name} -> {d['url'][:60]}...")
            return d["url"]
        if d.get("errcode") in (40001, 42001):
            raise SystemExit(f"token expired mid-upload: {d}")
        print(f"uploadimg retry {attempt + 1}: {d}")
        time.sleep(3 + attempt * 3)
    raise SystemExit(f"uploadimg FAIL {img.name}")


def main() -> None:
    mpid, mpsecret = mp_cred()
    ghid, ghsecret = gh_cred()
    print(f"mp appid {mpid[:8]}... / gh appid {ghid[:8]}...")

    mp_token = fetch_token(mpid, mpsecret)
    gh_token = fetch_token(ghid, ghsecret)

    gen_qr(mp_token, "trial")

    urls = {}
    for key, path in {
        "QR": QR_OUT,
        "SHOT_ASK": Path(r"E:\AI-Station\WeAppForge\work\sim_v072_ask.png"),
        "SHOT_ANS": Path(r"E:\AI-Station\WeAppForge\work\sim_v072_answer.png"),
        "POSTER": Path(r"E:\AI-Station\WeAppForge\work\qc_poster_v5.png"),
    }.items():
        if not path.exists():
            raise SystemExit(f"missing asset: {path}")
        urls[key] = uploadimg(gh_token, path)

    URL_MAP.write_text(json.dumps(urls, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"\nurl_map written: {URL_MAP}")
    assert all(u.startswith("http://mmbiz.qpic.cn") for u in urls.values()), "non-mmbiz url!"
    print("ALL ASSETS DONE")


if __name__ == "__main__":
    main()
