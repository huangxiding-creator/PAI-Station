"""主权格式规范（Phase A1）：vault 布局 + MANIFEST 指纹 + 完整性校验。

规范 v1.0（SOVEREIGN_SPEC_VERSION）：
- vault 根必需文件：memory.md（记忆库）、MANIFEST.json（清单）
- 可选：decisions/DEC-*.md（决策记忆）、forgotten.jsonl（遗忘日志）、
  profile.md（画像渲染）、skills-ledger.jsonl、reputation.jsonl
- MANIFEST.json 登记除自身外全部文件的 sha256 指纹；
  vault_validate 检出：缺文件 / 指纹失配（篡改）/ 未登记新文件。
"""
from __future__ import annotations

import hashlib
import json
import os
from datetime import datetime
from pathlib import Path

SOVEREIGN_SPEC_VERSION = "1.0"
REQUIRED_FILES = ("memory.md", "MANIFEST.json")


def file_sha256(path: str | Path) -> str:
    digest = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(65536), b""):
            digest.update(chunk)
    return f"sha256:{digest.hexdigest()}"


def _iter_files(root: Path):
    """vault 内全部受管文件（MANIFEST 自身除外），相对路径用 / 分隔。"""
    if not root.is_dir():
        return
    for path in sorted(root.rglob("*")):
        if path.is_file() and path.name != "MANIFEST.json":
            yield path.relative_to(root).as_posix(), path


def build_manifest(vault_dir: str | Path, clock=None) -> dict:
    """重算并写入 MANIFEST.json（原子写），返回清单。"""
    root = Path(vault_dir)
    now = (clock or datetime.now)().isoformat(timespec="milliseconds")
    files = {rel: file_sha256(path) for rel, path in _iter_files(root)}
    manifest = {"spec": SOVEREIGN_SPEC_VERSION, "generated_at": now,
                "files": files}
    out = root / "MANIFEST.json"
    root.mkdir(parents=True, exist_ok=True)
    tmp = out.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(manifest, ensure_ascii=False, indent=2),
                   encoding="utf-8")
    os.replace(tmp, out)
    return manifest


def vault_validate(vault_dir: str | Path) -> dict:
    """完整性校验：{spec, ok, missing, tampered, unmanifested}。"""
    root = Path(vault_dir)
    report: dict = {"spec": SOVEREIGN_SPEC_VERSION, "ok": False,
                    "missing": [], "tampered": [], "unmanifested": []}
    for name in REQUIRED_FILES:
        if not (root / name).is_file():
            report["missing"].append(name)
    if report["missing"]:
        return report
    try:
        manifest = json.loads(
            (root / "MANIFEST.json").read_text(encoding="utf-8"))
    except (OSError, ValueError):
        report["tampered"].append("MANIFEST.json")
        return report
    declared = manifest.get("files", {})
    for rel, fingerprint in declared.items():
        path = root / rel
        if not path.is_file():
            report["missing"].append(rel)
        elif file_sha256(path) != fingerprint:
            report["tampered"].append(rel)
    for rel, _path in _iter_files(root):
        if rel not in declared:
            report["unmanifested"].append(rel)
    report["ok"] = not (report["missing"] or report["tampered"]
                        or report["unmanifested"])
    return report
