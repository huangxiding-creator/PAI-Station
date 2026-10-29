# -*- coding: utf-8 -*-
"""kb_generate 云函数离线单测（纯规则引擎本地直跑，零真网络；
真网络/真部署验证腿一律 @pytest.mark.skip 保底不炸 CI）。

运行：py -3 -m pytest cloudfn/kb_generate/test_kb_generate.py -q（于 kb_factory 根）
"""
import json
import sys
from pathlib import Path

import pytest

HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import index  # noqa: E402

TEXT = "水利工程质量验收"


def test_main_returns_blueprint_core_keys():
    bp = index.main({"text": TEXT})
    for k in ("domain", "need", "tree", "ratio", "stats", "quote", "provenance"):
        assert k in bp, k
    assert bp["tree"]["l1"] and bp["tree"]["mode"] in ("six_domains", "clc")


def test_view_shape_is_sample_contract():
    """传输视图与包内样本同构：l2_count/槽位七字段/报价 import_add/截断注明。"""
    bp = index.main({"text": TEXT})
    l1 = bp["tree"]["l1"][0]
    assert set(l1.keys()) == {"code", "dir", "name", "theme", "l2_count", "l2"}
    assert l1["l2_count"] == len(l1["l2"])
    l2 = l1["l2"][0]
    assert set(l2.keys()) == {"code", "name", "path", "file_count", "files"}
    assert 1 <= len(l2["files"]) <= 3 and l2["file_count"] >= len(l2["files"])
    f = l2["files"][0]
    assert set(f.keys()) == {"name", "tier", "ext", "size", "icon", "src", "perm"}
    assert f["name"].endswith("." + f["ext"])
    assert f["src"] in ("公开资料", "会员资料", "共享资料", "官方标准", "自有资料")
    q = bp["quote"]
    assert q["import_add"] == 19.0 and "ima_add" not in q
    assert set(q) == {"base", "per_gb", "md_factor", "total", "import_add"}
    assert bp["_remote"]["truncated"] is True
    assert bp["_remote"]["files_total"] == bp["stats"]["files"]


def test_transport_budget_all_depths():
    """全部档位传输体 ≤200KB（与包内样本同一预算）。"""
    for depth in ("small", "medium", "large", "huge", 1, 2, 3, 4):
        bp = index.main({"text": TEXT, "depth": depth})
        size = len(json.dumps(bp, ensure_ascii=False, separators=(",", ":")).encode("utf-8"))
        assert size <= 200 * 1024, f"depth={depth} {size}B"


def test_depth_mapping():
    assert index._depth_to_size(None) == "large"      # 默认档=与旗舰样本同档
    assert index._depth_to_size("") == "large"
    assert index._depth_to_size("huge") == "huge"
    assert index._depth_to_size("M") == "medium"      # 别名不区分大小写
    assert index._depth_to_size(4) == "huge"
    assert index._depth_to_size("2") == "medium"
    assert index._depth_to_size("bad") == "large"     # 非法如实回落默认档
    assert index._depth_to_size(True) == "large"      # bool 非 int 档位
    assert index._depth_to_size(99) == "large"


def test_deterministic_same_input_same_output():
    a = json.dumps(index.main({"text": "律师事务所知识库"}), ensure_ascii=False, sort_keys=True)
    b = json.dumps(index.main({"text": "律师事务所知识库"}), ensure_ascii=False, sort_keys=True)
    assert a == b


def test_seed_routing_water_hits_six_domains():
    bp = index.main({"text": "水利水电EPC施工知识库"})
    assert bp["tree"]["mode"] == "six_domains"
    codes = [l1["code"] for l1 in bp["tree"]["l1"]]
    assert codes[:6] == ["MK", "EN", "EX", "KN", "CA", "RB"]


def test_seed_routing_generic_hits_clc():
    bp = index.main({"text": "少儿英语启蒙"})
    assert bp["tree"]["mode"] == "clc"
    assert 8 <= len(bp["tree"]["l1"]) <= 22


def test_empty_text_raises():
    with pytest.raises(ValueError):
        index.main({"text": "   "})
    with pytest.raises(ValueError):
        index.main({})


def test_keywords_extraction():
    kws = index._extract_keywords("水利工程质量验收，施工组织设计与造价")
    assert kws == ["水利工程质量验收", "施工组织设计与造价"][:2]
    assert index._extract_keywords("律") == ["律"]  # 单字无切点 → 整段兜底
    assert len(index._extract_keywords("水利 水利 水电 监理 造价 安全 计量")) == 5  # 上限5


