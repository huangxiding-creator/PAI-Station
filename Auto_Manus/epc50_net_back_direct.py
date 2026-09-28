# -*- coding: utf-8 -*-
"""EPC50 网络切回国内直连 — 条件触发式 (用户 09-24 令).

用户令: 「Manus 军团的任务全部安排完成之后, 等待它完成的期间,
网络可以切回国内直连」。

前置门 (全部满足才切):
  G1 军团派发进程已全部退出 (无 epc50_corps 命令行进程);
  G2 fill 日志有终态 (今日待派 0 / 本轮发出 0 / 收工字样);
  G3 当前 mode 非 direct (幂等: 已 direct 则无事可做)。

动作: 登记 network_changelog.jsonl → PATCH mode=direct → 验证
  (mode 读回 + baidu 200 + api.manus.im 直连可达=收割面活着) → 回填 verify。

用法: python epc50_net_back_direct.py [--force]
  --force: 跳过 G1/G2 人工兜底 (仅限用户明示)。
挂法: schtasks/cron 每 30min 巡检, 条件满足即切并自删任务。
"""
import io
import json
import re
import subprocess
import sys
import time
import urllib.request as u
from pathlib import Path
from urllib.parse import quote

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

CLASH_SECRET = "d42f2047-3a9e-45a1-9e1c-b6a91441588f"
PORTS = (15198, 20225, 40233, 29069, 11845)  # H11: 口漂三连, 见 manus_lib.clash_ports
CHANGELOG = Path(r"E:\AI-Station\data\state\network_changelog.jsonl")
FILL_LOG = Path(r"E:\AI-Station\Auto_Manus\epc50_corps_fill.log") if Path(
    r"E:\AI-Station\Auto_Manus\epc50_corps_fill.log").is_file() \
    else Path("/tmp/epc50_corps_fill.log")


def clash_base() -> str | None:
    hdr = {"Authorization": "Bearer " + CLASH_SECRET}
    for p in PORTS:
        base = f"http://127.0.0.1:{p}"
        try:
            u.urlopen(u.Request(base + "/version", headers=hdr),
                      timeout=2).read()
            return base
        except Exception:
            continue
    return None


def get_mode(base: str) -> str:
    hdr = {"Authorization": "Bearer " + CLASH_SECRET}
    d = json.loads(u.urlopen(u.Request(base + "/configs", headers=hdr),
                             timeout=4).read())
    return d.get("mode", "?")


CORPS_LOCK = Path(r"E:\AI-Station\Auto_Manus\data\epc50_corps.lock")


def _lock_holder_alive() -> bool:
    """0926 v2: corps 原子锁在役 (O_EXCL + Win32 pid + atexit 释放) 且
    持有进程活 = 铁证军团在跑. 不依赖 CIM 命令行查询 (10:27 实锤间歇
    空回 → 守卫 dormant 分支 --force 强切 direct → 活军团断网暴毙)."""
    try:
        pid = int(CORPS_LOCK.read_text(encoding="utf-8").strip())
    except (OSError, ValueError):
        return False
    if not pid:
        return False
    try:
        r = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"],
                           capture_output=True, text=True, timeout=20)
        return bool(re.search(rf"^\S+\s+{pid}\s", r.stdout or "",
                              re.MULTILINE))
    except Exception:
        return True   # 查不清 = 保守视为锁在役


def corps_alive() -> bool:
    """G1: 是否还有 epc50_corps 派发进程在跑 (锁优先, CIM 兜底)."""
    if _lock_holder_alive():
        return True
    try:
        out = subprocess.check_output(
            ["powershell", "-NoProfile", "-Command",
             "Get-CimInstance Win32_Process -Filter "
             "\"Name like 'python%'\" | "
             "Where-Object {$_.CommandLine -match 'epc50_corps'} | "
             "Select-Object -ExpandProperty ProcessId"],
            timeout=30, text=True)
        return bool(out.strip())
    except Exception:
        return True  # 查不清 = 保守视为活着, 不切


