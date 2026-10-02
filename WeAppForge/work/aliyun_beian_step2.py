# -*- coding: utf-8 -*-
"""阿里云登录第二步（DrissionPage，附加到已开浏览器，不刷新页面）：
  fill            填账号+密码，截取验证码原图（等我人工认码）
  submit XXXX     填验证码+点登录+过墙（滑块自动/短信MFA提醒）+登陆后侦察备案主体页
"""
import io
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumPage, ChromiumOptions
from DrissionPage.common import Actions

SHOTS = Path(r"E:\AI-Station\WeAppForge\work\beian_shots")
SHOTS.mkdir(exist_ok=True)
BEIAN_URL = "https://beian.aliyun.com/pcContainer/selfEntity?entityId=9452842"

sec = dict(l.strip().split("=", 1) for l in io.open(
    r"E:\AI-Station\data\secrets\aliyun_console.secret", encoding="utf-8")
    if "=" in l and not l.startswith("note"))
ACCOUNT, PASSWORD = sec["login"], sec["password"]


def attach():
    co = ChromiumOptions()
    co.set_browser_path(r"C:\Program Files\Google\Chrome\Application\chrome.exe")
    co.set_user_data_path(r"E:\AI-Station\data\state\aliyun_beian_profile")
    co.set_local_port(9335)
    return ChromiumPage(co)


def frames(page):
    out = []
    try:
        for f in page.eles("tag:iframe"):
            try:
                out.append(page.get_frame(f))
            except Exception:
                pass
    except Exception:
        pass
    return out


def ctxs(page):
    return [page] + frames(page)


def shot(page, tag):
    try:
        p = SHOTS / f"{tag}_{int(time.time())}.png"
        page.get_screenshot(str(p))
        print(f"[shot] {p.name}")
    except Exception as e:
        print("[shot-fail]", repr(e)[:100])


def find(page, sels, tag_filter=None):
    for c in ctxs(page):
        for sel in sels:
            try:
                e = c.ele(sel, timeout=1)
            except Exception:
                e = None
            if e and (not tag_filter or e.tag == tag_filter):
                return e
    return None


def click_first(page, sels):
    e = find(page, sels)
    if e:
        try:
            e.click()
            return True
        except Exception as ex:
            print("[click-fail]", repr(ex)[:80])
    return False


def try_slider(page):
    for c in ctxs(page):
        for sel in ("xpath://span[contains(@class,'btn_slide')]",
                    "xpath://div[contains(@class,'nc-lang-cnt')]//span",
                    "xpath://*[contains(@class,'nc_iconfont')]"):
            try:
                h = c.ele(sel, timeout=1)
            except Exception:
                h = None
            if not h:
                continue
            print("[slider] found:", sel)
            try:
                ac = Actions(c)
                ac.move_to(h).hold()
                for _ in range(10):
                    ac.offset(dx=32, dy=1, duration=0.09)
                ac.release()
                time.sleep(2)
                print("[slider] dragged")
                return True
            except Exception as e:
                print("[slider] drag-fail", repr(e)[:120])
    return False


def ctext(c):
    try:
        return c.text or ""
    except Exception:
        try:
            b = c.ele("xpath://body", timeout=2)
            return (b.text or "") if b else ""
        except Exception:
            return ""


def wall_state(page):
    txt = " ".join(ctext(c) for c in ctxs(page))
    if "MFA" in txt or "虚拟终端" in txt or "动态口令" in txt:
        return "NEED_MFA"
    if "短信验证" in txt or "验证码已发送" in txt or "校验码" in txt:
        return "NEED_SMS"
    if "安全验证" in txt or "身份核验" in txt or "滑块" in txt:
        return "NEED_VERIFY"
    return None


def dump_entity(page):
    print("=== 主体页侦察 ===")
    print("url=", page.url, "title=", page.title)
    for i, c in enumerate(ctxs(page)):
        try:
            t = (c.text or "").replace("\n", " | ")
            if t.strip():
                print(f"ctx{i}:", t[:2000])
        except Exception:
            pass
    shot(page, "06_self_entity")


