# -*- coding: utf-8 -*-
"""Manus webhook 接收端 — 阿里云 ECS 生产部署 (0922).

零依赖 (纯标准库), systemd 守护, jsonl 落盘.
路径: /hk/<SECRET>/<ACCT>  — SECRET 防扫描, ACCT 标识来源账号.
事件契约: task_created / task_stopped(attachments 带成果下载URL).
"""
import json
import os
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PORT = int(os.environ.get("HOOK_PORT", "8890"))
SECRET = os.environ.get("HOOK_SECRET", "")
DATA_DIR = Path(os.environ.get("HOOK_DATA", "/www/manus_hooks"))
LOG = DATA_DIR / "events.jsonl"
LOCK = threading.Lock()


def append_event(acct: str, hdrs: dict, body: bytes) -> None:
    lo = {k.lower(): v for k, v in hdrs.items()}
    rec = {
        "recv_ts": time.strftime("%Y-%m-%dT%H:%M:%S", time.gmtime()) + "Z",
        "acct": acct,
        "sig": lo.get("x-webhook-signature", ""),
        "sig_ts": lo.get("x-webhook-timestamp", ""),
        "event": json.loads(body.decode("utf-8", "replace")),
    }
    line = json.dumps(rec, ensure_ascii=False)
    with LOCK:
        with LOG.open("a", encoding="utf-8") as f:
            f.write(line + "\n")


class Handler(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def _send(self, code: int, text: str = "ok") -> None:
        data = text.encode()
        self.send_response(code)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self) -> None:
        if self.path == "/healthz":
            return self._send(200, "ok")
        # 预检/探活: 合法路径回 200, 其余 404
        if self.path.startswith(f"/hk/{SECRET}/"):
            return self._send(200, "ready")
        # 增量事件拉取: /ev/<SECRET>?after=N → N 行之后的事件 (本地收割器用)
        from urllib.parse import parse_qs, urlparse
        u = urlparse(self.path)
        if u.path == f"/ev/{SECRET}":
            after = int(parse_qs(u.query).get("after", ["0"])[0])
            limit = min(int(parse_qs(u.query).get("limit", ["200"])[0]), 500)
            lines = []
            if LOG.is_file():
                with LOCK:
                    all_lines = LOG.read_text(encoding="utf-8").splitlines()
                lines = all_lines[after:after + limit]
            payload = json.dumps({
                "total": len(all_lines) if LOG.is_file() else 0,
                "returned": len(lines), "lines": lines},
                ensure_ascii=False)
            data = payload.encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        return self._send(404, "nf")

    def do_POST(self) -> None:
        parts = self.path.strip("/").split("/")
        # 期望: hk <secret> <acct>...
        if len(parts) < 3 or parts[0] != "hk" or parts[1] != SECRET:
            return self._send(404, "nf")
        acct = parts[2][:80]
        try:
            length = int(self.headers.get("Content-Length", "0"))
            body = self.rfile.read(length) if length else b""
            append_event(acct, dict(self.headers.items()), body)
        except Exception as e:  # 落盘失败也不让 Manus 重试风暴
            DATA_DIR.mkdir(parents=True, exist_ok=True)
            (DATA_DIR / "errors.log").open("a", encoding="utf-8").write(
                f"{time.time()} {acct} {type(e).__name__}: {e}\n")
        return self._send(200, "ok")

    def log_message(self, fmt, *args) -> None:  # 安静模式, 事件本身已落盘
        pass


def main() -> None:
    if not SECRET:
        print("[FATAL] HOOK_SECRET 未设置", file=sys.stderr)
        sys.exit(1)
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    srv = ThreadingHTTPServer(("0.0.0.0", PORT), Handler)
    print(f"[hook-server] :{PORT} data={DATA_DIR}", flush=True)
    srv.serve_forever()


if __name__ == "__main__":
    main()
