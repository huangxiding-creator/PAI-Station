# -*- coding: utf-8 -*-
"""AI 伴读契约单测（T-P2-01/FR-P2-01）：已购闸/问句校验/检索式应答引用页码/
无命中诚实说无/openai_compat 缝（未配置自拒+monkeypatch 假端点+失败降级）。
免费模型铁律：默认 provider=local 零外呼（cr bomb 锁定）。"""
from __future__ import annotations

import sys
from pathlib import Path
from types import SimpleNamespace

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402

from xueyuan_engine import ai_chat, virtual_pay  # noqa: E402


def _ask(client, h, rid, question):
    return client.post(f"/api/v1/reports/{rid}/chat", json={"question": question},
                       headers=h)


def _own(uid, rid):
    virtual_pay.grant_entitlement(uid, rid, "purchase", "order-x")


def _no_network(monkeypatch):
    def boom(*a, **kw):
        raise AssertionError("local provider 不允许任何外呼（付费 API 调用数必须=0）")
    monkeypatch.setattr(ai_chat, "cr", SimpleNamespace(post=boom))


def test_requires_login(engine, client):
    assert _ask(client, {}, PILOT, "投资规模多大").status_code == 401


def test_report_not_found(engine, client, buyer):
    assert _ask(client, buyer, "ghost", "问题").status_code == 404


def test_not_entitled_403(engine, client, buyer):
    r = _ask(client, buyer, PILOT, "数据论证在哪里")
    assert r.status_code == 403 and r.json()["code"] == "NOT_ENTITLED"


def test_question_validation(engine, client, buyer, monkeypatch):
    _own(buyer["uid"], PILOT)
    _no_network(monkeypatch)
    assert _ask(client, buyer, PILOT, "   ").status_code == 400
    assert _ask(client, buyer, PILOT, "问" * 501).status_code == 400


def test_local_answer_cites_paid_chapter_with_disclaimer(engine, client, buyer,
                                                         monkeypatch):
    _own(buyer["uid"], PILOT)
    _no_network(monkeypatch)  # 免费模型铁律：默认 provider 全程零外呼
    r = _ask(client, buyer, PILOT, "报告里数据论证的部分讲了什么")
    assert r.status_code == 200
    body = r.json()
    assert body["provider"] == "local" and body["degraded"] is False
    assert "检索式应答，待接免费模型" in body["disclaimer"]
    assert "检索式应答，待接免费模型" in body["answer"]  # 诚实标注
    cites = body["citations"]
    assert cites and all(
        {"chapter_id", "chapter_title", "page", "quote"} == set(c) for c in cites)
    assert all(int(c["chapter_id"][2:]) >= 3 for c in cites)  # 命中在付费章
    assert all(isinstance(c["page"], int) and c["page"] >= 1 for c in cites)
    assert all("数据论证" in c["quote"] for c in cites)
    assert len(cites) <= ai_chat.config.CHAT_TOP_K


def test_local_no_hit_honest_answer(engine, client, buyer, monkeypatch):
    _own(buyer["uid"], PILOT)
    _no_network(monkeypatch)
    r = _ask(client, buyer, PILOT, "量子纠缠的商业应用")
    body = r.json()
    assert "未检索到" in body["answer"] and body["citations"] == []


def test_quote_leak_window(engine, client, buyer, monkeypatch):
    """引用 quote 复用 ±40 字窗口（最小暴露面，与 owned_search 同纪律）。"""
    _own(buyer["uid"], PILOT)
    _no_network(monkeypatch)
    body = _ask(client, buyer, PILOT, "数据论证").json()
    assert all(len(c["quote"]) <= 2 * 40 + 1 for c in body["citations"])


def test_provider_default_local():
    assert ai_chat.chat_provider() == "local"


def test_openai_compat_unconfigured_raises(engine, monkeypatch):
    monkeypatch.delenv("XY_CHAT_BASE_URL", raising=False)
    monkeypatch.delenv("XY_CHAT_MODEL", raising=False)
    with pytest.raises(RuntimeError, match="XY_CHAT_"):
        ai_chat._openai_compat_chat("q", {"title": "t"}, [])


def test_openai_compat_seam_and_fallback(engine, client, buyer, monkeypatch):
    _own(buyer["uid"], PILOT)
    monkeypatch.setenv("XY_CHAT_PROVIDER", "openai_compat")
    monkeypatch.setenv("XY_CHAT_BASE_URL", "http://free-endpoint.invalid/v1")
    monkeypatch.setenv("XY_CHAT_MODEL", "free-model")
    calls: list = []

    def fake_post(url, **kw):
        calls.append(url)
        return SimpleNamespace(
            status_code=200, raise_for_status=lambda: None,
            json=lambda: {"choices": [{"message": {"content": "模型回答（免费端点）"}}]})

    monkeypatch.setattr(ai_chat, "cr", SimpleNamespace(post=fake_post))
    r = _ask(client, buyer, PILOT, "数据论证在哪里")
    body = r.json()
    assert body["provider"] == "openai_compat" and body["answer"] == "模型回答（免费端点）"
    assert body["degraded"] is False and body["disclaimer"] == ""
    assert len(calls) == 1 and "chat/completions" in calls[0]
    # 真腿故障→降级回 local 检索式（伴读下线不伤主链）
    def broken_post(url, **kw):
        raise RuntimeError("endpoint down")

    monkeypatch.setattr(ai_chat, "cr", SimpleNamespace(post=broken_post))
    r2 = _ask(client, buyer, PILOT, "数据论证在哪里")
    b2 = r2.json()
    assert b2["provider"] == "local" and b2["degraded"] is True
    assert "检索式应答，待接免费模型" in b2["disclaimer"] and b2["citations"]


def test_estimate_page_unit():
    # 前序两章各 680 字（340 字/页口径=各 2 页）；命中 ch03 偏移 350
    # → 4 前序页 + (350//340+1)=2 → 第 6 页
    chapters = [
        {"id": "r/ch01", "idx": 1, "char_count": 680},
        {"id": "r/ch02", "idx": 2, "char_count": 680},
        {"id": "r/ch03", "idx": 3, "char_count": 680},
    ]
    assert ai_chat.estimate_page(chapters, "r/ch03", 350) == 6
    # 短 id 形态（目录短形 chNN）同样可定位；首章首偏移=第 1 页
    assert ai_chat.estimate_page(chapters, "ch01", 0) == 1


def test_retrieve_segments_ranking(engine, buyer):
    _own(buyer["uid"], PILOT)
    from xueyuan_engine.catalog import chapter_rows

    chs = chapter_rows(PILOT)
    hits = ai_chat.retrieve_segments("付费正文", chs, top_k=2)
    assert 1 <= len(hits) <= 2
    assert hits[0]["chapter_id"].startswith("ch")  # 章短形 id
