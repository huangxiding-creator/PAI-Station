# -*- coding: utf-8 -*-
"""task_ledger 单测 — 断言账本: 引用句 100% 落账 + 第四触发位 (断言链 W3-1).

覆盖: ①文档登记表 (valid 过滤/文档级最优等级/确定性短号) ②断言抽取
(标记语法 refs+@EEI/分句/表格标题行跳过) ③类型启发式 ④独立性 join
(同 engine 并簇=同源复读/三键异=独立多源/幽灵引用=未确证) ⑤GRADE 旗标
与 T0 门 ⑥第四触发位 (单源/未确证 100% 进 gap + 指纹去重) ⑦战役 sidecar
三件落盘且 manifest 零改动 ⑧不可变 ⑨ast 零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import task_ledger as TL               # noqa: E402


def _row(doc: str, node: str, engine: str, grade_key: str = "",
         judge: str = "valid", stance: str = "support",
         url: str = "https://w/") -> dict:
    return {"dedup_key": f"{doc}#{node}", "engine": engine,
            "source_path": f"E:/pool/{doc}.md", "url_norm": url,
            "chars": 100, "judge": judge, "tree_node": node,
            "stance": stance, "_gk": grade_key}


def _graded(rows: list[dict], **overrides: str) -> dict[str, str]:
    """rows → dedup_key→等级 map (_gk 字段, 缺省 C)."""
    out = {str(r["dedup_key"]): r.get("_gk") or "C" for r in rows}
    out.update(overrides)
    return out


_ROWS = [
    _row("a.md", "E1", "51_ima知识库", "A",
         url="https://www.sasac.gov.cn/x"),
    _row("b.md", "E1", "99_v2问答", "B",
         url="https://w/", stance="against"),
    _row("c.md", "E1", "51_ima知识库", "C",
         url="https://site-c.cn/z"),
    _row("bad.md", "E1", "20_微信文章", judge="rejected"),
]


# ------------------------------------------------ ① 文档登记表
def test_01_registry():
    reg = TL.build_registry(_ROWS, _graded(_ROWS))
    assert [d["id"] for d in reg] == ["D0001", "D0002", "D0003"]  # a,b,c
    by = TL.registry_rows_by_id(reg)
    assert by["D0001"]["grade"] == "A"
    assert by["D0002"]["engines"] == ["99_v2问答"]
    assert by["D0003"]["host"] == "site-c.cn"
    assert all(d["doc_base"] != "bad.md" for d in reg)      # rejected 不入


# ------------------------------------------------ ② 断言抽取
def test_02_extract_claims():
    md = ("# 第一章 标题行不该入账\n"
          "| 表格 | 行 |\n"
          "公司 2025 年营收 100 亿元，创历史新高[[S:D0001,D0002@E1]]。"
          "这是第二句没有标记不落账。管理层认为增速将持续[[S:D0003]]；"
          "幽灵引用句[[S:D9999]]。\n")
    claims = TL.extract_claims(md)
    assert [c["claim_id"] for c in claims] == ["C0001", "C0002", "C0003"]
    assert claims[0]["refs"] == ["D0001", "D0002"]
    assert claims[0]["eeis"] == ["E1"]
    assert claims[0]["key_sentence"] is True               # 100 亿元
    assert claims[1]["refs"] == ["D0003"]


# ------------------------------------------------ ③ 类型启发式
def test_03_claim_type():
    assert TL.claim_type("预计 2027 年营收将达 200 亿元") == "预测"
    assert TL.claim_type("笔者认为该模式不可持续") == "观点"
    assert TL.claim_type("公司 2024 年中标 12 个项目") == "事实"
    assert TL.is_t0("签约合同额 50 亿元") is True
    assert TL.is_t0("公司称「技术领先」") is True           # 直接引语
    assert TL.is_t0("该业务增长较快") is False


# ------------------------------------------------ ④ 独立性 join
def test_04_independence_join():
    reg = TL.build_registry(_ROWS, _graded(_ROWS))
    by = TL.registry_rows_by_id(reg)
    j = TL.judge_claim({"claim_id": "C0001", "断言": "营收 100 亿元",
                        "refs": ["D0001", "D0002"], "eeis": ["E1"],
                        "key_sentence": True}, by, {"E1": ["https://x/anti"]})
    assert j["验证态"] == "双独立源确证"                    # engine/host/doc 全异
    assert j["独立性类别"] == "独立多源"
    assert j["独立源数"] == 2
    assert j["反证urls"] == ["https://x/anti"]              # against 行回填
    mono = TL.judge_claim({"claim_id": "C0002", "断言": "营收 100 亿元",
                           "refs": ["D0001", "D0003"], "eeis": [],
                           "key_sentence": True}, by, {})   # 同 ima 渠道
    assert mono["验证态"] == "单源"
    assert mono["独立性类别"] == "同源复读"                  # 多文档 1 簇
    ghost = TL.judge_claim({"claim_id": "C0003", "断言": "增长较快",
                            "refs": ["D9999"], "eeis": [],
                            "key_sentence": False}, by, {})
    assert ghost["验证态"] == "未确证"
    assert ghost["幽灵引用"] == ["D9999"]


# ------------------------------------------------ ⑤ GRADE 旗标 + T0 门
def test_05_grade_flags_and_t0():
    reg = TL.build_registry(_ROWS, _graded(_ROWS))
    by = TL.registry_rows_by_id(reg)
    t0_bad = TL.judge_claim({"claim_id": "C1", "断言": "营收 100 亿元",
                             "refs": ["D0003"], "eeis": [],
                             "key_sentence": True}, by, {})
    assert "T0门阻塞" in t0_bad["降级旗标"]                 # 单源 C 级 T0
    assert t0_bad["确定性"] == "极低"                        # C(1)-1-1 → 1
    t0_ok = TL.judge_claim({"claim_id": "C2", "断言": "营收 100 亿元",
                            "refs": ["D0001", "D0002"], "eeis": [],
                            "key_sentence": True}, by, {})
    assert "T0门阻塞" not in t0_ok["降级旗标"]
    assert t0_ok["确定性"] == "高"                           # A(3)+1 → 4
    assert "双独立且含A/B级" in t0_ok["降级旗标"]


# ------------------------------------------------ ⑥ 第四触发位
def test_06_gap_tickets_and_dedup():
    reg = TL.build_registry(_ROWS, _graded(_ROWS))
    by = TL.registry_rows_by_id(reg)
    judged = [
        TL.judge_claim({"claim_id": "C1", "断言": "营收 100 亿元",
                        "refs": ["D0003"], "eeis": [], "key_sentence": True},
                       by, {}),
        TL.judge_claim({"claim_id": "C2", "断言": "双源句",
                        "refs": ["D0001", "D0002"], "eeis": [],
                        "key_sentence": False}, by, {}),
        TL.judge_claim({"claim_id": "C3", "断言": "幽灵句",
                        "refs": ["D9999"], "eeis": [],
                        "key_sentence": False}, by, {}),
    ]
    tickets = TL.gap_tickets(judged)
    assert [t["claim_id"] for t in tickets] == ["C1", "C3"]  # 单源+零源 100%
    assert tickets[0]["trigger"] == "单源断言"
    assert tickets[1]["trigger"] == "零源断言"
    tmp = Path(tempfile.mkdtemp(prefix="tl_test_")) / "gap_tickets.jsonl"
    assert TL.append_gap_tickets(tmp, tickets) == 2
    assert TL.append_gap_tickets(tmp, tickets) == 0          # 指纹去重
    assert len(tmp.read_text(encoding="utf-8").splitlines()) == 2


# ------------------------------------------------ ⑦ 战役 sidecar
def test_07_campaign_sidecar():
    tmp = Path(tempfile.mkdtemp(prefix="tl_test_"))
    camp = tmp / "CAMP-L"
    camp.mkdir(parents=True)
    (camp / "manifest.jsonl").write_text("\n".join(
        json.dumps({k: v for k, v in r.items() if k != "_gk"},
                   ensure_ascii=False) for r in _ROWS), encoding="utf-8")
    (camp / "grade_map.jsonl").write_text("\n".join(json.dumps(
        {"dedup_key": r["dedup_key"], "grade": r.get("_gk") or "C"},
        ensure_ascii=False) for r in _ROWS), encoding="utf-8")
    draft = tmp / "draft.md"
    draft.write_text("营收 100 亿元创新高[[S:D0001,D0002]]。"
                     "单源句 30 亿元[[S:D0003]]。幽灵[[S:D8888]]。\n",
                     encoding="utf-8")
    r = TL.audit_campaign(draft, "CAMP-L", tmp)
    assert (camp / "claim_ledger.json").is_file()
    assert (camp / "doc_registry.json").is_file()
    assert (camp / "gap_tickets.jsonl").is_file()
    s = r["stats"]
    assert s["claims"] == 3
    assert s["by_state"] == {"双独立源确证": 1, "单源": 1, "未确证": 1}
    assert s["citation_precision"] == round(3 / 4, 4)        # 4 引用 3 落账
    assert s["gates"]["precision_pass"] is False             # 0.75 < 0.9
    assert r["gap_added"] == 2
    # 原账零改动
    assert len((camp / "manifest.jsonl").read_text(
        encoding="utf-8").splitlines()) == 4
    # 幂等重跑 gap 不重复
    r2 = TL.audit_campaign(draft, "CAMP-L", tmp)
    assert r2["gap_added"] == 0


# ------------------------------------------------ ⑧ 不可变
def test_08_immutability():
    rows_snap = json.dumps(_ROWS, ensure_ascii=False, sort_keys=True)
    graded = _graded(_ROWS)
    TL.build_registry(_ROWS, graded)
    TL.audit_draft("句[[S:D0001]]", _ROWS, graded, {})
    assert json.dumps(_ROWS, ensure_ascii=False, sort_keys=True) == rows_snap


# ------------------------------------------------ ⑨ ast 零网络机检
def test_09_ast_no_network():
    tree = ast.parse(Path(TL.__file__).read_text(encoding="utf-8"))
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
