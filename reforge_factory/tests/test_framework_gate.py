# -*- coding: utf-8 -*-
"""P1-1 S1 出口呈审门单测 (framework_gate).

覆盖: ①build+submit 呈审件落盘+ledger 时间戳链+坏框架禁出门 ②三态回执
(APPROVED 批准/EXEMPT 豁免须 reason 绝不静默/EDIT 往返 ≤2 轮第 3 次
escalate) ③s2_gate 出队闸 (积分制/账号面须批准记录, 免费面直行) ④ast
零网络根模块机检.

跑法: python -X utf8 tests/test_framework_gate.py   (pytest 兼容)
"""
import ast
import json
import sys
import tempfile
from pathlib import Path

_TMP = Path(tempfile.mkdtemp(prefix="p11_test_"))
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import framework_gate as FGATE          # noqa: E402

FGATE._push_wecom = lambda text: True                  # 零真发 (注入)

_BD = _TMP / "battle"
_OUT = _BD / "00 研究报告需求"
_OUT.mkdir(parents=True)
_CAMP = "TEST-P11"

_FW = {"schema": "framework_v1", "campaign_id": _CAMP,
       "report_title": "《甲公司怎么干EPC总承包？》", "family": "enterprise",
       "version": 1, "chapters": [
           {"id": "ch01", "title": "引言", "description": "d",
            "tier_map": {"T1": ["甲公司"]}, "channels": ["current_increment"],
            "budget_band": "outline_wide", "evidence_density": "low"},
           {"id": "ch02", "title": "企业基本面", "description": "d",
            "tier_map": {"T1": ["甲公司"], "T2": ["乙公司"]},
            "channels": ["stock_harvest"], "budget_band": "section_narrow",
            "evidence_density": "low"}],
       "volume_ref": {"chapters": 2, "sections": 20, "total_chars": 60000}}
(_OUT / "framework.json").write_text(
    json.dumps(_FW, ensure_ascii=False), encoding="utf-8")


def _ledger():
    p = _OUT / FGATE.LEDGER
    return [json.loads(x) for x in
            p.read_text(encoding="utf-8").splitlines() if x.strip()]


# ------------------------------------------------ ① build+submit
def test_01_build_submit():
    d, out, errs = FGATE.build(str(_BD), _CAMP)
    assert not errs and d["n_chapters"] == 2 and d["total_tier_words"] == 3
    assert d["fingerprint"] and d["round"] == 1
    d2, out2, ok = FGATE.submit(str(_BD), _CAMP)
    assert d2["approval"] == "pending" and ok          # 推送注入=成功
    assert (_OUT / FGATE.REVIEW_MD).read_text(
        encoding="utf-8").startswith("# 框架呈审件")
    led = _ledger()
    assert [e["event"] for e in led] == ["built", "submitted"]
    assert all(e["ts"] >= led[0]["ts"] for e in led)   # ISO 单调
    # 坏框架禁出门: 空 channels → validate 错 → submit 硬拒+留痕
    bad = json.loads(json.dumps(_FW))
    bad["chapters"][0]["channels"] = []
    (_OUT / "framework.json").write_text(
        json.dumps(bad, ensure_ascii=False), encoding="utf-8")
    try:
        FGATE.submit(str(_BD), _CAMP)
        raise AssertionError("坏框架应拒")
    except ValueError as e:
        assert "禁呈批" in str(e)
    assert _ledger()[-1]["event"] == "submit_blocked"
    (_OUT / "framework.json").write_text(
        json.dumps(_FW, ensure_ascii=False), encoding="utf-8")  # 还原


# ------------------------------------------------ ② 三态回执
def test_02_receipt_three_states():
    d = FGATE.receipt(str(_BD), _CAMP, "APPROVED", feedback="准")
    assert d["approval"] == "approved"
    appr = json.loads((_OUT / FGATE.APPROVED_F).read_text(encoding="utf-8"))
    assert appr["verdict"] == "approved" and appr["fingerprint"]
    # EDIT 轮转
    FGATE.receipt(str(_BD), _CAMP, "EDIT", feedback="第二章拆两章")
    assert json.loads((_OUT / FGATE.REVIEW_JSON).read_text(
        encoding="utf-8"))["round"] == 2
    # EXEMPT 无 reason 硬拒 (waivers 同构绝不静默)
    try:
        FGATE.receipt(str(_BD), _CAMP, "EXEMPT", feedback="")
        raise AssertionError("无 reason 豁免应拒")
    except ValueError as e:
        assert "绝不静默" in str(e)
    assert any(e["event"] == "exempt_blocked" for e in _ledger())
    # EXEMPT 带 reason → WARN 态放行留痕
    d = FGATE.receipt(str(_BD), _CAMP, "EXEMPT", feedback="用户裁决豁免演练")
    assert d["approval"] == "exempt"
    appr = json.loads((_OUT / FGATE.APPROVED_F).read_text(encoding="utf-8"))
    assert appr["verdict"] == "exempt" and appr["waiver"] is True
    assert appr["reason"] == "用户裁决豁免演练"


# ------------------------------------------------ ③ EDIT 拉锯 escalate
def test_03_edit_rounds_escalate():
    (_OUT / FGATE.APPROVED_F).unlink()                  # 清上一轮批准
    d = json.loads((_OUT / FGATE.REVIEW_JSON).read_text(encoding="utf-8"))
    d["round"] = FGATE.MAX_EDIT_ROUNDS                  # 直跳临界轮
    (_OUT / FGATE.REVIEW_JSON).write_text(
        json.dumps(d, ensure_ascii=False), encoding="utf-8")
    d = FGATE.receipt(str(_BD), _CAMP, "EDIT", feedback="再改一轮")
    assert d["approval"] == "edit" and d.get("escalated") is True
    assert _ledger()[-1]["event"] == "escalated"   # 账尾即 escalate


# ------------------------------------------------ ④ s2_gate 出队闸
def test_04_s2_gate():
    # regulated 渠道 (积分制) 无批准记录 → 拦 (test_03 已清, 容错再清)
    (_OUT / FGATE.APPROVED_F).unlink(missing_ok=True)
    g = FGATE.s2_gate(str(_BD), {"id": "metaso", "credits": True})
    assert not g["ok"] and g["regulated"] and "禁出队" in g["why"]
    # 免费面直行 (止损在成本拐点不在零成本面)
    g2 = FGATE.s2_gate(str(_BD), {"id": "zh_search_pro"})
    assert g2["ok"] and not g2["regulated"]
    # 账号面渠道同受闸
    g3 = FGATE.s2_gate(str(_BD), {"id": "wx_export", "account_bound": True})
    assert not g3["ok"]
    # 批准在案 → regulated 放行 (verdict 透传)
    FGATE.receipt(str(_BD), _CAMP, "APPROVED", feedback="gate 测试")
    g4 = FGATE.s2_gate(str(_BD), {"id": "metaso", "credits": True})
    assert g4["ok"] and g4["verdict"] == "approved"
    st = FGATE.status(str(_BD))
    assert st["all_ts_iso"] and st["approved"]["verdict"] == "approved"


# ------------------------------------------------ ⑤ ast 零付费机检
def test_05_ast_no_network():
    tree = ast.parse(Path(FGATE.__file__).read_text(encoding="utf-8"))
    mods = set()
    for n in ast.walk(tree):
        if isinstance(n, ast.Import):
            mods.update(a.name.split(".")[0] for a in n.names)
        elif isinstance(n, ast.ImportFrom) and n.module:
            mods.add(n.module.split(".")[0])
    assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                        "socket"}), f"网络根模块混入: {mods}"


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
