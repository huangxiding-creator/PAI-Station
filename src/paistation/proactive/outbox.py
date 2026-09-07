"""推送发件箱（提案 4.2 proactive）：预算 + 勿扰 + 成果抽屉。

三闸门：①quiet_hours 勿扰（支持跨午夜）②max_push_per_day 每日预算
（失败发送不占预算）③静默消息全部落入成果抽屉（retention_days 清理）。
状态持久化到 JSON 文件，跨实例共享预算。
"""
import json
import logging
import os
import time

_log = logging.getLogger("paistation.proactive.outbox")


def _normalize_quiet(quiet_hours) -> tuple[str, str]:
    """接受 ("22:00","07:00") 或 C.1 单串 "22:00-07:00"。"""
    if isinstance(quiet_hours, str):
        parts = quiet_hours.split("-")
        if len(parts) == 2:
            return parts[0].strip(), parts[1].strip()
        raise ValueError(f"quiet_hours 格式非法：{quiet_hours}（应为 HH:MM-HH:MM）")
    if len(quiet_hours) == 2:
        return quiet_hours[0], quiet_hours[1]
    raise ValueError(f"quiet_hours 应为 2 元素或 'HH:MM-HH:MM'，得到 {quiet_hours}")


def _minutes(now) -> int:
    """datetime 与 time.struct_time 通吃的当日分钟数。"""
    if hasattr(now, "tm_hour"):
        return now.tm_hour * 60 + now.tm_min
    return now.hour * 60 + now.minute


def _in_quiet(now, quiet_hours) -> bool:
    start_s, end_s = quiet_hours
    minutes = _minutes(now)
    start = _hhmm(start_s)
    end = _hhmm(end_s)
    if start <= end:  # 同日区间
        return start <= minutes < end
    return minutes >= start or minutes < end  # 跨午夜（如 23:00-07:00）


def _hhmm(text: str) -> int:
    h, m = text.strip().split(":")
    return int(h) * 60 + int(m)


class Outbox:
    """主动推送唯一出口：push(channel, title, body)。"""

    def __init__(self, max_push_per_day: int, quiet_hours: tuple,
                 state_path: str, now_fn=None, retention_days: int = 7):
        self._max = int(max_push_per_day)
        self._quiet = _normalize_quiet(quiet_hours)
        self._path = state_path
        self._now = now_fn or (lambda: time.localtime())
        self._retention_days = retention_days
        self._sent_dates: list[str] = []
        self._drawer: list[dict] = []
        self._load()

    # ---------- 状态持久化 ----------

    def _load(self):
        try:
            with open(self._path, encoding="utf-8") as f:
                data = json.load(f)
            self._sent_dates = list(data.get("sent_dates", []))
            self._drawer = list(data.get("drawer", []))
        except (OSError, ValueError):
            pass  # 首次运行或损坏：从零开始

    def _save(self):
        parent = os.path.dirname(os.path.abspath(self._path))
        os.makedirs(parent, exist_ok=True)
        tmp = self._path + ".tmp"
        with open(tmp, "w", encoding="utf-8") as f:
            json.dump({"sent_dates": self._sent_dates[-50:],
                       "drawer": self._drawer[-500:]}, f, ensure_ascii=False)
        os.replace(tmp, self._path)

    # ---------- 判定 ----------

    def _today(self) -> str:
        now = self._now()
        return f"{now.tm_year:04d}-{now.tm_mon:02d}-{now.tm_mday:02d}" \
            if hasattr(now, "tm_year") else now.strftime("%Y-%m-%d")

    def _sent_today(self) -> int:
        return self._sent_dates.count(self._today())

    def _block_reason(self) -> str | None:
        now = self._now()
        if _in_quiet(now, self._quiet):
            return f"勿扰时段 {self._quiet[0]}-{self._quiet[1]}"
        if self._sent_today() >= self._max:
            return f"今日预算已用尽（{self._sent_today()}/{self._max}）"
        return None

    # ---------- 出口 ----------

    def push(self, channel, title: str, body: str) -> dict:
        reason = self._block_reason()
        if reason:
            self._to_drawer(title, body, f"held: {reason}")
            return {"delivered": False, "reason": reason}
        result = channel.send(title, body)
        if result.get("ok"):
            self._sent_dates.append(self._today())
            self._save()
            return {"delivered": True, "result": result}
        self._to_drawer(title, body, f"send failed: {result.get('errmsg')}")
        return {"delivered": False, "reason": f"发送失败：{result.get('errmsg')}"}

    def _to_drawer(self, title: str, body: str, why: str):
        now = self._now()
        ts = time.mktime(now) if hasattr(now, "tm_year") else now.timestamp()
        self._drawer.append({"title": title, "body": body, "why": why, "ts": ts})
        self._save()

    def drawer(self) -> list[dict]:
        return [dict(d) for d in self._drawer]

    def cleanup(self, older_than_days: int | None = None) -> int:
        days = self._retention_days if older_than_days is None else older_than_days
        cutoff = time.time() - days * 86400
        before = len(self._drawer)
        self._drawer = [d for d in self._drawer if d.get("ts", 0) >= cutoff]
        removed = before - len(self._drawer)
        if removed:
            self._save()
            _log.info("抽屉清理 %d 条（>%d 天）", removed, days)
        return removed

    def stats(self) -> dict:
        return {"today_sent": self._sent_today(),
                "max_per_day": self._max,
                "drawer_items": len(self._drawer)}
