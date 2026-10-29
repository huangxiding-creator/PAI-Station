# -*- coding: utf-8 -*-
"""中图法层级访问层测试（v2.6 #3）：五类号机械下钻/深度硬控≤三级/
键族对齐 seeds 分组/pip 包缺席 fail-soft（进程内模拟 + -S 子进程真缺席实证）。

口径：
  - 中间层来自巨人 sheoguo/chinese-library-classification 0.0.1 随包 data.json
    （实测 45785 键，T=247/TV=72/F=67/D=93/G=68 节点——断言取安全下限防包升版抖动）；
  - 「深度≤三级」按输出树深计（根=1），clc_level 是中图法本身的级（TV 下钻到第4级
    类目属正常，输出树深仍为 3）；
  - 机械忠实：数据库无下级的类目（借用类目/仿分如 [TV91]、F49）如实为空叶，不补造；
  - 引擎期键（file_count/files/index_md）访问层不造（数字零造假纪律）；
  - fail-soft 双证：进程内 monkeypatch 模拟缺包返回 None；-S 子进程剥离
    site-packages（真缺席）仍打印 None 且 rc=0，不崩。
"""
import json
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from catalog_engine import clc_layer  # noqa: E402
from catalog_engine.clc_layer import CLCLayer, clc_expand, reset  # noqa: E402

KB_FACTORY = Path(__file__).resolve().parents[2]
SEED_FILE = KB_FACTORY / "seeds" / "05_水利EPC工程.json"  # 六域树键族对齐基准

FIVE_CODES = {  # 类号 → (root 名, 实测节点数下限, l2 组数下限, 抽查 l2 类号)
    "T": ("工业技术", 200, 20, {"TB", "TU", "TV"}),
    "TV": ("水利工程", 50, 12, {"TV1", "TV21", "TV3"}),
    "F": ("经济", 50, 10, {"F0", "F2", "F8"}),
    "D": ("政治、法律", 50, 10, {"D0", "D9", "DF"}),
    "G": ("文化、科学、教育、体育", 50, 6, {"G0", "G4", "G8"}),
}


def _node_count(node, depth=1):
    """输出树节点总数（子层键 l2/l3/… 按层取名）。"""
    children = node.get(f"l{depth + 1}", [])
    return 1 + sum(_node_count(c, depth + 1) for c in children)


def _tree_depth(node, depth=1):
    """输出树深（根=1；无子层键即为叶）。"""
    children = node.get(f"l{depth + 1}", [])
    return max([depth] + [_tree_depth(c, depth + 1) for c in children])


def _walk(node, depth=1):
    """产出 (深度, 节点)。"""
    yield depth, node
    for c in node.get(f"l{depth + 1}", []):
        yield from _walk(c, depth + 1)


def test_expand_five_codes_intermediate_layers():
    """TV/T/F/D/G 五类号：默认深度即出中间层，节点量与抽查类号逐一对上。"""
    for code, (root_name, min_nodes, min_l2, must_have) in FIVE_CODES.items():
        tree = clc_expand(code)
        assert tree is not None, f"{code} 下钻不应缺席失败"
        assert tree["mode"] == "clc_expand"
        assert tree["root"] == f"{code} {root_name}"
        group = tree["l1"][0]
        assert group["name"] == root_name
        assert group["dir"] == code and group["path"] == f"{code}/"
        assert len(group["l2"]) >= min_l2, f"{code} 中间层过少: {len(group['l2'])}"
        assert must_have <= {c["code"] for c in group["l2"]}, f"{code} 缺抽查类号"
        assert _node_count(group) >= min_nodes, f"{code} 节点总量不足"
        # 默认深度下钻到第三级：主体 l2 带 l3 中间层；数据库无下级者如实为空叶
        assert any(c.get("l3") for c in group["l2"])


