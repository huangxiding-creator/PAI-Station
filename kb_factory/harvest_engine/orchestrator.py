# -*- coding: utf-8 -*-
"""订单编排 orchestrator（FR9.1）——收割引擎总装件（T40）。

主链（ARCHITECTURE 数据契约 + REQUIREMENTS FR9.1）：
订单(order_id/blueprint_slots/budget) → 收割计划(slot/FileMeta/adapter/ladder_try
含 L1/L2/L3/red_check 双红线检查点) → 两段式执行 → 质检 → 镜像树 → 既有交付链
（kb_factory/fulfillment，真符号适配、交付链本身不改动）→ progress_events 事件件。

编排要点（下游注意汇总，全为在案实锤）：
- ① 两段式编排硬约束（T38：sync_playwright 不可嵌套）：阶段1 collect（签名窗/
  采集腿，浏览器在场）→ 收口浏览器（browser_close 钩子）→ 阶段2 dispatch（重组/
  打印腿）——本件显式分阶段调度，全部 collect 完成才进 dispatch；
- ② 降级判定消费 adapters/base.should_degrade+next_ladder（T16 真符号）：
  事件流喂入=适配器自报 last_attempt_events（AttemptEvent 实测值）+ 编排层自观
  elapsed/pages（零造假：编排层只报自己实测得到的字段）；墙标记（blocked_waf/
  paid_wall/blocked_mirror_policy）=硬拒终止不降级（NFR1）；无降级信号=fail-fast
  如实终止（同 render_fallback 空流口径）；
- ③ 信封三态事件喂 account_pool（T29）：适配器自报 last_envelope_events
  （envelope.py 三态真件）→ pool.report（NeedVerify→槽冷却退避，R13）；
- ④ VIP 件质检门解耦口径（T38 下游4）：needs_vip_candidate 部分件 verify=False
  不作断言条件——qc 如实记录 + 部分交付（coverage=showPage/page 如实标注）；
- ⑤ 长档 OCR 排程=切片模式（T37 下游2：paddle 单进程>10页自旋）：计划期算
  ocr_slice 写 meta.extra，重组腿按切片模式消费；
- ⑥ 镜像树打包对接 fulfillment 入参形态（真符号定接口）：引擎产物落镜像树
  （槽位路径+标题命名）→ LocalCorpus 挂镜像根 → pipeline.run 建树打包 zip
  （交付链零改动）；发送腿（deliver/SMTP）不在本件射程（归 T42/发布链）；
- ⑦ 台账 harvest_audit 复用 audit.py 真符号（每腿如实一行）；
- ⑧ red_check 双红线检查点：计划期查 sources_registry（perm=red 引擎层硬拒）
  + fetch 前复验（采集窗内注册表翻关如实终止）；
- 注册准入（W1-W7→W8）：只注册已过验收适配器 wenku/book118/doc88——
  csdn/docin/legacy 不入注册表（注册即 ValueError）。
"""
from __future__ import annotations

import json
import re
import shutil
import time
from collections.abc import Callable, Mapping
from dataclasses import dataclass, field
from pathlib import Path

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 envelope.py）
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.base import (
        AttemptEvent, DownloadAdapter, HarvestPlan, LadderResult, WALL_BLOCKED_MIRROR_POLICY,
        WALL_BLOCKED_WAF, WALL_NEEDS_VIP_CANDIDATE, WALL_PAID, next_ladder, should_degrade)
    from kb_factory.harvest_engine.audit import HarvestAudit
except ImportError:  # pragma: no cover - worktree 阶段路径
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.base import (  # type: ignore
        AttemptEvent, DownloadAdapter, HarvestPlan, LadderResult, WALL_BLOCKED_MIRROR_POLICY,
        WALL_BLOCKED_WAF, WALL_NEEDS_VIP_CANDIDATE, WALL_PAID, next_ladder, should_degrade)
    from harvest_engine.audit import HarvestAudit  # type: ignore

__all__ = [
    "ACCEPTED_SITES", "BADGE_SITE_ROUTES", "BudgetExhausted", "HarvestArtifact",
    "HarvestBudget", "HarvestOrder", "HarvestReport", "Orchestrator", "SlotRecord",
    "OCR_SLICE_PAGE_FLOOR", "OCR_SLICE_SECONDS_DEFAULT", "default_adapters",
    "ocr_slice_plan", "site_for_slot", "slot_to_filemeta", "to_fulfillment_order",
]


def _fulfillment(module: str):
    """fulfillment 真符号惰性装载（主树 kb_factory.* 形态；不在此 import 顶层重货）。"""
    import importlib
    try:
        return importlib.import_module(f"kb_factory.fulfillment.{module}")
    except ImportError:  # pragma: no cover - worktree 阶段路径
        return importlib.import_module(f"fulfillment.{module}")


#: 只注册已过验收适配器（W1-W7→W8 准入；csdn/docin/legacy 不入）
ACCEPTED_SITES = ("book118", "wenku", "doc88")

#: badge→站点路由（编目词表 BADGES 中带站点语义的徽章；其余靠槽位显式 site 字段）
BADGE_SITE_ROUTES = {"wenku_vip": "wenku"}

#: 墙标记=硬拒（NFR1：行为=硬拒；不降级不重试）
HARD_WALL_STATUSES = frozenset((WALL_BLOCKED_WAF, WALL_PAID, WALL_BLOCKED_MIRROR_POLICY))

#: 长档 OCR 切片排程门（T37 下游2：paddle 单进程>10页自旋 → --slice-seconds 切片模式）
OCR_SLICE_PAGE_FLOOR = 10
OCR_SLICE_SECONDS_DEFAULT = 30.0

#: 缺省净请求预算（发数；口径=编排层可观测腿数保守下界，真实发数以台账为准）
DEFAULT_BUDGET_REQUESTS = 40

