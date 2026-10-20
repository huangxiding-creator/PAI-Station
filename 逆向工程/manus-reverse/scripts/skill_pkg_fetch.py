# -*- coding: utf-8 -*-
"""拉取 .skill 包 (S3 签名直链) 并解包 SKILL.md."""
from __future__ import annotations

import json
import sys
import tarfile
import time
import urllib.request
import zipfile
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

HERE = Path(__file__).resolve().parent
SK = HERE.parent / "live" / "skills"
PKG = SK / "_pkg"
PKG.mkdir(exist_ok=True)
PROXY = {"http": "http://127.0.0.1:7890", "https": "http://127.0.0.1:7890"}


def fetch(url: str, dest: Path) -> bool:
    op = urllib.request.build_opener(urllib.request.ProxyHandler(PROXY))
    try:
        r = op.open(url, timeout=60)
        dest.write_bytes(r.read())
        return True
    except Exception as e:
        print(f"  fetch EXC {type(e).__name__}: {str(e)[:60]}")
        return False


def unpack(pkg: Path, out: Path):
    try:
        if zipfile.is_zipfile(pkg):
            with zipfile.ZipFile(pkg) as z:
                z.extractall(out)
                return "zip"
        with tarfile.open(pkg) as t:
            t.extractall(out)
            return "tar"
    except Exception as e:
        return f"EXC {type(e).__name__}"


def main():
    n = ok = 0
    for jf in sorted(SK.glob("*.json")):
        if jf.name.startswith("_"):
            continue
        d = json.loads(jf.read_text(encoding="utf-8"))
        name = d["skill"]["name"]
        url = (d.get("downloadInfo") or {}).get("downloadUrl")
        if not url:
            print(f"- {name}: 无 downloadUrl")
            continue
        n += 1
        pkg = PKG / f"{name}.skill"
        if fetch(url, pkg):
            kind = unpack(pkg, PKG / name)
            md = list((PKG / name).rglob("SKILL.md"))
            size = md[0].stat().st_size if md else 0
            print(f"✓ {name}: {pkg.stat().st_size}B pkg, unpack={kind}, SKILL.md={size}B")
            ok += 1
        time.sleep(1.0)
    print(f"=== {ok}/{n} packages ===")


if __name__ == "__main__":
    main()
