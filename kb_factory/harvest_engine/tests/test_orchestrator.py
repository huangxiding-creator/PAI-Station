# -*- coding: utf-8 -*-
"""T40 单测：orchestrator 订单编排 + progress_events 施工直播（FR9.1）。

被测物 = kb_factory.harvest_engine.orchestrator + progress_events（引擎总装件）：
订单(order_id/blueprint_slots/budget) → 收割计划(slot/FileMeta/adapter/ladder_try
含 L1/L2/L3/red_check 双红线检查点) → 两段式执行（collect→收口浏览器→dispatch，
T38 实锤 sync_playwright 不可嵌套）→ 质检（段4 verify 真符号）→ 镜像树 →
既有交付链（fulfillment 真符号非 mock）→ progress_events 事件件。

测试纪律（WORKER_CONVENTIONS）：
- 适配器注入替身 = 真 DownloadAdapter 子类四段（StubAdapter），网络腿注入确定性响应
  （同 T22 手法：脚本化 Step + 可推进 FakeClock 注入 elapsed/信封/attempt 事件流）；
- 降级判定不桩：真消费 adapters/base.should_degrade+next_ladder（T16）；
- 信封三态不桩：真 EnvelopeNeedVerify 喂 account_pool 真符号（T29）；
- 红线检查不桩：真 fulfillment.sources_registry 口径（registry_fn 注入可控态）；
- 交付链不桩：fulfillment.pipeline.run 真链路跑通（蓝图/镜像语料全 tmp 落盘）；
- 产物 PDF 用 pypdfium2 真建（质检水印抽帧=真符号实测 ink 比）；台账/事件写 tmp_path。
- 实弹归 T42（E2E）；本件零网络。
"""
import json
import sys
import zipfile
from dataclasses import dataclass
from pathlib import Path

import pypdfium2
import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.fulfillment.sources_registry import ChannelStatus
    from kb_factory.harvest_engine.adapters.base import (
        LADDER_ORDER, AttemptEvent, DownloadAdapter, HarvestPlan, LadderResult,
        WALL_BLOCKED_WAF, WALL_NEEDS_VIP_CANDIDATE)
    from kb_factory.harvest_engine.account_pool.pool import AccountPool
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.envelope import EnvelopeNeedVerify
    from kb_factory.harvest_engine.orchestrator import (
        ACCEPTED_SITES, OCR_SLICE_PAGE_FLOOR, OCR_SLICE_SECONDS_DEFAULT, HarvestArtifact,
        HarvestBudget, HarvestOrder, Orchestrator, default_adapters, ocr_slice_plan,
        site_for_slot, slot_to_filemeta, to_fulfillment_order)
    from kb_factory.harvest_engine.progress_events import (
        EVENT_FIELDS, MINIPROGRAM_CHANNEL, ProgressEvents)
except ImportError:
    from channel_adapters.base import FileMeta  # type: ignore
    from fulfillment.sources_registry import ChannelStatus  # type: ignore
    from harvest_engine.adapters.base import (  # type: ignore
        LADDER_ORDER, AttemptEvent, DownloadAdapter, HarvestPlan, LadderResult,
        WALL_BLOCKED_WAF, WALL_NEEDS_VIP_CANDIDATE)
    from harvest_engine.account_pool.pool import AccountPool  # type: ignore
    from harvest_engine.audit import HarvestAudit  # type: ignore
    from harvest_engine.envelope import EnvelopeNeedVerify  # type: ignore
    from harvest_engine.orchestrator import (  # type: ignore
        ACCEPTED_SITES, OCR_SLICE_PAGE_FLOOR, OCR_SLICE_SECONDS_DEFAULT, HarvestArtifact,
        HarvestBudget, HarvestOrder, Orchestrator, default_adapters, ocr_slice_plan,
        site_for_slot, slot_to_filemeta, to_fulfillment_order)
    from harvest_engine.progress_events import (  # type: ignore
        EVENT_FIELDS, MINIPROGRAM_CHANNEL, ProgressEvents)


# ---------------------------------------------------------------- 确定性基建（时间/网络注入点）

class FakeClock:
    """可推进单调钟：腿内 tick 模拟耗时（编排层实测 elapsed 的确定性注入点）。"""

    def __init__(self, start: float = 1000.0):
        self.now = float(start)

    def __call__(self) -> float:
        return self.now

    def advance(self, seconds: float) -> None:
        self.now += float(seconds)


def build_real_pdf(path, pages: int = 1) -> Path:
    """pypdfium2 真建最小 PDF（产物非伪造字节；质检水印抽帧可实测）。"""
    doc = pypdfium2.PdfDocument.new()
    for _ in range(max(1, pages)):
        doc.new_page(300, 400)
    doc.save(str(path))
    return Path(path)