# ---- 槽位状态词表（如实态；guide 组=未取得进获取指引，failed 组=取得折损） ----
STATUS_PLANNED = "planned"
STATUS_COLLECTED = "collected"            # 两段式采集完成（待 dispatch）
STATUS_FETCHED = "fetched"                # 收割产物在手（待质检）
STATUS_DELIVERED = "delivered"
STATUS_PARTIAL = "partial"                # needs_vip_candidate 部分收割（如实标注交付）
STATUS_FAILED = "failed"
STATUS_QC_FAIL = "qc_fail"
STATUS_NO_ARTIFACT = "no_artifact"
STATUS_RED_REJECTED = "red_rejected"
STATUS_YELLOW_GATE_CLOSED = "yellow_gate_closed"
STATUS_NOT_ROUTABLE = "not_routable"
STATUS_ADAPTER_MISSING = "adapter_missing"
STATUS_RED_RECHECK = "red_recheck_blocked"
STATUS_BUDGET = "budget_exhausted"
STATUS_POOL = "pool_exhausted"

GUIDE_STATUSES = frozenset((STATUS_RED_REJECTED, STATUS_YELLOW_GATE_CLOSED,
                            STATUS_NOT_ROUTABLE, STATUS_ADAPTER_MISSING,
                            STATUS_RED_RECHECK, STATUS_BUDGET, STATUS_POOL))
FAILED_STATUSES = frozenset((STATUS_FAILED, STATUS_QC_FAIL, STATUS_NO_ARTIFACT))


_POOL_DRAINED = object()  # 哨兵：池在而全冷却/熔断（区别于无池）


class BudgetExhausted(RuntimeError):
    """净请求预算硬顶熔断（超预算如实停，不静默继续；e2e 同名口径）。"""


@dataclass
class HarvestBudget:
    """订单预算（v1=净请求发数；后续波次可扩展槽位/时长轴）。"""
    net_requests: int = DEFAULT_BUDGET_REQUESTS

    def __post_init__(self):
        if isinstance(self.net_requests, bool) or not isinstance(self.net_requests, int) \
                or self.net_requests < 1:
            raise ValueError(f"net_requests 须为正整数，当前={self.net_requests!r}")


class BudgetGuard:
    """预算守门：每腿 spend（口径=编排层可观测网络腿数，保守下界≥1 发/腿）。"""

    def __init__(self, cap: int):
        self.cap = int(cap)
        self.spent = 0

    def spend(self, n: int = 1, what: str = "") -> None:
        if self.spent + n > self.cap:
            raise BudgetExhausted(
                f"预算硬顶：spent={self.spent}+{n} > cap={self.cap}（{what}）")
        self.spent += n

    def to_dict(self) -> dict:
        return {"cap": self.cap, "spent": self.spent, "left": self.cap - self.spent}


@dataclass
class HarvestOrder:
    """收割订单入参（FR9.1 数据契约）：order_id + 蓝图槽位平铺 + 预算。

    blueprint_slots=编目层蓝图槽位 dict 列表（name/title/ext/path/badge/perm/
    pages/source_url；可选 site 显式站点路由、doc_id 站点文档号）。
    """
    order_id: str
    blueprint_slots: list = field(default_factory=list)
    budget: HarvestBudget = field(default_factory=HarvestBudget)

    def __post_init__(self):
        if not str(self.order_id or "").strip():
            raise ValueError("订单缺少 order_id")
        if not isinstance(self.blueprint_slots, list):
            raise ValueError("blueprint_slots 须为槽位 dict 列表")
        for slot in self.blueprint_slots:
            if not isinstance(slot, Mapping):
                raise ValueError(f"槽位须为映射，当前={type(slot).__name__}")


@dataclass
class HarvestArtifact:
    """收割产物件（ARCHITECTURE 出契约字段，不得增删改名）。"""
    slot: str
    path: str
    fmt: str
    pages: int | None
    chars: int | None
    watermark_scan: dict | None
    source_badge: str
    ladder_used: str | None
    wall_status: str | None
    coverage: str | None
    ledger_ref: str


@dataclass
class SlotRecord:
    """单槽位编排便签（状态机如实记录：计划→采集→重组→质检→镜像）。"""
    slot: str
    title: str
    site: str
    badge: str
    perm: str
    status: str = STATUS_PLANNED
    reason: str = ""
    advice: str = ""
    blueprint_slot: dict = field(default_factory=dict)
    plan: HarvestPlan | None = None
    ocr_slice: dict | None = None
    bundle: object | None = None      # 两段式采集产物（dispatch 期消费）
    attempts: list = field(default_factory=list)   # {"level","ok","form","evidence","elapsed_s"}
    ladder_used: str | None = None
    result: LadderResult | None = None
    artifact: HarvestArtifact | None = None
    qc: dict | None = None            # {"verify": True/False/None,"watermark_scan":…,"gate3_decoupled"}
    cookie_slot: str = ""             # 池槽序名（非凭据值）
    coverage: str | None = None

    def to_dict(self) -> dict:
        art = self.artifact
        return {"slot": self.slot, "title": self.title, "site": self.site,
                "badge": self.badge, "perm": self.perm, "status": self.status,
                "reason": self.reason, "advice": self.advice,
                "ladder_used": self.ladder_used, "coverage": self.coverage,
                "wall_status": getattr(self.result, "wall_status", None),
                "attempts": list(self.attempts), "qc": self.qc,
                "ocr_slice": self.ocr_slice, "cookie_slot": self.cookie_slot,
                "artifact": None if art is None else {
                    "slot": art.slot, "path": art.path, "fmt": art.fmt,
                    "pages": art.pages, "chars": art.chars,
                    "watermark_scan": art.watermark_scan,
                    "source_badge": art.source_badge, "ladder_used": art.ladder_used,
                    "wall_status": art.wall_status, "coverage": art.coverage,
                    "ledger_ref": art.ledger_ref}}


