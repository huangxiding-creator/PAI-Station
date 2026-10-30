# -*- coding: utf-8 -*-
"""_freekey_dp_common_1026 — 免费钥申领浏览器腿公共件 (DrissionPage 附加模式)."""
from __future__ import annotations
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

PROFILE = r"E:/AI-Station/_bigassets_local/dp_freekey_profile"
PORT = 9341
PROXY = "http://127.0.0.1:7890"
SHOTS = Path(r"E:/AI-Station/reforge_factory/channels_survey_2026/shots_freekey_1026")
SECRETS = Path(r"E:/AI-Station/data/secrets")
MAIL = "51817@qq.com"

def launch():
    co = ChromiumOptions()
    co.set_user_data_path(PROFILE)
    co.set_local_port(PORT)
    co.set_proxy(PROXY)
    co.set_argument("--start-minimized")
    co.set_argument("--window-size=1400,900")
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_argument("--lang=en-US")
    page = ChromiumPage(co)
    return page

def attach() -> ChromiumPage:
    try:
        return ChromiumPage(addr_or_opts=f"127.0.0.1:{PORT}")
    except Exception:
        return launch()

def mask(s: str) -> str:
    return (s[:6] + "..." + s[-3:] + f"(len={len(s)})") if s else ""

def save_key(ch: str, key: str, extra_lines: list[str] | None = None) -> str:
    p = SECRETS / f"{ch}.secret"
    if not key:
        return ""
    lines = [key] + [l for l in (extra_lines or [])]
    old = p.read_text(encoding="utf-8") if p.exists() else ""
    if old.strip() == key:
        return "dup"
    if old.strip():
        lines = [old.strip().splitlines()[0], *lines[1:]] if key == old.strip().splitlines()[0] else [key] + [l for l in lines[1:] if not l.startswith(key)]
        p.write_text("\n".join(lines) + "\n", encoding="utf-8")
    else:
        p.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return "saved"

def shot(page, name):
    try:
        f = SHOTS / f"{name}.png"
        page.get_screenshot(path=str(f), full_page=False)
        return str(f)
    except Exception as e:
        return "shot-fail:" + type(e).__name__

def keys_from(text, patterns):
    for rx in patterns:
        m = re.findall(rx, text)
        if m:
            return m[0]
    return ""

def log(d):
    print(json.dumps(d, ensure_ascii=False, default=str), flush=True)
