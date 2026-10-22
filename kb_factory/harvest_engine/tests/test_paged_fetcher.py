# -*- coding: utf-8 -*-
"""T06 单测：分页拉取状态机 paged_fetcher（支撑 FR2.2/FR3.1/FR4.1；FR2.3 熔断缝）。

- 驱动体=本地确定性 fetch_fn（零网络、零 mock 框架）；被测物=状态机本体：
  游标推进/批大小/节流/重试上限/页号 int 排序/无进展熔断。
- 时钟注入确定性：全部走 FakeTimeline（clock/sleep/asleep 三注入），全程零真实 sleep。
- 三源参数化按规格：wenku rn=50 批 showPage 游标（WENKU_SPEC §3.2）/
  book118 6 页批 i=1,7,13,...（BOOK118_SPEC §1）/ doc88 PH+PK 分层遍历（DOC88_SPEC §1.3）。
- 站点原始响应→BatchResponse 归一化由各适配器（T19/T22/T27）负责；本件与站点解耦。
"""
import asyncio
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.fetch.paged_fetcher import (  # noqa: E402
        BOOK118_BATCH_INTERVAL, BOOK118_MAX_RETRIES, BOOK118_STEP, NO_PROGRESS_LIMIT, WENKU_RN,
        ArithmeticStep, BatchResponse, LayeredWorklist, PagedFetchResult, PagedFetcher,
        ShowPageCursor, coerce_page_key, sorted_page_numbers)
except ImportError:
    from harvest_engine.fetch.paged_fetcher import (  # noqa: E402
        BOOK118_BATCH_INTERVAL, BOOK118_MAX_RETRIES, BOOK118_STEP, NO_PROGRESS_LIMIT, WENKU_RN,
        ArithmeticStep, BatchResponse, LayeredWorklist, PagedFetchResult, PagedFetcher,
        ShowPageCursor, coerce_page_key, sorted_page_numbers)


class FakeTimeline:
    """确定性假时钟：sleep/asleep 即推进虚拟时间并留痕（零真实等待，单测不真睡）。"""

    def __init__(self):
        self.now = 0.0
        self.waits: list[float] = []

    def clock(self) -> float:
        return self.now

    def sleep(self, seconds: float) -> None:
        self.waits.append(round(seconds, 9))
        self.now += seconds

    async def asleep(self, seconds: float) -> None:
        self.sleep(seconds)


def _b118_batch(start: int, limit: int) -> BatchResponse:
    """book118 openapi 批响应仿真：start 起连续 6 页（键=数字字符串），尾批自然截断。"""
    end = min(start + BOOK118_STEP - 1, limit)
    return BatchResponse(ok=True, limit=limit,
                         pages={str(i): f"//view-cache.book118.com/view1/{i}.png"
                                for i in range(start, end + 1)})


# ---------------------------------------------------------------- wenku（FR2.2/FR2.3）

def test_fr2_2_wenku_showpage_cursor_rn50_batch():
    """FR2.2（WENKU_SPEC §3.2）：pn=showPage+1 起批、rn=50、响应新 showPage 推进至 total。"""
    tl = FakeTimeline()
    reqs = []

    def fetch(req):
        reqs.append(dict(req))
        pn = req["pn"]
        new_show = min(pn + WENKU_RN - 1, 100)
        return BatchResponse(ok=True, cursor=new_show,
                             pages={i: f"htmlUrls#{i}" for i in range(pn, new_show + 1)})

    res = PagedFetcher.for_wenku(fetch, start_show_page=8, total_pages=100,
                                 clock=tl.clock, sleep=tl.sleep).run()
    assert isinstance(res, PagedFetchResult)
    assert [r["pn"] for r in reqs] == [9, 59]           # pn=游标+1；两批到顶
    assert all(r["rn"] == 50 for r in reqs)             # rn=50 批（WENKU_SPEC §3.2）
    assert res.ok and res.stopped_reason == "exhausted"
    assert res.page_numbers == list(range(9, 101)) and len(res.pages) == 92
    assert res.cursor == 100 and res.limit == 100 and res.coverage == "92/100"
    assert res.requests == 2 and res.retries == 0


