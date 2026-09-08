"""注意力账本（提案第 24 章①第二注意力）：替你看世界的 ROI 门槛。

每条打扰决策都记账（递进/挡掉），账本可证明两件事：
- ROI 门槛：value_est / (duration + 打扰成本) 低于线的一律挡
- 分辨力 ≥10:1：递进的价值均值 ≥ 挡掉的 10 倍——挡对了，不是挡一切
"""
import json
import os
import time

_MIN_ROI = 0.5


def roi_gate(value_est: float, duration_min: float, disturb_cost_min: float,
             min_roi: float = _MIN_ROI) -> bool:
    """ROI 门槛：价值 /（时长+打扰成本）≥ 线才放行。"""
    cost = duration_min + disturb_cost_min
    if cost <= 0:
        return value_est > 0
    return value_est / cost >= min_roi


class AttentionLedger:
    """打扰决策账本：递进/挡掉各归其位，落盘 JSON 可审计。"""

    def __init__(self, json_path: str, now_fn=time.time):
        self._path = json_path
        self._now = now_fn
        parent = os.path.dirname(os.path.abspath(json_path))
        os.makedirs(parent, exist_ok=True)
        self._records = self._load()

    def _load(self) -> list:
        try:
            with open(self._path, encoding="utf-8") as fh:
                data = json.load(fh)
            return data.get("records", []) if isinstance(data, dict) else []
        except (OSError, ValueError):
            return []

    def _append(self, kind: str, topic: str, value_est: float,
                duration_min: float, disturb_cost_min: float) -> None:
        self._records.append({
            "ts": self._now(), "kind": kind, "topic": topic,
            "value_est": float(value_est),
            "duration_min": float(duration_min),
            "disturb_cost_min": float(disturb_cost_min)})
        self._save()

    def _save(self) -> None:
        with open(self._path, "w", encoding="utf-8") as fh:
            json.dump({"records": self._records}, fh, ensure_ascii=False, indent=1)

    def record_delivered(self, topic: str, value_est: float,
                         duration_min: float, disturb_cost_min: float) -> None:
        self._append("delivered", topic, value_est, duration_min,
                     disturb_cost_min)

    def record_blocked(self, topic: str, value_est: float,
                       duration_min: float, disturb_cost_min: float) -> None:
        self._append("blocked", topic, value_est, duration_min,
                     disturb_cost_min)

    def stats(self) -> dict:
        delivered = [r["value_est"] for r in self._records
                     if r["kind"] == "delivered"]
        blocked = [r["value_est"] for r in self._records
                   if r["kind"] == "blocked"]
        avg = lambda xs: round(sum(xs) / len(xs), 2) if xs else 0.0  # noqa: E731
        return {"delivered": len(delivered), "blocked": len(blocked),
                "delivered_avg_value": avg(delivered),
                "blocked_avg_value": avg(blocked)}

    def discrimination(self) -> float:
        """分辨力：递进均值 / 挡掉均值（挡掉为 0 时视为 ∞ → 返回大数）。"""
        s = self.stats()
        if s["blocked_avg_value"] == 0:
            return float(s["delivered_avg_value"] > 0) * 1e9
        return round(s["delivered_avg_value"] / s["blocked_avg_value"], 2)

    def weekly_summary(self) -> str:
        """本周 5 件事：递进价值 Top5 + 挡掉统计（诚实：空账本照实说）。"""
        week_ago = self._now() - 7 * 86400
        recent = [r for r in self._records if r["ts"] >= week_ago]
        delivered = sorted((r for r in recent if r["kind"] == "delivered"),
                           key=lambda r: -r["value_est"])[:5]
        blocked = sum(1 for r in recent if r["kind"] == "blocked")
        lines = ["本周替你递进的 5 件事："]
        if delivered:
            lines += [f"{i}. {r['topic']}（价值 {r['value_est']:g}）"
                      for i, r in enumerate(delivered, 1)]
        else:
            lines.append("（本周暂无递进——没有值得打扰你的事，这本身是好事）")
        lines.append(f"挡掉 {blocked} 次低价值打扰"
                     f"（分辨力 {self.discrimination():g}:1）")
        return "\n".join(lines)
