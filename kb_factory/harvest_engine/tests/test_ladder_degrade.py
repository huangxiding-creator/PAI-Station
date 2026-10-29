# -*- coding: utf-8 -*-
"""FR1.AC2 单测：梯队降级判定器 should_degrade 数值化规则 + L1→L2→L3 降级矩阵全路径。

- 被测物=adapters/base.py 纯函数与数据类（should_degrade/next_ladder/LADDER_ORDER/LadderResult）；
  零网络、零 mock 框架：失败形态=任务卡明示的确定性数值注入
  （超时 30s/页 · HTTP≥400 连续 3 次 · envelope 判失败 · 质检不过）。
- 降级矩阵=4 失败形态 × 3 路径（L1 败降 L2 成 / 降到底 L3 成 / 梯队全败）
  + L1 直成与预算内未达门不降级两条反路径；含 L3 到达断言与 ladder_used 如实记录断言（全败=None）。
- _walk_ladder 为测试内走查器（降级循环本体属 orchestrator/T40）：只组合真函数验全路径，不桩被测物。
"""
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
    from kb_factory.harvest_engine.adapters.base import (  # noqa: E402
        AttemptEvent, DegradeDecision, FAIL_FORMS, FAIL_FORM_ENVELOPE, FAIL_FORM_HTTP, FAIL_FORM_QC,
        FAIL_FORM_TIMEOUT, HTTP_CONSECUTIVE_FLOOR, HTTP_FAIL_STATUS, LADDER_ORDER, LadderResult,
        TIMEOUT_PER_PAGE_S, next_ladder, should_degrade)
except ImportError:
    from harvest_engine.adapters.base import (  # noqa: E402
        AttemptEvent, DegradeDecision, FAIL_FORMS, FAIL_FORM_ENVELOPE, FAIL_FORM_HTTP, FAIL_FORM_QC,
        FAIL_FORM_TIMEOUT, HTTP_CONSECUTIVE_FLOOR, HTTP_FAIL_STATUS, LADDER_ORDER, LadderResult,
        TIMEOUT_PER_PAGE_S, next_ladder, should_degrade)

# 四失败形态注入器（FR1.2 原文四形态；每次调用产出全新事件流）
_FORMS = (
    ("timeout", "超时30s/页", lambda: [AttemptEvent(elapsed_s=65.0, pages=2)]),
    ("http", "HTTP≥400连续3次",
     lambda: [AttemptEvent(http_status=s) for s in (503, 502, 403)]),
    ("envelope", "envelope判失败",
     lambda: [AttemptEvent(http_status=200, envelope_ok=False)]),
    ("qc", "质检不过",
     lambda: [AttemptEvent(http_status=200, envelope_ok=True, qc_pass=False)]),
)
_FORM_IDS = [f[0] for f in _FORMS]


def _walk_ladder(levels: dict) -> LadderResult:
    """测试内梯队走查器：真用 next_ladder+should_degrade 组合走完 L1→L2→L3 全路径。

    levels：每级注入的失败事件流（空流=该级一次过）。注入流未触发降级=测试建模错误，
    直接 AssertionError（同时守住判定器充分性：FR 四形态必触发）。ladder_used 如实记录终级。
    """
    ladder = LADDER_ORDER[0]
    trail: list[str] = []
    while ladder is not None:
        trail.append(ladder)
        decision = should_degrade(levels[ladder])
        assert isinstance(decision, DegradeDecision)
        if not decision.degrade:
            return LadderResult(ok=True, ladder_used=ladder, artifact_path="fixtures/fake.pdf",
                                pages=3, chars=1500, coverage="3/3",
                                detail=f"trail={'->'.join(trail)}")
        ladder = next_ladder(ladder)
    return LadderResult(ok=False, ladder_used=None, detail=f"trail={'->'.join(trail)}")


# ---------- 判定器数值化规则（单门） ----------

