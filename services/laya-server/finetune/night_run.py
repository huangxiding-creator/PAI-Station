# -*- coding: utf-8 -*-
"""P2 夜间全流程编排（预备就位+自动触发模式，晚间窗独占 GPU）。

序列（任一步失败=停在那一步并落档，绝不半切）：
  1. 停看护 schtask（防训练中被复活旧服）
  2. 停 laya-server（pid 优雅杀）→ 等 VRAM 释放
  3. 全量训练 train.py（fp32 单卡 ~10-20min）
  4. 写 active_checkpoint.txt → 复活服务（带新检查点）
  5. 回复看护 schtask
  6. 回归门：LAYA_PARITY_DIR=parity-ft-v1 重跑平价门（主 Python）
  7. 落档 night_run_result.json（过门与否、各指标 before/after）

门不过的动作（保守）：清空 active_checkpoint.txt 回官方 multilingual——
零样本基线档服务立即恢复，微调检查点保留在盘上待人判。
用法: <laya-server>/venv/Scripts/pythonw.exe finetune/night_run.py
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

SVC = Path(__file__).resolve().parents[1]
FT = SVC / "finetune"
REPO = SVC.parents[1]
CKPT = FT / "checkpoint-ft-v1"
CKPT_FLAG = SVC / "active_checkpoint.txt"
KEEPALIVE_TASK = "LayaServerKeepalive"
HEALTHZ = "http://127.0.0.1:8864/healthz"
RESULT = FT / "night_run_result.json"

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
LOG_FH = open(FT / "night_run.log", "ab", buffering=0)


def log(msg: str) -> None:
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    LOG_FH.write((line + "\n").encode("utf-8"))


def _run(cmd: list[str]) -> tuple[int, str]:
    p = subprocess.run(cmd, capture_output=True, text=True,
                       creationflags=0x08000000)
    return p.returncode, (p.stdout or "") + (p.stderr or "")


def _main_python() -> str:
    """主 Python（带 paistation 依赖）：钉死 3.11 绝对路径 > which 回退。"""
    pinned = Path(r"C:\Users\91216\AppData\Local\Programs\Python"
                  r"\Python311\python.exe")
    if pinned.is_file():
        return str(pinned)
    import shutil
    hit = shutil.which("python")
    if hit:
        return hit
    raise RuntimeError("找不到主 Python（paistation 依赖所在）")


def _alive() -> bool:
    try:
        with urllib.request.urlopen(HEALTHZ, timeout=2) as r:
            return json.loads(r.read().decode("utf-8")).get("ok") is True
    except Exception:
        return False


def _vram_used_mb() -> int:
    try:
        p = subprocess.run(["nvidia-smi", "--query-gpu=memory.used",
                            "--format=csv,noheader,nounits"],
                           capture_output=True, text=True,
                           creationflags=0x08000000)
        return int(p.stdout.strip().splitlines()[0])
    except Exception:
        return -1


def main() -> int:
    result: dict = {"started": time.strftime("%Y-%m-%dT%H:%M:%S"), "steps": []}
    try:
        # 1. 停看护
        rc, out = _run(["schtasks", "/Change", "/TN", KEEPALIVE_TASK,
                        "/DISABLE"])
        result["steps"].append({"step": "disable_keepalive", "rc": rc})
        log(f"1. 看护已停 ({rc})")

        # 2. 停服务
        if (SVC / "server.pid").is_file():
            pid = (SVC / "server.pid").read_text().strip()
            if pid:
                _run(["taskkill", "/PID", pid, "/F"])
                log(f"2. server pid={pid} 已杀")
        for _ in range(30):
            if not _alive() and _vram_used_mb() < 2500:
                break
            time.sleep(2)
        log(f"   服务停妥，VRAM={_vram_used_mb()}MB")

        # 3. 全量训练
        env = {**os.environ, "USE_TF": "0", "HF_HUB_OFFLINE": "1",
               "PYTHONIOENCODING": "utf-8"}
        log("3. 全量训练开始（fp32 单卡）...")
        t0 = time.time()
        p = subprocess.run(
            [str(SVC / "venv" / "Scripts" / "python.exe"),
             str(FT / "train.py")],
            cwd=str(FT), env=env, capture_output=True, text=True,
            creationflags=0x08000000)
        result["steps"].append({"step": "train", "rc": p.returncode,
                                "seconds": round(time.time() - t0, 1)})
        log(f"   训练退出码 {p.returncode}，{time.time()-t0:.0f}s")
        (FT / "train_stdout.log").write_text(
            (p.stdout or "") + (p.stderr or ""), encoding="utf-8",
            errors="replace")
        if p.returncode != 0 or not (CKPT / "model.safetensors").is_file():
            raise RuntimeError(f"训练失败 rc={p.returncode}，看日志 train_stdout.log")

        # 4. 切检查点 + 复活服务
        CKPT_FLAG.write_text(str(CKPT), encoding="utf-8")
        rc, out = _run([str(SVC / "venv" / "Scripts" / "pythonw.exe"),
                        str(SVC / "keepalive.py")])
        for _ in range(45):
            if _alive():
                break
            time.sleep(2)
        if not _alive():
            raise RuntimeError("新检查点服务复活失败")
        with urllib.request.urlopen(HEALTHZ, timeout=5) as r:
            hz = json.loads(r.read().decode("utf-8"))
        log(f"4. 服务复活 checkpoint={hz.get('checkpoint')}")
        result["checkpoint"] = hz.get("checkpoint")

        # 5. 回复看护
        _run(["schtasks", "/Change", "/TN", KEEPALIVE_TASK, "/ENABLE"])
        result["steps"].append({"step": "enable_keepalive", "rc": 0})
        log("5. 看护已回复")

        # 6. 回归门（独立目录，零样本基线档不污染）
        env2 = {**os.environ, "PAI_JEV_ENGINE": "laya",
                "LAYA_PARITY_DIR": str(SVC / "parity-ft-v1"),
                "PYTHONIOENCODING": "utf-8"}
        log("6. 回归门重放 E1+E2+E3 ...")
        t0 = time.time()
        p2 = subprocess.run(
            [_main_python(), str(SVC / "parity_gate.py"), "all"],
            cwd=str(REPO), env=env2, capture_output=True, text=True,
            creationflags=0x08000000)
        result["steps"].append({"step": "parity_gate", "rc": p2.returncode,
                                "seconds": round(time.time() - t0, 1)})
        (FT / "parity_stdout.log").write_text(
            (p2.stdout or "") + (p2.stderr or ""), encoding="utf-8",
            errors="replace")
        report_path = SVC / "parity-ft-v1" / "parity_report.json"
        verdicts = {}
        if report_path.is_file():
            rep = json.loads(report_path.read_text(encoding="utf-8"))
            verdicts = {k: v.get("verdict") for k, v in rep.items()
                        if isinstance(v, dict)}
        result["parity_verdicts"] = verdicts
        log(f"   门判: {verdicts}")

        # 7. 保守收口：全 PASS 才留新检查点，否则回官方
        if set(verdicts.values()) == {"PASS"}:
            result["final"] = "ft-active"
            log("7. 全门 PASS——微调检查点在役")
        else:
            CKPT_FLAG.write_text("", encoding="utf-8")
            rc, _ = _run([str(SVC / "venv" / "Scripts" / "pythonw.exe"),
                          str(SVC / "keepalive.py")])
            result["final"] = "reverted-to-multilingual"
            log(f"7. 门未全 PASS——已回官方 multilingual（检查点留盘待人判）")
    except Exception as e:                                  # noqa: BLE001
        result["error"] = f"{type(e).__name__}: {e}"
        log(f"!! {result['error']}")
        # 兜底：确保服务与看护活着（用当前 active_checkpoint 状态）
        _run(["schtasks", "/Change", "/TN", KEEPALIVE_TASK, "/ENABLE"])
        if not _alive():
            _run([str(SVC / "venv" / "Scripts" / "pythonw.exe"),
                  str(SVC / "keepalive.py")])
    finally:
        result["finished"] = time.strftime("%Y-%m-%dT%H:%M:%S")
        RESULT.write_text(json.dumps(result, ensure_ascii=False, indent=1),
                          encoding="utf-8")
        log(f"落档 {RESULT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
