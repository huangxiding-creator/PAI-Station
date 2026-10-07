# -*- coding: utf-8 -*-
"""promo_guard 单测 — 七门守门器 (F5b).

验收 (设计 first_slice): 同一文两次推 → 第二次必拒.
"""
from __future__ import annotations

import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "promo"))
import promo_guard as PG   # noqa: E402


def _md(title: str = "测试标题", body_len: int = 2200) -> str:
    body = "深度拆解" * (body_len // 4 + 1)
    return f"# {title}\n这是摘要句, 非空。\n\n{body}\n"


def _html(n: int = 5000) -> str:
    return "<p>x</p>" * (n // 7 + 1)


def _tmp_ledger() -> Path:
    return Path(tempfile.mkdtemp(prefix="pg_test_")) / "ledger.jsonl"


def test_gate1_title_24h_dedup():
    """同一文两次推 → 第二次必拒 (设计验收判据)."""
    lg = _tmp_ledger()
    md, html = _md(), _html()
    ok1, r1 = PG.check(md, html, "测试标题", "总包之声", "R50", ledger=lg)
    assert ok1, r1
    PG.record("测试标题", "总包之声", "R50", "gzh-zbzs", ledger=lg)
    ok2, r2 = PG.check(md, html, "测试标题", "总包说", "R50", ledger=lg)
    assert not ok2 and any("①" in x for x in r2), r2


def test_gate2_sku_cooldown_7d():
    lg = _tmp_ledger()
    PG.record("甲标题", "总包之声", "ENT-05", "gzh-zbzs", ledger=lg)
    ok, r = PG.check(_md("乙标题"), _html(), "乙标题", "总包说",
                     "ENT-05", ledger=lg)
    assert not ok and any("②" in x for x in r), r
    # 换 SKU 不受冷却影响
    ok2, r2 = PG.check(_md("乙标题"), _html(), "乙标题", "总包说",
                       "ENT-06", ledger=lg)
    assert ok2, r2


def test_gate3_daily_cap():
    lg = _tmp_ledger()
    PG.record("题一", "工程行业大脑", "T1", "gzh-dt", ledger=lg)
    ok, r = PG.check(_md("题二"), _html(), "题二", "工程行业大脑",
                     "T2", ledger=lg)
    assert not ok and any("③" in x for x in r), r    # 大脑日帽=1
    # 总包之声日帽=2, 第一条不受限
    ok2, _ = PG.check(_md("题三"), _html(), "题三", "总包之声",
                      "T3", ledger=lg)
    assert ok2


def test_gate4_digest_empty_line2():
    md = "# 题\n\n正文" + "字" * 2200
    ok, r = PG.check(md, _html(), "题", "总包之声", "", ledger=_tmp_ledger())
    assert not ok and any("④" in x for x in r), r


def test_gate5_body_too_short():
    ok, r = PG.check(_md(body_len=800), _html(), "测试标题", "总包之声",
                     "", ledger=_tmp_ledger())
    assert not ok and any("⑤" in x for x in r), r


def test_gate6_html_over_limit():
    ok, r = PG.check(_md(), _html(25000), "测试标题", "总包之声",
                     "", ledger=_tmp_ledger())
    assert not ok and any("⑥" in x for x in r), r


def test_gate7_title_over_64_bytes():
    long_title = "超长标题" * 20        # 80 汉字 = 240B
    ok, r = PG.check(_md(long_title), _html(), long_title, "总包之声",
                     "", ledger=_tmp_ledger())
    assert not ok and any("⑦" in x and "64" in x for x in r), r


def test_ledger_corrupt_line_skipped():
    lg = _tmp_ledger()
    lg.write_text("not-json{{{\n", encoding="utf-8")
    ok, r = PG.check(_md(), _html(), "测试标题", "总包之声", "", ledger=lg)
    assert ok, r


def test_record_appends_jsonl():
    lg = _tmp_ledger()
    PG.record("题", "总包说", "S1", "gzh-zbshuo", "m1", ledger=lg)
    PG.record("题2", "总包说", "S2", "gzh-zbshuo", "m2", ledger=lg)
    lines = [ln for ln in lg.read_text(encoding="utf-8").splitlines() if ln]
    assert len(lines) == 2
    import json
    row = json.loads(lines[0])
    assert row["title_hash"] == PG.title_hash("题")
    assert row["src"] == "gzh-zbshuo" and row["media_id"] == "m1"


def test_gate8_state_db_and_sku_history(monkeypatch):
    """⑧ state.db 金标准对照 + ⑧b 同号同SKU全历史禁重投."""
    import promo_guard as PG2
    lg = _tmp_ledger()
    # ⑧b: 同号同SKU历史一次即拒
    PG2.record("旧题", "总包说", "ENT-05", "gzh-zbshuo", ledger=lg)
    ok, r = PG2.check(_md("全新标题"), _html(), "全新标题", "总包说",
                      "ENT-05", ledger=lg)
    assert not ok and any("⑧同号SKU已投" in x for x in r), r
    # 换号不受 ⑧b 限制 (受 ② 7天冷却, 但 sku 冷却只在7天内 — 用旧时间戳绕开)
    import json as _j
    lines = lg.read_text(encoding="utf-8").splitlines()
    row = _j.loads(lines[0]); row["ts_epoch"] = 0; row["date"] = "2026-01-01"
    lines[0] = _j.dumps(row, ensure_ascii=False)
    lg.write_text("\n".join(lines) + "\n", encoding="utf-8")
    ok2, r2 = PG2.check(_md("另一新标题"), _html(), "另一新标题", "总包之声",
                        "ENT-05", ledger=lg)
    assert ok2, r2
    # ⑧ state.db: monkeypatch 假金标准命中
    monkeypatch.setattr(PG2, "_state_db_titles",
                        lambda: [("总包之声", "金标准已发标题")])
    ok3, r3 = PG2.check(_md("金标准已发标题"), _html(), "金标准已发标题",
                        "总包之声", "", ledger=_tmp_ledger())
    assert not ok3 and any("⑧撞已发金标准" in x for x in r3), r3
    # 归一化: 尾部问号变体也命中 (R83 教训)
    ok4, r4 = PG2.check(_md("金标准已发标题？"), _html(), "金标准已发标题？",
                        "总包之声", "", ledger=_tmp_ledger())
    assert not ok4 and any("⑧撞已发金标准" in x for x in r4), r4
