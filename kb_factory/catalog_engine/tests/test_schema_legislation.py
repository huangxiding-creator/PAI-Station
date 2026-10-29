# -*- coding: utf-8 -*-
"""节点 schema 立法 + 防环护栏测试（v2.6 #4，巨人 Docusaurus+BookStack 双 MIT 思想）。

覆盖四件：
  1. 节点新字段：L1/L2 容器节点 position/kind/icon/color/duty（v2 档增量键；
     duty 从种子主题描述派生 ≤20 字，无来源如实留空禁编造）
  2. README 槽：每 L2 组一粒「00-README」索引文档槽（kind=leaf/fmt=doc/体积极小；
     落 l2["readme_slot"] 键不入 files——stats/quote/15 字段槽位契约零漂移）
  3. 防环护栏：validate_tree 四查（父子环/孤儿/断裂/无归属）负例必检出，
     引擎自产树（taxonomy/分拆/document_driven/立法后）全绿；
     build 末尾自动跑、问题记 provenance.lint.tree_problems 不阻断
  4. 排序算子（BookStack 四算子）：position 优先 → 数字前缀剥离
     （「01-堤防」→「堤防」+position=1）→ 字母序兜底 → 原序稳定

兼容硬门：缺省（无 schema 参数/无 env）输出与旧 schema 逐字节零漂移，
既有 test_engine 72 项与 test_depth_modes 契约不破。"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import build_blueprint  # noqa: E402
from catalog_engine import blueprint as bpu  # noqa: E402
from catalog_engine.document_engine import DocFile, build_blueprint_document_driven  # noqa: E402
from catalog_engine.engine import _attach_lint  # noqa: E402

NEED = {"domain": "水利水电EPC知识库", "keywords": ["水法", "EPC总承包", "施工组织", "造价"],
        "intent": "施工与项目管理", "size_hint": "small"}


def _groups(bp):
    return [l2 for l1 in bp["tree"]["l1"] for l2 in l1["l2"]]


def _healthy():
    return build_blueprint(NEED, mode="taxonomy")


# ── ① 档位归一（参数优先，env 兜底，均非法=旧 schema）──────────────────────

def test_normalize_schema_param_and_env(monkeypatch):
    assert bpu.normalize_schema("v2") == "v2"
    assert bpu.normalize_schema(" V2 ") == "v2"          # 大小写/空白宽容
    assert bpu.normalize_schema("v1") is None            # 非法档 → 旧 schema
    assert bpu.normalize_schema("") is None
    assert bpu.normalize_schema(2) is None
    assert bpu.normalize_schema(True) is None            # bool 非 str 档（同云函数纪律）
    monkeypatch.delenv(bpu.SCHEMA_ENV, raising=False)
    assert bpu.normalize_schema(None) is None            # 无 env 缺参 → 零漂移
    monkeypatch.setenv(bpu.SCHEMA_ENV, "v2")
    assert bpu.normalize_schema(None) == "v2"            # env 兜底开关生效
    monkeypatch.setenv(bpu.SCHEMA_ENV, "yes")
    assert bpu.normalize_schema(None) is None            # env 非法值同样回旧 schema


# ── ② 节点新字段（v2 档增量键）──────────────────────────────────────────────

def test_v2_container_fields():
    bp = build_blueprint(NEED, mode="taxonomy", schema="v2")
    l1s = bp["tree"]["l1"]
    assert len(l1s) >= 8
    for i, l1 in enumerate(l1s, 1):
        assert l1["kind"] == "container"
        assert isinstance(l1["position"], float) and l1["position"] == float(i)
        assert l1["icon"] and isinstance(l1["color"], str) and l1["color"].startswith("#")
        assert isinstance(l1["duty"], str) and 0 < len(l1["duty"]) <= 20
        assert l1["duty"] == bpu.derive_duty(l1["theme"])   # 从种子主题描述派生
        for j, l2 in enumerate(l1["l2"], 1):
            assert l2["kind"] == "container"
            assert l2["position"] == float(j)
            assert l2["color"] == l1["color"]               # 组色承袭（L2 随 L1）
            assert isinstance(l2["duty"], str) and len(l2["duty"]) <= 20
    assert bp["provenance"]["node_schema"] == "v2"          # 档位如实可查
    assert any("节点 schema 立法" in x for x in bp["provenance"]["stage_log"])


def test_duty_derivation_honest():
    # 有来源：压缩空白后截断 ≤20 字
    assert bpu.derive_duty("法律法规与强制性标准——必须遵守的红线") == \
        "法律法规与强制性标准——必须遵守的红线"[:20]
    assert len(bpu.derive_duty("一" * 99)) == 20
    assert bpu.derive_duty("  多  空白\t压缩 ") == "多 空白 压缩"
    # 无来源：如实留空，禁编造
    assert bpu.derive_duty("") == ""
    assert bpu.derive_duty(None) == ""


# ── ③ 00-README 索引文档槽（每 L2 组一粒）───────────────────────────────────

def test_readme_slot_per_l2_group():
    bp = build_blueprint(NEED, mode="taxonomy", schema="v2")
    groups = _groups(bp)
    assert groups
    for l2 in groups:
        rs = l2["readme_slot"]
        assert rs["name"] == "00-README"
        assert rs["title"] == f"00-README·{l2['name']}"
        assert rs["kind"] == "leaf" and rs["fmt"] == "doc"
        assert 0 < rs["size_kb"] <= 8                       # 体积极小（指针卡）
        assert rs["position"] == 0.0                        # 组内恒排首位
        assert rs["path"] == l2["path"]
    # 每组恰好一粒；L1 不发 README（L1 已有 _INDEX.md 枢纽卡）
    assert sum("readme_slot" in l2 for l2 in groups) == len(groups)
    assert all("readme_slot" not in l1 for l1 in bp["tree"]["l1"])


# ── ④ 缺省零漂移硬门（既有契约不破）────────────────────────────────────────

def test_default_output_zero_drift(monkeypatch):
    monkeypatch.delenv(bpu.SCHEMA_ENV, raising=False)
    plain = build_blueprint(NEED, mode="taxonomy")
    assert bpu.canonical_json(build_blueprint(NEED, mode="taxonomy", schema=None)) == \
        bpu.canonical_json(plain)                          # schema=None 与缺参逐字节一致
    for bad in ("", "v1", 2, True):
        out = build_blueprint(NEED, mode="taxonomy", schema=bad)
        assert bpu.canonical_json(out) == bpu.canonical_json(plain), \
            f"非法 schema={bad!r} 改变了缺省输出"
    for l1 in plain["tree"]["l1"]:                         # 新键一概不出现
        assert "position" not in l1 and "kind" not in l1 and "duty" not in l1
        for l2 in l1["l2"]:
            assert "readme_slot" not in l2
    assert "node_schema" not in plain["provenance"]
    # 健康树不写 tree_problems（lint 形状保持四既有键）
    assert set(plain["provenance"]["lint"]) == \
        {"passed", "failed", "warnings", "overall_pass"}


def test_v2_is_pure_additive_keys():
    """v2 只增不改：stats/quote/ratio/文件槽清单与缺省档全等（README 不计价不入 files）。"""
    plain = build_blueprint(NEED, mode="taxonomy")
    v2 = build_blueprint(NEED, mode="taxonomy", schema="v2")
    assert v2["stats"] == plain["stats"]
    assert v2["quote"] == plain["quote"]
    assert v2["ratio"] == plain["ratio"]
    for a, b in zip(_groups(plain), _groups(v2)):
        assert a["files"] == b["files"]
        assert a["file_count"] == b["file_count"]
        assert a["code"] == b["code"]


def test_v2_deterministic():
    a = build_blueprint(NEED, mode="taxonomy", schema="v2")
    b = build_blueprint(json.loads(json.dumps(NEED)), mode="taxonomy", schema="v2")
    assert bpu.canonical_json(a) == bpu.canonical_json(b)


# ── ⑤ 排序算子（BookStack 四算子）───────────────────────────────────────────

def test_strip_numeric_prefix():
    assert bpu.strip_numeric_prefix("01-堤防") == ("堤防", 1.0)
    assert bpu.strip_numeric_prefix("10_蓄水") == ("蓄水", 10.0)
    assert bpu.strip_numeric_prefix("3.质量检测") == ("质量检测", 3.0)
    assert bpu.strip_numeric_prefix("01堤防") == ("堤防", 1.0)   # 紧贴无分隔符也剥
    assert bpu.strip_numeric_prefix("堤防") == ("堤防", None)
    assert bpu.strip_numeric_prefix("01") == ("01", None)   # 纯数字=编号本体不剥
    assert bpu.strip_numeric_prefix("2026") == ("2026", None)
    assert bpu.strip_numeric_prefix("") == ("", None)


def test_sort_nodes_four_operators():
    nodes = [{"name": "大坝"}, {"name": "02-溢洪道"}, {"name": "安全监测"},
             {"name": "01-堤防"}, {"name": "泵站", "position": 0.5}]
    got = bpu.sort_nodes(nodes)
    # ① position 显式优先（0.5 压过一切命名序）
    # ②③ 数字前缀升序在前；无前缀字母序兜底（大坝 U+5927 < 安全监测 U+5B89）
    assert [n["name"] for n in got] == ["泵站", "01-堤防", "02-溢洪道", "大坝", "安全监测"]
    # ④ 同键原序稳定兜底（sorted 稳定，入参序保留）
    tied = bpu.sort_nodes([{"name": "乙"}, {"name": "乙", "x": 1}])
    assert tied[0].get("x") is None and tied[1]["x"] == 1
    assert bpu.display_name({"name": "01-堤防"}) == "堤防"
    assert bpu.node_sort_key({"name": "01-堤防"}) == (1, 1.0, "堤防")
    assert bpu.node_sort_key({"name": "堤防", "position": 2}) == (0, 2.0, "")


def test_legislate_numeric_prefix_positions_and_sorts():
    """名称带数字前缀 → position 取前缀值并按算子重排；同 position 落回原序稳定兜底。"""
    l1 = {"code": "T-01", "path": "T-01/", "name": "试验组", "theme": "试验主题描述",
          "l2": [{"name": "堤防", "path": "T-01/01/", "code": "T-01/01", "theme": "堤防主题",
                  "files": []},
                 {"name": "02-泵站", "path": "T-01/02/", "code": "T-01/02", "theme": "",
                  "files": []},
                 {"name": "01-溢洪道", "path": "T-01/03/", "code": "T-01/03", "theme": "溢洪道主题",
                  "files": []}]}
    n = bpu.legislate_nodes([l1])
    assert n == 3                                            # README 槽=L2 组数
    # position：堤防 j=1、01-溢洪道 前缀=1、02-泵站 前缀=2 → 01 与 02 按算子换位；
    # 堤防与 01-溢洪道 同 position=1.0 → 原序稳定兜底（算子④）堤防在前
    assert [x["name"] for x in l1["l2"]] == ["堤防", "01-溢洪道", "02-泵站"]
    pos = {x["name"]: x["position"] for x in l1["l2"]}
    assert pos["堤防"] == 1.0 and pos["01-溢洪道"] == 1.0 and pos["02-泵站"] == 2.0
    by = {x["name"]: x for x in l1["l2"]}
    assert by["02-泵站"]["duty"] == ""                        # theme 无来源 → 如实留空
    assert by["堤防"]["duty"] == "堤防主题"
    assert by["01-溢洪道"]["readme_slot"]["title"] == "00-README·01-溢洪道"


# ── ⑥ 防环护栏：负例必检出 ─────────────────────────────────────────────────

def test_validate_tree_catches_object_cycle():
    bp = _healthy()
    l1 = bp["tree"]["l1"][0]
    l1["l2"][0]["l2"] = [l1]                                # 父对象重现于子树
    assert any(p.startswith("环:") for p in bpu.validate_tree(bp))
    bp2 = _healthy()
    n = bp2["tree"]["l1"][0]["l2"][0]
    n["l2"] = [n]                                            # 自指环
    assert any(p.startswith("环:") for p in bpu.validate_tree(bp2))


def test_validate_tree_catches_code_cycle():
    bp = _healthy()
    l1 = bp["tree"]["l1"][0]
    l1["l2"].append({"code": l1["code"], "path": l1["path"] + "环/", "files": []})
    assert any("同码成环" in p for p in bpu.validate_tree(bp))


def test_validate_tree_catches_orphans():
    bp = {"tree": {"mode": "x", "root": "r", "l1": [
        {"code": "A-01", "path": "A-01/", "l2": [
            {"code": "Z-99/01", "path": "Z-99/01/", "files": []},
            {"code": "A-01/02", "path": "A-01/02/",
             "split_dirs": [{"name": "d", "path": "Q/01/"}]},
            {"code": "A-01/03", "path": "A-01/03/"},
        ]}]}}
    probs = bpu.validate_tree(bp)
    assert any(p.startswith("孤儿: L2") and "Z-99/01" in p for p in probs)  # 父目录不存在
    assert any("无文件通道" in p for p in probs)                             # L2 断头
    assert any("缺 files 键" in p for p in probs)                            # 分拆断头
    assert any("越级" in p for p in probs)                                   # 分拆路径越级


def test_validate_tree_catches_misplaced_and_unowned():
    bp = _healthy()
    l1a, l1b = bp["tree"]["l1"][0], bp["tree"]["l1"][1]
    l1a["l2"].append({"code": l1b["path"].rstrip("/") + "/77",
                      "path": l1b["path"] + "77/", "files": []})
    assert any("挂错父" in p for p in bpu.validate_tree(bp))   # L2 挂在别人名下
    bp2 = _healthy()
    l2 = bp2["tree"]["l1"][0]["l2"][0]
    l2["files"].append({"name": "野文件.md", "path": "Q/99/"})  # path 不属任何目录
    assert any(p.startswith("无归属:") and "野文件" in p for p in bpu.validate_tree(bp2))
    l2["files"][-1] = {"name": "串门.md", "path": l1b["path"]}  # 属他组=脱组（断裂）
    assert any(p.startswith("断裂: 文件") and "串门" in p for p in bpu.validate_tree(bp2))


def test_validate_tree_root_scatter_and_l1_scatter_and_dup():
    probs = bpu.validate_tree({"tree": {"files": [{"name": "x.md"}], "l1": []}})
    assert probs == ["断裂: 树缺 L1 层（tree.l1 为空或非列表）"]
    bp = _healthy()
    bp["tree"]["files"] = [{"name": "根级散件.md"}]              # 根级散文件
    assert any(p.startswith("无归属: 根级散文件") for p in bpu.validate_tree(bp))
    bp2 = _healthy()
    bp2["tree"]["l1"][0]["files"] = [{"name": "越级.md"}]        # L1 直属文件
    assert any(p.startswith("无归属: L1") for p in bpu.validate_tree(bp2))
    bp3 = _healthy()
    a, b = bp3["tree"]["l1"][0], bp3["tree"]["l1"][1]
    a["path"], a["code"] = b["path"], b["code"]                  # 同路径重复
    assert any("目录路径重复" in p for p in bpu.validate_tree(bp3))


# ── ⑦ 防环护栏：引擎自产树全绿 + build 末尾自动跑 ──────────────────────────

SAMPLE_NEEDS = [
    {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼"], "intent": "诉讼与合规",
     "size_hint": "medium"},
    {"domain": "初中数学教师备课库", "keywords": ["初中数学", "教案"], "intent": "备课与教研",
     "size_hint": "small"},
    {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包"], "intent": "施工与项目管理",
     "size_hint": "large"},
]


def test_validate_tree_healthy_on_engine_outputs():
    for need in SAMPLE_NEEDS:
        bp = build_blueprint(need, mode="taxonomy")
        assert bpu.validate_tree(bp) == [], f"{need['domain']} 引擎自产树不应有问题"
    v2 = build_blueprint(NEED, mode="taxonomy", schema="v2")     # 立法后依旧全绿
    assert bpu.validate_tree(v2) == []
    huge = build_blueprint(dict(NEED, size_hint="huge"), mode="taxonomy")
    assert bpu.validate_tree(huge) == []                          # 分拆树也自洽


def test_validate_tree_and_legislation_document_driven():
    docs = [DocFile(title=t, source="wenku", fmt="pdf", pages=50,
                    badge="green_free", perm="green") for t in
            ["《中华人民共和国水法》", "《建设工程质量管理条例》",
             "水利水电工程手册", "水利工程建设项目验收管理规定"]]
    need = {"domain": "水利水电知识库", "keywords": ["EPC", "施工"],
            "intent": "技术管理", "size_hint": "small"}
    bp = build_blueprint_document_driven(need, docs)
    assert bpu.validate_tree(bp) == []
    names_before = json.dumps([[f["name"] for f in l2["files"]] for l1 in bp["tree"]["l1"]
                               for l2 in l1["l2"]], ensure_ascii=False)
    n = bpu.legislate_nodes(bp["tree"]["l1"])
    assert n == sum(len(l1["l2"]) for l1 in bp["tree"]["l1"])     # 每组一粒 README
    assert bpu.validate_tree(bp) == []                            # 立法后仍健康
    names_after = json.dumps([[f["name"] for f in l2["files"]] for l1 in bp["tree"]["l1"]
                              for l2 in l1["l2"]], ensure_ascii=False)
    assert names_after == names_before                           # files 一概未动
    for l1 in bp["tree"]["l1"]:
        assert l1["duty"] == bpu.derive_duty(l1["theme"])[:20]
        assert l1["kind"] == "container"
        for l2 in l1["l2"]:
            assert "readme_slot" in l2 and l2["kind"] == "container"


def test_build_pipeline_records_tree_problems_nonblocking():
    healthy = build_blueprint(NEED, mode="taxonomy")
    assert "tree_problems" not in healthy["provenance"]["lint"]   # 健康树不写键（零漂移）
    corrupted = build_blueprint(NEED, mode="taxonomy")
    corrupted["tree"]["l1"][0]["l2"][0]["l2"] = [corrupted["tree"]["l1"][0]]  # 注入对象环
    out = _attach_lint(corrupted)                                 # 不抛异常=不阻断
    probs = out["provenance"]["lint"]["tree_problems"]
    assert any(p.startswith("环:") for p in probs)
    assert set(out["provenance"]["lint"]) == \
        {"passed", "failed", "warnings", "overall_pass", "tree_problems"}


if __name__ == "__main__":
    for fn in [test_normalize_schema_param_and_env, test_v2_container_fields,
               test_duty_derivation_honest, test_readme_slot_per_l2_group,
               test_default_output_zero_drift, test_v2_is_pure_additive_keys,
               test_v2_deterministic, test_strip_numeric_prefix,
               test_sort_nodes_four_operators,
               test_legislate_numeric_prefix_positions_and_sorts,
               test_validate_tree_catches_object_cycle,
               test_validate_tree_catches_code_cycle,
               test_validate_tree_catches_orphans,
               test_validate_tree_catches_misplaced_and_unowned,
               test_validate_tree_root_scatter_and_l1_scatter_and_dup,
               test_validate_tree_healthy_on_engine_outputs,
               test_validate_tree_and_legislation_document_driven,
               test_build_pipeline_records_tree_problems_nonblocking]:
        globals()[fn.__name__ + "_run"] = None
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