def test_fr2_3_wenku_no_progress_circuit_three_rounds_then_break():
    """FR2.3 缝：ok 信封但 showPage 不动+零新页 → 连续 3 轮熔断（下游据此标 needs_vip_candidate）。"""
    tl = FakeTimeline()

    def fetch(req):
        return BatchResponse(ok=True, cursor=20, pages={})  # 服务端卡在 20（tri_cap 映射归 T22）

    res = PagedFetcher.for_wenku(fetch, start_show_page=20, total_pages=60,
                                 clock=tl.clock, sleep=tl.sleep).run()
    assert not res.ok and res.stopped_reason == "no_progress"
    assert res.requests == NO_PROGRESS_LIMIT == 3
    assert res.no_progress_rounds == 3 and res.coverage == "0/60"
    assert "无进展" in res.detail


def test_fr2_3_wenku_progress_resets_no_progress_counter():
    """FR2.3：有进展轮清零计数；随后连续 3 轮零进展才熔断。"""
    tl = FakeTimeline()
    rounds = []

    def fetch(req):
        rounds.append(req["pn"])
        if len(rounds) == 1:
            return BatchResponse(ok=True, cursor=40, pages={i: i for i in range(21, 41)})
        return BatchResponse(ok=True, cursor=40, pages={})  # 之后卡死

    res = PagedFetcher.for_wenku(fetch, start_show_page=20, total_pages=60,
                                 clock=tl.clock, sleep=tl.sleep).run()
    assert res.stopped_reason == "no_progress" and res.requests == 4
    assert res.no_progress_rounds == 3 and len(res.pages) == 20


# ---------------------------------------------------------------- book118（FR3.1）

def test_fr3_1_book118_step_6_and_page_numbers_int_sorted():
    """FR3.1（BOOK118_SPEC §1）：i=1,7,13,... 6 页批；页号 int 升序（防 "10"<"2" 字典序）。"""
    tl = FakeTimeline()
    reqs = []

    def fetch(req):
        reqs.append(req["page"])
        return _b118_batch(req["page"], 101)

    res = PagedFetcher.for_book118(fetch, clock=tl.clock, sleep=tl.sleep).run()
    assert reqs == list(range(1, 102, 6))               # 1,7,13,...,97；下一 103>101 停
    assert len(reqs) == 17
    assert res.ok and res.stopped_reason == "exhausted"
    assert res.page_numbers == list(range(1, 102))
    assert res.page_numbers[1:4] == [2, 3, 4] and res.page_numbers[9] == 10
    # 反例留痕：字典序会把 "10"/"100" 排在 "2" 前——本件不走这条路
    assert sorted(str(i) for i in range(1, 102))[:3] == ["1", "10", "100"]
    assert res.coverage == "101/101"


def test_fr3_1_book118_limit_mod6_eq1_last_batch_single_page():
    """FR3.1：limit%6==1 时末批仅 1 页（原作修过的漏页坑）→ 不漏不重。"""
    tl = FakeTimeline()
    reqs = []
    batches = {}

    def fetch(req):
        reqs.append(req["page"])
        batches[req["page"]] = _b118_batch(req["page"], 13)
        return batches[req["page"]]

    res = PagedFetcher.for_book118(fetch, clock=tl.clock, sleep=tl.sleep).run()
    assert reqs == [1, 7, 13]
    assert sorted(batches[13].pages) == ["13"]          # 末批单页
    assert res.ok and res.page_numbers == list(range(1, 14)) and res.coverage == "13/13"


def test_fr3_1_book118_throttle_via_injected_clock_no_real_sleep():
    """FR3.1（BOOK118_SPEC §3）：批间≥1s 节流走注入 sleep（确定性，零真实等待）；0=关闭。"""
    tl = FakeTimeline()
    fx = PagedFetcher.for_book118(lambda req: _b118_batch(req["page"], 13),
                                  clock=tl.clock, sleep=tl.sleep)
    res = fx.run()
    assert tl.waits == [1.0, 1.0]                       # 首发不睡；批间各睡 1s（共 3 批）
    assert res.requests == 3 and res.ok

    tl0 = FakeTimeline()
    res0 = PagedFetcher.for_book118(lambda req: _b118_batch(req["page"], 13),
                                    min_interval=0, clock=tl0.clock, sleep=tl0.sleep).run()
    assert tl0.waits == [] and res0.ok                  # min_interval=0 不节流


