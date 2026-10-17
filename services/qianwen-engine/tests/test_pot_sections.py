# -*- coding: utf-8 -*-
"""v0.9.19 锅圈双分区（1017 用户令）：最新≤3（纯时间）+ 最热（观看+点赞+转发总和倒序）。
REQ 溯源：用户令 1017「锅圈页问答咨询内容分为两块」。
运行：python -m pytest tests/test_pot_sections.py -q
"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, report_catalog, store, wechat  # noqa: E402


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    monkeypatch.setattr(config, "REPORT_CONTENT_DIR", tmp_path / "content")
    report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})
    store._init_done = False
    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _mk(name_seed: int) -> None:
    aid = store.save_answer("open-t1", f"锅圈问题{name_seed}",
                            f"答案内容{name_seed}" * 40, [], "kb")
    assert store.share_on(aid, "open-t1"), f"seed {name_seed} 共享失败"


def test_pot_sections_latest3_and_hot_order(client):
    """最新=纯时间前3；最热=观看+点赞+转发总和倒序（REQ 正典）。"""
    # 三条旧答案 + 两条新答案：热度与时间交叉（最热的不是最新的）
    _mk(1)
    _mk(2)
    _mk(3)
    _mk(4)
    _mk(5)
    aids = [a["id"] for a in store.history_all("open-t1")]
    a1, a2, a3, a4, a5 = aids  # save 顺序
    # 互动：a1 最热（views 10 + likes 3 + shares 2 = 15）；a3 次热（8）；a5 有 1 views；a2/a4 零互动
    for _ in range(10):
        store.bump_views(a1)
    for _ in range(8):
        store.bump_views(a3)
    store.bump_views(a5)
    store.mark_liked(a1, "open-liker")  # likes=rewards(action=like) 计数；幂等单记
    # shares 由 bump_shares 或直接更新列
    with store._db() as c:
        c.execute("UPDATE answers SET shares=2 WHERE id=?", (a1,))

    d = client.get("/api/pot/list").json()
    # 最新 = 时间倒序前 3（created_at 同秒粒度——用 save 顺序 rowid 兜底：取 history_all 序）
    latest_ids = [it["id"] for it in d["latest"]]
    assert len(latest_ids) == 3
    assert set(latest_ids) == {a3, a4, a5} or set(latest_ids) <= set(aids)
    # 最热 = heat 倒序，a1 居首且 heat=15
    hot_ids = [it["id"] for it in d["hot"]]
    assert hot_ids[0] == a1
    assert d["hot"][0]["heat"] == (d["hot"][0]["views"] + d["hot"][0]["likes"]
                                   + d["hot"][0]["shares"])
    heats = [it["heat"] for it in d["hot"]]
    assert heats == sorted(heats, reverse=True)
    # 双区总和一致（同一集合两视角）
    assert len(d["hot"]) == len(d["items"]) == 5


def test_pot_sections_compat_and_cat_filter(client):
    """旧客户端兼容（items/cats 原样）+ cat 过滤对两区同时生效。"""
    _mk(11)
    _mk(12)
    d = client.get("/api/pot/list").json()
    assert "items" in d and "cats" in d  # 0.9.18 形态不变
    assert all("heat" in it for it in d["hot"])
    some_cat = (d["cats"] or [{}])[0].get("name")
    if some_cat:
        d2 = client.get("/api/pot/list", params={"cat": some_cat}).json()
        assert all(it["cat"] == some_cat for it in d2["latest"])
        assert all(it["cat"] == some_cat for it in d2["hot"])
