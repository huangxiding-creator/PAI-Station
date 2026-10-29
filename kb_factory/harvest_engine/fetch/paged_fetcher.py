# -*- coding: utf-8 -*-
"""分页拉取状态机 paged_fetcher（T06；支撑 FR2.2/FR3.1/FR4.1，FR2.3 熔断缝）。

与站点解耦的可复用状态机（同步 run / 异步 arun）：站点原始响应 → BatchResponse
的归一化由各适配器注入的 fetch_fn/afetch_fn 负责（T19 book118 / T22 wenku / T27 doc88），
本件只管五件事——游标推进、批大小、节流、重试上限、无进展熔断——外加页号 int 归一
（防 "10"<"2" 字典序坑，BOOK118_SPEC §5-6）。

三源参数化（SYNTHESIS §2-2，预设构造器 PagedFetcher.for_wenku/for_book118/for_doc88）：
- wenku（WENKU_SPEC §3.2）：rn=50 批；pn=showPage+1 起批，服务端新 showPage 推进游标；
  ok 空批不算失败（走无进展计数）；信封失败即停（§8-4 → max_retries=0）。
- book118（BOOK118_SPEC §1/§3）：6 页批 i=1,7,13,19,...本地步进；首响应发现 limit；
  limit%6==1 末批单页自然成立；批间≥1s；单批失败重试≤5。
- doc88（DOC88_SPEC §1.3/§1.4）：PH 全层 + PK 逐页分层遍历；层归属以页表 e 字段为准
  （调用方传 page_levels，不自行推算 50 页分层）。

确定性纪律：clock/sleep/asleep 三点可注入（单测零真实 sleep；缺省=time.monotonic/
time.sleep/asyncio.sleep）。终态四型：exhausted（游标/工作清单耗尽）/
no_progress（连续 no_progress_limit 轮零推进熔断，FR2.3 阈值=3，下游据此标
needs_vip_candidate）/ fetch_failed（批失败且重试耗尽）/ aborted（外部停止信号，
wenku AbortSignal 同型）。

数字零造假：requests/batches_ok/retries/no_progress_rounds 全为实发事实计数；
coverage 形态 "got/limit"（对齐 adapters.base.LadderResult.coverage 口径）。
边界前提：limit 必须来自配置或首响应（三源规格均保证），本件不设轮数兜底上限。
"""
from __future__ import annotations

import asyncio
import inspect
import time
from abc import ABC, abstractmethod
from collections.abc import Callable, Mapping, Sequence
from dataclasses import dataclass, field
from typing import Any

WENKU_RN = 50                    # wenku 每批页数（WENKU_SPEC §3.2 rn=50）
BOOK118_STEP = 6                 # book118 每批页数（BOOK118_SPEC §1 PARSE_STEP=6）
BOOK118_BATCH_INTERVAL = 1.0     # book118 批间隔（BOOK118_SPEC §3 实测频控：批间≥1s）
BOOK118_MAX_RETRIES = 5          # book118 单批重试上限（BOOK118_SPEC §3：≤5 次）
NO_PROGRESS_LIMIT = 3            # 连续零进展轮数熔断阈值（FR2.3：连续 3 轮零进展）

STOP_EXHAUSTED = "exhausted"     # 游标/工作清单耗尽（自然终态）
STOP_NO_PROGRESS = "no_progress" # 无进展熔断（FR2.3 缝：下游标 needs_vip_candidate）
STOP_FETCH_FAILED = "fetch_failed"  # 批失败且重试耗尽
STOP_ABORTED = "aborted"         # 外部停止信号


def coerce_page_key(key: Any) -> int:
    """页号归一为 int（防 "10"<"2" 字典序坑，BOOK118_SPEC §5-6）；非数字键硬拒不吞页。"""
    if isinstance(key, bool):
        raise ValueError(f"页号不可为布尔值: {key!r}")
    if isinstance(key, int):
        return key
    if isinstance(key, float) and key.is_integer():
        return int(key)
    if isinstance(key, str) and key.strip().isdecimal():
        return int(key.strip())
    raise ValueError(f"页号必须可转 int（防字典序坑）: {key!r}")


def sorted_page_numbers(pages: Mapping) -> list[int]:
    """按 int 升序取页号（状态机与适配器共用的统一出口）。"""
    return sorted(coerce_page_key(k) for k in pages)


