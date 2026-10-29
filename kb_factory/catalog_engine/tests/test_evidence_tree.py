# -*- coding: utf-8 -*-
"""证据树引擎测试（W3 核心件）——真实文档池→聚类→中图法上卷→种子兜底→防环。

夹具纪律：本文件全部 FileMeta 均为**测试夹具造数**（模拟渠道元数据形态，
非真实检索结果）；真实网络用例默认 skip（离线零网络纪律）。
"""
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # E:\AI-Station 入 sys.path

from kb_factory.catalog_engine import evidence_tree as et          # noqa: E402
from kb_factory.catalog_engine.blueprint import (canonical_json,  # noqa: E402
                                                  validate_tree)
from kb_factory.catalog_engine.engine import QUOTE_PARAMS          # noqa: E402
from kb_factory.catalog_engine.taxonomy import CLC_22              # noqa: E402

NEED = {"domain": "工程实务知识库", "keywords": ["工程造价", "EPC"], "intent": "真实调研编目",
        "size_hint": "small"}

# ── 测试夹具（fixture 造数，非真实检索）───────────────────────────────────

_TOPIC_TITLES = (
    ["水利水电工程施工组织设计", "水利水电工程等级划分标准", "水利水电工程验收管理规定",
     "水利水电工程移民安置实务", "水利水电工程质量检测手册", "水利水电工程安全监测技术"] +
    ["EPC工程总承包合同管理", "EPC工程总承包风险管理", "EPC工程总承包项目案例",
     "EPC工程总承包设计管理", "EPC工程总承包采购实务", "工程总承包管理办法条文解读"] +
    ["工程量清单计价与工程造价控制", "工程造价审计实务", "工程造价案例分析",
     "工程造价指标指数应用", "工程造价纠纷鉴定", "工程造价软件应用教程"] +
    ["建设工程法律风险防范", "工程合同法律审查要点", "招标投标法律实务指引",
     "劳动用工法律合规手册", "安全生产法律责任解析"] +
    ["建筑施工企业会计核算", "施工企业成本管理会计", "工程财务报表分析实务",
     "企业税务合规与会计准则", "会计师事务所审计底稿", "工程结算与会计档案管理"])
_CHANNELS = ["wenku", "ima", "djyanbao", "doc88", "chinca"]


def _meta(i: int, title: str, channel: str, fmt: str = "pdf", pages=None, url=None, did=None):
    """造一条 FileMeta 形态 dict（测试夹具）。"""
    return {"title": title, "fmt": fmt, "pages": pages, "badge": "green_free",
            "perm": "green", "source_url": url, "channel": channel,
            "extra": {"doc_id": did, "channel": channel}}


def _fixture_pool() -> list:
    """30 条夹具池：五主题 29 条 + 1 条无主题绿植件（覆盖兜底簇路径）。"""
    assert len(_TOPIC_TITLES) == 29, f"夹具主题数漂移: {len(_TOPIC_TITLES)}"
    metas = [
        _meta(i, t, _CHANNELS[i % 5],
              fmt=["pdf", "doc", "ppt", "xls"][i % 4] if i % 7 == 0 else "pdf",
              pages=20 + i if i % 11 else None,          # 每 11 条一条 pages 缺失（如实 None）
              url=f"https://fixture.example/d/{i}" if i % 3 == 0 else None,
              did=f"FIX{i:03d}" if i % 2 == 0 else None)
        for i, t in enumerate(_TOPIC_TITLES)
    ]
    metas.append(_meta(99, "办公室绿植养护手册", "wenku", fmt="doc", pages=None, url=None))
    return metas


def _big_pool(n: int = 120) -> list:
    """大规模夹具池（30 条标题轮转复制到 n 条，测 K 自适应上限）。"""
    base = _fixture_pool()
    return [dict(base[i % len(base)]) for i in range(n)]


def _slots(bp: dict) -> list:
    """拍平树内全部文件槽。"""
    out = []
    for l1 in bp["tree"]["l1"]:
        for l2 in l1["l2"]:
            out.extend(l2.get("files") or [])
            for sd in l2.get("split_dirs") or []:
                out.extend(sd.get("files") or [])
    return out


def _ev_groups(l1: dict) -> list:
    return [g for g in l1["l2"] if g.get("source") == et.TREE_MODE]


def _seed_groups(l1: dict) -> list:
    return [g for g in l1["l2"] if g.get("source") == "seed_fallback"]


# ── 聚类 ──────────────────────────────────────────────────────────────────

def test_cluster_pool_partition_and_topics():
    """归簇互斥分区（不重不漏）+ 长主题词成簇（防泛词吞池）。"""
    metas = _fixture_pool()
    clusters = et.cluster_pool(metas)
    assert clusters, "空簇列表"
    assert sum(c["size"] for c in clusters) == len(metas), "分区不守恒"
    all_docs = [i for c in clusters for i in c["docs"]]
    assert len(all_docs) == len(set(all_docs)), "文档重复归簇"
    names = [c["name"] for c in clusters]
    assert len(names) == len(set(names)), "簇名重复"
    # 长而具体的真实主题词应在簇名里（夹具五主题）
    assert any("水利水电" in n for n in names), f"缺水利水电簇: {names}"
    assert any("工程造价" in n for n in names), f"缺工程造价簇: {names}"
    assert any("工程总" in n for n in names), f"缺工程总承簇: {names}"
    # 无主题绿植件 → 兜底簇
    assert any(c.get("fallback") for c in clusters), "缺「综合资料」兜底簇"


