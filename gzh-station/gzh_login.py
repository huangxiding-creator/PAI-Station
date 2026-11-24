# -*- coding: utf-8 -*-
"""gzh_login.py — 独立公众号工作站登录器（gzh-station，零外部依赖）。
三号并排弹码（独立 profile + 独立端口 9361/9362/9363）→ 用户扫码 →
cookie+token 落 creds/mp_cred_acctXX.json（自己的凭据，永续复用+一键登录复活）。
用法: py -3 -I gzh_login.py [acct01,acct05,acct07]
"""
import sys, os, json, time, re

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from DrissionPage import ChromiumPage, ChromiumOptions

ACCOUNTS = {
    "acct01": ("总包说", 9361),
    "acct05": ("总包之声", 9362),
    "acct07": ("工程行业大脑", 9363),
}
CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"


def launch(acct):
    nick, port = ACCOUNTS[acct]
    prof = os.path.join(HERE, "profiles", acct)
    os.makedirs(prof, exist_ok=True)
    co = ChromiumOptions()
    co.set_local_port(port)
    co.set_user_data_path(prof)
    co.set_browser_path(CHROME)
    try:
        pg = ChromiumPage(co)
    except Exception as e:
        print(f"[{acct}] 启动失败: {str(e)[:80]}")
        return None
    pg.get("https://mp.weixin.qq.com/")
    return pg


def is_logged_in(pg):
    u = pg.url or ""
    return "token=" in u and "login" not in u.lower()


def read_nickname(pg):
    try:
        body = pg.run_js('return (document.body.innerText||"")') or ""
        for k in ("总包说", "总包之声", "工程行业大脑"):
            if k in body[:600]:
                return k
    except Exception:
        pass
    return ""


def save_cred(acct, pg):
    m = re.search(r"token=(\d+)", pg.url or "")
    cookies = {}
    for c in (pg.cookies() or []):
        cookies[c.get("name", "")] = c.get("value", "")
    cred = {"acct": acct, "nickname": read_nickname(pg),
            "token": m.group(1) if m else "", "cookies": cookies,
            "saved_at": time.strftime("%F %T")}
    path = os.path.join(HERE, "creds", f"mp_cred_{acct}.json")
    json.dump(cred, open(path, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"[{acct}] 凭据已存 {path}")
    return cred


def main():
    want = sys.argv[1].split(",") if len(sys.argv) > 1 else list(ACCOUNTS)
    pages = {}
    # 首轮：登录态活的直接收凭据；死的弹码等扫
    pending = []
    for acct in want:
        pg = launch(acct)
        if pg is None:
            continue
        if is_logged_in(pg):
            cred = save_cred(acct, pg)
            print(f"[{acct}] 会话活 ✓ ({cred.get('nickname','')})")
        else:
            print(f"[{acct}] 需扫码（窗口已弹出）")
            pending.append((acct, pg))
    # 等扫码（最长 10 分钟）
    deadline = time.time() + 600
    while pending and time.time() < deadline:
        time.sleep(10)
        still = []
        for acct, pg in pending:
            if is_logged_in(pg):
                cred = save_cred(acct, pg)
                print(f"[{acct}] 扫码成功 ✓ ({cred.get('nickname','')})")
            else:
                still.append((acct, pg))
        pending = still
    for acct, pg in pending:
        print(f"[{acct}] 超时未扫（下次运行重试）")
    print("LOGIN-ROUND-DONE")


if __name__ == "__main__":
    main()
