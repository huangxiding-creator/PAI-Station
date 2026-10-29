# -*- coding: utf-8 -*-
"""check_taxonomy 五律校验器测试（KB-FACTORY v2.7 #6）。

门不是恒真的橡皮图章：每律一条故意坏例夹具（tmp_path 落盘真 YAML 走真加载链），
外加最小良例必须全绿 + 真库全绿两道正例。
"""
import importlib.util
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]          # kb_factory/
TAX = ROOT / "seeds" / "taxonomy"

_spec = importlib.util.spec_from_file_location("check_taxonomy", TAX / "check_taxonomy.py")
ct = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(ct)


def _good_doc():
    """最小良例（五顶层件齐、三级树、词表引用合规）。"""
    return {
        "version": "1.0.0",
        "sources": [{"name": "Shopify/product-taxonomy", "url": "x", "license": "MIT", "role": "蓝本"}],
        "tree": {"type": "root", "id": "demo", "name": "示例域", "children": [
            {"type": "lib", "id": "AA", "name": "甲库", "children": [
                {"type": "grp", "id": "AA-01", "name": "甲组", "slots": 10}]},
        ]},
        "attributes": {
            "root": {"id": {"type": "string", "required": True, "pattern": "^[a-z][a-z0-9_]*$"},
                     "name": {"type": "string", "required": True}},
            "lib": {"id": {"type": "string", "required": True, "pattern": "^[A-Z]{2}$"},
                    "name": {"type": "string", "required": True, "vocab": "lib_names"}},
            "grp": {"id": {"type": "string", "required": True, "pattern": "^[A-Z]{2}-[0-9]{2}$"},
                    "name": {"type": "string", "required": True, "vocab": "grp_names"},
                    "slots": {"type": "integer", "required": True, "min": 0}},
        },
        "values": {"lib_names": ["甲库"], "grp_names": ["甲组"]},
    }


def _write(tmp_path, name, doc):
    import yaml
    (tmp_path / name).write_text(
        yaml.safe_dump(doc, allow_unicode=True, sort_keys=False), encoding="utf-8")


def _run(tmp_path):
    return ct.validate_library(tmp_path)


def test_good_fixture_zero_errors(tmp_path):
    """正例：最小良例全绿（0 错才算门真开）。"""
    _write(tmp_path, "demo.yaml", _good_doc())
    assert _run(tmp_path) == []


def test_r1_orphan_flat_parent_unresolvable(tmp_path):
    """R1 孤儿：扁平 parent_id 指向不存在节点 → 必须报 orphan。"""
    doc = _good_doc()
    doc["tree"]["children"][0]["children"][0]["parent_id"] = "NO-SUCH-NODE"
    _write(tmp_path, "demo.yaml", doc)
    errors = _run(tmp_path)
    assert any(e.startswith("R1 orphan:") for e in errors), errors


def test_r1_malformed_node(tmp_path):
    """R1 残缺节点：children 混入无 id/name 项 → 必须报 orphan。"""
    doc = _good_doc()
    doc["tree"]["children"][0]["children"].append({"slots": 3})
    _write(tmp_path, "demo.yaml", doc)
    errors = _run(tmp_path)
    assert any(e.startswith("R1 orphan:") for e in errors), errors


def test_r2_duplicate_id_within_file(tmp_path):
    """R2 重复ID：同文件撞 id → 必须报 dup-id。"""
    doc = _good_doc()
    doc["tree"]["children"][0]["children"].append(
        {"type": "lib", "id": "AA", "name": "甲库二", "children": []})
    _write(tmp_path, "demo.yaml", doc)
    errors = _run(tmp_path)
    assert any(e.startswith("R2 dup-id:") for e in errors), errors


def test_r2_duplicate_id_across_files(tmp_path):
    """R2 全局撞名：两文件同 id → 必须报 dup-id-global。"""
    _write(tmp_path, "a.yaml", _good_doc())
    doc2 = _good_doc()
    doc2["tree"]["id"] = "demo2"
    doc2["tree"]["name"] = "示例域二"
    doc2["values"] = {"lib_names": ["乙库"], "grp_names": ["乙组"]}
    _write(tmp_path, "b.yaml", doc2)      # 内部 id AA/AA-01 与 a.yaml 全局撞名
    errors = _run(tmp_path)
    assert any(e.startswith("R2 dup-id-global:") for e in errors), errors


