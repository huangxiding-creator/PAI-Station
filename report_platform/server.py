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
import hmac
import json
import os
import re
import sqlite3
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlparse, parse_qs, quote as _urlquote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parent
ADMIN_TOKEN = os.environ.get("RP_ADMIN_TOKEN", "")
_LOCK = threading.Lock()

import pay as PAY   # noqa: E402  (支付/反馈/退款/质量飞轮)

_SECRET_CACHE: dict = {"t": 0.0, "sec": None}


def _sec() -> dict:
    """凭证缓存 (60s TTL): 热改 secret.ini 无需重启."""
    now = time.time()
    if _SECRET_CACHE["sec"] is None or now - _SECRET_CACHE["t"] > 60:
        _SECRET_CACHE["sec"] = PAY.load_secrets()
        _SECRET_CACHE["t"] = now
    return _SECRET_CACHE["sec"]


def _qesc(s: str) -> str:
    """code_url → 查询串安全转义."""
    return _urlquote(s, safe="")


def _full_sig(order_no: str, token: str) -> str:
    """读者链接签名: HMAC-SHA256(key=access_token, msg=order_no) 前 32 位."""
    return hmac.new(token.encode(), order_no.encode(),
                    "sha256").hexdigest()[:32]


_READABLE = ("paid", "partial_refunded")   # 部分退款保留阅读权

_CH_CACHE: dict = {"t": 0.0, "map": {}}


def _sku_chapters(sku: str) -> list[str]:
    """sku → 全文章节标题表 (content/full/{sku}.html 的 h2, 5min 缓存).

    用途=L3 内容锚定: 质量类反馈的章节字段必须命中真章节, 单一事实源
    与读者所见全文一致.
    """
    import re as _re
    now = time.time()
    if now - _CH_CACHE["t"] > 300:
        m: dict[str, list[str]] = {}
        for f in (ROOT / "content" / "full").glob("*.html"):
            try:
                hs = _re.findall(r"<h2>(.*?)</h2>",
                                 f.read_text(encoding="utf-8"),
                                 re.S)
                m[f.stem] = [re.sub(r"<[^>]+>", "", h).strip()[:60]
                             for h in hs]
            except OSError:
                continue
        _CH_CACHE["map"] = m
        _CH_CACHE["t"] = now
    return _CH_CACHE["map"].get(sku, [])


