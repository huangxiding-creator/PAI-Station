"""M3.1 任务卡抽取（04 卷）：规则引擎默认+LLM 升级位+证据指针。

从统一事件流抽"责任人+动作+截止+证据指针"任务卡（ARCHITECTURE
数据契约二）。规则引擎保证零依赖零成本可测；`llm` 参数留升级位
（本地 LLM 夜间批处理替换/增强抽取，接口不变）。
"""
from __future__ import annotations

import hashlib
import json
import os
import re
from dataclasses import asdict, dataclass, field
from datetime import datetime, timedelta
from pathlib import Path

WEEKDAYS = {"一": 0, "二": 1, "三": 2, "四": 3, "五": 4,
            "六": 5, "日": 6, "天": 6}
_CJK_DIGITS = {"一": 1, "二": 2, "三": 3, "四": 4, "五": 5,
               "六": 6, "七": 7, "八": 8, "九": 9}
# 动作标记：命中其一才值得建卡（闲聊零误报优先于高召回）
ACTION_MARKERS = ("请", "帮我", "麻烦", "别忘了", "记得", "需要", "让",
                  "提交", "发我", "发给", "整理", "归档", "调研", "跟进",
                  "确认", "汇总", "落实", "要结果", "审核", "评审后")
FILLERS = ("你好", "对了", "顺便说下", "请", "帮我", "麻烦你", "麻烦",
           "记得", "别忘了", "有空的时候")


def _cjk_num(s: str) -> int:
    if s.isdigit():
        return int(s)
    if s == "十":
        return 10
    if "十" in s:
        left, _, right = s.partition("十")
        return (_CJK_DIGITS.get(left, 1) if left else 1) * 10 + (
            _CJK_DIGITS.get(right, 0) if right else 0)
    return _CJK_DIGITS.get(s, 0)


def parse_deadline(text: str, now: datetime | None = None) -> datetime | None:
    """中文截止时间解析：相对日/星期/月日+时段/钟点，解析不出回 None。"""
    now = now or datetime.now()
    day: datetime.date | None = None
    m = re.search(r"(\d{1,2})\s*月\s*(\d{1,2})\s*[号日]", text)
    if m:
        month, dnum = int(m.group(1)), int(m.group(2))
        year = now.year if (month, dnum) >= (now.month, now.day) else now.year + 1
        try:
            day = datetime(year, month, dnum).date()
        except ValueError:
            return None
    else:
        m = re.search(r"(\d{1,2})\s*[号日](?!\d)", text)
        if m:
            dnum = int(m.group(1))
            if 1 <= dnum <= 31:
                try:
                    cand = datetime(now.year, now.month, dnum).date()
                    if dnum < now.day:  # 本月已过→下月
                        nxt = (datetime(now.year, now.month, 28)
                               + timedelta(days=6))
                        cand = datetime(nxt.year, nxt.month, dnum).date()
                    day = cand
                except ValueError:
                    return None
        elif "大后天" in text:
            day = (now + timedelta(days=3)).date()
        elif "后天" in text:
            day = (now + timedelta(days=2)).date()
        elif "明天" in text or "明早" in text or "明晚" in text:
            day = (now + timedelta(days=1)).date()
        elif "今天" in text or "今晚" in text:
            day = now.date()
        else:
            mw = re.search(r"(下)?(?:周|星期)([一二三四五六日天])", text)
            if mw:
                target = WEEKDAYS[mw.group(2)]
                if mw.group(1):  # 下周X：锚定下周一
                    to_mon = (7 - now.weekday()) % 7 or 7
                    day = (now + timedelta(days=to_mon + target)).date()
                else:            # 本周最近的周X
                    delta = (target - now.weekday()) % 7 or 7
                    day = (now + timedelta(days=delta)).date()
    if day is None:
        return None
    # 钟点
    hour: int | None = None
    minute = 0
    mt = re.search(r"([一二三四五六七八九十]{1,2}|\d{1,2})\s*[点时]\s*(半)?",
                   text)
    if mt:
        hour = _cjk_num(mt.group(1))
        if mt.group(2):
            minute = 30
    evening = any(w in text for w in ("今晚", "明晚", "晚上", "傍晚"))
    afternoon = "下午" in text or "午后" in text
    morning = any(w in text for w in ("上午", "早上", "早晨", "明早"))
    if hour is None:
        if "下班" in text:
            hour = 18
        elif evening:
            hour = 20
        else:
            hour = 9 if (morning or True) else 9  # 无钟点默认早九
    elif (evening or afternoon) and hour < 12:
        hour += 12
    if not (0 <= hour <= 23):
        hour = 9
    return datetime(day.year, day.month, day.day, hour, minute)