def test_cluster_pool_empty_and_adaptive_k():
    """空池如实 []；K 自适应封顶（120 池 → ≤16 簇）。"""
    assert et.cluster_pool([]) == []
    clusters = et.cluster_pool(_big_pool(120))
    ev = [c for c in clusters if not c.get("fallback")]
    assert 1 <= len(ev) <= 16, f"K 自适应失守: {len(ev)}"
    assert sum(c["size"] for c in clusters) == 120
    assert et._adaptive_k(30) == 8 and et._adaptive_k(64) == 16


def test_cluster_pool_accepts_filemeta_objects():
    """FileMeta dataclass 对象池（channel_adapters 实产形态）同通路。"""
    from kb_factory.channel_adapters.base import FileMeta
    objs = [FileMeta(title=t, fmt="pdf", pages=10, source_url="https://e/x",
                     extra={"doc_id": f"X{i}", "channel": "wenku"})
            for i, t in enumerate(_TOPIC_TITLES)]
    clusters = et.cluster_pool(objs)
    assert sum(c["size"] for c in clusters) == len(objs)
    assert any("水利水电" in c["name"] for c in clusters)


# ── 蓝图契约 ──────────────────────────────────────────────────────────────

def test_blueprint_contract():
    """顶层契约同现有蓝图 + 树形态 + 配比和=100 + 报价公式沿用。"""
    bp = et.build_evidence_tree("给工程公司建一个真实调研知识库", _fixture_pool(), NEED)
    assert set(bp) == {"domain", "need", "tree", "ratio", "stats", "quote", "provenance"}
    assert bp["tree"]["mode"] == et.TREE_MODE
    assert bp["tree"]["l1"] and all(l1["l2"] for l1 in bp["tree"]["l1"])
    for l1 in bp["tree"]["l1"]:
        for l2 in l1["l2"]:
            assert l2["file_count"] == len(l2.get("files") or []) + sum(
                len(sd["files"]) for sd in l2.get("split_dirs") or [])
    assert sum(bp["ratio"].values()) == 100, f"配比和≠100: {bp['ratio']}"
    # 报价公式沿用引擎 A 档（QUOTE_PARAMS 纯常量 import，不改不抄）
    assert bp["quote"]["total"] == round(
        QUOTE_PARAMS["base"] + bp["stats"]["gb"] * QUOTE_PARAMS["per_gb"], 1)
    assert bp["quote"]["base"] == QUOTE_PARAMS["base"]
    # provenance.evidence_tree 五键如实记账
    ev = bp["provenance"]["evidence_tree"]
    assert ev["pool_size"] == 30
    assert sum(ev["per_channel_counts"].values()) == 30
    assert set(ev["per_channel_counts"]) == set(_CHANNELS)
    assert ev["clusters_from_evidence"] == sum(
        len(_ev_groups(l1)) for l1 in bp["tree"]["l1"])
    assert ev["clusters_fallback"] == sum(len(_seed_groups(l1)) for l1 in bp["tree"]["l1"])
    # 中图法上卷：夹具含法律簇（D）与造价/会计簇（F）
    codes = {l1["code"] for l1 in bp["tree"]["l1"]}
    assert codes <= {c["code"] for c in CLC_22}
    assert "D" in codes and "F" in codes, f"中图法上卷缺类: {codes}"


def test_real_slots_fields_honest():
    """真实槽字段全真实：title/fmt/pages/source_url 原样，缺如实 None，不编造。"""
    metas = _fixture_pool()
    by_title = {m["title"]: m for m in metas}
    bp = et.build_evidence_tree("工程实务", metas, NEED)
    reals = [s for s in _slots(bp) if s.get("real")]
    assert reals and len(reals) == 30
    for s in reals:
        m = by_title[s["title"]]
        assert s["fmt"] == m["fmt"]
        assert s["pages"] == m["pages"]                # None 原样保留
        assert s["source_url"] == m["source_url"]      # None 原样保留
        assert s["channel"] == m["channel"]
    # wenku 渠道件有可锚标识 → 证据锚定（evidence.py 既有件）
    wenku_anchored = [s for s in reals if s["channel"] == "wenku"]
    assert wenku_anchored and all(s.get("evidence") for s in wenku_anchored)
    # 体积是估算口径，如实注明
    assert "估算" in bp["provenance"]["evidence_tree"]["size_kb_note"]


