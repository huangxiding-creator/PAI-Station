# -*- coding: utf-8 -*-
"""单账号登录冒烟 — Auto_Manus 调通第一步.

目的: 证明「代理出口=美国 + 单账号可登录 + ListSessions 正常返回」三件事,
绝不做任何任务操作 (不点继续/不发消息/不下载) — 最小侵入, 账号安全.

网络形态: 本实例单独挂 --proxy-server=127.0.0.1:7890 (7890 实测出口=美国 LA);
不碰系统代理 (ProxyEnable=0 保持), 不碰 Clash 任何组, 不影响全机其他浏览器实例.
隔离形态: local_port=9333 + 独立 user_data_path, 绝不接管 EPC100/opencli 桥等实例.

退出码: 0=登录成功拿到会话; 2=浏览器出口非美国(网络前提失败); 3=登录失败;
4=ListSessions 未捕获(可能地区封锁/风控); 5=账号文件读取失败.
"""
import sys
import time
import json
import winsound

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import Chromium, ChromiumOptions

LOGIN_URL = "https://manus.im/login?type=signIn"
LIST_SESSIONS = "https://api.manus.im/session.v1.SessionService/ListSessions"
ACCOUNT_FILE = "账号列表 - 调试.txt"
PROFILE_DIR = r"E:\AI-Station\Auto_Manus\.chrome_profile"
PROXY = "http://127.0.0.1:7890"
OVERALL_DEADLINE = 300  # 整体硬帽 5 分钟, 防挂死


def beep_ok():
    winsound.Beep(1000, 300)


def beep_help():
    winsound.Beep(1000, 500)


AD_TRIGGER = "双倍积分促销！"  # config.ini refresh_trigger_text 同款


def dismiss_ads(page) -> list:
    """关闭弹窗广告, 避免遮挡后续操作 (用户令 2026-09-22).

    三招梯: 促销弹窗→整页刷新关 / 通用关闭按钮(aria-label close 等)→点 /
    ESC 兜底. 只在检测到时动作, 空页面零动作.
    """
    from DrissionPage.common import Keys
    closed = []
    try:
        if page.ele(AD_TRIGGER, timeout=2):
            page.refresh()
            time.sleep(3)
            closed.append("refresh:" + AD_TRIGGER)
        for sel in ("@@tag()=button@@aria-label=close",
                    "@@tag()=button@@aria-label=Close",
                    '@@tag()=button@@class^=Close'):
            try:
                btn = page.ele(sel, timeout=1)
                if btn:
                    btn.click()
                    time.sleep(1)
                    closed.append(sel[:28])
                    break
            except Exception:
                continue
        page.actions.key_down(Keys.ESCAPE)
        page.actions.key_up(Keys.ESCAPE)
        if page.ele(AD_TRIGGER, timeout=1):
            closed.append("STILL_PRESENT(warn)")
    except Exception as e:
        closed.append(f"err:{type(e).__name__}")
    return closed


def load_first_account(index: int = 1):
    """读账号文件第 index 个在役账号 — 密码只在进程内流转, 绝不打印."""
    from pathlib import Path
    n = 0
    for line in Path(ACCOUNT_FILE).read_text(encoding="utf-8",
                                             errors="replace").splitlines():
        s = line.strip()
        if not s or s.startswith("#"):
            continue
        parts = s.split("|")
        if len(parts) >= 2 and "@" in parts[0]:
            n += 1
            if n == index:
                return parts[0].strip(), parts[1].strip()
    return None, None


def check_exit_country(page) -> str:
    page.get("https://ipinfo.io/json")
    time.sleep(3)
    body = page.ele("tag:body").text if page.ele("tag:body") else ""
    try:
        info = json.loads(body)
        return info.get("country", "?"), info.get("city", "?")
    except Exception:
        return "?", body[:80]


