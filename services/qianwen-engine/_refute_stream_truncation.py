# -*- coding: utf-8 -*-
"""反驳复现（2026-09-30）：claim——SSE 流 ≥100 字后中断/超时 → 截断稿被当完整答案返回。

场景A：conversation_init 后收到 ~300 字增量，随后网络中断（iter_lines 抛异常）
场景B：KB_STREAM_TIMEOUT_SEC=150s deadline 流中途到点（FakeTime 推进）→ break
场景C（claim 的"更糟子例"）：cid 未到手前流断，前置 50 字增量是否被采信
场景D（对照）：完整流（含终止标记）正常走完
零真实网络调用：仅 monkeypatch metaso_kb.cr / kb_session / time。
"""
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, metaso_kb  # noqa: E402

CID = "2104386684190437377"
CID_LINE = ('data:{"data":{"id":"%s"},"type":"conversation_init"}' % CID).encode("utf-8")
DONE_LINE = b'data:{"type":"chunk","data":{"id":"done","status":"finished"}}'
FULL_ANSWER = "完整答案头。" + "内容" * 700 + "收尾引用[[末规范†88]]"   # ~1414 字
PARTIAL = "开头引用[[首规范†12]]。" + "字" * 280                       # ~294 字（≥100）


def delta_line(text: str) -> bytes:
    payload = (
        '{"type":"event","data":{"id":"chatcmpl-1","object":"chat.completion.chunk",'
        '"choices":[{"index":0,"delta":{"content":%s}}]}}'
        % json.dumps(text, ensure_ascii=False)
    )
    return ("data:" + payload).encode("utf-8")


def split_deltas(text: str, n: int):
    step = max(1, len(text) // n)
    return [delta_line(text[i:i + step]) for i in range(0, len(text), step)]


class FakeResp:
    def __init__(self, status_code=200, text="", chunks=None, exc=None, on_yield=None):
        self.status_code = status_code
        self._text = text
        self._chunks = chunks or []
        self._exc = exc
        self._on_yield = on_yield

    def iter_lines(self):
        for c in self._chunks:
            if self._on_yield:
                self._on_yield(c)
            yield c
        if self._exc is not None:
            raise self._exc

    def json(self):
        return json.loads(self._text)

    @property
    def text(self):
        return self._text

    def close(self):
        pass


class FakeCr:
    def __init__(self, chunks, exc=None, on_yield=None):
        self.calls = {"chat": 0, "full": 0}
        self._chunks = chunks
        self._exc = exc
        self._on_yield = on_yield

    def post(self, url, **kw):
        self.calls["chat"] += 1
        return FakeResp(chunks=self._chunks, exc=self._exc, on_yield=self._on_yield)

    def get(self, url, **kw):
        self.calls["full"] += 1
        payload = json.dumps(
            {"data": {"activePathMessages": [{"content": {"stages": [
                {"texts": [{"text": FULL_ANSWER}]}]}}]}},
            ensure_ascii=False)
        return FakeResp(text=payload)


class Clock:
    """可控时钟：仅替换 metaso_kb 命名空间内的 time。"""

    def __init__(self, start):
        self.now = float(start)

    def time(self):
        return self.now

    def strftime(self, fmt, *a):
        return time.strftime(fmt, *a)

    def sleep(self, s):
        self.now += s


def _setup(chunks, exc=None, on_yield=None, clock=None):
    fake_cr = FakeCr(chunks, exc, on_yield)
    saved = (metaso_kb.cr, metaso_kb.kb_session.get_session, metaso_kb.time)
    metaso_kb.cr = fake_cr
    metaso_kb.kb_session.get_session = (
        lambda force_refresh=False: {"cookie": "tid=x; uid=y", "token": "tok"})
    if clock is not None:
        metaso_kb.time = clock
    metaso_kb._points_used_today = 0
    metaso_kb._today_str = time.strftime("%Y-%m-%d")
    metaso_kb._breaker_open_until = 0
    metaso_kb._fail_streak = 0
    metaso_kb._last_ask_ts = 0.0
    return fake_cr, saved


def _teardown(saved):
    metaso_kb.cr, metaso_kb.kb_session.get_session, metaso_kb.time = saved


def _run(name, chunks, exc=None, on_yield=None, clock=None):
    fake_cr, saved = _setup(chunks, exc, on_yield, clock)
    print("=" * 72)
    print("[%s]" % name)
    try:
        try:
            res = metaso_kb.ask("测试问题", sleep=lambda s: None)
            print("  ask() 正常返回（未抛错）")
            print("  返回答案长度   : %d 字" % len(res.answer))
            print("  兜底轮询次数   : %d  (branched-messages GET=%d)"
                  % (fake_cr.calls["full"], fake_cr.calls["full"]))
            print("  返回答案尾部100: ...%s" % res.answer[-100:])
            print("  citations      : %s" % res.citations)
            print("  是否含全文独有标记'末规范': %s" % ("末规范" in res.answer))
            print("  是否含截断稿标记'首规范'  : %s" % ("首规范" in res.answer))
            return res, fake_cr
        except Exception as e:  # noqa: BLE001
            print("  ask() 抛错: %s: %s" % (type(e).__name__, e))
            print("  兜底轮询次数   : %d" % fake_cr.calls["full"])
            return None, fake_cr
    finally:
        _teardown(saved)


# ── 场景A：≥100 字后网络中断 ──────────────────────────────
chunks_a = [CID_LINE] + split_deltas(PARTIAL, 5)
_run("A 流中途网络断（294字后 ConnectionError）", chunks_a,
     exc=ConnectionError("mid-stream connection reset"))

# ── 场景B：150s deadline 中途到点 ─────────────────────────
clock = Clock(1750000000.0)
state = {"n": 0}


def bump_clock(_chunk):
    state["n"] += 1
    if state["n"] >= 6:                      # cid + 5 条增量已入 buf
        clock.now = 1750000000.0 + config.KB_STREAM_TIMEOUT_SEC + 1.0


chunks_b = [CID_LINE] + split_deltas(PARTIAL, 5) + [delta_line("永远不会被处理的后续增量")]
_run("B 流中途 150s deadline 到点（294字后 break）", chunks_b,
     on_yield=bump_clock, clock=clock)

# ── 场景C（claim 子例）：cid 未到手前断，前置 50 字 ────────
chunks_c = [delta_line("x" * 25), delta_line("y" * 25)]   # conversation_init 之前
_run("C 流在 conversation_init 之前断（cid 空，前置50字增量）", chunks_c,
     exc=ConnectionError("reset before conversation_init"))

# ── 场景D（对照）：完整流正常走完 ──────────────────────────
chunks_d = [CID_LINE] + split_deltas(FULL_ANSWER, 20) + [DONE_LINE]
_run("D 对照：完整流（1414字 + 终止标记）", chunks_d)

print("=" * 72)
print("MIN_ANSWER_LEN=%d  KB_STREAM_TIMEOUT_SEC=%d  KB_POLL_MAX_ROUNDS=%d"
      % (config.MIN_ANSWER_LEN, config.KB_STREAM_TIMEOUT_SEC, config.KB_POLL_MAX_ROUNDS))
