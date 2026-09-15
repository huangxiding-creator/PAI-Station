"""M7c 纠正飞轮：晨报修正 → 样本库 → ICL 注入（SummAct +21.9% 路线）。"""
import json

from paistation.intent.flywheel import (
    IntentSampleStore,
    build_icl,
    note_correction,
)

_BLOCK = {"start": "2026-09-15T10:00:00", "category": "leisure",
          "label": "休息娱乐", "titles": ["游戏直播"], "process": "chrome.exe"}


def _digest(block):
    return " | ".join([block["titles"][0], block["process"]])


def test_store_add_and_recent(tmp_path):
    s = IntentSampleStore(tmp_path / "samples.jsonl")
    s.add(_BLOCK, gold="在查游戏攻略（实为 research）")
    s.add({**_BLOCK, "titles": ["另一个直播"]}, gold="在休息看直播")
    rows = s.recent(n=1)
    assert len(rows) == 1
    assert rows[0]["gold"] == "在休息看直播"          # 最近优先


def test_store_persists_across_instances(tmp_path):
    path = tmp_path / "samples.jsonl"
    IntentSampleStore(path).add(_BLOCK, gold="判读A")
    rows = IntentSampleStore(path).recent()
    assert rows[0]["gold"] == "判读A"
    assert len(path.read_text(encoding="utf-8").splitlines()) == 1


def test_note_correction_keeps_wrong_for_analysis(tmp_path):
    s = IntentSampleStore(tmp_path / "samples.jsonl")
    note_correction(s, _BLOCK, wrong="在娱乐看直播", gold="在查攻略")
    row = s.recent()[0]
    assert row["wrong"] == "在娱乐看直播"
    assert row["gold"] == "在查攻略"


def test_build_icl_empty_and_filled(tmp_path):
    assert build_icl(IntentSampleStore(tmp_path / "x.jsonl")) == ""
    s = IntentSampleStore(tmp_path / "x.jsonl")
    note_correction(s, _BLOCK, wrong="娱乐", gold="查攻略")
    icl = build_icl(s)
    assert "历史修正" in icl
    assert "查攻略" in icl


def test_corrupt_lines_fail_soft(tmp_path):
    """坏行不炸（缺席不崩），好行照常读出。"""
    path = tmp_path / "samples.jsonl"
    path.write_text("不是json\n" + json.dumps(
        {"digest": "d", "gold": "好样本", "wrong": "", "ts": "t"},
        ensure_ascii=False) + "\n", encoding="utf-8")
    rows = IntentSampleStore(path).recent()
    assert [r["gold"] for r in rows] == ["好样本"]
