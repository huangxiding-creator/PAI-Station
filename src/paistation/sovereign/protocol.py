"""主权携带协议（Phase A2）：export / import / forget / audit。

- export_vault：数据目录 → 完整主权包（markdown 人读视图 + jsonl 机器源 +
  MANIFEST 指纹；被忘决策不随包）。
- import_vault：主权包 → 数据目录（记忆按原时间戳幂等并入、画像按确定性
  id 幂等并入、决策按文件名幂等复制）。
- import_markdown_dir：外部 agent 记忆（如 Claude Code 的 CLAUDE.md 目录）
  → 记忆库（source 打标，可溯源）。
- forget：遗忘权。memory=活动视图剔除+坟墓留全文；profile=双时间线封口
  （可验「已忘且何时忘」）；decision=移入 decisions/forgotten/ 本地留档。
  全部动作写 forgotten.jsonl（只增不删红线兼容：内容进坟墓，不消证据）。
- audit_vault：一页审计报告——完整性指纹、遗忘合规（被忘内容回流必报）、
  画像可证伪性、决策被否方案覆盖率。
"""
from __future__ import annotations

import json
import os
import re
import shutil
from datetime import datetime
from pathlib import Path

from ..profile.model import LAYERS, ProfileModel
from .format import build_manifest, vault_validate
from .vault import MemoryVault, parse_memory

_FRONT = re.compile(r"\A---\s*\n(.*?)\n---", re.DOTALL)


def _vault_dir(data_dir: str | Path) -> Path:
    return Path(data_dir) / "sovereign"


def _append_jsonl(path: Path, record: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "a", encoding="utf-8") as fh:
        fh.write(json.dumps(record, ensure_ascii=False) + "\n")


def _read_jsonl(path: Path) -> list[dict]:
    if not path.is_file():
        return []
    out = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.strip():
            try:
                out.append(json.loads(line))
            except ValueError:
                continue
    return out


# ---- export ----

def _render_profile(data_dir: Path) -> str:
    model = ProfileModel(data_dir)
    entries = model.query()
    if not entries:
        return ""
    lines = ["# 用户画像（主权导出视图）", "",
             f"- 导出时间：{datetime.now().isoformat(timespec='seconds')}",
             f"- 活动条目：{len(entries)}", ""]
    for layer in LAYERS:
        rows = [e for e in entries if e.layer == layer]
        if not rows:
            continue
        lines.append(f"## {layer}")
        for e in rows:
            source = f"，来源 {e.source}" if e.source else ""
            lines.append(f"- {e.key}：{e.value}"
                         f"（置信度 {e.confidence}{source}，"
                         f"自 {e.effective_from}）")
        lines.append("")
    return "\n".join(lines)


def _render_skills_ledger(data_dir: Path) -> str:
    skills_dir = Path(data_dir) / "skills"
    if not skills_dir.is_dir():
        return ""
    rows = []
    for skill in sorted(p for p in skills_dir.iterdir() if p.is_dir()):
        md = skill / "SKILL.md"
        if not md.is_file():
            continue
        meta: dict[str, str] = {}
        match = _FRONT.match(md.read_text(encoding="utf-8",
                                          errors="replace"))
        if match:
            for line in match.group(1).splitlines():
                if ":" in line:
                    key, _, value = line.partition(":")
                    meta[key.strip()] = value.strip()
        files = sum(len(names) for _d, _s, names in os.walk(skill))
        rows.append(json.dumps(
            {"name": meta.get("name") or skill.name,
             "description": meta.get("description", ""),
             "dir": skill.name, "files": files},
            ensure_ascii=False))
    return "\n".join(rows)


