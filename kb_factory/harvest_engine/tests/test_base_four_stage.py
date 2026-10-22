# -*- coding: utf-8 -*-
"""FR1.AC1 单测：DownloadAdapter 四段调用序 + harvest_audit 每请求如实一行。

- 驱动体=DownloadAdapter 真子类 RecordingAdapter（确定性本地实现：零网络、零 mock 框架）；
  被测对象=抽象框架本身（四段签名/FOUR_STAGES 权威序/LadderResult 契约/标记位/台账写入器）。
- 台账写 tests/fixtures/harvest_audit_test.jsonl（包内默认位 harvest_audit.jsonl 未被
  ignore，单测不得写默认位；断言后即清理）。
- 复用断言：引擎侧 FileMeta IS channel_adapters.base.FileMeta（不重复定义）。
"""
import json
import sys
from dataclasses import fields
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

from kb_factory.channel_adapters.base import FileMeta as _ChannelFileMeta  # noqa: E402

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.adapters.base import (  # noqa: E402
        FOUR_STAGES, LADDER_ORDER, WALL_NEEDS_VIP_CANDIDATE, WALL_PAID, WALL_STATUS_MARKERS,
        DownloadAdapter, FileMeta, HarvestPlan, LadderResult, mark_wall_status, next_ladder)
    from kb_factory.harvest_engine.audit import HarvestAudit  # noqa: E402
except ImportError:
    from harvest_engine.adapters.base import (  # noqa: E402
        FOUR_STAGES, LADDER_ORDER, WALL_NEEDS_VIP_CANDIDATE, WALL_PAID, WALL_STATUS_MARKERS,
        DownloadAdapter, FileMeta, HarvestPlan, LadderResult, mark_wall_status, next_ladder)
    from harvest_engine.audit import HarvestAudit  # noqa: E402

_FIXTURES = Path(__file__).resolve().parent / "fixtures"
_AUDIT_PATH = _FIXTURES / "harvest_audit_test.jsonl"


class RecordingAdapter(DownloadAdapter):
    """确定性本地驱动体：四段真实现（零网络），逐段写一行台账。"""

    site = "rec-site"

    def __init__(self, audit: HarvestAudit):
        self.audit = audit
        self.calls: list[str] = []
        self._url = ""

    def search(self, query: str, limit: int) -> list[FileMeta]:
        self.calls.append("search")
        metas = [FileMeta(title=f"{query}·候选{i + 1}", fmt="pdf", pages=3,
                          source_url=f"https://rec.test/doc/{i + 1}") for i in range(limit)]
        self.audit.request(site=self.site, event="search", query_or_docid=query,
                           count=len(metas), status="ok", detail="单测本地驱动")
        return metas

    def plan(self, meta: FileMeta) -> HarvestPlan:
        self.calls.append("plan")
        self._url = meta.source_url or meta.title
        self.audit.request(site=self.site, event="plan", query_or_docid=self._url,
                           count=1, status="ok", detail="ladder_try=L1,L2,L3")
        return HarvestPlan(meta=meta, slot="S-1")

    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        self.calls.append("fetch_ladder")
        result = LadderResult(ok=True, ladder_used="L1",
                              artifact_path=str(_FIXTURES / "fake_artifact.pdf"),
                              pages=plan.meta.pages, chars=1800,
                              coverage=f"{plan.meta.pages}/{plan.meta.pages}",
                              detail="本地合成，无网络")
        self.audit.request(site=self.site, event="fetch_ladder", query_or_docid=self._url,
                           count=result.pages, status="ok",
                           detail=f"ladder_used={result.ladder_used}")
        return result

    def verify(self, result: LadderResult) -> bool:
        self.calls.append("verify")
        ok = bool(result.ok and result.pages and result.chars)
        self.audit.request(site=self.site, event="verify", query_or_docid=self._url,
                           count=1, status="ok" if ok else "fail", detail="质检门单测口径")
        return ok


def _fresh_audit() -> HarvestAudit:
    _FIXTURES.mkdir(parents=True, exist_ok=True)
    if _AUDIT_PATH.exists():
        _AUDIT_PATH.unlink()  # 台账为 append 型：每轮重置保证断言确定性
    return HarvestAudit(path=str(_AUDIT_PATH))


