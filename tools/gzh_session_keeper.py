# -*- coding: utf-8 -*-
"""gzh_session_keeper — 公众号三号登录态续期守护 (用户令 1123「实现公众号登录态无限续下去」).

依据 (1123 拿真实会话只读实测, 不是假设):
  公众平台的会话 cookie (data_ticket / slave_sid / slave_user / bizuin 等 8 个) 过期时间
  = 最近一次被服务器刷新的时刻 + 5 天; 每次带会话访问首页, 服务器都会重新下发, 过期时间跟着往后滚
  (08:56 访问 → 11-27 08:56; 09:14 访问 → 11-27 09:14).
  身份 cookie (xid / wxuin / ua_id) 约 400 天, 不随访问变化.
所以“无限续”的做法: 定时对每个号做一次带会话的只读访问, 并读回 cookie 过期时间, 确认真续上了.
一次实测只能说明今天如此 — 剩余天数每轮都读回并留档, 几天后再看它是否稳定.

每号每轮:
  1 该 profile 已有浏览器在跑 → 复用, 开一个新标签页; 没有 → 离屏起一个
  2 打开公众平台首页 (只读), 用页面上的账号名核对登的是不是本号 (三个号绑同一个管理员微信)
  3 读回会话 cookie 过期时间 → 剩余天数; 与访问前比较, 过期时间有没有往后滚
  4 自己起的浏览器用 Browser.close 优雅关闭 (强杀会丢没落盘的 cookie); 复用的只关自己开的标签页

红线: 绝不写入、删除或注入任何 cookie. 登录态的唯一真源是该账号的 profile 目录.
      连不上调试端口时绝不让自动化库替我们新开浏览器.
用法: py -X utf8 tools/gzh_session_keeper.py [--no-alert] [--install-guard]
"""
from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE_ROOT = r"F:\We-AIPO\autopub\data\browser_profiles"
CRED_DIR = Path(r"E:\AI-Station\电力KB收割")
FACT = REPO / "data" / "factory"
STATE = FACT / "gzh_session_state.json"
HISTORY = FACT / "gzh_session_history.jsonl"
ACCOUNTS = [("acct05", 9371, "总包之声"), ("acct01", 9372, "总包说"), ("acct07", 9373, "工程行业大脑")]
CANDIDATES = ["总包之声", "总包说", "工程行业大脑"]
EXPECTED = {"acct05": "总包之声", "acct01": "总包说", "acct07": "工程行业大脑"}
SESSION_COOKIES = ["data_ticket", "slave_sid", "slave_user", "bizuin", "data_bizuin", "slave_bizuin", "rand_info"]
GUARD_TIMES = ("08:37", "20:17", "03:47", "16:37")   # 最长间隔 8 小时, 远小于 5 天窗口
WARN_DAYS = 2.0

_PS_LIST = r"""
Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" |
  Where-Object { $_.CommandLine -and $_.CommandLine -notmatch '--type=' -and $_.CommandLine -match 'remote-debugging-port=\d+' } |
  ForEach-Object {
    $p = [regex]::Match($_.CommandLine, 'remote-debugging-port=(\d+)').Groups[1].Value
    $u = [regex]::Match($_.CommandLine, '--user-data-dir=(?:"([^"]+)"|(\S+))')
    $d = if ($u.Groups[1].Value) { $u.Groups[1].Value } else { $u.Groups[2].Value }
    Write-Output ("PORT=" + $p + "|DIR=" + $d)
  }
"""


def log(msg: str):
    print(f"[{time.strftime('%m-%d %H:%M:%S')}] {msg}", flush=True)


def http_json(url: str, timeout: float = 5):
    try:
        with urllib.request.urlopen(url, timeout=timeout) as r:
            return json.loads(r.read().decode("utf-8", errors="replace"))
    except Exception:
        return None


