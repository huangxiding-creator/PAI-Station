# -*- coding: utf-8 -*-
"""qw_tcb_prep.py — 云托管部署准备：staging 目录 + 新 EnvParams JSON（virtual_pay.secret 更新版）。
输出: staging/ 与 data/state/qianwen_tcb_envparams.json（含密钥，data/ 不进 git）。"""
import base64
import json
import shutil
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SRC = Path(r"E:\AI-Station\services\qianwen-engine")
FONTS = Path(r"E:\AI-Station\data\qianwen\fonts")
SECRETS = Path(r"E:\AI-Station\data\secrets")
STAGE = Path(r"E:\AI-Station\data\state\qw_deploy_stage_1007")
ENVP_OUT = Path(r"E:\AI-Station\data\state\qianwen_tcb_envparams.json")
TCB = r"C:\Users\91216\AppData\Roaming\npm\tcb.cmd"


def tcb(*args):
    r = subprocess.run([TCB, *args], capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=120,
                       env={**__import__("os").environ, "PYTHONIOENCODING": "utf-8"})
    return r.stdout + (("\n[stderr]" + r.stderr) if r.stderr.strip() else "")


def main():
    # [1] staging
    if STAGE.exists():
        shutil.rmtree(STAGE)
    (STAGE / "fonts").mkdir(parents=True)
    for f in ("Dockerfile", "docker-entrypoint.sh", "requirements.txt"):
        shutil.copy2(SRC / f, STAGE / f)
    pkg = STAGE / "qianwen_engine"
    pkg.mkdir()
    n_py = 0
    for p in sorted((SRC / "qianwen_engine").rglob("*.py")):
        if "__pycache__" in p.parts:
            continue
        dst = pkg / p.relative_to(SRC / "qianwen_engine")
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(p, dst)
        n_py += 1
    n_font = 0
    for pat in ("NotoSansSC-*.otf", "simhei.ttf"):
        for p in sorted(FONTS.glob(pat)):
            shutil.copy2(p, STAGE / "fonts" / p.name)
            n_font += 1
    print(f"staged: {n_py} py, {n_font} fonts, at {STAGE}")

    # [2] 拉当前 EnvParams（fresh）
    raw = tcb("cloudrun", "detail", "-s", "qianwen-engine", "--json")
    j = raw[raw.find("{"): raw.rfind("}") + 1]
    detail = json.loads(j)
    sc = (detail.get("data") or {}).get("ServerConfig")
    if not sc:
        print("FAIL: no ServerConfig in detail:", raw[:400])
        return 1
    envp = json.loads(sc["EnvParams"])
    print("env keys:", sorted(envp.keys()))

    # [3] 替换 virtual_pay.secret
    vp = (SECRETS / "virtual_pay.secret").read_bytes()
    files = json.loads(base64.b64decode(envp["SECRET_FILES_B64"]))
    print("secret files on server:", sorted(files.keys()))
    files["virtual_pay.secret"] = base64.b64encode(vp).decode()
    envp["SECRET_FILES_B64"] = base64.b64encode(
        json.dumps(files, ensure_ascii=False).encode()).decode()
    ENVP_OUT.write_text(json.dumps(envp, ensure_ascii=False), encoding="utf-8")
    # 校验回读（值不打印）
    rt = json.loads(base64.b64decode(
        json.loads(ENVP_OUT.read_text(encoding="utf-8"))["SECRET_FILES_B64"]))
    assert base64.b64decode(rt["virtual_pay.secret"]) == vp, "roundtrip"
    has_offer = b"offer_id=1450664233" in vp
    has_pid = b"product_id=unlock_once" in vp
    print(f"new vp secret: offer_id={has_offer} product_id={has_pid} "
          f"sandbox_key={'sandbox_appkey=' in str(rt)} files_n={len(rt)}")
    print(f"envparams json -> {ENVP_OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
