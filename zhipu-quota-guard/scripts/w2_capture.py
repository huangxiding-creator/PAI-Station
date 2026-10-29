# -*- coding: utf-8 -*-
"""W2 重置链路抓包 — DrissionPage 登录 bigmodel.cn，被动捕获 reset/status 请求。
铁律：绝不点击「使用重置卡」按钮（不烧卡）；只抓页面加载时的被动 GET。
产物：state/zcode_jwt.txt + state/w2_capture.json + 截图（失败诊断用）。"""
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"
STATE.mkdir(exist_ok=True)

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

SEC = json.loads((ROOT / "secrets" / "zhipu_secrets.json").read_text(encoding="utf-8"))
BM = SEC["bigmodel"]
LOGIN_URL = BM["login_url"]
USAGE_URL = "https://www.bigmodel.cn/coding-plan/personal/usage"


def shot(page, name):
    try:
        p = STATE / f"w2_{name}.png"
        page.get_screenshot(path=str(p), full_page=False)
        print(f"[shot] {p.name}")
    except Exception as e:  # noqa: BLE001
        print(f"[shot] fail {e!r}")


def try_captcha(page, target: int | None = None) -> bool:
    """检测并尝试滑块验证（含 iframe 内 geetest）；拟人轨迹 + 可选目标距离扫描。"""
    import random
    sels = ["css:.geetest_slider_button",
            "css:[class*=slider] [class*=handle]",
            "css:[class*=slider-btn]",
            "css:[class*=slider] button",
            "css:[class*=Slider] [class*=handler]"]
    containers = [page]
    try:
        containers += list(page.eles("css:iframe"))
    except Exception:  # noqa: BLE001
        pass
    for cont in containers:
        try:
            tgt = cont if cont is page else cont.sr()
        except Exception:  # noqa: BLE001
            continue
        for sel in sels:
            try:
                sl = tgt.ele(sel, timeout=1)
                if sl and sl.states.is_displayed:
                    print(f"[captcha] 发现滑块 {sel}，拟人拖动")
                    # 先点「刷新」清掉加载失败状态（若有）
                    for rs in ["css:.geetest_refresh_1", "css:[class*=refresh]",
                               "css:[class*=reload]"]:
                        try:
                            r = tgt.ele(rs, timeout=1)
                            if r and r.states.is_displayed:
                                r.click()
                                time.sleep(1.5)
                                break
                        except Exception:  # noqa: BLE001
                            continue
                        break
                    sl = tgt.ele(sel, timeout=2)
                    sl.hover().hold()
                    # 拟人轨迹：目标距离带随机、加速-匀速-减速三段、y微抖、末端回修1px
                    total = target if target else random.randint(250, 310)
                    moved = 0
                    while moved < total:
                        remain = total - moved
                        if remain > 120:
                            step = random.randint(18, 28)   # 加速段
                        elif remain > 40:
                            step = random.randint(10, 18)   # 匀速段
                        else:
                            step = max(3, min(remain, random.randint(4, 9)))  # 减速段
                        moved += step
                        sl.move(offset_x=step, offset_y=random.randint(-2, 2), duration=random.randint(30, 70) / 1000)
                    sl.move(offset_x=-1, offset_y=0, duration=0.12)  # 回修
                    sl.release()
                    time.sleep(2.5)
                    return True
            except Exception:  # noqa: BLE001
                continue
    return False