def test_fr3_1_book118_retry_cap_five_then_fetch_failed():
    """FR3.1（BOOK118_SPEC §3）：单批失败重试≤5；耗尽即 fetch_failed 终态（部分页如实保留）。"""
    tl = FakeTimeline()
    calls = []

    def fetch(req):
        calls.append(req["page"])
        if req["page"] == 13:
            raise IOError("openapi 空响应")             # 网络/信封异常同型：进重试
        return _b118_batch(req["page"], 13)

    res = PagedFetcher.for_book118(fetch, min_interval=0, clock=tl.clock, sleep=tl.sleep).run()
    assert calls == [1, 7] + [13] * (BOOK118_MAX_RETRIES + 1)  # 初发+5 重试=6 次
    assert res.retries == BOOK118_MAX_RETRIES == 5
    assert not res.ok and res.stopped_reason == "fetch_failed"
    assert res.requests == 8
    assert res.page_numbers == list(range(1, 13)) and res.coverage == "12/13"


def test_fr3_1_book118_transient_failure_recovers_within_cap():
    """FR3.1：瞬时失败在额度内恢复 → 重试计数如实、终态 exhausted。"""
    tl = FakeTimeline()
    n = {"fail": 0}

    def fetch(req):
        if req["page"] == 7 and n["fail"] < 2:
            n["fail"] += 1
            return BatchResponse(ok=False, detail="status!=200")
        return _b118_batch(req["page"], 13)

    res = PagedFetcher.for_book118(fetch, min_interval=0, clock=tl.clock, sleep=tl.sleep).run()
    assert res.ok and res.stopped_reason == "exhausted"
    assert res.retries == 2 and res.requests == 3 + 2
    assert res.page_numbers == list(range(1, 14))


# ---------------------------------------------------------------- doc88（FR4.1）

def test_fr4_1_doc88_ph_all_layers_then_pk_per_page():
    """FR4.1（DOC88_SPEC §1.3/§1.4）：先全层 PH、再逐页 PK；层归属以页表为准、遍历按页号升序。"""
    tl = FakeTimeline()
    page_levels = {}
    for p in range(1, 119):                             # 实测样例同形：119 页 3 层
        page_levels[p] = 1 if p <= 50 else (2 if p <= 100 else 3)
    page_levels[60] = 1                                 # 例外页：单层超 50（SPEC：以页表 e 字段为准）
    reqs = []

    def fetch(req):
        reqs.append(dict(req))
        if req["kind"] == "ph":
            return BatchResponse(ok=True, headers={f"PH_L{req['level']}": b"YBD\x01" + b"\x00" * 36})
        return BatchResponse(ok=True, pages={req["page"]: {"level": req["level"], "blob": b"PK32"}})

    res = PagedFetcher.for_doc88(fetch, layers=[1, 2, 3], page_levels=page_levels,
                                 clock=tl.clock, sleep=tl.sleep).run()
    assert [(r["kind"], r.get("level")) for r in reqs[:3]] == [("ph", 1), ("ph", 2), ("ph", 3)]
    pk_pages = [r["page"] for r in reqs[3:]]
    assert pk_pages == list(range(1, 119))              # PK 逐页且页号升序（int 序）
    assert reqs[3 + 59]["level"] == 1                   # 第 60 页例外层如实按页表走
    assert set(res.headers) == {"PH_L1", "PH_L2", "PH_L3"}
    assert res.ok and res.page_numbers == list(range(1, 119)) and res.coverage == "118/118"
    assert res.requests == 3 + 118


# ---------------------------------------------------------------- 通用状态机性质

