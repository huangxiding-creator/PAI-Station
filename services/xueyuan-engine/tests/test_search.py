# -*- coding: utf-8 -*-
"""搜索契约单测（T-P0-06 LIKE 最小腿 → T-P0-19 切片② FTS5 三层降级）。

覆盖：中文分词拆词命中/L1→L2→L3 逐层触发/layer_used 标记正确/LIKE 兜底
（FTS 表缺与空索引两形态）/tags 空容错/热词聚合/off 下架过滤/增量重建。
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402

from xueyuan_engine import fts, store  # noqa: E402


def _search(client, q):
    r = client.get("/api/v1/search", params={"q": q})
    assert r.status_code == 200
    return r.json()


# ── L1：标题/摘要 FTS 命中 ──

def test_l1_chinese_tokenized_hit(engine, client):
    """「水网工程」jieba 拆词 [水网,工程] 后 OR MATCH 仍命中标题（R-10 主判据）。"""
    body = _search(client, "水网工程")
    assert body["layer_used"] == "L1"
    assert any(it["id"] == PILOT for it in body["items"])
    assert body["fallback_hint"] is False and body["layer"] is None


def test_l1_summary_and_distinct_title_hits(engine, client):
    """摘要域命中同层 L1；标题词命中报告子集正确。"""
    body = _search(client, "总包创研院")  # 三份摘要全含
    assert body["layer_used"] == "L1" and len(body["items"]) == 3
    body2 = _search(client, "港口")
    assert body2["layer_used"] == "L1"
    assert {it["id"] for it in body2["items"]} == {engine.second}


# ── L2：章节标题层（聚合报告级+命中章列表）──

def test_l2_chapter_title_layer_with_hit_chapters(engine, client):
    """标题/摘要 0 命中→L2 章节标题：聚合到报告级+hit_chapters 命中章列表。

    「第5章」拆词 [第,5,章] OR 语义——第/章 在所有章标题（三报告均命中），
    「5」仅试点第 5 章（他报告只 4 章，hit_chapters 不含 ch05）。
    """
    body = _search(client, "第5章")
    assert body["layer_used"] == "L2" and len(body["items"]) == 3
    by_id = {it["id"]: it for it in body["items"]}
    pilot_hits = [hc["id"] for hc in by_id[PILOT]["hit_chapters"]]
    assert "ch05" in pilot_hits and "第5章" in next(
        hc["title"] for hc in by_id[PILOT]["hit_chapters"] if hc["id"] == "ch05")
    assert all(hc["id"] != "ch05" for hc in by_id[engine.second]["hit_chapters"])


# ── L3：商机关键词层 ──

def test_l3_keyword_layer(engine, client):
    """L1/L2 均 0 命中→L3 商机关键词（tags+省份/业主/行业元数据）。

    「水利」仅在 owner_type（试点/第三=水利，第二=交通）——标题/摘要/章节
    标题均不含，恰为 L3 专属命中域。
    """
    body = _search(client, "水利")
    assert body["layer_used"] == "L3"
    assert {it["id"] for it in body["items"]} == {PILOT, engine.third}


# ── LIKE 兜底与 none ──

def test_like_fallback_when_fts_misses(engine, client):
    """FTS 各层 0 命中但子串跨 token 边界→LIKE 兜底：「省水」整词不在索引
    （索引 token=江苏省/水网），LIKE '%省水%' 命中「江苏省水网工程」。"""
    body = _search(client, "省水")
    assert body["layer_used"] == "like" and body["layer"] == "title"
    assert any(it["id"] == PILOT for it in body["items"])


def test_search_none_fallback_hint(engine, client):
    r = client.get("/api/v1/search", params={"q": "不存在的词xyzzy"})
    body = r.json()
    assert body["layer_used"] == "none" and body["items"] == []
    assert body["fallback_hint"] is True and body["hot_words"]  # 前端降级提示+榜单补位判据


def test_fts_missing_tables_degrade_to_like(engine, client):
    """FTS 表缺失（老库首启/建索引失败形态）→ LIKE 自愈，不炸。"""
    with store._db() as c:
        c.execute("DROP TABLE IF EXISTS reports_fts")
        c.execute("DROP TABLE IF EXISTS fts_docs")
    fts._schema_ok.clear()
    body = _search(client, "水网工程")
    assert body["layer_used"] == "like"
    assert any(it["id"] == PILOT for it in body["items"])


def test_fts_empty_index_degrade_to_like(engine, client):
    """FTS 索引空（schema 在、内容未灌）→ 逐层 0 命中自然降级 LIKE。"""
    with store._db() as c:
        c.execute("DELETE FROM reports_fts")
        c.execute("DELETE FROM fts_docs")
    body = _search(client, "水网工程")
    assert body["layer_used"] == "like"
    assert any(it["id"] == PILOT for it in body["items"])


# ── 容错与聚合 ──

def test_tags_empty_tolerated_and_hot_words(engine, client):
    """tags 空/元数据空容错：L3 keyword 无 tags 不炸；热词聚合跳过空 tag。"""
    with store._db() as c:
        c.execute("UPDATE reports SET tags='[]', province='', owner_type='', industry=''"
                  " WHERE id=?", (engine.second,))
    assert fts.rebuild_report(engine.second)
    assert set(fts.hot_words()) == {"水网", "江苏", "航运"}  # 「港口」随 tags 清空消失
    body = _search(client, "广东港口航道")  # 标题命中仍 L1（检索不依赖 tags）
    assert body["layer_used"] == "L1" and {it["id"] for it in body["items"]} == {engine.second}


def test_hot_words_frequency_ranking(engine, client):
    """tags 频次聚合排序：重复 tag 置顶（Top N=config.HOT_WORDS_TOP）。"""
    with store._db() as c:
        c.execute("UPDATE reports SET tags='[\"水网\",\"水利\"]' WHERE id=?", (engine.third,))
    assert fts.rebuild_report(engine.third)
    words = fts.hot_words()
    assert words[0] == "水网" and len(words) <= 8  # 2 次 > 其余 1 次


def test_search_filters_off_reports(engine, client):
    """下架报告不进结果（FTS 命中后回表 status 过滤——FTS 残留行也不漏）。"""
    with store._db() as c:
        c.execute("UPDATE reports SET status='off' WHERE id=?", (engine.second,))
    body = _search(client, "港口")  # 「港口」全域仅 second 命中
    assert engine.second not in {it["id"] for it in body["items"]}
    assert body["layer_used"] == "none"  # 各层命中均被 on 过滤→最终 none


def test_rebuild_report_incremental(engine, client):
    """增量重建：改标题/摘要后索引即时跟上（旧 token 回删、不残留不重复）。"""
    with store._db() as c:
        c.execute("UPDATE reports SET title='量子通信专项研究',"
                  " summary='量子通信专项研究——总包创研院出品。' WHERE id=?",
                  (engine.second,))
    assert fts.rebuild_report(engine.second)
    body = _search(client, "量子通信")
    assert body["layer_used"] == "L1" and {it["id"] for it in body["items"]} == {engine.second}
    body2 = _search(client, "港口航道")  # 标题/摘要 token 已回删→只剩章节标题命中（L2）
    assert body2["layer_used"] == "L2" and {it["id"] for it in body2["items"]} == {engine.second}


def test_search_like_wildcard_escaped(engine, client):
    """% _ 通配注入转义：token 过滤后无词→FTS 跳过，LIKE 按字面匹配不炸。"""
    r = client.get("/api/v1/search", params={"q": "%"})
    assert r.status_code == 200 and r.json()["layer_used"] == "none"


def test_search_blank_q_400(engine, client):
    assert client.get("/api/v1/search").status_code == 400
    assert client.get("/api/v1/search", params={"q": " "}).status_code == 400
