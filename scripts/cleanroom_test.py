"""Phase 10 Ralph It3 / M6.9 B 节可自动化部分：干净房验证。

模拟"新机器无 dev 依赖"：产 wheel+离线 wheels → 临时目录建全新 venv
→ 纯离线安装 → 干净房内跑 --version + 六环验收。S3 教训的永久闸：
打包脚本没在干净房实测过就不算完成。

用法：.venv\\Scripts\\python.exe -X utf8 scripts\\cleanroom_test.py
"""
from __future__ import annotations

import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PY = sys.executable
DEPS = ("watchdog", "APScheduler", "tenacity")


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    print("[cleanroom] $", " ".join(str(c) for c in cmd[:6]), "...")
    return subprocess.run([str(c) for c in cmd], capture_output=True,
                          text=True, encoding="utf-8", errors="replace",
                          cwd=str(ROOT), **kw)


def main() -> int:
    print("[cleanroom] 1/5 产 wheel")
    r = run([PY, "-X", "utf8", "-m", "pip", "wheel", "--no-deps",
             "-w", "dist", "."])
    if r.returncode != 0:
        print(r.stdout[-800:], r.stderr[-800:])
        return 1
    wheel = sorted((ROOT / "dist").glob("paistation-*.whl"))[-1]

    print("[cleanroom] 2/5 下载离线依赖 wheels")
    r = run([PY, "-X", "utf8", "-m", "pip", "download", "-q",
             "-d", "setup/wheels", *DEPS])
    if r.returncode != 0:
        print("依赖下载失败（网络）：", r.stderr[-500:])
        return 1

    with tempfile.TemporaryDirectory(prefix="pai-cleanroom-") as tmp:
        venv = Path(tmp) / "venv"
        print("[cleanroom] 3/5 建全新 venv（无任何 dev 依赖）")
        r = run([PY, "-X", "utf8", "-m", "venv", venv])
        if r.returncode != 0:
            print(r.stderr[-500:])
            return 1
        vpy = venv / "Scripts" / "python.exe"

        print("[cleanroom] 4/5 纯离线安装（--no-index）")
        r = run([vpy, "-X", "utf8", "-m", "pip", "install", "--no-index",
                 "--find-links", ROOT / "setup/wheels", *DEPS])
        if r.returncode != 0:
            print(r.stderr[-800:])
            return 1
        r = run([vpy, "-X", "utf8", "-m", "pip", "install", "--no-index",
                 "--no-deps", wheel])
        if r.returncode != 0:
            print(r.stderr[-800:])
            return 1

        print("[cleanroom] 5/5 干净房内验收")
        r = run([vpy, "-X", "utf8", "-m", "paistation", "--version"])
        print("   ", r.stdout.strip() or r.stderr.strip())
        if r.returncode != 0:
            return 1
        r = run([vpy, "-X", "utf8", str(ROOT / "scripts/acceptance_e2e.py")])
        print(r.stdout[-1500:])
        return r.returncode


if __name__ == "__main__":
    code = main()
    print("[cleanroom]", "通过 ✅" if code == 0 else "失败 ❌")
    sys.exit(code)