def do_fill(page):
    acct = find(page, ("#fm-login-id", "xpath://input[@id='fm-login-id']"), "input")
    if not acct:
        print("STATUS=NO_ACCOUNT_INPUT（页面可能已变化，截图看下）")
        shot(page, "fill_no_acct")
        return
    acct.clear()
    acct.input(ACCOUNT)
    pwd = find(page, ("#fm-login-password", "xpath://input[@id='fm-login-password']"), "input")
    if not pwd:
        print("STATUS=NO_PASSWORD_INPUT")
        shot(page, "fill_no_pwd")
        return
    pwd.clear()
    pwd.input(PASSWORD)
    try:
        va = acct.run_js("return this.value") or ""
        vp = pwd.run_js("return this.value") or ""
    except Exception:
        va, vp = acct.attr("value") or "", pwd.attr("value") or ""
    print(f"[verify] acct_ok={va == ACCOUNT} pwd_len={len(vp)}/{len(PASSWORD)}")
    if va != ACCOUNT or len(vp) != len(PASSWORD):
        print("STATUS=FILL_VERIFY_MISMATCH（React状态未同步，值没进去）")
        return
    print("[filled] account+password")

    # 验证码原图：优先已知id，否则枚举表单内img按尺寸挑
    cand = []
    for c in ctxs(page):
        try:
            for e in c.eles("tag:img"):
                try:
                    w, h = e.rect.size
                except Exception:
                    w = h = 0
                cand.append((e, w, h))
        except Exception:
            pass
    targets = [e for e in find_all_by_id(page, ("#fm-login-checkcode-img",))]
    if not targets:
        targets = [e for (e, w, h) in cand if 50 <= w <= 260 and 20 <= h <= 90]
    if not targets:
        print("[captcha] 未定位到验证码img，全部img清单：")
        for (e, w, h) in cand[:15]:
            print("   img:", (e.attr("id") or ""), (e.attr("src") or "")[:70], w, h)
        shot(page, "captcha_notfound")
        return
    for i, e in enumerate(targets[:3]):
        try:
            p = SHOTS / f"captcha_{i}.png"
            e.get_screenshot(str(p))
            print(f"[captcha] saved {p}")
        except Exception as ex:
            print("[captcha-shot-fail]", repr(ex)[:80])
    print("STATUS=FILLED_WAIT_CAPTCHA（请认 captcha_*.png 后跑 submit）")


def find_all_by_id(page, sels):
    out = []
    for c in ctxs(page):
        for sel in sels:
            try:
                e = c.ele(sel, timeout=1)
                if e:
                    out.append(e)
            except Exception:
                pass
    return out


def do_submit(page, code):
    ck = find(page, ("#fm-login-checkcode", "xpath://input[@id='fm-login-checkcode']"), "input")
    if not ck:
        print("STATUS=NO_CAPTCHA_INPUT")
        shot(page, "submit_no_ck")
        return
    ck.clear()
    ck.input(code)
    time.sleep(0.3)
    ok = click_first(page, ("xpath://button[contains(.,'立即登录')]", "text=立即登录",
                            "xpath://button[@type='submit']"))
    print("[clicked] login =", ok)
    time.sleep(6)

    for _ in range(3):
        all_txt = " ".join(ctext(c) for c in ctxs(page))
        if "密码错误" in all_txt:
            print("STATUS=PASSWORD_ERROR（密码被服务器拒绝）")
            shot(page, "pwd_error")
            return
        if "验证码错误" in all_txt or "图片验证码" in all_txt and "错误" in all_txt:
            print("STATUS=CAPTCHA_ERROR（验证码不对，刷新后重试）")
            shot(page, "captcha_error")
            return
        w = wall_state(page)
        if w == "NEED_SMS":
            print("STATUS=NEED_SMS（把手机收到的验证码告诉我，或直接在打开的浏览器里输入后告诉我）")
            shot(page, "04_sms")
            return
        if w in ("NEED_MFA", "NEED_VERIFY"):
            print(f"STATUS={w}（请在打开的浏览器里手动完成）")
            shot(page, "04_wall")
            return
        if not try_slider(page):
            break
        time.sleep(3)

    time.sleep(2)
    if "beian.aliyun.com" in page.url and "account.aliyun.com" not in page.url:
        print("STATUS=LOGGED_IN")
    else:
        shot(page, "05_after")
        print("STATUS=" + (wall_state(page) or "UNKNOWN"), "url=", page.url)
        return

    if "selfEntity" not in page.url:
        page.get(BEIAN_URL)
        page.wait.doc_loaded(timeout=30)
        time.sleep(4)
    dump_entity(page)


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else ""
    page = attach()
    print("attach url=", page.url)
    if mode == "fill":
        do_fill(page)
    elif mode == "submit":
        do_submit(page, sys.argv[2] if len(sys.argv) > 2 else "")
    else:
        print("usage: fill | submit <code>")


if __name__ == "__main__":
    main()