def _bigrams(s: str) -> set[str]:
    t = re.sub(r"[，。？！、\s]", "", s)
    return {t[i:i + 2] for i in range(len(t) - 1)}


def _similar(a: str, b: str) -> bool:
    ga, gb = _bigrams(a), _bigrams(b)
    if not ga or not gb:
        return False
    return len(ga & gb) / len(ga | gb) >= 0.30


def _owner_of(text: str) -> str:
    m = re.search(r"让([一-龥]{1,3}?)(?:把|将|去|来|负责|帮忙|整理|提交|发)",
                  text)
    if m:
        return m.group(1)
    m = re.match(r"^([一-龥]{1,4})[，,]", text)  # 呼语开头：小王，…
    if m and m.group(1) not in (
            "你好", "哈喽", "喂", "各位", "大家", "那个", "所以", "然后",
            "但是", "另外", "对了", "好的", "那么", "嗯", "呃", "哦"):
        return m.group(1)
    return "user"


def _title_from(text: str) -> str:
    clauses = [c for c in re.split(r"[。！？；]", text) if c.strip()]
    marked = [c for c in clauses if any(k in c for k in ACTION_MARKERS)]
    pick = marked[0] if marked else (clauses[0] if clauses else text)
    # 截掉礼貌前缀（对 ，/、 分号也切一道）
    segs = re.split(r"[，,]", pick)
    segs = [s for s in segs if any(k in s for k in ACTION_MARKERS)] or segs
    title = "，".join(segs) if len(segs) > 1 else segs[0]
    changed = True
    while changed and title:
        changed = False
        for f in FILLERS:
            if title.startswith(f):
                title = title[len(f):].lstrip("，,。 ")
                changed = True
    return title.strip()[:48] or text.strip()[:48]


@dataclass
class TaskCard:
    title: str
    owner: str = "user"
    deadline: datetime | None = None
    confidence: float = 0.5
    status: str = "proposed"        # proposed/confirmed/dismissed/done
    source: str = "voice"
    evidence: dict = field(default_factory=dict)
    mentions: int = 1
    created_at: str = ""
    card_id: str = ""

    def __post_init__(self):
        if not self.card_id:
            key = re.sub(r"\s+", "", f"{self.owner}|{self.title}")[:40]
            self.card_id = hashlib.sha1(key.encode("utf-8")).hexdigest()[:10]
        if not self.created_at:
            self.created_at = datetime.now().isoformat(timespec="milliseconds")

    def to_dict(self) -> dict:
        d = asdict(self)
        d["deadline"] = self.deadline.isoformat() if self.deadline else None
        return d

    @classmethod
    def from_dict(cls, d: dict) -> TaskCard:
        ddl = d.get("deadline")
        d = dict(d)
        d["deadline"] = datetime.fromisoformat(ddl) if ddl else None
        return cls(**d)