def export_vault(data_dir: str | Path, dest: str | Path,
                 clock=None) -> dict:
    data_dir = Path(data_dir)
    dest = Path(dest)
    vdir = _vault_dir(data_dir)
    dest.mkdir(parents=True, exist_ok=True)
    copied = 0
    for name in ("memory.md", "forgotten.jsonl"):
        if (vdir / name).is_file():
            shutil.copy2(vdir / name, dest / name)
            copied += 1
    decisions_src = vdir / "decisions"
    if decisions_src.is_dir():
        (dest / "decisions").mkdir(exist_ok=True)
        for path in sorted(decisions_src.glob("DEC-*.md")):
            shutil.copy2(path, dest / "decisions" / path.name)
            copied += 1
    profile_md = _render_profile(data_dir)
    if profile_md:
        (dest / "profile.md").write_text(profile_md, encoding="utf-8")
        copied += 1
    profile_src = data_dir / "profile" / "entries.jsonl"
    if profile_src.is_file():
        shutil.copy2(profile_src, dest / "profile-entries.jsonl")
        copied += 1
    skills = _render_skills_ledger(data_dir)
    if skills:
        (dest / "skills-ledger.jsonl").write_text(skills, encoding="utf-8")
        copied += 1
    rep = dest / "reputation.jsonl"
    if not rep.exists():
        rep.write_text("", encoding="utf-8")     # 声誉档案 schema 占位
    manifest = build_manifest(dest, clock=clock)
    return {"files": copied, "manifest": manifest}


# ---- import ----

def import_vault(src: str | Path, data_dir: str | Path, merge: bool = True,
                 clock=None) -> dict:
    src = Path(src)
    data_dir = Path(data_dir)
    result = {"memories": 0, "decisions": 0, "profile": 0, "skills": 0}
    if (src / "memory.md").is_file():
        vault = MemoryVault(_vault_dir(data_dir), clock=clock)
        for entry in parse_memory(
                (src / "memory.md").read_text(encoding="utf-8")):
            if vault.restore(entry):
                result["memories"] += 1
    decisions_src = src / "decisions"
    if decisions_src.is_dir():
        target_dir = _vault_dir(data_dir) / "decisions"
        target_dir.mkdir(parents=True, exist_ok=True)
        for path in sorted(decisions_src.glob("DEC-*.md")):
            if not (target_dir / path.name).is_file():
                shutil.copy2(path, target_dir / path.name)
                result["decisions"] += 1
    entries_src = src / "profile-entries.jsonl"
    if entries_src.is_file():
        import hashlib

        model = ProfileModel(data_dir)
        for row in _read_jsonl(entries_src):
            key_material = f"{row.get('layer')}|{row.get('key')}|{row.get('value')}"
            eid = hashlib.sha1(key_material.encode()).hexdigest()[:10]
            if model.get(eid) is None:
                model.record(row.get("layer", ""), row.get("key", ""),
                             row.get("value", ""),
                             confidence=float(row.get("confidence", 0.7)),
                             source=row.get("source", ""))
                result["profile"] += 1
    return result


def import_markdown_dir(src: str | Path, data_dir: str | Path,
                        clock=None) -> int:
    """外部 agent 记忆导入（Claude Code 语义：md 文件即记忆条目）。"""
    src = Path(src)
    files = sorted(src.rglob("*.md")) if src.is_dir() else [src]
    vault = MemoryVault(_vault_dir(data_dir), clock=clock)
    added = 0
    for path in files:
        if not path.is_file():
            continue
        text = path.read_text(encoding="utf-8", errors="replace").strip()
        if not text:
            continue
        before = len(vault.entries())
        vault.remember(text, source=f"claude-code:{path.name}")
        if len(vault.entries()) > before:
            added += 1
    return added


# ---- forget（遗忘权） ----

def forget(data_dir: str | Path, kind: str, target: str, actor: str = "user",
           clock=None) -> dict:
    data_dir = Path(data_dir)
    vdir = _vault_dir(data_dir)
    now = (clock or datetime.now)().isoformat(timespec="seconds")
    tomb_path = vdir / "forgotten.jsonl"
    base = {"ts": now, "actor": actor, "kind": kind, "target": target}
    count = 0
    if kind == "memory":
        vault = MemoryVault(vdir, clock=clock)
        kept, dropped = [], []
        for entry in vault.entries():
            (dropped if target in entry.text else kept).append(entry)
        if dropped:
            vault.rewrite(kept)
            for entry in dropped:
                _append_jsonl(tomb_path, dict(
                    base, snapshot=entry.text, entry_ts=entry.ts,
                    source=entry.source))
            count = len(dropped)
    elif kind == "profile":
        model = ProfileModel(data_dir)
        hits = [e for e in model.query()
                if target in e.key or target in e.value]
        for entry in hits:
            model.expire(entry.id)
            _append_jsonl(tomb_path, dict(
                base, snapshot=f"{entry.layer}|{entry.key}|{entry.value}",
                entry_id=entry.id))
        count = len(hits)
    elif kind == "decision":
        from .vault import DecisionLedger

        ledger = DecisionLedger(vdir / "decisions", clock=clock)
        decision = ledger.get(target)
        if decision is not None:
            graveyard = vdir / "decisions" / "forgotten"
            graveyard.mkdir(parents=True, exist_ok=True)
            os.replace(vdir / "decisions" / f"{target}.md",
                       graveyard / f"{target}.md")
            _append_jsonl(tomb_path, dict(base, snapshot=decision.topic))
            count = 1
    else:
        raise ValueError(f"未知遗忘类别：{kind}")
    return {"forgotten": count}


