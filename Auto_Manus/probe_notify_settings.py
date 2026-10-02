# -*- coding: utf-8 -*-
"""探通知邮箱配置 (用户令 0922): 登录账号 → UI 进设置 → 找通知项.

0922 深夜教训: manus.im/settings 是 404 兜底页(被误读成维护页),
设置入口必须从 UI 走或探测真实子路由. 本版: 首页进 → 登录 →
头像/齿轮菜单 → 截图+关键词扫描; 附 8 个候选路由 urllib 探测.
零冲突: 独立端口 9411/profile, 不碰 9333 采集实例.
"""
import sys
import time
import urllib.error
import urllib.request

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import manus_lib as lib

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except AttributeError:
    pass

EMAIL = "51817@qq.com"
PASSWORD = "ohwork4408@!"
OUT_DIR = r"E:\AI-Station\Auto_Manus"

CANDIDATE_ROUTES = (
    "/settings/profile", "/settings/general", "/settings/notifications",
    "/app/settings", "/app/settings/notifications", "/dashboard/settings",
    "/account/settings", "/user/settings",
)


def probe_routes() -> list:
    """urllib 走 7890 探候选路由: 200=存在, 404=无 (HTTPError 抓码)."""
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"http": lib.PROXY, "https": lib.PROXY}))
    op.addheaders = [("User-Agent", "Mozilla/5.0 Chrome/129.0")]
    alive = []
    for r in CANDIDATE_ROUTES:
        try:
            resp = op.open("https://manus.im" + r, timeout=10)
            alive.append((r, resp.status))
            print(f"[route] {r} -> {resp.status}")
        except urllib.error.HTTPError as e:
            print(f"[route] {r} -> {e.code}")
        except Exception as e:
            print(f"[route] {r} -> FAIL {type(e).__name__}")
    return alive


def scan_and_shot(page, tag):
    lib.dismiss_ads(page)
    time.sleep(1)
    shot = rf"{OUT_DIR}\probe_notify_{tag}.png"
    try:
        page.get_screenshot(shot, full_page=True)
        print(f"[shot] {shot}")
    except Exception as e:
        print(f"[shot] 失败 {type(e).__name__}: {e}")
    body = page.ele("tag:body")
    body = body.text if body else ""
    hits = set()
    for kw in ("notif", "Notify", "email", "Email", "通知", "邮件", "邮籍",
               "提醒", "preference", "Notification"):
        for ln in body.splitlines():
            if kw in ln:
                hits.add(ln.strip()[:110])
    for h in sorted(hits)[:25]:
        print(f"[HIT] {h}")
    if not hits:
        print(f"[HIT] ({tag}) 无通知相关关键词; url={page.url}")
    return hits


def main():
    print("[net]", lib.ensure_network())
    alive = probe_routes()
    page = lib.make_page(port=9411,
                         profile=rf"{OUT_DIR}\.profile_notify")
    try:
        page.get("https://manus.im/")
        time.sleep(4)
        lib.dismiss_ads(page)
        print(f"[nav] 首页 url={page.url}")
        if "login" in page.url or "signin" in page.url.lower():
            print("[auth] 未登录 -> lib.login")
            lib.login(page, EMAIL, PASSWORD, timeout_s=150)
            time.sleep(3)
            print(f"[auth] 登录后 url={page.url}")
            page.get("https://manus.im/")
            time.sleep(4)
            lib.dismiss_ads(page)
        scan_and_shot(page, "home_after_login")

        # UI 找设置入口: 齿轮/头像/aria-label
        clicked = False
        for sel in ("@@aria-label=Settings", "@@aria-label=settings",
                    "@@aria-label=设置", "@@title=Settings",
                    "text:设置", "text:Settings",
                    "@@tag()=button@@aria-label~gear",
                    "@@tag()=button@@aria-label~avatar",
                    "@@tag()=img@@alt~avatar"):
            try:
                btn = page.ele(sel, timeout=2)
                if btn:
                    print(f"[ui] 点设置入口: {sel}")
                    btn.click()
                    time.sleep(3)
                    clicked = True
                    break
            except Exception:
                continue
        if clicked:
            scan_and_shot(page, "menu")
            # 菜单里再找 Settings/通知 子项
            for sel in ("text:Settings", "text:设置", "text:Notifications",
                        "text:通知", "@@tag()=a@@href~settings"):
                try:
                    sub = page.ele(sel, timeout=2)
                    if sub:
                        print(f"[ui] 进子页: {sel}")
                        sub.click()
                        time.sleep(3)
                        scan_and_shot(page, "settings_page")
                        break
                except Exception:
                    continue
        # 若路由探测有活口, 也直接进
        for r, code in alive:
            page.get("https://manus.im" + r)
            time.sleep(3)
            if "unavailable" not in page.url and page.url.rstrip("/") \
                    != "https://manus.im":
                scan_and_shot(page, "route" + r.replace("/", "_"))
    finally:
        try:
            page.quit()
        except Exception:
            pass


if __name__ == "__main__":
    main()
