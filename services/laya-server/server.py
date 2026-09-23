# -*- coding: utf-8 -*-
"""laya-server — 本地判断引擎常驻服务 (Project LayaForge P0).

契约: POST /v1/systemone {state, model, questions} -> {answers, usage}
      与 https://api.typesafe.ai/v1/systemone 逐字段同构 (ADR-2),
      JudgmentClient 换 transport 即用, 业务接线点零改动.
健康: GET /healthz -> {ok, uptime_s, vram_mb, checkpoint, calls, errors}

纪律: USE_TF=0 (transformers 探测 TF 死锁坑) / HF_HUB_OFFLINE=1 (零网络) /
      preload 检查点常热 (反复重建 7.4-10.3s 坑) / 推理串行锁 (thread-safe) /
      无窗运行 (pythonw / CREATE_NO_WINDOW) / fail-soft (错误->500 JSON, 客户端降级).
"""
import json
import os
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

# 环境必须先于 transformers/laya 导入
os.environ.setdefault("USE_TF", "0")
os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("HF_ENDPOINT", "https://hf-mirror.com")
os.environ.setdefault("TRANSFORMERS_NO_ADVISORY_WARNINGS", "1")

HOST, PORT = "127.0.0.1", int(os.environ.get("LAYA_PORT", "8864"))
BUNDLE_REPO = "convaiinnovations/laya"
SUBFOLDER = os.environ.get("LAYA_SUBFOLDER", "multilingual")   # ADR-3: 首版仅 multilingual
MODEL_PATH = os.environ.get("LAYA_MODEL_PATH", "")             # 微调产物热换入口 (P2)

T0 = time.monotonic()
_LOCK = threading.Lock()          # 推理串行化 (ADR-1)
_STATS = {"calls": 0, "errors": 0}
_AGENT = None


def _load_agent():
    global _AGENT
    import laya
    if MODEL_PATH:                                   # 微调检查点优先
        _AGENT = laya.load(MODEL_PATH)
    else:
        _AGENT = laya.load(BUNDLE_REPO, subfolder=SUBFOLDER)
    return _AGENT


class Handler(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def log_message(self, fmt, *args):               # 静默 (无窗纪律)
        pass

    def _json(self, code: int, obj: dict) -> None:
        body = json.dumps(obj, ensure_ascii=False).encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path != "/healthz":
            return self._json(404, {"error": "not found"})
        import torch
        vram = (torch.cuda.max_memory_allocated() / 1e6
                if torch.cuda.is_available() else 0.0)
        self._json(200, {
            "ok": _AGENT is not None, "engine": "laya",
            "checkpoint": MODEL_PATH or f"{BUNDLE_REPO}/{SUBFOLDER}",
            "uptime_s": round(time.monotonic() - T0, 1),
            "vram_mb": round(vram, 1),
            **_STATS,
        })

    def do_POST(self):
        if self.path != "/v1/systemone":
            return self._json(404, {"error": "not found"})
        try:
            n = int(self.headers.get("Content-Length", "0"))
            req = json.loads(self.rfile.read(n).decode("utf-8"))
            state, questions = req.get("state"), req.get("questions")
            if not questions or not isinstance(questions, dict):
                return self._json(400, {"error": "questions required"})
            t0 = time.perf_counter()
            with _LOCK:
                out = _AGENT.system_one(state=state, questions=questions)
            # laya 自带信封 {model, answers, usage} → 拆出内层与 typesafe 对齐
            answers = out.get("answers") if isinstance(out, dict) else None
            if not isinstance(answers, dict):
                answers = out if isinstance(out, dict) else {}
            dt = (time.perf_counter() - t0) * 1000
            _STATS["calls"] += 1
            inner_usage = out.get("usage") if isinstance(out, dict) else None
            usage = {"engine": "laya", "latency_ms": round(dt, 1)}
            if isinstance(inner_usage, dict):
                usage.update({k: v for k, v in inner_usage.items()
                              if isinstance(v, (int, float))})
            self._json(200, {"answers": answers, "usage": usage})
        except Exception as e:                        # noqa: BLE001 — fail-soft
            _STATS["errors"] += 1
            self._json(500, {"error": f"{type(e).__name__}: {e}"})


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    print(f"[laya-server] loading checkpoint ...", flush=True)
    t0 = time.perf_counter()
    _load_agent()
    print(f"[laya-server] ready in {time.perf_counter()-t0:.1f}s "
          f"on http://{HOST}:{PORT} (USE_TF=0, offline, preload)", flush=True)
    ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()
    return 0


if __name__ == "__main__":
    sys.exit(main())
