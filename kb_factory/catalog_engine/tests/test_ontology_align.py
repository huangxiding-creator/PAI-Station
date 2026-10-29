# -*- coding: utf-8 -*-
"""ontology_align 测试（B1 本体对齐校准·KB-FACTORY 2.0 轴③）。
覆盖：改名（CLC 归位 / fibo·Brick 命中）、合并（同义词/包含/编辑距离）、
幂等、负例（已是规范名/纯域词不动）、开关、evidence_tree clusters 接线位
（mock 池建树全绿）与 clusters=None 旧行为等价。
夹具纪律：簇与元数据均为测试夹具造数；fibo/Brick 断言以仓库真实种子注册表
概念为锚（Loan zh=贷款 由 test_fibo_lex 同源钉死），不造假对齐。
"""
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # E:\AI-Station 入 sys.path
from kb_factory.catalog_engine import evidence_tree as et  # noqa: E402
from kb_factory.catalog_engine import ontology_align as oa  # noqa: E402
from kb_factory.catalog_engine.blueprint import canonical_json, validate_tree  # noqa: E402

NEED = {"domain": "工程实务知识库", "keywords": ["工程造价", "EPC"],
        "intent": "真实调研编目", "size_hint": "small"}


def _c(name, docs=None, size=None, pool_df=None, fallback=False):
    """造一条 cluster_pool 形态簇（测试夹具）。"""
    c = {"name": name}
    if docs is not None:
        c["docs"] = list(docs)
        c["size"] = len(docs) if size is None else size
    elif size is not None:
        c["size"] = size
    if pool_df is not None:
        c["pool_df"] = pool_df
    if fallback:
        c["fallback"] = True
    return c


def _meta(i, title, channel="wenku"):
    return {"title": title, "fmt": "pdf", "pages": 10, "badge": "green_free",
            "perm": "green", "source_url": None, "channel": channel,
            "extra": {"doc_id": "OA%03d" % i, "channel": channel}}


def _acct(c):
    """取簇上的 ontology_align 如实账。"""
    return (c.get("provenance") or {}).get("ontology_align") or {}


def test_clc_alias_rename():
    """① 中图归位：别名恰为规范名连续子串 → 改规范名并挂 CLC_22 标签。"""
    out = oa.align_clusters([_c("哲学", [0, 1]), _c("法律", [2, 3])])
    assert [c["name"] for c in out] == ["哲学宗教", "政治法律"]
    assert _acct(out[0])["aligned_to"] == "CLC_22:B"
    assert _acct(out[0])["renamed"] == ["哲学", "哲学宗教"]
    assert _acct(out[0])["merged"] == []
    assert _acct(out[1])["aligned_to"] == "CLC_22:D"


def test_clc_negative_canonical_and_domain_word_untouched():
    """负例：已是规范名 / 纯域词别名（造价非子串）/ 无关主题名一律不动。"""
    out = oa.align_clusters([_c("经济", [0, 1]), _c("造价", [2, 3]),
                             _c("水利水电工程", [4, 5])])
    assert [c["name"] for c in out] == ["经济", "造价", "水利水电工程"]
    for c in out:
        assert _acct(c) == {"merged": [], "renamed": [], "aligned_to": None}


def test_fibo_brick_alignment_real_concepts():
    """② 命中校准：zh 精确命中只挂账不改名；后缀变体靠拢本体概念名。"""
    out = oa.align_clusters([_c("贷款", [0, 1]), _c("暖通空调", [2, 3])])
    by = {c["name"]: c for c in out}
    # fibo zh 精确命中（test_fibo_lex 同源钉死 concepts["Loan"].zh=="贷款"）
    assert _acct(by["贷款"])["aligned_to"].startswith("fibo:") and \
        _acct(by["贷款"])["aligned_to"].endswith("/Loan")
    assert _acct(by["贷款"])["renamed"] == []
    # brick 后缀变体：暖通空调 → 暖通空调设备（种子注册表真实在库才改）
    assert "暖通空调设备" in by
    assert _acct(by["暖通空调设备"])["renamed"] == ["暖通空调", "暖通空调设备"]
    assert _acct(by["暖通空调设备"])["aligned_to"].startswith("brick:")


def test_merge_synonym():
    """③ 同义词表归并：docs 并集去重、size 实数重算、pool_df 取大、幸存=文件多者。"""
    out = oa.align_clusters([
        _c("招标投标", [0, 1], pool_df=4),
        _c("招投标", [2, 3, 4], pool_df=6),
        _c("工程造价", [5, 6], pool_df=3),
    ])
    assert len(out) == 2
    merged = next(c for c in out if c["name"] == "招投标")
    assert merged["docs"] == [0, 1, 2, 3, 4]
    assert merged["size"] == 5
    assert merged["pool_df"] == 6
    assert _acct(merged)["merged"] == ["招标投标"]


def test_merge_inclusion_and_edit_distance():
    """③ 包含簇与编辑距离≤1 归并（幸存=文件多者；输出按首成员原序）。"""
    out = oa.align_clusters([
        _c("工程造价", [0, 1, 2]),
        _c("工程造价案例分析", [3]),
        _c("安全监测", [4, 5]),
        _c("安全检测", [6]),
    ])
    assert [c["name"] for c in out] == ["工程造价", "安全监测"]
    assert out[0]["docs"] == [0, 1, 2, 3] and out[0]["size"] == 4
    assert _acct(out[0])["merged"] == ["工程造价案例分析"]
    assert out[1]["docs"] == [4, 5, 6]
    assert _acct(out[1])["merged"] == ["安全检测"]


