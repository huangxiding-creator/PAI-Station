# -*- coding: utf-8 -*-
"""clash_net_manager — Clash 专业网管器 (1023 用户令: 一定要专业地调用好).

四职责:
  1. 活性检查: 内核/系统代理/manus.im 可达
  2. 最优节点选择: 测全美国节点延迟, 自动切最低 (锁国不锁号)
  3. 自愈: 内核死→拉起; 代理关→开; 出口非美→拨回
  4. 班前预检: 军团/采集/浏览器动作前必跑 (三件套全绿才放行)

用法:
  py clash_net_manager.py check       # 一次性检查+自愈+选优
  py clash_net_manager.py watch       # 持续监控 (60s/轮, 漂移即拨)
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parent
CTRL_PORT = 48898
SECRET = "d42f2047-3a9e-45a1-9e1c-b6a91441588f"
GROUP = "🚀 手动切换"
PROXY = "http://127.0.0.1:7892"
CORE_BIN = (r"C:\Program Files\Clash for Windows\resources\static\files"
            r"\win\x64\clash-win64.exe")
CLASH_DIR = Path(r"C:\Users\91216\.config\clash")
HDRS = {"Authorization": f"Bearer {SECRET}",
        "Content-Type": "application/json"}


def ctrl(path: str, method: str = "GET", data: dict | None = None):
    url = f"http://127.0.0.1:{CTRL_PORT}{path}"
    req = urllib.request.Request(
        url, data=json.dumps(data).encode() if data else None,
        headers=HDRS, method=method)
    with urllib.request.urlopen(req, timeout=10) as r:
        return json.loads(r.read())


def core_alive() -> bool:
    try:
        import curl_cffi.requests as cr
        r = cr.get("https://manus.im", impersonate="chrome",
                   proxies={"https": PROXY, "http": PROXY}, timeout=8)
        return r.status_code == 200
    except Exception:
        return False


def revive_core():
    CLASH_DIR.mkdir(parents=True, exist_ok=True)
    subprocess.Popen(
        [CORE_BIN, "-d", str(CLASH_DIR), "-f",
         str(CLASH_DIR / "push_run.yaml")],
        stdout=open(CLASH_DIR / "clash_net_manager.log", "a"),
        stderr=subprocess.STDOUT, cwd=str(CLASH_DIR),
        creationflags=0x08000000)
    time.sleep(4)


def proxy_on():
    import winreg
    k = winreg.OpenKey(
        winreg.HKEY_CURRENT_USER,
        r"Software\Microsoft\Windows\CurrentVersion\Internet Settings",
        0, winreg.KEY_SET_VALUE)
    winreg.SetValueEx(k, "ProxyServer", 0, winreg.REG_SZ, "127.0.0.1:7892")
    winreg.SetValueEx(k, "ProxyEnable", 0, winreg.REG_DWORD, 1)
    winreg.CloseKey()


def best_us_node() -> tuple[str, int]:
    """测全美国节点延迟, 返回 (最优节点名, 延迟ms)."""
    g = ctrl(f"/proxies/{urllib.parse.quote(GROUP)}")
    us_nodes = [n for n in g.get("all", []) if "美国" in n]
    best, best_ms = g.get("now", us_nodes[0] if us_nodes else ""), 99999
    for node in us_nodes:
        try:
            u = (f"/proxies/{urllib.parse.quote(node)}"
                 f"/delay?timeout=3000&url=https://manus.im")
            r = ctrl(u)
            ms = r.get("delay", 99999)
            if ms < best_ms:
                best, best_ms = node, ms
        except Exception:
            continue
        time.sleep(0.3)
    return best, best_ms


def switch(node: str) -> bool:
    try:
        ctrl(f"/proxies/{urllib.parse.quote(GROUP)}", "PUT", {"name": node})
        return True
    except Exception:
        return False


def full_check(auto_fix: bool = True) -> dict:
    """三件套检查+自愈+选优. 返回状态报告."""
    report = {"ts": time.strftime("%F %T")}

    # ① 内核
    if core_alive():
        report["core"] = "✅"
    elif auto_fix:
        revive_core()
        report["core"] = "🔄已拉起" if core_alive() else "❌拉起失败"
    else:
        report["core"] = "❌"

    # ② 系统代理
    import winreg
    k = winreg.OpenKey(
        winreg.HKEY_CURRENT_USER,
        r"Software\Microsoft\Windows\CurrentVersion\Internet Settings")
    enabled = winreg.QueryValueEx(k, "ProxyEnable")[0]
    winreg.CloseKey(k)
    if enabled:
        report["proxy"] = "✅"
    elif auto_fix:
        proxy_on()
        report["proxy"] = "🔄已开"
    else:
        report["proxy"] = "❌"

    # ③ 出口选优
    try:
        node, ms = best_us_node()
        current = ctrl(f"/proxies/{urllib.parse.quote(GROUP)}").get("now")
        if node and node != current:
            switch(node)
            report["exit"] = f"🔄{current}→{node}({ms}ms)"
        else:
            report["exit"] = f"✅{current}({ms}ms)"
    except Exception as e:
        report["exit"] = f"❌{type(e).__name__}"

    ok = all("✅" in v or "🔄" in v for v in
             [report["core"], report["proxy"], report["exit"]])
    report["verdict"] = "全绿可战" if ok else "有红勿动"
    return report


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "check"
    if mode == "check":
        r = full_check()
        for k, v in r.items():
            if k != "ts":
                print(f"  [{k}] {v}")
        sys.exit(0 if "全绿" in r["verdict"] else 1)
    elif mode == "watch":
        while True:
            r = full_check()
            print(f"[{r['ts']}] {r['verdict']} | "
                  f"核{r['core']} 代{r['proxy']} 口{r['exit']}", flush=True)
            time.sleep(60)


if __name__ == "__main__":
    main()