def test_req_fr1_ac2_fr_numeric_gates_pinned():
    """FR1.2 原文数值钉死：30s/页、HTTP≥400、连续 3 次；形态归因序=FR 列举序。"""
    assert TIMEOUT_PER_PAGE_S == 30.0
    assert HTTP_FAIL_STATUS == 400
    assert HTTP_CONSECUTIVE_FLOOR == 3
    assert FAIL_FORMS == (FAIL_FORM_TIMEOUT, FAIL_FORM_HTTP, FAIL_FORM_ENVELOPE, FAIL_FORM_QC)
    assert LADDER_ORDER == ("L1", "L2", "L3")


def test_req_fr1_ac2_timeout_rule_per_page_budget():
    """超时门=30s/页×页数：65s/2页(预算60s)降级；贴线60s/2页不降；65s/3页不降（每页预算制）。"""
    hit = should_degrade([AttemptEvent(elapsed_s=65.0, pages=2)])
    assert hit.degrade is True and hit.form == FAIL_FORM_TIMEOUT
    assert hit.evidence == "elapsed=65s>budget=60s(2页)"
    assert should_degrade([AttemptEvent(elapsed_s=60.0, pages=2)]).degrade is False  # 贴线不超
    assert should_degrade([AttemptEvent(elapsed_s=65.0, pages=3)]).degrade is False  # 预算随页数放大
    assert should_degrade([AttemptEvent(elapsed_s=30.0, pages=1)]).degrade is False
    assert should_degrade([AttemptEvent(elapsed_s=30.5, pages=1)]).degrade is True
    assert should_degrade([AttemptEvent(elapsed_s=31.0, pages=0)]).degrade is True   # pages≤0 按 1 页计


def test_req_fr1_ac2_http_rule_needs_three_consecutive():
    """HTTP 门=≥400 连续 3 次：3 连降级；2 连不降；400 计入 399 不计；被打断重计数。"""
    hit = should_degrade([AttemptEvent(http_status=s) for s in (503, 502, 400)])
    assert hit.degrade is True and hit.form == FAIL_FORM_HTTP
    assert "3x" in hit.evidence and "400" in hit.evidence
    assert should_degrade([AttemptEvent(http_status=503)] * 2).degrade is False       # 仅 2 连
    assert should_degrade([AttemptEvent(http_status=399)] * 5).degrade is False       # 399 不入 HTTP 门
    broken = [AttemptEvent(http_status=503), AttemptEvent(http_status=503),
              AttemptEvent(http_status=200, envelope_ok=False),                      # 打断连续计数
              AttemptEvent(http_status=503), AttemptEvent(http_status=503)]
    d = should_degrade(broken)
    assert d.degrade is True and d.form == FAIL_FORM_ENVELOPE  # 4 次≥400 但最长游程=2：HTTP 门未触发


def test_req_fr1_ac2_envelope_rule_single_hit():
    """envelope 门=单发即中：HTTP 200 但 envelope_ok=False 仍降级；envelope_ok=True 不降。"""
    hit = should_degrade([AttemptEvent(http_status=200, elapsed_s=2.0, pages=1, envelope_ok=False)])
    assert hit.degrade is True and hit.form == FAIL_FORM_ENVELOPE
    assert "envelope_ok=False" in hit.evidence
    fine = AttemptEvent(http_status=200, elapsed_s=2.0, pages=1, envelope_ok=True, qc_pass=True)
    assert should_degrade([fine]).degrade is False


def test_req_fr1_ac2_qc_rule_single_hit():
    """质检门=单发即中：网络层全过但产物不过质检门仍降级（「未产出可过质检门的产物」）。"""
    hit = should_degrade([AttemptEvent(http_status=200, elapsed_s=5.0, pages=3,
                                       envelope_ok=True, qc_pass=False)])
    assert hit.degrade is True and hit.form == FAIL_FORM_QC
    assert "qc_pass=False" in hit.evidence
    assert should_degrade([AttemptEvent(http_status=200, envelope_ok=True,
                                        qc_pass=True)]).degrade is False


