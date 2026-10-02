# -*- coding: utf-8 -*-
"""web 登录门重探 — 区域封锁现状快判 (0923 晨).

昨晚 23:18 定案: 登录页 unavailable 全灭 (服务端收紧). 服务端策略会漂移,
每轮攻坚前先跑本探针: unavailable 出现=门还关着; 登录表单出现=可开闸建态.
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

BAN_MARKS = ("unavailable", "not available", "无法使用", "区域", "region")


def main() -> int:
    page = lib.make_page()
    try:
        net = lib.ensure_network(page)
        print(f"[net] {net}")
        page.get("https://manus.im/login?type=signIn")
        time.sleep(6)
        body = (page.html or "")[:6000].lower()
        hit = [m for m in BAN_MARKS if m.lower() in body]
        # 邮箱输入框出现 = 登录表单活着
        try:
            el = page.ele('css:input[type="email"], input[placeholder*="mail" i]',
                          timeout=4)
            form_alive = bool(el)
        except Exception:
            form_alive = False
        verdict = "OPEN(表单活)" if form_alive else (
            f"BANNED({hit[:3]})" if hit else "UNKNOWN")
        print(f"[verdict] {verdict} | ban_marks={hit}")
        page.get_screenshot(str(lib.Path("probe_login_gate.png").resolve()
                                if hasattr(lib, "Path") else "probe_login_gate.png"))
        return 0 if form_alive else 1
    finally:
        try:
            page.quit()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
