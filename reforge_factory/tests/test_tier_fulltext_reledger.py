# -*- coding: utf-8 -*-
"""test_tier_fulltext_reledger — 全文级分层重落账单测 (BID26 方案A).

覆盖: 全文级归位 (T1 全文命中优先于标题缺失) / 字数由盘上全文现读复算 /
legacy 四键保存 (首写保留) / 新明细逐行 schema / dry-run 不写 / 失联件
text_head 近似留痕 / v3 门 gates.json 现读。

跑法: py -m pytest reforge_factory/tests/test_tier_fulltext_reledger.py -q
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import tier_fulltext_reledger as RL                             # noqa: E402
from ammo_pool import count_chars                               # noqa: E402

CAMPAIGN = "TST-RECAL"
LEGACY = {"t1_chars": 32951, "t1_items": 99,
          "t2_chars": 38312, "t2_items": 88}


def _mk_pool(root: Path) -> Path:
    """tmp 池: 4 盘上件 (T1全文/T2全文/KWS/全不中) + 1 失联件 + 重复/废行."""
    d = root / CAMPAIGN
    d.mkdir(parents=True)
    src = root / "src"
    src.mkdir()
    body_a = "深度研究报告：本文详述公开招标流程与评标定标细则，" + "料" * 120
    body_b = "范本说明：本合同范本适用于工程总承包计价场景，" + "资" * 80
    body_c = "周边资料：与课题词相关的背景补充材料。" + "甲" * 60
    body_d = "完全无关的杂项内容，不含任何词表词。" + "乙" * 40
    (src / "deep_report.md").write_text(body_a, encoding="utf-8")
    (src / "contract_note.md").write_text(body_b, encoding="utf-8")
    (src / "kw_side.md").write_text(body_c, encoding="utf-8")
    (src / "plain_misc.md").write_text(body_d, encoding="utf-8")
    rows = [
        {"judge": "valid", "dedup_key": "c:1",
         "source_path": str(src / "deep_report.md"), "chars": 999999},
        {"judge": "valid", "dedup_key": "c:2",
         "source_path": str(src / "contract_note.md"), "chars": 888888},
        {"judge": "valid", "dedup_key": "c:3",
         "source_path": str(src / "kw_side.md"), "chars": 777777},
        {"judge": "valid", "dedup_key": "c:4",
         "source_path": str(src / "plain_misc.md"), "chars": 666666},
        # 失联件: 路径不存在 → text_head(500字)近似判层 + chars 取行值
        {"judge": "valid", "dedup_key": "c:5",
         "source_path": str(src / "gone.md"), "chars": 1234,
         "text_head": "某某招标公告正文片段 (文件已失联)"},
        {"judge": "valid", "dedup_key": "c:1",          # 重复 dedup → 不计
         "source_path": str(src / "deep_report.md"), "chars": 5555555},
        {"judge": "rejected", "dedup_key": "c:6",       # 废行 → 不计
         "source_path": str(src / "deep_report.md"), "chars": 4444444},
    ]
    with (d / "manifest.jsonl").open("w", encoding="utf-8") as fh:
        for r in rows:
            fh.write(json.dumps(r, ensure_ascii=False) + "\n")
    (d / "tiers.json").write_text(json.dumps(
        {"T1": ["招标"], "T2": ["合同"]}, ensure_ascii=False),
        encoding="utf-8")
    (d / "pool_state.json").write_text(json.dumps(
        {"campaign": CAMPAIGN, "kws": ["课题"],
         "total_chars": 777777, **LEGACY}, ensure_ascii=False),
        encoding="utf-8")
    return d


def _expected() -> dict:
    """期望账 (与 _mk_pool 同源推定): T1=全文件+失联件, T2/T3/T0 各 1."""
    a = count_chars("深度研究报告：本文详述公开招标流程与评标定标细则，"
                    + "料" * 120)
    b = count_chars("范本说明：本合同范本适用于工程总承包计价场景，" + "资" * 80)
    c = count_chars("周边资料：与课题词相关的背景补充材料。" + "甲" * 60)
    dd = count_chars("完全无关的杂项内容，不含任何词表词。" + "乙" * 40)
    return {"a": a, "b": b, "c": c, "d": dd,
            "t1": a + 1234, "t2": b, "t3": c, "t0": dd}


class TestReledger:
    def test_fulltext_classify_counts_legacy_and_detail(self, tmp_path):
        d = _mk_pool(tmp_path)
        exp = _expected()
        s = RL.reledger(CAMPAIGN, dry_run=False, pool_root=tmp_path)
        assert s["unique_items"] == 5 and s["approximated"] == 1
        assert s["new"]["T1"] == {"chars": exp["t1"], "items": 2}
        assert s["new"]["T2"] == {"chars": exp["t2"], "items": 1}
        assert s["new"]["T3"] == {"chars": exp["t3"], "items": 1}
        assert s["new"]["T0"] == {"chars": exp["t0"], "items": 1}
        # pool_state: 新值 + legacy 四键 + 辖外键零改动
        st = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
        assert st["t1_chars"] == exp["t1"] and st["t1_items"] == 2
        assert st["t2_chars"] == exp["t2"] and st["t2_items"] == 1
        assert st["t3_chars"] == exp["t3"] and st["t3_items"] == 1
        assert st["t0_chars"] == exp["t0"] and st["t0_items"] == 1
        assert st["t1_chars_legacy_1014"] == LEGACY["t1_chars"]
        assert st["t1_items_legacy_1014"] == LEGACY["t1_items"]
        assert st["t2_chars_legacy_1014"] == LEGACY["t2_chars"]
        assert st["t2_items_legacy_1014"] == LEGACY["t2_items"]
        assert st["total_chars"] == 777777 and st["kws"] == ["课题"]
        assert "fulltext_v2" in st["tier_note"]
        assert "tier_fulltext_reledger.py" in st["tier_note"]
        assert st["last_tier_persist"] and len(st["last_tier_persist"]) == 16
        # v3 门: 真 gates.json t1_min=1000万 → 小池 FAIL (如实)
        g = st["tier_gate_v3"]
        assert g["t1_pass"] is False and g["t1_chars"] == exp["t1"]
        assert g["rule"].startswith("T1>=") and "total gate removed" in g["rule"]
        # 新明细逐行: 5 行 schema, 失联件留痕, 全文件 matched_term 正确
        lines = (d / "tier_content_detail_v2.jsonl").read_text(
            encoding="utf-8").splitlines()
        assert len(lines) == 5
        recs = [json.loads(x) for x in lines]
        by_file = {r["file"]: r for r in recs}
        r1 = by_file[str(tmp_path / "src" / "deep_report.md")]
        assert r1["tier"] == "T1" and r1["matched_term"] == "招标"
        assert r1["chars"] == exp["a"] and r1["caliber"] == "fulltext_v2"
        assert "ts" in r1 and "caliber_note" not in r1
        assert by_file[str(tmp_path / "src" / "contract_note.md")]["tier"] == "T2"
        assert by_file[str(tmp_path / "src" / "kw_side.md")]["tier"] == "T3"
        assert by_file[str(tmp_path / "src" / "plain_misc.md")]["tier"] == "T0"
        gone = by_file[str(tmp_path / "src" / "gone.md")]
        assert gone["tier"] == "T1" and gone["chars"] == 1234
        assert "file_missing" in gone["caliber_note"]
        # 幂等重跑: legacy 首写保留 (不被 v2 值覆盖), 账不变
        RL.reledger(CAMPAIGN, dry_run=False, pool_root=tmp_path)
        st2 = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
        assert st2["t1_chars_legacy_1014"] == LEGACY["t1_chars"]
        assert st2["t1_items_legacy_1014"] == LEGACY["t1_items"]
        assert st2["t2_chars_legacy_1014"] == LEGACY["t2_chars"]
        assert st2["t2_items_legacy_1014"] == LEGACY["t2_items"]
        assert st2["t1_chars"] == exp["t1"]

    def test_dry_run_writes_nothing(self, tmp_path):
        d = _mk_pool(tmp_path)
        exp = _expected()
        s = RL.reledger(CAMPAIGN, dry_run=True, pool_root=tmp_path)
        assert s["dry_run"] is True and s["detail_path"] is None
        assert s["new"]["T1"]["chars"] == exp["t1"]      # 算了数
        assert not (d / "tier_content_detail_v2.jsonl").exists()  # 没写盘
        st = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
        assert st["t1_chars"] == LEGACY["t1_chars"]      # 账原样
        assert "t1_chars_legacy_1014" not in st and "tier_gate_v3" not in st
        assert "t3_chars" not in st and "last_tier_persist" not in st

    def test_gate_reads_gates_json_live(self, tmp_path, gates_json):
        _mk_pool(tmp_path)
        gates_json(t1_min_chars=1)                       # 现读权威源即时生效
        RL.reledger(CAMPAIGN, dry_run=False, pool_root=tmp_path)
        st = json.loads((tmp_path / CAMPAIGN / "pool_state.json")
                        .read_text(encoding="utf-8"))
        assert st["tier_gate_v3"]["t1_pass"] is True
        assert st["tier_gate_v3"]["rule"] == "T1>=1, total gate removed (v3)"