@dataclass
class HarvestReport:
    """订单收割报告（counts=零造假实测口径）。"""
    order_id: str
    slots: list = field(default_factory=list)
    budget: dict = field(default_factory=dict)
    mirror: dict = field(default_factory=dict)
    chain: dict | None = None
    events_path: str = ""
    ledger_ref: str = ""

    def counts(self) -> dict:
        st = [r.status for r in self.slots]
        return {"slots": len(st),
                "delivered": st.count(STATUS_DELIVERED),
                "partial": st.count(STATUS_PARTIAL),
                "guide": sum(1 for s in st if s in GUIDE_STATUSES),
                "failed": sum(1 for s in st if s in FAILED_STATUSES)}

    def to_dict(self) -> dict:
        return {"order_id": self.order_id, "counts": self.counts(),
                "budget": self.budget, "mirror": self.mirror, "chain": self.chain,
                "events_path": self.events_path, "ledger_ref": self.ledger_ref,
                "slots": [r.to_dict() for r in self.slots]}


# ---------------------------------------------------------------- 纯函数（路由/排程/适配）

def site_for_slot(slot: Mapping) -> str | None:
    """槽位→引擎站点路由：显式 site 字段优先（须在已过验收站点内），badge 兜底。

    无路由 → None（槽位归交付层：本地绿源命中或获取指引，非引擎射程）。
    """
    explicit = str(slot.get("site") or "").strip()
    if explicit:
        return explicit if explicit in ACCEPTED_SITES else None
    badge = str(slot.get("badge") or "")
    return BADGE_SITE_ROUTES.get(badge)


def slot_to_filemeta(slot: Mapping, site: str) -> FileMeta:
    """蓝图槽位 → FileMeta（元数据层真符号；extra 携带蓝图回链与站点文档号）。"""
    pages = slot.get("pages")
    meta = FileMeta(
        title=str(slot.get("title") or slot.get("name") or ""),
        fmt=str(slot.get("ext") or "pdf").lower().lstrip("."),
        pages=pages if isinstance(pages, int) and not isinstance(pages, bool) else None,
        badge=str(slot.get("badge") or ""),
        perm=str(slot.get("perm") or "green"),
        source_url=slot.get("source_url"),
        extra={"blueprint_slot": str(slot.get("name") or ""), "site": site or "",
               "doc_id": str(slot.get("doc_id") or "")})
    if not meta.extra["doc_id"]:
        meta.extra["doc_id"] = str(meta.source_url or meta.title)
    return meta


def ocr_slice_plan(pages: int | None, slice_seconds: float) -> dict | None:
    """长档 OCR 切片排程（T37 下游2）：>OCR_SLICE_PAGE_FLOOR 页 → 切片模式；否则 None。"""
    if isinstance(pages, bool) or not isinstance(pages, int) or pages <= OCR_SLICE_PAGE_FLOOR:
        return None
    return {"mode": "slice", "slice_seconds": float(slice_seconds), "pages": pages}


def default_adapters() -> dict:
    """缺省注册表=三件已过验收适配器实身（W8 准入口径；惰性装载避免测试背重货）。"""
    try:
        from kb_factory.harvest_engine.adapters.book118 import Book118Adapter
        from kb_factory.harvest_engine.adapters.doc88 import Doc88DownloadAdapter
        from kb_factory.harvest_engine.adapters.wenku import WenkuDownloadAdapter
    except ImportError:  # pragma: no cover - worktree 阶段路径
        from harvest_engine.adapters.book118 import Book118Adapter  # type: ignore
        from harvest_engine.adapters.doc88 import Doc88DownloadAdapter  # type: ignore
        from harvest_engine.adapters.wenku import WenkuDownloadAdapter  # type: ignore
    return {"book118": Book118Adapter(), "wenku": WenkuDownloadAdapter(),
            "doc88": Doc88DownloadAdapter()}


def to_fulfillment_order(order: HarvestOrder, *, blueprint_ref, email,
                         version_selection: str = "original", price: str = "",
                         paid_at: str = ""):
    """产出物→交付入参的适配函数①：收割订单 → fulfillment.Order（真符号校验）。"""
    order_mod = _fulfillment("order")
    return order_mod.Order(id=order.order_id, blueprint_ref=str(blueprint_ref),
                           email=str(email), version_selection=version_selection,
                           price=price, paid_at=paid_at, status="paid")


_SAFE_NAME_RE = re.compile(r'[<>:"/\|?*\x00-\x1f]')


def _safe_name(name: str, max_len: int = 96) -> str:
    """镜像树文件名清洗（路径非法字符→全角替代；不删不改语义）。"""
    cleaned = _SAFE_NAME_RE.sub("□", str(name or "")).strip().rstrip(".")
    return (cleaned or "unnamed")[:max_len]


def _safe_rel_dir(rel: str) -> Path:
    """槽位相对目录护栏：拒绝对路径/上跳（镜像树只在根内落件）。"""
    rel = str(rel or "").replace("\\", "/").strip("/")
    parts = [p for p in rel.split("/") if p not in ("", ".")]
    if any(p == ".." for p in parts) or Path(rel).is_absolute():
        raise ValueError(f"槽位目录越界（只允许根内相对路径）: {rel!r}")
    return Path(*parts) if parts else Path()


def _is_two_stage(adapter) -> bool:
    """两段式调用面鸭子型（wenku 位形：collect_reader_info+dispatch_reconstruction）。"""
    return callable(getattr(adapter, "collect_reader_info", None)) and \
        callable(getattr(adapter, "dispatch_reconstruction", None))


def _accepts_kwarg(fn, name: str) -> bool:
    """方法签名是否收某 keyword（cookie 注入面探测；探测一次即直呼）。"""
    import inspect
    try:
        sig = inspect.signature(fn)
    except (TypeError, ValueError):
        return False
    return name in sig.parameters or any(p.kind == inspect.Parameter.VAR_KEYWORD
                                         for p in sig.parameters.values())


