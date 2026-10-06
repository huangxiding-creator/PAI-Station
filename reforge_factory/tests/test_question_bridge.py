# -*- coding: utf-8 -*-
"""question_bridge 单测 — 问题桥: 企业问题入树 + ACH 点火 (断言链 W2-1).

覆盖: ①outline 抽取与硬拒 ②每章问题入树带三腿 EEI (正/反/权威) 且 id 规范
③可证伪性审查 (议论型标记不删) ④hypotheses ≥3 非空 + Heuer 规则随树
⑤framework 输入降级路 (sub_questions 已丢 → 章问题降级 + 警示)
⑥sidecar 落盘 question_tree_v2.json 而 v1 零触碰 ⑦ach_arena 兼容
(v2 树喂 arena 真跑 exit 0) ⑧ast 零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

_TMP = Path(tempfile.mkdtemp(prefix="qb_test_"))
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import question_bridge as QB          # noqa: E402
import ach_arena as AA                               # noqa: E402


def _outline_md() -> str:
    body = {"schema": "manus_outline_v1",
            "report_title": "《测试工程怎么干EPC总承包？》",
            "enterprise": {"full": "测试工程技术有限公司", "short": "测试工程",
                           "industry": "工程", "group": ""},
            "chapters": [
                {"no": 1, "title": "引言", "question": "Q1",
                 "sub_questions": ["测试工程 EPC 中标份额近三年趋势",
                                   "测试工程 EPC 业务的意义与价值探讨"],
                 "target_chars": 10000,
                 "search_terms": {"zh": ["测试工程 中标"], "en": []},
                 "evidence_density": "low", "differentiation": "d"},
                {"no": 2, "title": "生态位之问", "question": "Q2",
                 "sub_questions": ["测试工程 在煤化工 EPC 的头部排名"],
                 "target_chars": 12000,
                 "search_terms": {"zh": ["测试工程 竞争"], "en": []},
                 "evidence_density": "low", "differentiation": "d"}]}
    return "# 目录框架\n\n```json\n" + json.dumps(
        body, ensure_ascii=False, indent=1) + "\n```\n"


_MD = _outline_md()
_OBJ = QB.MOA.extract_outline(_MD)


# ------------------------------------------------ ① 抽取与硬拒
def test_01_extract_and_reject():
    tree, _ = QB.bridge(_OBJ, "T-CAMP", "《测试工程怎么干EPC总承包？》")
    assert tree["stats"]["chapters"] == 2
    try:
        QB.bridge({"schema": "framework_v1"}, "T-CAMP", "x")
        raise AssertionError("schema 非法应硬拒")
    except ValueError:
        pass


# ------------------------------------------------ ② 三腿 EEI + id 规范
def test_02_three_legs_and_ids():
    tree, _ = QB.bridge(_OBJ, "T-CAMP", "《测试工程怎么干EPC总承包？》")
    assert tree["stats"]["subquestions"] == 3        # 2 + 1 条 sub_question
    for sq in tree["subquestions"]:
        assert len(sq["eeis"]) == 3
        stances = [e["stance"] for e in sq["eeis"]]
        assert stances == ["support", "against", "support"]  # 正/反/权威
        assert all(e["id"].startswith(sq["id"] + "E") for e in sq["eeis"])
        assert all(e["queries"] for e in sq["eeis"])
        assert all(e["status"] == "zero" for e in sq["eeis"])
    assert tree["subquestions"][0]["id"] == "M01-001"
    assert tree["subquestions"][2]["dim"] == "生态位之问"


# ------------------------------------------------ ③ 可证伪审查 (标记不删)
def test_03_falsifiable_marked_not_dropped():
    tree, _ = QB.bridge(_OBJ, "T-CAMP", "《测试工程怎么干EPC总承包？》")
    bad = [s for s in tree["subquestions"] if not s["falsifiable"]]
    assert len(bad) == 1                              # "意义与价值探讨" 议论型
    assert "意义" in bad[0]["falsify_note"] or "议论" in bad[0]["falsify_note"]
    assert tree["stats"]["unfalsifiable"] == 1


# ------------------------------------------------ ④ ACH 假设 + Heuer 规则
def test_04_hypotheses_and_heuer_rules():
    tree, _ = QB.bridge(_OBJ, "T-CAMP", "《测试工程怎么干EPC总承包？》")
    assert len(tree["hypotheses"]) >= 3
    assert all(h["status"] == "alive" for h in tree["hypotheses"])
    assert any("扩张" in h["text"] for h in tree["hypotheses"])
    r = tree["ach_rules"]
    assert r["ranking"] == "count-I-only"
    assert r["death"] == "positive-counter-evidence-only"


# ------------------------------------------------ ⑤ framework 降级路
def test_05_framework_fallback():
    fw = {"schema": "framework_v1", "report_title": "《测试工程》",
          "chapters": [
              {"id": "ch01", "title": "企业基本面",
               "description": "测试工程的营收与 EPC 份额数据清单",
               "tier_map": {"T1": ["测试工程技术有限公司", "测试工程"]},
               "search_terms": {"zh": [], "en": []}}]}
    outline = QB.from_framework(fw)
    assert outline["schema"] == "manus_outline_v1"
    assert outline["enterprise"]["full"] == "测试工程技术有限公司"
    tree, warns = QB.bridge(outline, "T-CAMP", "《测试工程》")
    assert tree["stats"]["subquestions"] == 1          # 章问题降级为唯一子问题
    assert any("降级" in w for w in warns)


# ------------------------------------------------ ⑥ sidecar 落盘 + v1 零触碰
def test_06_sidecar_and_v1_untouched():
    pool = _TMP / "pool6"
    md_file = _TMP / "outline6.md"
    md_file.write_text(_MD, encoding="utf-8")
    r = QB.build(md_path=str(md_file), campaign_id="T6", pool_root=pool)
    v2 = pool / "T6" / "question_tree_v2.json"
    assert v2.is_file() and not (pool / "T6" / "question_tree.json").exists()
    t = json.loads(v2.read_text(encoding="utf-8"))
    assert t["campaign"] == "T6"
    assert t["provenance"]["source"] == str(md_file)  # 溯源字段真落


# ------------------------------------------------ ⑦ ach_arena 兼容真跑
def test_07_ach_arena_compatible():
    pool = _TMP / "pool7"
    md_file = _TMP / "outline7.md"
    md_file.write_text(_MD, encoding="utf-8")
    r = QB.build(md_path=str(md_file), campaign_id="T7", pool_root=pool)
    t = r["tree"]
    # arena 吃 question_tree.json 名字 → 拷 v2 内容进 tmp 池
    d = pool / "T7"
    (d / "question_tree.json").write_text(
        json.dumps(t, ensure_ascii=False), encoding="utf-8")
    eei0 = t["subquestions"][0]["eeis"][0]["id"]
    (d / "manifest.jsonl").write_text("\n".join(json.dumps(x, ensure_ascii=False) for x in [
        {"dedup_key": f"a.md#{eei0}", "engine": "52_官网深挖",
         "url_norm": "https://www.sasac.gov.cn/x", "chars": 100,
         "judge": "valid", "tree_node": eei0, "stance": "support"},
        {"dedup_key": f"b.md#{eei0}", "engine": "99_v2问答",
         "url_norm": "https://w/", "chars": 100,
         "judge": "valid", "tree_node": eei0, "stance": "against"}]),
        encoding="utf-8")
    old_root = AA.POOL_ROOT
    AA.POOL_ROOT = pool
    try:
        rc = AA.run("T7", detail=False)
        assert rc == 0                                # v2 树 arena 直接可跑
    finally:
        AA.POOL_ROOT = old_root


# ------------------------------------------------ ⑧ ast 零网络机检
def test_08_ast_no_network():
    tree = ast.parse(Path(QB.__file__).read_text(encoding="utf-8"))
    mods = set()
    for n in ast.walk(tree):
        if isinstance(n, ast.Import):
            mods.update(a.name.split(".")[0] for a in n.names)
        elif isinstance(n, ast.ImportFrom) and n.module:
            mods.add(n.module.split(".")[0])
    assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                        "socket"}), f"网络根模块混入: {mods}"


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
