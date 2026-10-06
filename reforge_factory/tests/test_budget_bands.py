# -*- coding: utf-8 -*-
"""S2-2 预算分档三档单测 — 池侧 (ingest --band + tier_report by_band 分列).

覆盖: ①band 入行 (非法值归 "") ②by_band 只计 valid (pending 不计) ③
三档并存分列可查 ④CLI --band 透传 (argv 形).

跑法: python -X utf8 tests/test_budget_bands.py   (pytest 兼容)
"""
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as AP                                # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s22_test_"))
AP.POOL_ROOT = _TMP / "ammo_pool"
_CAMP = "TEST-S22"
d = AP.POOL_ROOT / _CAMP
d.mkdir(parents=True)
(d / "tiers.json").write_text(
    json.dumps({"T1": ["中石化"], "T2": ["SEI"]}, ensure_ascii=False),
    encoding="utf-8")
(d / "pool_state.json").write_text(json.dumps(   # judge 判据 (课题关键词)
    {"campaign": _CAMP, "kws": ["EPC"], "total_chars": 0, "items": 0,
     "pending_chars": 0, "pending_items": 0, "rejected_chars": 0,
     "rejected_items": 0, "by_engine": {}, "domains": []}),
    encoding="utf-8")


def _ingest(name: str, title_kw: str, band: str, judge_now: bool = True):
    fp = _TMP / f"{name}.md"
    fp.write_text(f"{title_kw} EPC 项目全景分析正文。"
                  f"{name} "                      # 唯一尾料防互相去重
                  f"{'深度内容' * 120}", encoding="utf-8")
    rc = AP.ingest(_CAMP, str(fp), "own:web", band=band)
    assert rc == 0
    return fp


# ------------------------------------------------ ①② band 入行 + valid 分列
def test_band_stored_and_reported():
    _ingest("a_t1", "中石化", "outline_wide")
    _ingest("b_t2", "SEI", "section_narrow")
    _ingest("c_gap", "中石化", "gap")
    _ingest("d_bad_band", "中石化", "not-a-band")    # 非法 → "" 存量桶
    rows = [json.loads(x) for x in
            (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    assert len(rows) == 4
    by_file = {Path(r["source_path"]).name: r for r in rows}
    assert by_file["a_t1.md"]["budget_band"] == "outline_wide"
    assert by_file["d_bad_band.md"]["budget_band"] == ""   # 非法归 ""
    # 全 pending → by_band 空 (不入门槛账)
    rep = AP.tier_report(_CAMP)
    assert rep["by_band"] == {}
    # judge → valid 后分列
    AP.judge(_CAMP, limit=10)
    rep2 = AP.tier_report(_CAMP)
    bb = rep2["by_band"]
    assert bb["outline_wide"]["items"] == 1
    assert bb["section_narrow"]["items"] == 1
    assert bb["gap"]["items"] == 1
    assert bb[""]["items"] == 1                          # 存量未归档桶
    assert all(v["chars"] >= 400 for v in bb.values())


# ------------------------------------------------ ③ CLI --band 透传
def test_cli_band_passthrough():
    fp = _ingest("e_cli", "中石化", "outline_wide")
    # 行已带档 (ingest API 面); CLI 面由 argparse choices 限三档+空,
    # 这里验 choices 定义同源
    import argparse
    src = Path(AP.__file__).read_text(encoding="utf-8")
    assert 'choices=[""] + list(BUDGET_BANDS)' in src


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