def _full_ok(no: str, sig: str) -> tuple[bool, str]:
    """(ok, sku): 订单在可读态且签名对上 access_token → 放行并给 sku."""
    with _LOCK:
        con = _db(Handler.db_path)
        row = con.execute("SELECT sku, access_token, state FROM orders "
                          "WHERE order_no=?", (no,)).fetchone()
        con.close()
    if not row or row[2] not in _READABLE or not row[1]:
        return False, ""
    want = _full_sig(no, row[1])
    return hmac.compare_digest(want, sig), row[0]

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
    PAY.ensure_columns(con)
    PAY.ensure_feedback_table(con)
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
        q = parse_qs(u.query)
        if u.path == "/api/stats":
            if not ADMIN_TOKEN or q.get("token", [""])[0] != ADMIN_TOKEN:
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
                pulse = PAY.quality_pulse(con)
                rev = con.execute("SELECT COUNT(*) FROM orders "
                                  "WHERE state='refunded'").fetchone()[0]
            return self._json({"ok": True, "funnel": funnel,
                               "orders": orders, "quality": pulse,
                               "refunded": rev})
        if u.path == "/api/order/query":
            no = q.get("order_no", [""])[0][:24]
            tail = q.get("tail", [""])[0][:4]
            if not (no and tail):
                return self._json({"ok": False, "error": "参数缺"}, 400)
            with _LOCK, _db(self.db_path) as con:
                row = con.execute("SELECT state, sku, access_token "
                                  "FROM orders WHERE order_no=?",
                                  (no,)).fetchone()
                if not row:
                    return self._json({"ok": False, "error": "订单不存在"})
                state, sku, tok = row
                if state not in _READABLE or not tok:
                    return self._json({"ok": True, "state": state})
                sig = _full_sig(no, tok)
                return self._json({"ok": True, "state": state, "sku": sku,
                                   "reader_url": f"/reader.html?o={no}&s={sig}",
                                   "pdf_url": f"/api/full.pdf?o={no}&s={sig}"})
        if u.path == "/api/reader/content":
            no = q.get("o", [""])[0][:24]
            sig = q.get("s", [""])[0][:64]
            ok, sku = _full_ok(no, sig)
            if not ok:
                return self._json({"ok": False, "error": "签名无效"}, 403)
            html = self.site.parent / "content" / "full" / f"{sku}.html"
            if not html.is_file():
                return self._json({"ok": False, "error": "全文未就位"}, 404)
            return self._text_html(html.read_text(encoding="utf-8"))
        if u.path == "/api/full.pdf":
            no = q.get("o", [""])[0][:24]
            sig = q.get("s", [""])[0][:64]
            ok, sku = _full_ok(no, sig)
            if not ok:
                return self._json({"ok": False, "error": "签名无效"}, 403)
            pdf = self.site.parent / "content" / "full" / f"{sku}.pdf"
            if not pdf.is_file():
                return self._json({"ok": False, "error": "PDF 未就位"}, 404)
            data = pdf.read_bytes()
            self.send_response(200)
            self.send_header("Content-Type", "application/pdf")
            self.send_header("Content-Disposition",
                             'attachment; filename="EPC-report.pdf"')
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        if u.path == "/api/pay/qr":                      # code_url → PNG
            text = q.get("text", [""])[0][:600]
            if not text.startswith("weixin://"):
                return self._json({"ok": False}, 400)
            import io
            import qrcode
            buf = io.BytesIO()
            qrcode.make(text, box_size=8).save(buf, format="PNG")
            data = buf.getvalue()
            self.send_response(200)
            self.send_header("Content-Type", "image/png")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return
        if u.path in ("/", "/index.html"):
            return self._static("index.html")
        if u.path in ("/sample", "/sample.html"):
            return self._static("sample.html")
        if u.path in ("/reader", "/reader.html"):
            return self._static("reader.html")
        if u.path in ("/admin", "/admin.html"):
            return self._static("admin.html")
        if u.path.startswith("/assets/"):
            return self._static(u.path.lstrip("/"))
        # 多商品通配: /{sku}.html /sample_{sku}.html 等根层静态页 (防穿越已由
        # _static 的 resolve+startswith 兜底; 子路径一律不在此放行)
        if u.path.endswith((".html", ".png")) and "/" not in u.path[1:]:
            return self._static(u.path.lstrip("/"))
        self.send_error(404)

    def do_POST(self):
        u = urlparse(self.path)
        if u.path not in ("/api/track", "/api/order", "/api/pay/create",
                          "/api/pay/notify/wx", "/api/pay/notify/ali",
                          "/api/feedback", "/api/refund"):
            return self.send_error(404)
        d = self._read_body()
        if u.path == "/api/track":
            ev = str(d.get("event") or "")
            if not _SAFE_EVENT.match(ev):
                return self._json({"ok": False}, 400)
            sku = str(d.get("sku") or "")[:32]
            extra = str(d.get("extra") or "")[:120]
            with _LOCK, _db(self.db_path) as con:
                con.execute("INSERT INTO events(ts,event,sku,extra) VALUES(?,?,?,?)",
                            (time.strftime("%Y-%m-%d %H:%M:%S"), ev, sku, extra))
            return self._json({"ok": True})
        if u.path == "/api/order":                       # 个人码半自动登记
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
        if u.path == "/api/pay/create":                  # 企业支付下单
            sku = str(d.get("sku") or "")[:32]
            channel = str(d.get("channel") or "")[:10]
            sec = _sec()
            ready = PAY.pay_ready(sec)
            if channel not in ("wxpay", "alipay") or not ready.get(channel):
                return self._json({"ok": False,
                                   "error": f"{channel} 未配置 (等商户凭证)"})
            cfg = json.loads((ROOT / "content" / "report.json")
                             .read_text(encoding="utf-8"))
            rpt = next((r for r in cfg["reports"] if r["sku"] == sku), None)
            if not rpt:
                return self._json({"ok": False, "error": "sku 无效"}, 400)
            no = PAY.new_out_trade_no(sku)
            fen = rpt["price"] * 100
            with _LOCK, _db(self.db_path) as con:
                con.execute("INSERT INTO orders(created,sku,order_no,contact,"
                            "note,state) VALUES(?,?,?,?,?,?)",
                            (time.strftime("%Y-%m-%d %H:%M:%S"), sku, no,
                             "auto-pay", channel, "paying"))
                con.execute("INSERT OR REPLACE INTO pay_amounts(order_no,price) "
                            "VALUES(?,?)", (no, fen))
            if channel == "wxpay":
                r = PAY.wx_native_order(sec, sec["wxpay"], no, fen,
                                        rpt["title"])
                if r["ok"]:
                    return self._json({"ok": True, "order_no": no,
                                       "qr_url": "/api/pay/qr?text="
                                       + _qesc(r["code_url"])})
                return self._json({"ok": False, "error": r["error"]})
            form = PAY.ali_wap_form(sec["alipay"], sec, no,
                                    f"{fen / 100:.2f}", rpt["title"])
            return self._json({"ok": True, "order_no": no, "form": form})
        if u.path == "/api/pay/notify/wx":               # 微信回调
            body = self._raw_body()
            sec = _sec()
            w = sec["wxpay"]
            pem = (ROOT / "certs" / "wx_platform_pub.pem")
            if not (w and pem.is_file()):
                return self._json({"ok": False}, 500)
            note = PAY.wx_verify_notify(
                w, {k.lower(): v for k, v in self.headers.items()},
                body, pem.read_text(encoding="utf-8"))
            if not note:
                return self._json({"code": "FAIL", "message": "verify fail"}, 401)
            if note.get("trade_state") == "SUCCESS":
                with _LOCK, _db(self.db_path) as con:
                    PAY.mark_paid(con, note.get("out_trade_no", ""),
                                  "wxpay", note.get("transaction_id", ""))
            return self._json({"code": "SUCCESS", "message": "OK"})
        if u.path == "/api/pay/notify/ali":              # 支付宝回调
            params = {k: v[0] for k, v in parse_qs(
                self._raw_body(), keep_blank_values=True).items()}
            sec = _sec()
            if not sec["alipay"]:
                return self._json({"ok": False}, 500)
            if not PAY.ali_verify_notify(sec["alipay"], dict(params)):
                return self._text("fail")
            if params.get("trade_status") in ("TRADE_SUCCESS", "TRADE_FINISHED"):
                with _LOCK, _db(self.db_path) as con:
                    PAY.mark_paid(con, params.get("out_trade_no", ""),
                                  "alipay", params.get("trade_no", ""))
            return self._text("success")
        if u.path == "/api/feedback":                    # 反馈 (取证+比例退款)
            no = str(d.get("order_no") or "")[:24]
            rating = int(d.get("rating") or 0)
            chapter = str(d.get("chapter") or "")[:60]
            category = str(d.get("category") or "")[:20]
            content = str(d.get("content") or "")[:1000]
            if category not in ("quality", "suggest"):
                category = "suggest"
            if not (no and 1 <= rating <= 5 and content):
                return self._json({"ok": False,
                                   "error": "订单号/评分/内容必填"}, 400)
            with _LOCK, _db(self.db_path) as con:
                row = con.execute("SELECT sku, state FROM orders "
                                  "WHERE order_no=?", (no,)).fetchone()
                if not row or row[1] not in (_READABLE + ("refunded",)):
                    return self._json({"ok": False, "error": "仅已购订单可反馈"})
                sku, state = row
                # L3 内容锚定: 质量类反馈章节必须命中全文真章节表
                chapters = _sku_chapters(sku)
                if category == "quality" and chapters \
                        and chapter not in chapters:
                    return self._json({"ok": False,
                                       "error": "请定位到具体章节 (真实性问题须指明位置)"})
                g = PAY.grade_feedback(rating, category, content)
                # L2 阅读锚定: 退款须有该章节真实阅读埋点 (反馈本身照收)
                read_n = con.execute(
                    "SELECT COUNT(*) FROM events WHERE event='read_chapter' "
                    "AND sku=? AND extra=?", (sku, chapter)).fetchone()[0]
                refundable = (state in _READABLE and g["pct"] > 0
                              and (category != "quality" or read_n > 0))
                PAY.save_feedback(con, no, sku, rating, chapter, category,
                                  content, severity=g["severity"],
                                  refund_pct=g["pct"], read_verified=read_n > 0)
                refund = (PAY.auto_refund(con, _sec(), no,
                                          content[:80] or "质量不满意",
                                          pct=g["pct"]) if refundable else None)
            out: dict = {"ok": True, "grade": g, "read_verified": read_n > 0}
            if refund and refund.get("ok") and refund.get("refund_fen"):
                out["refund"] = {"fen": refund["refund_fen"],
                                 "pct": refund.get("pct", g["pct"])}
            elif category == "quality" and g["pct"] > 0 and not refundable:
                out["note"] = ("反馈已入质量飞轮并致谢；触发退款需该章节"
                               "存在真实阅读记录 (防虚假反馈套利)")
            return self._json(out)
        if u.path == "/api/refund":                      # 主动退款 (同护栏)
            no = str(d.get("order_no") or "")[:24]
            reason = str(d.get("reason") or "用户申请退款")[:200]
            pct = int(d.get("pct") or 100)
            with _LOCK, _db(self.db_path) as con:
                r = PAY.auto_refund(con, _sec(), no, reason, pct=pct)
            return self._json(r)

    def _raw_body(self) -> str:
        n = int(self.headers.get("Content-Length") or 0)
        if n <= 0 or n > 65536:
            return ""
        try:
            return self.rfile.read(n).decode("utf-8", "replace")
        except Exception:
            return ""

    def _text(self, s: str):
        b = s.encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(b)))
        self.end_headers()
        self.wfile.write(b)

    def _text_html(self, s: str):
        b = s.encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(b)))
        self.end_headers()
        self.wfile.write(b)


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
