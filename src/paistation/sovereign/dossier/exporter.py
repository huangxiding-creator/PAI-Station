# -*- coding: utf-8 -*-
"""P0 主权卷宗·导出器：一条命令出人可读自包含包。

DISRUPTION_PLAN P0 验收：导出包在无 PAI-Station 的机器上人可读可 grep。
包形态（全 markdown/YAML/jsonl 明文，零依赖零锁定）：
  dest/
    DOSSIER.md  README.md  vault 各节 + evidence 物化全文 + MANIFEST.json
MANIFEST 指纹复用 sovereign/format.py 规范（sha256 防篡改）。
"""
from __future__ import annotations

import shutil
from datetime import datetime
from pathlib import Path

from ..format import build_manifest
from .build import build_dossier


def export_dossier(data_dir: str | Path, dest: str | Path, *,
                   self_profile_dir: str | Path | None = None,
                   eval_sources: list[Path] | None = None,
                   clock=None) -> dict:
    dest = Path(dest)
    if dest.exists():
        raise FileExistsError(f"导出目标已存在（不覆盖）：{dest}")
    report = build_dossier(Path(data_dir), dest / "vault",
                           self_profile_dir=(Path(self_profile_dir)
                                             if self_profile_dir else None),
                           eval_sources=eval_sources, clock=clock)
    _materialize_evidence(Path(self_profile_dir) if self_profile_dir
                          else Path(data_dir).parent / "SELF_PROFILE",
                          dest / "vault" / "evidence")
    (dest / "README.md").write_text(_readme(report), encoding="utf-8")
    manifest = build_manifest(dest, clock=clock)
    return {"dest": str(dest), "build": report,
            "files": len(manifest["files"])}


def _materialize_evidence(self_profile_dir: Path, evidence_dir: Path) -> int:
    """evidence/INDEX.md 编目 → 物化全文副本（导出包自包含）。"""
    n = 0
    for report in sorted(self_profile_dir.glob("*.md")) if self_profile_dir.is_dir() else []:
        shutil.copyfile(report, evidence_dir / report.name)
        n += 1
    return n


def _readme(report: dict) -> str:
    return f"""\
# 主权卷宗导出包

这是持有人的数字资产包（画像/记忆/评测/证据），全明文，无加密、无锁定、
无电话回家。在任何机器上：人可直接阅读，grep 可全文检索，新 agent 可导入。

- 生成时间：{report['generated_at']}
- 画像条目 {report['profile']} / 记忆 {report['memory']} / 评测 {report['evals']} 行 / 证据 {report['evidence']} 份

## 目录

- `vault/DOSSIER.md` — 卷宗总览与读法
- `vault/profile/` — 五层画像（YAML frontmatter，双时间线）
- `vault/memory/` — 记忆库转录
- `vault/evals/` — 金标准评测资产
- `vault/evidence/` — 证据报告全文
- `MANIFEST.json` — 全部文件 sha256 指纹（校验完整性）

## 完整性校验

装有 PAI-Station 的机器：`python -m paistation.sovereign.dossier verify <本包>`。
其他环境：按 MANIFEST.json 逐文件 sha256 自校。
"""
