# -*- coding: utf-8 -*-
"""进库钩子单测（T-P0-01）：catalog/chapters→库 upsert 幂等/slug 主键/价格原样搬运。"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402

from xueyuan_engine import store  # noqa: E402


def _rows(rid):
    with store._db() as c:
        return [dict(r) for r in c.execute(
            "SELECT * FROM chapters WHERE report_id=? ORDER BY idx", (rid,)).fetchall()]


def test_sync_upserts_reports_and_chapters(engine):
    with store._db() as c:
        row = dict(c.execute("SELECT * FROM reports WHERE id=?", (PILOT,)).fetchone())
    assert row["price_fen"] == 990          # 价格取 catalog 值原样入库（治理归 A 线）
    assert row["province"] == "江苏"
    assert row["chapter_count"] == 6
    assert json.loads(row["tags"]) == ["水网", "江苏"]
    chs = _rows(PILOT)
    assert len(chs) >= 5 and any(ch["id"] == f"{PILOT}/ch01" for ch in chs)  # slug 主键
    assert chs[0]["is_trial"] == 1 and chs[2]["is_trial"] == 0  # 默认前 2 章试读
    assert chs[0]["html"].startswith("<h1>")                    # 试读章带正文
    assert chs[2]["html"].startswith("<h1>")                    # 付费正文来自全集覆盖
    assert chs[2]["char_count"] > 0


def test_sync_idempotent(engine):
    before = _rows(engine.pilot)
    stat = store.sync_from_catalog(engine.pkg, engine.full)
    assert stat["reports"] >= 1 and stat["chapters"] >= 10      # ≥1 且含试点口径
    assert _rows(engine.pilot) == before                       # 重跑不重复不漂移


def test_sync_full_content_missing_leaves_shells(engine):
    """全集缺席时付费章回退包内形态（A 线切片②产物未到位形态）。

    夹具包内前 3 章自带正文（trial_html_from=3 > trial=2）——空壳判定只针对
    包内本就无正文的付费章；且引擎侧全集文本（"付费正文"标记）不得残留。
    """
    import shutil

    shutil.rmtree(engine.full)
    store.sync_from_catalog(engine.pkg, engine.full)
    chs = _rows(engine.pilot)
    paid = [ch for ch in chs if not ch["is_trial"]]
    assert paid
    assert all("付费正文" not in ch["html"] for ch in chs)      # 全集文本不残留
    assert all(ch["html"] == "" for ch in paid if ch["idx"] > 3)  # 包内空壳保持空壳


def test_sync_cleans_stale_chapters(engine):
    """A 线重切章后残留行清理（幂等镜像）。"""
    with store._db() as c:
        c.execute("INSERT INTO chapters(id,report_id,idx,title,is_trial,html,char_count)"
                  " VALUES(?,?,?,?,?,?,?)",
                  (f"{engine.pilot}/chXX", engine.pilot, 99, "残留章", 0, "", 0))
    store.sync_from_catalog(engine.pkg, engine.full)
    assert all(ch["id"] != f"{engine.pilot}/chXX" for ch in _rows(engine.pilot))


def test_sync_missing_catalog_tolerated(engine, tmp_path):
    """内容区未就位：不炸、零入库（启动腿容错判据）。"""
    stat = store.sync_from_catalog(tmp_path / "empty", tmp_path / "empty2")
    assert stat["reports"] == 0 and "skipped" in stat


def test_off_sidecar_delists_and_relists(engine):
    """运营下架旁挂位（RL 决策③）：off.json 在列=下架（状态+详情屏蔽），移出=幂等复上架。"""
    from xueyuan_engine import catalog

    (engine.pkg / "off.json").write_text(
        json.dumps({"off": [engine.pilot]}), encoding="utf-8")
    assert catalog.apply_off_sidecar(engine.pkg) == 1
    with store._db() as c:
        assert c.execute("SELECT status FROM reports WHERE id=?",
                         (engine.pilot,)).fetchone()[0] == "off"
    assert catalog.get_report(engine.pilot) is None          # 详情随 status 屏蔽

    (engine.pkg / "off.json").unlink()
    assert catalog.apply_off_sidecar(engine.pkg) == 0
    with store._db() as c:
        assert c.execute("SELECT status FROM reports WHERE id=?",
                         (engine.pilot,)).fetchone()[0] == "on"
    assert catalog.get_report(engine.pilot) is not None      # 移出即复上架


def test_off_sidecar_corrupt_treated_as_empty(engine):
    """sidecar 损坏按空处理（全上架），不阻塞 sync（容错判据）。"""
    from xueyuan_engine import catalog

    (engine.pkg / "off.json").write_text("{not json", encoding="utf-8")
    assert catalog.apply_off_sidecar(engine.pkg) == 0
    (engine.pkg / "off.json").unlink()