@dataclass
class Step:
    """单腿脚本化确定性响应（网络腿注入，同 T22 手法）。"""
    ok: bool = True
    wall_status: str | None = None
    coverage: str | None = None
    pages: int | None = 1
    chars: int | None = 800
    attempt_events: tuple = ()       # 适配器自报失败事件流（喂 should_degrade，T16）
    envelopes: tuple = ()            # 信封三态事件流（喂 account_pool，T29）
    tick: float = 0.1                # 腿内时钟推进（编排层实测 elapsed→超时门）


@dataclass
class StubBundle:
    """两段式采集产物替身（对应 wenku ReaderInfoLegResult 位形）。"""
    doc_id: str
    meta: FileMeta


class StubAdapter(DownloadAdapter):
    """真 DownloadAdapter 子类四段替身：计划/采集/重组/质检全按脚本确定性响应。

    - two_stage=True 走 collect_reader_info+dispatch_reconstruction 两段式调用面
      （编排层按 T38 约束分阶段调度）；False 走单段 fetch_ladder（book118/doc88 位形）；
    - last_attempt_events/last_envelope_events=编排层消费的自报事件流（每腿重置）；
    - seen_ladder_tries 记录编排层实际传入的梯队窄化序（降级循环本体在编排层的实证）。
    """

    def __init__(self, site: str, *, two_stage: bool, log: list, clock: FakeClock,
                 out_dir: Path, steps: dict, verify_map: dict | None = None):
        self.site = site
        self.channel = site
        self.two_stage = two_stage
        self._log = log
        self._clock = clock
        self._out_dir = Path(out_dir)
        self._steps = dict(steps)
        self._verify = dict(verify_map or {})
        self.last_attempt_events: list = []
        self.last_envelope_events: list = []
        self.seen_ladder_tries: list = []
        self.cookie_seen: list = []
        self._out_dir.mkdir(parents=True, exist_ok=True)
        if not two_stage:  # 单段位形：显式遮蔽两段式调用面（编排鸭子型判定的负样本）
            self.collect_reader_info = None
            self.dispatch_reconstruction = None

    # ---- 段1 search：编排计划期不发起（槽位事实来自编目层蓝图）----
    def search(self, query: str, limit: int) -> list:
        raise AssertionError("编排层计划期不得发起 search（订单槽位自带 FileMeta 事实）")

    # ---- 段2 plan：真符号缺省（L1/L2/L3 + red_check=True）----
    def plan(self, meta: FileMeta) -> HarvestPlan:
        return HarvestPlan(meta=meta, slot=f"{self.site}:{self._doc_of(meta)}",
                           ladder_try=tuple(LADDER_ORDER), red_check=True)

    def _doc_of(self, meta: FileMeta) -> str:
        return str(meta.extra.get("doc_id") or meta.extra.get("blueprint_slot") or meta.title)

    def _step(self, doc: str, level: str) -> Step:
        key = (doc, level)
        assert key in self._steps, f"替身未脚本化: {key}"
        return self._steps[key]

    def _emit(self, step: Step) -> None:
        self.last_attempt_events = list(step.attempt_events)
        self.last_envelope_events = list(step.envelopes)

    def _result(self, step: Step, doc: str, level: str) -> LadderResult:
        if step.ok:
            pdf = build_real_pdf(self._out_dir / f"{self.site}_{doc}_{level}.pdf",
                                 pages=step.pages or 1)
            return LadderResult(
                ok=True, ladder_used=level, artifact_path=str(pdf), pages=step.pages,
                chars=step.chars, wall_status=step.wall_status, coverage=step.coverage,
                detail=f"doc={doc} ladder={level} stub_ok")
        return LadderResult(ok=False, wall_status=step.wall_status, coverage=step.coverage,
                            detail=f"doc={doc} ladder={level} stub_fail")

    # ---- 两段式调用面（wenku 位形）----
    def collect_reader_info(self, doc_id: str, *, meta=None, cookie: str = "", **_):
        self._log.append(f"collect:{self.site}:{doc_id}")
        self.cookie_seen.append(cookie)
        step = self._step(doc_id, "collect")
        self._clock.advance(step.tick)
        self._emit(step)
        return StubBundle(doc_id=doc_id, meta=meta)

    def dispatch_reconstruction(self, bundle, **_):
        meta = bundle.meta
        level = tuple(meta.extra.get("ladder_try") or ())[0]
        self.seen_ladder_tries.append(tuple(meta.extra.get("ladder_try") or ()))
        self._log.append(f"dispatch:{self.site}:{bundle.doc_id}:{level}")
        step = self._step(bundle.doc_id, level)
        self._clock.advance(step.tick)
        self._emit(step)
        return self._result(step, bundle.doc_id, level)

    # ---- 单段位形（book118/doc88）----
    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        doc = self._doc_of(plan.meta)
        level = tuple(plan.ladder_try)[0]
        self.seen_ladder_tries.append(tuple(plan.ladder_try))
        self._log.append(f"fetch_ladder:{self.site}:{doc}:{level}")
        step = self._step(doc, level)
        self._clock.advance(step.tick)
        self._emit(step)
        return self._result(step, doc, level)

    # ---- 段4 verify：真符号口径（脚本化成/败；needs_vip 件门③解耦归编排层）----
    def verify(self, result: LadderResult) -> bool:
        doc = result.detail.split()[0].split("=", 1)[1]
        return bool(self._verify.get(doc, True))


