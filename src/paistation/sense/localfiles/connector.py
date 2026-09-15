"""P4 接入层：LocalFilesConnector —— M2.6 CloudConnector 同构。

与腾讯会议/百度网盘/微信情报连接器同构的第四类连接器，把
「用户电脑上的文件宇宙」变成意图事件流的一级信号源：
collect(since_watermark) → 扫描差分转事件；水位线 = 扫描代数。
故障铁律：任何异常 → ([], since_watermark) 原样奉还，水位线不动。
"""
from __future__ import annotations

import logging

from paistation.sense.cloud.base import CloudConnector
from paistation.sense.localfiles.indexer import Indexer

_log = logging.getLogger("paistation.sense.cloud.localfiles")

# 进事件流的 kind（其余 metadata-only 的噪声不上流）
_EVENT_KINDS = {"pdf", "word", "excel", "powerpoint", "email_msg",
                "email_eml", "text", "code", "data"}
MAX_EVENTS_PER_TICK = 30


class LocalFilesConnector(CloudConnector):
    """本地盘感知连接器：tick 一次 = 增量扫描 + 差分转事件。"""

    name = "local.files"
    scopes = ("fs.read",)

    def __init__(self, indexer: Indexer):
        self._ix = indexer

    def login_flow(self) -> bool:
        return True  # 本地无账号：扫描域即授权边界

    def test_session(self) -> bool:
        try:
            self._ix.status()
            return True
        except Exception:
            return False

    def collect(self, since_watermark):
        try:
            report = self._ix.scan()
            events = self._collect_events()
            if report["added"] or report["changed"] or report["gone"]:
                _log.info("local.files 代差分 +%(added)s 变%(changed)s 逝%(gone)s",
                          report)
            return events, self._ix._inv.generation
        except Exception as exc:
            _log.warning("local.files 采集失败，水位线不动: %s", exc)
            return [], since_watermark

    def _collect_events(self) -> list[dict]:
        """本代新增/变更且 kind 有信息量的文件 → 精简事件。

        collect 只扫描不提取：存储 kind 可能未填，用 triage 现场
        分诊兜底（纯后缀查表，零 IO）。
        """
        from paistation.sense.localfiles.triage import Triage
        rows = self._ix._inv._db.execute(
            "SELECT path, kind, size, mtime, first_seen, last_seen FROM files"
            " WHERE status IN ('ok','pending') AND seen_gen=?"
            " ORDER BY mtime DESC", (self._ix._inv.generation,)).fetchall()
        events = []
        for r in rows:
            kind = r["kind"] or Triage().classify(r["path"])[0]
            if kind not in _EVENT_KINDS or len(events) >= MAX_EVENTS_PER_TICK:
                continue
            is_new = r["first_seen"] == r["last_seen"]
            name = r["path"].replace("\\", "/").rsplit("/", 1)[-1]
            events.append({
                "type": "fs.file.change",
                "text": f"本地文件《{name}》{'新增' if is_new else '更新'}",
                "evidence": {"path": r["path"], "kind": kind,
                             "size": r["size"], "mtime": r["mtime"]},
            })
        return events
