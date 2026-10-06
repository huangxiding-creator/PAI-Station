# -*- coding: utf-8 -*-
"""grade_rules 单测 — 权威度 A/B/C sidecar 判级 (断言链 W1-2).

覆盖: ①渠道规则表 12 渠道落值 ②域名规则表压过渠道默认 (政务/交易所→A,
edu→B) ③占位 URL 不吃域名规则 ④未知渠道保守地板 C ⑤覆盖率恒 100%
⑥不可变 (判级不改原行) ⑦ast 零网络根模块.
"""
from __future__ import annotations

import ast
import copy
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import grade_rules as gr                     # noqa: E402


def _row(engine: str, url: str = "https://w/", cred: str = "media") -> dict:
    return {"dedup_key": f"k-{engine}-{abs(hash(url)) % 99}",
            "engine": engine, "url_norm": url, "chars": 100,
            "credibility": cred, "judge": "valid"}


# ------------------------------------------------ ① 渠道规则表
def test_01_engine_grades():
    assert gr.ENGINE_GRADES["52_官网深挖"][0] == "A"
    assert gr.ENGINE_GRADES["CNKI"][0] == "B"
    assert gr.ENGINE_GRADES["99_v2问答"][0] == "C"
    assert gr.ENGINE_GRADES["35_Manus军团"][0] == "C"
    g = gr.grade_row(_row("52_官网深挖"))
    assert (g["grade"], g["rule"]) == ("A", "engine-official-site")


# ------------------------------------------------ ② 域名规则压过渠道
def test_02_domain_override():
    g = gr.grade_row(_row("20_微信文章", url="https://www.cninfo.com.cn/a.html"))
    assert g["grade"] == "A" and g["rule"] == "domain-official"
    g2 = gr.grade_row(_row("99_v2问答", url="https://court.gov.cn/zxgk"))
    assert g2["grade"] == "A"
    g3 = gr.grade_row(_row("20_微信文章", url="https://www.pku.edu.cn/news"))
    assert g3["grade"] == "B" and g3["rule"] == "domain-academic"


# ------------------------------------------------ ③ 占位 URL 不吃域名规则
def test_03_placeholder_url():
    assert gr.host_of("https://w/") == ""            # 无点 → 非真实域
    g = gr.grade_row(_row("99_v2问答", url="https://w/"))
    assert g["grade"] == "C" and g["host"] == ""


# ------------------------------------------------ ④ 未知渠道保守地板
def test_04_unknown_engine_floor():
    g = gr.grade_row(_row("77_未来新渠道"))
    assert (g["grade"], g["rule"]) == ("C", "default-unknown")


# ------------------------------------------------ ⑤ 覆盖率 100% + 汇总
def test_05_full_coverage_and_summary():
    rows = [_row(e) for e in ["52_官网深挖", "50_官网资料", "own:manual",
                              "CNKI", "60_论文学术", "50_飞书语料",
                              "99_v2问答", "35_Manus军团", "51_ima知识库",
                              "30_秘塔AI", "31_秘塔视频", "20_微信文章"]]
    graded = gr.grade_rows(rows)
    assert len(graded) == 12
    assert all(g["grade"] in ("A", "B", "C") for g in graded)
    s = gr.summarize(graded)
    assert s["rows"] == 12
    assert s["grade_dist"] == {"A": 3, "B": 3, "C": 6}
    assert s["url_real_pct"] == 0.0            # 全占位 URL
    assert "default-unknown" not in s["rule_dist"]   # 12 渠道全已知


# ------------------------------------------------ ⑥ 不可变
def test_06_immutability():
    rows = [_row("CNKI", url="https://x.edu.cn/p")]
    snap = json.dumps(rows, ensure_ascii=False, sort_keys=True)
    gr.grade_rows(rows)
    gr.summarize(gr.grade_rows(rows))
    assert json.dumps(rows, ensure_ascii=False, sort_keys=True) == snap


# ------------------------------------------------ ⑦ run 落 sidecar (tmp 池)
def test_07_run_sidecar():
    tmp = Path(tempfile.mkdtemp(prefix="gr_test_"))
    camp = tmp / "CAMP-X"
    camp.mkdir(parents=True)
    rows = [_row("52_官网深挖"), _row("99_v2问答"),
            _row("20_微信文章", url="https://www.sasac.gov.cn/n")]
    (camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows),
        encoding="utf-8")
    out = gr.run("CAMP-X", tmp)
    assert out["summary"]["rows"] == 3
    assert out["summary"]["grade_dist"] == {"A": 2, "C": 1}
    sc = camp / "grade_map.jsonl"
    assert sc.is_file()
    lines = [json.loads(x) for x in sc.read_text(encoding="utf-8").splitlines()]
    assert len(lines) == 3 and {l["grade"] for l in lines} == {"A", "C"}
    assert (camp / "grade_summary.json").is_file()   # 原 manifest 未被改写
    assert len((camp / "manifest.jsonl").read_text(encoding="utf-8")
               .splitlines()) == 3


# ------------------------------------------------ ⑧ ast 零网络机检
def test_08_ast_no_network():
    for mod in (gr,):
        tree = ast.parse(Path(mod.__file__).read_text(encoding="utf-8"))
        mods = set()
        for n in ast.walk(tree):
            if isinstance(n, ast.Import):
                mods.update(a.name.split(".")[0] for a in n.names)
            elif isinstance(n, ast.ImportFrom) and n.module:
                mods.add(n.module.split(".")[0])
        assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                            "socket"}), f"网络根模块混入: {mods}"


# ------------------------------------------------ ⑨ 名空间前缀路由 (EPC49 系)
def test_09_prefix_routing():
    assert gr.grade_row(_row("wenshu"))["grade"] == "A"
    assert gr.grade_row(_row("official:sibling"))["grade"] == "A"
    assert gr.grade_row(_row("standard:gbstandard"))["grade"] == "A"
    assert gr.grade_row(_row("paper:cnki"))["grade"] == "B"
    assert gr.grade_row(_row("feishu_zhiku"))["grade"] == "B"
    assert gr.grade_row(_row("stock:nb_library"))["grade"] == "C"
    assert gr.grade_row(_row("kb:lark_zhiku_file"))["grade"] == "C"
    assert gr.grade_row(_row("web:websearch_en"))["grade"] == "C"


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
