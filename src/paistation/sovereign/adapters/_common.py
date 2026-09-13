"""适配器共享读取：画像摘要 / 记忆条目 / 活动决策（单一来源，三向复用）。"""
from __future__ import annotations

from pathlib import Path

from ...profile.model import LAYERS, ProfileModel
from ..vault import DecisionLedger, MemoryVault


def profile_rows(data_dir: str | Path) -> list[tuple[str, str, str]]:
    """[(layer, key, value)] 仅活动条目，按层序排列。"""
    model = ProfileModel(data_dir)
    return [(e.layer, e.key, e.value) for layer in LAYERS
            for e in model.query(layer=layer)]


def memory_entries(data_dir: str | Path):
    return MemoryVault(Path(data_dir) / "sovereign").entries()


def active_decisions(data_dir: str | Path):
    ledger = DecisionLedger(Path(data_dir) / "sovereign" / "decisions")
    return ledger.list_decisions()


def first_line(text: str) -> str:
    return text.splitlines()[0] if text else ""


def render_identity_md(data_dir: str | Path, *, title: str) -> str:
    """三向通用的画像+关键决策 markdown（适配器的正文骨架）。"""
    lines = [f"# {title}", "", "## 用户画像", ""]
    rows = profile_rows(data_dir)
    if rows:
        last_layer = None
        for layer, key, value in rows:
            if layer != last_layer:
                lines += [f"### {layer}", ""]
                last_layer = layer
            lines.append(f"- {key}：{value}")
    else:
        lines.append("_暂无画像条目_")
    lines += ["", "## 关键决策（含被否方案，勿重提旧路）", ""]
    decisions = active_decisions(data_dir)
    if decisions:
        lines += [f"- {d.topic}（{d.id}）" for d in decisions]
    else:
        lines.append("_暂无决策记录_")
    return "\n".join(lines) + "\n"
