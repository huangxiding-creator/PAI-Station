# -*- coding: utf-8 -*-
"""Panel API 服务器：注意力面板的后端。

启动: py panel_server.py [端口]
默认端口 8090
"""
from __future__ import annotations

import json
import os
import sys
import threading
import time
from http.server import HTTPServer, SimpleHTTPRequestHandler
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "sources"))

from domain import Report, ReportType
from engine import Engine
from executor import Executor
from effects import Effects
from outbox import Outbox
from eval import PolicyConfig

PANEL_DIR = Path(__file__).parent


class PanelAPI:
    """面板 API 逻辑，与 HTTP 解耦。"""

    def __init__(self):
        self.engine = Engine()
        self.executor = Executor(self.engine.store)
        self.effects = Effects(self.engine.store)
        self.outbox = Outbox(self.engine.store)

        # 注册 Source
        try:
            from sources.viaim_source import poll as viaim_poll
            self.engine.register_source("viaim", viaim_poll)
        except ImportError:
            pass
        try:
            from sources.wechat_source import poll as wechat_poll
            self.engine.register_source("wechat", wechat_poll)
        except ImportError:
            pass

        # 注册 Effects handlers
        self.effects.register("launch", self._handle_launch)
        self.effects.register("notify", self._handle_notify)

        # 定期轮询
        self._start_poll_loop()

    def _start_poll_loop(self):
        """后台轮询 Sources + 处理 Effects + 投递 Outbox。"""
        def loop():
            while True:
                try:
                    self.engine.poll_all()
                    self.effects.process()
                    self.outbox.flush()
                except Exception:
                    pass
                time.sleep(10)  # 10秒一轮
        t = threading.Thread(target=loop, daemon=True)
        t.start()

    def _handle_launch(self, payload: dict):
        """Effect handler: 启动 Ticket 执行。"""
        result = self.executor.launch(payload.get("ticket_id", ""))
        if result and result.get("status") == "launched":
            print(f"[executor] launched: {result['title']} → {result['work_dir']}")

    def _handle_notify(self, payload: dict):
        """Effect handler: 发送通知。"""
        self.outbox.queue(
            payload.get("ticket_id", ""),
            payload.get("channel", "wecom"),
            payload.get("purpose", "result"),
            payload.get("content", ""),
        )

    # ── API 方法 ───────────────────────────────────────────────

    def overview(self) -> dict:
        return self.engine.overview()

    def tickets(self) -> list[dict]:
        return [
            {"id": t.id, "title": t.title, "stage": t.stage().value,
             "created_at": t.created_at, "outcome": t.outcome}
            for t in self.engine.store.open_tickets()
        ]

    def decisions(self, limit: int = 20) -> list[dict]:
        cur = self.engine.store.conn.execute(
            "SELECT * FROM decision ORDER BY ts DESC LIMIT ?", (limit,))
        return [dict(r) for r in cur.fetchall()]

    def manual_trigger(self, source: str, content: str,
                      actor: str = "user") -> dict:
        """手动创建 Trigger（测试用）。"""
        from domain import Trigger
        trigger = Trigger(
            source=source, actor=actor,
            thread_id=f"manual_{int(time.time())}",
            content=content, is_human=True,
        )
        decision = self.engine.intake(trigger)
        if decision and decision.ticket_id:
            self.effects.enqueue("launch", decision.ticket_id,
                                 {"ticket_id": decision.ticket_id})
        return {
            "decision": decision.to_dict() if decision else None,
            "ticket_id": decision.ticket_id if decision else None,
        }


class PanelHandler(SimpleHTTPRequestHandler):
    """HTTP 处理器：静态面板 + JSON API。"""

    api: PanelAPI = None

    def do_GET(self):
        if self.path == "/api/overview":
            self._json(self.api.overview())
        elif self.path == "/api/tickets":
            self._json({"tickets": self.api.tickets()})
        elif self.path == "/api/decisions":
            self._json({"decisions": self.api.decisions()})
        elif self.path == "/" or self.path == "/panel":
            self._file(PANEL_DIR / "panel.html")
        else:
            self.send_error(404)

    def do_POST(self):
        if self.path == "/api/trigger":
            length = int(self.headers.get("Content-Length", 0))
            body = json.loads(self.rfile.read(length))
            result = self.api.manual_trigger(
                body.get("source", "manual"),
                body.get("content", ""),
                body.get("actor", "user"),
            )
            self._json(result)
        else:
            self.send_error(404)

    def _json(self, data: dict):
        body = json.dumps(data, ensure_ascii=False).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", len(body))
        self.end_headers()
        self.wfile.write(body)

    def _file(self, path: Path):
        if not path.exists():
            self.send_error(404)
            return
        body = path.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", len(body))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        pass  # 静默访问日志


def main(port: int = 8090):
    api = PanelAPI()
    PanelHandler.api = api

    server = HTTPServer(("0.0.0.0", port), PanelHandler)
    print(f"🧠 注意力面板: http://localhost:{port}")
    print(f"   API: http://localhost:{port}/api/overview")
    print(f"   Sources: {list(api.engine._sources.keys())}")
    server.serve_forever()


if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8090
    main(port)
