"""AstrBot 适配器：persona_prompt.md（人设系统提示）+ memories.md。

中国个人 AI 最大实际载体是 IM 侧挂（AstrBot 40.4k★，08 路调研）；
persona_prompt 可直接贴进 AstrBot 人设配置，memories.md 作为长期记忆
参考文档。
"""
from __future__ import annotations

from pathlib import Path

from ._common import memory_entries, profile_rows


def export(data_dir: str | Path, dest: str | Path, clock=None) -> dict:
    dest = Path(dest)
    dest.mkdir(parents=True, exist_ok=True)
    rows = profile_rows(data_dir)
    by_key = {key: value for _layer, key, value in rows}
    name = by_key.get("称呼", "用户")
    lines = [f"你是{name}的个人助理。", "", "## 已知画像", ""]
    lines += [f"- {key}：{value}" for _layer, key, value in rows]
    lines += ["", "## 行为准则", "",
              "- 沿用上述偏好与身份事实，不确定时先问再做。",
              "- 决策相关记忆见 memories.md（含被否方案，勿重提旧路）。"]
    (dest / "persona_prompt.md").write_text("\n".join(lines) + "\n",
                                            encoding="utf-8")
    entries = memory_entries(data_dir)
    mem = ["# 记忆", ""] + [
        f"- [{e.ts}] {e.text.replace(chr(10), ' / ')}" for e in entries]
    (dest / "memories.md").write_text("\n".join(mem) + "\n",
                                      encoding="utf-8")
    return {"memories": len(entries)}


def validate(dest: str | Path) -> bool:
    persona = Path(dest) / "persona_prompt.md"
    return (persona.is_file()
            and "个人助理" in persona.read_text(encoding="utf-8"))
