# -*- coding: utf-8 -*-
"""转介绍 ?ref= 追踪单测 (REQ-036/AC1, T-022) — 测试先行件.

T-018 的 record() 已支持 ref 字段; 本任务在其上建订阅 SKU 骨架 (SUB-ANNUAL-
1999) + 部署验证, 本测三口径:
  1. 带 ref 落库 → 查询 (collect 事件面) ref 维度可见
  2. 不带 ref 落库 → 查询侧为空串 "" (缺省即空, 非缺列/非 None 混入)
  3. 坏 ref 格式 → ValueError 拒绝且账本零写入 (不静默丢弃)
"""
from __future__ import annotations

import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import funnel_query as FQ   # noqa: E402


def _tmp(name: str = "funnel_events.jsonl") -> Path:
    return Path(tempfile.mkdtemp(prefix="ref_test_")) / name


def test_record_with_ref_query_visible():
    p = _tmp()
    ev = FQ.record("SUB-ANNUAL-1999", "selftest", "visit",
                   ref="v3-selftest", path=p)
    assert ev["ref"] == "v3-selftest"
    # 查询侧: collect() 事件面里 ref 维度可见 (REQ-036 转介绍追踪口径)
    r = FQ.collect(sku="SUB-ANNUAL-1999", ledger=p, db_path=p.parent / "no.db")
    assert r["levels"]["visit"] == 1
    hit = [e for e in r["events"] if e["ref"] == "v3-selftest"]
    assert len(hit) == 1
    assert hit[0]["channel"] == "selftest" and hit[0]["level"] == "visit"
    # 账本原行同样带 ref (部署验证走的是同一条链)
    line = json.loads(p.read_text(encoding="utf-8").strip().splitlines()[0])
    assert line["ref"] == "v3-selftest"


def test_record_without_ref_lands_empty_string():
    p = _tmp()
    ev = FQ.record("BID26-FULL", "site", "visit", path=p)        # 不传 ref
    assert ev["ref"] == ""                                       # 落库空串
    ev_none = FQ.record("BID26-FULL", "site", "visit", ref=None, path=p)
    assert ev_none["ref"] == ""                                  # None 同空
    r = FQ.collect(sku="BID26-FULL", ledger=p, db_path=p.parent / "no.db")
    assert r["levels"]["visit"] == 2
    assert all(e["ref"] == "" for e in r["events"])   # 查询侧 null→"" 归一


def test_record_rejects_bad_ref_format_zero_write():
    p = _tmp()
    bad_refs = ["bad ref!",        # 空格+感叹号
                "ref#1",           # # 不在白名单
                "转介绍码",         # 非 ASCII
                "a" * 65,          # 超 64 位
                "?ref=x"]          # 误把参数串当码
    for bad in bad_refs:
        try:
            FQ.record("SUB-ANNUAL-1999", "selftest", "visit", ref=bad, path=p)
            raise AssertionError(f"应拒绝 ref: {bad!r}")
        except ValueError:
            pass
    # 拒绝即零写入: 账本不存在或为空
    assert not p.exists() or p.read_text(encoding="utf-8") == ""
