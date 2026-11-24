# -*- coding: utf-8 -*-
"""gzh_keepalive.py — gzh-station 会话保活（每日 08:00 计划任务）。
对每个有凭据的账号：导航首页（cookie 随访问滚动续期）→ 回读过期时间。
死会话不弹码（静默标记，等下次人工扫码窗口）。日志 logs/keepalive.log。"""
import sys, os, json, time, re

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from DrissionPage import ChromiumPage, ChromiumOptions

ACCOUNTS = {"acct01": 9361, "acct05": 9362, "acct07": 9363}


def keep(alive_account):
    acct = alive_account
    port = ACCOUNTS[acct]
    cred_path = os.path.join(HERE, "creds", f"mp_cred_{acct}.json")
    if not os.path.exists(cred_path):
        return f"[{acct}] 无凭据（未扫码过）—跳过"
    prof = os.path.join(HERE, "profiles", acct)
    os.makedirs(prof, exist_ok=True)
    co = ChromiumOptions()
    co.set_local_port(port)
    co.set_user_data_path(prof)
    co.set_browser_path(r"C:\Program Files\Google\Chrome\Application\chrome.exe")
    try:
        pg = ChromiumPage(co)
    except Exception as e:
        return f"[{acct}] 启动失败: {str(e)[:50]}"
    try:
        u = pg.url or ""
        if "token=" not in u or "login" in u.lower():
            cred = json.load(open(cred_path, encoding="utf-8"))
            pg.get("https://mp.weixin.qq.com/")
            time.sleep(3)
            try:
                pg.set.cookies(cred.get("cookies") or {})
            except Exception:
                pass
            tok = cred.get("token") or ""
            pg.get(f"https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN&token={tok}")
            time.sleep(6)
        u = pg.url or ""
        if "token=" in u and "login" not in u.lower():
            # 刷新凭据（cookie 滚动续期）
            m = re.search(r"token=(\d+)", u)
            cookies = {}
            for c in (pg.cookies() or []):
                cookies[c.get("name", "")] = c.get("value", "")
            cred = {"acct": acct, "token": m.group(1) if m else "",
                    "cookies": cookies, "saved_at": time.strftime("%F %T")}
            json.dump(cred, open(cred_path, "w", encoding="utf-8"),
                      ensure_ascii=False, indent=1)
            return f"[{acct}] 保活 ✓ token={cred['token']}"
        return f"[{acct}] 会话死（静默，待人工扫码）"
    finally:
        try:
            pg.quit()
        except Exception:
            pass


def main():
    lines = []
    for acct in ACCOUNTS:
        lines.append(keep(alive_account=acct))
        time.sleep(3)
    log_path = os.path.join(HERE, "logs", "keepalive.log")
    with open(log_path, "a", encoding="utf-8") as f:
        f.write(f"\n==== {time.strftime('%F %T')} ====\n" + "\n".join(lines) + "\n")
    print("\n".join(lines))


if __name__ == "__main__":
    main()
