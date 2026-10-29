# -*- coding: utf-8 -*-
"""Dendron 模板展开层测试（v2.7 补收）：22 大类展开全覆盖 / 分层稳定 ID 增删兄弟
不漂移（逐字节）/ 深度硬控≤三级 / 模板-槽位-配比契约 / 类号对齐巨人实库 /
与 clc_layer 互补不冲突（输出键可区分）/ 确定性 / fail-soft。

口径：
  - 「深度≤三级」按输出树深计（根=1），l3 为槽位展开层，永无 l4 键；
  - 稳定 ID 稳定性负例：增 L3 兄弟+删 L3 兄弟+增 L2 兄弟+删 L2 兄弟+重排兄弟
    五连击后 refresh_ids，幸存节点 ID 与快照逐字节相等（ID=父ID+段哈希，与
    兄弟无关）；同父内容重复（槽位重名）按兄弟序 -k 消歧，仅波及冲突者；
  - 类号对齐：SCHEMA_22 组 code ∈ 巨人 chinese-library-classification 实库该类
    next_level 真实二级类号（包缺席则该断言跳过，其余断言不受影响）；
  - 与 clc_layer 互补：mode 互斥（dendron_expand vs clc_expand）、dendron 节点
    必有 origin+stable_id（clc 节点永无）、clc 节点必有 clc_level（dendron 永无）；
  - 引擎期键（file_count/files/index_md）模板层不造（数字零造假纪律）；
  - 种子键族对齐 seeds 六域树（code/dir/name/path/theme 全覆盖）。
"""
import copy
import subprocess
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import dendron  # noqa: E402
from catalog_engine.dendron import (  # noqa: E402
    CLC_TOP_ORDER, HARD_MAX_DEPTH, SCHEMA_22, expand, refresh_ids, schema_stats, stable_id)
from catalog_engine import clc_layer, taxonomy  # noqa: E402

KB_FACTORY = Path(__file__).resolve().parents[2]
SEED_FILE = KB_FACTORY / "seeds" / "05_水利EPC工程.json"
AUTHORED_OK = {"I", "O", "U", "V"}  # 大类真实二级类目不足 6 组、允许补组的四类


def _walk(node, depth=1):
    """产出 (深度, 节点)（子层键 l2/l3 按层取名）。"""
    yield depth, node
    for child in node.get(f"l{depth + 1}", []):
        yield from _walk(child, depth + 1)


def _tree_depth(node, depth=1):
    """输出树深（根=1；无子层键即为叶）。"""
    children = node.get(f"l{depth + 1}", [])
    return max([depth] + [_tree_depth(c, depth + 1) for c in children])


# ── 1. SCHEMA_22 种子契约 ─────────────────────────────────────────────────────

def test_schema22_contract():
    """22 大类齐全且与 taxonomy.CLC_22 同轴；组字段契约（模板/槽位/配比/类号唯一）。"""
    codes = {c["code"] for c in taxonomy.CLC_22}
    assert set(SCHEMA_22) == codes and len(SCHEMA_22) == 22
    assert CLC_TOP_ORDER == tuple(SCHEMA_22)
    for key, spec in SCHEMA_22.items():
        assert spec["name"], f"{key} 大类名缺失"
        groups = spec["groups"]
        assert 6 <= len(groups) <= 12, f"{key} 模板组数 {len(groups)} 越 6-12 界"
        seen_code = set()
        for g in groups:
            assert set(g) == {"code", "name", "template", "slots", "share"}
            assert g["name"] and g["slots"] and isinstance(g["share"], int) and g["share"] >= 1
            assert g["template"].count("{slot}") == 1, f"{key} 模板须恰含一个 {{slot}}"
            assert len(g["slots"]) == len(set(g["slots"])), f"{key}/{g['name']} 槽位重复"
            assert all(isinstance(s, str) and s for s in g["slots"])
            if g["code"]:
                assert g["code"] not in seen_code, f"{key} 组类号重复: {g['code']}"
                seen_code.add(g["code"])
        if key not in AUTHORED_OK:
            assert all(g["code"] for g in groups), f"{key} 非补组类不得有无类号补组"