def test_req_fr1_ac1_four_stage_call_order():
    """FR1.AC1 前半：四段权威序 + 逐文档调用序 search→plan→fetch_ladder→verify。"""
    assert FOUR_STAGES == ("search", "plan", "fetch_ladder", "verify")
    adapter = RecordingAdapter(_fresh_audit())
    metas = adapter.search("水利EPC", 2)
    assert len(metas) == 2 and all(isinstance(m, FileMeta) for m in metas)
    for meta in metas:
        plan = adapter.plan(meta)
        assert isinstance(plan, HarvestPlan) and plan.meta is meta
        assert plan.ladder_try == LADDER_ORDER
        result = adapter.fetch_ladder(plan)
        assert isinstance(result, LadderResult) and result.ladder_used in LADDER_ORDER
        assert adapter.verify(result) is True
    assert adapter.calls == [FOUR_STAGES[0]] + list(FOUR_STAGES[1:]) * len(metas)
    with pytest.raises(TypeError):
        DownloadAdapter()  # 抽象基类不可实例化：四段缺一不可


def test_req_fr1_ac1_harvest_audit_one_line_per_request():
    """FR1.AC1 后半：每请求如实一行 + 七列字段齐 + 事件序==调用序 + FileMeta 复用真符号。"""
    adapter = RecordingAdapter(_fresh_audit())
    metas = adapter.search("泵站施工", 2)
    for meta in metas:
        adapter.verify(adapter.fetch_ladder(adapter.plan(meta)))
    lines = _AUDIT_PATH.read_text(encoding="utf-8").splitlines()
    assert len(lines) == 1 + 3 * len(metas) == 7  # 每请求一行：1 次检索 + 2 文档×3 段
    for line in lines:
        rec = json.loads(line)
        assert list(rec) == ["ts", "site", "event", "query_or_docid",
                             "count", "status", "detail"]
        assert rec["site"] == "rec-site" and rec["event"] in FOUR_STAGES
        assert isinstance(rec["count"], int) and rec["count"] >= 0
        assert rec["status"] in ("ok", "fail")
    events = [json.loads(line)["event"] for line in lines]
    assert events == ["search"] + ["plan", "fetch_ladder", "verify"] * len(metas)
    assert FileMeta is _ChannelFileMeta  # 复用元数据层真符号，不重复定义


def teardown_module(module):
    """运行时台账不留仓：测毕清理 fixtures 下临时台账（默认位未被 ignore，单测只写 fixtures）。"""
    if _AUDIT_PATH.exists():
        _AUDIT_PATH.unlink()


def test_req_nfr1_wall_status_marker_lands_on_filemeta_extra():
    """NFR1 标记映射：统一词表 → FileMeta.extra.wall_status；词表外硬拒。"""
    meta = FileMeta(title="VIP专享文档", fmt="pdf", pages=20)
    assert mark_wall_status(meta, WALL_PAID) is meta
    assert meta.extra["wall_status"] == "paid_wall"
    for marker in WALL_STATUS_MARKERS:
        m = FileMeta(title="t", fmt="pdf")
        assert mark_wall_status(m, marker).extra["wall_status"] == marker
    expected = ("needs_vip_candidate", "paid_wall", "blocked_waf", "blocked_mirror_policy")
    assert set(WALL_STATUS_MARKERS) == set(expected)
    with pytest.raises(ValueError):
        mark_wall_status(meta, "自定义墙")  # 统一语言禁同义词：词表外一律 ValueError


def test_ladder_result_contract_and_ladder_step():
    """LadderResult 字段序=任务书契约；梯队步进 L1→L2→L3→None。"""
    names = [f.name for f in fields(LadderResult)]
    expected = ["ok", "ladder_used", "artifact_path", "pages", "chars",
                "wall_status", "coverage", "detail"]
    assert names == expected
    failed = LadderResult(ok=False)
    assert failed.ladder_used is None and failed.artifact_path is None
    assert failed.pages is None and failed.chars is None
    assert failed.wall_status is None and failed.coverage is None and failed.detail == ""
    partial = LadderResult(ok=True, ladder_used="L3", pages=6, chars=900,
                           wall_status=WALL_NEEDS_VIP_CANDIDATE, coverage="6/20")
    assert partial.coverage == "6/20" and partial.wall_status in WALL_STATUS_MARKERS
    assert next_ladder("L1") == "L2" and next_ladder("L2") == "L3" and next_ladder("L3") is None
    with pytest.raises(ValueError):
        next_ladder("L4")
