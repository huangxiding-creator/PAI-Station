"""M6 serve 集成：Runtime 把 watcher→ingest→store→outbox 装成整机。"""
import json
from datetime import datetime

from paistation import config
from paistation.runtime import Runtime


class FakeWatcher:
    calls = []

    def __init__(self, watch_dirs, event_filter, on_batch, audit=None, window=2.0):
        self.on_batch = on_batch
        FakeWatcher.calls.append(self)
        self.started = False
        self.stopped = False

    def start(self):
        self.started = True

    def stop(self):
        self.stopped = True


class FakeClient:
    def fast(self, prompt, context="", json_mode=False):
        return {"text": json.dumps({"title": "文档", "summary": "测试摘要内容",
                                    "score": 0.8}, ensure_ascii=False),
                "usage": {}, "confidence": 1.0}

    def deep(self, prompt, reasoning=True):
        return {"text": "复盘建议：保持节奏。", "chain": "c", "confidence": 0.9}


class FakeChannel:
    def __init__(self):
        self.sent = []

    def send(self, title, body):
        self.sent.append((title, body))
        return {"ok": True, "errcode": 0, "errmsg": "ok"}


def write_ini(tmp_path):
    ini = tmp_path / "pai.ini"
    ini.write_text(
        f"[sense]\nwatch_dirs = {tmp_path / 'watch'}\n"
        f"[privacy]\ndata_dir = {tmp_path / 'data'}\n"
        # 勿扰窗口避开测试注入的时钟点（03:00 / 正午），否则推送入抽屉
        f"[proactive]\nquiet_hours = 03:30-04:00\n", encoding="utf-8")
    (tmp_path / "watch").mkdir(exist_ok=True)
    return str(ini)


def make_runtime(tmp_path, **kw):
    kw.setdefault("now_fn", lambda: datetime(2026, 9, 7, 12, 0))
    cfg = config.load(write_ini(tmp_path))
    channel = FakeChannel()
    rt = Runtime(cfg, client=FakeClient(), channel=channel,
                 watcher_factory=FakeWatcher, **kw)
    return rt, channel


def test_on_batch_ingests_into_store(tmp_path):
    rt, _ = make_runtime(tmp_path)
    doc = tmp_path / "watch" / "note.md"
    doc.write_text("这是一份测试文档，讲述风险排查过程。", encoding="utf-8")
    rt.on_batch([str(doc)])
    hits = rt.store.search("测试摘要内容")
    assert len(hits) == 1 and hits[0]["title"] == "文档"
    rt.close()


def test_on_batch_missing_file_isolated(tmp_path):
    rt, _ = make_runtime(tmp_path)
    rt.on_batch([str(tmp_path / "watch" / "gone.md")])  # 不抛
    assert rt.store.stats()["total"] == 0
    rt.close()


def test_first_scan_runs_only_when_store_empty(tmp_path):
    rt, channel = make_runtime(tmp_path)
    (tmp_path / "watch" / "seed.md").write_text("种子文档内容若干。", encoding="utf-8")
    rt.start()
    assert any(t == "首扫镜像报告" for t, _ in channel.sent)
    rt2, channel2 = make_runtime(tmp_path)  # 第二次启动：首扫不重复
    rt2.start()
    assert not any(t == "首扫镜像报告" for t, _ in channel2.sent)
    rt.stop()
    rt2.close()


def test_daily_tick_pdca_once_per_day(tmp_path):
    clock = {"now": datetime(2026, 9, 7, 3, 0)}
    rt, channel = make_runtime(tmp_path, now_fn=lambda: clock["now"])
    rt.daily_tick()
    assert any("复盘" in t for t, _ in channel.sent)
    rt.daily_tick()                                   # 同一天不重复
    assert len([t for t, _ in channel.sent if "复盘" in t]) == 1
    clock["now"] = datetime(2026, 9, 8, 3, 0)         # 次日再发
    rt.daily_tick()
    assert len([t for t, _ in channel.sent if "复盘" in t]) == 2
    rt.close()