def main() -> int:
    t0 = time.time()
    idx = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    email, password = load_first_account(idx)
    if not email:
        print("[smoke] 账号文件无在役账号", flush=True)
        return 5
    print(f"[smoke] 账号: {email} (密码不显示)", flush=True)

    co = ChromiumOptions()
    co.set_proxy(PROXY)
    co.set_paths(local_port=9333, user_data_path=PROFILE_DIR)
    co.set_argument("--no-first-run")
    co.set_argument("--no-default-browser-check")
    browser = Chromium(co)
    page = browser.latest_tab
    print("[smoke] 浏览器已起 (port 9333, 独立 profile, proxy 7890)", flush=True)

    # 第 0 步: 出口国验证 — 非美国则网络前提失败, 直接退
    country, city = check_exit_country(page)
    print(f"[smoke] 浏览器出口: {country} / {city}", flush=True)
    if country != "US":
        print("[smoke] FAIL 出口非美国 — 代理未生效或节点漂移", flush=True)
        return 2

    # 第 1 步: 登录页 + 输入邮箱 (先清上一账号 cookie + 广告残留)
    try:
        page.set.cookies.clear()
    except Exception:
        pass
    page.get(LOGIN_URL)
    time.sleep(3)
    email_input = page.ele("#email", timeout=15)
    if not email_input:
        print("[smoke] FAIL 未找到邮箱输入框 (页面形态漂移?)", flush=True)
        page.get_screenshot(path="smoke_fail_noemail.png")
        return 3
    email_input.clear()
    email_input.input(email)
    print("[smoke] 已输入邮箱", flush=True)

    # 第 2 步: 监听 ListSessions + 人机验证等待 + 密码
    page.listen.start(LIST_SESSIONS)
    captcha_help_needed = False
    for attempt in range(5):
        pw = page.ele("@placeholder=输入密码", timeout=2)
        if pw:
            break
        cont = page.ele("text=继续", timeout=2)
        if cont:
            cont.click()
            time.sleep(2)
            continue
        # 简单点一下 turnstile 复选框区域 (iframe 内), 失败就等下一轮
        try:
            for sel in ("input[type='checkbox']", ".cf-turnstile"):
                el = page.ele(sel, timeout=1)
                if el:
                    el.click()
                    time.sleep(3)
                    break
        except Exception:
            pass
        time.sleep(3)
    pw = page.ele("@placeholder=输入密码", timeout=5)
    if not pw:
        print("[smoke] 需要人工过人机验证 — 蜂鸣 3 声, 60s 内请人工点击验证",
              flush=True)
        beep_help(); time.sleep(0.4); beep_help(); time.sleep(0.4); beep_help()
        captcha_help_needed = True
        deadline = time.time() + 60
        while time.time() < deadline:
            pw = page.ele("@placeholder=输入密码", timeout=2)
            if pw:
                break
            time.sleep(2)
    if not pw:
        print("[smoke] FAIL 60s 内未出现密码框 (验证未过/页面漂移)", flush=True)
        page.get_screenshot(path="smoke_fail_nopw.png")
        page.listen.stop()
        return 3
    pw.clear()
    pw.input(password)
    print("[smoke] 已输入密码", flush=True)
    final_btn = page.ele("text=继续", timeout=5)
    if final_btn:
        final_btn.click()
        print("[smoke] 已点击继续 (提交登录)", flush=True)

    # 第 3 步: 等 ListSessions 响应 (登录成功的机器证据)
    got = None
    deadline = time.time() + 90
    while time.time() < deadline and time.time() - t0 < OVERALL_DEADLINE:
        try:
            packet = page.listen.wait(timeout=3)
        except Exception:
            continue
        if not packet or packet.is_failed:
            continue
        try:
            body = packet.response.body
        except Exception:
            continue
        if isinstance(body, dict) and "sessions" in body:
            got = body
            break
        # 登录报错页特征: 留痕但不中断, 继续等到帽
        page_txt = (page.ele("tag:body").text or "")[:200] if page.ele(
            "tag:body") else ""
        for kw in ("密码错误", "账号已被", "暂停", "blocked", "incorrect"):
            if kw in page_txt:
                print(f"[smoke] 页面出现关键词: {kw}", flush=True)
                page.get_screenshot(path="smoke_fail_keyword.png")
                page.listen.stop()
                return 3
    page.listen.stop()

    if got is None:
        print("[smoke] FAIL 90s 未捕获 ListSessions — 疑似地区封锁/API 改版/风控",
              flush=True)
        page.get_screenshot(path="smoke_fail_nosession.png")
        return 4

    sessions = got.get("sessions", [])
    print(f"[smoke] ✅ 登录成功: ListSessions 返回 {len(sessions)} 个会话",
          flush=True)
    ad = dismiss_ads(page)
    if ad:
        print(f"[smoke] 广告清理: {ad}", flush=True)
    if sessions:
        uid = sessions[0].get("uid", "?")
        title = str(sessions[0].get("title", ""))[:40]
        print(f"[smoke] 第一会话 uid={uid} title={title}", flush=True)
    page.get_screenshot(path="smoke_ok_sessions.png")
    beep_ok()
    print(f"[smoke] 冒烟通过, 耗时 {time.time()-t0:.0f}s; 人工验证参与={captcha_help_needed}",
          flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
