# -*- coding: utf-8 -*-
"""W11 云端履约拉取桥测试：假引擎（http.server）全链 + 真实 CLI（subprocess）。

覆盖：
- 摘要算法跨语言锚：digest_of_blueprint == kbfactory_pay.js summarySha
  （node 实算向量钉死，数字格式对齐 JS String(number)：29.0→'29'）
- 拉全链：pending → 蓝图解析 → inbox/<otn>.json（Order 契约）→ ack → 二轮空
- 未解析蓝图：不写不 ack（留云端下轮重拉，不丢单）
- 凭据：错钥 401 → CLI rc=1 如实报错；密钥零打印（输出不含 bridge_key）
测试纪律：走真实 CLI（subprocess py -3 -m kb_factory.fulfillment --cloud-pull，
rc 断言——直调不算数，W8 教训）。
"""
import json
import subprocess
import sys
import threading
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.fulfillment.cloud_pull import digest_of_blueprint  # noqa: E402
from kb_factory.fulfillment.order import Order  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parents[3]
BRIDGE_KEY = "test-bridge-key-w11"
BAD_KEY = "wrong-key"


def _mini_blueprint(tmp: Path, domain="水利EPC", gb=0.01, total=29.0) -> Path:
    bp = {
        "domain": domain,
        "need": {"domain": domain, "keywords": ["测试"], "intent": "施工",
                 "size_hint": "small"},
        "tree": {"mode": "test", "root": "测试知识库", "l1": []},
        "ratio": {},
        "stats": {"files": 7, "bytes": 10485760, "gb": gb},
        "quote": {"base": 29.0, "per_gb": 2.0, "md_factor": 1.5,
                  "ima_add": 19.0, "total": total},
        "provenance": {"engine_version": "kb-cat/1.0.0"},
    }
    p = tmp / "blueprints" / "01_测试蓝图.json"
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(bp, ensure_ascii=False), encoding="utf-8")
    return p


class _FakeEngineHandler(BaseHTTPRequestHandler):
    """假引擎：GET pending（首单一次）+ POST ack；X-KB-Bridge 钥匙校验。"""
    state = {"orders": [], "acked": [], "served": 0}

    def log_message(self, *a):  # 静默（测试输出零噪音）
        pass

    def _deny_or_json(self, body: dict):
        key = self.headers.get("X-KB-Bridge") or ""
        if key != BRIDGE_KEY:
            self.send_response(401)
            self.end_headers()
            return
        raw = json.dumps(body, ensure_ascii=False).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(raw)))
        self.end_headers()
        self.wfile.write(raw)

    def do_GET(self):
        if not self.path.startswith("/api/kb/orders/pending"):
            self.send_response(404)
            self.end_headers()
            return
        self.state["served"] += 1
        remaining = [o for o in self.state["orders"]
                     if o["otn"] not in self.state["acked"]]
        self._deny_or_json({"orders": remaining})

    def do_POST(self):
        if not self.path.startswith("/api/kb/orders/ack"):
            self.send_response(404)
            self.end_headers()
            return
        n = int(self.headers.get("Content-Length") or 0)
        otn = json.loads(self.rfile.read(n) or b"{}").get("otn") or ""
        key = self.headers.get("X-KB-Bridge") or ""
        if key != BRIDGE_KEY:
            self.send_response(401)
            self.end_headers()
            return
        if otn in [o["otn"] for o in self.state["orders"]]:
            self.state["acked"].append(otn)
            body = {"acknowledged": True}
        else:
            body = {"acknowledged": False}
        raw = json.dumps(body).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(raw)))
        self.end_headers()
        self.wfile.write(raw)


@pytest.fixture()
def fake_engine():
    _FakeEngineHandler.state = {"orders": [], "acked": [], "served": 0}
    srv = ThreadingHTTPServer(("127.0.0.1", 0), _FakeEngineHandler)
    t = threading.Thread(target=srv.serve_forever, daemon=True)
    t.start()
    yield f"http://127.0.0.1:{srv.server_address[1]}"
    srv.shutdown()
    srv.server_close()


def _cli(env_url: str, base: Path, key: str = BRIDGE_KEY,
         blueprints: Path | None = None) -> subprocess.CompletedProcess:
    env = {**__import__("os").environ,
           "KB_ENGINE_URL": env_url, "KB_BRIDGE_KEY": key,
           "KB_BLUEPRINTS_DIR": str(blueprints or (base / "blueprints")),
           "PYTHONIOENCODING": "utf-8"}
    return subprocess.run(
        [sys.executable, "-m", "kb_factory.fulfillment",
         "--cloud-pull", "--base", str(base)],
        cwd=str(REPO_ROOT), capture_output=True, text=True,
        encoding="utf-8", errors="replace", env=env, timeout=60)