def try_login(page) -> bool:
    page.get(LOGIN_URL)
    time.sleep(3)
    # 用户指定：走「账号登录」页签（非手机号验证码登录）
    tab = None
    for sel in ["xpath://div[contains(@class,'tab') and normalize-space()='账号登录']",
                "text:账号登录"]:
        try:
            tab = page.ele(sel, timeout=2)
            if tab:
                break
        except Exception:  # noqa: BLE001
            continue
    if tab:
        tab.click()
        time.sleep(1.5)
    acct = page.ele("css:input[placeholder='请输入用户名/邮箱/手机号']", timeout=4)
    if not acct:
        shot(page, "no_acct_input")
        return False
    acct.clear().input(BM["phone"])
    pwd = page.ele("css:input[placeholder='请输入密码']", timeout=3)
    if not pwd:
        shot(page, "no_pwd_input")
        return False
    pwd.clear().input(BM["password"])
    # 勾选「可见的」协议复选框（避开隐藏面板的 checkbox）
    try:
        for cb in page.eles("css:input[type=checkbox]"):
            try:
                if cb.states.is_displayed and not cb.states.is_checked:
                    cb.click()
                    time.sleep(0.4)
            except Exception:  # noqa: BLE001
                continue
    except Exception:  # noqa: BLE001
        pass
    # 提交：精确「登录」按钮（避开「登录 / 注册」按钮与页签）
    btn = page.ele("xpath://button[normalize-space()='登录']", timeout=3)
    if not btn:
        btn = page.ele("css:button[type=submit]", timeout=2)
    if not btn:
        shot(page, "no_submit_btn")
        return False
    try:
        btn.click()
    except Exception:  # noqa: BLE001
        btn.click(by_js=True)
    time.sleep(3)
    # 验证码自助闭环：滑块距离扫描×拟人轨迹（用户令：验证码自己搞定）
    sweep = [None, 170, 210, 250, 290]
    for _round in range(5):
        if "login" not in (page.url or ""):
            break
        if try_captcha(page, sweep[_round]):
            time.sleep(2)
            if "login" in (page.url or ""):
                # 滑块过了但没跳转→补点登录
                try:
                    b2 = page.ele("xpath://button[normalize-space()='登录']", timeout=2)
                    if b2:
                        b2.click()
                    time.sleep(4)
                except Exception:  # noqa: BLE001
                    pass
            continue
        try:
            b2 = page.ele("xpath://button[normalize-space()='登录']", timeout=2)
            if b2:
                b2.click()
            time.sleep(4)
        except Exception:  # noqa: BLE001
            pass
    # 捕获错误提示/toast（诊断登录失败原因）
    for sel in ["css:[class*=toast]", "css:[class*=error]", "css:[class*=message]",
                "css:[class*=tip]", "css:[class*=alert]"]:
        try:
            for el in page.eles(sel):
                t = (el.text or "").strip()
                if t and len(t) < 80:
                    print(f"[toast] {t}")
        except Exception:  # noqa: BLE001
            continue
    print("[login] cookies:", sorted({c["name"] for c in page.cookies() if isinstance(c, dict) and "name" in c})[:20])
    ok = "login" not in (page.url or "")
    print(f"[login] url now = {page.url}")
    shot(page, "after_login")
    return ok


def main() -> int:
    co = ChromiumOptions()
    co.set_local_port(9341)
    co.set_user_data_path(str(ROOT / ".chrome-profile"))
    co.headless(False)
    page = ChromiumPage(co)
    findings = {"requests": [], "localStorage_keys": [], "jwt": None}
    try:
        if not try_login(page):
            print("[W2] 登录未通过（详见 state/w2_after_login.png）")
            (STATE / "w2_capture.json").write_text(json.dumps(findings, ensure_ascii=False, indent=2), encoding="utf-8")
            return 2
        print(f"[W2] 登录成功 → {page.url}")
        # 被动监听：reset 相关请求（页面加载自然触发 status 查询）
        page.listen.start(["coding-plan/reset", "reset/status", "package-reset"])
        page.get(USAGE_URL)
        time.sleep(2)
        for pkt in page.listen.steps(timeout=20, count_gap=1.5):
            try:
                info = {"method": pkt.method, "url": pkt.url,
                        "headers": {k: (v[:18] + "***" if len(str(v)) > 24 else v)
                                    for k, v in dict(pkt.request.headers).items()}}
                findings["requests"].append(info)
                print(f"[pkt] {pkt.method} {pkt.url}")
                auth = dict(pkt.request.headers).get("authorization", "")
                if auth and not findings["jwt"]:
                    findings["jwt"] = auth
            except Exception as e:  # noqa: BLE001
                print(f"[pkt] parse err {e!r}")
            if len(findings["requests"]) >= 6:
                break
        # localStorage token 摸底
        try:
            ls = page.run_js("return JSON.stringify(Object.fromEntries(Object.entries(localStorage).map(([k,v])=>[k,String(v).slice(0,50)])))")
            findings["localStorage_keys"] = json.loads(ls)
        except Exception as e:  # noqa: BLE001
            print(f"[ls] {e!r}")
        shot(page, "usage_page")
        if findings["jwt"]:
            (STATE / "zcode_jwt.txt").write_text(findings["jwt"], encoding="utf-8")
            print(f"[W2] JWT 已存 state/zcode_jwt.txt ({findings['jwt'][:16]}***)")
        rc = 0 if findings["requests"] else 1
    finally:
        for cleanup in (lambda: page.listen.stop(), lambda: page.quit()):
            try:
                cleanup()
            except Exception:  # noqa: BLE001
                pass
    (STATE / "w2_capture.json").write_text(json.dumps(findings, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"[W2] 抓包 {len(findings['requests'])} 条，jwt={'有' if findings['jwt'] else '无'}")
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
