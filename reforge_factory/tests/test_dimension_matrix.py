# -*- coding: utf-8 -*-
"""T-007C / REQ-022.AC1 — D 轴九维矩阵传感器 dimension_matrix 测试.

铁律对拍:
  1. 九维 7 维有料 / 2 维零命中 → open_gaps=2, 缺格显式降级带 reason="无命中资料";
  2. 一切降级格 100% 带 reason (含 L1 薄料/无 T1 权威信号两类降级);
  3. register_dimension 自定义维生效 (可扩展域包);
  4. 全维有料 → open_gaps 空 + green=True;
  5. 双产物落盘: REQ-022.AC1 权威件 dimension_matrix.json + 完备性账本件
     completeness/D_axis.json (同载荷);
  6. manifest 只读 (scan 前后分毫不动)。
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # reforge_factory/

from completeness import dimension_matrix as dm  # noqa: E402

GAP_DIMS = ["司法风险", "ESG国际"]


def _kw(dim: str) -> str:
    """取该维词表首个关键词 (与模块词表同源, 防词表演化失配)."""
    kws = dm.DIMENSION_PACKS[dim]
    assert kws, f"维 {dim} 词表为空"
    return kws[0]


def _line(text: str, engine: str = "web:x", stance: str = "support",
          credibility: str = "web") -> dict:
    return {"engine": engine, "stance": stance, "credibility": credibility,
            "chars": len(text), "text_head": text, "source_path": "fixture"}


def _mk_pool(tmp_path: Path, lines: list[dict], *, campaign: str = "T-CAMP",
             t1_words: list[str] | None = ["权威甲"]) -> Path:
    pool = tmp_path / "ammo_pool" / campaign
    pool.mkdir(parents=True)
    (pool / "manifest.jsonl").write_text(
        "\n".join(json.dumps(x, ensure_ascii=False) for x in lines) + "\n",
        encoding="utf-8")
    if t1_words is not None:
        (pool / "tiers.json").write_text(
            json.dumps({"T1": t1_words, "T2": []}, ensure_ascii=False),
            encoding="utf-8")
    return pool


def _rich_lines(dim: str, t1: str = "权威甲", engines: tuple[str, str] = ("web:a", "web:b")) -> list[dict]:
    """3 条命中 + T1 词 + 双源 → L3 近似."""
    kw = _kw(dim)
    return [_line(f"{kw} 要点{i} {t1}", engine=engines[i % 2]) for i in range(3)]


NINE = list(dm.DIMENSION_PACKS)


def test_seven_rich_two_gap_open_gaps_two(tmp_path):
    """7 维有料 / 2 维零命中: open_gaps=2 且缺格显式降级带理由."""
    rich = [d for d in NINE if d not in GAP_DIMS]
    lines: list[dict] = []
    for d in rich:
        lines += _rich_lines(d)
    pool = _mk_pool(tmp_path, lines)

    rec = dm.scan("T-CAMP", ammo_root=pool.parent)

    assert set(rec["dims"]) == set(NINE) and len(rec["cells"]) == 9
    assert rec["open_gaps"] == GAP_DIMS           # 按 dims 顺序显式列缺格
    assert not rec["green"]
    for d in GAP_DIMS:
        c = rec["cells"][d]
        assert c["hits"] == 0 and c["depth"] == "L0"
        assert c["downgraded"] is True and c["reason"] == "无命中资料"
    for d in rich:
        c = rec["cells"][d]
        assert c["hits"] == 3 and not c["downgraded"] and c["reason"] is None
        assert c["depth"] == "L3"                 # hits>=3 + T1 词 + 双源


def test_every_downgraded_cell_carries_reason(tmp_path):
    """降级格 100% 带 reason (REQ-022.AC1): 含缺格/薄料/无T1三类降级."""
    lines = (
        _rich_lines("行业")                          # L3
        + [_line(f"{_kw('政策')} 单条提及")]           # 薄料 L1
        + [_line(f"{_kw('财务')} 条目{i}") for i in range(3)]  # 无 T1 词 → L1
    )
    pool = _mk_pool(tmp_path, lines)
    rec = dm.scan("T-CAMP", ammo_root=pool.parent)

    dg = [c for c in rec["cells"].values() if c["downgraded"]]
    assert len(dg) >= 2 and all(c["reason"] for c in dg)
    assert rec["cells"]["政策"]["depth"] == "L1"
    assert "门槛" in rec["cells"]["政策"]["reason"]
    assert rec["cells"]["财务"]["depth"] == "L1" and rec["cells"]["财务"]["hits"] == 3
    assert "T1" in rec["cells"]["财务"]["reason"]
    # 单源且有 T1 但 hits>=3 → L2 (源多样性不足, 不降级)
    lines_l2 = [_line(f"{_kw('技术')} 要点{i} 权威甲", engine="web:solo") for i in range(3)]
    pool2 = _mk_pool(tmp_path / "b", lines_l2, campaign="T-CAMP2")
    rec2 = dm.scan("T-CAMP2", ammo_root=pool2.parent)
    assert rec2["cells"]["技术"]["depth"] == "L2" and not rec2["cells"]["技术"]["downgraded"]


def test_register_dimension_custom_dim(tmp_path):
    """register_dimension 扩展域包: 自定义维进矩阵并计命中."""
    lines = _rich_lines("行业") + [
        _line("量子 Leopard 专项 权威甲"), _line("量子 Leopard 二号 权威甲")]
    pool = _mk_pool(tmp_path, lines)
    try:
        dm.register_dimension("自定义维", ["量子 Leopard"])
        rec = dm.scan("T-CAMP", ammo_root=pool.parent)
        assert "自定义维" in rec["dims"] and len(rec["cells"]) == 10
        assert rec["cells"]["自定义维"]["hits"] == 2
    finally:
        dm.reset_dimensions()
    rec2 = dm.scan("T-CAMP", ammo_root=pool.parent)
    assert "自定义维" not in rec2["cells"] and len(rec2["cells"]) == 9


def test_register_dimension_validation():
    with pytest.raises(ValueError):
        dm.register_dimension("", ["x"])
    with pytest.raises(ValueError):
        dm.register_dimension("空词表", [])
    dm.reset_dimensions()  # 确保未污染


def test_all_rich_green(tmp_path):
    """九维全有料 → open_gaps 空 + green=True, 零降级."""
    lines: list[dict] = []
    for d in NINE:
        lines += _rich_lines(d)
    pool = _mk_pool(tmp_path, lines)
    rec = dm.scan("T-CAMP", ammo_root=pool.parent)
    assert rec["open_gaps"] == [] and rec["green"] is True
    assert not any(c["downgraded"] for c in rec["cells"].values())


def test_dual_output_files_written(tmp_path):
    """双产物: <池>/dimension_matrix.json (REQ-022.AC1) + <池>/completeness/D_axis.json."""
    pool = _mk_pool(tmp_path, _rich_lines("行业"))
    rec = dm.scan("T-CAMP", ammo_root=pool.parent)

    canon = json.loads((pool / "dimension_matrix.json").read_text(encoding="utf-8"))
    assert canon["axis"] == "D" and canon["sensor"] == "dimension_matrix"
    assert canon["campaign"] == "T-CAMP" and len(canon["cells"]) == 9
    dg = [c for c in canon["cells"].values() if c.get("downgraded")]
    assert all(c.get("reason") for c in dg)

    axis = json.loads((pool / "completeness" / "D_axis.json").read_text(encoding="utf-8"))
    assert axis == canon                                   # 同载荷双落盘
    assert axis == rec


def test_manifest_readonly_and_missing(tmp_path):
    """manifest 只读: scan 前后逐字节不变; 池缺失 → 显式 FileNotFoundError (禁隐身)."""
    pool = _mk_pool(tmp_path, _rich_lines("行业"))
    raw = (pool / "manifest.jsonl").read_bytes()
    dm.scan("T-CAMP", ammo_root=pool.parent)
    assert (pool / "manifest.jsonl").read_bytes() == raw

    with pytest.raises(FileNotFoundError):
        dm.scan("不存在池", ammo_root=pool.parent)


def test_gov_credibility_counts_as_t1(tmp_path):
    """credibility=official/gov 的行视同 T1 权威信号 (无 T1 词也入 t1_lines)."""
    lines = [_line(f"{_kw('招投标')} 官发{i}", credibility="gov") for i in range(3)]
    lines += [_line(f"{_kw('市场客户')} 媒体{i}", credibility="media", engine="web:m2")
              for i in range(3)]
    pool = _mk_pool(tmp_path, lines, t1_words=None)        # 无 tiers.json → 模块兜底词表
    rec = dm.scan("T-CAMP", ammo_root=pool.parent)
    assert rec["cells"]["招投标"]["t1_lines"] == 3 and rec["cells"]["招投标"]["depth"] == "L2"
