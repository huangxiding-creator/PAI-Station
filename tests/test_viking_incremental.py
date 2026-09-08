"""R9 OpenViking 侧车隔离协议 + 1AM 增量扫描（补 M1 deferred）。

- VikingClient：本地 HTTP IPC（127.0.0.1:17777），进程边界隔离 AGPL；
  侧车缺席是常态 → 全接口优雅降级，绝不崩主程序。
- IncrementalScanner：mtime 增量扫描，兜住 watcher 漏报（停机窗口），
  每日 01:00 静默补扫（先于 02:00 PDCA），状态原子落盘。
"""
import io
import json
import os
import time
from datetime import datetime

import pytest

from paistation.memory.viking_client import VikingClient
from paistation.sense.incremental import IncrementalScanner

# ---- OpenViking 侧车客户端 ----

class _FakeResp(io.BytesIO):
    status = 200


class _FakeOpener:
    """记录请求并回放固定响应；可注入异常。"""

    def __init__(self, responses=None, error=None):
        self.calls = []
        self._responses = list(responses or [])
        self._error = error

    def open(self, req, timeout=None):
        self.calls.append({"url": req.full_url,
                           "method": req.get_method(),
                           "data": req.data.decode("utf-8") if req.data else ""})
        if self._error is not None:
            raise self._error
        body = self._responses.pop(0) if self._responses else "{}"
        return _FakeResp(body.encode("utf-8"))


def test_viking_absent_sidecar_degrades():
    """侧车未启动（连接拒绝）是常态：全部接口降级不抛。"""
    import urllib.error
    client = VikingClient("http://127.0.0.1:17777", timeout=1,
                          _opener=_FakeOpener(
                              error=urllib.error.URLError("refused")))
    assert client.health() is False
    assert client.upsert("doc1", "内容") is False
    assert client.search("查询") == []
    assert client.is_available() is False


def test_viking_health_ok():
    op = _FakeOpener(responses=['{"status": "ok"}'])
    client = VikingClient("http://127.0.0.1:17777", _opener=op)
    assert client.health() is True
    assert op.calls[0]["method"] == "GET"
    assert op.calls[0]["url"].endswith("/health")


def test_viking_upsert_posts_payload():
    op = _FakeOpener(responses=['{"ok": true}'])
    client = VikingClient("http://127.0.0.1:17777", _opener=op)
    assert client.upsert("m1", "周报三段式技能卡", {"score": 0.8}) is True
    call = op.calls[0]
    assert call["method"] == "POST"
    assert call["url"].endswith("/memory/upsert")
    body = json.loads(call["data"])
    assert body["id"] == "m1" and body["text"] == "周报三段式技能卡"
    assert body["meta"]["score"] == 0.8


def test_viking_search_parses_results():
    op = _FakeOpener(responses=[
        '{"results": [{"id": "r1", "score": 0.9, "text": "投标清单法"}]}'])
    client = VikingClient("http://127.0.0.1:17777", _opener=op)
    hits = client.search("清单", top_k=3)
    assert len(hits) == 1 and hits[0]["id"] == "r1"
    assert json.loads(op.calls[0]["data"])["top_k"] == 3


def test_viking_search_bad_json_degrades():
    op = _FakeOpener(responses=["not-json"])
    client = VikingClient("http://127.0.0.1:17777", _opener=op)
    assert client.search("查询") == []


def test_viking_rejects_remote_host():
    """AGPL 隔离边界：IPC 仅限回环地址，禁止指向远程。"""
    with pytest.raises(ValueError, match="回环"):
        VikingClient("http://viking.example.com:17777")
    with pytest.raises(ValueError, match="回环"):
        VikingClient("http://10.0.0.5:17777")


def test_viking_is_available_caches_probe():
    op = _FakeOpener(responses=['{"status": "ok"}', '{"status": "ok"}'])
    client = VikingClient("http://127.0.0.1:17777", _opener=op)
    assert client.is_available() is True
    client.is_available()  # 二次调用走缓存，不再发请求
    assert len(op.calls) == 1


# ---- 1AM 增量扫描 ----

def _mkfile(path, content="x", mtime=None):
    path.write_text(content, encoding="utf-8")
    if mtime is not None:
        os.utime(path, (mtime, mtime))


def test_incremental_detects_mtime_delta(tmp_path):
    d = tmp_path / "docs"
    d.mkdir()
    now = time.time()
    _mkfile(d / "old.md", mtime=now - 7 * 86400)
    _mkfile(d / "fresh.md", mtime=now - 60)
    scanned = []
    s = IncrementalScanner([str(d)], scanned.extend,
                           state_path=str(tmp_path / "inc.json"))
    out = s.run(now_fn=lambda: now)
    assert out["changed"] == 1
    assert scanned and scanned[0].endswith("fresh.md")


def test_incremental_state_advances_no_rescan(tmp_path):
    d = tmp_path / "docs"
    d.mkdir()
    now = time.time()
    _mkfile(d / "a.md", mtime=now)
    scanned = []
    s = IncrementalScanner([str(d)], scanned.extend,
                           state_path=str(tmp_path / "inc.json"))
    s.run(now_fn=lambda: now)
    out2 = s.run(now_fn=lambda: now + 3600)  # 无新变更
    assert out2["changed"] == 0
    assert len(scanned) == 1


