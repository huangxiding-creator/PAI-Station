# -*- coding: utf-8 -*-
"""EPC50 晨间闪击 — 08:05 积分刷新后 collect 全压派发 (用户令: collect 太少).

链路 (全自动, fail-safe):
  1. PATCH mode=rule (登记 changelog; 军团 web 面需要海外出口)
  2. probe_nodes.py 浏览器级轮换节点 (命中可用节点才继续)
     —— 全灭则切回 direct 收线, 写失败标记, 明日再战
  3. bash epc50_corps_fill.sh — 循环派发直到今日额度用满
     (seeds 已 deferred + v1 已收官 → 全部走 v2 collect)
  4. epc50_net_back_direct.py --force — 派完切回国内直连
     (用户令: 等待完成期间保持直连; force 因为 fill 退出已实证)

单进程纪律 (H6 教训): 本脚本运行期间不得另有 corps 实例。
"""
import io
import json
import subprocess
import sys
import time
import urllib.request as u
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

ROOT = Path(__file__).parent
CLASH_SECRET = "d42f2047-3a9e-45a1-9e1c-b6a91441588f"
PORTS = (20225, 29069, 11845)
CHANGELOG = Path(r"E:\AI-Station\data\state\network_changelog.jsonl")
FAIL_FLAG = ROOT / "data" / "blitz_fail.json"
PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"


def log_change(action: str, frm: str, to: str, reason: str) -> None:
    CHANGELOG.parent.mkdir(parents=True, exist_ok=True)
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "actor": "epc50-blitz",
           "action": action, "from": frm, "to": to, "reason": reason,
           "verify": "pending"}
    with CHANGELOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


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


def set_mode(base: str, mode: str) -> bool:
    hdr = {"Authorization": "Bearer " + CLASH_SECRET,
           "Content-Type": "application/json"}
    try:
        u.urlopen(u.Request(base + "/configs",
                            data=json.dumps({"mode": mode}).encode(),
                            method="PATCH", headers=hdr), timeout=4).read()
        return True
    except Exception:
        return False


def main() -> int:
    # 防重入 (H6 单进程纪律): 已有 corps/fill 在跑则本日跳过
    try:
        out = subprocess.check_output(
            ["powershell", "-NoProfile", "-Command",
             "Get-CimInstance Win32_Process -Filter \"Name like 'python%'\" | "
             "Where-Object {$_.CommandLine -match 'epc50_corps'} | "
             "Select -ExpandProperty ProcessId"],
            timeout=30, text=True)
        if out.strip():
            print(f"[blitz] 已有军团进程在跑 (pid {out.strip()}) — 跳过本日",
                  flush=True)
            return 0
    except Exception:
        pass
    base = clash_base()
    if not base:
        print("[blitz] Clash API 不可达 — 收线", flush=True)
        return 1
    if not set_mode(base, "rule"):
        print("[blitz] 切 rule 失败 — 收线", flush=True)
        return 1
    log_change("mode", "direct", "rule",
               "晨间闪击: 军团 collect 全压派发窗 (用户令 collect 优先)")
    print("[blitz] mode=rule 已开窗 (登记)", flush=True)

    # 2) 浏览器级节点轮换 (probe_nodes 自带命中保留)
    rc = subprocess.call([PY311, str(ROOT / "probe_nodes.py")],
                         cwd=str(ROOT), timeout=1800)
    if rc != 0:
        print("[blitz] probe_nodes 未命中可用节点 — 切回 direct 收线",
              flush=True)
        FAIL_FLAG.write_text(json.dumps(
            {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "stage": "probe"}),
            encoding="utf-8")
        set_mode(base, "direct")
        log_change("mode", "rule", "direct", "晨间闪击 fail-safe: 无可用节点")
        return 1
    print("[blitz] 海外节点就绪", flush=True)

    # 3) collect 全压 (fill 循环到额度满; 最长 14h 硬顶)
    print("[blitz] corps fill 启动 — collect 全压", flush=True)
    try:
        subprocess.call(["bash", str(ROOT / "epc50_corps_fill.sh")],
                        cwd=str(ROOT), timeout=14 * 3600)
    except subprocess.TimeoutExpired:
        print("[blitz] fill 14h 硬顶 — 收线切回", flush=True)
    print("[blitz] 派发结束", flush=True)

    # 4) 切回国内直连 (用户令; force=fill 进程退出已实证)
    subprocess.call([PY311, str(ROOT / "epc50_net_back_direct.py"),
                     "--force"], cwd=str(ROOT))
    print("[blitz] 完 — 已切回国内直连", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