def test_digest_parity_with_js_summary_sha():
    """跨语言锚：与 kbfactory_pay.js summarySha 同构（node 实算向量钉死）。"""
    seed05 = {"domain": "水利EPC工程知识库", "files": 1000, "gb": 1.33,
              "total": 31.7, "engine_version": "kb-cat/1.0.0"}
    assert digest_of_blueprint({
        "domain": seed05["domain"],
        "stats": {"files": 1000, "gb": 1.33},
        "quote": {"total": 31.7},
        "provenance": {"engine_version": "kb-cat/1.0.0"},
    }) == "296bea15"
    # JS String(number) 对齐锚：total=29.0 → JS '29' 非 '29.0'
    assert digest_of_blueprint({
        "domain": "水利EPC",
        "stats": {"files": 7, "gb": 0.01},
        "quote": {"total": 29.0},
        "provenance": {"engine_version": "kb-cat/1.0.0"},
    }) == "96a814d9"


def test_cloud_pull_full_chain_via_real_cli(tmp_path, fake_engine):
    """全链（真实 CLI）：pending → inbox 订单（Order 契约）→ ack → 二轮空。"""
    bp = _mini_blueprint(tmp_path)
    sha = digest_of_blueprint(json.loads(bp.read_text(encoding="utf-8")))
    order_cloud = {
        "otn": "o1a2b3c4d-xxxxxx", "email": "buyer@example.com",
        "version": "md", "need_text": "随单备注", "total_fen": 4700,
        "buy_quantity": 47, "confirmed_at": "2026-10-22 11:00:00",
        "blueprint": {"domain": "水利EPC", "files": 7, "gb": 0.01,
                      "total": 29.0, "version_sha": sha},
    }
    _FakeEngineHandler.state["orders"].append(order_cloud)

    base = tmp_path / "line"
    r = _cli(fake_engine, base, blueprints=tmp_path / "blueprints")
    assert r.returncode == 0, (r.stdout, r.stderr)
    s = json.loads(r.stdout.splitlines()[-1].removeprefix("[cloud-pull] "))
    assert s["pulled"] == 1 and s["written"] == 1 and s["acked"] == 1
    assert s["unresolved"] == []
    # 密钥零打印（stdout/stderr 均不得出现钥匙内容）
    assert BRIDGE_KEY not in r.stdout + r.stderr

    p = base / "inbox" / f"{order_cloud['otn']}.json"
    assert p.is_file()
    o = Order.from_json(p)
    assert o.id == order_cloud["otn"] and o.email == "buyer@example.com"
    assert o.version_selection == "md"          # Order 词法兼容（md→markdown）
    assert o.price == "47.00" and o.status == "paid"
    assert o.blueprint_ref.endswith(".json") and Path(o.blueprint_ref).is_file()
    assert _FakeEngineHandler.state["acked"] == [order_cloud["otn"]]

    # 二轮：已 ack → 引擎不再下发 → 无新文件
    r2 = _cli(fake_engine, base, blueprints=tmp_path / "blueprints")
    assert r2.returncode == 0
    s2 = json.loads(r2.stdout.splitlines()[-1].removeprefix("[cloud-pull] "))
    assert s2["pulled"] == 0 and s2["written"] == 0


def test_cloud_pull_unresolved_blueprint_not_acked(tmp_path, fake_engine):
    """蓝图解析失败：不写 inbox、不 ack（留云端下轮重拉，不丢单）。"""
    _FakeEngineHandler.state["orders"].append({
        "otn": "oUNKNOWN-sha", "email": "b@ex.com", "version": "original",
        "need_text": "", "total_fen": 2900, "buy_quantity": 29,
        "confirmed_at": "2026-10-22 11:05:00",
        "blueprint": {"domain": "未知域", "files": 9, "gb": 0.5,
                      "total": 30.0, "version_sha": "00000000"},
    })
    _mini_blueprint(tmp_path)   # 蓝图目录在但摘要不匹配
    base = tmp_path / "line2"
    r = _cli(fake_engine, base, blueprints=tmp_path / "blueprints")
    assert r.returncode == 0
    s = json.loads(r.stdout.splitlines()[-1].removeprefix("[cloud-pull] "))
    assert s["pulled"] == 1 and s["written"] == 0 and s["acked"] == 0
    assert s["unresolved"] == ["oUNKNOWN-sha"]
    assert not list((base / "inbox").glob("*.json"))
    assert _FakeEngineHandler.state["acked"] == []   # 未 ack：云端仍持有


def test_cloud_pull_wrong_key_fails_honestly(tmp_path, fake_engine):
    """错钥 → 引擎 401 → CLI rc=1 如实报错（不带密钥内容）。"""
    _FakeEngineHandler.state["orders"].append({
        "otn": "oSHOULD-NOT-PULL", "email": "b@ex.com", "version": "original",
        "need_text": "", "total_fen": 2900, "buy_quantity": 29,
        "confirmed_at": "2026-10-22 11:10:00",
        "blueprint": {"domain": "x", "files": 1, "gb": 0, "total": 29,
                      "version_sha": "1234abcd"},
    })
    base = tmp_path / "line3"
    r = _cli(fake_engine, base, key=BAD_KEY)
    assert r.returncode == 1
    assert "401" in r.stderr
    assert BAD_KEY not in r.stderr and BRIDGE_KEY not in r.stderr
    assert not list((base / "inbox").glob("*.json"))
