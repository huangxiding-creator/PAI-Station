"""CLI 长跑模式：断点续跑收敛与毒文件停机判定。"""
import logging

from paistation.sense.localfiles.__main__ import _extract_loop


class _FakeIx:
    """按剧本回放 extract_pending 结果序列。"""

    def __init__(self, script):
        self._script = list(script)
        self.calls = 0

    def extract_pending(self, limit):
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
