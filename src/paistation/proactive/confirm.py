"""M3.3 确认交互（04 卷）：notify/question/review 三模式+toast+晨报。

三模式裁决：notify=即时 toast（高急迫+预算内）；review=进晨报汇总
（默认出口，一次打扰处理全部）；question=agent 需要用户输入（用户
发起的回环，不受预算限制）。toast 系统缺席/失败绝不阻塞决策。
"""
from __future__ import annotations

import base64
import logging
import subprocess

from paistation.proactive.budget import InterruptionBudget
from paistation.proactive.taskcards import TaskCard, TaskCardStore

_log = logging.getLogger("paistation.proactive.confirm")

_TOAST_PS = r"""
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType=WindowsRuntime] | Out-Null
$t = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
$x = $t.GetElementsByTagName('text')
[void]$x.Item(0).AppendChild($t.CreateTextNode($title))
[void]$x.Item(1).AppendChild($t.CreateTextNode($body))
$n = [Windows.UI.Notifications.ToastNotification]::new($t)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('PAI.Station').Show($n)
"""


class ToastNotifier:
    """Windows toast（PowerShell WinRT，best-effort：失败回 False 不抛）。"""

    def notify(self, title: str, body: str) -> bool:
        try:
            script = _TOAST_PS.replace("$title", repr(title)).replace(
                "$body", repr(body))
            encoded = base64.b64encode(script.encode("utf-16-le")).decode()
            proc = subprocess.run(
                ["powershell", "-NoProfile", "-EncodedCommand", encoded],
                capture_output=True, timeout=10)
            return proc.returncode == 0
        except (OSError, subprocess.SubprocessError) as exc:
            _log.debug("toast 失败（忽略）: %s", exc)
            return False


class RecordingNotifier:
    """测试/审计用假通知器：只记录不打扰。"""

    def __init__(self):
        self.sent: list[dict] = []

    def notify(self, title: str, body: str) -> bool:
        self.sent.append({"title": title, "body": body})
        return True


class ConfirmCenter:
    def __init__(self, notifier=None, store_dir=None,
                 daily_immediate_cap: int = 5):
        self._notifier = notifier or ToastNotifier()
        self._store = TaskCardStore(store_dir)
        self._budget = InterruptionBudget(daily_immediate_cap=daily_immediate_cap)
        self._notified: set[str] = set()

    # ---- 路由：新卡进来决定模式 ----

    def route(self, card: TaskCard) -> str:
        self._store.add(card)
        if card.card_id in self._notified:
            return "review"                # 已即时通知过不重复打扰
        if self._budget.should_notify_now(card):
            self._safe_notify(card.title[:40],
                              f"截止 {card.deadline:%m-%d %H:%M}"
                              if card.deadline else "尽快确认")
            self._notified.add(card.card_id)
            return "notify"
        return "review"

    def ask(self, title: str, body: str = "") -> str:
        """question 模式：执行 agent 需要用户输入时召回用户。"""
        self._safe_notify(title, body)
        return "question"

    # ---- 晨报 ----

    def morning_digest(self) -> str:
        return self._budget.build_digest(self._store.proposed())

    def confirm_by_appearance(self, card_ids: list[str]) -> None:
        for cid in card_ids:
            self._store.confirm(cid)

    def dismiss(self, card_id: str) -> None:
        self._store.dismiss(card_id)

    def get(self, card_id: str) -> TaskCard | None:
        return self._store.get(card_id)

    def _safe_notify(self, title: str, body: str) -> None:
        try:
            self._notifier.notify(title, body)
        except Exception as exc:  # noqa: BLE001 - 通知系统故障不阻塞
            _log.warning("通知失败（忽略）: %s", exc)
