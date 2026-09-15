"""M7c 意图记忆：MIRIX 六类 ↔ profile 五层对接（workflow 层）。"""
from paistation.intent.intent_memory import recent_intents, record_intent
from paistation.profile.model import ProfileModel

_BLOCK = {"start": "2026-09-15T10:00:00", "category": "project",
          "label": "做项目"}
_INTENT = {"activity": "在写意图层测试", "confidence": 0.85}


def test_record_intent_to_workflow_layer(tmp_path):
    p = ProfileModel(tmp_path)
    e = record_intent(p, _BLOCK, _INTENT)
    assert e.layer == "workflow"
    assert e.key == "intent:project"
    assert e.value == "在写意图层测试"
    assert e.confidence == 0.85
    assert e.source == "2026-09-15T10:00:00"


def test_record_intent_idempotent_same_value(tmp_path):
    p = ProfileModel(tmp_path)
    record_intent(p, _BLOCK, _INTENT)
    record_intent(p, _BLOCK, _INTENT)
    assert len(p.query(layer="workflow")) == 1   # 同值幂等


def test_record_intent_empty_activity_skipped(tmp_path):
    p = ProfileModel(tmp_path)
    assert record_intent(p, _BLOCK, {"activity": ""}) is None
    assert p.query(layer="workflow") == []


def test_recent_intents_newest_first(tmp_path):
    p = ProfileModel(tmp_path)
    record_intent(p, {**_BLOCK, "start": "2026-09-15T09:00:00",
                      "category": "research"},
                  {"activity": "查资料", "confidence": 0.7})
    record_intent(p, _BLOCK, _INTENT)
    rows = recent_intents(p, n=1)
    assert len(rows) == 1
    assert rows[0].value == "在写意图层测试"    # 只取最近 n 条