def test_schema22_codes_aligned_with_giant_db():
    """类号对齐：组 code ∈ 巨人实库该类 next_level 真实二级类号（包缺席则跳过）。"""
    data = clc_layer._get_data()
    if data is None:
        pytest.skip("巨人 chinese-library-classification 不在位，类号对齐断言让位于真缺席")
    for key, spec in SCHEMA_22.items():
        real_l2 = set(data[key]["next_level"])
        for g in spec["groups"]:
            if g["code"]:
                assert g["code"] in real_l2, f"{key} 组类号 {g['code']} 非实库二级类号"
    assert SCHEMA_22["T"]["groups"][-1]["name"] == data["TV"]["name"] == "水利工程"


# ── 2. 22 大类展开全覆盖 ─────────────────────────────────────────────────────

def test_expand_all_22_full_coverage():
    """22 大类逐类展开：结构/路径拼接/键族/配比/模板渲染/子组数全契约。"""
    assert HARD_MAX_DEPTH == 3
    for key in CLC_TOP_ORDER:
        tree = expand(key)
        assert tree is not None, f"{key} 展开失败"
        assert tree["mode"] == "dendron_expand" and tree["schema_key"] == key
        assert tree["root"] == f"{key} {SCHEMA_22[key]['name']}"
        root = tree["l1"][0]
        assert root["dir"] == key and root["path"] == f"{key}/" and root["code"] == key
        groups = root["l2"]
        assert 6 <= len(groups) <= 12
        assert sum(g["ratio"] for g in groups) == pytest.approx(1.0, abs=1e-4)
        for g in groups:
            spec_g = next(s for s in SCHEMA_22[key]["groups"] if s["name"] == g["name"])
            expect_dir = (spec_g["code"] or spec_g["name"]).replace("/", "-")
            assert g["dir"] == expect_dir
            assert g["path"] == f"{key}/{g['dir']}/"  # 父path+dir+"/" 同 seeds 约定
            assert g["template"] == spec_g["template"] and g["slot_count"] == len(spec_g["slots"])
            assert g["origin"] == "dendron" and "dendronhq" in g["source"] and g["stable_id"]
            assert len(g["l3"]) == len(spec_g["slots"]) >= 3
            for leaf in g["l3"]:
                rendered = spec_g["template"].format(slot=leaf["slot"])
                assert leaf["name"] == rendered and leaf["dir"] == rendered
                assert leaf["path"] == g["path"] + rendered + "/"
                assert leaf["code"] is None and leaf["origin"] == "dendron"
            unit = g["ratio"] / len(g["l3"])
            for leaf in g["l3"]:
                assert leaf["ratio"] == pytest.approx(unit, abs=1e-6)


def test_node_keys_aligned_with_seed_groups():
    """节点键族覆盖 seeds 六域树组键；引擎期键（file_count/files/index_md）不造。"""
    import json
    seed_tree = json.loads(SEED_FILE.read_text(encoding="utf-8"))["tree"]
    base = set(seed_tree["l1"][0]) - {"l2"}
    for key in ("T", "D", "V"):
        for _, node in _walk(expand(key)["l1"][0]):
            assert base - {"file_count", "files", "index_md"} <= set(node), f"{key} 种子组键未覆盖"
            assert not ({"file_count", "files", "index_md"} & set(node))


# ── 3. 稳定 ID 语义 + 增删兄弟不漂移负例 ──────────────────────────────────────

def test_stable_id_chain_semantics():
    """分层链式：ID=父ID+段哈希；同段异支不撞；容错斜杠；空/非字符串抛错。"""
    assert stable_id("T").startswith("ddn.") and len(stable_id("T").split(".")) == 2
    leaf, mid = stable_id("T/TV/工程水文学"), stable_id("T/TV")
    assert leaf == mid + "." + stable_id("工程水文学").split(".", 1)[1]
    assert stable_id("T/TV/基础") != stable_id("T/TU/基础")  # 同名叶异支 ID 不同
    assert stable_id("T/TV") == stable_id("T//TV/") == stable_id("T\\TV")  # 容错
    assert stable_id("T/TV") == stable_id("T/TV")  # 确定性
    with pytest.raises(ValueError):
        stable_id("")
    with pytest.raises(ValueError):
        stable_id("  /  ")
    with pytest.raises(TypeError):
        stable_id(123)


