# -*- coding: utf-8 -*-
"""test_redteam — 红队轮战役级契约测试 (T-013 / REQ-043.AC1 收口位).

详测在 test_redteam_run.py (合成框架/树/池 → 路径带/退出码/KAC 联动/降级);
本件收口真实产物契约: work/redteam_EPC-BID26.json 须含失败路径 ≥3 条、
逐条回应 (response 非空) 与 material_diff 在案 — 与任务图 verify 命令同口径。
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import redteam_run as RT                                      # noqa: E402

_REAL_OUT = RT.WORK_DIR / "redteam_EPC-BID26.json"
_REAL_POOL = RT.POOL_ROOT / "EPC-BID26" / "pool_state.json"


def test_module_exposes_runner_contract():
    """run(campaign, framework_md=None) 战役级入口在位, 五族+定制位齐备."""
    assert callable(RT.run)
    assert set(RT.FAMILIES) == {"数据时效失效", "单一信源垄断", "口径错配",
                                "反证缺失", "样本偏差"}
    assert RT.CUSTOM_FAMILY == "战役定制"


@pytest.mark.skipif(not (_REAL_OUT.exists() and _REAL_POOL.exists()),
                    reason="BID26 红队产物/真实池缺席, 跳过实盘契约")
def test_real_bid26_artifact_contract():
    """REQ-043.AC1: 失败路径与逐条回应; ≥1 条实质修改 diff 在案 (如实降级)."""
    d = json.loads(_REAL_OUT.read_text(encoding="utf-8"))
    assert d["campaign"] == "EPC-BID26"
    assert len(d["failure_paths"]) >= 3
    assert all(p.get("response") for p in d["failure_paths"])
    assert all(p["response_status"] == "responded" for p in d["failure_paths"])
    assert d.get("material_diff")
    # BID26 无框架/无树 → 如实降级在案 (不静默伪装全知)
    assert d["framework_degraded"] is True
    assert d["kac"]["degraded"] is True