def test_huge_split_dirs_view_still_has_files():
    """huge 档每组 250 槽>200 上限走分拆目录：视图仍从分拆首盘取展示条目。"""
    bp = index.main({"text": TEXT, "depth": "huge"})
    assert bp["stats"]["split_dir_count"] > 0
    with_split = [l2 for l1 in bp["tree"]["l1"] for l2 in l1["l2"] if l2["file_count"] == 250]
    assert with_split and all(1 <= len(l2["files"]) <= 3 for l2 in with_split)


def test_depth_mode_passthrough():
    """轨A4：event.depth=standard/pro/flagship 三档透传引擎（槽量按档放大）；
    旧规模档词（small..huge）经引擎归一仍=现状零漂移；传输体不破 200KB 预算。"""
    std = index.main({"text": TEXT})
    pro = index.main({"text": TEXT, "depth": "pro"})
    flag = index.main({"text": TEXT, "depth": "flagship"})
    assert 0 < std["stats"]["files"] < pro["stats"]["files"] < flag["stats"]["files"]
    assert pro["provenance"]["depth"] == "pro"
    assert flag["provenance"]["depth"] == "flagship"
    assert "depth" not in std["provenance"]  # 无参=现状（不写档位键）
    assert all(l2["file_count"] >= 4 for l1 in pro["tree"]["l1"] for l2 in l1["l2"])
    assert all(l2["file_count"] >= 6 for l1 in flag["tree"]["l1"] for l2 in l1["l2"])
    for bp in (pro, flag):
        size = len(json.dumps(bp, ensure_ascii=False, separators=(",", ":")).encode("utf-8"))
        assert size <= 200 * 1024, f"depth={bp['provenance']['depth']} {size}B"
    # 旧口径 depth（规模档）不被当蓝图档：引擎归一 standard，蓝图仍按 size_hint 原样
    old = index.main({"text": TEXT, "depth": "small"})
    assert "depth" not in old["provenance"]
    assert all(l2["file_count"] == 10 for l1 in old["tree"]["l1"] for l2 in l1["l2"])  # small 计划 fpg=10


def test_guided_flag_passthrough():
    """收口波B：event.guided 三态透传 build_blueprint(guided=)——
    True → 首 L1=「00-导览」（📥收件箱+五类实体索引）且 provenance.guided_layer=true，
    视图层同构兼容（L1/L2/槽位七字段不破）；False/缺省 → 与基线逐字节一致（零漂移）；
    开启态传输体仍守 200KB 预算。"""
    on = index.main({"text": TEXT, "guided": True})
    assert on["tree"]["l1"][0]["name"] == "00-导览"
    assert on["provenance"]["guided_layer"] is True
    assert on["provenance"]["guided_layer_info"]["page_count"] == 6
    # 视图契约不破：导览组同构（code/name/path/file_count/files 七字段槽位）
    g_l1 = on["tree"]["l1"][0]
    assert set(g_l1.keys()) == {"code", "dir", "name", "theme", "l2_count", "l2"}
    g_slot = g_l1["l2"][0]["files"][0]
    assert set(g_slot.keys()) == {"name", "tier", "ext", "size", "icon", "src", "perm"}
    assert g_slot["src"] == "自有资料" and g_slot["perm"] == "可自由使用"
    size = len(json.dumps(on, ensure_ascii=False, separators=(",", ":")).encode("utf-8"))
    assert size <= 200 * 1024, f"guided on {size}B"
    # 关态零漂移：False 与缺省 = 基线逐字节一致，且无导览组
    base = json.dumps(index.main({"text": TEXT}), ensure_ascii=False, sort_keys=True)
    off = json.dumps(index.main({"text": TEXT, "guided": False}), ensure_ascii=False,
                     sort_keys=True)
    assert base == off
    plain = index.main({"text": TEXT})
    assert plain["tree"]["l1"][0]["name"] != "00-导览"
    assert "guided_layer" not in plain["provenance"]


@pytest.mark.skip(reason="真部署验证腿：需 tcb fn deploy 后实调，CI 离线保底跳过")
def test_live_deployed_roundtrip():
    import subprocess  # noqa: F401  部署后手动解除 skip：
    # tcb fn detail kb_generate 确认在役，再以 DevTools console:
    # wx.cloud.callFunction({name:'kb_generate', data:{text:'水利工程质量验收'}})
    assert False, "真网络用例仅人肉触发"