def fill_finished() -> bool:
    """G2: fill 日志出现派发终态字样."""
    try:
        tail = FILL_LOG.read_text(encoding="utf-8",
                                  errors="replace").splitlines()[-30:]
    except Exception:
        return False
    marks = ("今日待派 0", "发出 0", "收工", "第", "轮")
    joined = "\n".join(tail)
    return any(m in joined for m in marks[:3])


def verify_direct() -> tuple[bool, str]:
    ok, notes = True, []
    try:
        env = {"SystemRoot": r"C:\Windows", "PATH": ";".join([])}
        r = subprocess.run(
            ["curl", "-s", "-o", "NUL", "-m", "8", "-w", "%{http_code}",
             "https://www.baidu.com"],
            capture_output=True, text=True, timeout=15,
            env={**__import__("os").environ,
                 "https_proxy": "", "http_proxy": "",
                 "HTTPS_PROXY": "", "HTTP_PROXY": ""})
        code = (r.stdout or "").strip()
        notes.append(f"baidu={code}")
        ok = ok and code == "200"
    except Exception as e:
        ok = False
        notes.append(f"baidu err {type(e).__name__}")
    try:
        r = subprocess.run(
            ["curl", "-s", "-o", "NUL", "-m", "15", "-w", "%{http_code}",
             "https://api.manus.im/"],
            capture_output=True, text=True, timeout=20,
            env={**__import__("os").environ,
                 "https_proxy": "", "http_proxy": "",
                 "HTTPS_PROXY": "", "HTTP_PROXY": ""})
        code = (r.stdout or "").strip()
        notes.append(f"api.manus.im={code}")
        ok = ok and code in ("200", "404", "401", "403")
    except Exception as e:
        ok = False
        notes.append(f"api err {type(e).__name__}")
    return ok, "; ".join(notes)


def log_change(rec: dict) -> None:
    CHANGELOG.parent.mkdir(parents=True, exist_ok=True)
    with CHANGELOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def main() -> int:
    force = "--force" in sys.argv
    base = clash_base()
    if not base:
        print("[net-direct] Clash API 不可达 — 不动网", flush=True)
        return 1
    mode = get_mode(base)
    if mode == "direct":
        print("[net-direct] 已是 direct — 无事可做", flush=True)
        return 0
    # 0926 根修: 原子锁在役 = 活军团铁证, 连 --force 也不切
    # (守卫 dormant 分支曾以 --force 绕过 G1/G2 强切 direct 杀军团).
    if _lock_holder_alive():
        print("[net-direct] 军团原子锁在役 (活军团) — 不切 (含 --force)",
              flush=True)
        return 1
    if not force:
        if corps_alive():
            print("[net-direct] G1 未过: 军团派发进程仍在跑 — 不切", flush=True)
            return 1
        if not fill_finished():
            print("[net-direct] G2 未过: fill 日志无终态 — 不切", flush=True)
            return 1
    hdr = {"Authorization": "Bearer " + CLASH_SECRET,
           "Content-Type": "application/json"}
    group = json.loads(u.urlopen(u.Request(
        base + "/proxies/" + quote("🚀 手动切换"), headers=hdr),
        timeout=4).read()).get("now", "?")
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "actor": "epc50",
           "action": "mode", "from": mode, "to": "direct",
           "reason": "用户令0924: 军团派发全部完成后等待期切回国内直连"
                     f" (原出口 {group}); 收割走 api 面直连实证可达",
           "verify": "pending", "force": force}
    log_change(rec)
    req = u.Request(base + "/configs",
                    data=json.dumps({"mode": "direct"}).encode(),
                    method="PATCH", headers=hdr)
    u.urlopen(req, timeout=4).read()
    mode2 = get_mode(base)
    ok, notes = verify_direct()
    log_change({**rec, "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                "verify": f"mode={mode2} {'OK' if ok else 'FAIL'} {notes}"})
    print(f"[net-direct] mode {mode}→{mode2} verify={'OK' if ok else 'FAIL'}"
          f" {notes}", flush=True)
    return 0 if (mode2 == "direct" and ok) else 1


if __name__ == "__main__":
    sys.exit(main())