def test_stable_id_equals_tree_ids_zero_collision():
    """种子槽位两两不重 → 全 22 类树内 ID 与纯函数 stable_id(path) 逐节点相等（零冲突实证）。"""
    for key in CLC_TOP_ORDER:
        for _, node in _walk(expand(key)["l1"][0]):
            assert node["stable_id"] == stable_id(node["path"]), node["path"]


def test_stable_id_no_drift_on_sibling_ops():
    """负例核心：增 L3 兄弟+删 L3 兄弟+增 L2 兄弟+删 L2 兄弟+重排兄弟，幸存 ID 逐字节不变。"""
    tree = expand("T")
    snap = {n["path"]: n["stable_id"] for _, n in _walk(tree["l1"][0])}
    mut = copy.deepcopy(tree)
    root = mut["l1"][0]
    by_dir = {g["dir"]: g for g in root["l2"]}
    # 删 L3 兄弟（TU 组首槽位）
    removed_leaf = by_dir["TU"]["l3"].pop(0)
    # 增 L3 兄弟（TV 组尾插新槽位节点）
    new_leaf = copy.deepcopy(by_dir["TV"]["l3"][0])
    new_leaf["dir"] = new_leaf["name"] = "新增槽位测试"
    new_leaf["path"] = by_dir["TV"]["path"] + "新增槽位测试/"
    by_dir["TV"]["l3"].append(new_leaf)
    # 增 L2 兄弟（尾插补组节点）
    new_grp = copy.deepcopy(root["l2"][0])
    new_grp["dir"] = "TZ补组"; new_grp["path"] = "T/TZ补组/"
    new_grp.pop("l3", None)
    root["l2"].append(new_grp)
    # 删 L2 兄弟（TP 整组）
    tp = root["l2"].pop(root["l2"].index(by_dir["TP"]))
    # 重排兄弟（TM 组槽位逆序）
    by_dir["TM"]["l3"].reverse()
    refresh_ids(mut)
    new_map = {n["path"]: n["stable_id"] for _, n in _walk(root)}
    # 被删 TP 整组的路径（组+l3 槽位，树深恒 3 级故直接枚举）
    removed_paths = {tp["path"]} | {leaf["path"] for leaf in tp["l3"]}
    survivors = set(snap) - {removed_leaf["path"]} - removed_paths
    for path in survivors:
        assert new_map[path] == snap[path], f"兄弟增删重排后漂移: {path}"
    assert new_map[new_leaf["path"]] not in set(snap.values())  # 新节点 ID 不复用旧值
    # 幸存者含被逆序重排的 TM 全部槽位（重排不漂移）
    for _, n in _walk(by_dir["TM"]):
        assert new_map[n["path"]] == snap[n["path"]]


def test_refresh_ids_idempotent_on_untouched_tree():
    """未动树重复 refresh 不改任何 ID（幂等）。"""
    tree = expand("F")
    before = {n["path"]: n["stable_id"] for _, n in _walk(tree["l1"][0])}
    refresh_ids(tree); refresh_ids(tree)
    after = {n["path"]: n["stable_id"] for _, n in _walk(tree["l1"][0])}
    assert before == after


def test_duplicate_sibling_collision_ordinal():
    """同父内容哈希冲突（槽位重名）按兄弟序 -k 消歧：仅波及冲突者，首者无后缀。"""
    mini = {"ZZ": {"name": "测试域", "groups": [
        {"code": "ZZ1", "name": "组一", "template": "{slot}", "slots": ["甲", "甲", "乙"],
         "share": 1},
    ]}}
    root = expand("zz", schema=mini)["l1"][0]
    ids = [leaf["stable_id"] for leaf in root["l2"][0]["l3"]]
    base = stable_id("ZZ/ZZ1/甲")
    assert (ids[0], ids[1]) == (base, base + "-2") and not ids[2].endswith("-2")
    assert expand("zz", schema=mini) == expand("zz", schema=mini)  # 消歧亦确定性


# ── 4. 深度硬控 ──────────────────────────────────────────────────────────────

