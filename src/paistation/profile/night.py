"""M5.2 夜间整理窗口（06 卷/R13）：事件流→画像提案（永不自批）。

夜间窗口（22:00-06:00）跑三件：①高频主题→knowledge 提案；②高频
动作→workflow 提案；③陈旧条目→失效提案。产出 proposals 带
approved=False——上岗走晨报一键确认（R15：进化提案永不自批，
hooks 强制不靠提示自觉），apply() 只落 approved 项。
"""
from __future__ import annotations

import re
from datetime import datetime, timedelta

ACTION_TERMS = ("调研", "归档", "汇总", "整理", "提交", "汇报", "复盘",
                "核价", "评审", "谈判")
_CJK_RUN = re.compile(r"[一-龥]{4,}")


class NightConsolidator:
    def __init__(self, profile, min_mentions: int = 3,
                 min_actions: int = 2, stale_days: int = 30):
        self._profile = profile
        self._min_mentions = min_mentions
        self._min_actions = min_actions
        self._stale_days = stale_days

    def should_run(self, now: datetime | None = None) -> bool:
        now = now or datetime.now()
        return now.hour >= 22 or now.hour < 6

    # ---- 提案 ----

    def run(self, events: list[dict]) -> list[dict]:
        now = datetime.now()
        proposals: list[dict] = []
        proposals += self._topic_proposals(events)
        proposals += self._action_proposals(events)
        proposals += self._stale_proposals(now)
        return proposals

    def _topic_proposals(self, events: list[dict]) -> list[dict]:
        texts = [(e.get("ts", ""), e.get("text") or "")
                 for e in events if e.get("text")]
        counts: dict[str, int] = {}
        evidence: dict[str, list[str]] = {}
        for ts, text in texts:
            for n in (4, 5, 6, 7, 8):
                seen: set[str] = set()
                for i in range(len(text) - n + 1):
                    gram = text[i:i + n]
                    if not re.fullmatch(r"[一-龥]+", gram):
                        continue
                    if gram not in seen:          # 每事件至多计一次
                        seen.add(gram)
                        counts[gram] = counts.get(gram, 0) + 1
                        evidence.setdefault(gram, []).append(ts)
        qualified = {g: c for g, c in counts.items() if c >= self._min_mentions}
        # 合并重叠 n-gram → 最长短语
        merged: list[tuple[str, int]] = []
        for gram in sorted(qualified, key=len, reverse=True):
            if not any(gram in kept for kept, _ in merged):
                merged.append((gram, qualified[gram]))
        out = []
        for term, c in merged[:10]:
            out.append({"kind": "knowledge", "layer": "knowledge",
                        "key": term, "value": f"近期高频主题（{c} 次提及）",
                        "confidence": min(0.5 + 0.1 * c, 0.9),
                        "evidence": evidence[term][:10], "approved": False})
        return out

    def _action_proposals(self, events: list[dict]) -> list[dict]:
        texts = [e.get("text") or "" for e in events if e.get("text")]
        out = []
        for term in ACTION_TERMS:
            c = sum(1 for t in texts if term in t)
            if c >= self._min_actions:
                out.append({"kind": "workflow", "layer": "workflow",
                            "key": f"高频动作：{term}",
                            "value": f"用户近期执行「{term}」{c} 次，"
                                     "执行代理可预载对应技能",
                            "confidence": min(0.5 + 0.1 * c, 0.9),
                            "evidence": [], "approved": False})
        return out

    def _stale_proposals(self, now: datetime) -> list[dict]:
        if self._profile is None:
            return []
        out = []
        for e in self._profile.query():
            try:
                created = datetime.fromisoformat(e.created_at)
            except (ValueError, TypeError):
                continue
            if now - created > timedelta(days=self._stale_days):
                out.append({"kind": "expire", "entry_id": e.id, "layer": e.layer,
                            "key": e.key, "value": e.value,
                            "confidence": 0.6, "evidence": [],
                            "approved": False})
        return out

    # ---- 晨报确认后落库 ----

    def apply(self, proposals: list[dict]) -> int:
        n = 0
        for p in proposals:
            if not p.get("approved"):
                continue
            if p["kind"] == "expire":
                self._profile.expire(p["entry_id"])
            else:
                self._profile.record(
                    layer=p["layer"], key=p["key"], value=p["value"],
                    confidence=p.get("confidence", 0.7),
                    source=f"night:{len(p.get('evidence', []))}条证据")
            n += 1
        return n
