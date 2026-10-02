# -*- coding: utf-8 -*-
"""已购检索契约单测（T-P2-03/FR-P2-03）：已购范围/付费章命中/snippet 泄漏
控制（命中句 ±40 字）/游标分页/offset 坐标/限流/下架不除权/通配注入安全。"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT, SECOND, THIRD  # noqa: E402

from xueyuan_engine import owned_search, store, virtual_pay  # noqa: E402


@pytest.fixture(autouse=True)
def _clear_limiter():
    owned_search._LIMITER._hits.clear()
    yield
    owned_search._LIMITER._hits.clear()


def _get(client, buyer, q, **kw):
    return client.get("/api/v1/search/owned", params={"q": q, **kw}, headers=buyer)


def _own(uid, rid):
    virtual_pay.grant_entitlement(uid, rid, "purchase", "order-x")


def test_requires_login(engine, client):
    assert _get(client, {}, "水网").status_code == 401


def test_empty_q_400(engine, client, buyer):
    assert _get(client, buyer, "  ").status_code == 400


def test_hits_paid_chapters_of_owned_report(engine, client, buyer):
    _own(buyer["uid"], PILOT)
    r = _get(client, buyer, "数据论证")  # 仅付费章正文含该词（trial 正文无）
    assert r.status_code == 200
    body = r.json()
    assert body["total"] > 0 and body["has_more"] is False
    item = body["items"][0]
    assert set(item) == {"report_id", "title", "chapter_id", "chapter_title",
                         "snippet", "offset"}  # 契约字段精确集
    assert item["report_id"] == PILOT
    assert int(item["chapter_id"][2:]) >= 3  # 付费章（ch03 起无试读标记）


def test_unowned_report_never_in_results(engine, client, buyer):
    _own(buyer["uid"], PILOT)  # 只拥有试点
    r = _get(client, buyer, "港口")  # SECOND 章正文含「港口」但未购
    assert r.status_code == 200
    assert all(i["report_id"] != SECOND for i in r.json()["items"])


def test_empty_library_returns_empty(engine, client, buyer):
    r = _get(client, buyer, "水网")
    assert r.status_code == 200
    assert r.json() == {"items": [], "total": 0, "next_cursor": "", "has_more": False}


def test_snippet_leak_control_paid_chapter(engine, client, buyer):
    """付费章 snippet 泄漏控制：只返回命中句 ±40 字（远处关键词不得出现）。"""
    with store._LOCK, store._db() as c:
        c.execute("INSERT INTO reports(id,title,chapter_count) VALUES('leak-r','泄漏控制',1)")
        c.execute(
            "INSERT INTO chapters(id,report_id,idx,title,is_trial,html,char_count)"
            " VALUES('leak-r/leak01','leak-r',1,'敏感章',0,?,0)",
            ("<p>锚点甲" + "填充内容" * 300 + "锚点乙</p>",),
        )
    _own(buyer["uid"], "leak-r")
    r = _get(client, buyer, "锚点甲")
    item = r.json()["items"][0]
    assert "锚点甲" in item["snippet"] and "锚点乙" not in item["snippet"]
    assert len(item["snippet"]) <= 2 * 40 + 1  # ±40 字窗口硬上限


def test_make_snippet_sentence_bounds():
    plain = "第一句。这里是命中词所在句子。第三句。"
    hit = plain.index("命中词")
    snippet, off = owned_search.make_snippet(plain, hit)
    assert snippet == "这里是命中词所在句子。" and off == hit


def test_make_snippet_long_sentence_clamp():
    plain = "甲" * 200 + "命中" + "乙" * 200
    snippet, off = owned_search.make_snippet(plain, 200)
    assert "命中" in snippet and off == 200
    assert len(snippet) <= 81  # 长句回退为 ±40 窗口


def test_cursor_pagination_stable(engine, client, buyer):
    for rid in (PILOT, SECOND, THIRD):
        _own(buyer["uid"], rid)
    total = _get(client, buyer, "数据论证").json()["total"]
    seen, cursor, pages = [], "", 0
    while True:
        body = _get(client, buyer, "数据论证", limit=3, cursor=cursor).json()
        seen += [(i["report_id"], i["chapter_id"]) for i in body["items"]]
        pages += 1
        assert pages <= 10
        if not body["next_cursor"]:
            assert body["has_more"] is False
            break
        assert body["has_more"] is True
        cursor = body["next_cursor"]
    assert len(seen) == total == len(set(seen))  # 无重复无丢失


def test_offset_is_plain_text_hit(engine, client, buyer):
    _own(buyer["uid"], PILOT)
    item = _get(client, buyer, "数据论证").json()["items"][0]
    with store._db() as c:
        html = c.execute("SELECT html FROM chapters WHERE id=?",
                         (f"{item['report_id']}/{item['chapter_id']}",)).fetchone()["html"]
    assert item["offset"] == owned_search.plain_text(html).index("数据论证")


def test_off_report_still_searchable_in_library(engine, client, buyer):
    """已购库语义：下架不除权——off 报告仍可检索自有正文。"""
    _own(buyer["uid"], PILOT)
    with store._LOCK, store._db() as c:
        c.execute("UPDATE reports SET status='off' WHERE id=?", (PILOT,))
    r = _get(client, buyer, "数据论证")
    assert r.status_code == 200 and r.json()["total"] > 0


def test_wildcard_query_injection_safe(engine, client, buyer):
    _own(buyer["uid"], PILOT)
    r = _get(client, buyer, "%%%")  # 通配符全转义为字面量：无命中不炸
    assert r.status_code == 200 and r.json()["total"] == 0


def test_rate_limit_429(engine, client, buyer):
    _own(buyer["uid"], PILOT)
    for _ in range(30):
        assert _get(client, buyer, "水网").status_code == 200
    r = _get(client, buyer, "水网")
    assert r.status_code == 429 and r.json()["code"] == "RATE_LIMITED"