@dataclass
class BatchResponse:
    """归一化批响应（适配器把站点原始响应转成此形再喂状态机）。

    - pages：本批新页 {页号: payload}；键 int 或数字字符串（状态机强制 int 归一）。
    - headers：非页载荷（doc88 层头 PH 等），键由适配器定（如 "PH_L1"）。
    - cursor：服务端新游标（wenku 新 showPage）；本地步进/工作清单型可不填。
    - limit：本批发现的总页数上限（book118 pages.preview 等）；不变则不填。
    """

    ok: bool
    pages: dict = field(default_factory=dict)
    headers: dict = field(default_factory=dict)
    cursor: int | None = None
    limit: int | None = None
    detail: str = ""


@dataclass
class FetchState:
    """单次 run 的状态机全部状态（每轮从 policy.init_state() 重建 → 实例可复用）。"""

    cursor: int = 1                 # 游标：showPage 型=已可得页数；步进型=下一批首页；清单型=0
    limit: int | None = None        # 总页数上限（配置给定或首响应发现）
    pages: dict = field(default_factory=dict)    # 已收页 {int 页号: payload}
    headers: dict = field(default_factory=dict)  # 非页载荷（PH 层头等）
    pending: list = field(default_factory=list)  # 工作清单（doc88 PH+PK 用）
    pending_pos: int = 0
    requests: int = 0               # 实发请求次数（初发+重试全计）
    batches_ok: int = 0             # 成功并入的批数
    retries: int = 0                # 实发重试次数
    no_progress_rounds: int = 0     # 连续零进展轮数（有进展即清零）
    stopped_reason: str | None = None
    notes: list = field(default_factory=list)    # 终态事实（进 result.detail）


@dataclass
class PagedFetchResult:
    """状态机终态产物（字段序=本件契约，不得增删改名；计数全为实测）。"""

    ok: bool                        # 仅 exhausted 为 True（部分收割如实 False）
    pages: dict                     # {int 页号: payload}
    page_numbers: list              # int 升序页号（防字典序）
    headers: dict                   # 非页载荷（doc88 PH 等）
    requests: int
    batches_ok: int
    retries: int
    cursor: int                     # 终游标（wenku=最终 showPage）
    limit: int | None               # 终 limit（未知=None）
    no_progress_rounds: int         # 熔断时的连续零进展轮数（未熔断=0）
    stopped_reason: str             # exhausted/no_progress/fetch_failed/aborted
    coverage: str                   # "got/limit"；limit 未知则 "got/?"
    detail: str = ""


def _merge_pages(state: FetchState, resp: BatchResponse) -> int:
    """并入本批页（int 归一键，幂等覆盖）；返回新增页数（进展判定用）。"""
    new = 0
    for key, payload in resp.pages.items():
        page_no = coerce_page_key(key)
        if page_no not in state.pages:
            new += 1
        state.pages[page_no] = payload
    return new


def _merge_headers(state: FetchState, resp: BatchResponse) -> int:
    """并入非页载荷（PH 层头等）；返回新增键数。"""
    new = 0
    for key, payload in resp.headers.items():
        if key not in state.headers:
            new += 1
        state.headers[key] = payload
    return new


class CursorPolicy(ABC):
    """游标策略：决定下一请求与响应并入——状态机与站点解耦的核心缝。"""

    name = "abstract"

    @abstractmethod
    def init_state(self) -> FetchState:
        """每轮 run 的初始状态（策略自带配置 → 实例可复用）。"""

    @abstractmethod
    def next_request(self, state: FetchState) -> dict | None:
        """下一请求参数；None=游标/工作清单耗尽（自然终态）。"""

    @abstractmethod
    def absorb(self, state: FetchState, resp: BatchResponse) -> bool:
        """并入有效批响应并推进游标；返回是否有进展（新页/新头/游标推进）。"""

    def batch_ok(self, resp: BatchResponse) -> bool:
        """批有效性（无效=进重试路径）；默认=ok 且带新内容。"""
        return bool(resp.ok and (resp.pages or resp.headers))


