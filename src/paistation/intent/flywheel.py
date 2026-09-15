"""M7c 纠正飞轮：晨报修正 → 样本库 → ICL 注入（SummAct 路线，ICL 先于微调）。

方法论栈第⑥层。三级用法：
  1. note_correction  晨报一键修正时入库（错判 vs 金标）
  2. build_icl        修正样本 → few-shot 文本，注入 L2 prompt
  3. 样本库 jsonl 只增不删（Git 留痕口径），坏行跳过不炸
微调位（>500 样本后）留给 M8+，先用 ICL 吃复利。
"""
from __future__ import annotations

import json
from pathlib import Path


class IntentSampleStore:
    """(块摘要, 金标判读) 对的 jsonl 追加库。"""

    def __init__(self, path: str | Path):
        self._path = Path(path)

    def add(self, block: dict, gold: str, wrong: str = "") -> dict:
        row = {"ts": str(block.get("start") or block.get("end") or ""),
               "digest": _digest(block), "gold": gold, "wrong": wrong}
        self._path.parent.mkdir(parents=True, exist_ok=True)
        with self._path.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(row, ensure_ascii=False) + "\n")
        return row

    def recent(self, n: int = 8) -> list[dict]:
        """最近 n 条（新→旧）；坏行跳过（缺席不崩）。"""
        if not self._path.is_file():
            return []
        rows = []
        try:
            lines = self._path.read_text(encoding="utf-8").splitlines()
        except OSError:
            return []
        for line in lines:
            line = line.strip()
            if not line:
                continue
            try:
                obj = json.loads(line)
            except ValueError:
                continue
            if isinstance(obj, dict) and obj.get("gold"):
                rows.append(obj)
        return list(reversed(rows[-n:]))


def note_correction(store: IntentSampleStore, block: dict,
                    wrong: str, gold: str) -> dict:
    """晨报修正落库：错判与金标都留（错判用于回溯分析）。"""
    return store.add(block, gold=gold, wrong=wrong)


def build_icl(store: IntentSampleStore, n: int = 8) -> str:
    """修正样本 → few-shot 注入文本；空库返回空串。"""
    rows = store.recent(n)
    if not rows:
        return ""
    lines = ["[历史修正示例]（用户纠正过的活动判读，判读时优先对齐）"]
    for r in rows:
        wrong = f"（曾误判: {r['wrong']}）" if r.get("wrong") else ""
        lines.append(f"记录: {r['digest']}{wrong}")
        lines.append(f"正确判读: {r['gold']}")
    return "\n".join(lines)


def _digest(block: dict) -> str:
    titles = block.get("titles") or [""]
    parts = [titles[0], block.get("process") or ""]
    return " | ".join(p for p in parts if p)[:200]
