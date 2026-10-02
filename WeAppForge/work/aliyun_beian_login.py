# -*- coding: utf-8 -*-
"""阿里云控制台自动登录 + ICP备案主体侦察（DrissionPage）。
- 本机Chrome，独立profile持久登录态，调试端口9335（避开9222微信devtools）
- 账密从 data/secrets/aliyun_console.secret 读取，绝不硬编码
- 滑块自动尝试；短信/MFA/失败 → 截图留证 + 控制台打 NEED_* 状态（浏览器保持打开，用户可手动）
- 幂等：已登录则直接侦察主体页
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

LOGIN_URL = ("https://account.aliyun.com/login/login.htm?"
             "oauth_callback=http://beian.aliyun.com/pcContainer/selfEntity?entityId=9452842")
BEIAN_URL = "https://beian.aliyun.com/pcContainer/selfEntity?entityId=9452842"

sec = dict(l.strip().split("=", 1) for l in io.open(
    r"E:\AI-Station\data\secrets\aliyun_console.secret", encoding="utf-8")
    if "=" in l and not l.startswith("note"))
ACCOUNT, PASSWORD = sec["login"], sec["password"]


def shot(page, tag):
    try:
        p = SHOTS / f"{tag}_{int(time.time())}.png"
        page.get_screenshot(str(p))
        print(f"[shot] {p.name}")
    except Exception as e:
        print("[shot-fail]", repr(e)[:100])


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


def dump(page, tag, n=700):
    print(f"--- {tag} url={page.url}")
    print("title:", page.title)
    for i, c in enumerate(ctxs(page)):
        try:
            t = (c.text or "").replace("\n", " | ")
            if t.strip():
                print(f"  ctx{i} text[:{n}]:", t[:n])
        except Exception:
            pass


def inventory(page):
    for i, c in enumerate(ctxs(page)):
        try:
            for e in c.eles("tag:input")[:10]:
                print(f"  ctx{i} input:", e.attr("id"), "|", (e.attr("placeholder") or "")[:30], "|", e.attr("type"))
            for e in c.eles("tag:button")[:12]:
                txt = (e.text or "").strip().replace("\n", " ")[:24]
                if txt:
                    print(f"  ctx{i} button:", txt)
        except Exception:
            pass


def find(page, sels, tag_filter=None):
    """主文档+iframe 逐个找元素。"""
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
    """阿里云滑块：尝试按住抖动拖到底。"""
    for c in ctxs(page):
        for sel in ("xpath://span[contains(@class,'btn_slide')]",
                    "xpath://div[contains(@class,'nc-lang-cnt')]//span",
                    "xpath://*[contains(@class,'nc_iconfont')]",
                    "xpath://div[contains(@class(),'slider')]//span[contains(@class(),'btn')]"):
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
                print("[slider] dragged, wait verify...")
                return True
            except Exception as e:
                print("[slider] drag-fail", repr(e)[:120])
    return False


def human_wall(page):
    """识别需要用户介入的墙：短信/MFA/安全验证。返回状态名或None。"""
    txt = " ".join((c.text or "") for c in ctxs(page))
    if "MFA" in txt or "虚拟终端" in txt or ("动态口令" in txt):
        return "NEED_MFA"
    if ("短信验证" in txt or "验证码已发送" in txt or "校验码" in txt) and "登录" not in txt[:50]:
        return "NEED_SMS"
    if "安全验证" in txt or "身份核验" in txt or "人脸" in txt:
        return "NEED_VERIFY"
    return None


def main():
    co = ChromiumOptions()
    co.set_browser_path(r"C:\Program Files\Google\Chrome\Application\chrome.exe")
    co.set_user_data_path(r"E:\AI-Station\data\state\aliyun_beian_profile")
    co.set_local_port(9335)
    co.set_argument("--no-first-run")
    co.set_argument("--lang=zh-CN")
    co.set_argument("--window-size", "1300,880")
    page = ChromiumPage(co)

    page.get(LOGIN_URL)
    page.wait.doc_loaded(timeout=30)
    time.sleep(3)

    if "beian.aliyun.com" in page.url and "account.aliyun.com" not in page.url:
        print("STATUS=ALREADY_LOGGED_IN")
    else:
        dump(page, "login-page")
        shot(page, "01_login")
        inventory(page)

        # 1) 切到密码登录tab（如有）
        click_first(page, ("text=密码登录", "text=账号密码登录",
                           "xpath://div[text()='密码登录']", "xpath://span[text()='密码登录']"))
        time.sleep(1.5)

        # 2) 账号
        acct = find(page, ("#username", "xpath://input[@name='username']",
                           "xpath://input[not(@type='password') and contains(@placeholder,'账号')]",
                           "xpath://input[not(@type='password') and contains(@placeholder,'手机')]",
                           "xpath://input[not(@type='password') and contains(@placeholder,'邮箱')]"),
                    tag_filter="input")
        if not acct:
            print("STATUS=NO_ACCOUNT_INPUT")
            shot(page, "02_no_acct")
            return
        acct.clear()
        acct.input(ACCOUNT)

        # 3) 密码（有的流程先点下一步）
        pwd = find(page, ("#password", "xpath://input[@type='password']"), tag_filter="input")
        if not pwd:
            click_first(page, ("text=下一步", "xpath://button[contains(.,'下一步')]"))
            time.sleep(2)
            pwd = find(page, ("xpath://input[@type='password']",), tag_filter="input")
        if not pwd:
            print("STATUS=NO_PASSWORD_INPUT")
            shot(page, "03_no_pwd")
            return
        pwd.clear()
        pwd.input(PASSWORD)
        time.sleep(0.5)

        # 4) 滑块（表单内嵌式）
        try_slider(page)

        # 5) 登录
        click_first(page, ("xpath://button[contains(.,'登录')]", "text=登 录", "text=登录",
                           "xpath://div[@role='button'][contains(.,'登录')]"))
        print("[clicked] login")
        time.sleep(5)

        # 6) 登录后可能弹滑块/短信/安全验证
        for round_ in range(3):
            wall = human_wall(page)
            if wall == "NEED_SMS":
                print("STATUS=NEED_SMS（请把手机收到的验证码告诉我，或直接在浏览器里输入）")
                dump(page, "sms-wall", 400)
                shot(page, "04_sms")
                return
            if wall == "NEED_MFA":
                print("STATUS=NEED_MFA（需要动态口令，请在浏览器里手动完成）")
                shot(page, "04_mfa")
                return
            if wall == "NEED_VERIFY":
                print("STATUS=NEED_VERIFY（安全验证/人脸，请在浏览器里手动完成）")
                shot(page, "04_verify")
                return
            slid = try_slider(page)
            if not slid:
                break
            time.sleep(3)

        time.sleep(3)
        if "beian.aliyun.com" in page.url and "account.aliyun.com" not in page.url:
            print("STATUS=LOGGED_IN")
        else:
            dump(page, "after-login")
            shot(page, "05_after")
            wall = human_wall(page)
            print("STATUS=" + (wall or "UNKNOWN_STATE"))

    # ===== 已登录：直接侦察主体页 =====
    if "selfEntity" not in page.url:
        page.get(BEIAN_URL)
        page.wait.doc_loaded(timeout=30)
        time.sleep(4)
    print("=== 主体页侦察 ===")
    dump(page, "self-entity", 1500)
    shot(page, "06_self_entity")
    inventory(page)
    print("DONE url=", page.url)


if __name__ == "__main__":
    main()
