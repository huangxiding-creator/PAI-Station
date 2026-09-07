"""入库管道（提案 4.2 sense→memory）：guard 只读 → fast 摘要 → store 落库。

LLM 输出要求 JSON{title,summary,score}；解析失败降级为规则摘要（首行截断），
永不因模型抖动丢数据。越界文件由 FileGuard 拒绝并留痕，不读不调不落库。
"""
import logging
import os

from ..llm.zhipu_client import extract_json

_log = logging.getLogger("paistation.sense.ingest")

_PROMPT = (
    "请为以下文件生成 JSON：{\"title\": \"不超过20字标题\", "
    "\"summary\": \"80字内摘要\", \"score\": 0到1的相关度分数，"
    "个人工作文档/知识笔记打高分，临时草稿打低分}。只输出 JSON。")


class Ingester:
    """单文件/批量入库：fast(json_mode) 摘要 + FTS5 落库。"""

    def __init__(self, client, guard, store, max_chars: int = 6000):
        self._client = client
        self._guard = guard
        self._store = store
        self._max_chars = max_chars

    def ingest_file(self, path: str) -> dict:
        try:
            real = self._guard.check(path)
        except Exception as exc:  # 越界：拒而不读
            return {"ok": False, "path": path, "reason": f"guard: {exc}"}
        try:
            text = self._guard.read_text(real)
        except Exception as exc:
            return {"ok": False, "path": path, "reason": f"read: {exc}"}
        title, summary, score = self._summarize(real, text)
        stat = os.stat(real)
        self._store.upsert(path=real, title=title, summary=summary, score=score,
                           size=stat.st_size, mtime=stat.st_mtime)
        return {"ok": True, "path": real, "title": title, "score": score}

    def ingest_batch(self, paths: list) -> list:
        results = []
        for p in paths:
            if not os.path.exists(p):
                results.append({"ok": False, "path": p, "reason": "missing"})
                continue
            results.append(self.ingest_file(p))
        return results

    def _summarize(self, path: str, text: str) -> tuple[str, str, float]:
        try:
            r = self._client.fast(_PROMPT, context=text[: self._max_chars],
                                  json_mode=True)
            data = extract_json(r["text"]) or {}
            title = str(data.get("title") or "")[:40]
            summary = str(data.get("summary") or "")[:200]
            score = _clamp(data.get("score"))
            if title and summary:
                return title, summary, score
        except Exception as exc:
            _log.warning("LLM 摘要失败，降级规则摘要 %s: %s", path, exc)
        return self._rule_summary(path, text)

    @staticmethod
    def _rule_summary(path: str, text: str) -> tuple[str, str, float]:
        lines = [ln.strip() for ln in text.splitlines() if ln.strip()]
        title = (lines[0][:40] if lines else os.path.basename(path))
        summary = " ".join(lines)[:200] or "(空文件)"
        return title, summary, 0.5


def _clamp(value) -> float:
    try:
        return max(0.0, min(1.0, float(value)))
    except (TypeError, ValueError):
        return 0.5
