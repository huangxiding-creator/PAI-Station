# -*- coding: utf-8 -*-
"""W2 按给定距离拟人拖动滑块；成功→用量页抓包+提JWT+清场退出，失败→重截验证码等再瞄准。
用法: python w2_drag.py <distance_px> [--check]  # --check=只查状态不拖"""
import json
import random
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

USAGE_URL = "https://www.bigmodel.cn/coding-plan/personal/usage"


def logged_in(page) -> bool:
    return "login" not in (page.url or "")


def main() -> int:
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    check_only = "--check" in sys.argv
    co = ChromiumOptions()
    co.set_local_port(9341)
    co.set_user_data_path(str(ROOT / ".chrome-profile"))
    page = ChromiumPage(co)
    try:
        if not check_only and args:
            dist = int(args[0])
            handle = None
            for sel in ["css:[class*=slider] [class*=handle]", "css:[class*=slider-btn]",
                        "css:span[class*=slide][class*=icon]", "css:[class*=handler]",
                        "css:[class*=btn_slide]"]:
                try:
                    h = page.ele(sel, timeout=1.5)
                    if h and h.states.is_displayed:
                        handle = h
                        break
                except Exception:  # noqa: BLE001
                    continue
            if not handle:
                print("[drag] 未找到滑块")
                page.get_screenshot(path=str(STATE / "w2_drag_nohandle.png"))
                return 3
            handle.hover().hold()
            moved = 0
            while moved < dist:
                remain = dist - moved
                step = random.randint(8, 20) if remain > 50 else max(2, min(remain, random.randint(3, 7)))
                moved += step
                handle.move(offset_x=step, offset_y=random.randint(-2, 2),
                            duration=random.randint(25, 60) / 1000)
            handle.move(offset_x=-1, offset_y=0, duration=0.15)
            handle.release()
            time.sleep(3)
        # 状态检查
        if logged_in(page):
            print(f"[drag] ✅ 登录成功 url={page.url}")
            page.listen.start(["coding-plan/reset", "reset/status", "package-reset", "monitor/usage"])
            page.get(USAGE_URL)
            time.sleep(2)
            findings = {"requests": [], "jwt": None}
            for pkt in page.listen.steps(timeout=20, count_gap=1.5):
                try:
                    hdrs = dict(pkt.request.headers)
                    findings["requests"].append({"method": pkt.method, "url": pkt.url,
                                                 "auth": (hdrs.get("authorization", "")[:14] + "***") if hdrs.get("authorization") else None})
                    auth = hdrs.get("authorization", "")
                    if auth and not findings["jwt"]:
                        findings["jwt"] = auth
                except Exception:  # noqa: BLE001
                    continue
                if len(findings["requests"]) >= 8:
                    break
            try:
                ls = page.run_js("return JSON.stringify(Object.fromEntries(Object.entries(localStorage).map(([k,v])=>[k,String(v).slice(0,40)])))")
                findings["localStorage"] = json.loads(ls)
            except Exception:  # noqa: BLE001
                findings["localStorage"] = None
            page.get_screenshot(path=str(STATE / "w2_usage.png"), full_page=False)
            (STATE / "w2_capture.json").write_text(json.dumps(findings, ensure_ascii=False, indent=2), encoding="utf-8")
            if findings["jwt"]:
                (STATE / "zcode_jwt.txt").write_text(findings["jwt"], encoding="utf-8")
            print(f"[drag] 抓包 {len(findings['requests'])} 条 jwt={'✅' if findings['jwt'] else '❌'}")
            for r in findings["requests"]:
                print("   ", r["method"], r["url"][:110])
            return 0
        # 仍失败：重截验证码区供再瞄准
        for sel in ["css:[class*=captcha]", "css:[class*=verify]", "css:[class*=slide]"]:
            try:
                c = page.ele(sel, timeout=1.5)
                if c and c.states.is_displayed and c.rect.size[0] > 120:
                    c.get_screenshot(path=str(STATE / "w2_captcha.png"))
                    print("[drag] 容器", sel, rect_str(c))
                    break
            except Exception:  # noqa: BLE001
                continue
        page.get_screenshot(path=str(STATE / "w2_aim_full.png"), full_page=False)
        print("[drag] ❌ 未过，已重截 w2_captcha.png / w2_aim_full.png")
        return 1
    finally:
        if logged_in(page):
            try:
                page.quit()
            except Exception:  # noqa: BLE001
                pass


def rect_str(el):
    try:
        return f"rect={tuple(el.rect.location)}+{tuple(el.rect.size)}"
    except Exception:  # noqa: BLE001
        return "?"


if __name__ == "__main__":
    raise SystemExit(main())
