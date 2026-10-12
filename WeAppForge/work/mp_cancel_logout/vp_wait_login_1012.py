# -*- coding: utf-8 -*-
"""vp_wait_login_1012.py — 等管理员扫码登录（≤12min），登成功即落状态文件退出。

只轮询，不点击任何东西。登录成功 → 写 vp_login_ok_1012.json {token, ts}
并截一张首页证据图。超时 → 写 vp_login_timeout_1012.json。
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

HERE = Path(__file__).parent
DEADLINE = time.time() + 12 * 60


def main():
    page = attach_or_launch()
    last_url = ""
    while time.time() < DEADLINE:
        tab = None
        for t in page.get_tabs():
            if "mp.weixin.qq.com" in (t.url or ""):
                tab = t
                break
        if tab is None:
            tab = page.latest_tab
        url = tab.url or ""
        if url != last_url:
            print("url:", url[:100], flush=True)
            last_url = url
        token = None
        m = __import__("re").search(r"token=(\d{8,})", url)
        if m:
            token = m.group(1)
        else:
            # 登录成功后 mp 会自动跳到带 token 的首页；未登录时根页无 token
            try:
                body_head = (tab.run_js("return (document.body.innerText||'').slice(0,120);") or "")
            except Exception:
                body_head = ""
            if "扫码" not in body_head and "登录" not in body_head[:60] and body_head.strip():
                token = live_token(tab)
        if token:
            out = {"ok": True, "token": token, "ts": time.strftime("%H:%M:%S")}
            (HERE / "vp_login_ok_1012.json").write_text(
                json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
            shot(tab, "vp_login_ok_1012")
            print(json.dumps(out, ensure_ascii=False), flush=True)
            return 0
        time.sleep(10)
    (HERE / "vp_login_timeout_1012.json").write_text(
        json.dumps({"ok": False, "ts": time.strftime("%H:%M:%S")}, ensure_ascii=False),
        encoding="utf-8")
    print(json.dumps({"ok": False, "timeout": True}, ensure_ascii=False), flush=True)
    return 2


if __name__ == "__main__":
    sys.exit(main())