def test_depth_hard_capped_at_three():
    """输出深度硬控≤三级：默认/超大请求同形，max_depth=1/2 逐档收窄。"""
    assert CLCLayer.HARD_MAX_DEPTH == 3
    for code in ("T", "TV"):
        for md in (None, 3, 99):  # 默认、显式 3、越界 99 一律被钳到 3
            tree = clc_expand(code, max_depth=md)
            group = tree["l1"][0]
            assert _tree_depth(group) <= 3, f"{code} max_depth={md} 越过三级硬控"
            assert all("l4" not in n for _, n in _walk(group))
    tv1 = clc_expand("TV", max_depth=1)["l1"][0]
    assert "l2" not in tv1 and _tree_depth(tv1) == 1  # 只出根
    tv2 = clc_expand("TV", max_depth=2)["l1"][0]
    assert _tree_depth(tv2) == 2 and all("l3" not in c for c in tv2["l2"])


def test_node_keys_aligned_with_seed_groups():
    """节点键族与现有种子分组对齐（六域树 l1/l2 组键全覆盖，引擎期键不造）。"""
    seed_tree = json.loads(SEED_FILE.read_text(encoding="utf-8"))["tree"]
    seed_l1_keys = set(seed_tree["l1"][0])
    seed_l2_keys = set(seed_tree["l1"][0]["l2"][0])
    engine_period_keys = {"file_count", "files", "index_md"}  # 引擎渲染期键，访问层不造
    tree = clc_expand("TV")
    for depth, node in _walk(tree["l1"][0]):
        base = seed_l1_keys if depth == 1 else seed_l2_keys
        assert base - engine_period_keys - {"l2"} <= set(node), f"第{depth}层种子组键未覆盖"
        assert {"code", "dir", "path", "name", "theme", "source"} <= set(node)
    # 路径拼接同 seeds 约定：父 path + dir + "/"
    g = tree["l1"][0]
    tv1 = next(c for c in g["l2"] if c["code"] == "TV1")
    assert tv1["path"] == "TV/TV1/"
    leaf = tv1["l3"][0]
    assert leaf["path"] == f"TV/TV1/{leaf['code']}/"
    # source 记巨人溯源，theme 含类名与类号
    assert "chinese-library-classification" in g["source"]
    assert "水利工程" in g["theme"] and "TV" in g["theme"]


def test_mechanical_determinism_and_leaf_faithfulness():
    """纯规则机械生成：同输入两次输出全等；数据库原序保留；空叶如实（不补造）。"""
    assert clc_expand("TV") == clc_expand("TV")
    tv = clc_expand("TV")["l1"][0]["l2"]
    assert tv[0]["code"] == "[TV-9]" and tv[0]["name"] == "水利经济"  # 原序：借用类目打头
    tv1 = next(c for c in tv if c["code"] == "TV1")
    assert tv1["l3"][0]["code"] == "[TV11]"
    tv91 = next(c for c in tv if c["code"] == "[TV91]")
    assert tv91.get("l3", []) == []  # 借用类目无下级，机械如实为空叶
    g = clc_expand("T")["l1"][0]
    assert g["clc_level"] == 1 and all(n["clc_level"] >= g["clc_level"] for _, n in _walk(g))


def test_invalid_code_fail_soft_returns_none():
    """库外类号/空输入 → None，不抛。"""
    for bad in ("XX99", "", "   ", None):
        assert clc_expand(bad) is None


def test_fail_soft_pkg_absent_in_process(monkeypatch):
    """进程内模拟缺包：loader 置 None + reset → 全部 fail-soft 返回 None，恢复不留疤。"""
    monkeypatch.setattr(clc_layer, "_giant_load_all_data", None)
    reset()
    try:
        assert clc_expand("T") is None
        assert CLCLayer().available is False
    finally:
        monkeypatch.undo()
        reset()  # 清掉缺席 error，不污染共享模块级缓存
    assert clc_expand("T") is not None


def test_fail_soft_pkg_absent_subprocess_real_absence():
    """-S 子进程真缺席（site-packages 剥离）：直接按文件路径载入本层，输出 None 且 rc=0。"""
    loader = (
        "import importlib.util;"
        f"spec = importlib.util.spec_from_file_location('clc_layer', r'{(KB_FACTORY / 'catalog_engine' / 'clc_layer.py')}');"
        "m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m);"
        "print(m.clc_expand('T'))"
    )
    proc = subprocess.run(
        [sys.executable, "-S", "-X", "utf8", "-c", loader],
        capture_output=True, text=True, encoding="utf-8", timeout=120)
    assert proc.returncode == 0, proc.stderr  # 不崩
    assert proc.stdout.strip() == "None"      # fail-soft 返回 None
