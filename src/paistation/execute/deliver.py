"""M4.2 交付：成果落 08 成果/+回执 jsonl+通知（企微升级位）。

成果是唯一对用户可见的产出（D4 成果计价的地基）：按日落档、
标题净化防路径注入、回执可审计（谁/何时/交付到哪/多少字）、
通知 best-effort 绝不反噬交付本身。
"""
from __future__ import annotations

import json
import logging
import os
import re
import urllib.request
from datetime import datetime
from pathlib import Path

_log = logging.getLogger("paistation.execute.deliver")

_BAD_CHARS = re.compile(r'[\\/:*?"<>|\r\n，。；！？、\s]+')


class WeComNotifier:
    """企微群机器人 webhook（url 来自配置/环境，best-effort）。"""

    def __init__(self, webhook_url: str = ""):
        self._url = webhook_url

    def notify(self, title: str, body: str) -> bool:
        if not self._url:
            return False
        try:
            data = json.dumps({"msgtype": "text",
                               "text": {"content": f"{title}\n{body}"[:2000]}}
                              ).encode("utf-8")
            req = urllib.request.Request(self._url, data=data, method="POST",
                                         headers={"Content-Type":
                                                  "application/json"})
            with urllib.request.urlopen(req, timeout=10):
                return True
        except (OSError, ValueError) as exc:
            _log.debug("企微通知失败（忽略）: %s", exc)
            return False


class RecordingNotifier:
    def __init__(self):
        self.sent: list[dict] = []

    def notify(self, title: str, body: str) -> bool:
        self.sent.append({"title": title, "body": body})
        return True


class Deliverer:
    def __init__(self, root: str | Path, notifier=None):
        self._root = Path(root)
        self._notifier = notifier  # None=静默交付

    def deliver(self, card, content: str) -> Path:
        day = datetime.now()
        safe = _BAD_CHARS.sub("_", card.title).strip("_")[:40] or "未命名任务"
        folder = self._root / "08 成果"
        folder.mkdir(parents=True, exist_ok=True)
        path = folder / f"{day:%Y-%m-%d}_{safe}.md"
        deadline_note = (f"截止 {card.deadline:%Y-%m-%d %H:%M}"
                         if card.deadline else "无截止")
        header = (f"# {card.title}\n\n"
                  f"> 任务卡 `{card.card_id}`｜{deadline_note}")
        path.write_text(f"{header}\n\n{content}\n", encoding="utf-8")
        self._receipt(card, path, content, day)
        if self._notifier:
            try:
                self._notifier.notify(f"交付：{card.title[:30]}", str(path))
            except Exception as exc:  # noqa: BLE001 - 通知故障不反噬交付
                _log.warning("交付通知失败（忽略）: %s", exc)
        _log.info("已交付 %s -> %s", card.card_id, path)
        return path

    def _receipt(self, card, path: Path, content: str, day: datetime) -> None:
        rdir = self._root / "deliveries"
        rdir.mkdir(parents=True, exist_ok=True)
        rec = {"ts": day.isoformat(timespec="milliseconds"),
               "card_id": card.card_id, "title": card.title,
               "artifact": str(path), "chars": len(content)}
        with open(rdir / "receipts.jsonl", "a", encoding="utf-8") as fh:
            fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
