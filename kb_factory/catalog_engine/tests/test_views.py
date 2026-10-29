# -*- coding: utf-8 -*-
"""一份数据三棵树视图测试（v2.7 #12，巨人 obsidian-dataview+Wiki.js 一树多导航）。

覆盖七门：
  1. 守恒律：三视图文件引用数 = 原清单有效槽位数（taxonomy 引擎树 / huge 分拆树 /
     document_driven 树 / 手工 mini 树）；
  2. 分区律：每文件在每视图恰属一个主组（跨组无重复 ref，并集=全量）；
  3. 零改动硬门：build_views 前后 canonical_json 逐字节一致（原树/槽位零回写）；
     attach_views 只写 provenance，tree 部分哈希不变；
  4. 映射表正负例：phase/type 两表命中路径（含「施工组织设计→施工建造」组合词防
     误抢、组名驱动映射、fmt 优先直判数据报表、标准号正则）；未命中 → 「待归类」
     如实不编造（mini 树神秘杂件两视图皆落待归类，且不出现在任何声明组）；
  5. meta 标注只消费既有键：catalog.clc_no/fmt|ext/tier/L2 组名如实投影，
     缺键 None；ensure_catalog 编目后 clc_no 可见（副本上验证，原树不染）；
  6. phase 与 type 独立性（v2.7 #12 规约）：同文件在两视图可落不同组
     （阶段轴与类型轴互不干涉，两判定器输入轴也不同）；
  7. 零复制轻量树（v2.7 #12 规约）：三视图共享同一批引用对象（身份同一 is），
     文件本体一份零复制；引用只有指针键 {ref,name,meta}，槽位本体键不进场。

附带：attach_views 溯源记账如实（views_available 与 metrics 同账、tree_touched=
False、S10 单行幂等、树缺失防御）+ 全链确定性（两次构建逐字节一致）+ 组名口径
= PHASE_ORDER/TYPE_ORDER 规约全名（前期报批/勘察设计/施工建造/质量验收/运维检修；
标准规范/合同范本/研究报告/案例实录/数据报表）。"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import build_blueprint  # noqa: E402
from catalog_engine import views as vw  # noqa: E402
from catalog_engine.blueprint import canonical_json, split_files  # noqa: E402
from catalog_engine.cataloging import ensure_catalog  # noqa: E402
from catalog_engine.document_engine import DocFile, build_blueprint_document_driven  # noqa: E402

WATER = {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包", "施工组织设计", "工程监理", "工程造价"],
         "intent": "施工与项目管理", "size_hint": "large"}


# ── 手工 mini 树（正负例全覆盖的最小样本）──────────────────────────────────

def _mini_bp():
    l2_pre = {"code": "T/01", "path": "T-01/01/", "name": "前期报批",
              "files": [{"name": "项目可行性研究报告.pdf", "tier": "core", "ext": "pdf"},
                        {"name": "工程量清单汇总表.xlsx", "tier": "field", "ext": "xlsx"}],
              "file_count": 2}
    l2_misc = {"code": "T/02", "path": "T-01/02/", "name": "杂项",
               "files": [{"name": "神秘杂件_zzz.docx", "tier": "field", "ext": "docx"}],
               "file_count": 1}
    l2_build = {"code": "T/03", "path": "T-01/03/", "name": "施工技术",
                "files": [{"name": "施工组织设计方案.pdf", "tier": "core", "ext": "pdf"},
                          {"name": "水利枢纽初步设计报告.pdf", "tier": "core", "ext": "pdf"},
                          {"name": "GB50500工程量清单计价规范.pdf", "tier": "core", "ext": "pdf"}],
                "file_count": 3}
    l1 = {"code": "T", "dir": "T-01", "path": "T-01/", "name": "水利枢纽",
          "l2": [l2_pre, l2_misc, l2_build]}
    return {"domain": "测试域",
            "tree": {"mode": "taxonomy", "root": "测试域", "l1": [l1]},
            "provenance": {"stage_log": []}}


def _count_files(tree):
    """独立口径清点（与视图实现解耦）：L2 files + 分拆组拍平，只数 dict 槽。"""
    n = 0
    for l1 in tree.get("l1") or []:
        for l2 in l1.get("l2") or []:
            n += sum(1 for f in (l2.get("files") or []) if isinstance(f, dict))
            n += sum(1 for sd in l2.get("split_dirs") or []
                     for f in sd.get("files") or [] if isinstance(f, dict))
    return n


def _refs_of_view(view):
    """收全视图引用（by_topic 嵌套组递归；by_phase/by_type 平铺组）。"""
    out = []
    for g in view["groups"]:
        out.extend(g.get("files") or [])
        for sub in g.get("groups") or []:
            out.extend(sub.get("files") or [])
    return out


# ── ① 守恒律：三视图引用数 = 原清单槽位数 ─────────────────────────────────

def test_conservation_mini_and_engine():
    for bp in (_mini_bp(), build_blueprint(WATER, mode="taxonomy")):
        v = vw.build_views(bp)
        n = _count_files(bp["tree"])
        assert n > 0
        assert v["metrics"]["files"] == n
        for key in vw.VIEWS:
            assert len(_refs_of_view(v[key])) == n, f"{key} 视图引用数失恒"


def test_conservation_split_dirs_and_document_driven():
    files = [{"name": f"施工案例_{i:03d}.pdf", "tier": "core", "ext": "pdf"}
             for i in range(1, 401)]  # >200 → 受控扇出分拆两组
    l2 = {"code": "T/01", "path": "T-01/01/", "name": "施工", "file_count": 400,
          "files": [], "split_dirs": split_files("施工", files, base_path="T-01/01/")}
    bp = {"tree": {"l1": [{"code": "T", "path": "T-01/", "name": "域", "l2": [l2]}]}}
    v = vw.build_views(bp)
    assert _count_files(bp["tree"]) == 400
    assert len(_refs_of_view(v["by_topic"])) == 400   # 分拆组拍平回 L2 主组
    assert len(_refs_of_view(v["by_phase"])) == 400   # 组名「施工」全量命中施工建造档
    assert len(_refs_of_view(v["by_type"])) == 400    # 「案例」全量命中案例实录档
    assert len(v["by_topic"]["groups"][0]["groups"][0]["files"]) == 400

    docs = [DocFile(title=t, source="wenku", fmt="pdf", pages=50,
                    badge="green_free", perm="green") for t in
            ["《中华人民共和国水法》", "《建设工程质量管理条例》",
             "水利水电工程手册", "水利工程建设项目验收管理规定"]]
    need = {"domain": "水利水电知识库", "keywords": ["EPC", "施工"],
            "intent": "技术管理", "size_hint": "small"}
    v2 = vw.build_views(build_blueprint_document_driven(need, docs))
    assert v2["metrics"]["files"] == 4
    for key in vw.VIEWS:
        assert len(_refs_of_view(v2[key])) == 4


# ── ② 分区律：每文件每视图恰属一个主组 ─────────────────────────────────────

def test_partition_exactly_one_group_per_view():
    for bp in (_mini_bp(), build_blueprint(WATER, mode="taxonomy")):
        v = vw.build_views(bp)
        for key in vw.VIEWS:
            refs = [r["ref"] for r in _refs_of_view(v[key])]
            assert len(refs) == len(set(refs)), f"{key} 视图同文件落多组"
        # by_topic 主组=L2：meta.group 恒为所属 L2 名（引用与组挂载互证）
        for g in v["by_topic"]["groups"]:
            for sub in g["groups"]:
                for r in sub["files"]:
                    assert r["meta"]["group"] == sub["name"]


def test_by_topic_mirrors_tree():
    bp = _mini_bp()
    v = vw.build_views(bp)
    top = v["by_topic"]["groups"][0]
    assert top["name"] == "水利枢纽" and top["path"] == "T-01/"
    assert [s["name"] for s in top["groups"]] == ["前期报批", "杂项", "施工技术"]
    assert [len(s["files"]) for s in top["groups"]] == [2, 1, 3]
    assert v["by_topic"]["origin"].startswith("existing_tree")


# ── ③ 零改动硬门：原树零回写 ───────────────────────────────────────────────

def test_build_views_zero_mutation():
    for bp in (_mini_bp(), build_blueprint(WATER, mode="taxonomy")):
        before = canonical_json(bp)
        vw.build_views(bp)
        vw.build_views(bp)  # 连跑两遍同样零改动
        assert canonical_json(bp) == before


def test_attach_views_touches_provenance_only():
    bp = _mini_bp()
    tree_before = canonical_json(bp["tree"])
    need_before = canonical_json(bp.get("need"))
    out = vw.attach_views(bp)
    assert out is bp  # 就地修改并返回同一 dict（house 风格）
    assert canonical_json(bp["tree"]) == tree_before
    assert canonical_json(bp.get("need")) == need_before
    v = vw.build_views(bp)
    assert bp["provenance"]["views_available"] == {
        "views": ["by_topic", "by_phase", "by_type"],
        "design_origin": vw.DESIGN_ORIGIN,
        "files": v["metrics"]["files"],
        "by_phase": v["metrics"]["by_phase"],
        "by_type": v["metrics"]["by_type"],
        "unmapped": v["metrics"]["unmapped"],
        "tree_touched": False,
    }


def test_attach_views_idempotent_and_defensive():
    bp = _mini_bp()
    vw.attach_views(bp)
    once = canonical_json(bp)
    vw.attach_views(bp)  # 二次挂载：views_available 同值覆盖 + S10 不重复
    assert canonical_json(bp) == once
    assert sum(str(x).startswith("S10 视图层") for x in bp["provenance"]["stage_log"]) == 1
    for empty in ({}, {"tree": {}}, {"tree": {"l1": []}}):
        assert vw.attach_views(empty) == empty  # 树缺失：原样返回不记账


# ── ④ 映射表正负例（phase + type）─────────────────────────────────────────

def test_phase_mapping_positive_and_specificity():
    assert vw.phase_for("施工组织设计方案.pdf", "core", "综合") == "施工建造"  # 组合词防误抢
    assert vw.phase_for("水利枢纽初步设计报告.pdf", "core", "综合") == "勘察设计"
    assert vw.phase_for("施工图设计文件审查要点.pdf", "core", "综合") == "勘察设计"
    assert vw.phase_for("项目建议书审批.pdf", "core", "杂项") == "前期报批"
    assert vw.phase_for("可行性研究报告.pdf", "core", "杂项") == "前期报批"
    assert vw.phase_for("竣工财务决算审计报告.pdf", "core", "杂项") == "质量验收"
    assert vw.phase_for("大坝安全运行维护手册.pdf", "guide", "杂项") == "运维检修"
    # 组名驱动映射（spec 口径：文件名+tier+组名）
    assert vw.phase_for("无字天书.md", "core", "前期报批组") == "前期报批"
    # tier 计入文本但词表不含 tier 值：纯 tier 不产伪信号
    assert vw.phase_for("无字天书.md", "guide", "杂项") == vw.UNMAPPED


def test_type_mapping_fmt_first_and_title_heuristics():
    assert vw.type_for({"name": "任意名.xlsx"}) == "数据报表"      # fmt 优先直判
    assert vw.type_for({"name": "任意名", "fmt": "CSV"}) == "数据报表"
    assert vw.type_for({"name": "GB50500工程量清单计价规范.pdf"}) == "标准规范"  # 标准号正则
    assert vw.type_for({"name": "SL677水闸技术标准.pdf"}) == "标准规范"
    assert vw.type_for({"name": "水利水电工程施工监理规范.pdf"}) == "标准规范"  # 关键词
    assert vw.type_for({"name": "EPC合同范本.docx"}) == "合同范本"
    assert vw.type_for({"name": "施工方案汇报模板.pptx"}) == "合同范本"
    assert vw.type_for({"title": "2026行业研究报告", "fmt": "pdf"}) == "研究报告"
    assert vw.type_for({"name": "基坑事故案例分析.pdf"}) == "案例实录"
    assert vw.type_for({"name": "设备台账明细表.docx"}) == "数据报表"  # fmt 未中走关键词
    # 组名口径=规约全名：两表声明序即 UI 组名单一事实源
    assert vw.PHASE_ORDER == ("前期报批", "勘察设计", "施工建造", "质量验收", "运维检修")
    assert vw.TYPE_ORDER == ("标准规范", "合同范本", "研究报告", "案例实录", "数据报表")


def test_unmapped_honest_not_fabricated():
    bp = _mini_bp()
    v = vw.build_views(bp)
    # 负例：神秘杂件两视图皆「待归类」，且不出现在任何声明组
    target = "T-01/02/神秘杂件_zzz.docx"
    for key in ("by_phase", "by_type"):
        names = [g["name"] for g in v[key]["groups"]]
        assert names[-1] == vw.UNMAPPED  # 待归类恒排尾部
        refs = {r["ref"] for r in _refs_of_view(v[key])}
        assert target in refs
        for g in v[key]["groups"][:-1]:
            assert target not in {r["ref"] for r in g["files"]}
    assert v["metrics"]["unmapped"] == {"by_phase": 1, "by_type": 3}
    assert v["metrics"]["by_phase"]["待归类"] == 1
    assert v["metrics"]["by_type"]["待归类"] == 3
    # mini 分布账（正例全对号；组名=规约全名）
    assert v["metrics"]["by_phase"] == {"前期报批": 2, "勘察设计": 1, "施工建造": 2,
                                        "质量验收": 0, "运维检修": 0, "待归类": 1}
    assert v["metrics"]["by_type"] == {"标准规范": 1, "合同范本": 0, "研究报告": 1,
                                       "案例实录": 0, "数据报表": 1, "待归类": 3}
    # 全映射树不出空待归类组（滤空组=轻量；0 档只进 metrics 账）
    assert [g["name"] for g in v["by_phase"]["groups"]] == ["前期报批", "勘察设计", "施工建造", "待归类"]
    assert [g["name"] for g in v["by_type"]["groups"]] == ["标准规范", "研究报告", "数据报表", "待归类"]


# ── ⑤ meta 标注：只消费既有键，缺键如实 None ───────────────────────────────

def test_meta_annotation_reads_existing_keys_only():
    v = vw.build_views(_mini_bp())
    ref = next(r for r in _refs_of_view(v["by_topic"]) if r["name"] == "工程量清单汇总表.xlsx")
    assert ref["ref"] == "T-01/01/工程量清单汇总表.xlsx"
    assert ref["meta"] == {"clc_no": None, "fmt": "xlsx", "tier": "field",
                           "group": "前期报批"}  # 未编目 clc 如实 None；ext 同义回退 fmt
    # v2 document_driven 槽：fmt 自带，无 tier 键 → None 如实
    docs = [DocFile(title="《中华人民共和国水法》", source="wenku", fmt="pdf",
                    pages=50, badge="green_free", perm="green")]
    need = {"domain": "水利水电知识库", "keywords": ["水法"], "intent": "查法", "size_hint": "small"}
    v2 = vw.build_views(build_blueprint_document_driven(need, docs))
    ref2 = _refs_of_view(v2["by_topic"])[0]
    assert ref2["meta"]["fmt"] == "pdf" and ref2["meta"]["tier"] is None
    assert ref2["meta"]["clc_no"] is None


def test_meta_clc_visible_after_cataloging_on_copy():
    bp = _mini_bp()
    before = canonical_json(bp)
    copy = json.loads(before)  # 副本上编目（ensure_catalog 会写 slot.catalog）
    ensure_catalog(copy)
    v = vw.build_views(copy)
    refs = _refs_of_view(v["by_topic"])
    assert all(r["meta"]["clc_no"] == "T" for r in refs)  # mini L1 code=T 大类直取
    assert canonical_json(bp) == before  # 原树未被编目/视图任一环节染指


# ── ⑥ phase 与 type 独立性：同文件两视图可不同组 ──────────────────────────

def _group_of(view, ref):
    """在视图中查 ref 所属主组名（by_topic 嵌套组递归；找不到 → None）。"""
    for g in view["groups"]:
        for r in g.get("files") or []:
            if r["ref"] == ref:
                return g["name"]
        for sub in g.get("groups") or []:
            for r in sub.get("files") or []:
                if r["ref"] == ref:
                    return sub["name"]
    return None


def test_phase_type_independence():
    bp = _mini_bp()
    v = vw.build_views(bp)
    # 同一文件：阶段轴与类型轴判定互不干涉，可落（且此处确实落）不同组——
    #   工程量清单汇总表.xlsx → 阶段=前期报批（组名驱动）/ 类型=数据报表（fmt 驱动）
    #   GB50500…计价规范.pdf  → 阶段=施工建造（组名驱动）/ 类型=标准规范（标准号正则）
    cases = [("T-01/01/工程量清单汇总表.xlsx", "前期报批", "数据报表"),
             ("T-01/03/GB50500工程量清单计价规范.pdf", "施工建造", "标准规范")]
    for ref, want_phase, want_type in cases:
        assert _group_of(v["by_phase"], ref) == want_phase
        assert _group_of(v["by_type"], ref) == want_type
        assert want_phase != want_type  # 两轴组名空间互不相交 → 独立性可观测
    # 判定器输入轴即不同：phase 吃「文件名+tier+组名」，type 吃「fmt+标题」——
    # 组名只影响阶段轴（换成运维检修组→阶段变），类型轴不收组名（恒数据报表）
    slot = {"name": "工程量清单汇总表.xlsx", "tier": "field", "ext": "xlsx"}
    assert vw.phase_for(slot["name"], slot["tier"], "运维检修") == "运维检修"
    assert vw.type_for(slot) == "数据报表"
    # fmt 只影响类型轴：xlsx→docx 后类型档失守→待归类，阶段轴不看 fmt 恒不变
    xlsx = {"name": "无字天书.xlsx", "tier": "field"}
    docx = {"name": "无字天书.docx", "tier": "field"}
    assert vw.type_for(xlsx) == "数据报表"
    assert vw.type_for(docx) == vw.UNMAPPED
    assert vw.phase_for(xlsx["name"], "field", "前期报批") == \
           vw.phase_for(docx["name"], "field", "前期报批") == "前期报批"


# ── ⑦ 零复制轻量树：三视图共享同一批引用对象，文件本体一份 ─────────────────

def test_views_share_ref_objects_zero_copy():
    for bp in (_mini_bp(), build_blueprint(WATER, mode="taxonomy")):
        v = vw.build_views(bp)
        flat = {"by_topic": [r for g in v["by_topic"]["groups"]
                             for sub in g["groups"] for r in sub["files"]],
                "by_phase": [r for g in v["by_phase"]["groups"] for r in g["files"]],
                "by_type": [r for g in v["by_type"]["groups"] for r in g["files"]]}
        by_ref = {r["ref"]: r for r in flat["by_topic"]}
        assert len(by_ref) == len(flat["by_topic"])  # ref 全库唯一前提自证
        # 同一 ref 在三视图指向同一对象（is）——投影零复制，文件本体只此一份
        for key in ("by_phase", "by_type"):
            assert all(r is by_ref[r["ref"]] for r in flat[key]), f"{key} 引用非同体"
        # 轻量树契约：引用只有指针键，槽位本体键（title/bytes/url/badge/…）不进场
        assert all(set(r) == {"ref", "name", "meta"} for r in flat["by_topic"])
        assert all(set(r["meta"]) == {"clc_no", "fmt", "tier", "group"}
                   for r in flat["by_topic"])


# ── 确定性 + 引擎树冒烟 ────────────────────────────────────────────────────

def test_views_deterministic():
    bp = _mini_bp()
    assert canonical_json(vw.build_views(bp)) == canonical_json(vw.build_views(bp))
    a = build_blueprint(dict(WATER), mode="taxonomy")
    assert canonical_json(vw.build_views(a)) == canonical_json(vw.build_views(a))


def test_engine_blueprint_smoke():
    v = vw.build_views(build_blueprint(WATER, mode="taxonomy"))
    assert set(v) == {"origin", *vw.VIEWS, "metrics"}
    assert all(v[k]["label"] for k in vw.VIEWS)
    m = v["metrics"]
    assert sum(m["by_phase"].values()) == m["files"] == sum(m["by_type"].values())
    for g in v["by_phase"]["groups"] + v["by_type"]["groups"]:
        assert g["files"], "视图树只出非空组"


if __name__ == "__main__":
    for fn in [test_conservation_mini_and_engine,
               test_conservation_split_dirs_and_document_driven,
               test_partition_exactly_one_group_per_view,
               test_by_topic_mirrors_tree, test_build_views_zero_mutation,
               test_attach_views_touches_provenance_only,
               test_attach_views_idempotent_and_defensive,
               test_phase_mapping_positive_and_specificity,
               test_type_mapping_fmt_first_and_title_heuristics,
               test_unmapped_honest_not_fabricated,
               test_meta_annotation_reads_existing_keys_only,
               test_meta_clc_visible_after_cataloging_on_copy,
               test_phase_type_independence,
               test_views_share_ref_objects_zero_copy,
               test_views_deterministic, test_engine_blueprint_smoke]:
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