def test_daily_tick_before_pdca_time_skips(tmp_path):
    rt, channel = make_runtime(tmp_path, now_fn=lambda: datetime(2026, 9, 7, 1, 0))
    rt.daily_tick()
    assert channel.sent == []
    rt.close()


def test_daily_tick_in_quiet_defers_not_consumes(tmp_path):
    # 测试 ini 勿扰 03:30-04:00：勿扰中不标记当日，勿扰结束后补送
    clock = {"now": datetime(2026, 9, 7, 3, 45)}
    rt, channel = make_runtime(tmp_path, now_fn=lambda: clock["now"])
    assert rt.daily_tick() is None          # 勿扰中：跳过且不占名额
    assert channel.sent == []
    clock["now"] = datetime(2026, 9, 7, 5, 0)
    rt.daily_tick()                         # 同日勿扰后：正常送
    assert len([t for t, _ in channel.sent if "复盘" in t]) == 1
    rt.close()


def test_daily_tick_without_channel_safe(tmp_path):
    cfg = config.load(write_ini(tmp_path))
    rt = Runtime(cfg, client=FakeClient(), channel=None, watcher_factory=FakeWatcher,
                 now_fn=lambda: datetime(2026, 9, 7, 3, 0))
    rt.daily_tick()  # 无通道：入抽屉不崩溃
    assert rt.outbox.stats()["drawer_items"] == 1
    rt.close()


def test_start_stop_watcher_lifecycle(tmp_path):
    rt, _ = make_runtime(tmp_path)
    (tmp_path / "watch" / "x.md").write_text("内容", encoding="utf-8")
    rt.start()
    w = FakeWatcher.calls[-1]
    assert w.started and w.on_batch is not None
    rt.stop()
    assert w.stopped


def test_stats_exposes_components(tmp_path):
    rt, _ = make_runtime(tmp_path)
    st = rt.stats()
    assert {"store_files", "drawer_items", "watch_dirs"} <= set(st)
    rt.close()


def test_from_config_builds_runtime(tmp_path):
    cfg = config.load(write_ini(tmp_path))
    rt = Runtime.from_config(cfg)  # 无密钥/无 webhook 也不崩（规则降级）
    st = rt.stats()
    assert st["store_files"] == 0 and st["watch_dirs"]
    rt.close()


class FakeServeRuntime:
    def __init__(self, cfg, audit=None):
        self.audit = audit
        self.started = self.stopped = self.ticked = 0

    def start(self):
        self.started += 1

    def stop(self):
        self.stopped += 1

    def daily_tick(self):
        self.ticked += 1
        return None


def test_serve_wires_runtime_lifecycle(tmp_path):
    from paistation.main import serve
    made = {}

    def factory(cfg, audit=None):
        rt = FakeServeRuntime(cfg, audit=audit)
        made["rt"] = rt
        return rt

    rc = serve(write_ini(tmp_path), db=str(tmp_path / "audit.db"),
               max_ticks=2, interval=0.01, runtime_factory=factory)
    assert rc == 0
    rt = made["rt"]
    assert rt.started == 1 and rt.stopped == 1
    assert rt.ticked == 2          # 每拍一次 PDCA 闸门检查
    assert rt.audit is not None    # 复用 serve 的审计实例


def test_production_clock_struct_time_feeds_new_engines(tmp_path, caplog):
    """实机雷（2026-09-11 守护重启实测暴露）：生产默认时钟是
    time.localtime（struct_time），而深读/进化引擎契约是 datetime。
    不注入 now_fn 时 daily_tick 也不许炸（夹具此前恒注 datetime 假钟，
    该组合从未被测过）。"""
    import logging

    cfg = config.load(write_ini(tmp_path))
    rt = Runtime(cfg, client=FakeClient(), channel=FakeChannel(),
                 watcher_factory=FakeWatcher, station_root=tmp_path)
    with caplog.at_level(logging.WARNING, logger="paistation.runtime"):
        rt.daily_tick()
    assert "深读 tick 异常" not in caplog.text
    assert "进化提案步异常" not in caplog.text
    rt.close()
