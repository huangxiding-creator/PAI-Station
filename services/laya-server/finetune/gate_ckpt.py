# -*- coding: utf-8 -*-
"""检查点验收门（night_run 步骤 4-7 的独立重放）。

场景：训练被暂停/中断但 checkpoint-ft-v1[_v2] 已有完整 epoch 落盘
      （滚动存档每个 epoch 覆写一次，杀进程丢的只是未完 epoch）。
流程：写 active_checkpoint.txt → 重启服务（带检查点）→ 回归门重放
      E1-E3（独立目录 parity-ft*）→ 全 PASS 留检查点，否则清 flag
      回官方 multilingual（检查点留盘待人判）。
用法: <laya-server>/venv/Scripts/python.exe finetune/gate_ckpt.py [_v2]
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

FT = Path(__file__).resolve().parent
SVC = FT.parent
REPO = SVC.parents[1]
SUFFIX = (sys.argv[1] if len(sys.argv) > 1 else "").lstrip("_")
SUFFIX = f"_{SUFFIX}" if SUFFIX else ""
CKPT = FT / f"checkpoint-ft-v1{SUFFIX}"
PARITY_DIR = SVC / f"parity-ft{SUFFIX or '-v1'}"
CKPT_FLAG = SVC / "active_checkpoint.txt"
HEALTHZ = "http://127.0.0.1:8864/healthz"
RESULT = FT / f"gate_result{SUFFIX}.json"

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def log(msg: str) -> None:
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def _run(cmd: list[str]) -> tuple[int, str]:
    p = subprocess.run(cmd, capture_output=True, text=True,
                       creationflags=0x08000000)
    return p.returncode, (p.stdout or "") + (p.stderr or "")


def _main_python() -> str:
    pinned = Path(r"C:\Users\91216\AppData\Local\Programs\Python"
                  r"\Python311\python.exe")
    return str(pinned) if pinned.is_file() else "python"


def _alive_ckpt() -> str | None:
    """healthz 活着则返回其 checkpoint 值，否则 None。"""
    try:
        with urllib.request.urlopen(HEALTHZ, timeout=2) as r:
            hz = json.loads(r.read().decode("utf-8"))
            return hz.get("checkpoint") if hz.get("ok") else None
    except Exception:                               # noqa: BLE001
        return None


def main() -> int:
    if not (CKPT / "model.safetensors").is_file():
        raise SystemExit(f"检查点不存在: {CKPT}")
    result: dict = {"started": time.strftime("%Y-%m-%dT%H:%M:%S"),
                    "checkpoint": str(CKPT), "steps": []}
    try:
        # 1. 热换：写 flag → 杀旧服 → keepalive 拉起新服
        CKPT_FLAG.write_text(str(CKPT), encoding="utf-8")
        if (SVC / "server.pid").is_file():
            pid = (SVC / "server.pid").read_text().strip()
            if pid:
                _run(["taskkill", "/PID", pid, "/F"])
                log(f"1. 旧服 pid={pid} 已杀（待带检查点复活）")
        _run([str(SVC / "venv" / "Scripts" / "pythonw.exe"),
              str(SVC / "keepalive.py")])
        ck = None
        for _ in range(45):
            ck = _alive_ckpt()
            if ck:
                break
            time.sleep(2)
        if not ck:
            raise RuntimeError("带检查点的服务复活失败")
        if str(CKPT) not in (ck or ""):
            raise RuntimeError(f"服务没吃上检查点: healthz={ck}")
        log(f"1. 服务复活 checkpoint={ck}")

        # 2. 回归门（独立目录，不污染零样本基线档）
        env2 = {**os.environ, "PAI_JEV_ENGINE": "laya",
                "LAYA_PARITY_DIR": str(PARITY_DIR),
                "PYTHONIOENCODING": "utf-8"}
        log(f"2. 回归门重放 E1-E3 → {PARITY_DIR} ...")
        t0 = time.time()
        p2 = subprocess.run([_main_python(), str(SVC / "parity_gate.py"), "all"],
                            cwd=str(REPO), env=env2, capture_output=True,
                            text=True, creationflags=0x08000000)
        result["steps"].append({"step": "parity_gate", "rc": p2.returncode,
                                "seconds": round(time.time() - t0, 1)})
        (FT / f"parity_stdout{SUFFIX}.log").write_text(
            (p2.stdout or "") + (p2.stderr or ""), encoding="utf-8",
            errors="replace")
        verdicts: dict = {}
        report_path = PARITY_DIR / "parity_report.json"
        if report_path.is_file():
            rep = json.loads(report_path.read_text(encoding="utf-8"))
            verdicts = {k: v.get("verdict") for k, v in rep.items()
                        if isinstance(v, dict)}
        result["parity_verdicts"] = verdicts
        log(f"   门判: {verdicts}")

        # 3. 保守收口：全 PASS 才留，否则回官方
        if verdicts and set(verdicts.values()) == {"PASS"}:
            result["final"] = "ft-active"
            log("3. 全门 PASS——微调检查点在役")
        else:
            CKPT_FLAG.write_text("", encoding="utf-8")
            _run([str(SVC / "venv" / "Scripts" / "pythonw.exe"),
                  str(SVC / "keepalive.py")])
            for _ in range(45):
                if _alive_ckpt():
                    break
                time.sleep(2)
            result["final"] = "reverted-to-multilingual"
            log("3. 门未全 PASS——已回官方 multilingual（检查点留盘待人判）")
    except Exception as e:                                  # noqa: BLE001
        result["error"] = f"{type(e).__name__}: {e}"
        log(f"!! {result['error']}")
        _run([str(SVC / "venv" / "Scripts" / "pythonw.exe"),
              str(SVC / "keepalive.py")])                    # 兜底保活
    finally:
        result["finished"] = time.strftime("%Y-%m-%dT%H:%M:%S")
        RESULT.write_text(json.dumps(result, ensure_ascii=False, indent=1),
                          encoding="utf-8")
        log(f"落档 {RESULT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