# ---------------------------------------------------------------- 槽位/注册表工厂

def slot_green(name="绿档A.pdf", title="水利安全测试文档甲", pages=3, site="book118"):
    return {"name": name, "title": title, "ext": "pdf", "path": "T-01/01/",
            "badge": "green_free", "perm": "green", "site": site, "pages": pages,
            "source_url": f"https://max.book118.com/{title}.html", "doc_id": title}


def slot_wenku(name="黄档B.pdf", title="文库黄源测试文档乙", pages=12, doc_id="wkdoc001"):
    return {"name": name, "title": title, "ext": "pdf", "path": "T-01/02/",
            "badge": "wenku_vip", "perm": "yellow", "pages": pages,
            "source_url": f"https://wenku.baidu.com/view/{doc_id}.html", "doc_id": doc_id}


def slot_red(name="红档C.pdf", title="受版权严格保护文档丙"):
    return {"name": name, "title": title, "ext": "pdf", "path": "T-01/03/",
            "badge": "wenku_vip", "perm": "red", "pages": 5,
            "source_url": "https://wenku.baidu.com/view/redxxx.html", "doc_id": "redxxx"}


def make_registry(wenku_on: bool) -> dict:
    """fulfillment.sources_registry 真符号形态（ChannelStatus 数据类实身）。"""
    return {
        "local": ChannelStatus("local", "self_owned", "green", True, ""),
        "wenku": ChannelStatus("wenku", "wenku_vip", "yellow", wenku_on,
                               "" if wenku_on else "测试态黄门关（双闸不放行）"),
        "ima": ChannelStatus("ima", "ima_public", "green", False, "测试态"),
        "gb": ChannelStatus("gb", "gb_free", "green", False, "测试态"),
    }


def make_orch(adapters, tmp_path, *, registry_fn=None, account_pool=None,
              clock=None, browser_log=None, order_id="ORD-T40-1"):
    clock = clock or FakeClock()
    audit = HarvestAudit(path=str(tmp_path / "harvest_audit.jsonl"))
    progress = ProgressEvents(str(tmp_path / "progress_events.jsonl"), order_id=order_id)
    browser_close = (lambda: browser_log.append("browser_close")) if browser_log is not None \
        else None
    orch = Orchestrator(adapters, audit=audit, progress=progress,
                        registry_fn=registry_fn or (lambda: make_registry(True)),
                        account_pool=account_pool, browser_close=browser_close,
                        clock=clock, work_root=str(tmp_path / "work"))
    return orch, audit, progress


# ---------------------------------------------------------------- 注册准入（W1-W7→W8）

def test_fr9_1_registry_gate_accepts_only_verified_adapters(tmp_path):
    """csdn/docin/legacy 不入注册表：注册即 ValueError；三件已过验收站可注册。"""
    def stub(s):
        return StubAdapter(s, two_stage=False, log=[], clock=FakeClock(),
                           out_dir=tmp_path / s, steps={})
    with pytest.raises(ValueError, match="csdn"):
        make_orch({"csdn": stub("csdn")}, tmp_path)
    with pytest.raises(ValueError, match="docin"):
        make_orch({"wenku": stub("wenku"), "docin": stub("docin")}, tmp_path)
    with pytest.raises(ValueError, match="legacy"):
        make_orch({"legacy": stub("legacy")}, tmp_path)
    orch, _, _ = make_orch({s: stub(s) for s in ACCEPTED_SITES}, tmp_path)
    assert sorted(orch.adapters) == ["book118", "doc88", "wenku"]
    # 缺省注册表=三件已过验收适配器实身（W8 准入口径）
    defaults = default_adapters()
    assert set(defaults) == set(ACCEPTED_SITES)
    for site, adapter in defaults.items():
        assert isinstance(adapter, DownloadAdapter)
        assert adapter.site == site


def test_fr9_1_site_routing_from_badge_and_explicit_site():
    """badge wenku_vip→wenku；显式 site 字段优先；无路由= None（归交付层指引）。"""
    assert site_for_slot(slot_wenku()) == "wenku"
    assert site_for_slot(slot_green()) == "book118"
    assert site_for_slot({"name": "x.pdf", "title": "无站槽", "badge": "self_owned",
                          "perm": "green"}) is None


# ---------------------------------------------------------------- 计划期（红线检查点①）

