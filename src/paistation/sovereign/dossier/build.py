# -*- coding: utf-8 -*-
"""P0 主权卷宗·构建器：三源统一 OKF 目录形态。

源 → 卷宗树（DISRUPTION_PLAN P0：SELF_PROFILE+记忆层+金标准统一）：
  profile/<layer>/<id>.md   ← profile/entries.jsonl 五层条目（双时间线保留）
  memory/<n>-<ts>.md        ← sovereign MemoryVault 转录（append-only 快照）
  evals/*.jsonl + INDEX.md  ← 金标准评测资产（复制入卷=永不贬值资产归位）
  evidence/INDEX.md         ← SELF_PROFILE 报告群编目（路径+sha256，导出时物化）
  DOSSIER.md                总览（各源计数+生成时间+读法）
构建为快照式：卷宗=v0 镜像视图；「卷宗为主索引为辅」的翻转在后续阶段渐进。
"""
from __future__ import annotations

import hashlib
import json
import shutil
from datetime import datetime
from pathlib import Path

from ..vault import MemoryVault
from .entries import OkfEntry, write_entry

SECTION_README = {
    "profile": "五层画像（identity/preference/knowledge/workflow/achievement），"
               "一条目一文件；effective_to 为空=当前有效，双时间线全程可溯。",
    "memory": "记忆库转录（append-only 快照）；正文为原始记忆文本。",
    "evals": "金标准评测资产（模型越强越值钱的资产层）。",
    "evidence": "证据报告编目（SELF_PROFILE 画像报告群）；导出包内物化为全文。",
}


def _slug(ts: str) -> str:
    return ts.replace(":", "").replace("-", "").replace("T", "-").replace(".", "-")


def _sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(65536), b""):
            digest.update(chunk)
    return digest.hexdigest()


def build_profile(src_jsonl: Path, out: Path, clock=None) -> int:
    """profile entries.jsonl → profile/<layer>/<id>.md（源缺省=空节）。"""
    if not src_jsonl.is_file():
        return 0
    count = 0
    for line in src_jsonl.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        e = json.loads(line)
        meta = {"id": e["id"], "kind": "profile", "layer": e["layer"],
                "key": e.get("key", ""), "created": e.get("created_at", ""),
                "effective_from": e.get("effective_from", ""),
                "effective_to": e.get("effective_to"),
                "confidence": e.get("confidence", 0.7),
                "source": e.get("source", "")}
        write_entry(out / e["layer"] / f"{e['id']}.md",
                    OkfEntry(meta=meta, body=e.get("value", "")))
        count += 1
    return count


def build_memory(vault_dir: Path, out: Path) -> int:
    """MemoryVault → memory/<n>-<ts>.md（源缺省=空节）。"""
    if not (vault_dir / "memory.md").is_file():
        return 0
    vault = MemoryVault(vault_dir)
    count = 0
    for i, entry in enumerate(vault.entries(), start=1):
        meta = {"id": f"mem-{i:05d}", "kind": "memory",
                "created": entry.ts, "source": entry.source,
                "tags": list(entry.tags)}
        write_entry(out / f"{i:05d}-{_slug(entry.ts)}.md",
                    OkfEntry(meta=meta, body=entry.text))
        count += 1
    return count


def build_evals(sources: list[Path], out: Path) -> int:
    """金标准 jsonl 复制 + evals/INDEX.md。"""
    count = 0
    index = ["# 评测资产索引", ""]
    out.mkdir(parents=True, exist_ok=True)
    for src in sources:
        if not src.is_file():
            continue
        dest = out / src.name
        shutil.copyfile(src, dest)
        n = sum(1 for ln in dest.read_text(encoding="utf-8").splitlines()
                if ln.strip())
        count += n
        index.append(f"- `{src.name}` — {n} 行，sha256 `{_sha256_file(dest)[:16]}…`")
    (out / "INDEX.md").write_text("\n".join(index) + "\n", encoding="utf-8")
    return count


def build_evidence(self_profile_dir: Path, out: Path) -> int:
    """SELF_PROFILE 报告群编目（md 报告路径+指纹；导出时物化）。"""
    index = ["# 证据报告编目", "", "本体在 SELF_PROFILE/；导出包内为全文副本。", ""]
    reports = sorted(self_profile_dir.glob("*.md")) if self_profile_dir.is_dir() else []
    for p in reports:
        index.append(f"- `{p.name}` — {p.stat().st_size} B，"
                     f"sha256 `{_sha256_file(p)[:16]}…`")
    out.mkdir(parents=True, exist_ok=True)
    (out / "INDEX.md").write_text("\n".join(index) + "\n", encoding="utf-8")
    return len(reports)


def build_dossier(data_dir: Path, dest: Path, *,
                  self_profile_dir: Path | None = None,
                  eval_sources: list[Path] | None = None,
                  clock=None) -> dict:
    """一键构建卷宗树。data_dir=运行数据根（含 profile/、sovereign vault）。"""
    now = (clock or datetime.now)().isoformat(timespec="seconds")
    report = {"generated_at": now, "profile": 0, "memory": 0,
              "evals": 0, "evidence": 0}
    report["profile"] = build_profile(
        data_dir / "profile" / "entries.jsonl", dest / "profile")
    report["memory"] = build_memory(data_dir / "sovereign", dest / "memory")
    report["evals"] = build_evals(eval_sources or [], dest / "evals")
    report["evidence"] = build_evidence(
        self_profile_dir or (data_dir.parent / "SELF_PROFILE"),
        dest / "evidence")
    overview = ["# Sovereign Dossier（主权卷宗）", "",
                f"- 生成时间：{now}",
                f"- 画像条目：{report['profile']}（五层/双时间线）",
                f"- 记忆条目：{report['memory']}（append-only）",
                f"- 评测资产：{report['evals']} 行（金标准）",
                f"- 证据报告：{report['evidence']} 份（SELF_PROFILE）", "",
                "## 读法", ""]
    for key in ("profile", "memory", "evals", "evidence"):
        overview.append(f"- `{key}/` {SECTION_README[key]}")
    overview += ["", "> 卷宗归持有人所有；任何 agent（含 PAI-Station）只是访客。", ""]
    (dest / "DOSSIER.md").write_text("\n".join(overview), encoding="utf-8")
    return report
