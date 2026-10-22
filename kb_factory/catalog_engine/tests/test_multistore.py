# -*- coding: utf-8 -*-
"""P2 #7 类型化多库+路由测试——四库路由 / 建库 / 跨库引用 / 多库视图。

调研来源：MIRIX + Akasha + claude-memory-compiler（KB 分类型库 + 路由规则）。
确定性纪律：无随机源、无时钟，同输入必同输出。
"""
import os
import sys
import dataclasses

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))

from kb_factory.catalog_engine.multistore import (
    STORE_REGISTRY, STORE_EVENTS, STORE_SEMANTIC, STORE_RESOURCES,
    MultiStoreBlueprint, route_document, build_multistore, render_multistore_view,
    DocFile,
)

# ── 50 件多类型 DocFile（覆盖四库 + 跨库共享特征） ────────────────────────

_TITLES = [
    # registry（13）：标准号 / 法规 / 规范后缀
    "GB/T 50358 建设项目工程总承包管理规范",
    "SL 252 水利水电工程等级划分及洪水标准",
    "SL 253 混凝土重力坝设计规范",
    "GB 50500 建设工程工程量清单计价规范",
    "《中华人民共和国水法》",
    "建设工程质量管理条例",
    "水利工程建设项目验收管理规定",
    "水利水电工程施工组织设计规范 SL 303",
    "中华人民共和国安全生产法",
    "ISO 9001 质量管理体系要求",
    "水利工程建设监理规定",
    "水库大坝注册登记管理办法",
    "水利水电工程定额标准",
    # events（14）：案例 / 事故 / 变更 / 通报 / 新闻
    "SL 253-2018某重力坝工程裂缝事故案例分析",
    "江西丰城电厂冷却塔坍塌特大事故调查报告",
    "重力坝溃坝事故复盘报告（1975）",
    "水利工程重大变更记录汇编（2018-2023）",
    "EPC项目合同纠纷案例实录",
    "大坝安全监测异常事件通报（2021）",
    "水电站施工塌方事故警示录",
    "工程总承包项目索赔案例分析",
    "水库除险加固工程事故教训总结",
    "水利工程质量缺陷调查纪实",
    "深基坑坍塌事故应急处置案例",
    "某EPC项目重大设计变更纪实",
    "水电站投产新闻特稿（2022）",
    "防洪调度失误事件复盘",
    # semantic（12）：指南 / 流程 / 方法 / 教程
    "EPC工程总承包项目管理指南",
    "大坝安全监测技术导则",
    "水利水电工程施工流程与工法",
    "工程造价编制方法与最佳实践",
    "施工质量控制作业指导书",
    "EPC项目策划编制教程",
    "混凝土坝温控防裂技术指引",
    "水利工程验收流程指南",
    "安全生产培训讲义",
    "EPC项目风险管理方法",
    "水电站机电设备安装流程",
    "造价咨询实务操作指引",
    # resources（11）：模板 / 范本 / 手册 / 表格
    "工程量清单计价表格模板",
    "EPC项目施工合同范本",
    "水利水电工程概算定额手册",
    "监理规划编制模板",
    "大坝安全监测记录表格",
    "水利工程竣工资料清单模板",
    "工程结算书范本",
    "施工进度计划横道图模板",
    "水电工程建设用地协议文书模板",
    "造价测算工具使用说明",
    "EPC投标文件编制模板",
]

_EXPECTED_COUNTS = {
    STORE_REGISTRY: 13, STORE_EVENTS: 14, STORE_SEMANTIC: 12, STORE_RESOURCES: 11,
}


def _fifty_docs() -> list:
    """造 50 件多类型 DocFile（含跨库共享特征：SL 253 / 大坝 / EPC / 造价…）。"""
    assert len(_TITLES) == 50
    docs = []
    for i, title in enumerate(_TITLES):
        docs.append(DocFile(title=title, source="wenku", fmt="pdf", pages=40 + i,
                            badge="green_free", perm="green", size_kb=300 + i))
    return docs


# ── 路由规则 ────────────────────────────────────────────────────────────

def test_p2_7_route_by_standard_and_law():
    assert route_document(DocFile(title="GB 50500 建设工程工程量清单计价规范")) == STORE_REGISTRY
    assert route_document(DocFile(title="《中华人民共和国水法》")) == STORE_REGISTRY
    assert route_document(DocFile(title="水库大坝注册登记管理办法")) == STORE_REGISTRY
    assert route_document(DocFile(title="水利水电工程定额标准")) == STORE_REGISTRY


def test_p2_7_route_events_beats_resources_on_dispute():
    # 合同范本类落资源库；但"合同纠纷案例"是事件，events 优先级高于 resources
    assert route_document(DocFile(title="EPC项目施工合同范本")) == STORE_RESOURCES
    assert route_document(DocFile(title="EPC项目合同纠纷案例实录")) == STORE_EVENTS
    assert route_document(DocFile(title="水利工程质量缺陷调查纪实")) == STORE_EVENTS