class ShowPageCursor(CursorPolicy):
    """wenku 型（WENKU_SPEC §3.2）：pn=showPage+1、rn=批大小；服务端新 showPage 推进游标。

    ok 空批视为有效（推进与否由 absorb 判）→ 走无进展计数而非重试；
    信封失败（适配器映射 ok=False，如 status.code!=0 / tri_cap 硬态）走重试路径
    （wenku 预设 max_retries=0 → 即刻 fetch_failed，等价 §8-4 中断补页循环）。
    """

    name = "wenku_showpage"

    def __init__(self, start_show_page: int, total_pages: int, batch_size: int = WENKU_RN):
        if int(total_pages) < 0 or int(start_show_page) < 0 or int(batch_size) <= 0:
            raise ValueError("start_show_page/total_pages 须≥0 且 batch_size>0")
        self.batch_size = int(batch_size)
        self._start = int(start_show_page)
        self._total = int(total_pages)

    def init_state(self) -> FetchState:
        return FetchState(cursor=self._start, limit=self._total)

    def next_request(self, state: FetchState) -> dict | None:
        if state.limit is not None and state.cursor >= state.limit:
            return None
        return {"pn": state.cursor + 1, "rn": self.batch_size}

    def absorb(self, state: FetchState, resp: BatchResponse) -> bool:
        new_pages = _merge_pages(state, resp)
        _merge_headers(state, resp)
        advanced = resp.cursor is not None and resp.cursor > state.cursor
        if advanced:
            state.cursor = resp.cursor            # 只进不退（服务端回退游标不采信）
        if resp.limit is not None:
            state.limit = resp.limit if state.limit is None else max(state.limit, resp.limit)
        return advanced or new_pages > 0

    def batch_ok(self, resp: BatchResponse) -> bool:
        return bool(resp.ok)                      # 空批有效：零进展判定交给 absorb


class ArithmeticStep(CursorPolicy):
    """book118 型（BOOK118_SPEC §1）：i=1,7,13,19,... 本地步进（步长=批大小）。

    首响应发现 limit（pages.preview）；停点=cursor>limit → limit%6==1 末批单页自然成立。
    空批（缺本批内容）视为失败进重试（§5-3 移植坑 3）。
    """

    name = "book118_step"

    def __init__(self, step: int = BOOK118_STEP, start: int = 1,
                 total_pages: int | None = None):
        if int(step) <= 0 or int(start) < 1:
            raise ValueError("start 须≥1 且 step>0")
        self.step = int(step)
        self._start = int(start)
        self._total = None if total_pages is None else int(total_pages)

    def init_state(self) -> FetchState:
        return FetchState(cursor=self._start, limit=self._total)

    def next_request(self, state: FetchState) -> dict | None:
        if state.limit is not None and state.cursor > state.limit:
            return None
        return {"page": state.cursor, "rn": self.step}

    def absorb(self, state: FetchState, resp: BatchResponse) -> bool:
        new_pages = _merge_pages(state, resp)
        _merge_headers(state, resp)
        if resp.limit is not None:
            state.limit = resp.limit if state.limit is None else max(state.limit, resp.limit)
        state.cursor += self.step
        return new_pages > 0


class LayeredWorklist(CursorPolicy):
    """doc88 型（DOC88_SPEC §1.3/§1.4）：先全层 PH 头、再逐页 PK，静态工作清单遍历。

    层归属以调用方页表为准（page_levels={页号: 层号}，对应 p_struct 的 e 字段），
    不自行按 50 页推算（SPEC：存在单层超百页例外）。
    """

    name = "doc88_ph_pk"

    def __init__(self, layers: Sequence[int], page_levels: Mapping):
        if not layers:
            raise ValueError("layers 不可为空（至少一层 PH）")
        if not page_levels:
            raise ValueError("page_levels 不可为空（至少一页 PK）")
        self.layers = [int(lv) for lv in layers]
        self.page_levels = {coerce_page_key(p): int(lv) for p, lv in dict(page_levels).items()}

    def init_state(self) -> FetchState:
        pending = [{"kind": "ph", "level": lv} for lv in self.layers]
        pending += [{"kind": "pk", "page": p, "level": self.page_levels[p]}
                    for p in sorted(self.page_levels)]
        return FetchState(cursor=0, limit=len(self.page_levels), pending=pending)

    def next_request(self, state: FetchState) -> dict | None:
        if state.pending_pos >= len(state.pending):
            return None
        item = dict(state.pending[state.pending_pos])
        state.pending_pos += 1
        return item

    def absorb(self, state: FetchState, resp: BatchResponse) -> bool:
        return (_merge_pages(state, resp) + _merge_headers(state, resp)) > 0