# ---- audit ----

def audit_vault(data_dir: str | Path, report_path: str | Path | None = None,
                clock=None) -> dict:
    data_dir = Path(data_dir)
    vdir = _vault_dir(data_dir)
    build_manifest(vdir, clock=clock)
    integrity = vault_validate(vdir)

    vault = MemoryVault(vdir, clock=clock)
    active_texts = [e.text for e in vault.entries()]
    from .vault import DecisionLedger

    ledger = DecisionLedger(vdir / "decisions", clock=clock)
    live_decisions = ledger.list_decisions(include_superseded=True)
    model = ProfileModel(data_dir)

    violations: list[dict] = []
    tombs = _read_jsonl(vdir / "forgotten.jsonl")
    for tomb in tombs:
        kind = tomb.get("kind")
        if kind == "memory":
            snapshot = tomb.get("snapshot", "")
            if snapshot and any(snapshot in text or text in snapshot
                                for text in active_texts):
                violations.append({
                    "kind": "memory", "target": tomb.get("target"),
                    "why": "被忘内容仍在活动记忆视图"})
        elif kind == "profile":
            entry = model.get(tomb.get("entry_id", ""))
            if entry is not None and entry.effective_to is None:
                violations.append({
                    "kind": "profile", "target": tomb.get("target"),
                    "why": "被忘画像条目仍为活动状态"})
        elif kind == "decision":
            if tomb.get("target") in {d.id for d in live_decisions}:
                violations.append({
                    "kind": "decision", "target": tomb.get("target"),
                    "why": "被忘决策仍在决策列表"})

    actives = ledger.list_decisions()
    with_alts = sum(1 for d in actives
                    if "否决理由" in ledger.body(d.id))
    report = {
        "integrity": integrity,
        "forget_compliance": {"checked": len(tombs),
                              "violations": violations},
        "profile": {"entries_active": len(model.query()),
                    "with_source": sum(1 for e in model.query() if e.source)},
        "decisions": {"active": len(actives),
                      "superseded": len(live_decisions) - len(actives),
                      "with_alternatives":
                          with_alts / len(actives) if actives else 1.0},
        "forgotten": tombs,
    }
    if report_path:
        Path(report_path).write_text(_render_audit_md(report),
                                     encoding="utf-8")
    return report


def _render_audit_md(report: dict) -> str:
    integ = report["integrity"]
    comp = report["forget_compliance"]
    lines = [
        "# 主权审计报告", "",
        f"- 完整性：{'✅ 通过' if integ['ok'] else '❌ 失败'}"
        f"（篡改 {len(integ['tampered'])} / 缺失 {len(integ['missing'])}"
        f" / 未登记 {len(integ['unmanifested'])}）",
        f"- 遗忘合规：检查 {comp['checked']} 条，违规 "
        f"{len(comp['violations'])} 条",
        f"- 画像：活动 {report['profile']['entries_active']} 条，"
        f"带来源 {report['profile']['with_source']} 条（可证伪性）",
        f"- 决策：活动 {report['decisions']['active']}，"
        f"被推翻 {report['decisions']['superseded']}，"
        f"被否方案覆盖率 {report['decisions']['with_alternatives']:.0%}", "",
        "## 违规明细", "",
    ]
    if comp["violations"]:
        lines += [f"- [{v['kind']}] {v['target']}：{v['why']}"
                  for v in comp["violations"]]
    else:
        lines.append("- 无")
    lines += ["", "## 遗忘日志（坟墓，只增不删）", ""]
    lines += [f"- [{t.get('ts')}] ({t.get('kind')}) {t.get('target')}"
              f" ← 快照：{str(t.get('snapshot'))[:80]}"
              for t in report.get("forgotten", [])]
    return "\n".join(lines) + "\n"
