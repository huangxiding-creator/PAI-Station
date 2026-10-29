# -*- coding: utf-8 -*-
"""organ_probe.py — 引擎器官健康探针（W2.2）。

读 organs.json 注册表，逐器官检查：单例锁(pid+hb)新鲜度 + 进程存活 + 账本尾读，
输出单行 JSON（--summary 则输出人读短串）。只读不写、绝不动器官进程。

退出码：0=全部健康  2=存在不健康器官  1=探针自身错误（注册表缺失/损坏）
用法：py -X utf8 organ_probe.py [--organ zqg] [--summary] [--registry organs.json]
消费方：auto-loop.sh 429限额路径(shield_snapshot入ledger) / 每轮PROMPT额度自检 / 人工巡检
"""
from __future__ import annotations

import argparse
import ctypes
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
WATCH_KINDS = ("poll", "decision", "heartbeat", "error", "drift",
               "reset_result", "login", "notify")
PROCESS_QUERY_LIMITED_INFORMATION = 0x1000
STILL_ACTIVE = 259


def _proc_alive(pid) -> bool:
    """Windows 进程存活探测（OpenProcess 只查询句柄，绝不杀进程）。"""
    try:
        pid = int(pid)
        if pid <= 0:
            return False
        k32 = ctypes.windll.kernel32
        h = k32.OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, False, pid)
        if not h:
            return False
        try:
            code = ctypes.c_ulong()
            if k32.GetExitCodeProcess(h, ctypes.byref(code)):
                return code.value == STILL_ACTIVE
            return True
        finally:
            k32.CloseHandle(h)
    except Exception:                       # noqa: BLE001 — 非Windows/转换失败：交hb新鲜度兜底
        return False


def _tail_ledger(ledger_dir: Path, n_files: int = 2, n_tail: int = 100) -> dict:
    """读账本最新 n_files 个 run-*.jsonl：各 kind 最后一条 + 近段 error/drift 计数。

    撕裂尾行容忍（对齐 zqg Ledger.read 语义）；目录缺失=空账本不报错。
    """
    out = {"last": {}, "errors_recent": 0, "drifts_recent": 0}
    files = sorted(ledger_dir.glob("run-*.jsonl"))[-n_files:] if ledger_dir.is_dir() else []
    entries = []
    for p in files:
        for raw in p.read_text(encoding="utf-8", errors="replace").splitlines():
            raw = raw.strip()
            if not raw:
                continue
            try:
                e = json.loads(raw)
            except ValueError:
                continue
            if isinstance(e, dict) and "kind" in e:
                entries.append(e)
    for e in entries[-n_tail:]:
        k = e.get("kind")
        if k in WATCH_KINDS:
            out["last"][k] = e.get("payload", e)
        if k == "error":
            out["errors_recent"] += 1
        elif k == "drift":
            out["drifts_recent"] += 1
    return out


def _yaml_scalar(path: Path, section: str, key: str):
    """极简两段式 YAML 取值（config.yaml 无深嵌套，够用；避免引 PyYAML 依赖）。"""
    try:
        cur = None
        for line in path.read_text(encoding="utf-8").splitlines():
            s = line.split("#", 1)[0].rstrip()
            if not s.strip():
                continue
            if not s[:1].isspace() and s.endswith(":"):
                cur = s[:-1].strip()
            elif cur == section and ":" in s:
                k, _, v = s.partition(":")
                if k.strip() == key:
                    return v.strip() or None
    except OSError:
        pass
    return None


def probe_organ(organ: dict, now: float | None = None) -> dict:
    """探单个器官。verdict: healthy|hb_stale|process_dead|no_lock。"""
    now = now if now is not None else time.time()
    workdir = Path(organ["workdir"])
    stale = float(organ.get("stale_sec", 600))
    res = {"organ": organ["id"], "name": organ.get("name", organ["id"]),
           "ts": time.strftime("%Y-%m-%d %H:%M:%S"), "stale_sec": stale,
           "verdict": "no_lock", "healthy": False, "pid": None, "hb_age_s": None}
    info = None
    lock = workdir / organ["lock_file"]
    if lock.is_file():
        try:
            info = json.loads(lock.read_text(encoding="utf-8"))
        except ValueError:
            info = None                    # 损坏锁按 zqg 语义=陈旧可接管 → 视同无锁
    if info is not None:
        pid, hb = info.get("pid"), float(info.get("hb", 0) or 0)
        res["pid"], res["hb_age_s"] = pid, round(now - hb, 1)
        if now - hb > stale:
            res["verdict"] = "hb_stale"    # 心跳超时：冻结/崩溃残留
        elif not _proc_alive(pid):
            res["verdict"] = "process_dead"  # hb新鲜但进程不在（zqg将自拒接管至hb过期）
        else:
            res["verdict"], res["healthy"] = "healthy", True
    led = _tail_ledger(workdir / organ.get("ledger_dir", "ledger"))
    res["ledger"] = led["last"]
    res["last_poll"] = led["last"].get("poll")
    res["last_decision"] = led["last"].get("decision")
    res["errors_recent"] = led["errors_recent"]
    res["drifts_recent"] = led["drifts_recent"]
    mode_path = organ.get("config_mode_path") or []
    if len(mode_path) == 2 and organ.get("config_file"):
        res["mode"] = _yaml_scalar(workdir / organ["config_file"],
                                   mode_path[0], mode_path[1])
    return res


def _summary_line(r: dict) -> str:
    if not r.get("healthy"):
        return f"{r['organ']}:{r['verdict']}"
    dec = r.get("last_decision") or {}
    poll = r.get("last_poll") or {}
    sim = "模拟" if dec.get("simulated") else "实弹"
    return (f"{r['organ']}:healthy pct={poll.get('window_pct', '?')}% "
            f"decision={dec.get('action', '?')}({sim}) mode={r.get('mode', '?')} "
            f"hb={r.get('hb_age_s', '?')}s err{r.get('errors_recent', 0)}")


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="organ_probe")
    ap.add_argument("--organ", help="只探指定器官（默认全部）")
    ap.add_argument("--summary", action="store_true", help="人读短串代替JSON")
    ap.add_argument("--registry", default=str(ROOT / "organs.json"))
    args = ap.parse_args(argv)
    try:
        reg = json.loads(Path(args.registry).read_text(encoding="utf-8"))
        organs = [o for o in reg.get("organs", [])
                  if not args.organ or o.get("id") == args.organ]
    except (OSError, ValueError) as e:
        print(json.dumps({"probe_error": str(e)[:200]}, ensure_ascii=False))
        return 1
    if args.organ and not organs:
        print(json.dumps({"probe_error": f"器官未注册: {args.organ}"}, ensure_ascii=False))
        return 1
    worst = 0
    for o in organs:
        try:
            r = probe_organ(o)
        except Exception as e:              # noqa: BLE001 — 单器官故障不拖垮全局
            r = {"organ": o.get("id", "?"), "verdict": "probe_error",
                 "healthy": False, "err": str(e)[:200]}
        if not r.get("healthy"):
            worst = 2
        print(_summary_line(r) if args.summary else
              json.dumps(r, ensure_ascii=False, separators=(",", ":")))
    return worst


if __name__ == "__main__":
    sys.exit(main())
