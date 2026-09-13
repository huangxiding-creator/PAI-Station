"""E4 反退化仪表盘对外版：信息贸易顺差指标（P2 顺差公开方法论）。

顺差=产出 tokens vs 摄入 tokens（meter 账本 intake:*/output:* 前缀分组）。
摄入>产出=逆差（退化警报）；公开方法论=信任获客杠杆。
"""
from __future__ import annotations

import json
from pathlib import Path


def _read_jsonl(path: Path) -> list[dict]:
    if not path.is_file():
        return []
    return [json.loads(x) for x in
            path.read_text(encoding="utf-8").splitlines() if x.strip()]


def _tokens_by_prefix(home: Path, prefix: str) -> int:
    total = 0
    for row in _read_jsonl(home / "control" / "meter.jsonl"):
        if str(row.get("task_id", "")).startswith(prefix):
            total += row.get("tokens", 0)
    return total


def render_dashboard(home: str | Path) -> str:
    home = Path(home)
    intake = _tokens_by_prefix(home, "intake:")
    output = _tokens_by_prefix(home, "output:")
    if output > intake:
        verdict = "顺差 ✅"
    elif intake == 0 and output == 0:
        verdict = "待观测"
    else:
        verdict = "逆差 ⚠️（摄入多产出少=退化警报）"
    return (
        "# 信息贸易顺差仪表盘\n\n"
        f"- 摄入：{intake:,} tokens\n"
        f"- 产出：{output:,} tokens\n"
        f"- 判定：{verdict}\n\n"
        "方法论公开：摄入（采集/阅读）与产出（报告/交付）同账本计量，"
        "顺差=个人认知净值出口。\n"
    )