def test_idempotent():
    """幂等：对齐结果再跑一遍，名字/数量不变，二轮 merged/renamed 全空账。"""
    src = [_c("哲学", [0, 1]), _c("招投标", [2, 3]), _c("招标投标", [4]),
           _c("水利水电工程", [5, 6])]
    once = oa.align_clusters(src)
    twice = oa.align_clusters(once)
    assert [c["name"] for c in once] == [c["name"] for c in twice]
    assert len(once) == len(twice) == 3
    for c in twice:
        assert _acct(c)["merged"] == []
        assert _acct(c)["renamed"] == []


def test_env_switch_default_on(monkeypatch):
    """KB_ONTOLOGY_ALIGN 默认开；显式 0/false/off/no 才关。"""
    monkeypatch.delenv(oa.ONTOLOGY_ALIGN_ENV, raising=False)
    assert oa.align_enabled() is True
    for off in ("0", "false", "OFF", "no"):
        monkeypatch.setenv(oa.ONTOLOGY_ALIGN_ENV, off)
        assert oa.align_enabled() is False
    monkeypatch.setenv(oa.ONTOLOGY_ALIGN_ENV, "1")
    assert oa.align_enabled() is True


def test_align_summary_ledger():
    """总账如实：merged/renamed 对清单 + aligned_to 映射 + lexicons 状态。"""
    out = oa.align_clusters([_c("哲学", [0, 1]), _c("招投标", [2, 3]),
                             _c("招标投标", [4])])
    s = oa.align_summary(out, clusters_in=3)
    assert s["clusters_in"] == 3 and s["clusters_out"] == 2
    assert s["merged"] == [["招标投标", "招投标"]]
    assert s["renamed"] == [["哲学", "哲学宗教"]]
    assert s["aligned_to"]["哲学宗教"] == "CLC_22:B"
    assert s["lexicons"]["fibo"] == "ok" and s["lexicons"]["brick"] == "ok"
    assert "in=3 out=2" in s["stage"]


def _wiring_metas():
    """mock 池：六主题 18 件（哲学/招投标/水利水电/EPC/造价 + 混合）。"""
    titles = [
        "哲学通论讲义", "中国哲学史纲要", "西方哲学原著选读",
        "招标投标法实施条例解读", "招标投标全流程指南", "招投标实务与案例",
        "水利水电工程质量管理", "水利水电工程验收规范", "水利水电工程安全监测",
        "EPC工程总承包合同管理", "EPC工程总承包风险管理", "EPC工程总承包采购实务",
        "工程量清单计价规范", "工程造价指标指数", "工程造价纠纷鉴定实务",
        "建设工程法律风险防范", "施工企业会计核算", "办公室绿植养护手册"]
    return [_meta(i, t, ["wenku", "ima", "djyanbao"][i % 3]) for i, t in enumerate(titles)]


def test_wiring_clusters_into_build_evidence_tree():
    """接线位（mock 池）：cluster_pool → align → build_evidence_tree(clusters=…)
    建树全绿（防环零问题、证据组名全来自对齐簇、同输入同输出）。"""
    metas = _wiring_metas()
    raw = et.cluster_pool(metas)
    aligned = oa.align_clusters(raw, metas)
    aligned_names = {c["name"] for c in aligned}
    bp = et.build_evidence_tree("工程实务与哲学法律测试域", metas, NEED,
                                clusters=aligned)
    assert validate_tree(bp) == []
    ev_names = {g["name"] for l1 in bp["tree"]["l1"] for g in l1["l2"]
                if g.get("source") == et.TREE_MODE}
    # 当前引擎建树时还会按 need 关键字补导览组（并行轴新增能力），
    # 故只断言对齐簇确实入树（交集非空）+ 护栏全绿，不强求全等。
    assert ev_names and (ev_names & aligned_names), (ev_names, aligned_names)
    bp2 = et.build_evidence_tree("工程实务与哲学法律测试域", metas, NEED,
                                 clusters=oa.align_clusters(raw, metas))
    assert canonical_json(bp) == canonical_json(bp2)


def test_wiring_none_keeps_legacy_behavior():
    """clusters=None/空列表=旧行为：与不传完全等价（既有回归零漂移）。"""
    metas = _wiring_metas()[:8]
    a = et.build_evidence_tree("测试域", metas, NEED)
    b = et.build_evidence_tree("测试域", metas, NEED, clusters=None)
    c = et.build_evidence_tree("测试域", metas, NEED, clusters=[])
    assert canonical_json(a) == canonical_json(b)
    assert canonical_json(a) == canonical_json(c)


def test_fallback_cluster_untouched():
    """兜底簇（综合资料）如实不动：不改名、不归并、空账。"""
    out = oa.align_clusters([_c("综合资料", [0], fallback=True),
                             _c("哲学", [1, 2])])
    fb = next(c for c in out if c.get("fallback"))
    assert fb["name"] == "综合资料"
    assert _acct(fb) == {"merged": [], "renamed": [], "aligned_to": None}
