# -*- coding: utf-8 -*-
"""S0-3 Charter 呈批门单测 — 全夹具隔离 (零网络/零真战役目录).

覆盖: ①build 组装+contracts 校验零错 (F2 六栏/体量/设问/反例≥3)
②两级输入 L1/L2 ③submit 机器可读件+企微可注入+ledger 留痕
④三态回执: ACCEPTED 批准进战役目录 / EDIT ≤2 轮 / 第3次 escalate
⑤批准前 S1 不动工 (s1_may_start 双态) ⑥REJECT 驳回
⑦全链时间戳 ISO 且有序 (试产全链模拟) ⑧坏件禁呈批 ⑨ast 零付费机检.

跑法: python -X utf8 tests/test_charter_gate.py   (pytest 兼容)
"""
import json
import re
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import charter_gate as cg          # noqa: E402
from superline import contracts as C              # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s03_test_"))
_T = "《中石化南京工程有限公司怎么干EPC总承包？》"
_TS = re.compile(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$")


def _battle(name):
    bd = _TMP / name
    (bd / "00 研究报告需求").mkdir(parents=True, exist_ok=True)
    return bd


def _no_wecom(calls):
    def _fake(text):
        calls.append(text)
        return True
    orig = cg._push_wecom
    cg._push_wecom = _fake
    return orig


# ------------------------------------------------ ① build + contracts 零错
def test_build_valid_and_f2_six_columns():
    bd = _battle("b1")
    ch, out, errs = cg.build(_T, battle="EPC50-SNEI",
                             battle_dir=str(bd), pool_id="EPC50-SNEI")
    assert errs == [], errs[:3]
    assert C.validate_charter(ch) == []            # 与契约层同源零错
    assert (out / cg.DRAFT).is_file()
    assert set(ch["six_columns"]) == set(cg.F2_SIX_COLUMNS)   # F2 六栏卡
    assert ch["volume"] == cg.DEFAULT_VOLUME       # 章×节×字显式
    assert "？" in ch["core_question"]              # 设问式
    assert len([q for q in ch["counter_questions"] if q.strip()]) >= 3
    assert ch["tiers"]["T1"]                        # T1 非空 (S0-2 消费)
    assert ch["ammo_budget"]["t1_min_chars"] == C.gate_defaults()["t1_min_chars"]
    assert {p["class"] for p in ch["channel_plan"]} == set(C.CHANNEL_PLAN_CLASSES)


# ------------------------------------------------ ② 两级输入 L1/L2
def test_two_level_input_l1_l2():
    bd = _battle("b2")
    ch1, _, e1 = cg.build(_T, battle_dir=str(bd), level="L1")
    assert e1 == [] and ch1["input_level"] == "L1"
    assert "怎么干成" in ch1["core_question"]
    ch2, _, e2 = cg.build("海上风电EPC交付模式", battle_dir=str(_battle("b2x")),
                          level="L2")
    assert e2 == [] and ch2["input_level"] == "L2"  # L2 自产问题走同一门
    assert ch2["core_question"].startswith("海上风电EPC交付模式")
    assert len(ch2["counter_questions"]) >= 3


# ------------------------------------------------ ③ submit 机器可读+留痕
def test_submit_machine_readable_and_ledger():
    bd = _battle("b3")
    cg.build(_T, battle_dir=str(bd))
    calls = []
    orig = _no_wecom(calls)
    try:
        ch, out, ok = cg.submit(str(bd))
        assert ok and len(calls) == 1 and "呈批" in calls[0]
        sub = json.loads((out / cg.SUBMITTED).read_text(encoding="utf-8"))
        assert sub["schema"] == "charter_v1"        # S1 直接消费机读件
        assert C.validate_charter(sub) == []
        assert (out / cg.BRIEF).is_file()
        led = cg._ledger(out)
        assert [e["event"] for e in led][-1] == "submitted"
        assert led[-1]["push_ok"] is True
    finally:
        cg._push_wecom = orig


# ------------------------------------------------ ④ EDIT ≤2轮, 第3次 escalate
def test_edit_rounds_and_escalation():
    bd = _battle("b4")
    cg.build(_T, battle_dir=str(bd))
    calls = []
    orig = _no_wecom(calls)
    try:
        cg.submit(str(bd))
        ch = cg.receipt(str(bd), "EDIT", "读者改为业务团队")   # 轮1→2
        assert ch["approval"] == "edit" and ch["round"] == 2
        assert (bd / "00 研究报告需求" / cg.DRAFT).is_file()  # 回草案可改
        cg.submit(str(bd))
        ch = cg.receipt(str(bd), "EDIT", "再改体量")          # 轮2 → escalate
        assert ch.get("escalated") is True and ch["round"] == 2
        assert any("escalated" in c for c in calls)           # 详单回呈
        led = cg._ledger(bd / "00 研究报告需求")
        assert "escalated" in [e["event"] for e in led]
        ok, why = cg.s1_may_start(str(bd))
        assert not ok                                   # escalate≠批准
    finally:
        cg._push_wecom = orig


# ------------------------------------------------ ⑤⑥ ACCEPTED/REJECT + S1 门
def test_accept_lands_in_battle_and_s1_gate():
    bd = _battle("b5")
    cg.build(_T, battle_dir=str(bd))
    ok0, _ = cg.s1_may_start(str(bd))
    assert not ok0                                       # 批准前不动工
    cg.submit(str(bd))
    ch = cg.receipt(str(bd), "ACCEPTED")
    assert ch["approval"] == "approved"
    acc = bd / "00 研究报告需求" / cg.ACCEPTED_F
    assert acc.is_file()                                 # 批准进战役目录
    doc = json.loads(acc.read_text(encoding="utf-8"))
    assert doc["fingerprint"] and _TS.match(doc["accepted"])
    ok1, why = cg.s1_may_start(str(bd))
    assert ok1 and "approved" in why
    # REJECT 路
    bd6 = _battle("b6")
    cg.build(_T, battle_dir=str(bd6))
    cg.submit(str(bd6))
    ch6 = cg.receipt(str(bd6), "REJECT", "方向错")
    assert ch6["approval"] == "edit"
    assert (bd6 / "00 研究报告需求" / cg.REJECTED_F).is_file()
    ok6, _ = cg.s1_may_start(str(bd6))
    assert not ok6


# ------------------------------------------------ ⑦ 全链时间戳 (试产模拟)
def test_full_chain_timestamps_ordered():
    bd = _battle("b7")
    calls = []
    orig = _no_wecom(calls)
    try:
        cg.build(_T, battle="EPC50-SNEI", battle_dir=str(bd),
                 pool_id="EPC50-SNEI")
        cg.submit(str(bd))
        cg.receipt(str(bd), "EDIT", "改关注点")
        cg.submit(str(bd))                              # 第2轮锁定
        cg.receipt(str(bd), "ACCEPTED")
        led = cg._ledger(bd / "00 研究报告需求")
        events = [e["event"] for e in led]
        assert events[0] == "built" and "escalated" not in events
        assert events.count("submitted") == 2 and "revise_to_draft" in events
        assert events[-2] == "accepted"                 # push 在其后
        assert all(_TS.match(e["ts"]) for e in led)     # ts 全 ISO
        ts_list = [e["ts"] for e in led]
        assert ts_list == sorted(ts_list)               # 单调不逆
        st = cg.status(str(bd))
        assert st["s1"]["ok"] and st["all_ts_iso"]
    finally:
        cg._push_wecom = orig


# ------------------------------------------------ ⑧ 坏件禁呈批
def test_submit_blocked_on_invalid_charter():
    bd = _battle("b8")
    cg.build(_T, battle_dir=str(bd))
    out = bd / "00 研究报告需求"
    bad = json.loads((out / cg.DRAFT).read_text(encoding="utf-8"))
    bad["tiers"]["T1"] = []                             # T1 空=硬伤
    (out / cg.DRAFT).write_text(json.dumps(bad, ensure_ascii=False),
                                encoding="utf-8")
    try:
        cg.submit(str(bd))
        raised = False
    except ValueError:
        raised = True
    assert raised
    assert "submit_blocked" in [e["event"]
                                for e in cg._ledger(out)]


# ------------------------------------------------ ⑨ ast 零付费机检
def test_zero_paid_no_network_imports():
    import ast as _ast
    src = Path(cg.__file__).read_text(encoding="utf-8")
    mods = set()
    for node in _ast.walk(_ast.parse(src)):
        if isinstance(node, _ast.Import):
            mods.update(a.name.split(".")[0] for a in node.names)
        elif isinstance(node, _ast.ImportFrom) and node.module:
            mods.add(node.module.split(".")[0])
    banned = {"urllib", "requests", "httpx", "curl_cffi", "socket"}
    assert not (mods & banned), f"charter 呈批门禁网络根模块: {mods & banned}"


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