def extract_task_cards(events: list[dict], llm=None,
                       now: datetime | None = None) -> list[TaskCard]:
    """事件流→任务卡。llm 升级位：给 callable(prompt_events)→list[dict] 时
    由其产出候选，本函数仍负责校验/去重/证据接线（缝合怪律：交接显式）。"""
    now = now or datetime.now()
    raw = events if llm is None else _llm_candidates(events, llm)
    cards: list[TaskCard] = []
    for ev in raw:
        text = (ev.get("text") or "").strip()
        if not text or not any(k in text for k in ACTION_MARKERS):
            continue
        title = _title_from(text)
        if not title or not any(k in title for k in ACTION_MARKERS):
            # 标题清洗丢了标记（如纯呼语句），退整句重试一次
            title = _title_from(text.replace("，", ""))
            if not any(k in title for k in ACTION_MARKERS):
                continue
        deadline = parse_deadline(text, now)
        owner = _owner_of(text)
        conf = 0.5
        if deadline:
            conf += 0.2
        if "请" in text or "帮我" in text or "麻烦" in text:
            conf += 0.15
        if "别忘了" in text or "记得" in text:
            conf += 0.1
        if deadline and "要结果" in text:
            conf += 0.05
        card = TaskCard(
            title=title, owner=owner, deadline=deadline,
            confidence=min(round(conf, 2), 0.95), source=ev.get("source", "mic"),
            evidence={"ts": ev.get("ts", ""),
                      "audio_hash": (ev.get("evidence") or {}).get("audio_hash", ""),
                      "segment_ms": (ev.get("evidence") or {}).get("segment_ms", [])},
        )
        dup = next((c for c in cards if c.owner == card.owner
                    and _similar(c.title, card.title)), None)
        if dup:  # 同型重提=置信度证据，不重复建卡
            dup.mentions += 1
            dup.confidence = min(round(dup.confidence + 0.1, 2), 0.95)
            if card.deadline and (not dup.deadline or card.deadline < dup.deadline):
                dup.deadline = card.deadline
        else:
            cards.append(card)
    return cards


def _llm_candidates(events: list[dict], llm) -> list[dict]:
    """LLM 升级位适配：把 LLM 产出的候选伪装回事件形状进入同一管线。"""
    try:
        out = llm([e for e in events if e.get("text")])
        return out if isinstance(out, list) else []
    except Exception:  # noqa: BLE001 - LLM 故障退规则
        return [e for e in events if e.get("text")]


class TaskCardStore:
    """任务卡落盘（tasks.json 原子写）；data_dir=None 时纯内存。"""

    def __init__(self, data_dir: str | Path | None):
        self._path = (Path(data_dir) / "tasks.json") if data_dir else None
        self._cards: dict[str, TaskCard] = {}
        if self._path and self._path.is_file():
            try:
                raw = json.loads(self._path.read_text(encoding="utf-8"))
                self._cards = {k: TaskCard.from_dict(v)
                               for k, v in raw.items()}
            except (OSError, ValueError, TypeError):
                self._cards = {}

    def add(self, card: TaskCard) -> None:
        old = self._cards.get(card.card_id)
        if old:  # 重抽合并：保最新置信度与最早截止
            old.mentions = max(old.mentions, card.mentions)
            old.confidence = max(old.confidence, card.confidence)
            if card.deadline and (not old.deadline or card.deadline < old.deadline):
                old.deadline = card.deadline
        else:
            self._cards[card.card_id] = card
        self._save()

    def get(self, card_id: str) -> TaskCard | None:
        return self._cards.get(card_id)

    def all(self) -> list[TaskCard]:
        return list(self._cards.values())

    def proposed(self) -> list[TaskCard]:
        return [c for c in self._cards.values() if c.status == "proposed"]

    def confirmed(self) -> list[TaskCard]:
        return [c for c in self._cards.values() if c.status == "confirmed"]

    def _set_status(self, card_id: str, status: str) -> None:
        card = self._cards.get(card_id)
        if card:
            card.status = status
            self._save()

    def confirm(self, card_id: str) -> None:
        self._set_status(card_id, "confirmed")

    def dismiss(self, card_id: str) -> None:
        self._set_status(card_id, "dismissed")

    def done(self, card_id: str) -> None:
        self._set_status(card_id, "done")

    def _save(self) -> None:
        if not self._path:
            return
        self._path.parent.mkdir(parents=True, exist_ok=True)
        tmp = self._path.with_suffix(".tmp")
        tmp.write_text(
            json.dumps({k: c.to_dict() for k, c in self._cards.items()},
                       ensure_ascii=False, indent=1),
            encoding="utf-8")
        os.replace(tmp, self._path)
