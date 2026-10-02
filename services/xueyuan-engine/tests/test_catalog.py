# -*- coding: utf-8 -*-
"""目录与详情契约单测（T-P0-05）：分页/三筛选/榜单 tab/决策卡/预览三件套。"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402


def test_catalog_lists_pilot(engine, client):
    r = client.get("/api/v1/catalog")
    assert r.status_code == 200
    body = r.json()
    ids = [it["id"] for it in body["items"]]
    assert body["total"] >= 1 and PILOT in ids          # ≥1 且含试点
    item = next(it for it in body["items"] if it["id"] == PILOT)
    assert item["price_fen"] == 990 and item["trial_chapters"] == 2
    assert set(item) >= {"province", "owner_type", "industry", "tags", "cover"}


def test_catalog_filters_single_and_combined(engine, client):
    def ids(**params):
        return {it["id"] for it in client.get("/api/v1/catalog", params=params).json()["items"]}

    assert PILOT in ids(province="江苏") and engine.second not in ids(province="江苏")
    assert ids(industry="水网工程") == {PILOT}
    assert ids(owner_type="水利") == {PILOT, engine.third}
    assert ids(province="江苏", industry="港口工程") == set()   # 组合=AND
    assert ids(province="广东", industry="港口工程") == {engine.second}


def test_catalog_pagination(engine, client):
    r = client.get("/api/v1/catalog", params={"page": 1, "page_size": 2})
    body = r.json()
    assert len(body["items"]) <= 2 and body["page_size"] == 2
    page2 = client.get("/api/v1/catalog", params={"page": 2, "page_size": 2}).json()
    assert page2["total"] == body["total"]
    ids1 = {it["id"] for it in body["items"]}
    ids2 = {it["id"] for it in page2["items"]}
    assert not (ids1 & ids2)                              # 分页不重叠


def test_catalog_tabs(engine, client):
    assert client.get("/api/v1/catalog", params={"tab": "bad"}).status_code == 400
    praise = client.get("/api/v1/catalog", params={"tab": "praise"}).json()
    assert praise["items"] == [] and praise["praise_visible"] is False
    hot = client.get("/api/v1/catalog", params={"tab": "hot"}).json()
    new = client.get("/api/v1/catalog", params={"tab": "new"}).json()
    assert {it["id"] for it in new["items"]} >= {PILOT}   # 上新序含试点
    assert {it["id"] for it in hot["items"]} >= {PILOT}   # 无阅读数据回退上新序


def test_report_detail_decision_card(engine, client):
    r = client.get(f"/api/v1/reports/{PILOT}")
    assert r.status_code == 200
    body = r.json()
    assert body["anchor_price_fen"] == 188800 and body["anchor_copy"]
    assert body["owned"] is False and body["favorited"] is False   # 游客视图
    dc = body["decision_card"]
    assert dc["remaining_chapters"] == 4 and dc["remaining_pages"] > 0
    assert dc["locked_conclusions"] and dc["locked_conclusions"][0]["blurred"] is True
    assert dc["toc"][0]["is_trial"] == 1 and dc["toc"][2]["is_trial"] == 0
    assert len(dc["toc"]) == 6
    assert body["preview_triad"]["related"][0]["why"] == "同省"    # zj 同省命中
    assert body["preview_triad"]["readers_also"] == []             # 无共读数据空数组
    assert body["refund_policy_url"].endswith("#refund")
    assert body["disclosure"] == {"no_reason_refund": False, "invoice_entry": True}


def test_report_detail_404_and_reading_rank_badge(engine, client, buyer):
    assert client.get("/api/v1/reports/no-such").status_code == 404
    assert client.get("/api/v1/reports/no-such").json()["code"] == "REPORT_NOT_FOUND"
    for _ in range(2):  # 已登录阅读→阅读榜徽章出现
        client.get(f"/api/v1/reports/{PILOT}/chapters", headers=buyer)
    body = client.get(f"/api/v1/reports/{PILOT}").json()
    assert body["preview_triad"]["rank_badge"] == "阅读榜 #1"
    hot = client.get("/api/v1/catalog", params={"tab": "hot"}).json()
    assert hot["items"][0]["id"] == PILOT                # 阅读聚合登顶
