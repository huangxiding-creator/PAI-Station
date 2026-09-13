"""M5.3 Obsidian 镜像（06 卷）：画像双向同步——人可编辑，编辑可回写。

镜像只写当前有效条目；回写三判：值改→record（旧值自动封口留痕）、
行删→expire（失效不删）、新行→record。用户拥有画像的最终编辑权。
"""
from __future__ import annotations

import re
from pathlib import Path

LAYER_CN = {"identity": "身份事实", "preference": "偏好风格",
            "knowledge": "领域知识", "workflow": "做事流程",
            "achievement": "成果库"}
_LINE = re.compile(
    r"^- \[(?P<id>[0-9a-f]{6,12}|new)\] (?P<key>.+?)："
    r"(?P<value>.+?)（置信(?P<conf>[\d.]+)）\s*$")


class ObsidianMirror:
    def __init__(self, profile, root: str | Path):
        self._profile = profile
        self._dir = Path(root) / "PAI-Profile"

    def _path(self, layer: str) -> Path:
        return self._dir / f"{layer}.md"

    def write(self) -> None:
        self._dir.mkdir(parents=True, exist_ok=True)
        for layer, cn in LAYER_CN.items():
            entries = self._profile.query(layer=layer)
            if not entries:
                continue
            lines = [f"# {cn}", ""]
            for e in entries:
                lines.append(f"- [{e.id}] {e.key}：{e.value}"
                             f"（置信{e.confidence:.1f}）")
            self._path(layer).write_text("\n".join(lines) + "\n",
                                         encoding="utf-8")

    def sync_back(self) -> dict:
        stats = {"updated": 0, "expired": 0, "recorded": 0}
        for layer in LAYER_CN:
            p = self._path(layer)
            if not p.is_file():
                continue
            parsed: dict[str, tuple[str, str, float]] = {}
            for line in p.read_text(encoding="utf-8").splitlines():
                m = _LINE.match(line.strip())
                if m:
                    parsed[m["id"]] = (m["key"], m["value"],
                                       float(m["conf"] or 0.7))
            active = self._profile.query(layer=layer)
            for e in active:
                hit = parsed.pop(e.id, None)
                if hit is None:
                    moved = any(pid == "new" and v[:2] == (e.key, e.value)
                                for pid, v in parsed.items())
                    if not moved:
                        self._profile.expire(e.id)      # 行删=失效
                        stats["expired"] += 1
                elif hit[0] != e.key or hit[1] != e.value:
                    self._profile.record(                # 值改=封旧录新
                        layer=layer, key=hit[0], value=hit[1],
                        confidence=hit[2], source="obsidian-镜像回写")
                    stats["updated"] += 1
            for _pid, (key, value, conf) in parsed.items():  # 剩余=新行
                if any(e.key == key and e.value == value
                       for e in self._profile.query(layer=layer)):
                    continue                              # 同值已存在不重复
                self._profile.record(layer=layer, key=key, value=value,
                                     confidence=conf,
                                     source="obsidian-镜像新增")
                stats["recorded"] += 1
        return stats
