"""M2.6 云感知服务：串行轮询已授权连接器→水位线增量→统一事件流。

daemon 服务协议：name/start/stop/tick(paused)。串行铁律：单线程
逐个连接器轮询，绝不并发打平台；每连接器配 RateLimiter 四件套，
采集异常=report(False) 进冷却，绝不重试风暴。
"""
from __future__ import annotations

import logging
from datetime import datetime

from paistation.sense.cloud.base import CloudConnector, ConnectorRegistry, WatermarkStore
from paistation.sense.cloud.rate import RateLimiter

_log = logging.getLogger("paistation.sense.cloud")


class CloudSensingService:
    name = "sense.cloud"

    def __init__(self, stream, registry: ConnectorRegistry,
                 watermarks: WatermarkStore,
                 limiters: dict[str, RateLimiter] | None = None):
        self._stream = stream
        self._registry = registry
        self._wm = watermarks
        self._limiters = limiters if limiters is not None else {}
        self.started = False

    def _limiter(self, conn: CloudConnector) -> RateLimiter:
        if conn.name not in self._limiters:
            self._limiters[conn.name] = RateLimiter(conn.name)
        return self._limiters[conn.name]

    def start(self) -> None:
        self.started = True

    def stop(self) -> None:
        self.started = False

    def tick(self, paused: bool) -> None:
        if paused:  # 一键全局暂停（NFR2）
            return
        for conn in self._registry.all():
            if not self._registry.is_enabled(conn):
                continue
            limiter = self._limiter(conn)
            if not limiter.try_acquire():
                continue
            since = self._wm.get(conn.name)
            try:
                events, new_wm = conn.collect(since)
            except Exception as exc:  # noqa: BLE001 - 平台故障进冷却
                _log.warning("连接器 %s 采集异常（进冷却）: %s",
                             conn.name, exc)
                limiter.report(False)
                continue
            limiter.report(True)
            for lean in events or []:
                self._emit(conn, lean)
            if new_wm is not None:
                self._wm.set(conn.name, new_wm)

    def _emit(self, conn: CloudConnector, lean: dict) -> None:
        ev = {
            "ts": datetime.now().isoformat(timespec="milliseconds"),
            "type": lean.get("type", "cloud.doc.change"),
            "source": conn.name,
            "text": lean.get("text", ""),
            "speaker": "cloud",
            "evidence": lean.get("evidence", {}),
            "meta": lean.get("meta", {}),
        }
        if not self._stream.append(ev):
            _log.debug("云事件被拒（类型或字段不合规）: %s", ev.get("type"))
