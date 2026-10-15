# -*- coding: utf-8 -*-
"""PRESS 式检索计划独立评议件测试 (T-016 / REQ-027).

覆盖:
  1. 合成 tiers → 八项全在, 每项 {item, plan_evidence, status:needs_review}
  2. 词矩阵行含 T1 词 (T1/T2/KWS 三层词表入 plan_evidence, md 表格里渲染真实词)
  3. 站点清单非空 (channel_manifest named_channels + families 端点数)
  4. 时间窗 (pool_state created/last_judge 收割窗 + timeline 主题跨度)
  5. render_md 含 词矩阵/站点/时间窗/结论 四关键词与逐项「评议人意见」空栏
  6. --record 追加不覆盖 (原文保留 + 评议记录段落在尾部)
  7. CLI 落盘: 生成受评议件; 已存在拒覆盖(只增); 记录件不在 md 时报错
  8. 真实池 BID26 只读冒烟 (池缺席则 skip, 不造假)
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

import press_review as pr  # noqa: E402

EXPECTED_ITEMS = [
    "数据库选择",
    "检索式结构-布尔逻辑",
    "检索式结构-字段限定",
    "同义词与截词-词矩阵",
    "时间窗",
    "限定与排除",
    "可复现性",
    "同行第二人评议",
]


# ---- 夹具 ----------------------------------------------------------------

def make_lab(tmp_path, *, with_kws_in_tiers=False, with_timeline=True):
    """实验室: tmp ammo 根 + manifest + 战役池 (tiers/pool_state/timeline)."""
    tmp_path = Path(tmp_path)
    tmp_path.mkdir(parents=True, exist_ok=True)
    manifest = tmp_path / "channel_manifest.json"
    manifest.write_text(json.dumps({
        "version": 1,
        "totals": {"families": 1, "named_channels": 3, "site_endpoints": 9},
        "families": [{"id": "f1", "name": "试验舰队", "modules": 4,
                      "runner": "-", "note": "-"}],
        "named_channels": [
            {"id": "chanA", "name": "渠道A", "runner": "-", "note": "-"},
            {"id": "chanB", "name": "渠道B", "runner": "-", "note": "-"},
            {"id": "chanC", "name": "渠道C", "runner": "-", "note": "-"},
        ],
    }, ensure_ascii=False), encoding="utf-8")

    pool_dir = tmp_path / "ammo" / "EPC-CAMP"
    pool_dir.mkdir(parents=True)
    tiers = {"T1": ["甲词", "乙词", "丙词"], "T2": ["丁词", "戊词"], "_note": "注释键不进词矩阵"}
    if with_kws_in_tiers:
        tiers["KWS"] = ["甲词组合检索"]
    (pool_dir / "tiers.json").write_text(
        json.dumps(tiers, ensure_ascii=False), encoding="utf-8")
    (pool_dir / "pool_state.json").write_text(json.dumps({
        "campaign": "EPC-CAMP",
        "kws": ["甲词组合检索", "戊词短语"],
        "created": "2026-10-12 21:45",
        "last_judge": "2026-10-15 07:08",
        "by_engine": {"eng:a": 100, "eng:b": 200},
        "gate_chars": 200000,
        "rejected_items": 7,
        "rejected_chars": 9000,
        "tier_note": "head3000 词表归层",
        "tier_gate_v3": {"t1_pass": True, "rule": "T1>=10000000"},
    }, ensure_ascii=False), encoding="utf-8")
    if with_timeline:
        (pool_dir / "timeline.json").write_text(json.dumps({
            "founded_year": 1953, "current_year": 2026,
        }, ensure_ascii=False), encoding="utf-8")
    return {"root": tmp_path / "ammo", "manifest": manifest,
            "pool_dir": pool_dir, "work": tmp_path / "work"}


def checklist_of(lab, campaign="CAMP"):
    return pr.make_checklist(campaign, ammo_root=lab["root"],
                             manifest_path=lab["manifest"])


@pytest.fixture
def lab(tmp_path):
    return make_lab(tmp_path)


# ---- 1. 八项全在 -----------------------------------------------------------

def test_eight_items_all_present(lab):
    cl = checklist_of(lab)
    assert [it["item"] for it in cl["items"]] == EXPECTED_ITEMS
    assert len(cl["items"]) == 8
    for it in cl["items"]:
        assert set(it) >= {"item", "plan_evidence", "status"}
        assert it["status"] == "needs_review"
        assert it["plan_evidence"]                      # 证据非空


def test_campaign_alias_resolves_pool_dir(lab):
    cl = checklist_of(lab, campaign="EPC-CAMP")         # 全名也通
    assert cl["campaign"] == "EPC-CAMP"


# ---- 2. 词矩阵含 T1 词 ------------------------------------------------------

def test_word_matrix_rows_carry_t1_words(lab):
    cl = checklist_of(lab)
    wm = pr.find_item(cl, "同义词与截词-词矩阵")["plan_evidence"]["word_matrix"]
    tiers = {row["tier"]: row for row in wm}
    assert tiers["T1"]["words"] == ["甲词", "乙词", "丙词"]
    assert tiers["T2"]["words"] == ["丁词", "戊词"]
    assert "甲词组合检索" in tiers["KWS"]["words"]      # pool_state.kws 兜底
    assert "_note" not in tiers                          # 注释键不进词矩阵


def test_word_matrix_prefers_tiers_kws(lab, tmp_path):
    lab2 = make_lab(tmp_path / "second", with_kws_in_tiers=True)
    cl = pr.make_checklist("CAMP", ammo_root=lab2["root"],
                           manifest_path=lab2["manifest"])
    wm = pr.find_item(cl, "同义词与截词-词矩阵")["plan_evidence"]["word_matrix"]
    tiers = {row["tier"]: row for row in wm}
    assert tiers["KWS"]["words"] == ["甲词组合检索"]     # tiers.KWS 优先


# ---- 3. 站点清单非空 --------------------------------------------------------

def test_site_list_non_empty(lab):
    ev = pr.find_item(checklist_of(lab), "数据库选择")["plan_evidence"]
    assert ev["named_channel_ids"] == ["chanA", "chanB", "chanC"]
    assert ev["site_endpoints_total"] == 9
    assert ev["站点清单_舰队"] == ["试验舰队"]


# ---- 4. 时间窗 --------------------------------------------------------------

def test_time_window_evidence(lab):
    ev = pr.find_item(checklist_of(lab), "时间窗")["plan_evidence"]
    assert ev["harvest_window"]["created"] == "2026-10-12 21:45"
    assert ev["harvest_window"]["last_judge"] == "2026-10-15 07:08"
    assert ev["subject_span"]["founded_year"] == 1953
    assert ev["subject_span"]["current_year"] == 2026
    assert ev["date_limit_declared"] is False            # 未显式声明 → 待评议


def test_time_window_failsoft_without_timeline(tmp_path):
    lab = make_lab(tmp_path, with_timeline=False)
    ev = pr.find_item(checklist_of(lab), "时间窗")["plan_evidence"]
    assert ev["subject_span"]["available"] is False      # 缺件注明, 不造假


# ---- 5. render_md -----------------------------------------------------------

def test_render_md_keywords_and_blank_columns(lab):
    md = pr.render_md(checklist_of(lab))
    for kw in ("词矩阵", "站点", "时间窗", "结论"):
        assert kw in md
    assert md.count("评议人意见") >= 8                    # 每项空栏
    assert "needs_review" in md
    # 词矩阵表格行渲染真实 T1 词
    assert "甲词" in md and "丁词" in md and "甲词组合检索" in md
    # 站点与时间窗渲染
    assert "chanA" in md and "2026-10-12 21:45" in md and "1953" in md


# ---- 6. --record 追加不覆盖 ---------------------------------------------------

def test_record_appends_not_overwrites(lab, tmp_path):
    md_path = tmp_path / "press_review_EPC-CAMP.md"
    md_path.write_text(pr.render_md(checklist_of(lab)), encoding="utf-8")
    before = md_path.read_text(encoding="utf-8")

    record = {"reviewer": "独立会话评议人", "items": [
        {"item": "数据库选择", "verdict": "通过", "comment": "站点覆盖充分"},
        {"index": 4, "verdict": "修改后通过", "comment": "建议补截词策略"},
    ]}
    rec_path = tmp_path / "review.json"
    rec_path.write_text(json.dumps(record, ensure_ascii=False), encoding="utf-8")

    rc = pr.main(["CAMP", "--ammo-root", str(lab["root"]),
                  "--manifest", str(lab["manifest"]),
                  "--out", str(md_path), "--record", str(rec_path)])
    assert rc == 0
    after = md_path.read_text(encoding="utf-8")
    assert before in after                              # 原文保留
    assert "评议记录" in after and "独立会话评议人" in after
    assert "站点覆盖充分" in after and "建议补截词策略" in after
    assert "修改后通过" in after


def test_record_rejects_unknown_item(lab, tmp_path):
    md_path = tmp_path / "press_review_EPC-CAMP.md"
    md_path.write_text(pr.render_md(checklist_of(lab)), encoding="utf-8")
    rec_path = tmp_path / "review.json"
    rec_path.write_text(json.dumps(
        {"reviewer": "x", "items": [{"item": "不存在的项", "verdict": "通过"}]},
        ensure_ascii=False), encoding="utf-8")
    rc = pr.main(["CAMP", "--ammo-root", str(lab["root"]),
                  "--manifest", str(lab["manifest"]),
                  "--out", str(md_path), "--record", str(rec_path)])
    assert rc == 4
    assert "评议记录" not in md_path.read_text(encoding="utf-8")


# ---- 7. CLI 落盘 -------------------------------------------------------------

def test_cli_writes_md_and_refuses_overwrite(lab, capsys):
    rc = pr.main(["CAMP", "--ammo-root", str(lab["root"]),
                  "--manifest", str(lab["manifest"]),
                  "--work-dir", str(lab["work"])])
    assert rc == 0
    out = lab["work"] / "press_review_EPC-CAMP.md"
    assert out.exists()
    first = out.read_text(encoding="utf-8")
    assert "词矩阵" in first

    rc2 = pr.main(["CAMP", "--ammo-root", str(lab["root"]),
                   "--manifest", str(lab["manifest"]),
                   "--work-dir", str(lab["work"])])
    assert rc2 == 3                                     # 只增: 拒覆盖
    assert out.read_text(encoding="utf-8") == first


# ---- 8. 真实池 BID26 只读冒烟 ---------------------------------------------------

def test_real_bid26_readonly_smoke():
    root = pr.REPO_ROOT / "ammo_pool"
    if not (root / "EPC-BID26" / "tiers.json").exists():
        pytest.skip("真实池 EPC-BID26 不在本机, 不造假")
    cl = pr.make_checklist("BID26")
    assert cl["campaign"] == "EPC-BID26"
    assert len(cl["items"]) == 8
    wm = {r["tier"]: r for r in
          pr.find_item(cl, "同义词与截词-词矩阵")["plan_evidence"]["word_matrix"]}
    assert wm["T1"]["count"] >= 20
    assert wm["KWS"]["count"] >= 5
    ev = pr.find_item(cl, "数据库选择")["plan_evidence"]
    assert len(ev["named_channel_ids"]) >= 20            # 实测 28 渠道
    md = pr.render_md(cl)
    assert all(kw in md for kw in ("词矩阵", "站点", "时间窗", "结论"))