def test_fr9_1_plan_builds_harvest_plan_with_dual_redline_checkpoint_1(tmp_path):
    """计划期：red perm 硬拒 + 黄门关如实跳过 + 可路由槽出真符号 HarvestPlan。"""
    stub = StubAdapter("book118", two_stage=False, log=[], clock=FakeClock(),
                       out_dir=tmp_path / "out", steps={})
    wstub = StubAdapter("wenku", two_stage=True, log=[], clock=FakeClock(),
                        out_dir=tmp_path / "out2", steps={})
    orch, audit, progress = make_orch({"book118": stub, "wenku": wstub}, tmp_path,
                                       registry_fn=lambda: make_registry(False))
    order = HarvestOrder("ORD-PLAN-1", [slot_red(), slot_wenku(), slot_green(),
                                        {"name": "无站.pdf", "title": "无站槽",
                                         "badge": "self_owned", "perm": "green"}])
    records = orch.plan_order(order)
    by_slot = {r.slot: r for r in records}
    # 红槽：perm=red → 引擎层硬拒（永不 fetch）+ 建议获取路径（sources_registry 真口径）
    red = by_slot["红档C.pdf"]
    assert red.status == "red_rejected" and red.plan is None
    assert "官方渠道购买" in red.advice
    # 黄槽：wenku 黄门关（registry OFF）→ 如实跳过不 fetch
    yellow = by_slot["黄档B.pdf"]
    assert yellow.status == "yellow_gate_closed" and yellow.plan is None
    assert yellow.advice  # 建议获取路径在案
    # 无路由槽：归交付层（绿源/指引），非引擎射程
    assert by_slot["无站.pdf"].status == "not_routable"
    # 绿槽：真符号计划（FileMeta+ladder_try L1/L2/L3+red_check）
    green = by_slot["绿档A.pdf"]
    assert green.status == "planned"
    assert isinstance(green.plan, HarvestPlan)
    assert isinstance(green.plan.meta, FileMeta)
    assert green.plan.ladder_try == ("L1", "L2", "L3")
    assert green.plan.red_check is True
    assert green.plan.meta.title == "水利安全测试文档甲"
    # 红线检查点①落台账+事件件
    rows = [json.loads(l) for l in
            (tmp_path / "harvest_audit.jsonl").read_text(encoding="utf-8").splitlines()]
    assert any(r["event"] == "red_check" and r["status"] == "fail" for r in rows)
    events = [json.loads(l) for l in
              (tmp_path / "progress_events.jsonl").read_text(encoding="utf-8").splitlines()]
    kinds = [e["event"] for e in events]
    assert "red_reject" in kinds and "yellow_gate_closed" in kinds


def test_fr9_1_redline_checkpoint_2_reverifies_before_fetch(tmp_path):
    """fetch 前复验：注册表在采集窗内翻关 → 该槽如实终止（red_recheck_blocked）。"""
    state = {"wenku_on": True}
    stub = StubAdapter("wenku", two_stage=True, log=[], clock=FakeClock(),
                       out_dir=tmp_path / "out", steps={("wkdoc001", "collect"): Step(),
                                                        ("wkdoc001", "L1"): Step()})
    orch, audit, progress = make_orch({"wenku": stub}, tmp_path,
                                       registry_fn=lambda: make_registry(state["wenku_on"]))
    order = HarvestOrder("ORD-RECHECK-1", [slot_wenku()])
    # 计划期黄门开（检查点①过）→ 计划完成后注册表翻关 → 采集前复验（检查点②）拦下
    records = orch.plan_order(order)
    state["wenku_on"] = False
    orch.collect_phase(order, records)
    assert records[0].status == "red_recheck_blocked"
    assert records[0].plan is not None           # 检查点①已过、②拦在 fetch 前
    assert stub.seen_ladder_tries == []          # 复验不过=零网络腿
    events = [json.loads(l) for l in
              (tmp_path / "progress_events.jsonl").read_text(encoding="utf-8").splitlines()]
    assert any(e["event"] == "red_recheck_blocked" for e in events)


# ---------------------------------------------------------------- 两段式编排硬约束（T38）

def test_fr9_1_two_stage_collect_then_close_browser_then_dispatch(tmp_path):
    """sync_playwright 不可嵌套：全部 collect → 收口浏览器 → 全部 dispatch。"""
    call_log: list = []
    clock = FakeClock()
    steps = {}
    for doc in ("wkdoc001", "wkdoc002"):
        steps[(doc, "collect")] = Step()
        steps[(doc, "L1")] = Step()
    stub = StubAdapter("wenku", two_stage=True, log=call_log, clock=clock,
                       out_dir=tmp_path / "out", steps=steps)
    orch, _, _ = make_orch({"wenku": stub}, tmp_path, clock=clock, browser_log=call_log)
    order = HarvestOrder("ORD-2PHASE-1", [slot_wenku(doc_id="wkdoc001"),
                                          slot_wenku(name="黄档B2.pdf",
                                                     title="文库黄源测试文档乙二",
                                                     doc_id="wkdoc002")],
                         HarvestBudget(net_requests=10))
    report = orch.run(order)
    tags = list(call_log)
    collects = [i for i, t in enumerate(tags) if t.startswith("collect:")]
    dispatches = [i for i, t in enumerate(tags) if t.startswith("dispatch:")]
    close = tags.index("browser_close")
    assert collects and dispatches
    assert max(collects) < close < min(dispatches)   # 阶段边界硬约束
    assert report.counts()["delivered"] == 2


