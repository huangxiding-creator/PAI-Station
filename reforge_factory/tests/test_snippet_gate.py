# -*- coding: utf-8 -*-
"""S2-1 snippet 不入池硬门单测 — 池侧 (ammo_pool.ingest 闸 + 全池审计).

覆盖: ①三规则判定 (engine 自标/SERP 面形/检索 JSON) ②全文件零误杀
③ingest 硬拒=manifest 零行 + snippet_gate.jsonl 留痕 ④合法件照常入池
⑤snippet_audit 全池复查 (验收判据 =0).

跑法: python -X utf8 tests/test_snippet_gate.py   (pytest 兼容)
"""
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as AP                                # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s21_test_"))
AP.POOL_ROOT = _TMP / "ammo_pool"
_CAMP = "TEST-S21"
(AP.POOL_ROOT / _CAMP).mkdir(parents=True)

_FULL_ARTICLE = ("中石化南京工程有限公司在 EPC 总承包领域深耕多年，"
                 "承接了宁波乙烯等多个大型项目。" * 60)   # ~5k 字全文
_SERP_DUMP = ("## Search Results\n"
              + "\n".join(f"### {i}. 某公司EPC项目中标结果{i}\n"
                          f"- **URL**: http://s.example.com/r{i}\n"
                          f"- 摘要: 某公司中标某 EPC 项目, 金额 1.2 亿。"
                          for i in range(1, 6)))


# ------------------------------------------------ ①② 判定三规则 + 零误杀
def test_is_snippet_only_three_rules():
    assert AP.is_snippet_only(_SERP_DUMP) == (True, "serp_shape")
    assert AP.is_snippet_only("", "zh:搜索清单") == (True, "engine_marked")
    assert AP.is_snippet_only("", "metaso-serp") == (True, "engine_marked")
    assert AP.is_snippet_only('{"hits": {"baidu": []}}') == (
        True, "search_json_dump")
    ok, rule = AP.is_snippet_only(_FULL_ARTICLE, "own:web")
    assert ok is False                               # 全文零误杀
    assert AP.is_snippet_only("短文", "own:manual") == (False, "")


# ------------------------------------------------ ③④ ingest 硬门
def test_ingest_gate_blocks_and_logs():
    snip = _TMP / "serp.md"
    snip.write_text(_SERP_DUMP, encoding="utf-8")
    rc = AP.ingest(_CAMP, str(snip), "zh-search-pro")
    assert rc == 0
    d = AP.POOL_ROOT / _CAMP
    man = (d / "manifest.jsonl").read_text(encoding="utf-8") if (
        d / "manifest.jsonl").is_file() else ""
    assert man == ""                                  # 入池记录恒 0
    gate = [json.loads(x) for x in
            (d / "snippet_gate.jsonl").read_text(encoding="utf-8")
            .splitlines() if x.strip()]
    assert len(gate) == 1 and gate[0]["rule"] == "serp_shape"
    assert gate[0]["chars"] == len(_SERP_DUMP)
    # 合法全文件照常入池 (pending 不计门槛账)
    full = _TMP / "full.md"
    full.write_text(_FULL_ARTICLE, encoding="utf-8")
    assert AP.ingest(_CAMP, str(full), "own:web") == 0
    rows = [json.loads(x) for x in
            (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    assert len(rows) == 1 and rows[0]["judge"] == "pending"


# ------------------------------------------------ ⑤ 全池审计
def test_snippet_audit_zero_after_gate():
    rep = AP.snippet_audit(_CAMP)
    assert rep[_CAMP]["snippet_rows"] == 0            # 验收判据 =0
    assert rep[_CAMP]["rows"] >= 1                    # 合法件在账
    # 历史污染模拟: 手工塞一行 snippet → 审计照出 (绝不静默)
    d = AP.POOL_ROOT / _CAMP
    with (d / "manifest.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps({"engine": "zh:搜索清单", "text_head": "x"},
                           ensure_ascii=False) + "\n")
    rep2 = AP.snippet_audit(_CAMP)
    assert rep2[_CAMP]["snippet_rows"] == 1
    assert rep2[_CAMP]["rules"] == {"engine_marked": 1}
    # 还原 (只增不删 → 重写去掉模拟行)
    rows = [x for x in (d / "manifest.jsonl").read_text(
        encoding="utf-8").splitlines() if '"zh:搜索清单"' not in x]
    (d / "manifest.jsonl").write_text("\n".join(rows) + "\n",
                                      encoding="utf-8")


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