def test_req_fr1_ac2_clean_stream_and_rule_priority():
    """空流/全界内不降级；多门同发按 FR1.2 列举序归因（超时>HTTP>envelope>质检）。"""
    empty = should_degrade([])
    assert empty.degrade is False and empty.form == "" and empty.evidence == ""
    within = [AttemptEvent(elapsed_s=10.0, pages=2, http_status=200, envelope_ok=True, qc_pass=True)]
    assert should_degrade(within).degrade is False
    mixed = [AttemptEvent(elapsed_s=100.0, pages=1),
             AttemptEvent(http_status=503), AttemptEvent(http_status=503), AttemptEvent(http_status=503)]
    assert should_degrade(mixed).form == FAIL_FORM_TIMEOUT                     # 超时先于 HTTP
    mixed2 = [AttemptEvent(http_status=503)] * 3 + [AttemptEvent(envelope_ok=False, qc_pass=False)]
    assert should_degrade(mixed2).form == FAIL_FORM_HTTP                      # HTTP 先于 envelope/质检
    assert should_degrade([AttemptEvent(envelope_ok=False,
                                        qc_pass=False)]).form == FAIL_FORM_ENVELOPE  # envelope 先于质检


# ---------- 降级矩阵：4 失败形态 × 全路径（含 L3 到达断言） ----------

def test_req_fr1_ac2_l1_success_no_degrade():
    """反路径1：L1 一次过（空失败流）→ 不降级，ladder_used=L1。"""
    result = _walk_ladder({"L1": [], "L2": [], "L3": []})
    assert result.ok is True and result.ladder_used == "L1" and result.ladder_used in LADDER_ORDER
    assert result.detail == "trail=L1"


def test_req_fr1_ac2_under_floor_failures_stay_on_l1():
    """反路径2：预算内 2 次 HTTP≥400 未达连续 3 次门 → 不降级，ladder_used 仍 L1。"""
    result = _walk_ladder({"L1": [AttemptEvent(http_status=503)] * 2, "L2": [], "L3": []})
    assert result.ok is True and result.ladder_used == "L1" and result.detail == "trail=L1"


@pytest.mark.parametrize("form_id,label,make_events", _FORMS, ids=_FORM_IDS)
def test_req_fr1_ac2_matrix_l1_fail_degrade_to_l2(form_id, label, make_events):
    """矩阵[形态×路径1]：L1 注入失败形态 → 自动降级，L2 成：ladder_used=L2。"""
    result = _walk_ladder({"L1": make_events(), "L2": [], "L3": []})
    assert result.ok is True and isinstance(result, LadderResult)
    assert result.ladder_used == "L2" and result.detail == "trail=L1->L2"


@pytest.mark.parametrize("form_id,label,make_events", _FORMS, ids=_FORM_IDS)
def test_req_fr1_ac2_matrix_degrade_all_the_way_to_l3(form_id, label, make_events):
    """矩阵[形态×路径2]：L1、L2 同形态连败 → 降到底，L3 截图+OCR 成：L3 到达断言。"""
    result = _walk_ladder({"L1": make_events(), "L2": make_events(), "L3": []})
    assert result.ok is True and result.ladder_used == "L3"          # L3 到达
    assert result.detail == "trail=L1->L2->L3"                       # 走过全梯队
    assert result.ladder_used == LADDER_ORDER[-1]


@pytest.mark.parametrize("form_id,label,make_events", _FORMS, ids=_FORM_IDS)
def test_req_fr1_ac2_matrix_all_ladders_fail(form_id, label, make_events):
    """矩阵[形态×路径3]：三级同形态全败 → ok=False、ladder_used=None（如实记录梯队全败）。"""
    result = _walk_ladder({"L1": make_events(), "L2": make_events(), "L3": make_events()})
    assert result.ok is False and result.ladder_used is None
    assert result.detail == "trail=L1->L2->L3"                       # 确曾到达 L3 后才判全败


def test_req_fr1_ac2_mixed_forms_full_path_to_l3():
    """混合形态全路径：L1 超时(95s/3页) → L2 HTTP≥400×3 → L3 成：L3 到达且 ladder_used=L3。"""
    result = _walk_ladder({"L1": [AttemptEvent(elapsed_s=95.0, pages=3)],
                           "L2": [AttemptEvent(http_status=429)] * 3,
                           "L3": []})
    assert result.ok is True and result.ladder_used == "L3"
    assert result.detail == "trail=L1->L2->L3"