# ---------------------------------------------------------------- 降级循环（T16 真符号消费）

def test_fr9_1_ladder_degrade_consumes_should_degrade_and_next_ladder(tmp_path):
    """单段位形：L1 信封失败事件流 → should_degrade 判降级 → next_ladder → L2 成。"""
    clock = FakeClock()
    stub = StubAdapter("book118", two_stage=False, log=[], clock=clock,
                       out_dir=tmp_path / "out", steps={
                           ("水利安全测试文档甲", "L1"): Step(
                               ok=False, attempt_events=(
                                   AttemptEvent(http_status=200, envelope_ok=False),)),
                           ("水利安全测试文档甲", "L2"): Step()})
    orch, _, _ = make_orch({"book118": stub}, tmp_path, clock=clock)
    order = HarvestOrder("ORD-DEG-1", [slot_green()])
    report = orch.run(order)
    rec = report.slots[0]
    assert stub.seen_ladder_tries == [("L1",), ("L2",)]   # 窄化计划逐级推进
    assert rec.ladder_used == "L2"
    assert rec.attempts[0]["form"] == "envelope"           # 真判定器归因
    assert rec.status == "delivered"


def test_fr9_1_wall_status_hard_reject_never_degrades(tmp_path):
    """墙标记=硬拒：L1 blocked_waf 直接终止，不降级不重试（NFR1 行为=硬拒）。"""
    stub = StubAdapter("book118", two_stage=False, log=[], clock=FakeClock(),
                       out_dir=tmp_path / "out", steps={
                           ("水利安全测试文档甲", "L1"): Step(
                               ok=False, wall_status=WALL_BLOCKED_WAF)})
    orch, _, progress = make_orch({"book118": stub}, tmp_path)
    order = HarvestOrder("ORD-WALL-1", [slot_green()])
    report = orch.run(order)
    rec = report.slots[0]
    assert stub.seen_ladder_tries == [("L1",)]
    assert rec.status == "failed" and rec.result.wall_status == WALL_BLOCKED_WAF
    events = [json.loads(l) for l in
              (tmp_path / "progress_events.jsonl").read_text(encoding="utf-8").splitlines()]
    assert any(e["event"] == "wall_reject" for e in events)


def test_fr9_1_timeout_gate_from_orchestrator_measured_elapsed(tmp_path):
    """超时门：编排层实测 elapsed（65s/2页 > 30s/页预算）→ 降级 L2（零造假实测值）。"""
    clock = FakeClock()
    stub = StubAdapter("book118", two_stage=False, log=[], clock=clock,
                       out_dir=tmp_path / "out", steps={
                           ("水利安全测试文档甲", "L1"): Step(ok=False, tick=65.0),
                           ("水利安全测试文档甲", "L2"): Step()})
    orch, _, _ = make_orch({"book118": stub}, tmp_path, clock=clock)
    order = HarvestOrder("ORD-TMO-1", [slot_green(pages=2)])
    report = orch.run(order)
    rec = report.slots[0]
    assert rec.attempts[0]["form"] == "timeout"
    assert "65" in rec.attempts[0]["evidence"]        # 编排层实测值入账
    assert rec.ladder_used == "L2" and rec.status == "delivered"


def test_fr9_1_no_degrade_signal_means_fail_fast_as_is(tmp_path):
    """失败但无降级信号（事件流空+耗时界内）→ 如实终止不空转（fail-fast 口径）。"""
    stub = StubAdapter("book118", two_stage=False, log=[], clock=FakeClock(),
                       out_dir=tmp_path / "out", steps={
                           ("水利安全测试文档甲", "L1"): Step(ok=False)})
    orch, _, _ = make_orch({"book118": stub}, tmp_path)
    report = orch.run(HarvestOrder("ORD-FAST-1", [slot_green()]))
    rec = report.slots[0]
    assert stub.seen_ladder_tries == [("L1",)]        # 无信号不降级
    assert rec.status == "failed" and rec.ladder_used is None


# ---------------------------------------------------------------- 信封三态 → 账号池（T29）

