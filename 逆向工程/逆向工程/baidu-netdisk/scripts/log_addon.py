# -*- coding: utf-8 -*-
"""mitmproxy addon: 百度网盘客户端流量采集腿 (2026-10-29)
- flows.jsonl: 每条 flow {ts, host, path, method, status, 请求头全集, 请求体前2KB, 响应体前2KB}
- 凭据字段(BDUSS/STOKEN/token/sign 等)在 flows.jsonl 只留 字段名+前8位+长度
- 完整凭据值 -> secrets_vault.json (仅本机, 不进 git)
"""
import json
import os
import re
import time
from urllib.parse import urlsplit, parse_qsl

BASE = r"E:\AI-Station\逆向工程\baidu-netdisk\captures"
FLOWS = os.path.join(BASE, "flows.jsonl")
VAULT = os.path.join(BASE, "secrets_vault.json")
TLSLOG = os.path.join(BASE, "tls_anomalies.jsonl")

# 字段名命中即视为凭据/签名
NAME_RE = re.compile(
    r"(bduss|stoken|stok\b|token|sign|secret|session|ticket|auth|passwd|password|"
    r"rand|sk|skey|cookie|credential|apikey|api_key)", re.I)
# 长 token 形态值(32+位十六进制/base62)在 vault 留底, 明文里截断展示
LONGVAL_RE = re.compile(r"(?P<name>[A-Za-z0-9_\-]{2,40})=(?P<val>[A-Za-z0-9\-_]{24,})")

_vault = {}
if os.path.exists(VAULT):
    try:
        with open(VAULT, "r", encoding="utf-8") as f:
            _vault = json.load(f)
    except Exception:
        _vault = {}


def _save_vault():
    with open(VAULT, "w", encoding="utf-8") as f:
        json.dump(_vault, f, ensure_ascii=False, indent=1)


def _mask_kv(name, val):
    v = str(val)
    if NAME_RE.search(name) and len(v) >= 10:
        key = f"{name}(len={len(v)})"
        _vault[key] = v
        return f"<MASKED {name} len={len(v)} head8={v[:8]}>"
    return v


def _mask_headers(h):
    out = {}
    for k in sorted(h.keys()):
        vals = h.get_all(k)
        masked = [_mask_kv(k, v) for v in vals]
        out[k] = masked[0] if len(masked) == 1 else masked
    return out


def _mask_query(query):
    out = []
    for k, v in parse_qsl(query, keep_blank_values=True):
        out.append(f"{k}={_mask_kv(k, v)}")
    return "&".join(out)


def _mask_text(text):
    """对 body 文本做两件事: 命中名字的 k=v 掩码; 其余不动."""
    def rep(m):
        return f"{m.group('name')}={_mask_kv(m.group('name'), m.group('val'))}"
    return LONGVAL_RE.sub(rep, text)


def _body_snippet(msg, maxlen=2048):
    try:
        raw = msg.get_content()
    except Exception:
        raw = getattr(msg, "raw_content", None) or b""
    if not raw:
        return ""
    try:
        text = raw[: maxlen * 2].decode("utf-8", errors="replace")
    except Exception:
        return repr(raw[:64]) + "..."
    snippet = text[:maxlen]
    ct = ""
    try:
        ct = (msg.headers.get("content-type") or "")[:60]
    except Exception:
        pass
    if "urlencoded" in ct or "json" in ct or "text" in ct:
        snippet = _mask_text(snippet)
    return snippet


class Collector:
    def response(self, flow):
        try:
            self._emit(flow)
        except Exception as e:
            with open(FLOWS, "a", encoding="utf-8") as f:
                f.write(json.dumps({"ts": time.time(), "error": repr(e)}) + "\n")
            _save_vault()

    def _emit(self, flow):
        u = urlsplit(flow.request.pretty_url)
        rec = {
            "ts": round(time.time(), 3),
            "method": flow.request.method,
            "host": u.netloc,
            "path": u.path + (("?" + _mask_query(u.query)) if u.query else ""),
            "status": flow.response.status_code if flow.response else None,
            "req_headers": _mask_headers(flow.request.headers),
            "req_body": _body_snippet(flow.request),
            "resp_body": _body_snippet(flow.response),
            "client": f"{flow.client_conn.peername[0]}:{flow.client_conn.peername[1]}" if flow.client_conn.peername else "",
        }
        with open(FLOWS, "a", encoding="utf-8") as f:
            f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        _save_vault()

    def tls_failed(self, client_conn):
        try:
            rec = {
                "ts": round(time.time(), 3),
                "event": "tls_failed",
                "client": str(client_conn.peername),
                "sni": getattr(client_conn, "sni", None),
                "error": str(getattr(client_conn, "error", "")),
            }
            with open(TLSLOG, "a", encoding="utf-8") as f:
                f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        except Exception:
            pass


addons = [Collector()]
