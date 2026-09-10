"""微信读书扫码登录引导：可见窗口等用户扫码，轮询 /web/user 直到成功。

登录态双层持久化（对齐 RE-Factory 三层范式的前两层）：
- data/browser_profile/：Chromium 完整 profile（下次免扫的兜底层）
- data/weread/_auth/weread_auth.json：cookie 字符串（API 客户端主用层）
用法: python scripts/weread_login.py [超时秒数，默认300]
"""
import json
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
AUTH_DIR = os.path.join(ROOT, "data", "weread", "_auth")
AUTH_PATH = os.path.join(AUTH_DIR, "weread_auth.json")
URL = "https://weread.qq.com/"

# 仅保留 web API 必需的 cookie 键（最小权限，减少凭据暴露面）
_KEEP = ("wr_skey", "wr_vid", "wr_rt", "wr_pf", "wr_gid", "wr_localvid")


def main() -> int:
    co = ChromiumOptions()
    co.headless(False)                    # 可见窗口：用户扫码
    co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
    co.set_local_port(9333)
    co.set_argument("--no-first-run")
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_argument("--window-size=1280,900")
    co.set_argument("--window-position=100,60")

    page = ChromiumPage(co)
    try:
        page.get(URL)
        page.wait.doc_loaded()
        print("[login] 已打开微信读书，请在页面内扫码登录（右上角头像→登录）")
        os.makedirs(AUTH_DIR, exist_ok=True)
        timeout = int(sys.argv[1]) if len(sys.argv) > 1 else 300
        deadline = time.time() + timeout
        ok, payload = False, {}
        while time.time() < deadline:
            try:
                # 勘误：/web/user 改版后恒返 -2003，改查 /api/user/config
                # （登录成功返回 accountsets 账号配置）
                r = page.run_js(
                    "fetch('/api/user/config', {cache: 'no-store'})"
                    ".then(r => r.json())"
                    ".then(d => JSON.stringify(d)).catch(e => 'ERR')",
                    as_expr=True)
                if r and r != "ERR":
                    payload = json.loads(r)
                    if "accountsets" in payload:
                        ok = True
                        break
            except Exception:                     # noqa: BLE001 - 轮询容错
                pass
            time.sleep(3)
        if not ok:
            print(f"[login] TIMEOUT（{timeout}s 内未检测到登录态）")
            return 1
        pairs = {c["name"]: c["value"] for c in page.cookies()
                 if c.get("name") in _KEEP and c.get("value")}
        if "wr_skey" not in pairs:
            print("[login] 登录成功但未取到 wr_skey（罕见），重试一次")
            return 1
        cookie = "; ".join(f"{k}={v}" for k, v in pairs.items())
        auth = {"cookie": cookie,
                "vid": pairs.get("wr_vid", ""),
                "name": "",
                "saved_at": time.strftime("%Y-%m-%dT%H:%M:%S")}
        tmp = AUTH_PATH + ".tmp"
        with open(tmp, "w", encoding="utf-8") as fh:
            json.dump(auth, fh, ensure_ascii=False, indent=1)
        os.replace(tmp, AUTH_PATH)
        print(f"[login] SUCCESS 用户={auth['name']} vid={auth['vid']} "
              f"→ {os.path.relpath(AUTH_PATH, ROOT)}")
        return 0
    finally:
        page.quit()


if __name__ == "__main__":
    sys.exit(main())
