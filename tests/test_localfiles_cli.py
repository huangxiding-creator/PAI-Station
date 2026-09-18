"""CLI 长跑模式：断点续跑收敛与毒文件停机判定。"""
import logging

from paistation.sense.localfiles.__main__ import _extract_loop


class _FakeIx:
    """按剧本回放 extract_pending 结果序列。"""

    def __init__(self, script):
        self._script = list(script)
        self.calls = 0

    def drain_events(self):
        return {}

    def extract_pending(self, limit, workers=None, engine="thread"):
        self.calls += 1
        return self._script.pop(0) if self._script else {"processed": 0}


def test_loop_drains_until_empty():
    ix = _FakeIx([
        {"processed": 10, "extracted": 8, "cached": 1, "failed": 1},
        {"processed": 5, "extracted": 0, "cached": 5, "failed": 0},
    ])
    total = _extract_loop(ix, 100, logging.getLogger("t"))
    assert total == {"processed": 15, "extracted": 8, "cached": 6, "failed": 1}


def test_loop_stops_on_poison_stall():
    """队列只剩毒文件（批批全失败）时收敛停机，不死循环。"""
    poison = {"processed": 7, "extracted": 0, "cached": 0, "failed": 7}
    ix = _FakeIx([poison] * 10)  # 剧本足够长：靠停机判定退出
    total = _extract_loop(ix, 100, logging.getLogger("t"))
    assert ix.calls == 3  # POISON_STALL_BATCHES=3 即停
    assert total["failed"] == 21


def test_loop_progress_resets_stall_counter():
    """失败批之间穿插产出批 → 计数清零，继续跑。"""
    fail = {"processed": 5, "extracted": 0, "cached": 0, "failed": 5}
    good = {"processed": 5, "extracted": 5, "cached": 0, "failed": 0}
    ix = _FakeIx([fail, fail, good, fail, fail, fail])
    total = _extract_loop(ix, 100, logging.getLogger("t"))
    assert ix.calls == 6  # 中途 good 清零，末尾连三失败才停
    assert total["extracted"] == 5 and total["failed"] == 25


# ---------- embed 长跑：时长预算优雅收工 ----------

class _FakeChunks:
    """backfill 永远有活干（embedded>0）——只有预算/清空能停。"""

    def __init__(self, script=None):
        self._script = script
        self.calls = 0

    def backfill(self, batch=256, **kwargs):
        self.calls += 1
        if self._script is not None:
            return self._script.pop(0)
        return {"embedded": 10, "rows_lit": 10, "failed": 0,
                "remaining": 9999}


def test_embed_budget_stops_loop(monkeypatch):
    """预算到点 → 首批后优雅收工（假时钟确定性，不靠真实耗时）。"""
    import paistation.sense.localfiles.__main__ as m

    seq = iter([100.0, 999.0])  # 首调算 deadline=100+ε，次调 999 已过点
    monkeypatch.setattr(m.time, "monotonic", lambda: next(seq))
    ch = _FakeChunks()
    total = m._embed_loop(ch, 256, loop=True, max_hours=1e-6,
                          log=logging.getLogger("t"))
    assert ch.calls == 1  # 预算退出（embedded>0 却停）
    assert total["embedded"] == 10


def test_embed_no_budget_runs_to_empty():
    """max_hours=0 → 跑到队列清空（embedded=0）才停。"""
    from paistation.sense.localfiles.__main__ import _embed_loop

    ch = _FakeChunks(script=[
        {"embedded": 5, "rows_lit": 5, "failed": 0, "remaining": 3},
        {"embedded": 0, "rows_lit": 0, "failed": 0, "remaining": 0},
    ])
    total = _embed_loop(ch, 256, loop=True, max_hours=0,
                        log=logging.getLogger("t"))
    assert ch.calls == 2
    assert total["embedded"] == 5


def test_embed_heal_only_batch_keeps_looping():
    """纯自愈/纯点亮批不算完工（2026-09-18 早退回归）：embedded=0
    但 healed>0 说明 remaining 在降，继续磨；真零进展批才收工。"""
    from paistation.sense.localfiles.__main__ import _embed_loop

    ch = _FakeChunks(script=[
        {"embedded": 0, "rows_lit": 30, "failed": 0, "healed": 30,
         "remaining": 2703000},
        {"embedded": 0, "rows_lit": 0, "failed": 0, "healed": 0,
         "remaining": 0},
    ])
    total = _embed_loop(ch, 256, loop=True, max_hours=0,
                        log=logging.getLogger("t"))
    assert ch.calls == 2
    assert total["healed"] == 30
