"""B4 金标准增长管线：origin 溯源 + 质量闸防稀释。

每任务可沉淀条目带 origin 溯源（task:<id>/manual/import）；质量闸：
字段校验 + 词面近邻查重（中文 bigram Jaccard，阈值防稀释）。
拒收=不入库；已入库永不删（R 只增不删）。
"""
from __future__ import annotations

import json
from pathlib import Path

_NEAR_DUP_THRESHOLD = 0.70


def _bigrams(text: str) -> set[str]:
    t = "".join(text.split())          # 去空白压紧
    return {t[i:i + 2] for i in range(len(t) - 1)} or ({t} if t else set())


def _unigrams(text: str) -> set[str]:
    return set("".join(text.split()))


def _jaccard(a: set[str], b: set[str]) -> float:
    if not a or not b:
        return 0.0
    return len(a & b) / len(a | b)


def _similarity(q1: str, q2: str) -> float:
    """词面相似度=max(bigram, unigram) Jaccard——单 bigram 对虚词插入不敏感。"""
    return max(_jaccard(_bigrams(q1), _bigrams(q2)),
               _jaccard(_unigrams(q1), _unigrams(q2)))


def _load(path: Path) -> list[dict]:
    if not path.is_file():
        return []
    return [json.loads(x) for x in
            path.read_text(encoding="utf-8").splitlines() if x.strip()]


def add_golden(path: str | Path, q: str, expect_paths: list[str],
               expect_keyword: str, origin: str) -> dict:
    """质量闸+追加。返回 {accepted, reason}。"""
    path = Path(path)
    q = (q or "").strip()
    if not q or not (expect_keyword or "").strip() or not expect_paths:
        return {"accepted": False, "reason": "字段不全：q/expect_paths/"
                "expect_keyword 必须非空"}
    if not origin.strip():
        return {"accepted": False, "reason": "origin 必填（task:<id>/manual/"
                "import）——无溯源不入库"}
    rows = _load(path)
    for row in rows:
        if row.get("q", "").strip() == q:
            return {"accepted": False,
                    "reason": f"重复条目：与「{q[:20]}」完全相同"}
        if _similarity(q, row.get("q", "")) >= _NEAR_DUP_THRESHOLD:
            return {"accepted": False,
                    "reason": f"近邻稀释：与「{row.get('q', '')[:20]}」词面"
                    f"相似度过高"}
    entry = {"q": q, "expect_paths": expect_paths,
             "expect_keyword": expect_keyword.strip(), "origin": origin}
    with path.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(entry, ensure_ascii=False) + "\n")
    return {"accepted": True, "reason": ""}


def growth_report(path: str | Path) -> dict:
    """增长台账：总数+origin 分布（legacy=V3 存量无 origin 字段）。"""
    rows = _load(Path(path))
    by_origin: dict[str, int] = {}
    for row in rows:
        key = row.get("origin") or "legacy"
        by_origin[key] = by_origin.get(key, 0) + 1
    return {"total": len(rows), "by_origin": by_origin}
