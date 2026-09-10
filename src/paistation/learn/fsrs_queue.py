"""FSRS 练习队列（提案第 23 章 T14）：py-fsrs + 工作产物出卡 + 每日 3 张。

间隔重复把"产品学到的"变成"用户记住的"——共同成长引擎的用户侧轨道。
每日上限 3 张（防退化机制：教学入预算，不强灌）。
"""
import json
import os
from datetime import UTC, datetime

from fsrs import Card, Rating, Scheduler

_RATINGS = {1: Rating.Again, 2: Rating.Hard, 3: Rating.Good, 4: Rating.Easy}


class FsrsQueue:
    """出卡/到期/复习三操作；卡片持久化 JSON（fsrs Card 字段序列化）。"""

    def __init__(self, json_path: str, daily_limit: int = 3,
                 now_fn=lambda: datetime.now(UTC)):
        self._path = json_path
        self._limit = daily_limit
        self._now = now_fn
        self._sched = Scheduler()
        parent = os.path.dirname(os.path.abspath(json_path))
        os.makedirs(parent, exist_ok=True)
        try:
            with open(self._path, encoding="utf-8") as fh:
                self._cards = json.load(fh).get("cards", [])
        except (OSError, ValueError):
            self._cards = []

    def _save(self) -> None:
        with open(self._path, "w", encoding="utf-8") as fh:
            json.dump({"cards": self._cards}, fh, ensure_ascii=False, indent=1)

    def add(self, front: str, back: str, source: str = "",
            retention: float | None = None) -> str:
        """工作产物自动出卡：立即到期（首练当天）。

        retention：分档目标记忆率（B2——概念卡 0.9 / 行动卡 0.8）。
        不传则沿用默认 Scheduler（0.9），且不写键（向后兼容旧 JSON）。
        """
        card = Card()
        card.due = self._now()  # 尊重注入时钟（py-fsrs 默认用真实 now，测试会随日期漂移）
        entry = {"id": str(card.card_id), "front": front, "back": back,
                 "source": source, "reps": 0,
                 "fsrs": card.to_dict()}
        if retention is not None:
            entry["retention"] = float(retention)
        self._cards.append(entry)
        self._save()
        return entry["id"]

    def due_cards(self) -> list[dict]:
        """今日到期（含逾期），按到期时间升序，截断到每日上限。"""
        now = self._now()
        due = []
        for entry in self._cards:
            due_at = datetime.fromisoformat(entry["fsrs"]["due"])
            if due_at <= now:
                due.append((due_at, entry))
        due.sort(key=lambda kv: kv[0])
        return [{k: v for k, v in entry.items() if k != "fsrs"}
                for _, entry in due[:self._limit]]

    def review(self, card_id: str, rating: int) -> dict:
        """复习一张：1 Again / 2 Hard / 3 Good / 4 Easy → FSRS 重排期。

        分档卡按各自 desired_retention 调度（每卡一个 Scheduler 视图）；
        ReviewLog 落库（rating/时间），未来可喂 fsrs-rs Optimizer 重训个人曲线。
        """
        if rating not in _RATINGS:
            raise ValueError(f"rating 应为 1-4，收到 {rating}")
        for entry in self._cards:
            if entry["id"] == str(card_id):
                card = Card.from_dict(entry["fsrs"])
                sched = (Scheduler(desired_retention=entry["retention"])
                         if "retention" in entry else self._sched)
                card, log = sched.review_card(card, _RATINGS[rating])
                entry["fsrs"] = card.to_dict()
                entry["reps"] = entry.get("reps", 0) + 1
                duration = log.review_duration
                seconds = (duration.total_seconds()
                           if hasattr(duration, "total_seconds") else duration)
                entry.setdefault("logs", []).append({
                    "rating": int(log.rating),
                    "review_datetime": log.review_datetime.isoformat(),
                    "review_duration": seconds,
                })
                self._save()
                return {"due": card.due.isoformat(),
                        "stability": round(card.stability, 3)}
        raise KeyError(f"未知卡片 id: {card_id}")

    def stats(self) -> dict:
        return {"total": len(self._cards),
                "repped": sum(1 for c in self._cards if c.get("reps", 0) > 0),
                "daily_limit": self._limit}
