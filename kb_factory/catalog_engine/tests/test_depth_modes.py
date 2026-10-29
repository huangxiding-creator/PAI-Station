# -*- coding: utf-8 -*-
"""蓝图深度三档测试（轨A4：standard/pro/flagship）——三档槽量对比/下限/确定性/无参兼容。

口径（与 blueprint.DEPTH_MODES 同源）：
  standard = 现状零漂移（无参输出逐字节一致，既有契约不破）
  pro      = 每 L2 组槽位 ×1.4（round）+ 组下限 4
  flagship = ×1.8 + 组下限 6 + provenance.depth 如实记录档位
  同输入同 depth 必同输出（纯规则确定性）
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import build_blueprint  # noqa: E402
from catalog_engine.blueprint import (DEPTH_MODES, canonical_json, normalize_depth,  # noqa: E402
                                      scale_slots)
from catalog_engine.document_engine import DocFile, build_blueprint_document_driven  # noqa: E402
from catalog_engine.engine import SIZE_PLANS  # noqa: E402

NEED = {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
        "intent": "诉讼与合规", "size_hint": "medium"}


def _groups(bp):
    return [l2 for l1 in bp["tree"]["l1"] for l2 in l1["l2"]]


def _group_slots(l2):
    """L2 组槽位总数（分拆组拍平）。"""
    if l2.get("split_dirs"):
        return sum(len(sd["files"]) for sd in l2["split_dirs"])
    return len(l2.get("files") or [])


# ── 纯函数档位规格 ─────────────────────────────────────────────────────────

def test_scale_slots_spec():
    assert scale_slots(12, "standard") == 12          # 标准档=现状
    assert scale_slots(10, "pro") == 14               # 10×1.4
    assert scale_slots(12, "pro") == 17               # 16.8 → round 17
    assert scale_slots(14, "pro") == 20               # 19.6 → round 20
    assert scale_slots(10, "flagship") == 18          # ×1.8
    assert scale_slots(12, "flagship") == 22          # 21.6 → 22
    assert scale_slots(1, "pro") == 4                 # 放大后仍小 → 下限 4 保底
    assert scale_slots(2, "flagship") == 6            # 下限 6 保底


def test_normalize_depth():
    assert normalize_depth("pro") == "pro"
    assert normalize_depth("FLAGSHIP") == "flagship"  # 大小写宽容
    assert normalize_depth(" standard ") == "standard"
    assert normalize_depth(None) is None              # 无参=standard 兼容
    assert normalize_depth("") is None
    assert normalize_depth("huge") is None            # 旧规模档词非法 → standard
    assert normalize_depth("deep") is None
    assert normalize_depth(3) is None
    assert normalize_depth(True) is None              # bool 非 int 档位（同云函数纪律）
    assert set(DEPTH_MODES) == {"standard", "pro", "flagship"}


# ── taxonomy 模式：三档槽量对比（每 L2 组槽数=scale_slots(fpg, depth)）─────

def test_taxonomy_slot_totals_by_depth():
    for size, plan in SIZE_PLANS.items():
        need = dict(NEED, size_hint=size)
        outs = {}
        for depth in ("standard", "pro", "flagship"):
            bp = build_blueprint(need, mode="taxonomy", depth=depth)
            outs[depth] = bp
            expected = scale_slots(plan["fpg"], depth)
            for l2 in _groups(bp):
                assert _group_slots(l2) == expected, \
                    f"{size}/{depth} 组 {l2['code']} 槽数 {l2.get('file_count')}≠{expected}"
            assert bp["stats"]["files"] == expected * len(_groups(bp))
        # 三档槽量严格递增，且 L1/L2 结构不动（只放大组内槽数）
        n_std, n_pro, n_flag = (outs[d]["stats"]["files"] for d in ("standard", "pro", "flagship"))
        assert n_std < n_pro < n_flag, f"{size} 三档槽量非递增: {n_std}/{n_pro}/{n_flag}"
        codes = [[l2["code"] for l2 in _groups(outs[d])] for d in ("standard", "pro", "flagship")]
        assert codes[0] == codes[1] == codes[2]


def test_taxonomy_group_minimum_per_l2():
    pro = build_blueprint(dict(NEED, size_hint="small"), mode="taxonomy", depth="pro")
    flag = build_blueprint(dict(NEED, size_hint="small"), mode="taxonomy", depth="flagship")
    assert all(_group_slots(l2) >= 4 for l2 in _groups(pro))
    assert all(_group_slots(l2) >= 6 for l2 in _groups(flag))


def test_taxonomy_fanout_law_holds_under_depth():
    """受控扇出律不破：huge+flagship（每组 450>200）仍分拆且每盘 ≤200。"""
    huge = dict(NEED, size_hint="huge", domain="超大规模法务资料总库")
    bp = build_blueprint(huge, mode="taxonomy", depth="flagship")
    assert bp["stats"]["split_dir_count"] > 0
    for l2 in _groups(bp):
        if l2.get("split_dirs"):
            assert all(len(sd["files"]) <= 200 for sd in l2["split_dirs"])
        else:
            assert len(l2["files"]) <= 200


# ── 确定性与无参兼容 ───────────────────────────────────────────────────────

def test_same_input_same_depth_same_output():
    for depth in ("standard", "pro", "flagship"):
        a = build_blueprint(NEED, mode="taxonomy", depth=depth)
        b = build_blueprint(NEED, mode="taxonomy", depth=depth)
        assert canonical_json(a) == canonical_json(b), f"{depth} 两次生成不一致"


def test_no_param_is_byte_identical_standard():
    """无参=现状零漂移：与 depth=None / 非法值输出逐字节一致。"""
    base = canonical_json(build_blueprint(NEED, mode="taxonomy"))
    assert canonical_json(build_blueprint(NEED, mode="taxonomy", depth=None)) == base
    for bad in ("", "huge", "deep", 2, True):
        assert canonical_json(build_blueprint(NEED, mode="taxonomy", depth=bad)) == base, \
            f"非法 depth={bad!r} 改变了无参输出"


def test_explicit_standard_only_adds_provenance_depth():
    """显式 standard：结构/统计与现状全同，仅 provenance 如实多一个档位键。"""
    a = build_blueprint(NEED, mode="taxonomy")
    b = build_blueprint(NEED, mode="taxonomy", depth="standard")
    for k in ("tree", "ratio", "stats", "quote", "need", "domain"):
        assert a[k] == b[k], f"{k} 被显式 standard 改动"
    assert "depth" not in a["provenance"]
    assert b["provenance"]["depth"] == "standard"


def test_provenance_depth_recorded():
    assert build_blueprint(NEED, mode="taxonomy", depth="pro")["provenance"]["depth"] == "pro"
    assert build_blueprint(NEED, mode="taxonomy", depth="flagship")["provenance"]["depth"] == "flagship"
    log = build_blueprint(NEED, mode="taxonomy", depth="flagship")["provenance"]["stage_log"]
    assert any("S5b 深度档位" in line for line in log)


# ── document_driven 模式：下限保底 + 规划位如实（真实文件一概不动）──────────

def _docs():
    """4 件真实文件：法律法规 3 件 + 工具书 1 件（后者单件成组，考下限）。"""
    titles = ["《中华人民共和国水法》", "《建设工程质量管理条例》",
              "《水利工程建设项目验收管理规定》", "水利水电工程手册"]
    return [DocFile(title=t, source="wenku", fmt="pdf", pages=50,
                    badge="green_free", perm="green") for t in titles]


def _doc_need():
    return {"domain": "水利水电知识库", "keywords": ["EPC", "施工"],
            "intent": "技术管理", "size_hint": "small"}


def test_document_driven_floor_and_scaling():
    bp = build_blueprint_document_driven(_doc_need(), _docs(), depth="pro")
    groups = _groups(bp)
    assert groups and all(len(l2["files"]) >= 4 for l2 in groups)   # 下限 4 保底
    # 真实 4 件一概不动（real_docs 不虚增），增量全为规划位（real=False、_规划_ 命名）
    assert bp["stats"]["files"] == sum(len(l2["files"]) for l2 in groups)
    assert bp["stats"]["real_docs"] == 4
    pads = [f for l2 in groups for f in l2["files"] if not f.get("real")]
    assert len(pads) == bp["stats"]["files"] - 4
    assert all("_规划_" in f["name"] for f in pads)
    assert bp["provenance"]["depth"] == "pro"

    flag = build_blueprint_document_driven(_doc_need(), _docs(), depth="flagship")
    assert all(len(l2["files"]) >= 6 for l2 in _groups(flag))       # 下限 6
    assert flag["stats"]["real_docs"] == 4
    assert flag["stats"]["files"] > bp["stats"]["files"]            # 旗舰档规划位更多
    assert flag["provenance"]["depth"] == "flagship"


def test_document_driven_no_depth_unchanged():
    bp = build_blueprint_document_driven(_doc_need(), _docs())
    files = [f for l2 in _groups(bp) for f in l2["files"]]
    assert len(files) == 4 and all(f.get("real") for f in files)
    assert "depth" not in bp["provenance"]
    # 确定性：同输入同档同输出
    a = build_blueprint_document_driven(_doc_need(), _docs(), depth="pro")
    b = build_blueprint_document_driven(_doc_need(), _docs(), depth="pro")
    assert canonical_json(a) == canonical_json(b)


if __name__ == "__main__":
    for fn in [test_scale_slots_spec, test_normalize_depth, test_taxonomy_slot_totals_by_depth,
               test_taxonomy_group_minimum_per_l2, test_taxonomy_fanout_law_holds_under_depth,
               test_same_input_same_depth_same_output, test_no_param_is_byte_identical_standard,
               test_explicit_standard_only_adds_provenance_depth, test_provenance_depth_recorded,
               test_document_driven_floor_and_scaling, test_document_driven_no_depth_unchanged]:
        fn()
        print(f"  PASS {fn.__name__}")
    print("ALL PASS")
