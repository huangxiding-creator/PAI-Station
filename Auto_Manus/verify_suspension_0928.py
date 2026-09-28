# -*- coding: utf-8 -*-
"""哨兵复核 — 区分真停用弹窗 vs JS bundle 误报.

判据升级: document.body.innerText (纯可见文本) + URL + 截图三证.
只读诊断, 不派发. 用 v3 独立 profile (登录态仍在, 秒进).
"""
import io
import json
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
ROOT = Path(__file__).parent
sys.path.insert(0, str(ROOT))
import manus_lib as lib  # noqa: E402

EMAIL = "xwd8lu0drf@manus.edu.kg"
KEYS = ("已被暂停", "违反了我们的服务条款", "临时限制", "suspended",
        "deactivated", "申诉")

creds = dict(lib.load_accounts("Manus账号（全部）260922_干净版.txt"))
page = lib.make_page(port=9401,
                     profile=str(ROOT / "data" / "profiles_v3" / "xwd8lu0drf"))
try:
    page.get("https://manus.im/")
    time.sleep(8)
    url = page.url or ""
    inner = page.run_js("return document.body.innerText") or ""
    html_hit = {k: (k in (page.html or "")) for k in KEYS}
    text_hit = {k: (k in inner) for k in KEYS}
    print(f"URL: {url}")
    print(f"可见文本长度: {len(inner)}")
    print(f"innerText 命中: {{{', '.join(f'{k}:{v}' for k, v in text_hit.items())}}}")
    print(f"raw html 命中: {{{', '.join(f'{k}:{v}' for k, v in html_hit.items())}}}")
    print("--- 可见文本前 600 字 ---")
    print(inner[:600])
    shot = str(ROOT / "data" / "verify_suspension_0928.png")
    try:
        page.get_screenshot(shot)
        print(f"截图: {shot}")
    except Exception as e:
        print(f"截图失败 {type(e).__name__}")
finally:
    try:
        page.browser.quit()
    except Exception:
        pass
