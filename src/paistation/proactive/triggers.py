"""事件触发器（提案 4.6 L5）：文件/日历/IM/周期四源 → JTBD 候选任务。

每个候选 {"job", "source", "evidence", "importance", "urgency",
"urgency_hint"}；噪声（desktop.ini 等系统文件）在源头过滤。
纯规则起步——LLM 升级位留接口（deep_fn 注入即增强），缺席不崩。
"""
import os

_IMPORTANT_KEYWORDS = ("投标", "合同", "评审", "客户", "deadline", "截止", "周报",
                       "汇报", "方案")
_URGENT_KEYWORDS = ("今天", "立即", "马上", "urgent", " ASAP ".lower(), "急")


class TriggerEngine:
    """四源事件 → JTBD 候选任务列表。"""

    def __init__(self, ignore_patterns: tuple = ("desktop.ini", "thumbs.db"),
                 deep_fn=None):
        self._ignore = tuple(p.lower() for p in ignore_patterns)
        self._deep = deep_fn

    @staticmethod
    def _base(job: str, source: str, evidence: str) -> dict:
        return {"job": job, "source": source, "evidence": evidence,
                "importance": 0.5, "urgency": 0.3, "urgency_hint": 0.0}

    def _boost(self, item: dict, text: str) -> dict:
        """关键词信号 → 重要度/紧急度提升（不可变：返回新 dict）。"""
        important = any(k in text for k in _IMPORTANT_KEYWORDS)
        urgent = any(k in text for k in _URGENT_KEYWORDS)
        return {**item,
                "importance": min(0.9, item["importance"] + (0.3 if important else 0)),
                "urgency": min(0.95, item["urgency"] + (0.4 if urgent else 0))}

    def on_file(self, event: dict) -> list[dict]:
        path = event.get("path", "")
        if not path or os.path.basename(path).lower() in self._ignore:
            return []
        item = self._boost(
            self._base(f"跟进文档变化：{os.path.basename(path)}",
                       "file", path), path)
        return [item]

    def on_im(self, event: dict) -> list[dict]:
        text = event.get("text", "")
        if not text.strip():
            return []
        item = self._boost(
            self._base(f"回应 IM 消息（{event.get('channel', 'im')}）",
                       "im", text[:80]), text)
        return [item]

    def on_calendar(self, event: dict) -> list[dict]:
        minutes = max(0, int(event.get("in_minutes", 60)))
        urgency_hint = 1.0 if minutes <= 15 else (0.8 if minutes <= 60 else 0.3)
        item = self._base(f"准备日程：{event.get('event', '日程')}",
                          "calendar", str(event.get("event", ""))[:80])
        return [{**item, "urgency": max(item["urgency"], urgency_hint),
                 "urgency_hint": urgency_hint,
                 "importance": 0.7}]

    def on_periodic(self, kind: str, hour: int) -> list[dict]:
        if kind == "daily" and 8 <= hour < 11:
            return [self._base("回顾昨日产出与今日三件事", "periodic", f"daily@{hour}")]
        if kind == "weekly":
            return [self._base("整理本周成果与下周计划", "periodic", "weekly")]
        return []
