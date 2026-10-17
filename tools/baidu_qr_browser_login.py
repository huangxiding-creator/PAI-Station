# -*- coding: utf-8 -*-
"""baidu_qr_browser_login.py — 无头浏览器扫码登录取 BDUSS（持久化版）.

路线: 自起 Chromium(专属口 9341 + 专用 profile 持久化) → 直开 passport
登录页(QR 默认在位) → 截图发企微(scan-summon 协议) → 轮询 CDP cookies
等 BDUSS → 落 data/secrets/baidu_bduss.ini.
纪律: 不碰任何在用浏览器(9222/9225/9333/9340); 凭据只落盘绝不打印;
UA 覆写防 HeadlessChrome WAF(搜狗根因同款); 直连国内站不动网.
复用: profile 持久化在 data/state/baidu_qr_profile, 二次运行若仍登录
直接秒取(登录态持久化标配).
"""
import os
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(r"E:\AI-Station")
PROFILE = ROOT / "data" / "state" / "baidu_qr_profile"
QR_PNG = ROOT / "tools" / "baidu_qr2.png"
SECRETS = ROOT / "data" / "secrets" / "baidu_bduss.ini"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36")
LOGIN_URL = ("https://passport.baidu.com/v2/?login&qrlogin=1&suggest=1"
             "&u=https%3A%2F%2Fpan.baidu.com%2F")

from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402


def wecom(msg_text: bool, title: str = None, body: str = None, fname: str = None):
    py = sys.executable
    if os.environ.get("BAIDU_QR_SEND") != "1":
        print("WECom_SKIP (BAIDU_QR_SEND!=1, 自验模式)")
        return
    if msg_text:
        subprocess.run([py, "-X", "utf8", str(ROOT / "tools" / "notify_wecom.py"),
                        title or "百度网盘扫码登录",
                        body or "请扫刚发的企微图片(以手机上最新收到的一张为准)。"
                                "用手机百度APP或网盘APP扫码,按手机提示点确认登录。"
                                "扫完不用回复,自动捕获。"],
                       capture_output=True, timeout=60)
    else:
        subprocess.run([py, "-X", "utf8", str(ROOT / "tools" / "send_wecom_file.py"),
                        str(QR_PNG), fname or "百度网盘登录二维码(最新-扫这张)"],
                       capture_output=True, timeout=60)


def grab_cookies(page):
    try:
        cs = page.cookies(all_domains=True)
    except TypeError:                      # 旧版签名
        cs = page.cookies()
    out = {}
    for c in cs or []:
        if c.get("name") in ("BDUSS", "STOKEN") and c.get("value"):
            out[c["name"]] = c["value"]
    return out


def main() -> int:
    # 守候模式: 默认单窗600s; --wait-min N 开长守候(N分钟,码每~4分钟自动
    # 刷新重发企微,用户任何时刻回来扫最新一张都是活码)
    wait_min = 0
    for i, a in enumerate(sys.argv):
        if a == "--wait-min" and i + 1 < len(sys.argv):
            wait_min = int(sys.argv[i + 1])
    rounds = max(1, (wait_min * 60) // 240) if wait_min else 1
    poll_sec = 600 if not wait_min else 240
    co = ChromiumOptions()
    co.set_local_port(9341)
    co.set_user_data_path(str(PROFILE))
    co.headless(True)
    co.set_argument("--user-agent=" + UA)           # 防 HeadlessChrome WAF
    co.set_argument("--no-first-run")
    co.set_argument("--window-size", "1280,900")
    page = ChromiumPage(co)
    try:
        got = {}
        for rnd in range(1, rounds + 1):
            page.get(LOGIN_URL)                     # 每轮重开=新码
            time.sleep(4)
            got = grab_cookies(page)
            if got.get("BDUSS"):
                print("PROFILE_STILL_LOGGED_IN (免扫, 持久化生效)")
                break
            page.get_screenshot(str(QR_PNG))        # 全视口截屏, QR 在页中央
            print(f"QR_SAVED round={rnd}/{rounds} "
                  f"{QR_PNG.stat().st_size}bytes {time.strftime('%H:%M:%S')}",
                  flush=True)
            wecom(msg_text=False)
            wecom(msg_text=True,
                  title=f"百度网盘扫码(第{rnd}张,扫最新这张)",
                  body="以手机上最新收到的二维码图片为准(旧图已过期)。"
                       "百度APP或网盘APP扫码→手机上点确认登录。扫完不用管,自动收。")
            t0 = time.time()
            while time.time() - t0 < poll_sec:
                time.sleep(3)
                got = grab_cookies(page)
                if got.get("BDUSS"):
                    print(f"LOGIN_CONFIRMED round={rnd} "
                          f"at {int(time.time() - t0)}s", flush=True)
                    break
            if got.get("BDUSS"):
                break
        if not got.get("BDUSS"):
            print("TIMEOUT_NO_CONFIRM_ALL_ROUNDS", flush=True)
            return 1
        bduss = got["BDUSS"]
        stoken = got.get("STOKEN", "")
        SECRETS.parent.mkdir(parents=True, exist_ok=True)
        with open(SECRETS, "w", encoding="utf-8") as f:
            f.write("[baidu]\n"
                    f"bduss = {bduss}\n"
                    f"stoken = {stoken}\n"
                    f"# via headless qr login {time.strftime('%F %T')}\n"
                    f"# profile: {PROFILE}\n")
        print(f"BDUSS_SAVED len={len(bduss)} stoken_len={len(stoken)}",
              flush=True)
        wecom(msg_text=True,
              title="百度网盘登录已捕获",
              body="扫码成功,BDUSS已安全落盘(不显示内容)。102G裁判文书离线下载任务即将开跑。")
        return 0
    finally:
        try:
            page.quit()
        except Exception:  # noqa: BLE001
            pass


if __name__ == "__main__":
    raise SystemExit(main())
