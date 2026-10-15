# -*- coding: utf-8 -*-
"""test_gates_loader — gates.json 单一权威源 loader 单测 (T-002, REQ-002/REQ-011).

覆盖:
  a) 权威源加载关键字段: t1_min_chars/t12_total_gate/三回开旗标/stopping 三参数/
     floor_per_type 三键
  b) 缺文件/坏 JSON → 回退 DEFAULTS + stderr 告警一次 (进程内去重)
  c) DEFAULTS 与磁盘 gates.json 全量对拍一致 (兜底语义永不偏航)

跑法: py -m pytest reforge_factory/tests/test_gates_loader.py -q
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import gates_loader as GL                                # noqa: E402

GATES_JSON = Path(__file__).resolve().parents[1] / "config" / "gates.json"


def test_a_disk_gates_key_fields():
    """a) 权威源关键字段 (REQ-011 新口径 + REQ-002 三旗默认关)."""
    g = GL.load_gates()
    assert g["t1_min_chars"] == 10_000_000            # REQ-011: T1 ≥ 1000万
    assert g["t12_total_gate"] is None                # REQ-011: T12 总门关闭
    assert g["t3_reference_cap_ratio"] == 1.5
    assert g["legacy_total_budget_reference"] == 200_000_000
    f = g["flags"]                                    # REQ-002: 三回开旗标
    assert [f["legacy_t12_gate"], f["legacy_total_gate"],
            f["legacy_chapter_band"]] == [False, False, False]
    s = g["stopping"]                                 # 停机三参数在
    assert s["gain_threshold_pct"] == 2.0
    assert s["rounds"] == 3
    assert s["fuse_hours"] == 72
    floor = g["chapter_band"]["floor_per_type"]       # 章型下限三键在
    assert floor == {"精编": 3000, "融合": 5000, "原创": 4000}
    assert g["report_length"]["max"] is None          # 篇幅上限撤销, 密度门主判
    assert g["report_length"]["min_chapters"] == 3


def test_a_get_helper():
    """get() 便捷读透传 + 缺键回 default."""
    assert GL.get("t1_min_chars") == 10_000_000
    assert GL.get("no_such_key", 42) == 42
    assert GL.get("no_such_key") is None


def test_b_missing_file_fallback_and_warn_once(capsys, tmp_path):
    """b) 缺文件 → 回退 DEFAULTS + stderr 告警一次, 重复读不再刷屏."""
    GL._warned.clear()
    missing = tmp_path / "no_such_gates.json"
    g1 = GL.load_gates(config_path=missing)
    assert g1 == GL.DEFAULTS                            # 回退内置默认
    err1 = capsys.readouterr().err
    assert "gates_loader" in err1 and "DEFAULTS" in err1  # stderr 有告警
    # 进程内去重: 同一失败再读, 不再产生新告警
    g2 = GL.load_gates(config_path=missing)
    assert g2 == GL.DEFAULTS
    assert capsys.readouterr().err == ""
    # 回退结果是深拷贝, 调用方改动不污染 DEFAULTS
    g1["t1_min_chars"] = -1
    assert GL.DEFAULTS["t1_min_chars"] == 10_000_000


def test_b_bad_json_fallback(capsys, tmp_path):
    """b) 坏 JSON → 同样回退 DEFAULTS + 告警."""
    GL._warned.clear()
    bad = tmp_path / "bad_gates.json"
    bad.write_text("{ not valid json", encoding="utf-8")
    assert GL.load_gates(config_path=bad) == GL.DEFAULTS
    assert "gates_loader" in capsys.readouterr().err


def test_b_non_dict_top_level_fallback(capsys, tmp_path):
    """b) 顶层非 object (如数组) → 视为坏件回退 + 告警."""
    GL._warned.clear()
    arr = tmp_path / "arr_gates.json"
    arr.write_text("[1, 2, 3]", encoding="utf-8")
    assert GL.load_gates(config_path=arr) == GL.DEFAULTS
    assert "gates_loader" in capsys.readouterr().err


def test_c_defaults_match_disk_gates():
    """c) DEFAULTS 与磁盘 gates.json 全量对拍一致."""
    with open(GATES_JSON, encoding="utf-8") as fh:
        disk = json.load(fh)
    assert GL.DEFAULTS == disk                          # 兜底口径 == 权威源口径
