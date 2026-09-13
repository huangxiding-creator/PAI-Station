"""Phase A 验收判据③：遗产模式干净房离线实测。

模拟"继承人拿到遗产包，在无 dev 依赖的干净机器上复活资产"：
产 wheel → 全新 venv 纯离线装 → 干净房内全程用 CLI：
  造资产(remember/decide) → heritage 产遗产包 → 换新 data_dir import 复活
  → manifest 校验 + 记忆复活断言。
干净房闸铁律：遗产链路没在干净房跑通就不算完成。

用法：.venv\\Scripts\\python.exe -X utf8 scripts\\heritage_cleanroom.py
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
    print("[heritage-cr] $", " ".join(str(c) for c in cmd[:6]), "...")
    return subprocess.run([str(c) for c in cmd], capture_output=True,
                          text=True, encoding="utf-8", errors="replace",
                          **kw)


def make_config(ini: Path, data_dir: Path) -> str:
    ini.write_text(f"[privacy]\ndata_dir = {data_dir}\n"
                   f"[sense]\nwatch_dirs = {data_dir}\n", encoding="utf-8")
    return str(ini)


def main() -> int:
    print("[heritage-cr] 1/6 产 wheel（含 sovereign）")
    r = run([PY, "-X", "utf8", "-m", "pip", "wheel", "--no-deps",
             "-w", "dist", "."])
    if r.returncode != 0:
        print(r.stdout[-600:], r.stderr[-600:])
        return 1
    wheel = sorted((ROOT / "dist").glob("paistation-*.whl"))[-1]

    wheels_dir = ROOT / "setup" / "wheels"
    if not all(wheels_dir.glob(f"{d.lower()}*") or wheels_dir.glob(f"{d}*")
               for d in ("watchdog", "apscheduler", "tenacity")):
        print("[heritage-cr] 2/6 补离线依赖 wheels")
        r = run([PY, "-X", "utf8", "-m", "pip", "download", "-q",
                 "-d", wheels_dir, *DEPS])
        if r.returncode != 0:
            print("依赖下载失败：", r.stderr[-400:])
            return 1
    else:
        print("[heritage-cr] 2/6 离线依赖 wheels 已齐（跳过下载）")

    with tempfile.TemporaryDirectory(prefix="pai-heir-cr-") as tmp:
        tmp = Path(tmp)
        venv = tmp / "venv"
        print("[heritage-cr] 3/6 建全新 venv")
        if run([PY, "-X", "utf8", "-m", "venv", venv]).returncode != 0:
            return 1
        vpy = venv / "Scripts" / "python.exe"

        r = run([vpy, "-X", "utf8", "-m", "pip", "install", "--no-index",
                 "--find-links", wheels_dir, *DEPS])
        if r.returncode != 0:
            print(r.stderr[-500:])
            return 1
        r = run([vpy, "-X", "utf8", "-m", "pip", "install", "--no-index",
                 "--no-deps", wheel])
        if r.returncode != 0:
            print(r.stderr[-500:])
            return 1

        # ---- 干净房内：原主人造资产 ----
        print("[heritage-cr] 4/6 原主人造资产（remember×2 + decide）")
        home = tmp / "home-data"
        home.mkdir()
        ini = make_config(tmp / "home.ini", home)
        cli = [vpy, "-X", "utf8", "-m", "paistation.main", "--config", ini,
               "--sovereign"]
        for txt in ("遗产干净房验证：常驻城市=北京", "遗产干净房验证：偏好深色主题"):
            if run([*cli, "remember", "--target", txt]).returncode != 0:
                print("remember 失败")
                return 1
        if run([*cli, "decide", "--target", "遗产链路验证", "--chosen",
                "markdown 为源", "--rationale", "人机双读",
                "--alts", '[{"option": "SQLite 为源", "why_rejected": "人不可读"}]']
               ).returncode != 0:
            print("decide 失败")
            return 1

        heir = tmp / "heritage-bundle"
        if run([*cli, "heritage", "--dest", heir,
                "--heir", "继承人"]).returncode != 0:
            print("heritage 产包失败")
            return 1

        # ---- 干净房内：继承人 import 复活 ----
        print("[heritage-cr] 5/6 继承人干净 data_dir 导入复活")
        away = tmp / "heir-data"
        away.mkdir()
        ini2 = make_config(tmp / "heir.ini", away)
        r = run([vpy, "-X", "utf8", "-m", "paistation.main", "--config", ini2,
                 "--sovereign", "import", "--src", heir / "vault"])
        if r.returncode != 0:
            print(r.stdout[-400:], r.stderr[-400:])
            return 1

        print("[heritage-cr] 6/6 断言：manifest 校验 + 资产复活 + 文档在场")
        check = (
            "from pathlib import Path\n"
            "from paistation.sovereign.format import vault_validate\n"
            "from paistation.sovereign.vault import MemoryVault, DecisionLedger\n"
            f"v = vault_validate(Path(r'{away / 'sovereign'}'))\n"
            "assert v['ok'] and not v['missing'] and not v['tampered'], v\n"
            f"mem = [e.text for e in MemoryVault(Path(r'{away / 'sovereign'}')).entries()]\n"
            "assert any('常驻城市' in t for t in mem), mem\n"
            "decs = DecisionLedger(Path(r'%s')).list_decisions()\n"
            "assert any(d.topic == '遗产链路验证' for d in decs), decs\n"
            f"assert (Path(r'{heir / 'OFFLINE.md'}')).is_file()\n"
            f"assert (Path(r'{heir / 'HEIRLOOM.md'}')).is_file()\n"
            "print('HERITAGE-CLEANROOM-OK')\n"
        ) % (away / "sovereign" / "decisions")
        r = run([vpy, "-X", "utf8", "-c", check])
        print(r.stdout.strip())
        if r.returncode != 0 or "HERITAGE-CLEANROOM-OK" not in r.stdout:
            print(r.stdout[-600:], r.stderr[-600:])
            return 1

    print("[heritage-cr] ✅ 遗产模式干净房离线跑通（判据③达成）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