def test_fr9_1_envelope_need_verify_feeds_account_pool_cooldown(tmp_path):
    """NeedVerify(tri_cap) 信封喂池 → 槽冷却 60s；次槽 acquire=None → 如实 pool_exhausted。"""
    clock = FakeClock()
    cred_dir = tmp_path / "creds"
    cred_dir.mkdir()
    (cred_dir / "wenku.secret.ini").write_text(
        "[wenku]\ncookie = synthetic-not-a-real-cookie\n", encoding="utf-8")
    pool = AccountPool({"wenku": {"min_interval": 0.0}}, credentials_dir=cred_dir,
                       clock=clock)
    call_log: list = []
    stub = StubAdapter("wenku", two_stage=True, log=call_log, clock=clock,
                       out_dir=tmp_path / "out", steps={
                           ("wkdoc001", "collect"): Step(envelopes=(
                               EnvelopeNeedVerify("wenku", "tri_cap", "stub 验证码信封"),)),
                           ("wkdoc001", "L1"): Step(),
                           ("wkdoc002", "collect"): Step(),
                           ("wkdoc002", "L1"): Step()})
    orch, _, _ = make_orch({"wenku": stub}, tmp_path, account_pool=pool, clock=clock)
    order = HarvestOrder("ORD-POOL-1", [slot_wenku(doc_id="wkdoc001"),
                                        slot_wenku(name="黄档B2.pdf",
                                                   title="文库黄源测试文档乙二",
                                                   doc_id="wkdoc002")],
                         HarvestBudget(net_requests=10))
    report = orch.run(order)
    rec1, rec2 = report.slots
    # 槽1：cookie 注入腿 + NeedVerify 喂池（真 pool.report：冷却 60s 起梯）
    assert stub.cookie_seen[0] == "synthetic-not-a-real-cookie"
    health = pool.health()["sites"]["wenku"]["slots"][0]
    assert health["need_verify"] == 1 and health["cooldown_remaining_s"] > 0
    # 槽2：唯一槽冷却中 → acquire=None → 如实 pool_exhausted（零网络腿）
    assert rec2.status == "pool_exhausted"
    assert not any(t.startswith("collect:wenku:wkdoc002") for t in call_log)
    events = [json.loads(l) for l in
              (tmp_path / "progress_events.jsonl").read_text(encoding="utf-8").splitlines()]
    assert any(e["event"] == "need_verify" for e in events)


# ---------------------------------------------------------------- 预算硬顶

def test_fr9_1_budget_exhaustion_stops_as_is_no_fabrication(tmp_path):
    """净请求预算硬顶：超预算如实停（未收槽位=指引态，不伪造产物）。"""
    clock = FakeClock()
    steps = {}
    for doc in ("wkdoc001", "wkdoc002"):
        steps[(doc, "collect")] = Step()
        steps[(doc, "L1")] = Step()
    stub = StubAdapter("wenku", two_stage=True, log=[], clock=clock,
                       out_dir=tmp_path / "out", steps=steps)
    orch, _, _ = make_orch({"wenku": stub}, tmp_path, clock=clock)
    # 预算 3 发：collect×2 + dispatch×1 → 次槽 dispatch 腿熔断
    order = HarvestOrder("ORD-BUDGET-1", [slot_wenku(doc_id="wkdoc001"),
                                          slot_wenku(name="黄档B2.pdf",
                                                     title="文库黄源测试文档乙二",
                                                     doc_id="wkdoc002")],
                         HarvestBudget(net_requests=3))
    report = orch.run(order)
    rec1, rec2 = report.slots
    assert rec1.status == "delivered"
    assert rec2.status == "budget_exhausted"
    assert rec2.artifact is None and rec2.result is None   # 零伪造
    assert report.budget["spent"] == 3 and report.budget["cap"] == 3
    events = [json.loads(l) for l in
              (tmp_path / "progress_events.jsonl").read_text(encoding="utf-8").splitlines()]
    assert any(e["event"] == "budget_stop" for e in events)


# ---------------------------------------------------------------- 长档 OCR 切片排程（T37 下游2）

def test_fr9_1_ocr_slice_mode_scheduled_for_long_docs():
    """>10 页长档 → 切片模式（paddle 单进程自旋坑）；短档/未知页不排程。"""
    plan = ocr_slice_plan(12, OCR_SLICE_SECONDS_DEFAULT)
    assert plan == {"mode": "slice", "slice_seconds": OCR_SLICE_SECONDS_DEFAULT,
                    "pages": 12}
    assert OCR_SLICE_PAGE_FLOOR == 10
    assert ocr_slice_plan(10, 30.0) is None      # 恰 10 页=界内
    assert ocr_slice_plan(3, 30.0) is None
    assert ocr_slice_plan(None, 30.0) is None


def test_fr9_1_ocr_slice_written_into_meta_for_dispatch_leg(tmp_path):
    """切片排程经 meta.extra 传给重组腿（长档=12页切片/短档=不注入）。"""
    clock = FakeClock()
    seen: dict = {}

    class ProbeAdapter(StubAdapter):
        def dispatch_reconstruction(self, bundle, **kw):
            seen[bundle.doc_id] = bundle.meta.extra.get("ocr_slice")
            return super().dispatch_reconstruction(bundle, **kw)

    stub = ProbeAdapter("wenku", two_stage=True, log=[], clock=clock,
                        out_dir=tmp_path / "out", steps={
                            ("wklong", "collect"): Step(), ("wklong", "L1"): Step(),
                            ("wkshort", "collect"): Step(), ("wkshort", "L1"): Step()})
    orch, _, _ = make_orch({"wenku": stub}, tmp_path, clock=clock)
    order = HarvestOrder("ORD-OCR-1", [
        slot_wenku(doc_id="wklong", pages=12),
        slot_wenku(name="黄档S.pdf", title="文库短档", doc_id="wkshort", pages=3)],
        HarvestBudget(net_requests=10))
    report = orch.run(order)
    assert seen["wklong"]["mode"] == "slice" and seen["wklong"]["pages"] == 12
    assert seen["wkshort"] is None
    assert report.slots[0].ocr_slice["mode"] == "slice"