def test_seed_fallback_honest_labeling():
    """簇<2 的 L1 补 1 组种子兜底；占位槽 badge/标题双标注，不冒充真实件。"""
    bp = et.build_evidence_tree("工程实务", _fixture_pool(), NEED)
    slots = _slots(bp)
    reals = [s for s in slots if s.get("real")]
    ph = [s for s in slots if not s.get("real")]
    assert ph, "夹具含单簇 L1（法律/综合资料），必有种子兜底占位槽"
    for l1 in bp["tree"]["l1"]:
        # 兜底纪律：证据簇>=2 不补；<2 恰补 1 组
        if len(_ev_groups(l1)) >= 2:
            assert not _seed_groups(l1), f"{l1['name']} 证据簇充足仍补种子"
        else:
            assert len(_seed_groups(l1)) == 1, f"{l1['name']} 单簇未补/多补种子"
    for s in ph:
        assert s["badge"] == et.SEED_FALLBACK_BADGE
        assert et.PLACEHOLDER_MARK in s["title"]
        assert s["origin"] == "seed_fallback"
        assert s["pages"] is None and s["source_url"] is None and s["channel"] is None
    # provenance 记 origin=seed_fallback + real_file_ratio 真实计算（真实槽/总槽）
    recs = bp["provenance"]["evidence_tree"]["seed_fallback"]
    assert recs and all(r["origin"] == "seed_fallback" for r in recs)
    ratio = bp["provenance"]["evidence_tree"]["real_file_ratio"]
    assert ratio == round(len(reals) / len(slots), 4)
    assert 0.0 < ratio < 1.0


def test_validate_tree_and_determinism():
    """防环护栏（既有 validate_tree 四查）全绿 + 同输入必同输出。"""
    metas = _fixture_pool()
    bp1 = et.build_evidence_tree("工程实务", metas, NEED)
    assert validate_tree(bp1) == [], validate_tree(bp1)
    bp2 = et.build_evidence_tree("工程实务", metas, NEED)
    assert canonical_json(bp1) == canonical_json(bp2)


def test_empty_pool_refuses_empty_tree():
    """空池 → ValueError 禁空树（零造假：检索 0 件不虚构树）。"""
    with pytest.raises(ValueError, match="空"):
        et.build_evidence_tree("任意域", [], NEED)
    with pytest.raises(ValueError, match="空"):
        et.build_evidence_tree("任意域", [], None)


def test_need_gate_reuses_engine_validator():
    """need 门禁复用引擎 validate_need：非法 need 如实报错；None 由 text 派生。"""
    with pytest.raises(ValueError):
        et.build_evidence_tree("域", _fixture_pool(),
                               {"domain": "x", "keywords": [], "intent": "i",
                                "size_hint": "bogus"})
    bp = et.build_evidence_tree("水利水电EPC调研编目", _fixture_pool()[:12], None)
    assert bp["domain"] == "水利水电EPC调研编目"
    assert bp["need"]["size_hint"] == "small"


def test_large_pool_split_dir_guard():
    """>200 件的簇走受控扇出分拆（split_files 既有纯函数）且防环仍全绿。"""
    # 夹具：同一主题 220 件（极端同题池）
    metas = [_meta(i, f"工程造价控制实务案例汇编第{i:03d}辑", _CHANNELS[i % 5], pages=30)
             for i in range(220)]
    bp = et.build_evidence_tree("工程造价", metas, NEED)
    slots = _slots(bp)
    reals = [s for s in slots if s.get("real")]
    assert len(reals) == 220, "真实槽必须一件不少全部入树"
    assert len(slots) == 220 + 3, "单簇 L1 恰补 1 组种子兜底（3 占位槽）"
    assert bp["stats"]["split_dir_count"] >= 1, "超 200 未分拆"
    assert validate_tree(bp) == []
    for l1 in bp["tree"]["l1"]:
        for l2 in l1["l2"]:
            if l2.get("split_dirs"):
                assert all(len(sd["files"]) <= 200 for sd in l2["split_dirs"])


@pytest.mark.skip(reason="真网络用例默认 skip（离线零网络纪律）：需真渠道密钥/出口，"
                         "手动去掉 skip 或 -m live 才跑")
def test_live_channel_pool_smoke():
    """真网络冒烟（默认 skip）：真适配器取池 → 造树；检索 0 件如实断言 ValueError。"""
    from kb_factory.channel_adapters.base import AuditLog
    from kb_factory.channel_adapters.enrich import build_default_adapters
    audit = AuditLog()
    adapters = build_default_adapters(audit)
    metas = []
    for a in adapters:
        if a.available():
            metas.extend(a.metadata("工程造价", 8))
    if not metas:
        pytest.skip("真渠道零命中（如实计 0，不虚构）")
    bp = et.build_evidence_tree("工程造价真实调研", metas, NEED)
    assert validate_tree(bp) == []


if __name__ == "__main__":
    fns = [test_cluster_pool_partition_and_topics, test_cluster_pool_empty_and_adaptive_k,
           test_cluster_pool_accepts_filemeta_objects, test_blueprint_contract,
           test_real_slots_fields_honest, test_seed_fallback_honest_labeling,
           test_validate_tree_and_determinism, test_empty_pool_refuses_empty_tree,
           test_need_gate_reuses_engine_validator, test_large_pool_split_dir_guard]
    for fn in fns:
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