def test_arun_async_parity_with_sync_and_injected_asleep():
    """async 状态机与同步逐字段一致；异步节流走注入 asleep（零真实 asyncio.sleep 等待）。"""
    tl_s, tl_a = FakeTimeline(), FakeTimeline()

    def sync_fetch(req):
        return _b118_batch(req["page"], 19)             # 批序 1,7,13,19 → 4 批

    async def async_fetch(req):
        return _b118_batch(req["page"], 19)

    res_s = PagedFetcher.for_book118(sync_fetch, clock=tl_s.clock, sleep=tl_s.sleep).run()
    res_a = asyncio.run(PagedFetcher.for_book118(
        async_fetch, clock=tl_a.clock, sleep=tl_a.sleep, asleep=tl_a.asleep).arun())
    assert res_a == res_s                               # dataclass 全字段一致（含 detail/coverage）
    assert tl_a.waits == [1.0, 1.0, 1.0] and tl_s.waits == [1.0, 1.0, 1.0]


def test_page_key_coercion_int_order_and_strict_reject():
    """页号 int 归一（防字典序）+ 非数字键硬拒（ValueError 直抛，不静默丢页）。"""
    assert sorted_page_numbers({"10": 0, "2": 0, "1": 0}) == [1, 2, 10]
    assert sorted_page_numbers({12: 0, 2: 0}) == [2, 12]
    assert coerce_page_key("007") == 7
    for bad in ("abc", "1a", "", None, [1]):
        with pytest.raises(ValueError):
            coerce_page_key(bad)

    def bad_fetch(req):
        return BatchResponse(ok=True, pages={"封面": 1}, limit=3)

    tl = FakeTimeline()
    with pytest.raises(ValueError):
        PagedFetcher.for_book118(bad_fetch, total_pages=3, min_interval=0,
                                 clock=tl.clock, sleep=tl.sleep).run()


def test_should_stop_aborts_between_rounds():
    """外部停止信号（wenku AbortSignal 同型）：轮间检查、已得页如实保留。"""
    tl = FakeTimeline()
    calls = []

    def fetch(req):
        calls.append(req["page"])
        return _b118_batch(req["page"], 19)

    res = PagedFetcher.for_book118(fetch, min_interval=0, clock=tl.clock, sleep=tl.sleep,
                                   should_stop=lambda: len(calls) >= 2).run()
    assert res.stopped_reason == "aborted" and not res.ok
    assert res.requests == 2 and res.page_numbers == list(range(1, 13))


def test_fetcher_instance_reusable_across_runs():
    """可复用性：同一实例二次 run 状态独立（run/arun 每轮从 policy.init_state 重建）。"""
    tl = FakeTimeline()
    fx = PagedFetcher.for_book118(lambda req: _b118_batch(req["page"], 13),
                                  min_interval=0, clock=tl.clock, sleep=tl.sleep)
    r1, r2 = fx.run(), fx.run()
    assert r1 == r2 and r1.ok and r1.page_numbers == list(range(1, 14))


def test_preset_params_match_three_source_specs():
    """三源参数化落位：wenku rn=50/信封失败即停；book118 步6/批间1s/重试5；doc88 单项重试默认关。"""
    def dummy(req):                                     # 只验参数落位，不 run
        return BatchResponse(ok=True)

    fx_w = PagedFetcher.for_wenku(dummy, start_show_page=0, total_pages=1)
    assert isinstance(fx_w.policy, ShowPageCursor) and fx_w.policy.batch_size == WENKU_RN == 50
    assert fx_w.max_retries == 0 and fx_w.no_progress_limit == NO_PROGRESS_LIMIT == 3
    fx_b = PagedFetcher.for_book118(dummy)
    assert isinstance(fx_b.policy, ArithmeticStep) and fx_b.policy.step == BOOK118_STEP == 6
    assert fx_b.min_interval == BOOK118_BATCH_INTERVAL == 1.0
    assert fx_b.max_retries == BOOK118_MAX_RETRIES == 5
    fx_d = PagedFetcher.for_doc88(dummy, layers=[1], page_levels={1: 1})
    assert isinstance(fx_d.policy, LayeredWorklist) and fx_d.max_retries == 0
