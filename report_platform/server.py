# -*- coding: utf-8 -*-
"""server — 发布平台后端 (旗舰 F5a, stdlib 零依赖).

静态站 site/ + 三 API, sqlite 落自有库 (付费数据自主掌控):
  POST /api/track  {event, sku, extra}          埋点 (visit/scroll_xx/read_sample/click_buy/show_qr/order_created)
  POST /api/order  {sku, contact, note, order_no} 支付凭证登记 → state=pending
  GET  /api/stats?token=…                       漏斗计数+订单表 (ADMIN_TOKEN 保护)

跑法: python server.py [--site site] [--db db] [--port 8885]
ECS 常驻: deploy/report-platform.service (systemd)
"""
from __future__ import annotations

import argparse
import json
import os
import re
import sqlite3
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlparse, parse_qs

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parent
ADMIN_TOKEN = os.environ.get("RP_ADMIN_TOKEN", "")
_LOCK = threading.Lock()

FUNNEL_EVENTS = ("visit", "scroll_25", "scroll_50", "scroll_75", "scroll_90",
                 "read_sample", "click_buy", "show_qr", "order_created")
_SAFE_EVENT = re.compile(r"^[a-z0-9_]{1,40}$")
_SAFE_TEXT = re.compile(r"^[\w\-.,@;；：:（）()《》?？!！\s]{0,200}$", re.UNICODE)


def _db(path: Path) -> sqlite3.Connection:
    fresh = not path.exists()
    con = sqlite3.connect(str(path))
    con.execute("PRAGMA journal_mode=WAL")
    if fresh:
        con.execute("CREATE TABLE events(id INTEGER PRIMARY KEY, ts TEXT, "
                    "event TEXT, sku TEXT, extra TEXT)")
        con.execute("CREATE TABLE orders(id INTEGER PRIMARY KEY, created TEXT, "
                    "sku TEXT, order_no TEXT, contact TEXT, note TEXT, "
                    "state TEXT DEFAULT 'pending')")
        con.commit()
    return con


class Handler(BaseHTTPRequestHandler):
    site: Path = ROOT / "site"
    db_path: Path = ROOT / "report_platform.db"

    def log_message(self, fmt, *args):          # 安静模式 (systemd journal 归档)
        sys.stderr.write("[%s] %s\n" % (time.strftime("%H:%M:%S"),
                                        fmt % args))

    # ---------------------------------------------------------- helpers
    def _json(self, obj: dict, code: int = 200):
        body = json.dumps(obj, ensure_ascii=False).encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def _read_body(self) -> dict:
        n = int(self.headers.get("Content-Length") or 0)
        if n <= 0 or n > 8192:
            return {}
        try:
            return json.loads(self.rfile.read(n).decode("utf-8"))
        except (json.JSONDecodeError, UnicodeDecodeError):
            return {}

    def _static(self, rel: str):
        safe = (self.site / rel).resolve()
        if not str(safe).startswith(str(self.site.resolve())) or not safe.is_file():
            self.send_error(404)
            return
        mime = {".html": "text/html; charset=utf-8",
                ".png": "image/png", ".js": "text/javascript"}.get(safe.suffix,
                                                                   "application/octet-stream")
        data = safe.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", mime)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    # ---------------------------------------------------------- routes
    def do_GET(self):
        u = urlparse(self.path)
        if u.path == "/api/stats":
            if not ADMIN_TOKEN or parse_qs(u.query).get("token", [""])[0] != ADMIN_TOKEN:
                return self._json({"ok": False, "error": "token"}, 403)
            with _LOCK, _db(self.db_path) as con:
                funnel = {e: con.execute(
                    "SELECT COUNT(*) FROM events WHERE event=?", (e,)
                ).fetchone()[0] for e in FUNNEL_EVENTS}
                orders = [{"created": r[0], "sku": r[1], "order_no": r[2],
                           "contact": r[3], "note": r[4], "state": r[5]}
                          for r in con.execute(
                              "SELECT created,sku,order_no,contact,note,state "
                              "FROM orders ORDER BY id DESC LIMIT 500")]
            return self._json({"ok": True, "funnel": funnel, "orders": orders})
        if u.path in ("/", "/index.html"):
            return self._static("index.html")
        if u.path in ("/sample", "/sample.html"):
            return self._static("sample.html")
        if u.path in ("/admin", "/admin.html"):
            return self._static("admin.html")
        if u.path.startswith("/assets/"):
            return self._static(u.path.lstrip("/"))
        self.send_error(404)

    def do_POST(self):
        if self.path != "/api/track" and self.path != "/api/order":
            return self.send_error(404)
        d = self._read_body()
        if self.path == "/api/track":
            ev = str(d.get("event") or "")
            if not _SAFE_EVENT.match(ev):
                return self._json({"ok": False}, 400)
            sku = str(d.get("sku") or "")[:32]
            extra = str(d.get("extra") or "")[:120]
            with _LOCK, _db(self.db_path) as con:
                con.execute("INSERT INTO events(ts,event,sku,extra) VALUES(?,?,?,?)",
                            (time.strftime("%Y-%m-%d %H:%M:%S"), ev, sku, extra))
            return self._json({"ok": True})
        # /api/order
        sku = str(d.get("sku") or "")[:32]
        contact = str(d.get("contact") or "")[:120]
        note = str(d.get("note") or "")[:120]
        order_no = str(d.get("order_no") or "")[:24]
        if not (sku and contact):
            return self._json({"ok": False, "error": "sku/contact 必填"}, 400)
        if not all(_SAFE_TEXT.match(x) for x in (contact, note, order_no)):
            return self._json({"ok": False, "error": "含非法字符"}, 400)
        with _LOCK, _db(self.db_path) as con:
            con.execute("INSERT INTO orders(created,sku,order_no,contact,note) "
                        "VALUES(?,?,?,?,?)",
                        (time.strftime("%Y-%m-%d %H:%M:%S"), sku, order_no,
                         contact, note))
        return self._json({"ok": True})


def serve(site: Path, db: Path, port: int) -> None:
    Handler.site = site
    Handler.db_path = db
    srv = ThreadingHTTPServer(("0.0.0.0", port), Handler)
    print(f"[rp] serving {site} :{port} db={db} "
          f"admin={'on' if ADMIN_TOKEN else 'OFF(set RP_ADMIN_TOKEN)'}")
    srv.serve_forever()


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="发布平台后端 (F5a)")
    ap.add_argument("--site", default=str(ROOT / "site"))
    ap.add_argument("--db", default=str(ROOT / "report_platform.db"))
    ap.add_argument("--port", type=int, default=8885)
    ns = ap.parse_args(argv)
    serve(Path(ns.site), Path(ns.db), ns.port)
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