# ---------------------------------------------------------------- 质检门（T38 下游4 解耦口径）

def test_fr9_1_vip_candidate_partial_qc_decoupled_and_quarantine(tmp_path):
    """needs_vip_candidate 部分件：verify=False 不作断言条件（如实记录+部分交付）；
    普通件 verify=False → 隔离不入镜像树。"""
    wstub = StubAdapter("wenku", two_stage=True, log=[], clock=FakeClock(),
                        out_dir=tmp_path / "wout", steps={
                            ("wkdoc001", "collect"): Step(),
                            ("wkdoc001", "L1"): Step(ok=True,
                                                     wall_status=WALL_NEEDS_VIP_CANDIDATE,
                                                     coverage="2/12", pages=2)},
                        verify_map={"wkdoc001": False})
    bstub = StubAdapter("book118", two_stage=False, log=[], clock=FakeClock(),
                        out_dir=tmp_path / "bout", steps={
                            ("水利安全测试文档甲", "L1"): Step()},
                        verify_map={"水利安全测试文档甲": False})
    orch, _, _ = make_orch({"wenku": wstub, "book118": bstub}, tmp_path)
    order = HarvestOrder("ORD-QC-1", [slot_wenku(), slot_green()],
                         HarvestBudget(net_requests=10))
    report = orch.run(order)
    vip, quarantined = report.slots
    # VIP 候选部分件：门③解耦——qc 如实 False 但不作断言条件 → partial + 入镜像
    assert vip.status == "partial"
    assert vip.qc["verify"] is False and vip.coverage == "2/12"
    assert vip.artifact is not None
    # 普通件：verify=False → qc_fail 隔离，不入镜像树
    assert quarantined.status == "qc_fail"
    assert quarantined.artifact is None
    mirror_files = [e["dest"] for e in report.mirror["entries"]]
    assert any("文库黄源测试文档乙" in f for f in mirror_files)
    assert not any("水利安全测试文档甲" in f for f in mirror_files)


# ---------------------------------------------------------------- progress_events 事件件

def test_fr9_1_progress_events_jsonl_shape_and_miniprogram_channel(tmp_path):
    """事件件=固定字段 JSONL + 小程序施工直播通道占位（同一事件双出口）。"""
    sink_rows: list = []
    ev = ProgressEvents(str(tmp_path / "pe.jsonl"), order_id="ORD-EV-1",
                        channel_sink=sink_rows.append)
    row = ev.emit("wenku", "黄档B.pdf", "collect_done", progress="1/2",
                  detail="showPage=3/12")
    assert set(EVENT_FIELDS) <= set(row)
    assert row["order_id"] == "ORD-EV-1" and row["site"] == "wenku"
    assert row["slot"] == "黄档B.pdf" and row["event"] == "collect_done"
    assert row["progress"] == "1/2"
    rows = ev.rows()
    assert len(rows) == 1 and rows[0] == row
    # 小程序通道占位：同一行透传（kb-factory-integration「引擎进度事件接同一通道」）
    assert sink_rows == [row]
    assert MINIPROGRAM_CHANNEL == "kbfactory_build_live"
    # 通道腿异常不外溢（直播通道挂=主链不停）
    ev2 = ProgressEvents(str(tmp_path / "pe2.jsonl"), order_id="ORD-EV-2",
                         channel_sink=lambda _r: 1 / 0)
    ev2.emit("book118", "绿档A.pdf", "plan")
    assert len(ev2.rows()) == 1


# ---------------------------------------------------------------- 一单全链（计划→执行→质检→镜像树→交付链→事件序）

