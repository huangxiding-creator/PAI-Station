"""M2.6 云感知框架：连接器注册/授权门/水位线/服务编排（FR15）。"""
from paistation.sense.cloud.base import CloudConnector, ConnectorRegistry, WatermarkStore
from paistation.sense.cloud.rate import RateLimiter
from paistation.sense.cloud.service import CloudSensingService
from paistation.sense.voice_events import EventStream


class FakeConnector(CloudConnector):
    name = "fake.cloud"
    scopes = ("cloud.docs.read",)

    def __init__(self):
        self.collect_calls = 0
        self.fail = False

    def login_flow(self) -> bool:
        return True

    def test_session(self) -> bool:
        return True

    def collect(self, since_watermark):
        self.collect_calls += 1
        if self.fail:
            raise RuntimeError("平台接口故障")
        ev = {"type": "cloud.doc.change", "text": "云文档《甲》更新了",
              "evidence": {"doc": "d1", "since": since_watermark}}
        return [ev], (since_watermark or 0) + 1


def _setup(tmp_path):
    stream = EventStream(tmp_path)
    registry = ConnectorRegistry()
    wm = WatermarkStore(tmp_path / "watermarks.json")
    return stream, registry, wm


def test_registry_opt_in_gating(tmp_path):
    stream, registry, wm = _setup(tmp_path)
    conn = FakeConnector()
    registry.register(conn)
    svc = CloudSensingService(stream, registry, wm)
    svc.tick(paused=False)
    assert conn.collect_calls == 0            # 未授权（opt-in）不采集

    registry.grant("fake.cloud", ["cloud.docs.read"])
    svc.tick(paused=False)
    assert conn.collect_calls == 1            # 授权后采集

    registry.revoke("fake.cloud")
    svc.tick(paused=False)
    assert conn.collect_calls == 1            # 撤授权即停


def test_service_emits_events_and_advances_watermark(tmp_path):
    stream, registry, wm = _setup(tmp_path)
    conn = FakeConnector()
    registry.register(conn)
    registry.grant("fake.cloud", ["cloud.docs.read"])
    svc = CloudSensingService(stream, registry, wm,
                              limiters={"fake.cloud":
                                        RateLimiter("fake.cloud",
                                                    min_interval_s=0)})
    svc.tick(paused=False)
    events = stream.read_today()
    assert any(e["type"] == "cloud.doc.change" and "甲" in e["text"]
               for e in events)
    assert events[-1]["source"] == "fake.cloud"
    assert wm.get("fake.cloud") == 1
    svc.tick(paused=False)
    assert wm.get("fake.cloud") == 2          # 水位线随采集推进


def test_service_paused_skips(tmp_path):
    stream, registry, wm = _setup(tmp_path)
    conn = FakeConnector()
    registry.register(conn)
    registry.grant("fake.cloud", ["cloud.docs.read"])
    svc = CloudSensingService(stream, registry, wm)
    svc.tick(paused=True)                     # 全局一键暂停
    assert conn.collect_calls == 0
    assert stream.read_today() == []


def test_service_failure_triggers_limiter_coolown(tmp_path):
    stream, registry, wm = _setup(tmp_path)
    conn = FakeConnector()
    conn.fail = True
    registry.register(conn)
    registry.grant("fake.cloud", ["cloud.docs.read"])
    limiter = RateLimiter("fake.cloud", min_interval_s=0, cooldown_s=300)
    svc = CloudSensingService(stream, registry, wm, limiters={"fake.cloud": limiter})
    svc.tick(paused=False)                    # 采集抛异常→report(False)
    svc.tick(paused=False)                    # 冷却中不再触达平台
    assert conn.collect_calls == 1
    assert stream.read_today() == []          # 故障不产事件


def test_watermark_store_roundtrip(tmp_path):
    store = WatermarkStore(tmp_path / "wm.json")
    assert store.get("x") is None
    assert store.get("x", default="2026-09-13") == "2026-09-13"
    store.set("x", "cursor-42")
    store.set("y", 7)
    again = WatermarkStore(tmp_path / "wm.json")   # 重开可续
    assert again.get("x") == "cursor-42"
    assert again.get("y") == 7