def test_r3_depth_over_limit(tmp_path):
    """R3 深度越限：根→库→组→子组=4 级 → 必须报 depth。"""
    doc = _good_doc()
    doc["tree"]["children"][0]["children"][0]["children"] = [
        {"type": "grp", "id": "AA-01-9", "name": "越限子组", "slots": 0}]
    _write(tmp_path, "demo.yaml", doc)
    errors = _run(tmp_path)
    assert any(e.startswith("R3 depth:") for e in errors), errors


def test_r4_naming_space_in_id_and_dirty_name(tmp_path):
    """R4 命名：id 带空格 / name 带首尾空白 → 必须报 naming。"""
    doc = _good_doc()
    doc["tree"]["children"][0]["children"][0]["id"] = "AA 01"
    doc["tree"]["children"][0]["name"] = " 甲库 "
    _write(tmp_path, "demo.yaml", doc)
    errors = _run(tmp_path)
    assert sum(1 for e in errors if e.startswith("R4 naming:")) >= 2, errors


def test_r4_illegal_vocab_key_and_attr_type(tmp_path):
    """R4 词表键非法（大写）+ slots 类型错（字符串）→ 必须报。"""
    doc = _good_doc()
    doc["values"]["LibNames"] = ["甲库"]
    doc["tree"]["children"][0]["children"][0]["slots"] = "ten"
    _write(tmp_path, "demo.yaml", doc)
    errors = _run(tmp_path)
    assert any("词表键非法" in e for e in errors), errors
    assert any(e.startswith("R4 attr:") for e in errors), errors


def test_r5_vocab_out_of_range(tmp_path):
    """R5 词表外引用：组名不在受控词表 → 必须报 vocab-out。"""
    doc = _good_doc()
    doc["tree"]["children"][0]["children"][0]["name"] = "野组"
    _write(tmp_path, "demo.yaml", doc)
    errors = _run(tmp_path)
    assert any(e.startswith("R5 vocab-out:") for e in errors), errors


def test_r5_vocab_ref_cross_file(tmp_path):
    """R5 跨件受控引用：vocab_ref 指向邻件词表——在表内过、出表报、词表缺报 missing。"""
    base = _good_doc()
    _write(tmp_path, "demo.yaml", base)
    ref = _good_doc()
    ref["tree"] = {"type": "root", "id": "lex", "name": "词表域", "children": [
        {"type": "dom", "id": "d1", "name": "域一", "mapped": ["甲组"]}]}
    ref["attributes"] = {"root": {"id": {"type": "string", "required": True,
                                         "pattern": "^[a-z][a-z0-9_]*$"},
                                  "name": {"type": "string", "required": True}},
                         "dom": {"id": {"type": "string", "required": True,
                                        "pattern": "^[a-z0-9_]+$"},
                                 "name": {"type": "string", "required": True},
                                 "mapped": {"type": "array", "required": True,
                                            "vocab_ref": "demo.yaml:values.grp_names"}}}
    ref["values"] = {"dom_names": ["域一"]}
    ref["attributes"]["dom"]["name"]["vocab"] = "dom_names"
    _write(tmp_path, "lex.yaml", ref)
    assert _run(tmp_path) == []                        # 在表内 → 全绿
    ref["tree"]["children"][0]["mapped"] = ["野组"]
    _write(tmp_path, "lex.yaml", ref)
    errors = _run(tmp_path)
    assert any("不在跨件词表" in e for e in errors), errors
    ref["tree"]["children"][0]["mapped"] = ["甲组"]
    ref["attributes"]["dom"]["mapped"]["vocab_ref"] = "ghost.yaml:values.grp_names"
    _write(tmp_path, "lex.yaml", ref)
    errors = _run(tmp_path)
    assert any(e.startswith("R5 vocab-missing:") for e in errors), errors


def test_bad_yaml_file_reported(tmp_path):
    """坏 YAML 文件如实报错不吞（R4 format）。"""
    (tmp_path / "broken.yaml").write_text("tree: [unclosed", encoding="utf-8")
    errors = _run(tmp_path)
    assert any("YAML 解析失败" in e for e in errors), errors


def test_real_library_zero_errors():
    """真库正例：seeds/taxonomy 全库五律 0 错（CI 门位断言）。"""
    errors = ct.validate_library(TAX)
    assert errors == [], f"真库 {len(errors)} 错: {errors[:10]}"
    assert len(ct._library_docs) == 3