def test_fr9_1_full_chain_one_order_plan_to_delivery_chain(tmp_path):
    """FR9.AC1 单测形态：一单全链贯通（交付链=fulfillment.pipeline 真符号非 mock）。"""
    call_log: list = []
    clock = FakeClock()
    bstub = StubAdapter("book118", two_stage=False, log=call_log, clock=clock,
                        out_dir=tmp_path / "bout", steps={
                            ("水利安全测试文档甲", "L1"): Step(pages=3, chars=1200)})
    wstub = StubAdapter("wenku", two_stage=True, log=call_log, clock=clock,
                        out_dir=tmp_path / "wout", steps={
                            ("wkdoc001", "collect"): Step(),
                            ("wkdoc001", "L1"): Step(ok=True,
                                                     wall_status=WALL_NEEDS_VIP_CANDIDATE,
                                                     coverage="2/12", pages=2)},
                        verify_map={"wkdoc001": False})
    green, yellow = slot_green(), slot_wenku()
    blueprint = {"domain": "测试域", "tree": {"root": "测试知识库T40", "l1": [{
        "code": "T", "dir": "T-01", "path": "T-01/", "name": "测试枢纽",
        "theme": "测试主题", "source": "test",
        "l2": [{"code": "T-01/01", "dir": "01", "path": "T-01/01/", "name": "文档组",
                "theme": "文档组主题", "files": [green, yellow]}]}]}}
    bp_path = tmp_path / "bp_t40.json"
    bp_path.write_text(json.dumps(blueprint, ensure_ascii=False), encoding="utf-8")

    sink_rows: list = []
    audit = HarvestAudit(path=str(tmp_path / "audit_full.jsonl"))
    progress = ProgressEvents(str(tmp_path / "events_full.jsonl"), order_id="ORD-FULL-1",
                              channel_sink=sink_rows.append)
    orch = Orchestrator({"book118": bstub, "wenku": wstub}, audit=audit, progress=progress,
                        registry_fn=lambda: make_registry(True), clock=clock,
                        browser_close=lambda: call_log.append("browser_close"),
                        work_root=str(tmp_path / "work"))
    order = HarvestOrder("ORD-FULL-1", [green, yellow], HarvestBudget(net_requests=20))
    report = orch.run(order, blueprint_ref=str(bp_path), email="buyer@example.com",
                      base_dir=str(tmp_path))

    # ① 报告口径（零造假：delivered/partial/guide/failed 全实测）
    assert report.counts() == {"slots": 2, "delivered": 1, "partial": 1,
                               "guide": 0, "failed": 0}
    # ② 产物件字段=ARCHITECTURE 出契约（不得增删改名）
    art = report.slots[0].artifact
    assert art is not None
    assert set(art.__dict__) == {"slot", "path", "fmt", "pages", "chars", "watermark_scan",
                                 "source_badge", "ladder_used", "wall_status", "coverage",
                                 "ledger_ref"}
    assert art.ladder_used == "L1" and art.pages == 3
    assert art.watermark_scan is not None       # pypdfium2 真实测 ink 比
    assert 0.0 <= art.watermark_scan[0] <= 1.0
    # ③ 镜像树：引擎产物落盘 + 引擎侧 harvest_manifest
    assert Path(report.mirror["root"]).is_dir()
    assert Path(report.mirror["manifest"]).is_file()
    names = [e["name"] for e in report.mirror["entries"]]
    assert "水利安全测试文档甲.pdf" in names
    # ④ 既有交付链（真 pipeline.run）：绿槽经镜像语料真交付进树+zip；黄槽 v1 如实进指引
    zip_path = Path(report.chain["zip_path"])
    assert zip_path.is_file()
    with zipfile.ZipFile(zip_path) as z:
        inner = z.namelist()
    assert "测试知识库T40/T-01/01/水利安全测试文档甲.pdf" in inner
    assert "测试知识库T40/manifest.json" in inner
    assert report.chain["stats"]["delivered"] == 1
    assert report.chain["stats"]["guide"] == 1   # wenku_vip 黄槽=交付链 v1 指引态（如实）
    # ⑤ 事件件：序=计划→采集→收口→重组→质检→镜像→交付链→收单
    events = progress.rows()
    kinds = [e["event"] for e in events]
    assert kinds[0] == "order_start" and kinds[-1] == "order_done"
    seq = [kinds.index(k) for k in ("plan", "collect_start", "browser_close",
                                    "dispatch_start", "qc", "mirror", "chain")]
    assert seq == sorted(seq)
    assert len(sink_rows) == len(events)        # 直播通道与 JSONL 同步
    # ⑥ 台账：每腿如实一行（七列口径）
    audit_rows = [json.loads(l) for l in
                  (tmp_path / "audit_full.jsonl").read_text(encoding="utf-8").splitlines()]
    assert all({"ts", "site", "event", "query_or_docid", "count", "status",
                "detail"} <= set(r) for r in audit_rows)
    assert any(r["event"] == "dispatch" and r["status"] == "ok" for r in audit_rows)
    # ⑦ 适配：产出物→交付入参（fulfillment.Order 真符号校验）
    fo = to_fulfillment_order(order, blueprint_ref=str(bp_path), email="buyer@example.com")
    assert fo.id == "ORD-FULL-1" and fo.blueprint_ref == str(bp_path)


def test_fr9_1_chain_skipped_without_blueprint_ref(tmp_path):
    """无 blueprint_ref/email=不出交付链（报告 chain=None 如实，事件无 chain 行）。"""
    stub = StubAdapter("book118", two_stage=False, log=[], clock=FakeClock(),
                       out_dir=tmp_path / "out",
                       steps={("水利安全测试文档甲", "L1"): Step()})
    orch, _, progress = make_orch({"book118": stub}, tmp_path)
    report = orch.run(HarvestOrder("ORD-NOCHAIN-1", [slot_green()]))
    assert report.chain is None and report.counts()["delivered"] == 1
    assert all(e["event"] != "chain" for e in progress.rows())