def _chrome_main_cmdlines() -> list[str]:
    """所有 Chrome 主进程 (不带 --type=) 的命令行. 三条路依次退:
    ① 进程内读进程列表 (不启动任何外部程序)  ② wmic  ③ PowerShell.
    1123 实测: 同一时间启动 PowerShell 会被系统策略间歇性拒绝 (WinError 786),
    而靠它枚举浏览器的守护会把“有实例在跑”误判成“没有”. 所以不押在它一条路上."""
    try:
        import psutil
        out = []
        for p in psutil.process_iter(["name", "cmdline"]):
            try:
                if (p.info.get("name") or "").lower() != "chrome.exe":
                    continue
                cl = p.info.get("cmdline") or []
                if any(a.startswith("--type=") for a in cl):
                    continue
                out.append(" ".join(cl))
            except Exception:
                continue
        return out
    except Exception:
        pass
    try:
        r = subprocess.run(["wmic", "process", "where", "name='chrome.exe'",
                            "get", "CommandLine", "/format:csv"], capture_output=True, timeout=30)
        raw = r.stdout or b""
        txt = raw.decode("utf-16", errors="replace") if raw[:2] in (b"\xff\xfe", b"\xfe\xff") \
            else raw.decode("gbk", errors="replace")
        return [ln for ln in txt.splitlines() if "remote-debugging-port=" in ln and "--type=" not in ln]
    except Exception:
        pass
    try:
        r = subprocess.run(["powershell", "-NoProfile", "-Command", _PS_LIST],
                           capture_output=True, timeout=40)
        out = (r.stdout or b"").decode("utf-8", errors="replace")
        return [ln.split("DIR=", 1)[1] + " --remote-debugging-port=" + ln.split("PORT=", 1)[1].split("|", 1)[0]
                for ln in out.splitlines() if ln.strip().startswith("PORT=")]
    except Exception:
        return []


def running_instance(acct: str) -> int | None:
    """该 profile 目录上已经在跑的 Chrome 主进程的调试端口 (没有则 None)."""
    for cl in _chrome_main_cmdlines():
        m = re.search(r"--remote-debugging-port=(\d+)", cl)
        u = re.search(r'--user-data-dir=(?:"([^"]+)"|(\S+))', cl)
        if not (m and u):
            continue
        d = (u.group(1) or u.group(2) or "").strip().replace("/", "\\").rstrip("\\").lower()
        if d.endswith("\\" + acct.lower()):
            return int(m.group(1))
    return None


class CDP:
    """最小的 CDP 客户端 (只用 websocket, 不依赖会自动新开浏览器的自动化库)."""

    def __init__(self, ws_url: str, timeout: float = 25):
        import websocket
        self.ws = websocket.create_connection(ws_url, timeout=timeout)
        self.n = 0

    def call(self, method: str, **params):
        self.n += 1
        self.ws.send(json.dumps({"id": self.n, "method": method, "params": params}))
        while True:
            m = json.loads(self.ws.recv())
            if m.get("id") == self.n:
                if "error" in m:
                    raise RuntimeError(str(m["error"].get("message"))[:120])
                return m.get("result", {})

    def eval(self, expr: str):
        res = self.call("Runtime.evaluate", expression=expr, returnByValue=True)
        return res.get("result", {}).get("value")

    def close(self):
        try:
            self.ws.close()
        except Exception:
            pass


def session_expiry(browser: CDP) -> dict:
    """会话 cookie 的过期时间 (服务器签发的时间戳)."""
    cks = browser.call("Storage.getCookies").get("cookies", [])
    detail = {c["name"]: c.get("expires", 0) for c in cks
              if c["name"] in SESSION_COOKIES and "weixin.qq.com" in c.get("domain", "")}
    latest = max(detail.values()) if detail else 0
    return {"latest": latest, "detail": detail}


