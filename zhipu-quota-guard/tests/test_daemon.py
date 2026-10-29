# -*- coding: utf-8 -*-
"""T-11 daemon 集成测试：全 fake 依赖跑 run_once 全链。"""
import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from zqg.config import load_config  # noqa: E402
from zqg.daemon import Daemon  # noqa: E402


class _Snap:
    def __init__(self, pct=92.0):
        self.ts = int(time.time())
        self.provider = "zai"
        self.window_pct = pct
        self.remaining = 100 - pct
        self.next_reset_at = int(time.time()) + 4 * 3600
        self.raw = {}


class _Prov:
    name = "zai"
    base_url = "https://api.z.ai"

    def __init__(self, snap=None, fail=False):
        self._snap, self._fail = snap or _Snap(), fail

    def fetch_quota(self):
        if self._fail:
            from zqg.providers.base import RetryableError
            raise RetryableError("down")
        return self._snap


class _Cards:
    def __init__(self, inv):
        self.inv = inv

    def __call__(self, *a, **k):
        return self.inv


class _Reset:
    def __init__(self):
        self.calls = []

    def execute(self, card):
        self.calls.append(card)
        return {"used": True}


class _Notify:
    def __init__(self):
        self.sent = []

    def send(self, title, detail="", kind="heartbeat"):
        self.sent.append((kind, title))
        return True


class _Ledger:
    def __init__(self):
        self.items = []

    def append(self, kind, payload):
        self.items.append((kind, payload))
        return {"ts": 0, "kind": kind, "payload": payload}

    def read(self, kinds=None, since=None, limit=None):
        return [dict(ts=i, kind=k, payload=p) for i, (k, p) in enumerate(self.items)
                if kinds is None or k in kinds][-limit if limit else None:]


def _burn(rate=200.0):
    class _B:
        tokens_per_min = rate
        peak_now = False
    return _B()


def _render(ledger, cards=None, snapshot=None, decision=None, **k):
    return "<html>ok</html>"


@pytest.fixture()
def cfg(tmp_path):
    c = load_config(None) if Path(load_config.__module__ and "config.yaml").exists() else None
    # 独立默认配置（不依赖仓库 config.yaml）
    from zqg.config import Config, PolicyCfg
    c = Config()
    c.policy.mode = "dry_run"
    return c


def test_run_once_full_chain_reset_dry_run(tmp_path, cfg):
    led = _Ledger()
    reset, notify = _Reset(), _Notify()
    inv = {"five_hour": [{"count": 3, "expire_at": int(time.time()) + 86400 * 30}],
           "weekly": [], "fetched_at": int(time.time())}
    d = Daemon(cfg, providers=[_Prov()], reset_client=reset, notifier=notify,
               ledger=led, burn_fn=lambda *a, **k: _burn(200.0), decide_fn=None,
               render_fn=_render, now=time.time, telemetry_root=tmp_path)
    d._cards_cache, d._cards_ts = inv, time.time()
    r = d.run_once()
    assert r["action"] == "reset"           # 92% + 200积分/min + 4h 窗 → 烧穿 → reset（dry_run simulated）
    kinds = [k for k, _ in led.items]
    rr = [p for k, p in led.items if k == "reset_result"]
    assert rr and rr[-1].get("ok") is True  # CN 执行器 dry_run 模拟成功或 zcode 腿兜底
    kinds = [k for k, _ in led.items]
    assert "poll" in kinds and "decision" in kinds and "reset_result" in kinds and "heartbeat" in kinds
    assert any("重置" in t for _, t in notify.sent)   # 重置结果已企微通报


def test_run_once_provider_failover_and_cards_cache(tmp_path, cfg):
    led = _Ledger()
    d = Daemon(cfg, providers=[_Prov(fail=True), _Prov(_Snap(30.0))], reset_client=_Reset(),
               notifier=_Notify(), ledger=led, burn_fn=lambda *a, **k: _burn(1.0),
               render_fn=_render, telemetry_root=tmp_path)
    r = d.run_once()
    assert r["action"] in ("wait", "notify_only")
    assert r["pct"] == 30.0                 # 第二站接管成功


def test_single_instance_lock(tmp_path, cfg):
    d1 = Daemon(cfg, providers=[_Prov()], reset_client=_Reset(), notifier=_Notify(),
                ledger=_Ledger(), burn_fn=lambda *a, **k: _burn(0),
                render_fn=_render, telemetry_root=tmp_path)
    import zqg.daemon as zd
    orig_state = zd.STATE
    zd.STATE = tmp_path
    try:
        assert d1._acquire_lock() is True
        # 伪造成他进程活锁
        (tmp_path / "daemon.lock").write_text(
            __import__("json").dumps({"pid": -999, "hb": time.time()}), encoding="utf-8")
        assert d1._acquire_lock() is False
        # 陈旧锁可抢占
        (tmp_path / "daemon.lock").write_text(
            __import__("json").dumps({"pid": -999, "hb": time.time() - 9999}), encoding="utf-8")
        assert d1._acquire_lock() is True
    finally:
        zd.STATE = orig_state
