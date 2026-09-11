"""M8.1 液态架构 organ 模块 TDD（PROPOSAL_V2.md 第 3 章器官宪法）。

覆盖三件套：
- registry：12 器官全注册、字段齐备（使命/IO/质量门/触发器）、未知器官显式报错
- state：_state.json 液态状态——默认态、原子落盘、不可变更新、水位只前进不后退
- credential：流转凭证——签发带摘要、篡改可验、审计链追加、全链审计

红线：一切写动作仅发生在 12 器官目录内（R14 凭证不可绕过的基础设施）。
"""
import json

import pytest

from paistation.organ import credential as cred


# ---------------------------------------------------------------------------
# registry
# ---------------------------------------------------------------------------

def test_registry_has_exactly_twelve_organs():
    from paistation.organ import registry
    assert len(registry.ORGANS) == 12
    ids = [o.id for o in registry.ORGANS]
    assert ids == [f"{i:02d}" for i in range(12)]


def test_registry_every_organ_has_full_contract():
    from paistation.organ import registry
    for spec in registry.ORGANS:
        assert spec.name, f"{spec.id} 缺名称"
        assert spec.mission, f"{spec.id} 缺使命"
        assert spec.inputs and spec.outputs, f"{spec.id} 缺 IO 契约"
        assert spec.quality_gate, f"{spec.id} 缺质量门"
        assert spec.trigger, f"{spec.id} 缺自主更新触发器"


def test_registry_lookup_by_id_and_name():
    from paistation.organ import registry
    assert registry.find("04").name == "智库"
    assert registry.find_by_name("智库").id == "04"
    with pytest.raises(KeyError):
        registry.find("99")
    with pytest.raises(KeyError):
        registry.find_by_name("不存在器官")


# ---------------------------------------------------------------------------
# state（液态状态 _state.json）
# ---------------------------------------------------------------------------

def test_state_default_when_missing(tmp_path):
    from paistation.organ.state import load_state
    st = load_state(tmp_path, "01")
    assert st.organ_id == "01"
    assert st.items == 0
    assert st.watermark == {}


def test_state_save_load_roundtrip(tmp_path):
    from paistation.organ.state import load_state, save_state, touch
    st = load_state(tmp_path, "04")
    st2 = touch(st, items=4255, freshness="2026-09-11")
    save_state(tmp_path, st2)
    back = load_state(tmp_path, "04")
    assert back.items == 4255
    assert back.freshness == "2026-09-11"
    # 文件真实落盘在器官目录内
    assert (tmp_path / "04 智库" / "_state.json").exists()


def test_state_touch_is_immutable():
    from paistation.organ.state import OrganState, touch
    st = OrganState(organ_id="01")
    st2 = touch(st, items=10)
    assert st.items == 0 and st2.items == 10  # 原对象不被改写


def test_state_watermark_never_regresses():
    from paistation.organ.state import OrganState, advance_watermark
    st = OrganState(organ_id="06", watermark={"chat": "2026-09-10T00:00:00"})
    ok = advance_watermark(st, "chat", "2026-09-11T00:00:00")
    assert ok.watermark["chat"] == "2026-09-11T00:00:00"
    stale = advance_watermark(ok, "chat", "2026-09-01T00:00:00")
    assert stale.watermark["chat"] == "2026-09-11T00:00:00"  # 水位不后退


# ---------------------------------------------------------------------------
# credential（流转凭证，R14）
# ---------------------------------------------------------------------------

def test_credential_issue_and_verify():
    c = cred.issue(kind="refine", upstream="04 智库", downstream="05 方法",
                   payload={"items": 3})
    assert cred.verify(c) is True
    broken = cred._replace(c, payload={"items": 999})  # 篡改负载
    assert cred.verify(broken) is False


def test_credential_requires_contract_fields():
    with pytest.raises(ValueError):
        cred.issue(kind="", upstream="04 智库", downstream="05 方法", payload={})
    with pytest.raises(ValueError):
        cred.issue(kind="refine", upstream="", downstream="05 方法", payload={})


def test_credential_chain_append_and_read(tmp_path):
    c1 = cred.issue(kind="refine", upstream="04 智库", downstream="05 方法", payload={})
    c2 = cred.issue(kind="package", upstream="05 方法", downstream="06 技能", payload={})
    p1 = cred.append_to_chain(tmp_path, "05 方法", c1)
    cred.append_to_chain(tmp_path, "06 技能", c2)
    chain = cred.read_chain(tmp_path, "05 方法")
    assert [x.id for x in chain] == [c1.id]
    assert p1.parent.name == "_credentials"
    assert p1.parent.parent.name == "05 方法"


def test_audit_chain_reports_tampering(tmp_path):
    c = cred.issue(kind="refine", upstream="04 智库", downstream="05 方法", payload={"k": 1})
    cred.append_to_chain(tmp_path, "05 方法", c)
    # 篡改链文件中的一行 payload
    chain_file = tmp_path / "05 方法" / "_credentials" / "chain.jsonl"
    rows = [json.loads(line) for line in chain_file.read_text(encoding="utf-8").splitlines()]
    rows[0]["payload"] = {"k": 2}
    chain_file.write_text("\n".join(json.dumps(r, ensure_ascii=False) for r in rows),
                          encoding="utf-8")
    report = cred.audit_chain(tmp_path)
    assert report["total"] == 1
    assert report["bad"] == 1
    assert report["ok"] == 0
