# -*- coding: utf-8 -*-
"""check_taxonomy —— 种子分类法校验器（KB-FACTORY v2.7 #6，Shopify 制式迁移配套）。

校验对象：seeds/taxonomy/*.yaml 全量（新制式「垂直域三件套」库；每件
tree(层级)+attributes(属性字典)+values(受控词表)+顶层 version/sources）。

五律（全库 0 错才算过，任何一律命中即 error）：
  R1 孤儿节点   —— 子节点必须是带 id/name 的完整节点且挂在树上；
                   节点若带 parent_id（扁平制式）必须在本文件节点集内可解析。
  R2 重复ID     —— 同文件内节点 id 不得重复；跨文件全局 id 亦不得重复
                   （id 是全局寻址键，撞名即隐患）。
  R3 深度越限   —— 树深 > 3 即越限（根=1；根→库→分组 正好三级，硬顶）。
  R4 命名规范   —— id 禁空格/非法字符（须匹配声明 pattern，缺省
                   ^[A-Za-z][A-Za-z0-9_-]*$）；name/受控词表值非空、无首尾
                   空白、无制表/换行控制符；values 词表键 ^[a-z][a-z0-9_]*$。
  R5 受控词表外引用 —— attributes 声明 vocab/vocab_ref 的属性，节点实值
                   必须逐个落在词表内；vocab 指向的词表必须真实存在
                   （vocab_ref 支持 "文件名:values.词表键" 跨件解析）。

属性字典（attributes）为活法：每个节点带 type，validator 按
attributes[type] 的声明逐项校验（required/pattern/type/min/vocab/vocab_ref），
字典不写就不查——立法与执法同源，不搞两本账。

CLI：
  python seeds/taxonomy/check_taxonomy.py            # 人读汇总（rc=0 全绿）
  python seeds/taxonomy/check_taxonomy.py --json     # 机读 {"files","errors","detail"}
  python seeds/taxonomy/check_taxonomy.py --dir <目录>  # 校验其他 taxonomy 目录

收口波接线说明（本任务不接线，只留口）：
  1) 引擎门禁位：engine.py S-1 前调 validate_library()（或 subprocess 跑本 CLI），
     errors 非空即 raise/拒产蓝图——挂法同 security_gate 三态门，一次 import 即成；
  2) CI 位：pytest 已有 test_check_taxonomy.py::test_real_library_zero_errors
     兜底（校验器跑真库 0 错是测试断言，不是口头承诺）；CI 直跑 CLI --json 即插即用；
  3) 新垂直域入库（brick/cilin 等后续若采同制式）：落 *.yaml 进本目录即自动纳入
     全库校验（glob 驱动，无需改本件）。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

import yaml  # PyYAML（venv 实装 6.0.3；校验器硬依赖，缺席即如实崩）

# 校验器数据位：本文件所在目录（seeds/taxonomy/）
TAXONOMY_DIR = Path(__file__).resolve().parent

HARD_MAX_DEPTH = 3                      # R3 硬顶：根(1)+两层，>3 即越限
DEFAULT_ID_PATTERN = r"^[A-Za-z][A-Za-z0-9_\-]*$"   # 缺省命名规范（禁空格/CJK/标点）
VOCAB_KEY_PATTERN = r"^[a-z][a-z0-9_]*$"             # values 词表键命名规范
_CONTROL_CHARS = re.compile(r"[\t\r\n]")             # name/词表值禁控制符

# 制式必备顶层件（缺一即格式不合规）
REQUIRED_TOP_KEYS = ("version", "sources", "tree", "attributes", "values")


def _walk(node, depth: int, parent_id, stem: str, errors: list, seen_ids: dict, parent_refs: list):
    """深度优先走树：R1 结构孤儿 / R2 重复ID / R3 深度 / R4 命名 逐节点执法。"""
    if not isinstance(node, dict):
        errors.append(f"R1 orphan: {stem} 深度{depth} 存在非节点项 {node!r}")
        return
    nid = node.get("id")
    if not nid or not node.get("name"):
        errors.append(f"R1 orphan: {stem} 深度{depth} 存在无 id/name 的残缺节点 {node!r}")
        return
    # R2 同文件重复 id
    if nid in seen_ids:
        errors.append(f"R2 dup-id: {stem} 节点 id 重复 {nid}（首见父={seen_ids[nid]}）")
    else:
        seen_ids[nid] = parent_id
    # R1 扁平制式支持：显式 parent_id 先记账，全树收齐后二次解析（嵌套制式不用该键）
    if node.get("parent_id") is not None:
        parent_refs.append((nid, node["parent_id"]))
    # R3 深度越限
    if depth > HARD_MAX_DEPTH:
        errors.append(f"R3 depth: {stem} 节点 {nid} 深度 {depth} > {HARD_MAX_DEPTH}")
    # R4 id 命名（缺省规范 + attributes 声明 pattern 由 validate_doc 复核）
    if not re.match(DEFAULT_ID_PATTERN, str(nid)) or " " in str(nid):
        errors.append(f"R4 naming: {stem} 节点 id 非法 {nid!r}（禁空格/非法字符）")
    # R4 name 洁净
    name = node["name"]
    if not isinstance(name, str) or not name or name != name.strip() or _CONTROL_CHARS.search(name):
        errors.append(f"R4 naming: {stem} 节点 {nid} name 非法 {name!r}（须非空、无首尾空白、无制表换行）")
    for child in node.get("children", []) or []:
        _walk(child, depth + 1, nid, stem, errors, seen_ids, parent_refs)


def _check_attr_value(stem, nid, attr, spec, value, errors):
    """单属性值执法：类型/pattern/min/vocab/vocab_ref（R4/R5 合流处）。"""
    label = f"{stem}#{nid}.{attr}"
    if spec.get("type") == "integer":
        if not isinstance(value, int) or isinstance(value, bool):
            errors.append(f"R4 attr: {label} 应为 integer，实得 {value!r}")
            return
        if "min" in spec and value < spec["min"]:
            errors.append(f"R4 attr: {label}={value} < min={spec['min']}")
    elif spec.get("type") == "number":
        if not isinstance(value, (int, float)) or isinstance(value, bool):
            errors.append(f"R4 attr: {label} 应为 number，实得 {value!r}")
            return
    values = value if isinstance(value, list) else [value]
    if spec.get("type") == "array" and not isinstance(value, list):
        errors.append(f"R4 attr: {label} 应为 array，实得 {value!r}")
        return
    pattern = spec.get("pattern")
    vocab = spec.get("vocab")          # 本件 values 内词表
    vocab_ref = spec.get("vocab_ref")  # 跨件词表 "file.yaml:values.key"
    for v in values:
        if pattern is not None and (not isinstance(v, str) or not re.match(pattern, v)):
            errors.append(f"R4 attr: {label} 值 {v!r} 不匹配声明 pattern {pattern}")
        if vocab is not None and v not in _vocab_cache.get((stem, vocab), []):
            errors.append(f"R5 vocab-out: {label} 值 {v!r} 不在受控词表 values.{vocab}")
        if vocab_ref is not None:
            table = _resolve_vocab_ref(vocab_ref)
            if table is None:
                errors.append(f"R5 vocab-missing: {label} 声明 vocab_ref={vocab_ref} 但词表不存在")
            elif v not in table:
                errors.append(f"R5 vocab-out: {label} 值 {v!r} 不在跨件词表 {vocab_ref}")


# 跨件词表解析缓存：{vocab_ref字符串: list | None}（库级一次装载，validate_doc 前刷新）
_vocab_cache = {}
_ref_cache = {}


def _resolve_vocab_ref(ref: str):
    """解析 "file.yaml:values.key" → 词表 list；文件/词表缺席返回 None（如实）。"""
    if ref in _ref_cache:
        return _ref_cache[ref]
    fname, _, keypath = ref.partition(":")
    result = None
    doc = _library_docs.get(fname)
    if doc is not None and keypath.startswith("values."):
        table = doc.get("values", {}).get(keypath[len("values."):])
        if isinstance(table, list):
            result = table
    _ref_cache[ref] = result
    return result


def _iter_typed(node: dict):
    """产出 (node) 全树节点（含根）。"""
    yield node
    for child in node.get("children", []) or []:
        if isinstance(child, dict):
            yield from _iter_typed(child)


def validate_doc(stem: str, doc: dict) -> list:
    """单件校验：顶层必备件 + 树五律 + attributes 活法 + values 词表规范。"""
    errors: list = []
    # 顶层格式
    for key in REQUIRED_TOP_KEYS:
        if key not in doc:
            errors.append(f"R4 format: {stem} 缺顶层必备件 {key}")
    if errors:                       # 连顶层都不齐，后面无从校起
        return errors
    if not isinstance(doc["version"], str) or not doc["version"].strip():
        errors.append(f"R4 format: {stem} version 非法 {doc['version']!r}")
    if not isinstance(doc["sources"], list) or not doc["sources"]:
        errors.append(f"R4 format: {stem} sources 须为非空 list")
    # R4 values 词表键规范 + 词表值洁净 + 词表内重复
    values = doc.get("values", {})
    if not isinstance(values, dict) or not values:
        errors.append(f"R4 format: {stem} values 须为非空 dict")
    else:
        for key, table in values.items():
            if not re.match(VOCAB_KEY_PATTERN, str(key)):
                errors.append(f"R4 naming: {stem} 词表键非法 {key!r}（须 {VOCAB_KEY_PATTERN}）")
            if not isinstance(table, list) or not table:
                errors.append(f"R4 format: {stem} 词表 values.{key} 须为非空 list")
                continue
            for v in table:
                if not isinstance(v, str) or not v or v != v.strip() or _CONTROL_CHARS.search(v):
                    errors.append(f"R4 naming: {stem} 词表值 values.{key} 非法 {v!r}")
            if len(set(table)) != len(table):
                errors.append(f"R2 dup-vocab: {stem} 词表 values.{key} 存在重复项")
    # 本件词表缓存（R5 vocab 用）
    for key, table in values.items():
        _vocab_cache[(stem, key)] = table if isinstance(table, list) else []
    # 树五律（R1/R2/R3/R4）
    tree = doc["tree"]
    if not isinstance(tree, dict):
        errors.append(f"R4 format: {stem} tree 须为 dict")
        return errors
    seen: dict = {}
    parent_refs: list = []
    _walk(tree, 1, None, stem, errors, seen, parent_refs)
    # R1 二次解析：扁平 parent_id 必须落在本文件节点集内（全树收齐后判，防前向引用误报）
    for nid, pid in parent_refs:
        if pid not in seen:
            errors.append(f"R1 orphan: {stem} 节点 {nid} 的 parent_id={pid!r} 无法解析（孤儿）")
    # attributes 活法：按节点 type 逐项执法（required/pattern/type/min/vocab/vocab_ref）
    attributes = doc.get("attributes", {})
    if not isinstance(attributes, dict) or not attributes:
        errors.append(f"R4 format: {stem} attributes 须为非空 dict")
        return errors
    for node in _iter_typed(tree):
        ntype = node.get("type")
        if ntype not in attributes:
            errors.append(f"R4 attr: {stem} 节点 {node.get('id')!r} type={ntype!r} 未立法（attributes 无此键）")
            continue
        spec = attributes[ntype]
        for attr, aspec in spec.items():
            if not isinstance(aspec, dict):
                continue
            if aspec.get("required") and attr not in node:
                errors.append(f"R4 attr-missing: {stem}#{node.get('id')} 缺必备属性 {attr}")
                continue
            if attr in node:
                _check_attr_value(stem, node.get("id"), attr, aspec, node[attr], errors)
    return errors


# 库级文档缓存（validate_library 装载；跨件 vocab_ref 依赖它）
_library_docs: dict = {}


def validate_library(tax_dir=None) -> list:
    """全种子库校验：seeds/taxonomy/*.yaml 逐件五律 + 跨件全局查重/词表引用。

    返回错误清单（空 = 全绿）。确定性：纯读、无时钟、无随机，重复调用结果相等。
    """
    d = Path(tax_dir) if tax_dir is not None else TAXONOMY_DIR
    docs = {}
    for path in sorted(d.glob("*.yaml")):
        try:
            docs[path.name] = yaml.safe_load(path.read_text(encoding="utf-8"))
        except Exception as exc:            # YAML 坏文件如实报错，不吞
            docs[path.name] = {"_load_error": str(exc)}
    # 库级缓存刷新（本函数可重入，先清后填）
    global _library_docs, _vocab_cache, _ref_cache
    _library_docs, _vocab_cache, _ref_cache = docs, {}, {}
    errors: list = []
    for stem, doc in docs.items():
        if "_load_error" in doc:
            errors.append(f"R4 format: {stem} YAML 解析失败: {doc['_load_error']}")
            continue
        errors.extend(validate_doc(stem, doc))
    # R2 跨文件全局 id 查重（id 全局寻址，撞名即隐患）
    global_ids: dict = {}
    for stem, doc in docs.items():
        if "_load_error" in doc or not isinstance(doc.get("tree"), dict):
            continue
        for node in _iter_typed(doc["tree"]):
            nid = node.get("id")
            if nid in global_ids:
                errors.append(f"R2 dup-id-global: {nid} 同时出现于 {global_ids[nid]} 与 {stem}")
            else:
                global_ids[nid] = stem
    return errors


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="种子分类法校验器（五律，全库 0 错才算过）")
    ap.add_argument("--dir", default=str(TAXONOMY_DIR), help="taxonomy 目录（缺省=本件所在目录）")
    ap.add_argument("--json", action="store_true", help="机读 JSON 输出")
    args = ap.parse_args(argv)
    errors = validate_library(args.dir)
    payload = {"files": len(_library_docs), "errors": len(errors), "detail": errors}
    if args.json:
        print(json.dumps(payload, ensure_ascii=False, indent=1))
    else:
        for line in errors:
            print(line)
        print(f"TAXONOMY CHECK: {payload['errors']} errors / {payload['files']} files"
              + ("  [PASS]" if not errors else "  [FAIL]"))
    return 0 if not errors else 1


if __name__ == "__main__":
    sys.exit(main())