def measure_watermark(pdf_path) -> dict | None:
    """产物水印抽帧实测（quality_gate 真符号：首/中/末渲染 ink 比；不可解析=None）。"""
    try:
        import pypdfium2
        try:
            from kb_factory.harvest_engine.quality_gate import (
                RENDER_SCALE, image_ink_ratio, sample_indices)
        except ImportError:  # pragma: no cover - worktree 阶段路径
            from harvest_engine.quality_gate import (  # type: ignore
                RENDER_SCALE, image_ink_ratio, sample_indices)
        doc = pypdfium2.PdfDocument(str(pdf_path))
        out: dict = {}
        for idx in sample_indices(len(doc)):
            page = doc[idx]
            try:
                im = page.render(scale=RENDER_SCALE).to_pil()
            finally:
                page.close()
            out[idx] = round(image_ink_ratio(im), 4)
        return out or None
    except Exception:  # 不可解析/渲染折损 → None 如实（不以不可得充过门）
        return None


# ---------------------------------------------------------------- Orchestrator 本体

class Orchestrator:
    """订单编排器：plan→collect→收口浏览器→dispatch→质检→镜像树→交付链。

    用法：``orch = Orchestrator({"wenku": adapter, ...}, audit=HarvestAudit(...),
    progress=ProgressEvents(...))`` → ``report = orch.run(order, blueprint_ref=...,
    email=..., base_dir=...)``。注入面（全 keyword-only）：registry_fn（sources_registry
    读接口）、account_pool（T29）、browser_close（收口浏览器钩子）、clock（确定性
    时间注入）、work_root（工作根）、ocr_slice_seconds（切片参数）。
    """

    def __init__(self, adapters: Mapping, *, audit: HarvestAudit,
                 progress, registry_fn: Callable[[], dict] | None = None,
                 account_pool=None, browser_close: Callable[[], None] | None = None,
                 clock: Callable[[], float] | None = None,
                 work_root: str | Path | None = None,
                 ocr_slice_seconds: float = OCR_SLICE_SECONDS_DEFAULT):
        bad = sorted(set(adapters) - set(ACCEPTED_SITES))
        if bad:
            raise ValueError(
                f"未过验收适配器不入注册表（W1-W7→W8 准入）: {'/'.join(bad)}"
                f"（合法={list(ACCEPTED_SITES)}）")
        for site, adapter in adapters.items():
            if not isinstance(adapter, DownloadAdapter):
                raise ValueError(f"站点 {site!r} 注册对象非 DownloadAdapter 四段适配器")
        self.adapters = dict(adapters)
        self.audit = audit
        self.progress = progress
        self._registry_fn = registry_fn or (lambda: _fulfillment("sources_registry").registry())
        self._pool = account_pool
        self._browser_close = browser_close
        self._clock = clock or time.monotonic
        self._work_root = Path(work_root) if work_root else Path.cwd() / "kb_harvest_work"
        self._ocr_slice_seconds = float(ocr_slice_seconds)
        self._budget = BudgetGuard(DEFAULT_BUDGET_REQUESTS)

    # ------------------------------------------------------------ 红线检查点（双查）

    def red_check(self, slot: Mapping, site: str | None, *, phase: str):
        """红线检查（plan 期/fetch 前复验共用判定；phase 只入账）。

        ① perm=red → 引擎层硬拒（永不 fetch，建议获取路径=官方渠道购买）；
        ② 黄门：sources_registry 中该站渠道 OFF → 不放行（如 wenku 双闸未开）。
        返回 (ok, kind, advice)。
        """
        reg_mod = _fulfillment("sources_registry")
        perm = str(slot.get("perm") or "green")
        badge = str(slot.get("badge") or "")
        if perm == "red":
            return False, "red_perm_hard_reject", reg_mod.ADVICE_RED
        channel = self._registry_fn().get(site) if site else None
        if channel is not None and not getattr(channel, "on", True):
            reason = str(getattr(channel, "reason", "") or "")
            return False, f"channel_off[{site}]: {reason}", reg_mod.advice_for(badge, perm)
        return True, "", ""

    def _red_check_row(self, rec: SlotRecord, phase: str) -> tuple:
        slot = rec.blueprint_slot
        ok, kind, advice = self.red_check(slot, rec.site, phase=phase)
        self.audit.request(site=rec.site, event="red_check", query_or_docid=rec.slot,
                           count=0, status="ok" if ok else "fail",
                           detail=f"phase={phase} kind={kind}")
        return ok, kind, advice

    # ------------------------------------------------------------ 段2 计划期（检查点①）

    def plan_order(self, order: HarvestOrder) -> list:
        """订单 → 收割计划清单（slot/FileMeta/adapter/ladder_try/red_check）。

        编排计划期不发起 search（订单槽位自带编目层 FileMeta 事实）；adapter.plan
        为四段真符号段2。未过红线/无路由/未注册的槽位如实分态，不进执行。
        """
        records: list = []
        total = len(order.blueprint_slots)
        for i, slot in enumerate(order.blueprint_slots):
            name = str(slot.get("name") or slot.get("title") or "")
            site = site_for_slot(slot)
            rec = SlotRecord(slot=name, title=str(slot.get("title") or ""),
                             site=site or "", badge=str(slot.get("badge") or ""),
                             perm=str(slot.get("perm") or "green"),
                             blueprint_slot=dict(slot))
            ok, kind, advice = self._red_check_row(rec, phase="plan")
            if not ok:
                if kind == "red_perm_hard_reject":
                    rec.status, rec.advice = STATUS_RED_REJECTED, advice
                    self.progress.emit(rec.site, rec.slot, "red_reject",
                                       progress=f"{i + 1}/{total}", detail=kind)
                else:
                    rec.status, rec.advice = STATUS_YELLOW_GATE_CLOSED, advice
                    rec.reason = kind
                    self.progress.emit(rec.site, rec.slot, "yellow_gate_closed",
                                       progress=f"{i + 1}/{total}", detail=kind)
                records.append(rec)
                continue
            if site is None:
                rec.status, rec.reason = STATUS_NOT_ROUTABLE, "no_route"
                self.audit.request(site="", event="plan", query_or_docid=rec.slot,
                                   count=0, status="fail", detail="no_route（归交付层）")
                self.progress.emit(rec.site, rec.slot, "not_routable",
                                   progress=f"{i + 1}/{total}", detail="no_route")
                records.append(rec)
                continue
            adapter = self.adapters.get(site)
            if adapter is None:
                rec.status = STATUS_ADAPTER_MISSING
                rec.reason = f"site={site} 未注册（合法={list(self.adapters)}）"
                self.audit.request(site=site, event="plan", query_or_docid=rec.slot,
                                   count=0, status="fail", detail=rec.reason)
                records.append(rec)
                continue
            meta = slot_to_filemeta(slot, site)
            rec.ocr_slice = ocr_slice_plan(meta.pages, self._ocr_slice_seconds)
            if rec.ocr_slice is not None:  # ⑤ 长档切片排程经 meta.extra 传给重组腿
                meta.extra["ocr_slice"] = rec.ocr_slice
            try:
                rec.plan = adapter.plan(meta)  # 段2 真符号
            except Exception as exc:  # 计划折损如实分态（不炸主链）
                rec.status, rec.reason = STATUS_FAILED, f"plan_error:{type(exc).__name__}: {exc}"
                self.audit.request(site=site, event="plan", query_or_docid=rec.slot,
                                   count=0, status="fail", detail=rec.reason)
                records.append(rec)
                continue
            self.audit.request(site=site, event="plan", query_or_docid=rec.slot,
                               count=1, status="ok",
                               detail=f"adapter={site} ladder_try={tuple(rec.plan.ladder_try)}"
                                      f" red_check={rec.plan.red_check}"
                                      + (f" ocr_slice={rec.ocr_slice['mode']}"
                                         f"/{rec.ocr_slice['pages']}页"
                                         if rec.ocr_slice else ""))
            self.progress.emit(site, rec.slot, "plan", progress=f"{i + 1}/{total}",
                               detail=f"adapter={site} ladder_try={list(rec.plan.ladder_try)}")
            records.append(rec)
        return records

    # ------------------------------------------------------------ 阶段1 collect（检查点② fetch 前复验）

    def _ensure_budget(self, order: HarvestOrder) -> None:
        self._budget = BudgetGuard(order.budget.net_requests)

    def _consume_adapter_events(self, adapter, rec: SlotRecord, acct) -> None:
        """消费适配器自报事件流（喂 T16 降级判定在 _walk_ladder 内；此处只管信封→池）。"""
        envelopes = list(getattr(adapter, "last_envelope_events", None) or [])
        for ev in envelopes:  # ③ 信封三态喂 account_pool（NeedVerify→槽冷却，R13）
            state = str(getattr(ev, "state", "") or "")
            if self._pool is not None and acct is not None:
                try:
                    receipt = self._pool.report(rec.site, acct, ev)
                except ValueError as exc:  # 防串槽护栏触发=如实入账不炸
                    receipt = {"error": f"{type(exc).__name__}: {exc}"}
                detail = f"pool_action={receipt.get('action', '')}"
            else:
                detail = "pool_absent（信封事件如实入账，无池可喂）"
            kind = str(getattr(ev, "kind", "") or "")
            self.audit.request(site=rec.site, event="envelope", query_or_docid=rec.slot,
                               count=1, status="ok" if state == "ok" else "fail",
                               detail=f"state={state} kind={kind} {detail}")
            if state == "need_verify":
                self.progress.emit(rec.site, rec.slot, "need_verify", detail=kind)
        if envelopes:
            adapter.last_envelope_events = []

    def collect_phase(self, order: HarvestOrder, records: list) -> None:
        """阶段1：采集腿（签名窗/浏览器在场）——红线检查点② fetch 前复验先于一切网络腿。

        两段式适配器：collect_reader_info 一次（bundle 待阶段2）；单段适配器：
        fetch_ladder 全链在本阶段走完（其浏览器腿都在采集窗内）。
        """
        planned = [r for r in records if r.status == STATUS_PLANNED]
        total = len(planned)
        for i, rec in enumerate(planned):
            ok, kind, advice = self._red_check_row(rec, phase="fetch")
            if not ok:  # ⑧ fetch 前复验不过：如实终止，零网络腿
                rec.status, rec.reason, rec.advice = STATUS_RED_RECHECK, kind, advice
                self.progress.emit(rec.site, rec.slot, "red_recheck_blocked",
                                   progress=f"{i + 1}/{total}", detail=kind)
                continue
            adapter = self.adapters[rec.site]
            if _is_two_stage(adapter):
                self._collect_two_stage(adapter, rec, i, total)
            else:
                self._walk_ladder(adapter, rec, phase="collect", i=i, total=total)

    def _collect_two_stage(self, adapter, rec: SlotRecord, i: int, total: int) -> None:
        """两段式采集腿（wenku 位形）：预算→池→cookie 注入→collect_reader_info。"""
        try:
            self._budget.spend(1, f"collect:{rec.slot}")
        except BudgetExhausted as exc:
            self._budget_stop(rec, str(exc), i, total)
            return
        acct = self._acquire_account(rec, i, total)
        if acct is _POOL_DRAINED:
            return
        cookie = acct.cookie if acct is not None else ""
        rec.cookie_slot = acct.name if acct is not None else ""
        doc = str(rec.plan.meta.extra.get("doc_id") or rec.slot)
        self.progress.emit(rec.site, rec.slot, "collect_start",
                           progress=f"{i + 1}/{total}", detail=f"doc={doc}")
        kwargs = {"meta": rec.plan.meta}
        if _accepts_kwarg(adapter.collect_reader_info, "cookie"):
            kwargs["cookie"] = cookie
        t0 = self._clock()
        try:
            bundle = adapter.collect_reader_info(doc, **kwargs)
        except Exception as exc:  # 采集折损如实分态（不炸主链）
            rec.status = STATUS_FAILED
            rec.reason = f"collect_error:{type(exc).__name__}: {exc}"
            self.audit.request(site=rec.site, event="collect", query_or_docid=rec.slot,
                               count=1, status="fail", detail=rec.reason)
            self.progress.emit(rec.site, rec.slot, "collect_fail",
                               progress=f"{i + 1}/{total}", detail=rec.reason)
            self._consume_adapter_events(adapter, rec, acct)
            return
        elapsed = self._clock() - t0
        rec.bundle = bundle
        rec.status = STATUS_COLLECTED
        self._consume_adapter_events(adapter, rec, acct)
        self.audit.request(site=rec.site, event="collect", query_or_docid=rec.slot,
                           count=1, status="ok",
                           detail=f"doc={doc} elapsed_s={elapsed:.3f}"
                                  + (f" cookie_slot={rec.cookie_slot}"
                                     if rec.cookie_slot else " anonymous"))
        self.progress.emit(rec.site, rec.slot, "collect_done",
                           progress=f"{i + 1}/{total}",
                           detail=f"doc={doc} elapsed_s={elapsed:.3f}")

    def _acquire_account(self, rec: SlotRecord, i: int, total: int):
        """池取槽（有池才取）：None=无池；哨兵=池尽（槽如实 pool_exhausted）。"""
        if self._pool is None:
            return None
        acct = self._pool.acquire(rec.site)
        if acct is None:
            rec.status = STATUS_POOL
            rec.reason = "account_pool 全冷却/熔断（acquire=None）"
            self.audit.request(site=rec.site, event="collect", query_or_docid=rec.slot,
                               count=0, status="fail", detail=rec.reason)
            self.progress.emit(rec.site, rec.slot, "pool_exhausted",
                               progress=f"{i + 1}/{total}", detail=rec.reason)
            return _POOL_DRAINED
        return acct

    def _budget_stop(self, rec: SlotRecord, why: str, i: int, total: int) -> None:
        """预算硬顶如实停：未收槽位如实分态（不伪造产物）。"""
        rec.status = STATUS_BUDGET
        rec.reason = why
        self.audit.request(site=rec.site, event="budget", query_or_docid=rec.slot,
                           count=0, status="fail", detail=why)
        self.progress.emit(rec.site, rec.slot, "budget_stop",
                           progress=f"{i + 1}/{total}", detail=why)

    def close_browsers(self) -> None:
        """阶段边界：收口浏览器（T38 sync_playwright 不可嵌套——collect 全毕才 dispatch）。"""
        detail = "browser_close"
        if self._browser_close is not None:
            self._browser_close()
        else:
            detail = "browser_close（未注入收口钩子，如实注记）"
        self.progress.emit("order", "", "browser_close", detail=detail)

    # ------------------------------------------------------------ 梯队降级循环（T16 真符号消费）

    def _walk_ladder(self, adapter, rec: SlotRecord, *, phase: str,
                     i: int = 0, total: int = 1) -> None:
        """按 plan.ladder_try 逐级窄化推进（降级循环本体=编排层，T16 判定器真符号）。

        - 窄化协议：单段位形经 HarvestPlan(ladder_try=(level,)) 传入；两段式位形经
          meta.extra["ladder_try"] 传入（dispatch_reconstruction 只吃 bundle）；
        - 事件流喂入：适配器自报 last_attempt_events（实测值）+ 编排层自观
          elapsed_s/pages（零造假：只报自己实测得到的字段）；
        - 墙标记（HARD_WALL_STATUSES）=硬拒终止不降级；无降级信号=fail-fast 如实终止。
        """
        meta = rec.plan.meta
        history: list = []
        two_stage = _is_two_stage(adapter)
        total_levels = len(tuple(rec.plan.ladder_try))
        result = None
        for step_i, level in enumerate(tuple(rec.plan.ladder_try)):
            try:
                self._budget.spend(1, f"{phase}:{rec.slot}:{level}")
            except BudgetExhausted as exc:
                self._budget_stop(rec, str(exc), i, total)
                return
            narrowed = HarvestPlan(meta=meta, slot=rec.plan.slot, ladder_try=(level,),
                                   red_check=rec.plan.red_check)
            meta.extra["ladder_try"] = (level,)
            event_name = "dispatch_start" if phase == "dispatch" else "collect_start"
            self.progress.emit(rec.site, rec.slot, event_name,
                               progress=f"{step_i + 1}/{total_levels}", detail=f"{level}")
            t0 = self._clock()
            try:
                if two_stage:
                    result = adapter.dispatch_reconstruction(rec.bundle)
                else:
                    result = adapter.fetch_ladder(narrowed)
                elapsed = self._clock() - t0
            except Exception as exc:  # 腿异常折损→失败结果如实走判定（不炸主链）
                elapsed = self._clock() - t0
                result = LadderResult(ok=False,
                                      detail=f"{phase}_leg_error:{type(exc).__name__}: {exc}")
            self._consume_adapter_events(adapter, rec, None)
            ok = bool(result.ok)
            form = evidence = ""
            decision = None
            if not ok:
                history.extend(list(getattr(adapter, "last_attempt_events", None) or []))
                history.append(AttemptEvent(elapsed_s=elapsed, pages=meta.pages or 0))
                decision = should_degrade(history)  # T16 真符号
                form, evidence = decision.form, decision.evidence
                if getattr(adapter, "last_attempt_events", None):
                    adapter.last_attempt_events = []
            rec.attempts.append({"level": level, "ok": ok, "form": form,
                                 "evidence": evidence, "elapsed_s": round(elapsed, 3)})
            self.audit.request(
                site=rec.site, event=phase if phase == "dispatch" else "fetch_ladder",
                query_or_docid=rec.slot, count=1, status="ok" if ok else "fail",
                detail=f"ladder={level} elapsed_s={elapsed:.3f}"
                       + (f" form={form} {evidence}" if form else "")
                       + f" detail={result.detail[:160]}")
            if ok:
                rec.result, rec.ladder_used = result, (result.ladder_used or level)
                rec.status = STATUS_FETCHED
                self.progress.emit(rec.site, rec.slot,
                                   "dispatch_done" if phase == "dispatch" else "collect_done",
                                   progress=f"{step_i + 1}/{total_levels}",
                                   detail=f"ladder={rec.ladder_used} pages={result.pages}")
                return
            if result.wall_status in HARD_WALL_STATUSES:  # 墙=硬拒不降级
                rec.result = result
                rec.status = STATUS_FAILED
                rec.reason = f"wall_reject:{result.wall_status}"
                self.audit.request(site=rec.site, event="degrade", query_or_docid=rec.slot,
                                   count=0, status="fail",
                                   detail=f"wall_reject wall_status={result.wall_status}（不降级）")
                self.progress.emit(rec.site, rec.slot, "wall_reject",
                                   detail=f"wall_status={result.wall_status}（硬拒不降级）")
                return
            nxt = next_ladder(level) if (decision is not None and decision.degrade) else None
            if nxt is None:  # 无降级信号或已到底 → fail-fast 如实终止
                rec.result = result
                rec.status = STATUS_FAILED
                rec.reason = f"ladder_exhausted_at:{level} form={form or 'none'}"
                return
            self.audit.request(site=rec.site, event="degrade", query_or_docid=rec.slot,
                               count=1, status="fail",
                               detail=f"{level}->{nxt} form={form} {evidence}")
            self.progress.emit(rec.site, rec.slot, "degrade",
                               progress=nxt, detail=f"{level}->{nxt} form={form} {evidence}")
        rec.result = result  # 梯队走完仍未成（全败 ladder_used=None 如实）
        rec.status = STATUS_FAILED
        rec.reason = "ladder_all_failed"

    # ------------------------------------------------------------ 阶段2 dispatch

    def dispatch_phase(self, order: HarvestOrder, records: list) -> None:
        """阶段2：重组/打印腿（浏览器已收口）——两段式 dispatch 走梯队；单段直通。"""
        runnable = [r for r in records if r.status in (STATUS_COLLECTED, STATUS_FETCHED)]
        total = len(runnable)
        for i, rec in enumerate(runnable):
            adapter = self.adapters[rec.site]
            if rec.status == STATUS_COLLECTED:
                self._walk_ladder(adapter, rec, phase="dispatch", i=i, total=total)
            else:  # 单段位形：产物在阶段1 已到手，本阶段浏览器无涉直通（如实注记）
                self.progress.emit(rec.site, rec.slot, "dispatch_start",
                                   progress=f"{i + 1}/{total}", detail="single_stage_passthrough")
                self.audit.request(site=rec.site, event="dispatch", query_or_docid=rec.slot,
                                   count=0, status="ok", detail="single_stage_passthrough")
                self.progress.emit(rec.site, rec.slot, "dispatch_done",
                                   progress=f"{i + 1}/{total}", detail="single_stage_passthrough")
        for rec in records:  # 收口分态：walk 未置终态的（预算停/池尽已置）不动
            if rec.status == STATUS_COLLECTED:
                rec.status = STATUS_FAILED
                rec.reason = "dispatch 阶段未执行（如实现状）"

    # ------------------------------------------------------------ 段4 质检期

    def quality_phase(self, order: HarvestOrder, records: list) -> None:
        """质检：段4 adapter.verify 真符号 + 水印抽帧实测；VIP 件门③解耦口径（④）。"""
        fetched = [r for r in records if r.status == STATUS_FETCHED]
        total = len(fetched)
        for i, rec in enumerate(fetched):
            result = rec.result
            adapter = self.adapters[rec.site]
            try:
                verdict = adapter.verify(result)  # 段4 真符号（True/False）
                verdict = None if verdict is None else bool(verdict)
            except Exception as exc:  # 未实装/不可得 → None 如实（不以不可得充过门）
                verdict = None
                rec.reason = f"verify_error:{type(exc).__name__}: {exc}"
            watermark = measure_watermark(result.artifact_path) \
                if result.artifact_path else None
            decoupled = result.wall_status == WALL_NEEDS_VIP_CANDIDATE
            rec.qc = {"verify": verdict, "watermark_scan": watermark,
                      "gate3_decoupled": decoupled}
            if verdict is True:
                rec.status = STATUS_DELIVERED
            elif verdict is False and decoupled:
                # ④ T38 下游4：needs_vip_candidate 部分件 verify 不作断言条件——
                # qc 如实记录 + 部分交付（coverage=showPage/page 如实标注）
                rec.status = STATUS_PARTIAL
            elif not result.artifact_path:
                rec.status = STATUS_NO_ARTIFACT  # ok 但无产物件（如页清单腿）如实分态
            else:
                rec.status = STATUS_QC_FAIL
            audit_status = "ok" if rec.status in (STATUS_DELIVERED, STATUS_PARTIAL) \
                else "fail"
            self.audit.request(
                site=rec.site, event="verify", query_or_docid=rec.slot,
                count=result.pages or 0, status=audit_status,
                detail=f"verify={verdict} status={rec.status}"
                       f" watermark_pages={sorted(watermark) if watermark else None}"
                       f" gate3_decoupled={decoupled}")
            self.progress.emit(rec.site, rec.slot, "qc", progress=f"{i + 1}/{total}",
                               detail=f"verify={verdict} status={rec.status}"
                                      f" coverage={result.coverage}")
        for rec in records:  # 阶段2 后仍非终态的（如 fetched 无 result）→ failed 如实
            if rec.status == STATUS_FETCHED and rec.result is None:
                rec.status = STATUS_FAILED
                rec.reason = "fetched 无产物（如实现状）"

    # ------------------------------------------------------------ 镜像树 → 交付链适配

    def mirror_phase(self, order: HarvestOrder, records: list) -> dict:
        """镜像树：质检过关件（delivered/partial）按槽位路径落镜像根 + harvest_manifest。"""
        mirror_root = self._work_root / order.order_id / "mirror"
        entries = []
        shipped = [r for r in records if r.status in (STATUS_DELIVERED, STATUS_PARTIAL)]
        for rec in shipped:
            result = rec.result
            src = Path(result.artifact_path)
            slot = rec.blueprint_slot
            rel_dir = _safe_rel_dir(slot.get("path") or "")
            ext = str(slot.get("ext") or src.suffix.lstrip(".") or "pdf").lstrip(".")
            name = f"{_safe_name(rec.title or rec.slot)}.{ext}"
            dest_dir = mirror_root / rel_dir
            dest_dir.mkdir(parents=True, exist_ok=True)
            dest = dest_dir / name
            shutil.copy2(src, dest)  # copy 非 move：适配器产物源不动
            rec.artifact = HarvestArtifact(
                slot=rec.slot, path=str(dest), fmt=ext, pages=result.pages,
                chars=result.chars, watermark_scan=(rec.qc or {}).get("watermark_scan"),
                source_badge=rec.badge, ladder_used=rec.ladder_used,
                wall_status=result.wall_status, coverage=result.coverage,
                ledger_ref=str(self.audit.path))
            rec.coverage = result.coverage
            entries.append({"slot": rec.slot, "title": rec.title, "site": rec.site,
                            "src": str(src), "dest": str(dest), "name": name,
                            "status": rec.status, "pages": result.pages,
                            "chars": result.chars, "coverage": result.coverage,
                            "ladder_used": rec.ladder_used})
            self.audit.request(site=rec.site, event="mirror", query_or_docid=rec.slot,
                               count=result.pages or 0, status="ok",
                               detail=f"{src.name}->"
                                      f"{dest.relative_to(mirror_root).as_posix()}")
        manifest_path = mirror_root / "harvest_manifest.json"
        manifest_path.parent.mkdir(parents=True, exist_ok=True)
        manifest_path.write_text(json.dumps(
            {"order_id": order.order_id,
             "summary": {"slots": len(records), "shipped": len(entries)},
             "slots": [r.to_dict() for r in records]}, ensure_ascii=False, indent=1),
            encoding="utf-8")
        self.progress.emit("order", "", "mirror", progress=f"{len(entries)}/{len(records)}",
                           detail=f"root={mirror_root}")
        return {"root": str(mirror_root), "manifest": str(manifest_path),
                "entries": entries}

    def run_chain(self, order: HarvestOrder, records: list, mirror: dict, *,
                  blueprint_ref, email, base_dir) -> dict:
        """既有交付链对接（真符号非 mock）：镜像根挂 LocalCorpus → pipeline.run 建树打包。

        交付链本身零改动：引擎只提供入参（fulfillment.Order + 镜像语料 corpus）；
        黄槽（wenku_vip）由交付链 v1 口径如实进获取指引（引擎侧产物在
        harvest_manifest 如实在案）。发送腿（deliver/SMTP）不在本件射程。
        """
        fo = to_fulfillment_order(order, blueprint_ref=blueprint_ref, email=email)
        sources_local = _fulfillment("sources_local")
        corpus = sources_local.LocalCorpus(roots=[mirror["root"]])
        corpus.scan()
        pipeline = _fulfillment("pipeline")
        br = pipeline.run(fo, base_dir=base_dir, corpus=corpus)
        chain = {"order_id": br.order_id, "kb_name": br.kb_name,
                 "build_dir": br.build_dir, "zip_path": br.zip_path,
                 "stats": dict(br.stats)}
        self.audit.request(site="fulfillment", event="chain",
                           query_or_docid=order.order_id,
                           count=br.stats.get("delivered", 0), status="ok",
                           detail=f"zip={br.zip_path} stats={br.stats}")
        self.progress.emit("fulfillment", "", "chain",
                           progress=f"{br.stats.get('delivered', 0)}/"
                                    f"{br.stats.get('slots', 0)}",
                           detail=f"zip={br.zip_path}")
        return chain

    # ------------------------------------------------------------ 主链

    def run(self, order: HarvestOrder, *, blueprint_ref=None, email=None,
            base_dir=None) -> HarvestReport:
        """一单全链：计划→采集→收口浏览器→重组→质检→镜像树→交付链→事件件收口。"""
        total = len(order.blueprint_slots)
        self.progress.emit("order", "", "order_start", progress=f"0/{total}",
                           detail=f"budget_requests={order.budget.net_requests}")
        self.audit.request(site="order", event="order_start",
                           query_or_docid=order.order_id, count=total, status="ok",
                           detail=f"budget_requests={order.budget.net_requests}")
        self._ensure_budget(order)
        records = self.plan_order(order)
        self.collect_phase(order, records)
        self.close_browsers()          # ① 两段式阶段边界：采集窗收口后才重组
        self.dispatch_phase(order, records)
        self.quality_phase(order, records)
        mirror = self.mirror_phase(order, records)
        chain = None
        if blueprint_ref and email:
            chain = self.run_chain(order, records, mirror, blueprint_ref=blueprint_ref,
                                   email=email, base_dir=base_dir or self._work_root)
        report = HarvestReport(
            order_id=order.order_id, slots=records, budget=self._budget.to_dict(),
            mirror=mirror, chain=chain,
            events_path=str(getattr(self.progress, "path", "")),
            ledger_ref=str(self.audit.path))
        got = report.counts()
        self.progress.emit("order", "", "order_done",
                           progress=f"{got['delivered'] + got['partial']}/{total}",
                           detail=f"counts={got} budget={report.budget}")
        self.audit.request(site="order", event="order_done",
                           query_or_docid=order.order_id,
                           count=got["delivered"] + got["partial"], status="ok",
                           detail=f"counts={got} budget={report.budget}")
        return report