class PagedFetcher:
    """分页拉取状态机（可复用：run/arun 每轮重建状态；节流时间戳跨轮保留=跨文档礼貌性）。

    - fetch_fn：同步请求函数 dict(请求参数)→BatchResponse；异常=批失败（进重试）。
    - afetch_fn：异步请求函数；缺省回落 fetch_fn（同步函数在 arun 中直接调用）。
    - min_interval：批间（含重试间）最小间隔秒；0=关闭。clock/sleep/asleep 注入点。
    - max_retries：单批重试上限（0=失败即停；总尝试=1+max_retries）。
    - no_progress_limit：连续零进展熔断阈值（FR2.3 默认 3）。
    - should_stop：轮间外部停止信号（wenku AbortSignal 同型）。
    """

    def __init__(self, policy: CursorPolicy, fetch_fn: Callable | None = None,
                 afetch_fn: Callable | None = None, *, site: str = "",
                 min_interval: float = 1.0, max_retries: int = 0,
                 no_progress_limit: int = NO_PROGRESS_LIMIT,
                 clock: Callable[[], float] | None = None,
                 sleep: Callable[[float], None] | None = None,
                 asleep: Callable | None = None,
                 should_stop: Callable[[], bool] | None = None):
        if fetch_fn is None and afetch_fn is None:
            raise ValueError("fetch_fn 与 afetch_fn 至少注入一个")
        self.policy = policy
        self.fetch_fn = fetch_fn
        self.afetch_fn = afetch_fn
        self.site = site or policy.name
        self.min_interval = float(min_interval)
        self.max_retries = int(max_retries)
        self.no_progress_limit = int(no_progress_limit)
        self._clock = clock or time.monotonic
        self._sleep = sleep or time.sleep
        self._asleep = asleep or asyncio.sleep
        self.should_stop = should_stop
        self._last_ts: float | None = None

    # ------------------------------------------------------------ 预设（三源参数化）

    @classmethod
    def for_wenku(cls, fetch_fn: Callable | None = None, *, start_show_page: int,
                  total_pages: int, min_interval: float = 1.0, max_retries: int = 0,
                  no_progress_limit: int = NO_PROGRESS_LIMIT, **kw) -> "PagedFetcher":
        """wenku（WENKU_SPEC §3.2）：rn=50 批 + showPage 服务端游标 + 信封失败即停（§8-4）。"""
        return cls(ShowPageCursor(start_show_page=start_show_page, total_pages=total_pages),
                   fetch_fn, site="wenku", min_interval=min_interval,
                   max_retries=max_retries, no_progress_limit=no_progress_limit, **kw)

    @classmethod
    def for_book118(cls, fetch_fn: Callable | None = None, *, total_pages: int | None = None,
                    min_interval: float = BOOK118_BATCH_INTERVAL,
                    max_retries: int = BOOK118_MAX_RETRIES, **kw) -> "PagedFetcher":
        """book118（BOOK118_SPEC §1/§3）：6 页批 i=1,7,13,... + 批间≥1s + 单批重试≤5。"""
        return cls(ArithmeticStep(step=BOOK118_STEP, total_pages=total_pages),
                   fetch_fn, site="book118", min_interval=min_interval,
                   max_retries=max_retries, **kw)

    @classmethod
    def for_doc88(cls, fetch_fn: Callable | None = None, *, layers: Sequence[int],
                  page_levels: Mapping, min_interval: float = 1.0, max_retries: int = 0,
                  **kw) -> "PagedFetcher":
        """doc88（DOC88_SPEC §1.3/§1.4）：PH 全层 + PK 逐页；层归属以页表为准。"""
        return cls(LayeredWorklist(layers=layers, page_levels=page_levels),
                   fetch_fn, site="doc88", min_interval=min_interval,
                   max_retries=max_retries, **kw)

    # ------------------------------------------------------------ 同步驱动

    def run(self) -> PagedFetchResult:
        """同步驱动状态机至终态（四型之一），返回实测计数齐备的 PagedFetchResult。"""
        if self.fetch_fn is None:
            raise RuntimeError("run() 需同步 fetch_fn（异步链路用 arun()）")
        state = self.policy.init_state()
        while self._round_top(state):
            req = self.policy.next_request(state)
            if req is None:
                self._mark_exhausted(state)
                break
            attempts = 0
            while True:
                self._throttle()
                state.requests += 1
                try:
                    resp = self.fetch_fn(dict(req))
                except Exception as exc:           # 网络/解析异常=批失败（进重试，不中止进程）
                    resp = BatchResponse(ok=False, detail=f"{type(exc).__name__}: {exc}")
                if self.policy.batch_ok(resp):
                    break
                attempts += 1
                if not self._on_batch_failure(state, req, resp, attempts):
                    break
            if state.stopped_reason is not None:
                break
            if not self._round_end(state, resp):
                break
        return self._finish(state)

    # ------------------------------------------------------------ 异步驱动

    async def arun(self) -> PagedFetchResult:
        """异步驱动状态机（afetch_fn 注入；缺省回落同步 fetch_fn 直调）。"""
        fetch = self.afetch_fn or self.fetch_fn
        state = self.policy.init_state()
        while self._round_top(state):
            req = self.policy.next_request(state)
            if req is None:
                self._mark_exhausted(state)
                break
            attempts = 0
            while True:
                await self._athrottle()
                state.requests += 1
                try:
                    got = fetch(dict(req))
                    resp = await got if inspect.isawaitable(got) else got
                except Exception as exc:
                    resp = BatchResponse(ok=False, detail=f"{type(exc).__name__}: {exc}")
                if self.policy.batch_ok(resp):
                    break
                attempts += 1
                if not self._on_batch_failure(state, req, resp, attempts):
                    break
            if state.stopped_reason is not None:
                break
            if not self._round_end(state, resp):
                break
        return self._finish(state)

    # ------------------------------------------------------------ 共用轮步进

    def _round_top(self, state: FetchState) -> bool:
        """轮顶：外部停止信号检查（返回 False=终态）。"""
        if self.should_stop is not None and self.should_stop():
            state.stopped_reason = STOP_ABORTED
            state.notes.append("外部停止信号触发（wenku AbortSignal 同型）")
            return False
        return True

    def _round_end(self, state: FetchState, resp: BatchResponse) -> bool:
        """轮尾：并入响应 + 无进展熔断判定（返回 False=终态）。"""
        progress = self.policy.absorb(state, resp)
        state.batches_ok += 1
        if progress:
            state.no_progress_rounds = 0
            return True
        state.no_progress_rounds += 1
        if state.no_progress_rounds >= self.no_progress_limit:
            state.stopped_reason = STOP_NO_PROGRESS
            state.notes.append(f"无进展熔断: 连续{state.no_progress_rounds}轮零推进 "
                               f"cursor={state.cursor} got={len(state.pages)}/{state.limit}")
            return False
        return True

    def _on_batch_failure(self, state: FetchState, req: dict, resp: BatchResponse,
                          attempts: int) -> bool:
        """记一次批失败；返回 True=还有重试额度（继续尝试）。"""
        if attempts > self.max_retries:
            state.stopped_reason = STOP_FETCH_FAILED
            state.notes.append(f"批失败且重试耗尽({self.max_retries}): req={req} "
                               f"detail={resp.detail}")
            return False
        state.retries += 1
        state.notes.append(f"批失败重试 {state.retries}/{self.max_retries}: req={req} "
                           f"detail={resp.detail}")
        return True

    def _mark_exhausted(self, state: FetchState) -> None:
        state.stopped_reason = STOP_EXHAUSTED
        state.notes.append(f"游标耗尽: cursor={state.cursor} got={len(state.pages)}/{state.limit}")

    # ------------------------------------------------------------ 节流（可注入）

    def _throttle(self) -> None:
        """同步节流：距上次请求不足 min_interval 则 sleep 补足（clock/sleep 注入点）。"""
        if self.min_interval <= 0:
            return
        now = self._clock()
        if self._last_ts is None:
            self._last_ts = now
            return
        wait = self.min_interval - (now - self._last_ts)
        if wait > 0:
            self._sleep(wait)
        self._last_ts = self._clock()

    async def _athrottle(self) -> None:
        """异步节流：同 _throttle（asleep 注入点，缺省 asyncio.sleep）。"""
        if self.min_interval <= 0:
            return
        now = self._clock()
        if self._last_ts is None:
            self._last_ts = now
            return
        wait = self.min_interval - (now - self._last_ts)
        if wait > 0:
            await self._asleep(wait)
        self._last_ts = self._clock()

    # ------------------------------------------------------------ 终态产物

    def _finish(self, state: FetchState) -> PagedFetchResult:
        reason = state.stopped_reason or STOP_EXHAUSTED
        page_numbers = sorted_page_numbers(state.pages)
        limit = state.limit
        coverage = f"{len(page_numbers)}/{limit}" if limit is not None else f"{len(page_numbers)}/?"
        return PagedFetchResult(
            ok=reason == STOP_EXHAUSTED,
            pages=dict(state.pages),
            page_numbers=page_numbers,
            headers=dict(state.headers),
            requests=state.requests,
            batches_ok=state.batches_ok,
            retries=state.retries,
            cursor=state.cursor,
            limit=limit,
            no_progress_rounds=state.no_progress_rounds,
            stopped_reason=reason,
            coverage=coverage,
            detail="; ".join(state.notes),
        )