def test_p2_7_route_guides_to_semantic_not_registry():
    # 指南/导则/流程 → semantic（与 classify_doc 的"技术规范"分流：无标准号的指南不进登记库）
    assert route_document(DocFile(title="EPC工程总承包项目管理指南")) == STORE_SEMANTIC
    assert route_document(DocFile(title="大坝安全监测技术导则")) == STORE_SEMANTIC
    assert route_document(DocFile(title="水利水电工程施工流程与工法")) == STORE_SEMANTIC
    assert route_document(DocFile(title="安全生产培训讲义")) == STORE_SEMANTIC


def test_p2_7_route_templates_and_tools_to_resources():
    assert route_document(DocFile(title="工程量清单计价表格模板")) == STORE_RESOURCES
    assert route_document(DocFile(title="水利水电工程概算定额手册")) == STORE_RESOURCES
    assert route_document(DocFile(title="造价测算工具使用说明")) == STORE_RESOURCES


def test_p2_7_route_fallback_doc_type_and_default():
    # doc_type 兜底：模板范本→resources；未命中任何特征默认落 semantic
    d = DocFile(title="无名文档甲乙丙", doc_type="模板范本")
    assert route_document(d) == STORE_RESOURCES
    assert route_document(DocFile(title="某某杂项资料")) == STORE_SEMANTIC


def test_p2_7_route_rejects_doc_without_title():
    try:
        route_document(None)
    except (TypeError, ValueError):
        pass
    else:
        raise AssertionError("route_document(None) 必须抛 TypeError/ValueError")


# ── 建库 ────────────────────────────────────────────────────────────────

def test_p2_7_build_multistore_distribution():
    msb = build_multistore(_fifty_docs())
    assert isinstance(msb, MultiStoreBlueprint)
    counts = {}
    for code in (STORE_REGISTRY, STORE_EVENTS, STORE_SEMANTIC, STORE_RESOURCES):
        store = getattr(msb, code)
        assert isinstance(store, dict) and store["files"], f"{code} 库不得为空"
        counts[code] = len(store["files"])
    assert counts == _EXPECTED_COUNTS
    # 无丢失无重复：四库文件总数 == 输入数
    total = sum(len(getattr(msb, c)["files"]) for c in _EXPECTED_COUNTS)
    assert total == 50


def test_p2_7_each_store_has_internal_tree():
    msb = build_multistore(_fifty_docs())
    for code in (STORE_REGISTRY, STORE_EVENTS, STORE_SEMANTIC, STORE_RESOURCES):
        store = getattr(msb, code)
        tree = store["tree"]
        assert isinstance(tree, list) and tree, f"{code} 库目录树不得为空"
        assert all(node["file_count"] > 0 for node in tree)
        assert sum(node["file_count"] for node in tree) == len(store["files"])
        # 事件流库必须带时间线
    years = [t["year"] for t in msb.events["timeline"]]
    assert any(y and y <= 1976 for y in years), "事件流库时间线应含历史事故年份"


def test_p2_7_cross_references_exist():
    msb = build_multistore(_fifty_docs())
    xrefs = msb.cross_references
    assert xrefs, "跨库引用不得为空"
    # 任务样例形态：标准 SL 253 ↔ 案例（registry ↔ events）
    sl = [x for x in xrefs if "SL 253" in x["reason"]]
    assert sl, "应有 SL 253 共享特征驱动的跨库引用"
    pair_stores = {sl[0]["a"]["store"], sl[0]["b"]["store"]}
    assert pair_stores == {STORE_REGISTRY, STORE_EVENTS}
    # 跨库引用必须双侧都真实存在于对应库
    for x in xrefs:
        assert x["a"]["store"] != x["b"]["store"]
        assert x["a"]["doc"] and x["b"]["doc"]


def test_p2_7_routing_rules_self_describing():
    msb = build_multistore(_fifty_docs())
    assert isinstance(msb.routing_rules, list) and len(msb.routing_rules) >= 4
    assert {r["store"] for r in msb.routing_rules} >= set(_EXPECTED_COUNTS)


def test_p2_7_deterministic_same_input_same_output():
    d1, d2 = _fifty_docs(), _fifty_docs()
    assert dataclasses.asdict(build_multistore(d1)) == dataclasses.asdict(build_multistore(d2))


# ── 多库视图 ────────────────────────────────────────────────────────────

def test_p2_7_render_multistore_view():
    msb = build_multistore(_fifty_docs())
    view = render_multistore_view(msb)
    assert isinstance(view, str) and view.startswith("# ")
    for name in ("核心登记库", "事件流库", "语义知识库", "资源库", "跨库引用"):
        assert name in view, f"视图缺 {name}"
    assert "50" in view and "↔" in view
    # 视图含真实文件名（含扩展名）
    assert "SL 253 混凝土重力坝设计规范.pdf" in view
