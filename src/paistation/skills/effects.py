"""M6.5 技能效果跟踪+回滚（FR10b）：批准≠终点——跟踪实际效果、反馈、一键回滚。

每次技能使用记 effects.jsonl；滚动窗口（最近 10 次）成功率对比基线，
劣化超阈值且样本充分 → 产出「建议回滚」任务卡（走晨报确认，不自作主张）；
一键回滚=git checkout 上一 tag + 基线重置（回滚后以新现状为准，不刷屏）。
"""
from __future__ import annotations

import json
from datetime import datetime
from pathlib import Path

WINDOW = 10          # 滚动窗口
MIN_SAMPLES = 5      # 样本不足不武断
DEGRADE = 0.15       # 劣化阈值


class EffectTracker:
    """record→suggest_rollbacks→rollback（回滚即恢复+基线重置）。"""

    def __init__(self, data_dir: str | Path, repo):
        self._dir = Path(data_dir)
        self._repo = repo
        self._effects = self._dir / "effects.jsonl"
        self._baseline_path = self._dir / "effects_baseline.json"

    # ---- 记录 ----

    def record(self, skill: str, success: bool, task: str = "") -> None:
        self._dir.mkdir(parents=True, exist_ok=True)
        with self._effects.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps({
                "ts": datetime.now().isoformat(timespec="seconds"),
                "skill": skill, "success": bool(success), "task": task},
                ensure_ascii=False) + "\n")

    def _records(self) -> list[dict]:
        if not self._effects.is_file():
            return []
        return [json.loads(ln) for ln in
                self._effects.read_text(encoding="utf-8").splitlines()
                if ln.strip()]

    # ---- 基线 ----

    def set_baseline(self, skill: str, rate: float) -> None:
        baselines = self._load_baselines()
        baselines[skill] = round(float(rate), 3)
        self._baseline_path.write_text(
            json.dumps(baselines, ensure_ascii=False, indent=1),
            encoding="utf-8")

    def _load_baselines(self) -> dict[str, float]:
        if not self._baseline_path.is_file():
            return {}
        try:
            return json.loads(self._baseline_path.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            return {}

    def rate(self, skill: str, window: int = WINDOW) -> tuple[float, int]:
        recent = [r for r in self._records() if r.get("skill") == skill]
        recent = recent[-window:]
        if not recent:
            return (0.0, 0)
        hits = sum(1 for r in recent if r.get("success"))
        return (round(hits / len(recent), 3), len(recent))

    # ---- 建议（产出任务卡形状，走晨报确认） ----

    def suggest_rollbacks(self) -> list[dict]:
        out = []
        for skill, baseline in self._load_baselines().items():
            rate, n = self.rate(skill)
            if n < MIN_SAMPLES:
                continue
            if rate < baseline - DEGRADE:
                tags = self._repo.tags(skill)
                out.append({
                    "kind": "rollback_suggestion", "skill": skill,
                    "rate": rate, "baseline": baseline, "samples": n,
                    "previous_tag": tags[-2] if len(tags) >= 2 else None,
                    "title": f"建议回滚技能「{skill}」：成功率 "
                             f"{rate:.0%} 低于基线 {baseline:.0%}",
                    "source": "skills.effects"})
        return out

    # ---- 一键回滚 ----

    def rollback(self, skill: str) -> bool:
        tags = self._repo.tags(skill)
        if len(tags) < 2:
            return False                    # 无旧版可回
        self._repo.rollback(skill, tags[-2])
        rate, _ = self.rate(skill)
        self.set_baseline(skill, rate)      # 基线重置：以回滚后现状为准
        return True
