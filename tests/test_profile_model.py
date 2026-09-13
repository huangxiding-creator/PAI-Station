"""M5.1 用户画像：五层+双时间线（失效不删可溯）+四操作。"""
from datetime import datetime

from paistation.profile.model import ProfileModel


def _clk(fixed="2026-09-13T12:00:00"):
    now = datetime.fromisoformat(fixed)
    return lambda: now


def test_record_and_query_current(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk())
    p.record("identity", "姓名", "宗宝")
    p.record("knowledge", "主营业务", "水利工程 EPC 总承包")
    assert [e.value for e in p.query(layer="identity")] == ["宗宝"]
    assert any("EPC" in e.value for e in p.query(keyword="EPC"))


def test_dual_timeline_update_expires_not_deletes(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk())
    p.record("identity", "常驻城市", "北京")
    p.record("identity", "常驻城市", "上海")     # 搬家=事实失效
    current = p.query(layer="identity", keyword="常驻")
    assert [e.value for e in current] == ["上海"]
    timeline = p.history("常驻城市", layer="identity")
    assert len(timeline) == 2                   # 旧事实仍在时间线
    assert timeline[0].effective_to is not None  # 旧的已被封口
    assert timeline[1].effective_to is None      # 新的开放


def test_record_same_value_noop(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk())
    p.record("preference", "作息", "早睡早起")
    p.record("preference", "作息", "早睡早起")
    assert len(p.history("作息", layer="preference")) == 1


def test_expire_and_persistence_roundtrip(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk())
    e = p.record("workflow", "周报习惯", "每周五下班前写周报")
    p.expire(e.id)
    assert p.query(keyword="周报") == []
    reopened = ProfileModel(tmp_path, clock=_clk())
    assert reopened.history("周报习惯", layer="workflow")[0].effective_to is not None


def test_layers_all_present(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk())
    for layer in ("identity", "preference", "knowledge", "workflow",
                  "achievement"):
        p.record(layer, f"{layer}键", f"{layer}值")
    assert len(p.query()) == 5