def renew_one(acct: str, own_port: int, name: str) -> dict:
    r = {"acct": acct, "name": name, "expected": EXPECTED[acct], "alive": False, "account": "",
         "mismatch": False, "renewed": False, "remaining_days": None, "reused": False,
         "error": "", "token": ""}
    browser = page = None
    tid = None
    own = False
    use_port = None
    try:
        # 这台机器上还有别的程序会操作同一账号资料目录 (1123 实测: 总包之声上出现过来历不明、
        # 父进程已退出的浏览器实例). 所以: 优先复用在跑的实例; 自己起的时候若被并入别的实例
        # (Chrome 同一资料目录只允许一个进程), 就回过头去找那个实例, 多试几轮.
        for _attempt in range(4):
            rp = running_instance(acct)
            if rp and http_json(f"http://127.0.0.1:{rp}/json/version"):
                use_port, r["reused"], own = rp, True, False
                break
            own = True
            subprocess.Popen(
                [CHROME, f"--remote-debugging-port={own_port}",
                 f"--user-data-dir={os.path.join(PROFILE_ROOT, acct)}",
                 "--window-position=-32000,-32000", "--window-size=1280,800",
                 "--disable-blink-features=AutomationControlled", "--no-first-run",
                 "--no-default-browser-check", "--disable-infobars", "about:blank"],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            t0 = time.time()
            while time.time() - t0 < 20 and not http_json(f"http://127.0.0.1:{own_port}/json/version"):
                time.sleep(1)
            if http_json(f"http://127.0.0.1:{own_port}/json/version"):
                use_port = own_port
                break
            time.sleep(2)          # 没起来: 多半已并入别的实例, 回去找它
        if use_port is None:
            r["error"] = "浏览器没起来, 也没找到能复用的实例 (该账号资料多半正被别的程序占用)"
            own = False
            return r
        ver = http_json(f"http://127.0.0.1:{use_port}/json/version")
        browser = CDP(ver["webSocketDebuggerUrl"])
        before = session_expiry(browser)
        tid = browser.call("Target.createTarget", url="https://mp.weixin.qq.com/")["targetId"]
        ws_url = ""
        t0 = time.time()
        while time.time() - t0 < 20:
            for t in (http_json(f"http://127.0.0.1:{use_port}/json", 4) or []):
                if t.get("id") == tid and t.get("webSocketDebuggerUrl"):
                    ws_url = t["webSocketDebuggerUrl"]
            if ws_url:
                break
            time.sleep(0.5)
        if not ws_url:
            r["error"] = "新标签页没拿到调试入口"
            return r
        page = CDP(ws_url)
        url = ""
        t0 = time.time()
        while time.time() - t0 < 30:
            try:
                url = page.eval("location.href") or ""
            except Exception:
                url = ""
            if "cgi-bin/home" in url or "token=" in url:
                break
            time.sleep(1)
        time.sleep(3)                                   # 让服务器重新下发的 cookie 落稳
        body = page.eval("(document.body && document.body.innerText) || ''") or ""
        hits = [c for c in CANDIDATES if c in body]
        r["account"] = hits[0] if len(hits) == 1 else ""
        m = re.search(r"token=(\d+)", url)
        r["token"] = m.group(1) if m else ""
        # 账号名是判活的必要条件: 死会话的恢复页 URL 也可能带 token
        r["alive"] = bool(r["account"]) and (bool(m) or "cgi-bin/home" in url)
        r["mismatch"] = r["alive"] and r["account"] != EXPECTED[acct]
        after = session_expiry(browser)
        now = time.time()
        if after["latest"]:
            r["remaining_days"] = round((after["latest"] - now) / 86400, 2)
            r["renewed"] = after["latest"] > before["latest"] + 60
        r["window_days"] = round((after["latest"] - now) / 3600, 1) if after["latest"] else None
        if r["alive"] and not r["mismatch"]:
            # 留一份快照给旧的免扫码脚本用 (它们在会话失效时拿它重注入). 账号对不上绝不导出.
            jar = {c["name"]: c.get("value", "") for c in browser.call("Storage.getCookies").get("cookies", [])
                   if c.get("name") and "weixin.qq.com" in c.get("domain", "")}
            (CRED_DIR / f"mp_cred_{acct}.json").write_text(
                json.dumps({"acct": acct, "nickname": r["account"], "cookies": jar,
                            "token": r["token"], "exported_at": time.strftime("%Y-%m-%d %H:%M:%S"),
                            "note": "由登录态续期守护导出; 仅作失效时的兜底, 登录态真源是 profile 目录"},
                           ensure_ascii=False, indent=1), encoding="utf-8")
            r["cookies"] = len(jar)
    except Exception as e:
        r["error"] = str(e)[:140]
    finally:
        if browser is not None:
            try:
                if tid:
                    browser.call("Target.closeTarget", targetId=tid)   # 只关自己开的标签页
                if own:
                    browser.call("Browser.close")                      # 自己起的浏览器: 优雅关闭
            except Exception:
                pass
            browser.close()
        if own:
            time.sleep(1.5)   # 等 cookie 落盘
    return r


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--no-alert", action="store_true")
    ap.add_argument("--install-guard", action="store_true")
    ns = ap.parse_args()

    if ns.install_guard:
        script = REPO / "tools" / "gzh_session_keeper.py"
        logf = FACT / "gzh_session_keeper.log"
        for hhmm in GUARD_TIMES:
            cmdfile = FACT / f"GzhSessionKeeper{hhmm.replace(':', '')}.cmd"
            cmdfile.write_text(
                "@echo off\r\n"
                f'cd /d "{REPO}"\r\n'
                f'"{Path(sys.executable)}" -X utf8 "{script}" >> "{logf}" 2>&1\r\n',
                encoding="utf-8")
            r = subprocess.run(["cmd", "/c",
                                f"SchTasks /Create /F /TN GzhSessionKeeper{hhmm.replace(':', '')} "
                                f'/SC DAILY /ST {hhmm} /TR "{cmdfile}"'],
                               capture_output=True, timeout=30)
            out = (r.stdout or b"").decode("gbk", errors="replace")
            ok = r.returncode == 0
            log(f"[guard] {hhmm}: {'已注册' if ok else '失败 ' + out[-70:]}")
            if ok:
                # 注册成功后把命令回读出来, 确认路径里没有被转坏
                q = subprocess.run(["cmd", "/c",
                                    f"Schtasks /Query /TN GzhSessionKeeper{hhmm.replace(':', '')} /FO LIST /V"],
                                   capture_output=True, timeout=30)
                txt = (q.stdout or b"").decode("gbk", errors="replace")
                task = next((ln.split(":", 1)[1].strip() for ln in txt.splitlines()
                             if ln.startswith("要运行的任务") or ln.startswith("Task To Run")), "")
                bad = [hex(ord(c)) for c in task if ord(c) < 32 and c not in "\r\n"]
                log(f"[guard]   计划程序里记的命令: {task[:150]}  {'异常字符 ' + str(bad) if bad else '路径正常'}")
        return 0

    FACT.mkdir(parents=True, exist_ok=True)
    results = []
    for acct, port, name in ACCOUNTS:
        r = renew_one(acct, port, name)
        results.append(r)
        if r.get("error"):
            status = "出错"
        elif not r["alive"]:
            status = "未登录"
        elif r["mismatch"]:
            status = f"登错号(实为{r['account']})"
        elif r["remaining_days"] is not None and r["remaining_days"] < WARN_DAYS:
            status = f"剩余不足{WARN_DAYS:g}天"
        elif not r["renewed"]:
            status = "访问后过期时间没有后移"
        else:
            status = "已续期"
        r["status"] = status
        log(f"[{name}] {status} | 剩余 {r['remaining_days']} 天 | "
            + (f"{'复用了在跑的浏览器(只关自己的标签页)' if r['reused'] else '自起浏览器(已优雅关闭)'}"
               if not r["error"] else "未完成")
            + (f" | {r['error']}" if r["error"] else ""))
        time.sleep(2)

    ts = time.strftime("%Y-%m-%d %H:%M:%S")
    STATE.write_text(json.dumps({"ts": ts, "accounts": results}, ensure_ascii=False, indent=1), encoding="utf-8")
    with HISTORY.open("a", encoding="utf-8") as f:
        for r in results:
            f.write(json.dumps({"ts": ts, "name": r["name"], "status": r["status"], "account": r["account"],
                                "remaining_days": r["remaining_days"], "renewed": r["renewed"]},
                               ensure_ascii=False) + "\n")

    bad = [r for r in results if r["status"] != "已续期"]
    if bad and not ns.no_alert:
        lines = [f"· {r['name']}: {r['status']}" + (f"（剩余{r['remaining_days']}天）" if r.get("remaining_days") is not None else "")
                 + (f" {r['error']}" if r["error"] else "") for r in bad]
        good = [r for r in results if r["status"] == "已续期"]
        subprocess.run([sys.executable, "-X", "utf8", str(REPO / "tools" / "notify_wecom.py"),
                        "公众号登录态续期异常",
                        "本轮没能续上:\n" + "\n".join(lines)
                        + ("\n\n其余正常: " + "、".join(f"{r['name']}(剩余{r['remaining_days']}天)" for r in good)
                           if good else "")
                        + "\n\n守护不会自动注入或重登 — 需要时回复「弹码」。"],
                       capture_output=True, timeout=60)
    log(f"[keeper] 已续期 {len(results) - len(bad)}/{len(results)}")
    return 0 if not bad else 1


if __name__ == "__main__":
    raise SystemExit(main())
