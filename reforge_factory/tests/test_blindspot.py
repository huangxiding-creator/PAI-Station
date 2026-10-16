# -*- coding: utf-8 -*-
"""V-004 / REQ-022.AC1 — BSP 盲区传感器测试 (不碰真池: tmp 夹具全合成).

铁律对拍:
  1. 树+manifest 含跨学科关键词命中 → 未问之问新 EEI >=3 条 (green);
  2. 每条候选带 source_domain(做空/法务/调查) + why_unasked + evidence_hits;
  3. 五轴门过滤在场: 逐门 bool, 薄料/单渠道/单年份候选被拒 (不过门不入报告);
  4. 树内已问之词显式压下 (未问之问=树真没问过);
  5. 树缺失 fail-soft: 落盘不炸, green=False, exit 径 2;
  6. manifest 只读 (scan 前后分毫不动)。
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # reforge_factory/

from completeness import blindspot_sensor as bs  # noqa: E402


def _mk_tree(topic: str = "四川省 EPC总承包市场", region: str = "四川省",
             extra_eei_need: str = "") -> dict:
    """合成问题树: 两子问题各 3 EEI, 语料不含三域包盲词 (除非 extra 注入)."""
    subqs = [
        {"id": "Q1", "dim": "政策监管", "text": f"{region} EPC总承包市场 政策监管框架",
         "eeis": [
             {"id": "Q1-E1", "need": f"正面证据: {region} 市场规模数据/清单",
              "stance": "support"},
             {"id": "Q1-E2", "need": "反面证据: 市场风险 处罚案例",
              "stance": "against"},
             {"id": "Q1-E3", "need": "权威口径: 官方统计公报原文", "stance": "support"},
         ]},
        {"id": "Q2", "dim": "竞争格局", "text": "EPC总承包市场 头部企业排名与份额",
         "eeis": [
             {"id": "Q2-E1", "need": "正面证据: 头部企业营收数据", "stance": "support"},
             {"id": "Q2-E2", "need": "反面证据: 纠纷 败诉 反例", "stance": "against"},
             {"id": "Q2-E3", "need": "权威口径: 排名官方口径", "stance": "support"},
         ]},
    ]
    if extra_eei_need:
        subqs[0]["eeis"].append(
            {"id": "Q1-E4", "need": extra_eei_need, "stance": "support"})
    return {"campaign": "T-BSP", "topic": topic, "region": region,
            "subquestions": subqs,
            "stats": {"eeis": sum(len(q["eeis"]) for q in subqs)}}


def _row(text: str, *, engine: str = "web:x", ts: str = "2025-03-01T10:00:00",
         chars: int = 5000) -> dict:
    return {"ts": ts, "engine": engine, "source_path": "fixture", "url_norm": "",
            "chars": chars, "text_head": text, "tree_node": "", "stance": "",
            "judge": "valid", "credibility": "web"}


def _mk_pool(tmp_path: Path, tree: dict | None, rows: list[dict],
             *, campaign: str = "T-BSP") -> Path:
    pool = tmp_path / "ammo_pool" / campaign
    pool.mkdir(parents=True)
    if tree is not None:
        (pool / "question_tree.json").write_text(
            json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    (pool / "manifest.jsonl").write_text(
        "\n".join(json.dumps(x, ensure_ascii=False) for x in rows) + "\n",
        encoding="utf-8")
    return pool


def _strong_rows() -> list[dict]:
    """跨学科命中行: 每域全词 × 双行 (跨年份+跨引擎+厚料) → 词词全过五轴门."""
    return [
        # 做空域 8 词 × 双行 (2024/2025, web:gov + rss:fin)
        _row("关联方 交易与 利益输送 疑点: 资金流向 异常, 审计意见 保留, "
             "内控 失效 红旗 清单, 隐瞒 与 伪造 迹象核查",
             engine="web:gov", ts="2024-06-01T09:00:00", chars=8000),
        _row("复盘: 关联方 网络与 利益输送 链路, 资金流向 追踪, "
             "审计意见 变脸, 内控 缺陷, 红旗 信号, 隐瞒 伪造 证据对照",
             engine="rss:fin", ts="2025-04-11T08:30:00", chars=5200),
        # 法务域 7 词 × 双行 (2024/2025, court:gii + web:x)
        _row("股权穿透 图谱: 实控人 与 代持 结构, 抽逃 出资线索, "
             "担保链 风险与 诉讼风险 敞口, 行政处罚 记录",
             engine="court:gii", ts="2024-11-20T14:00:00", chars=6000),
        _row("判例研究: 股权穿透 至终极 实控人, 代持 效力, 抽逃 认定, "
             "担保链 断裂, 诉讼风险 分级, 行政处罚 清单",
             engine="web:x", ts="2025-01-15T11:00:00", chars=4500),
        # 调查域 5 词 × 双行 (2024/2025, wechat:sogou + rss:bid)
        _row("项目 时间线交叉 核验: 信源动机 与披露时点错位, "
             "利益冲突 嫌疑, 选择性披露 与 内幕 线索",
             engine="wechat:sogou", ts="2024-09-05T16:00:00", chars=4000),
        _row("叙事核查: 时间线交叉 后矛盾点, 信源动机 追问, "
             "利益冲突 声明, 选择性披露 模式, 内幕 交易痕迹",
             engine="rss:bid", ts="2025-02-28T19:00:00", chars=3600),
    ]


def test_scan_yields_unasked_candidates_green(tmp_path):
    """树真没问过 + manifest 跨学科命中 → 新 EEI >=3 条, 全带域包标注, green."""
    pool = _mk_pool(tmp_path, _mk_tree(), _strong_rows())
    before = (pool / "manifest.jsonl").read_bytes()
    r = bs.scan("T-BSP", pool_root=tmp_path / "ammo_pool")

    # 1) 未问之问 >=3 条且 green
    assert len(r["candidates"]) >= 3
    assert r["green"] is True and r["passed_count"] >= 3
    # 2) 域包标注/未问理由/命中行数齐备
    for c in r["candidates"]:
        assert c["source_domain"] in ("做空", "法务", "调查")
        assert c["source_domain_full"] in ("做空审计", "法务穿透", "调查叙事")
        assert c["candidate_eei"] and c["why_unasked"] and c["evidence_hits"] >= 1
        g = c["gate"]
        assert set(g) >= {"T", "B", "D", "P", "C", "passed"}
    # 三域各至少一条候选 (跨学科广度)
    doms = {c["source_domain"] for c in r["candidates"]}
    assert doms == {"做空", "法务", "调查"}
    # 强命中行全部过五轴门
    assert all(c["gate"]["passed"] for c in r["candidates"])
    # 3) 落盘 schema: BSP 轴位, green 布尔 (父指令 {axis,sensor,candidates,green} 同容)
    axis_file = pool / "completeness" / "BSP_axis.json"
    assert axis_file.is_file()
    disk = json.loads(axis_file.read_text(encoding="utf-8"))
    assert disk["axis"] == "BSP" and disk["sensor"] == "blindspot"
    assert isinstance(disk["green"], bool) and disk["green"] is True
    assert len(disk["candidates"]) == len(r["candidates"])
    # 4) manifest 只读
    assert (pool / "manifest.jsonl").read_bytes() == before


def test_gate_filters_thin_single_channel_single_year():
    """五轴门过滤: 薄料(P)/单渠道(C)/单年份(T) 候选被拒, 不过门不入报告."""
    rows = [
        # 单年份 + 单引擎 + 薄料: 关联方 只在一条短行里被提及
        _row("短提及 关联方 一句", engine="web:x", ts="2025-05-01T10:00:00",
             chars=300),
    ]
    g = bs.gate_candidate("做空", rows)
    assert g["T"] is False          # 单年份 → 时间锚不过
    assert g["C"] is False          # 单引擎 → 渠道在场不过
    assert g["P"] is False          # 薄料 → 深度可达不过
    assert g["B"] is True and g["D"] is True   # 结构门: 挂靠/归属恒过
    assert g["passed"] is False
    # 深料+双源+双年份 → 全过
    strong = bs.gate_candidate("做空", _strong_rows()[:2])
    assert strong["passed"] is True


def test_words_already_asked_are_suppressed(tmp_path):
    """树内已问之词 (EEI need 含「实控人」) → 不产候选, 显式压下可追溯."""
    tree = _mk_tree(extra_eei_need="反面证据: 实控人 变更历史核查")
    rows = [
        _row("实控人 穿透核查", engine="web:a", ts="2024-01-01T00:00:00", chars=3000),
        _row("实控人 再穿透", engine="web:b", ts="2025-01-01T00:00:00", chars=3000),
        # 调查域强命中保底候选仍在
        *_strong_rows()[4:],
    ]
    pool = _mk_pool(tmp_path, tree, rows)
    r = bs.scan("T-BSP", pool_root=tmp_path / "ammo_pool")
    asked = [c for c in r["candidates"]
             if "实控人" in c["candidate_eei"]]
    assert asked == []                            # 未问之问=树真没问过
    assert "实控人" in r["suppressed_asked_words"]
    assert any("压下" in n for n in r["notes"])


def test_tree_missing_fail_soft(tmp_path):
    """树缺失: fail-soft 不炸, 落 BSP_axis.json, green=False, 候选空."""
    pool = _mk_pool(tmp_path, None, _strong_rows())
    r = bs.scan("T-BSP", pool_root=tmp_path / "ammo_pool")
    assert r["candidates"] == [] and r["green"] is False
    assert any("fail-soft" in n or "无法取树" in n for n in r["notes"])
    axis_file = pool / "completeness" / "BSP_axis.json"
    assert axis_file.is_file()
    disk = json.loads(axis_file.read_text(encoding="utf-8"))
    assert disk["green"] is False and disk["candidates"] == []


def test_cli_exit_codes(tmp_path):
    """CLI 退出码: 全过门且 green=0; 有未过门=2; 非法 cid=1."""
    pool = _mk_pool(tmp_path, _mk_tree(), _strong_rows())
    root = tmp_path / "ammo_pool"
    # 全候选过五轴门且 green → 0
    rc0 = bs._main(["--campaign", "T-BSP", "--pool-root", str(root)])
    assert rc0 == 0
    # 制造未过门: 另一池, 「红旗」被剔出强命中行, 只剩一条孤证薄料
    thin_only = [dict(r, text_head=str(r["text_head"]).replace("红旗 ", ""))
                 for r in _strong_rows()]
    thin_only.append(_row("红旗 信号一句提及", engine="web:only",
                          ts="2025-07-07T07:07:07", chars=100))
    _mk_pool(tmp_path, _mk_tree(), thin_only, campaign="T-BSP2")
    rc2 = bs._main(["--campaign", "T-BSP2", "--pool-root", str(root)])
    assert rc2 == 2
    rc_bad = bs._main(["--campaign", "非法!", "--pool-root", str(root)])
    assert rc_bad == 1
