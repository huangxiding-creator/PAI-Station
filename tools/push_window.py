# -*- coding: utf-8 -*-
r"""机场窗口重试推送——复刻 We-AIPO push_hard 配方（r0..r21 ★PUSH VERIFIED 收兵）。

原理：机场故障是"窗口性"的（深夜坏、几小时后自愈）。GET github.com 永远通，
无法判别 POST 通道；用 git 智能协议的 receive-pack 引用广告（GET、带认证）
做廉价判别——它走与推送完全相同的 URL 路径，窗口关则挂/残缺，窗口开则返回
"001e# service=git-receive-pack"。窗口开才真推；推完 ls-remote 验证 SYNCED。

运行: python tools/push_window.py [rounds] [sleep_sec]   默认 60 轮×180 秒
"""
import subprocess
import sys
import time

ROOT = __file__.rsplit("\\tools", 1)[0] if "\\" in __file__ else __file__.rsplit("/tools", 1)[0]
REPO_URL = "https://github.com/huangxiding-creator/PAI-Station.git"


def creds():
    p = subprocess.run(["git", "credential", "fill"],
                       input=b"protocol=https\nhost=github.com\n\n",
                       capture_output=True, timeout=10)
    d = dict(l.split("=", 1) for l in p.stdout.decode().splitlines() if "=" in l)
    return d.get("username", ""), d.get("password", "")


def window_open(user, tok):
    """GET receive-pack 引用广告：窗口判别器。"""
    import base64
    import urllib.request as u
    import urllib.error
    basic = base64.b64encode(f"{user}:{tok}".encode()).decode()
    url = REPO_URL + "/info/refs?service=git-receive-pack"
    req = u.Request(url, headers={"Authorization": f"Basic {basic}",
                                  "User-Agent": "git/2.52.0"})
    opener = u.build_opener(u.ProxyHandler({"http": "http://127.0.0.1:7890",
                                            "https": "http://127.0.0.1:7890"}))
    try:
        with opener.open(req, timeout=12) as r:
            return r.status == 200 and r.read(32).startswith(b"001e# service=git-receive-pack")
    except Exception:
        return False


def heads():
    local = subprocess.run(["git", "rev-parse", "HEAD"], cwd=ROOT,
                           capture_output=True, text=True).stdout.strip()
    r = subprocess.run(["git", "ls-remote", "origin", "main"], cwd=ROOT,
                       capture_output=True, text=True, timeout=60)
    remote = r.stdout.strip().split()[0] if r.stdout.strip() else ""
    return local, remote


def main():
    rounds = int(sys.argv[1]) if len(sys.argv) > 1 else 60
    gap = int(sys.argv[2]) if len(sys.argv) > 2 else 180
    user, tok = creds()
    for i in range(rounds):
        local, remote = heads()
        if remote == local:
            print(f"r{i}: ★ SYNCED already remote={remote[:8]} —— 收兵", flush=True)
            return 0
        if not window_open(user, tok):
            print(f"r{i}: 窗口关 (local={local[:8]} remote={remote[:8]})", flush=True)
        else:
            print(f"r{i}: 窗口开 → push", flush=True)
            p = subprocess.run(["git", "push", "origin", "main"], cwd=ROOT,
                               capture_output=True, text=True, timeout=180,
                               encoding="utf-8", errors="replace")
            local, remote = heads()
            if remote == local:
                print(f"r{i}: push(rc={p.returncode}) verify=SYNCED", flush=True)
                print("★ PUSH VERIFIED——收兵", flush=True)
                subprocess.run([sys.executable, ROOT + "\\tools\\notify_wecom.py",
                                "PAI-Station 推送成功（窗口法）",
                                f"机场窗口恢复，r{i} 轮推送成功并验证 SYNCED，remote={remote[:8]}，含 Word 成果 V2.1"],
                               capture_output=True)
                return 0
            print(f"r{i}: push(rc={p.returncode}) verify=BEHIND", flush=True)
        time.sleep(gap)
    print("exhausted rounds without success", flush=True)
    return 1


if __name__ == "__main__":
    sys.exit(main())