def test_incremental_first_run_bounded_24h(tmp_path):
    """无状态文件首跑：回看窗 24h，不重扫全盘（首扫已覆盖）。"""
    d = tmp_path / "docs"
    d.mkdir()
    now = time.time()
    _mkfile(d / "ancient.md", mtime=now - 10 * 86400)
    _mkfile(d / "yesterday.md", mtime=now - 2 * 3600)
    scanned = []
    s = IncrementalScanner([str(d)], scanned.extend,
                           state_path=str(tmp_path / "inc.json"))
    out = s.run(now_fn=lambda: now)
    assert out["changed"] == 1
    assert scanned[0].endswith("yesterday.md")


def test_incremental_suffix_and_ignore_filter(tmp_path):
    d = tmp_path / "docs"
    (d / "sub").mkdir(parents=True)
    now = time.time()
    _mkfile(d / "run.exe", mtime=now)          # 后缀不在白名单
    _mkfile(d / "keep.md", mtime=now)
    _mkfile(d / "sub" / "skip.md", mtime=now)   # 命中 ignore
    scanned = []
    s = IncrementalScanner([str(d)], scanned.extend,
                           state_path=str(tmp_path / "inc.json"),
                           ignore_patterns=["sub"])
    s.run(now_fn=lambda: now)
    assert scanned == [str(d / "keep.md")]


def test_incremental_ingest_failure_still_advances(tmp_path):
    """单文件入库失败不阻塞状态推进（下次不重扫已见文件）。"""
    d = tmp_path / "docs"
    d.mkdir()
    now = time.time()
    _mkfile(d / "boom.md", mtime=now)

    def bad_ingest(paths):
        raise RuntimeError("入库崩了")

    s = IncrementalScanner([str(d)], bad_ingest,
                           state_path=str(tmp_path / "inc.json"))
    out = s.run(now_fn=lambda: now)
    assert out["changed"] == 1 and out["ingested"] == 0
    assert os.path.isfile(tmp_path / "inc.json")  # 状态仍推进
    data = json.loads((tmp_path / "inc.json").read_text(encoding="utf-8"))
    assert data["last_run"] == now


def test_incremental_state_atomic_no_tmp_left(tmp_path):
    d = tmp_path / "docs"
    d.mkdir()
    now = time.time()
    _mkfile(d / "a.md", mtime=now)
    s = IncrementalScanner([str(d)], lambda p: None,
                           state_path=str(tmp_path / "inc.json"))
    s.run(now_fn=lambda: now)
    leftovers = [p for p in os.listdir(tmp_path) if p.endswith(".tmp")]
    assert leftovers == []


# ---- Runtime 01:00 增量闸门 ----

def _runtime_cfg(tmp_path):
    from paistation.config import load
    ini = tmp_path / "pai.ini"
    docs = tmp_path / "docs"
    docs.mkdir()
    ini.write_text(
        f"[sense]\nwatch_dirs = {docs}\n"
        f"[privacy]\ndata_dir = {tmp_path / 'data'}\n", encoding="utf-8")
    cfg = load(str(ini))
    (tmp_path / "data").mkdir(exist_ok=True)
    return cfg, docs


def test_runtime_incremental_fires_before_pdca(tmp_path):
    """01:30（勿扰内、PDCA 前）：增量静默补扫照跑，PDCA 仍被闸。"""
    from paistation.runtime import Runtime
    cfg, docs = _runtime_cfg(tmp_path)
    now = datetime(2026, 9, 8, 1, 30)
    _mkfile(docs / "missed.md", mtime=now.timestamp() - 300)
    rt = Runtime(cfg, client=None, channel=None, watcher_factory=lambda *a, **k: _NoopWatcher(),
                 now_fn=lambda: now)
    result = rt.daily_tick()
    assert result is None  # PDCA 未到点 → 无复盘
    inc_state = tmp_path / "data" / "incremental.state.json"
    assert inc_state.is_file()
    date = json.loads(inc_state.read_text(encoding="utf-8"))["date"]
    assert date == "2026-09-08"
    # 同日第二次 tick 不重扫
    assert rt.daily_tick() is None
    assert json.loads(inc_state.read_text(encoding="utf-8"))["runs"] == 1


def test_runtime_incremental_skips_before_window(tmp_path):
    """00:30（01:00 窗口前）：不扫。"""
    from paistation.runtime import Runtime
    cfg, docs = _runtime_cfg(tmp_path)
    now = datetime(2026, 9, 8, 0, 30)
    rt = Runtime(cfg, client=None, channel=None, watcher_factory=lambda *a, **k: _NoopWatcher(),
                 now_fn=lambda: now)
    rt.daily_tick()
    assert not (tmp_path / "data" / "incremental.state.json").exists()


class _NoopWatcher:
    def __init__(self, *args, **kwargs):
        pass

    def start(self):
        pass

    def stop(self):
        pass