def test_depth_hard_capped_at_three():
    """默认/显式 3/越界 99 全同形=3 级；逐档收窄 1/2；非整数深度钳边界。"""
    for md in (None, 3, 99):
        root = expand("T", max_depth=md)["l1"][0]
        assert _tree_depth(root) == 3, f"max_depth={md} 越三级硬控"
        assert all("l4" not in n for _, n in _walk(root))
    only_root = expand("T", max_depth=1)["l1"][0]
    assert "l2" not in only_root and _tree_depth(only_root) == 1
    two = expand("T", max_depth=2)["l1"][0]
    assert _tree_depth(two) == 2 and all("l3" not in g for g in two["l2"])
    assert _tree_depth(expand("T", max_depth=0)["l1"][0]) == 1  # 越下界钳回 1
    assert _tree_depth(expand("T", max_depth=-5)["l1"][0]) == 1


# ── 5. 与 clc_layer 互补不冲突 ────────────────────────────────────────────────

def test_complement_with_clc_layer_keys_distinguishable():
    """互补实证：mode 互斥；dendron 节点必有 origin/stable_id（clc 永无），
    clc 节点必有 clc_level（dendron 永无）——输出键可区分，合并侧零歧义。"""
    clc_node = clc_layer.CLCLayer._node(
        "TV", {"name": "水利工程", "level": 1}, parent_path="", source="s")
    d_tree = expand("T")
    assert d_tree["mode"] == "dendron_expand" != "clc_expand"
    for _, node in _walk(d_tree["l1"][0]):
        assert {"stable_id", "origin", "ratio"} <= set(node)
        assert "stable_id" not in clc_node and "origin" not in clc_node
        assert "clc_level" not in node and "clc_level" in clc_node
    if clc_layer._get_data() is not None:  # 真实层在位时再对真树互斥一次
        assert clc_layer.clc_expand("T")["mode"] != d_tree["mode"]
        for _, n in _walk(clc_layer.clc_expand("T")["l1"][0]):
            assert "stable_id" not in n


# ── 6. 确定性与 fail-soft ────────────────────────────────────────────────────

def test_determinism_and_input_normalization():
    """同输入两次输出全等；类号大小写/空白容忍；自定义 schema 可复用。"""
    assert expand("T") == expand("T")
    assert expand(" t ") == expand("T")
    mini = {"YY": {"name": "自定义", "groups": [
        {"code": "YY1", "name": "甲组", "template": "{slot}实务", "slots": ["尽调", "合规"],
         "share": 1}]}}
    root = expand("yy", schema=mini)["l1"][0]
    assert [leaf["name"] for leaf in root["l2"][0]["l3"]] == ["尽调实务", "合规实务"]
    assert root["l2"][0]["ratio"] == 1.0


def test_invalid_key_fail_soft_returns_none():
    """库外类号/二级类号/空/非字符串 → None 不抛（与 clc_expand 同口径）。"""
    for bad in ("TV", "XX99", "", "   ", None, 123, ["T"]):
        assert expand(bad) is None


def test_schema_stats_counts():
    """规模盘点由 SCHEMA_22 实数得出（零手填）：183 组/8 补组/四类以外零补组。"""
    stats = schema_stats()
    manual_groups = [g for spec in SCHEMA_22.values() for g in spec["groups"]]
    assert stats["classes"] == 22 and stats["groups"] == len(manual_groups) == 183
    assert stats["slots"] == sum(len(g["slots"]) for g in manual_groups)
    assert stats["authored_groups"] == 8 and stats["aligned_groups"] == 183 - 8
    assert {k for k, s in SCHEMA_22.items()
            if any(not g["code"] for g in s["groups"])} == AUTHORED_OK


# ── 7. 纯 stdlib 实证（-I 子进程隔离 site，直接按文件路径载入） ─────────────────

def test_stdlib_only_subprocess_isolated():
    """-I 子进程剥离用户 site（真零第三方依赖）：展开 'T' 正常输出，rc=0。"""
    loader = (
        "import importlib.util;"
        f"spec = importlib.util.spec_from_file_location('dendron', r'{(KB_FACTORY / 'catalog_engine' / 'dendron.py')}');"
        "m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m);"
        "t = m.expand('T'); print(t['mode'], len(t['l1'][0]['l2']))"
    )
    proc = subprocess.run([sys.executable, "-I", "-X", "utf8", "-c", loader],
                          capture_output=True, text=True, encoding="utf-8", timeout=120)
    assert proc.returncode == 0, proc.stderr
    assert proc.stdout.strip() == "dendron_expand 12"
